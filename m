Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77D148462C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiADQrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:47:08 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41800 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiADQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:47:04 -0500
Received: by mail-ot1-f42.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so7108534otl.8;
        Tue, 04 Jan 2022 08:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7mQQJrCdEvgNbyIwr5yNwFdQG8u6m/SH9iP6BsWA2k=;
        b=pARU8lByw8HFVOWbnBpkLDMwXrOROArCgugp0NVYSd9gUQc1p2igsV7eTSJa7bsFqd
         v91SaktpZ3q6rdmldenv4vA7iwt1VeJ9sbfWOeN0aDnNjVWiyHyYisyV3CLx51nSZjiY
         nSKQTASB9l9Wmb47hi324hL98dW6dUQ20inpay+PiNGq/NB1CjlNMoQAL0sKlSQyCSvs
         CMFcQ/mWECba0c+tfM9Ca+u6jkr4Db2dJUQo94TA++3X08DCOHrUCl4BFqfDsIGp1Nro
         Na3CWIJwn4xyb+eRPjKMZoV0F7Jfwf+8HsRiSRz1aTKLG+nK3fFPolZi2VvmgzOoyT8r
         7Hpg==
X-Gm-Message-State: AOAM533re9NS/ZRaBqa1TKjW0siqvDfx2t55W1Clt+zvPl5POqpvzNWG
        S+Ft60yBJikTaico46XeWMbMt7Z0Dg==
X-Google-Smtp-Source: ABdhPJy0PyfbMoothJN0QqxQV5E6kPSeffzh13BwOswhv+KAZppSmJI+nToDoCzSskZteZdgFbdUug==
X-Received: by 2002:a9d:7519:: with SMTP id r25mr35850106otk.16.1641314823657;
        Tue, 04 Jan 2022 08:47:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f20sm10008819oiw.48.2022.01.04.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:47:02 -0800 (PST)
Received: (nullmailer pid 996734 invoked by uid 1000);
        Tue, 04 Jan 2022 16:47:02 -0000
Date:   Tue, 4 Jan 2022 10:47:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <YdR6BsyVaBnnFz7x@robh.at.kernel.org>
References: <20220102155807.42758-1-krzysztof.kozlowski@canonical.com>
 <20220102155807.42758-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220102155807.42758-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 04:58:07PM +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/spi/samsung,spi.yaml  | 220 ++++++++++++++++++
>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ----------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 221 insertions(+), 123 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> new file mode 100644
> index 000000000000..195bfafe05fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
> @@ -0,0 +1,220 @@
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
> +          - samsung,s3c2443-spi
> +          - samsung,s3c6410-spi
> +          - samsung,s5pv210-spi
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
> +
> +    allOf:
> +      - $ref: spi-peripheral-props.yaml
> +
> +    properties:
> +      controller-data:
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          samsung,spi-feedback-delay:

All this has to go in it's own schema which then needs to be added to 
spi-peripheral-props.yaml.

> +            description: |
> +              The sampling phase shift to be applied on the miso line (to account
> +              for any lag in the miso line). Valid values:
> +               - 0: No phase shift.
> +               - 1: 90 degree phase shift sampling.
> +               - 2: 180 degree phase shift sampling.
> +               - 3: 270 degree phase shift sampling.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +
> +        required:
> +          - samsung,spi-feedback-delay
> +
> +    required:
> +      - controller-data

Not really great that this is required and there's not some default that 
works.

> +
> +    unevaluatedProperties: false
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
> +        status = "okay";

Don't need 'status' in examples.

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

The schema didn't get checked since spi-peripheral-props.yaml isn't 
yet in my tree, but I'd expect this to be a warning. If not its schema 
needs to be a bit stricter. The schema for "wlf,wm5110" will need to 
reference spi-peripheral-props.yaml. (Actually, all SPI peripheral 
device schemas will need a reference in theory, but really we only care 
for devices used with controllers with extra properties). 

Rob
