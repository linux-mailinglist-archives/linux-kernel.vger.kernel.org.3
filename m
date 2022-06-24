Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6861A558C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiFXBBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFXBBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:01:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71C51337;
        Thu, 23 Jun 2022 18:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656032465; x=1687568465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cu3gs3fP0Lb/Tmh6S3V8jqns1LEH+E+/NnZiIgmAzA0=;
  b=Czp2CkWrUMvrXPUydAHPutOoNqIXwMfsPsUGX5kC5yMpMmzxgPopgxIq
   76M18/eHWC5spzCh6y9XKkM3wfy5xet0UaHH1FyfVQsfEV1+HPn9RtccF
   n7rk3/IN7zQD2sofvWmeVxKZrFj5dNrmWZ+yokuXI5nBdBsrbfna5rj6b
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Jun 2022 18:01:05 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 18:01:05 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 18:01:04 -0700
Date:   Thu, 23 Jun 2022 18:01:03 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
Message-ID: <20220624010103.GA23758@quicinc.com>
References: <20220623182542.1116677-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220623182542.1116677-1-robimarko@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:25:42PM +0200, Robert Marko wrote:
> Convert bindings for Qualcomm SCM to dtschema.
> 
> SoC compatibles that were used, but not documented were added.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../devicetree/bindings/firmware/qcom,scm.txt |  57 --------
>  .../bindings/firmware/qcom,scm.yaml           | 124 ++++++++++++++++++
>  2 files changed, 124 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> deleted file mode 100644
> index 0f4e5ab26477..000000000000
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -QCOM Secure Channel Manager (SCM)
> -
> -Qualcomm processors include an interface to communicate to the secure firmware.
> -This interface allows for clients to request different types of actions.  These
> -can include CPU power up/down, HDCP requests, loading of firmware, and other
> -assorted actions.
> -
> -Required properties:
> -- compatible: must contain one of the following:
> - * "qcom,scm-apq8064"
> - * "qcom,scm-apq8084"
> - * "qcom,scm-ipq4019"
> - * "qcom,scm-ipq806x"
> - * "qcom,scm-ipq8074"
> - * "qcom,scm-mdm9607"
> - * "qcom,scm-msm8226"
> - * "qcom,scm-msm8660"
> - * "qcom,scm-msm8916"
> - * "qcom,scm-msm8953"
> - * "qcom,scm-msm8960"
> - * "qcom,scm-msm8974"
> - * "qcom,scm-msm8976"
> - * "qcom,scm-msm8994"
> - * "qcom,scm-msm8996"
> - * "qcom,scm-msm8998"
> - * "qcom,scm-sc7180"
> - * "qcom,scm-sc7280"
> - * "qcom,scm-sdm845"
> - * "qcom,scm-sdx55"
> - * "qcom,scm-sm6350"
> - * "qcom,scm-sm8150"
> - * "qcom,scm-sm8250"
> - * "qcom,scm-sm8350"
> - * "qcom,scm-sm8450"
> - and:
> - * "qcom,scm"
> -- clocks: Specifies clocks needed by the SCM interface, if any:
> - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
> -   "qcom,scm-msm8960"
> - * core, iface and bus clocks required for "qcom,scm-apq8084",
> -   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
> -- clock-names: Must contain "core" for the core clock, "iface" for the interface
> -  clock and "bus" for the bus clock per the requirements of the compatible.
> -- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> -		   download mode control register (optional)
> -
> -Example for MSM8916:
> -
> -	firmware {
> -		scm {
> -			compatible = "qcom,msm8916", "qcom,scm";
> -			clocks = <&gcc GCC_CRYPTO_CLK> ,
> -				 <&gcc GCC_CRYPTO_AXI_CLK>,
> -				 <&gcc GCC_CRYPTO_AHB_CLK>;
> -			clock-names = "core", "bus", "iface";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> new file mode 100644
> index 000000000000..7dd7beb39846
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qcom,scm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Secure Channel Manager (SCM) bindings
> +
> +maintainers:
> +  - Robert Marko <robimarko@gmail.com>

I'd like to volunteer my name as well, if that's okay:

Guru Das Srinagesh <quic_gurus@quicinc.com>

> +
> +description: |
...
> +
> +  '#reset-cells':
> +    const: 1

This isn't part of the original file - could you please explain why this is
being added?

> +
> +  qcom,dload-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle to the TCSR hardware block and offset of the download mode control register
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8064
> +              - qcom,scm-msm8660
> +              - qcom,scm-msm8960
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SCM core clock
> +        clock-names:
> +          items:
> +            - const: core
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8084
> +              - qcom,scm-mdm9607
> +              - qcom,scm-msm8916
> +              - qcom,scm-msm8953
> +              - qcom,scm-msm8974
> +              - qcom,scm-msm8976
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: SCM core clock
> +            - description: SCM bus clock
> +            - description: SCM interface clock
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: iface

Thanks, I had this YAML conversion patch done locally, but couldn't figure out
how to represent the above logic in YAML. Thank you for this patch.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +    firmware {
> +      scm {
> +        compatible = "qcom,scm-msm8916", "qcom,scm";
> +
> +        clocks = <&gcc GCC_CRYPTO_CLK>,
> +                 <&gcc GCC_CRYPTO_AXI_CLK>,
> +                 <&gcc GCC_CRYPTO_AHB_CLK>;
> +        clock-names = "core", "bus", "iface";
> +        qcom,dload-mode = <&tcsr 0x6100>;
> +      };
> +    };
> -- 
> 2.36.1
> 
