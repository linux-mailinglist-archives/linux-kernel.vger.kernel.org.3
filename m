Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B184E47C997
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhLUXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:15:30 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:39672 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhLUXP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:15:29 -0500
Received: by mail-qk1-f171.google.com with SMTP id 69so606134qkd.6;
        Tue, 21 Dec 2021 15:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6ghia2oyzyiH6598CR7ywYiwIMz19YOc/inSFGIjXg=;
        b=66EvN33l/vN3KVBdNEYE2q/RnO6Fxf0ZKY1Lo+4hPWPcHDh8T6cCXsxKHqn+zuSooQ
         8JlOc1mQnZZF5CKX8YxZtQyR3mzxu2r3BnoeVPdGoqP6r7EK3SPAqsA9oVhgxvXi07CI
         uWHsmr5I+MbR97hnixV0rTNnVwRlupfrSBfQuvxYuWw+DrXVgSkhX6gZLFxOdBZzOLGj
         Vsy5GxVtJw3OMkbwzKVFxdOI9ByJQdrFfeQvMrlt/iRuu1LZ7E74jeySuBQ+Y4mBb6ZY
         EcaYpFhNbDHkgk+qvr4a3Dx3JnwX4HtHxppMwQNPY0WqqFdl653kr8aiO2yeJImOxe7u
         cpLA==
X-Gm-Message-State: AOAM531vsWc7dEOiafdCJqvOUBOJ4Ddogp/lAFRHIyEnWR2JJQnw5tLh
        LhBOMj9IzJgaDxYfYWCNmA==
X-Google-Smtp-Source: ABdhPJy/cHQS5nApZxm48O3HXciLucD7zbZaW6bVGeweLlpl2HjKP7ScYE0q99i2ucfRtMIlvzF8aQ==
X-Received: by 2002:a05:620a:2789:: with SMTP id g9mr436915qkp.295.1640128528267;
        Tue, 21 Dec 2021 15:15:28 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id o21sm288848qta.89.2021.12.21.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 15:15:27 -0800 (PST)
Received: (nullmailer pid 1696922 invoked by uid 1000);
        Tue, 21 Dec 2021 23:15:25 -0000
Date:   Tue, 21 Dec 2021 19:15:25 -0400
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: avs: qcom,cpr: Convert to DT schema
Message-ID: <YcJgDToAY/vXXekl@robh.at.kernel.org>
References: <20211221133937.173618-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221133937.173618-1-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 01:40:05PM +0000, Yassine Oudjana wrote:
> Convert qcom,cpr.txt to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
>  .../bindings/power/avs/qcom,cpr.yaml          | 161 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 162 insertions(+), 131 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml


> diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> new file mode 100644
> index 000000000000..852eb36eea93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/avs/qcom,cpr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Core Power Reduction (CPR) bindings
> +
> +maintainers:
> +  - Niklas Cassel <nks@flawful.org>
> +
> +description: |
> +  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> +  or other device. Each OPP of a device corresponds to a "corner" that has
> +  a range of valid voltages for a particular frequency. While the device is
> +  running at a particular frequency, CPR monitors dynamic factors such as
> +  temperature, etc. and suggests adjustments to the voltage to save power
> +  and meet silicon characteristic requirements.
> +
> +properties:
> +  compatible:
> +    allOf:

Don't need allOf with only 1 entry.

> +      - items:
> +          - enum:
> +              - qcom,qcs404-cpr
> +          - const: qcom,cpr
> +
> +  reg:
> +    description: Base address and size of the RBCPR register region.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Reference clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  vdd-apc-supply:
> +    description: APC regulator supply.
> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +  operating-points-v2:
> +    description: |
> +      A phandle to the OPP table containing the performance states
> +      supported by the CPR power domain.
> +
> +  acc-syscon:
> +    description: A phandle to the syscon used for writing ACC settings.
> +
> +  nvmem-cells:
> +    items:
> +      - description: Corner 1 quotient offset
> +      - description: Corner 2 quotient offset
> +      - description: Corner 3 quotient offset
> +      - description: Corner 1 initial voltage
> +      - description: Corner 2 initial voltage
> +      - description: Corner 3 initial voltage
> +      - description: Corner 1 quotient
> +      - description: Corner 2 quotient
> +      - description: Corner 3 quotient
> +      - description: Corner 1 ring oscillator
> +      - description: Corner 2 ring oscillator
> +      - description: Corner 3 ring oscillator
> +      - description: Fuse revision
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: cpr_quotient_offset1
> +      - const: cpr_quotient_offset2
> +      - const: cpr_quotient_offset3
> +      - const: cpr_init_voltage1
> +      - const: cpr_init_voltage2
> +      - const: cpr_init_voltage3
> +      - const: cpr_quotient1
> +      - const: cpr_quotient2
> +      - const: cpr_quotient3
> +      - const: cpr_ring_osc1
> +      - const: cpr_ring_osc2
> +      - const: cpr_ring_osc3
> +      - const: cpr_fuse_revision
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - vdd-apc-supply
> +  - '#power-domain-cells'
> +  - operating-points-v2
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cpr_opp_table: cpr-opp-table {
> +        compatible = "operating-points-v2-qcom-level";
> +
> +        cpr_opp1: opp1 {
> +            opp-level = <1>;
> +            qcom,opp-fuse-level = <1>;
> +        };
> +        cpr_opp2: opp2 {
> +            opp-level = <2>;
> +            qcom,opp-fuse-level = <2>;
> +        };
> +        cpr_opp3: opp3 {
> +            opp-level = <3>;
> +            qcom,opp-fuse-level = <3>;
> +        };
> +    };
> +
> +    power-controller@b018000 {
> +        compatible = "qcom,qcs404-cpr", "qcom,cpr";
> +        reg = <0x0b018000 0x1000>;
> +        interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&xo_board>;
> +        clock-names = "ref";
> +        vdd-apc-supply = <&pms405_s3>;
> +        #power-domain-cells = <0>;
> +        operating-points-v2 = <&cpr_opp_table>;
> +        acc-syscon = <&tcsr>;
> +
> +        nvmem-cells = <&cpr_efuse_quot_offset1>,
> +            <&cpr_efuse_quot_offset2>,
> +            <&cpr_efuse_quot_offset3>,
> +            <&cpr_efuse_init_voltage1>,
> +            <&cpr_efuse_init_voltage2>,
> +            <&cpr_efuse_init_voltage3>,
> +            <&cpr_efuse_quot1>,
> +            <&cpr_efuse_quot2>,
> +            <&cpr_efuse_quot3>,
> +            <&cpr_efuse_ring1>,
> +            <&cpr_efuse_ring2>,
> +            <&cpr_efuse_ring3>,
> +            <&cpr_efuse_revision>;
> +        nvmem-cell-names = "cpr_quotient_offset1",
> +            "cpr_quotient_offset2",
> +            "cpr_quotient_offset3",
> +            "cpr_init_voltage1",
> +            "cpr_init_voltage2",
> +            "cpr_init_voltage3",
> +            "cpr_quotient1",
> +            "cpr_quotient2",
> +            "cpr_quotient3",
> +            "cpr_ring_osc1",
> +            "cpr_ring_osc2",
> +            "cpr_ring_osc3",
> +            "cpr_fuse_revision";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7d86182fa6b..9ebbccb0494e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15746,7 +15746,7 @@ M:	Niklas Cassel <nks@flawful.org>
>  L:	linux-pm@vger.kernel.org
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> +F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
>  F:	drivers/soc/qcom/cpr.c
>  
>  QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
> -- 
> 2.34.1
> 
> 
> 
