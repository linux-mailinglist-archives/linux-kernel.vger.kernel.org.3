Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558A647C6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhLUStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:49:49 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:33652 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbhLUSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:49:48 -0500
Received: by mail-qt1-f171.google.com with SMTP id n15so43661qta.0;
        Tue, 21 Dec 2021 10:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tc7KgE4R7TIeJUPDVcb1bQxRyC9vHMWeEu1iTeMSAEU=;
        b=ZWMOtvkKgFhWk4I1jx6CwKeRdatyOWTltLP3tuujA1WsrndgOsoxxpB8qYy8AvuCjp
         F0Cq3qInEWNc2w131gBc7yUozQs4ixvoyUR3tZ/HQ4f0qeMlk2dRZpuhFlqwUtKZnM/p
         LyhdmghCrvTtcvK9IqyHymwgPovMim8le17F7X/OpsNzsjwRBTixXVYYzEpEwZ4chpVD
         rNdZPdooZgDA0XjHLbfDNcbZlce1pVOsi18Q3XOlX3Ompar3wRvq+BSepjqkf2wMIVDx
         bcNtGIz74lWtYMs9YUNGJPOjHreF292J/ArAzLU/mLxhfrAVXnTI9BBLJAdd84621jd0
         Xerw==
X-Gm-Message-State: AOAM531bsNasO2Mbxx4p99UA3KaKr/cE7st2uOfhVYnAIMmOJE8EkiRW
        DeVwXz9Yq8AGhQZi38ua6sbFBPkmWkQH
X-Google-Smtp-Source: ABdhPJzCZFbAIi7Iw6KHaow+W0pn29adEINr94asi/uERGFjJPf/+XWX7T8JJ628S1p4rsK9qMjuLA==
X-Received: by 2002:a05:622a:60e:: with SMTP id z14mr3408981qta.639.1640112587278;
        Tue, 21 Dec 2021 10:49:47 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id l2sm17946697qtk.41.2021.12.21.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:49:46 -0800 (PST)
Received: (nullmailer pid 1559272 invoked by uid 1000);
        Tue, 21 Dec 2021 18:49:45 -0000
Date:   Tue, 21 Dec 2021 14:49:45 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: regulator: pwm: Convert to json-schema
Message-ID: <YcIhyWEdv1yRj46G@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
 <20211217170507.2843568-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-2-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:05:03PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the generic PWM regulator bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/pwm-regulator.txt      |  92 -------------
>  .../bindings/regulator/pwm-regulator.yaml     | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 92 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
> 

> diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
> new file mode 100644
> index 000000000000..d87e8110989d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/pwm-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic PWM Regulator
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Mark Brown <broonie@kernel.org>
> +
> +description: |
> +  Currently supports 2 modes of operation:
> +
> +    - Voltage Table: When in this mode, a voltage table (See below) of predefined voltage <=>
> +      duty-cycle values must be provided via DT. Limitations are that the regulator can only
> +      operate at the voltages supplied in the table. Intermediary duty-cycle values which would
> +      normally allow finer grained voltage selection are ignored and rendered useless. Although
> +      more control is given to the user if the assumptions made in continuous-voltage mode do not
> +      reign true.
> +
> +    - Continuous Voltage: This mode uses the regulator's maximum and minimum supplied voltages
> +      specified in the regulator-{min,max}-microvolt properties to calculate appropriate duty-cycle
> +      values. This allows for a much more fine grained solution when compared with voltage-table
> +      mode above. This solution does make an assumption that a %50 duty-cycle value will cause the
> +      regulator voltage to run at half way between the supplied max_uV and min_uV values.
> +
> +  NB: To be clear, if voltage-table is provided, then the device will be used
> +  in Voltage Table Mode.  If no voltage-table is provided, then the device will
> +  be used in Continuous Voltage Mode.
> +
> +  Any property defined as part of the core regulator binding can also be used. (See:
> +  ../regulator/regulator.txt)
> +
> +properties:
> +  compatible:
> +    const: pwm-regulator
> +
> +  pwms:
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"

Already has a type. Just need 'maxItems: 1'

> +    description: phandle and PWM specifier (see ../pwm/pwm.txt)
> +
> +  # Only required for Voltage Table Mode:
> +  voltage-table:
> +    description: Voltage and Duty-Cycle table consisting of 2 cells. The first cell is the voltage
> +      in microvolts (uV) and the second cell is duty-cycle in percent (%).
> +    $ref: "/schemas/types.yaml#/definitions/uint32-matrix"

items:
  maxItems: 2
  minItems: 2


> +
> +  # Optional properties for Continuous mode:
> +  pwm-dutycycle-unit:
> +    description: Integer value encoding the duty cycle unit. If not defined, <100> is assumed,
> +      meaning that pwm-dutycycle-range contains values expressed in percent.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  pwm-dutycycle-range:
> +    description: Should contain 2 entries. The first entry is encoding the dutycycle for
> +      regulator-min-microvolt and the second one the dutycycle for regulator-max-microvolt. Duty
> +      cycle values are expressed in pwm-dutycycle-unit. If not defined, <0 100> is assumed.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"

maxItems: 2

> +
> +  # Optional properties:
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the regulator

maxItems: 1

> +
> +  # from regulator.yaml
> +  regulator-enable-ramp-delay: true
> +  regulator-max-microvolt: true
> +  regulator-min-microvolt: true
> +  regulator-name: true
> +  regulator-ramp-delay: true
> +  regulator-settling-time-us: true

Given the other properties still missing, probably better to drop all 
these and use unevaluatedProperties.

> +  vin-supply: true
> +
> +allOf:
> +  - $ref: "regulator.yaml"
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - pwms
> +
> +examples:
> +  # Continuous Voltage With Enable GPIO:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pwm_regulator {
> +        compatible = "pwm-regulator";
> +        pwms = <&pwm1 0 8448 0>;
> +        enable-gpios = <&gpio0 23 GPIO_ACTIVE_HIGH>;
> +        regulator-min-microvolt = <1016000>;
> +        regulator-max-microvolt = <1114000>;
> +        regulator-name = "vdd_logic";
> +        /* unit == per-mille */
> +        pwm-dutycycle-unit = <1000>;
> +        /*
> +         * Inverted PWM logic, and the duty cycle range is limited
> +         * to 30%-70%.
> +         */
> +        pwm-dutycycle-range = <700 300>; /* */
> +    };
> +
> +  # Voltage Table:
> +  - |
> +    regulator {
> +        compatible = "pwm-regulator";
> +        pwms = <&pwm1 0 8448 0>;
> +        regulator-min-microvolt = <1016000>;
> +        regulator-max-microvolt = <1114000>;
> +        regulator-name = "vdd_logic";
> +
> +        /* Voltage Duty-Cycle */
> +        voltage-table = <1114000 0>,
> +                        <1095000 10>,
> +                        <1076000 20>,
> +                        <1056000 30>,
> +                        <1036000 40>,
> +                        <1016000 50>;
> +    };
> -- 
> 2.34.1
> 
> 
