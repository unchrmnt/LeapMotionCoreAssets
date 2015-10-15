﻿Shader "LeapMotion/Passthrough/Background" {
  Properties {
  }

  SubShader {
    Tags {"Queue"="Background" "IgnoreProjector"="True"}

    Cull Off
    Zwrite Off
    Blend One Zero

    Pass{
    CGPROGRAM
    #pragma multi_compile LEAP_FORMAT_IR LEAP_FORMAT_RGB
    #include "LeapCG.cginc"
    #include "UnityCG.cginc"
    
    #pragma target 3.0
    
    #pragma vertex vert
    #pragma fragment frag
    
    uniform float _LeapGlobalColorSpaceGamma;

    struct frag_in{
      float4 position : SV_POSITION;
      float4 screenPos  : TEXCOORD1;
    };

    frag_in vert(appdata_img v){
      frag_in o;
      o.position = mul(UNITY_MATRIX_MVP, v.vertex);
      o.screenPos = LeapGetWarpedScreenPosition(v.vertex);
      
      return o;
    }

    float4 frag (frag_in i) : COLOR {
      return float4(LeapColor(i.screenPos), 1);
    }

    ENDCG
    }
  } 
  Fallback off
}
