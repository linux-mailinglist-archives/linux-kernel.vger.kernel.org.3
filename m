Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A429246C6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbhLGVhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:37:07 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36471 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhLGVhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:37:06 -0500
Received: by mail-oi1-f179.google.com with SMTP id t23so1110338oiw.3;
        Tue, 07 Dec 2021 13:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTTas1/ToPeZuNmkXpJX6xNDV6v1yWEA0grwjHIblIE=;
        b=S8+9dxcatcyselceFjNeuDUDv8VbyzqE39FY1hRXJq4L0z5FDDXXm8YWSo6p9kgctO
         i0vFn9DJ3nHcaM6rIHbZJrZOAc4EtzYVhSTKOAiE9JyH6O+sFQaDdzF8lzNBk1YGe3O3
         rICZMmTzrYSh6g7aN0d2zqDLMTdKRdoHWJVLLTKP4JyQSgbyDEep5Jnc0rDgW+XbXXQf
         OCqzE2x9CsMdc3y2pGUCcrPEqJMUfnOMauRPtgvFVHFusVwV1N43Ky7cuMeQwvhT6126
         VmiAC3hNK/QiClPOyoc0FwQM8ldLmfECosYOzZ+aBvjg9o1hYSC9oT+7i5nsSM6pJj4t
         6BEg==
X-Gm-Message-State: AOAM531tIdgLrsKPMRNeS3bw2YLbprnVeJ27gOmnbFqyRpR2gmeEqdNn
        QauZiQeLOI0W5fxDmI19HQ==
X-Google-Smtp-Source: ABdhPJzUwLIDjtr3+gOUiMc45We2JJT6KVAgNVPbbi6Mqugux3LpaJ6PrP/7yv0n/dJ8DECNG6/Pgw==
X-Received: by 2002:aca:b387:: with SMTP id c129mr7736848oif.6.1638912815567;
        Tue, 07 Dec 2021 13:33:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h6sm139933otb.60.2021.12.07.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:33:34 -0800 (PST)
Received: (nullmailer pid 871914 invoked by uid 1000);
        Tue, 07 Dec 2021 21:33:34 -0000
Date:   Tue, 7 Dec 2021 15:33:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        ekangupt@qti.qualcomm.com, jeyr@codeaurora.org,
        bkumar@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: misc: fastrpc convert bindings to yaml
Message-ID: <Ya/TLjuChN2VjZLk@robh.at.kernel.org>
References: <20211130092846.18804-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130092846.18804-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:28:46AM +0000, Srinivas Kandagatla wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> Changes since v2:
>  fixed typo in pil compatible string 
>  added required properties for pil example node
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt |  78 -------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 104 ++++++++++++++++++
>  2 files changed, 104 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> new file mode 100644
> index 000000000000..1840db08500c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Technologies, Inc. FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes Qualcomm FastRPC an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries. This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks.
> +
> +properties:
> +  compatible:
> +    const: qcom,fastrpc
> +
> +  label:
> +    enum:
> +      - adsp
> +      - mdsp
> +      - sdsp
> +      - cdsp
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^cb@[0-9a-f]$":
> +    type: object
> +    description: |
> +      Compute context bank
> +
> +    properties:
> +      compatible:
> +        const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +        description: Context Bank ID
> +
> +      qcom,nsessions:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: How many sessions can share this context bank.
> +                     Defaults to 1 when this property is not specified.

default: 1

Is there a maximum? Or 2^32 is good?

> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - label
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adsp {
> +        compatible = "qcom,msm8996-adsp-pil";
> +        interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
> +        clocks = <&xo_board>;
> +        clock-names = "xo";
> +        memory-region = <&adsp_region>;
> +        qcom,smem-states = <&smp2p_adsp_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        smd-edge {
> +            label = "lpass";
> +
> +            fastrpc {
> +                compatible = "qcom,fastrpc";
> +                label = "adsp";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                cb@1 {
> +                    compatible = "qcom,fastrpc-compute-cb";
> +                    reg = <1>;
> +                };
> +
> +                cb@2 {
> +                    compatible = "qcom,fastrpc-compute-cb";
> +                    reg = <2>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.21.0
> 
> 
