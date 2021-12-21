Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22847C722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbhLUS7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:59:04 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:41657 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbhLUS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:59:03 -0500
Received: by mail-qv1-f53.google.com with SMTP id h5so124561qvh.8;
        Tue, 21 Dec 2021 10:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JJe1fEFE8UI3bYHQhe6nBFz5yxD7c9UK1xUm//GlgMo=;
        b=RAifsAzuzfb/aSGJfQTha3FghS0PVLPIgGg2/PgcAcvqA7pVN3dvjTzG7gkcyMO9F6
         G2qwy7Q/Sqlft9fT1Ms8rBgG1kOWXd0SE7dXU/ZqdJNao//QmQTNRBETziVwjZwYYBta
         ORoT265AP/Xo2dVicbTdGSUgAAUPnpOF3jKrshVqKQPxgZXB8bWqUb3a6WIr8PQHegZE
         niPV4Qq+EYDeORsp7cWlcS1x5FoxPej6Vult0yAPKVsYsP2Qbe/9gQp3Wn+adKfvfb3M
         pLIYlksQbqoa/Uq552IkkhoPbGAu6zCczWNFnkgOyeaurthp1VPQ15Riwwl6JUON54Sj
         cZwQ==
X-Gm-Message-State: AOAM530mZVIFAocxNwEkSzSFHwvK8fNeGCgriac/VQqb/zgJeEr/IqYZ
        GFny5OU7RzKvouM8E90/JA==
X-Google-Smtp-Source: ABdhPJzCAWlVpJboeU7wwyqyKWwxRX+Lt7MG7tyzzgvYRamWzsYIqNNK0F8u6bXTCPgs3yarPUmF9A==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr3696666qvp.90.1640113142451;
        Tue, 21 Dec 2021 10:59:02 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id q22sm13398517qki.46.2021.12.21.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:59:02 -0800 (PST)
Received: (nullmailer pid 1571411 invoked by uid 1000);
        Tue, 21 Dec 2021 18:59:00 -0000
Date:   Tue, 21 Dec 2021 14:59:00 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: regulator: tps6586x: Convert to
 json-schema
Message-ID: <YcIj9FMp/ba0gH3t@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
 <20211217170507.2843568-5-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-5-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:05:06PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments TPS6586x bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/regulator/ti,tps6586x.yaml       | 184 ++++++++++++++++++
>  .../bindings/regulator/tps6586x.txt           | 135 -------------
>  2 files changed, 184 insertions(+), 135 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/tps6586x.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
> new file mode 100644
> index 000000000000..c5ea7012c653
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps6586x.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/ti,tps6586x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TPS6586x family of voltage regulator
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: ti,tps6586x
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sys-supply:
> +    description: input supply for SYS
> +
> +  vin-sm0-supply:
> +    description: input supply for SM0
> +
> +  vin-sm1-supply:
> +    description: input supply for SM1
> +
> +  vin-sm2-supply:
> +    description: input supply for SM2
> +
> +  vinldo01-supply:
> +    description: input supply for LDO0 and LDO1
> +
> +  vinldo23-supply:
> +    description: input supply for LDO2 and LDO3
> +
> +  vinldo4-supply:
> +    description: input supply for LDO4
> +
> +  vinldo678-supply:
> +    description: input supply for LDO6, LDO7 and LDO8
> +
> +  vinldo9-supply:
> +    description: input supply for LDO9
> +
> +  ti,system-power-controller:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: If this property exists, it specifies that this PMIC controls the system power.
> +
> +  regulators:
> +    type: object
> +    description: |
> +      A node that houses a sub-node for each regulator within the device. Each sub-node is
> +      identified using the node's name (or the deprecated regulator-compatible property if
> +      present), with valid values listed below. The content of each sub-node is defined by the
> +      standard binding for regulators; see regulator.yaml.
> +
> +      Note: LDO5 and LDO_RTC is supplied by SYS regulator internally and the operating system
> +        needs to take care of establishing the proper parent child relationships.
> +
> +    patternProperties:
> +      "^sys|sm[0-2]|ldo[0-9]|ldo_rtc$":
> +        $ref: regulator.yaml
> +
> +allOf:
> +  - $ref: /schemas/gpio/gpio.yaml

You need to define #gpio-cells value. Usually we don't reference 
gpio.yaml because of that and it's just 'gpio-controller' in addition.

> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@34 {
> +        compatible = "ti,tps6586x";
> +        reg = <0x34>;
> +        interrupts = <0 88 0x4>;
> +
> +        #gpio-cells = <2>;
> +        gpio-controller;
> +
> +        ti,system-power-controller;
> +
> +        sys-supply = <&dummy>;
> +        vin-sm0-supply = <&dummy>;
> +        vin-sm1-supply = <&dummy>;
> +        vin-sm2-supply = <&dummy>;
> +        vinldo01-supply = <&dummy>;
> +        vinldo23-supply = <&dummy>;
> +        vinldo4-supply = <&dummy>;
> +        vinldo678-supply = <&dummy>;
> +        vinldo9-supply = <&dummy>;
> +
> +        regulators {
> +          sys {
> +            regulator-name = "vdd_sys";
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +
> +          sm0 {
> +            regulator-min-microvolt = < 725000>;
> +            regulator-max-microvolt = <1500000>;
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +
> +          sm1 {
> +            regulator-min-microvolt = < 725000>;
> +            regulator-max-microvolt = <1500000>;
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +
> +          sm2 {
> +            regulator-min-microvolt = <3000000>;
> +            regulator-max-microvolt = <4550000>;
> +            regulator-boot-on;
> +            regulator-always-on;
> +          };
> +
> +          ldo0 {
> +            regulator-name = "PCIE CLK";
> +            regulator-min-microvolt = <3300000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo1 {
> +            regulator-min-microvolt = < 725000>;
> +            regulator-max-microvolt = <1500000>;
> +          };
> +
> +          ldo2 {
> +            regulator-min-microvolt = < 725000>;
> +            regulator-max-microvolt = <1500000>;
> +          };
> +
> +          ldo3 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo4 {
> +            regulator-min-microvolt = <1700000>;
> +            regulator-max-microvolt = <2475000>;
> +          };
> +
> +          ldo5 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo6 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo7 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo8 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +
> +          ldo9 {
> +            regulator-min-microvolt = <1250000>;
> +            regulator-max-microvolt = <3300000>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/tps6586x.txt b/Documentation/devicetree/bindings/regulator/tps6586x.txt
> deleted file mode 100644
> index 8b40cac24d93..000000000000
> --- a/Documentation/devicetree/bindings/regulator/tps6586x.txt
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -TPS6586x family of regulators
> -
> -Required properties:
> -- compatible: "ti,tps6586x"
> -- reg: I2C slave address
> -- interrupts: the interrupt outputs of the controller
> -- #gpio-cells: number of cells to describe a GPIO
> -- gpio-controller: mark the device as a GPIO controller
> -- regulators: A node that houses a sub-node for each regulator within the
> -  device. Each sub-node is identified using the node's name (or the deprecated
> -  regulator-compatible property if present), with valid values listed below.
> -  The content of each sub-node is defined by the standard binding for
> -  regulators; see regulator.txt.
> -  sys, sm[0-2], ldo[0-9] and ldo_rtc
> -- sys-supply: The input supply for SYS.
> -- vin-sm0-supply: The input supply for the SM0.
> -- vin-sm1-supply: The input supply for the SM1.
> -- vin-sm2-supply: The input supply for the SM2.
> -- vinldo01-supply: The input supply for the LDO1 and LDO2
> -- vinldo23-supply: The input supply for the LDO2 and LDO3
> -- vinldo4-supply: The input supply for the LDO4
> -- vinldo678-supply: The input supply for the LDO6, LDO7 and LDO8
> -- vinldo9-supply: The input supply for the LDO9
> -
> -Optional properties:
> -- ti,system-power-controller: Telling whether or not this pmic is controlling
> -  the system power.
> -
> -Each regulator is defined using the standard binding for regulators.
> -
> -Note: LDO5 and LDO_RTC is supplied by SYS regulator internally and driver
> -      take care of making proper parent child relationship.
> -
> -Example:
> -
> -	pmu: tps6586x@34 {
> -		compatible = "ti,tps6586x";
> -		reg = <0x34>;
> -		interrupts = <0 88 0x4>;
> -
> -		#gpio-cells = <2>;
> -		gpio-controller;
> -
> -		ti,system-power-controller;
> -
> -		sys-supply = <&some_reg>;
> -		vin-sm0-supply = <&some_reg>;
> -		vin-sm1-supply = <&some_reg>;
> -		vin-sm2-supply = <&some_reg>;
> -		vinldo01-supply = <...>;
> -		vinldo23-supply = <...>;
> -		vinldo4-supply = <...>;
> -		vinldo678-supply = <...>;
> -		vinldo9-supply = <...>;
> -
> -		regulators {
> -			sys_reg: sys {
> -				regulator-name = "vdd_sys";
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sm0_reg: sm0 {
> -				regulator-min-microvolt = < 725000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sm1_reg: sm1 {
> -				regulator-min-microvolt = < 725000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			sm2_reg: sm2 {
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <4550000>;
> -				regulator-boot-on;
> -				regulator-always-on;
> -			};
> -
> -			ldo0_reg: ldo0 {
> -				regulator-name = "PCIE CLK";
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo1_reg: ldo1 {
> -				regulator-min-microvolt = < 725000>;
> -				regulator-max-microvolt = <1500000>;
> -			};
> -
> -			ldo2_reg: ldo2 {
> -				regulator-min-microvolt = < 725000>;
> -				regulator-max-microvolt = <1500000>;
> -			};
> -
> -			ldo3_reg: ldo3 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo4_reg: ldo4 {
> -				regulator-min-microvolt = <1700000>;
> -				regulator-max-microvolt = <2475000>;
> -			};
> -
> -			ldo5_reg: ldo5 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo6_reg: ldo6 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo7_reg: ldo7 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo8_reg: ldo8 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -
> -			ldo9_reg: ldo9 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3300000>;
> -			};
> -		};
> -	};
> -- 
> 2.34.1
> 
> 
