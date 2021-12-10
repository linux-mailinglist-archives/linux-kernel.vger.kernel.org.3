Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEE470CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbhLJVjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:39:25 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:34645 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhLJVjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:39:24 -0500
Received: by mail-ot1-f48.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso10973635otj.1;
        Fri, 10 Dec 2021 13:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJVyF7s6ECy3EHwytwu/7flgT8YPUQlyliudo6ukmR8=;
        b=sJvo0+1gmc5R2RNZdQbVBdDTZ4v4vvKYMfH7sGOBqVdZ6pRaaFIrFA/eNMVZoi9KuF
         fGQx2xcn1mQj5BxGoZd9Uburv7e8Et7xMcGoyzLFpHL+Kjxu0CQjqTJcZglnLo1RWLC9
         crj0rE7gb9FMsPiMTe1FGiQ3FUC6C1BD2mzmCTDROr7s9TsHc/lImuAQeww5aFPtahHm
         kVJcNG+9Ob4f1fXp0GL8S5pM70kSnsINkdufzQJYZH4tqVhb/QubFGcPUIy8KycIFHNB
         UZqCFNmn13lcdxWewFKvq+dYNndWhyLpMqexUC4i1gtwycw8Fx/vFwZ3zgdV1N+MvZ/D
         JMmQ==
X-Gm-Message-State: AOAM532jyaGX/XB/kHXuAi95uYfOWGFlZX2zQsp5W5xwT9HSTLacVzkr
        4RpCRzpc0FnXkDoV676WKA==
X-Google-Smtp-Source: ABdhPJxjseeNkPoE8Vi8WRUoOqTWYMs4kNbUNMYM4M1qsOrJfP7X1y9DeQnwtjyBknNvo3oCAq08nQ==
X-Received: by 2002:a9d:4543:: with SMTP id p3mr13129056oti.99.1639172148980;
        Fri, 10 Dec 2021 13:35:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bi20sm1076938oib.29.2021.12.10.13.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 13:35:48 -0800 (PST)
Received: (nullmailer pid 1967534 invoked by uid 1000);
        Fri, 10 Dec 2021 21:35:47 -0000
Date:   Fri, 10 Dec 2021 15:35:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: misc: fastrpc convert bindings to yaml
Message-ID: <YbPIM9OXyuU5hfHY@robh.at.kernel.org>
References: <20211208101508.24582-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208101508.24582-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:15:08AM +0100, David Heidelberg wrote:
> Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
> dt-entries correctly and any future additions can go into yaml format.
> 
> Also:
>  - simplify example
>  - embrace compute-cb@ subnodes instead of just cb@
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  v4:
>  - combined mine and Srinivas versions of the patch
>  - previously found issues should be fixed
> 
>  .../devicetree/bindings/misc/qcom,fastrpc.txt | 78 ---------------
>  .../bindings/misc/qcom,fastrpc.yaml           | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 78 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> deleted file mode 100644
> index 2a1827ab50d2..000000000000
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -Qualcomm Technologies, Inc. FastRPC Driver
> -
> -The FastRPC implements an IPC (Inter-Processor Communication)
> -mechanism that allows for clients to transparently make remote method
> -invocations across DSP and APPS boundaries. This enables developers
> -to offload tasks to the DSP and free up the application processor for
> -other tasks.
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc"
> -
> -- label
> -	Usage: required
> -	Value type: <string>
> -	Definition: should specify the dsp domain name this fastrpc
> -	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
> -
> -- #address-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 1
> -
> -- #size-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 0
> -
> -= COMPUTE BANKS
> -Each subnode of the Fastrpc represents compute context banks available
> -on the dsp.
> -- All Compute context banks MUST contain the following properties:
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,fastrpc-compute-cb"
> -
> -- reg
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Context Bank ID.
> -
> -- qcom,nsessions:
> -	Usage: Optional
> -	Value type: <u32>
> -	Defination: A value indicating how many sessions can share this
> -		    context bank. Defaults to 1 when this property
> -		    is not specified.
> -
> -Example:
> -
> -adsp-pil {
> -	compatible = "qcom,msm8996-adsp-pil";
> -	...
> -	smd-edge {
> -		label = "lpass";
> -		fastrpc {
> -			compatible = "qcom,fastrpc";
> -			qcom,smd-channels = "fastrpcsmd-apps-dsp";
> -			label = "adsp";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			cb@1 {
> -				compatible = "qcom,fastrpc-compute-cb";
> -				reg = <1>;
> -			};
> -
> -			cb@2 {
> -				compatible = "qcom,fastrpc-compute-cb";
> -				reg = <2>;
> -			};
> -			...
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> new file mode 100644
> index 000000000000..f42ab208a7fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm FastRPC Driver
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  The FastRPC implements an IPC (Inter-Processor Communication)
> +  mechanism that allows for clients to transparently make remote method
> +  invocations across DSP and APPS boundaries. This enables developers
> +  to offload tasks to the DSP and free up the application processor for
> +  other tasks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,fastrpc
> +
> +  label:
> +    items:
> +      enum:
> +        - adsp
> +        - mdsp
> +        - sdsp
> +        - cdsp
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "(compute-)?cb@[0-9]$":
> +    type: object
> +
> +    description: >
> +      Each subnode of the Fastrpc represents compute context banks available on the dsp.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,fastrpc-compute-cb
> +
> +      reg:
> +        maxItems: 1
> +
> +      qcom,nsession:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 1
> +        description: >
> +          A value indicating how many sessions can share this context bank.
> +
> +    required:
> +      - compatible
> +      - reg
> +
> +    additionalProperties: true

Why? What other properties are present.

> +
> +required:
> +  - compatible
> +  - label
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: true

Why? What other properties are present. This is generally never correct.

Rob

