Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC44581392
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiGZM4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiGZM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:56:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A41B7A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so8119312wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ILtpMzX3VY8k59M2BJDRJGfQpuHK3RZfnXCOjBm8eTY=;
        b=Idx1cyBcJSvQO3qJZY9/aAkWS39UYbRrrvFmReLWAdgOk77gC96Fms5dd93efjpID+
         SQ2cZMwICM1Dea4y48jvewtcgj6nXOOw5ldBOIcTeW1eIvMogAm1zEw12cbKJ+DM4Fgs
         wHlb2ykYPd2GlQZxjNsRMSazXBLqe9y+i5cIwGYjkC+yvwGNUkGrMNTFcC36YMnjm6IR
         xGt5LDLtwbPYpPU4vyZLL1TcFE6BxbFAfe6KoC9E0nPJVbVuChQP7pqvZu+ofLO86Bel
         Qc5N3OSUXrm35zzIxWP2ZMJhhW6WyO6XJ1ch/A2YysgUwhW9mxP0C9CLKoe6Cewfo1TJ
         DGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ILtpMzX3VY8k59M2BJDRJGfQpuHK3RZfnXCOjBm8eTY=;
        b=QKmpNW2jhlEofGC8La/BXJodXg+6t+mxrzkw4lp28Gay9e07sW5S7chB5Zn1RmJfo3
         R0xv6LZ2D/mpCVRZ11Yncctnrs33Qiqy/CqV7Dkky2ihbnuo7JFlZhBtWNsXRzFmOKgR
         zkcJFf/4UNACqwrQaLIFdu0uwB/xVSs1nQlW4s66td8qhUclLhUFwp3CvKbwSoj6kzor
         dHB6A7zhvQlMHDnwB/UUITGOTAYMcNoRgOABXsItQYQMAAuy7y5TpoRmcIJmdnJSC95j
         guNOr5ALleedJ+3lPAKtY3ljp1Xt9lqwJHDSdo6WFZxVNZZ5RGzbWkvsyPK/LUJGYTID
         3nUA==
X-Gm-Message-State: AJIora+SWm8yeOgzGiCUJ0U74Lcd8QcVfQL5UCAZPPkE6ehvXqJ/cwmv
        A+4xypEBksDhNLjhnzZ/fFwLoQ==
X-Google-Smtp-Source: AGRyM1ukOx2aF9TBjUKq17lWfVED7ORwA752wJog+hPij7ufp+0vmCFhu2SrCpEmVz1IreQKIux2RQ==
X-Received: by 2002:a05:600c:6002:b0:3a3:5453:bcbe with SMTP id az2-20020a05600c600200b003a35453bcbemr8829006wmb.190.1658840168574;
        Tue, 26 Jul 2022 05:56:08 -0700 (PDT)
Received: from blmsp ([2001:4090:a243:806e:25e7:daa:8208:ceb])
        by smtp.gmail.com with ESMTPSA id a9-20020adfeec9000000b0021dfacfdf0dsm14944421wrp.33.2022.07.26.05.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:56:08 -0700 (PDT)
Date:   Tue, 26 Jul 2022 14:56:06 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, khilman@baylibre.com,
        narmstrong@baylibre.com, j-keerthy@ti.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/11] regulator: dt-bindings: Add TI TPS65219 PMIC
 bindings
Message-ID: <20220726125606.kzpzlfeg57ufuhiv@blmsp>
References: <20220726103355.17684-1-jneanne@baylibre.com>
 <20220726103355.17684-6-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220726103355.17684-6-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 26, 2022 at 12:33:49PM +0200, Jerome Neanne wrote:
> Add TPS65219 PMIC bindings using json-schema.
> 
> Describe required properties and regname-supply.
> regname-supply is required when bypass mode is used for a regulator.
> Describes regulator topology.
> Interrupts support.
> Add a power-button property to configure the EN/PB/VSENSE pin as a
> powerbutton:
> 
> TPS65219 has a multipurpose pin called EN/PB/VSENSE that can be either:
> - EN in which case it functions as an enable pin.
> - VSENSE which compares the voltages and triggers an automatic
> on/off request.
> - PB in which case it can be configured to trigger an interrupt
> to the SoC.
> ti,power-button reflects the last one of those options
> where the board has a button wired to the pin and triggers
> an interrupt on pressing it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  .../bindings/regulator/ti,tps65219.yaml       | 164 ++++++++++++++++++
>  1 file changed, 164 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml
> new file mode 100644
> index 000000000000..8fca4db6c64c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,tps65219.yaml

...

> +
> +  power-button:
> +    type: boolean
> +    description: Optional property that sets the EN/PB/VSENSE pin to be a
> +      power-button.

It seems something went wrong here. This should have been
ti,power-button and have a similar description as the commit message,
right?

Best,
Markus

> +
> +patternProperties:
> +  "^buck[1-3]-supply$":
> +    description: Input supply phandle of one regulator.
> +
> +  "^ldo[1-4]-supply$":
> +    description: Input supply phandle of one regulator.
> +
> +  regulators:
> +    type: object
> +    description: |
> +      list of regulators provided by this controller
> +
> +    patternProperties:
> +      "^ldo[1-4]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description:
> +          Properties for single LDO regulator.
> +
> +        unevaluatedProperties: false
> +
> +      "^buck[1-3]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description:
> +          Properties for single BUCK regulator.
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tps65219: pmic@30 {
> +            compatible = "ti,tps65219";
> +            reg = <0x30>;
> +            buck1-supply = <&vcc_3v3_sys>;
> +            buck2-supply = <&vcc_3v3_sys>;
> +            buck3-supply = <&vcc_3v3_sys>;
> +            ldo1-supply = <&vcc_3v3_sys>;
> +            ldo2-supply = <&buck2_reg>;
> +            ldo3-supply = <&vcc_3v3_sys>;
> +            ldo4-supply = <&vcc_3v3_sys>;
> +
> +            pinctrl-0 = <&pmic_irq_pins_default>;
> +
> +            interrupt-parent = <&gic500>;
> +            interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +
> +            regulators {
> +                buck1_reg: buck1 {
> +                    regulator-name = "VDD_CORE";
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <750000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                buck2_reg: buck2 {
> +                    regulator-name = "VCC1V8";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                buck3_reg: buck3 {
> +                    regulator-name = "VDD_LPDDR4";
> +                    regulator-min-microvolt = <1100000>;
> +                    regulator-max-microvolt = <1100000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo1_reg: ldo1 {
> +                    regulator-name = "VDDSHV_SD_IO_PMIC";
> +                    regulator-min-microvolt = <33000000>;
> +                    regulator-max-microvolt = <33000000>;
> +                };
> +
> +                ldo2_reg: ldo2 {
> +                    regulator-name = "VDDAR_CORE";
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <850000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo3_reg: ldo3 {
> +                    regulator-name = "VDDA_1V8";
> +                    regulator-min-microvolt = <18000000>;
> +                    regulator-max-microvolt = <18000000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo4_reg: ldo4 {
> +                    regulator-name = "VDD_PHY_2V5";
> +                    regulator-min-microvolt = <25000000>;
> +                    regulator-max-microvolt = <25000000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
