Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3393348BD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiALCZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:25:19 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38454 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiALCZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:25:18 -0500
Received: by mail-oi1-f170.google.com with SMTP id g205so1605188oif.5;
        Tue, 11 Jan 2022 18:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=llwb2H8HSHeg6jRR6oNprJOTRNjfZ9WvMbBDpFuM5Rg=;
        b=GmFt/W8yhlSS47vidpld8FS5NyidbSERKpvH1UllxPScwiMEgl5DO6Xipq2OlE66vo
         gnfWqOqj3JZ1ZvpsGG7BP30VmxGG+I8nllm7m2MyRYdwwlr/WJte51Jo/FdzAD1qE9ci
         ECMJGqfiQ8RWjQNI5JGvf0coQaCJjdFxchqOYL5GGyi1hZEFyr3PwWNZ4s+dGuRxuyrn
         QDFnDv+rKyasYBsEpjmRVnGTmTAsRvRts1hTgzzzfZ5hl3eG2neF2M3Egi5vVBkhOhSh
         LQqTAUz3H8wTW/hXiVKR4YEu3RjNqhgVbi8129KLawydYhzs8wHOHYyBehWYColbVgF/
         iTJA==
X-Gm-Message-State: AOAM533so6nQfit51JgFZzjaaI2Bk/zWfhPUE4APlvz+cqS8EXJkEBso
        nODBtWRb36DXMgOYf7zCTg==
X-Google-Smtp-Source: ABdhPJy2nlg9zamK7JojNNLBrl6nPvpxc1QWG+h+BDkBimkyKlKgmz2arQconqtCRlBTuVHnenH6fw==
X-Received: by 2002:a54:4402:: with SMTP id k2mr3669609oiw.1.1641954317752;
        Tue, 11 Jan 2022 18:25:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f9sm2364869oto.56.2022.01.11.18.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:25:16 -0800 (PST)
Received: (nullmailer pid 3949473 invoked by uid 1000);
        Wed, 12 Jan 2022 02:25:15 -0000
Date:   Tue, 11 Jan 2022 20:25:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 2/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <Yd48C4pRH7tQz++f@robh.at.kernel.org>
References: <20220111101338.58630-1-krzysztof.kozlowski@canonical.com>
 <20220111101338.58630-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111101338.58630-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:13:36AM +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../spi/samsung,spi-peripheral-props.yaml     |  35 ++++
>  .../devicetree/bindings/spi/samsung,spi.yaml  | 198 ++++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 -----------
>  MAINTAINERS                                   |   2 +-
>  5 files changed, 235 insertions(+), 123 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> new file mode 100644
> index 000000000000..aa5a1f48494b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/samsung,spi-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral-specific properties for Samsung S3C/S5P/Exynos SoC SPI controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description:
> +  See spi-peripheral-props.yaml for more info.
> +
> +properties:
> +  controller-data:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      samsung,spi-feedback-delay:
> +        description: |
> +          The sampling phase shift to be applied on the miso line (to account
> +          for any lag in the miso line). Valid values:
> +           - 0: No phase shift.
> +           - 1: 90 degree phase shift sampling.
> +           - 2: 180 degree phase shift sampling.
> +           - 3: 270 degree phase shift sampling.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3]
> +
> +    required:
> +      - samsung,spi-feedback-delay
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> new file mode 100644
> index 000000000000..da4533feb946
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/samsung,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S3C/S5P/Exynos SoC SPI controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description:
> +  All the SPI controller nodes should be represented in the aliases node using
> +  the following format 'spi{n}' where n is a unique number for the alias.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - samsung,s3c2443-spi # for S3C2443, S3C2416 and S3C2450
> +          - samsung,s3c6410-spi
> +          - samsung,s5pv210-spi # for S5PV210 and S5PC110
> +          - samsung,exynos5433-spi
> +      - const: samsung,exynos7-spi
> +        deprecated: true
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +  cs-gpios: true
> +
> +  dmas:
> +    minItems: 2
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  no-cs-readback:
> +    description:
> +      The CS line is disconnected, therefore the device should not operate
> +      based on CS signalling.
> +    type: boolean
> +
> +  num-cs:
> +    minimum: 1
> +    maximum: 4
> +    default: 1
> +
> +  samsung,spi-src-clk:
> +    description:
> +      If the spi controller includes a internal clock mux to select the clock
> +      source for the spi bus clock, this property can be used to indicate the
> +      clock to be used for driving the spi bus clock. If not specified, the
> +      clock number 0 is used as default.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    allOf:
> +      - $ref: spi-peripheral-props.yaml
> +
> +    required:
> +      - controller-data
> +
> +    unevaluatedProperties: false

This is wrong because the child nodes will certainly have device 
specific properties.

The whole child node schema can be dropped.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - interrupts
> +  - reg
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos5433-spi
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: spi
> +            - enum:
> +                - spi_busclk0
> +                - spi_busclk1
> +                - spi_busclk2
> +                - spi_busclk3
> +            - const: spi_ioclk
> +    else:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: spi
> +            - enum:
> +                - spi_busclk0
> +                - spi_busclk1
> +                - spi_busclk2
> +                - spi_busclk3
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos5433.h>
> +    #include <dt-bindings/clock/samsung,s2mps11.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi@14d30000 {
> +        compatible = "samsung,exynos5433-spi";
> +        reg = <0x14d30000 0x100>;
> +        interrupts = <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&pdma0 11>, <&pdma0 10>;
> +        dma-names = "tx", "rx";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&cmu_peric CLK_PCLK_SPI1>,
> +                 <&cmu_peric CLK_SCLK_SPI1>,
> +                 <&cmu_peric CLK_SCLK_IOCLK_SPI1>;
> +        clock-names = "spi",
> +                      "spi_busclk0",
> +                      "spi_ioclk";
> +        samsung,spi-src-clk = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&spi1_bus>;
> +        num-cs = <1>;
> +
> +        cs-gpios = <&gpd6 3 GPIO_ACTIVE_HIGH>;
> +
> +        audio-codec@0 {
> +            compatible = "wlf,wm5110";
> +            reg = <0x0>;
> +            spi-max-frequency = <20000000>;
> +            interrupt-parent = <&gpa0>;
> +            interrupts = <4 IRQ_TYPE_NONE>;
> +            clocks = <&pmu_system_controller 0>,
> +                     <&s2mps13_osc S2MPS11_CLK_BT>;
> +            clock-names = "mclk1", "mclk2";
> +
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            wlf,micd-detect-debounce = <300>;
> +            wlf,micd-bias-start-time = <0x1>;
> +            wlf,micd-rate = <0x7>;
> +            wlf,micd-dbtime = <0x2>;
> +            wlf,micd-force-micbias;
> +            wlf,micd-configs = <0x0 1 0>;
> +            wlf,hpdet-channel = <1>;
> +            wlf,gpsw = <0x1>;
> +            wlf,inmode = <2 0 2 0>;
> +
> +            wlf,reset = <&gpc0 7 GPIO_ACTIVE_HIGH>;
> +            wlf,ldoena = <&gpf0 0 GPIO_ACTIVE_HIGH>;
> +
> +            /* core supplies */
> +            AVDD-supply = <&ldo18_reg>;
> +            DBVDD1-supply = <&ldo18_reg>;
> +            CPVDD-supply = <&ldo18_reg>;
> +            DBVDD2-supply = <&ldo18_reg>;
> +            DBVDD3-supply = <&ldo18_reg>;
> +            SPKVDDL-supply = <&ldo18_reg>;
> +            SPKVDDR-supply = <&ldo18_reg>;
> +
> +            controller-data {
> +                samsung,spi-feedback-delay = <0>;
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5dd209206e88..df885eeb144f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -85,5 +85,6 @@ properties:
>  # The controller specific properties go here.
>  allOf:
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> +  - $ref: samsung,spi-peripheral-props.yaml#
>  
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
> deleted file mode 100644
> index 49028a4f5df1..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -* Samsung SPI Controller
> -
> -The Samsung SPI controller is used to interface with various devices such as flash
> -and display controllers using the SPI communication interface.
> -
> -Required SoC Specific Properties:
> -
> -- compatible: should be one of the following.
> -    - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
> -    - samsung,s3c6410-spi: for s3c6410 platforms
> -    - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
> -    - samsung,exynos5433-spi: for exynos5433 compatible controllers
> -    - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
> -
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -
> -- interrupts: The interrupt number to the cpu. The interrupt specifier format
> -  depends on the interrupt controller.
> -
> -- dmas : Two or more DMA channel specifiers following the convention outlined
> -  in bindings/dma/dma.txt
> -
> -- dma-names: Names for the dma channels. There must be at least one channel
> -  named "tx" for transmit and named "rx" for receive.
> -
> -- clocks: specifies the clock IDs provided to the SPI controller; they are
> -  required for interacting with the controller itself, for synchronizing the bus
> -  and as I/O clock (the latter is required by exynos5433 and exynos7).
> -
> -- clock-names: string names of the clocks in the 'clocks' property; for all the
> -  the devices the names must be "spi", "spi_busclkN" (where N is determined by
> -  "samsung,spi-src-clk"), while Exynos5433 should specify a third clock
> -  "spi_ioclk" for the I/O clock.
> -
> -Required Board Specific Properties:
> -
> -- #address-cells: should be 1.
> -- #size-cells: should be 0.
> -
> -Optional Board Specific Properties:
> -
> -- samsung,spi-src-clk: If the spi controller includes a internal clock mux to
> -  select the clock source for the spi bus clock, this property can be used to
> -  indicate the clock to be used for driving the spi bus clock. If not specified,
> -  the clock number 0 is used as default.
> -
> -- num-cs: Specifies the number of chip select lines supported. If
> -  not specified, the default number of chip select lines is set to 1.
> -
> -- cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
> -
> -- no-cs-readback: the CS line is disconnected, therefore the device should not
> -  operate based on CS signalling.
> -
> -SPI Controller specific data in SPI slave nodes:
> -
> -- The spi slave nodes should provide the following information which is required
> -  by the spi controller.
> -
> -  - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
> -    miso line (to account for any lag in the miso line). The following are the
> -    valid values.
> -
> -      - 0: No phase shift.
> -      - 1: 90 degree phase shift sampling.
> -      - 2: 180 degree phase shift sampling.
> -      - 3: 270 degree phase shift sampling.
> -
> -Aliases:
> -
> -- All the SPI controller nodes should be represented in the aliases node using
> -  the following format 'spi{n}' where n is a unique number for the alias.
> -
> -
> -Example:
> -
> -- SoC Specific Portion:
> -
> -	spi_0: spi@12d20000 {
> -		compatible = "samsung,exynos4210-spi";
> -		reg = <0x12d20000 0x100>;
> -		interrupts = <0 66 0>;
> -		dmas = <&pdma0 5
> -			&pdma0 4>;
> -		dma-names = "tx", "rx";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -	};
> -
> -- Board Specific Portion:
> -
> -	spi_0: spi@12d20000 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi0_bus>;
> -		cs-gpios = <&gpa2 5 0>;
> -
> -		w25q80bw@0 {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "w25x80";
> -			reg = <0>;
> -			spi-max-frequency = <10000>;
> -
> -			controller-data {
> -				samsung,spi-feedback-delay = <0>;
> -			};
> -
> -			partition@0 {
> -				label = "U-Boot";
> -				reg = <0x0 0x40000>;
> -				read-only;
> -			};
> -
> -			partition@40000 {
> -				label = "Kernel";
> -				reg = <0x40000 0xc0000>;
> -			};
> -		};
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ea5655a29c3..1f951bc877f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17054,7 +17054,7 @@ M:	Andi Shyti <andi@etezian.org>
>  L:	linux-spi@vger.kernel.org
>  L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/spi/spi-samsung.txt
> +F:	Documentation/devicetree/bindings/spi/samsung,spi*.yaml
>  F:	drivers/spi/spi-s3c*
>  F:	include/linux/platform_data/spi-s3c64xx.h
>  F:	include/linux/spi/s3c24xx-fiq.h
> -- 
> 2.32.0
> 
> 
