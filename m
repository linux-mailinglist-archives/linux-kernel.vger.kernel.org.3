Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421158ED40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiHJN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiHJN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:29:21 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B84199F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:29:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i128-20020a1c3b86000000b003a536d58f73so1001304wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=El5U8RK9aLvduD1IUFTA0BkNM1fuVS1EOfWZ+eu1FG0=;
        b=qEgFzj5kfjWxCE9Ke0H6G2aJHPZWchGAHOH6JwEwXyFZS+ozPmj6u7vrOS6uq0w0pv
         /4lURZxSnJEIPpKusmIQFAtXn8kGTQgquzDc6lB1gCzFMz/D6zUOCtFG1TF/Eql19YQ0
         rwqrflc1kDdrp3BUEJd3dZ93ihAecQmoEjhWyC7DlkqZ88k5lJJ03cs8sSm5K0LXupe4
         LLT2UKTpx+L+nwBy5toeGkQjZdbDe6zVOlefo1FL5YPwG3btjhhxBhC0NBuJ1020X4V4
         qV/gL7DXSG0CqV4pPBy81nbYTpHmVH7k/f+aloal/O976vHl305gNF3pmoQFiRxRItbN
         kv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=El5U8RK9aLvduD1IUFTA0BkNM1fuVS1EOfWZ+eu1FG0=;
        b=OuYXftB1ob4VMcgeMjvN70x6spO70p6vhE3ScnPLTit/39dqt3ri+jF+FcDgI6uMsn
         pu4khyGlVjw0rEAdN83mEkP0CzyfhP7geVfMpArrj+AjorNVLHUK6o2pbG6MXWXPmFd5
         jNUxBDZxTwUmTplSANydGJSyfmzqiAWYihjxPsK5jaZ04Z+YHpUhjpmFWqLZP274GfGQ
         J54yAVlhd+jDvd8hEkOz0BFWshcrMDadudFnw8UEK44B3VqZqV6ZtJkbEvH8hllMO6QP
         PiyhZjpuJueLOxatJZN/HDuSgWWbxP5LWOVT5rU5sZx7cUU/+3WpkOvkad4+WowGg0lh
         KQ3Q==
X-Gm-Message-State: ACgBeo3QaAwZut3X7zBTZliPc3XTIBP1XDUc1KGTEIj7vK9J8OKpkLSK
        nBj92a9OUJ1VlTWFY+kVxugJ9g==
X-Google-Smtp-Source: AA6agR6d9GnhvvPy9EnDhLzUj5Pi0Mq7K0+QdRKqDXVrcOcpXTVWdG9uBWZ1rThQqssw/R9iAn8rZg==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr2386804wmp.143.1660138155970;
        Wed, 10 Aug 2022 06:29:15 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4d09000000b0021dd08ad8d7sm16298130wrt.46.2022.08.10.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:29:15 -0700 (PDT)
Date:   Wed, 10 Aug 2022 14:29:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <YvOyqUGOjlZ7qE5K@google.com>
References: <20220626191630.176835-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626191630.176835-1-david@ixit.cz>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, 26 Jun 2022, David Heidelberg wrote:

> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>  - filled many missing compatibles
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v3:
>  - added subnodes, there are two not converted to YAML yet, but it works
>  - now it prints milion directly unrelated warning to this binding
>    (it's related to the included subnodes bindings, can be merged,
>     but it'll generate more warnings and preferably anyone can takeover
>     from here)
>  - add qcom,pmx65
> 
> v2:
>  - changed author to myself, kept Caleb as co-author
>  - moved nodename to properties
>  - add nodenames for pm* with deprecated property
>  - add ^$ to pattern properties
>  - dropped interrupt-names property
>  - added reg prop. to the nodes which have register in nodename
>  - added compatible pmx55
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.txt           |  94 ---------
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 191 ++++++++++++++++++
>  2 files changed, 191 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> deleted file mode 100644
> index eb78e3ae7703..000000000000
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -          Qualcomm SPMI PMICs multi-function device bindings
> -
> -The Qualcomm SPMI series presently includes PM8941, PM8841 and PMA8084
> -PMICs.  These PMICs use a QPNP scheme through SPMI interface.
> -QPNP is effectively a partitioning scheme for dividing the SPMI extended
> -register space up into logical pieces, and set of fixed register
> -locations/definitions within these regions, with some of these regions
> -specifically used for interrupt handling.
> -
> -The QPNP PMICs are used with the Qualcomm Snapdragon series SoCs, and are
> -interfaced to the chip via the SPMI (System Power Management Interface) bus.
> -Support for multiple independent functions are implemented by splitting the
> -16-bit SPMI slave address space into 256 smaller fixed-size regions, 256 bytes
> -each. A function can consume one or more of these fixed-size register regions.
> -
> -Required properties:
> -- compatible:      Should contain one of:
> -                   "qcom,pm660",
> -                   "qcom,pm660l",
> -                   "qcom,pm7325",
> -                   "qcom,pm8004",
> -                   "qcom,pm8005",
> -                   "qcom,pm8019",
> -                   "qcom,pm8028",
> -                   "qcom,pm8110",
> -                   "qcom,pm8150",
> -                   "qcom,pm8150b",
> -                   "qcom,pm8150c",
> -                   "qcom,pm8150l",
> -                   "qcom,pm8226",
> -                   "qcom,pm8350c",
> -                   "qcom,pm8841",
> -                   "qcom,pm8901",
> -                   "qcom,pm8909",
> -                   "qcom,pm8916",
> -                   "qcom,pm8941",
> -                   "qcom,pm8950",
> -                   "qcom,pm8953",
> -                   "qcom,pm8994",
> -                   "qcom,pm8998",
> -                   "qcom,pma8084",
> -                   "qcom,pmd9635",
> -                   "qcom,pmi8950",
> -                   "qcom,pmi8962",
> -                   "qcom,pmi8994",
> -                   "qcom,pmi8998",
> -                   "qcom,pmk8002",
> -                   "qcom,pmk8350",
> -                   "qcom,pmr735a",
> -                   "qcom,smb2351",
> -                   or generalized "qcom,spmi-pmic".
> -- reg:             Specifies the SPMI USID slave address for this device.
> -                   For more information see:
> -                   Documentation/devicetree/bindings/spmi/spmi.yaml
> -
> -Required properties for peripheral child nodes:
> -- compatible:      Should contain "qcom,xxx", where "xxx" is a peripheral name.
> -
> -Optional properties for peripheral child nodes:
> -- interrupts:      Interrupts are specified as a 4-tuple. For more information
> -                   see:
> -                   Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> -- interrupt-names: Corresponding interrupt name to the interrupts property
> -
> -Each child node of SPMI slave id represents a function of the PMIC. In the
> -example below the rtc device node represents a peripheral of pm8941
> -SID = 0. The regulator device node represents a peripheral of pm8941 SID = 1.
> -
> -Example:
> -
> -	spmi {
> -		compatible = "qcom,spmi-pmic-arb";
> -
> -		pm8941@0 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x0 SPMI_USID>;
> -
> -			rtc {
> -				compatible = "qcom,rtc";
> -				interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> -				interrupt-names = "alarm";
> -			};
> -		};
> -
> -		pm8941@1 {
> -			compatible = "qcom,pm8941", "qcom,spmi-pmic";
> -			reg = <0x1 SPMI_USID>;
> -
> -			regulator {
> -				compatible = "qcom,regulator";
> -				regulator-name = "8941_boost";
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> new file mode 100644
> index 000000000000..32daebc3a0bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -0,0 +1,191 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMICs multi-function device
> +
> +description: |
> +  Some Qualcomm PMICs used with the Snapdragon series SoCs are interfaced
> +  to the chip via the SPMI (System Power Management Interface) bus.
> +  Support for multiple independent functions are implemented by splitting the
> +  16-bit SPMI peripheral address space into 256 smaller fixed-size regions, 256 bytes
> +  each. A function can consume one or more of these fixed-size register regions.
> +
> +  The Qualcomm SPMI series includes the PM8941, PM8841, PMA8084, PM8998 and other
> +  PMICs.  These PMICs use a "QPNP" scheme through SPMI interface.
> +  QPNP is effectively a partitioning scheme for dividing the SPMI extended
> +  register space up into logical pieces, and set of fixed register
> +  locations/definitions within these regions, with some of these regions
> +  specifically used for interrupt handling.
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +properties:
> +  $nodename:
> +    oneOf:
> +      - pattern: '^pmic@.*$'
> +      - pattern: '^pm(a|s)?[0-9]*@.*$'
> +        deprecated: true
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pm660
> +          - qcom,pm660l
> +          - qcom,pm6150
> +          - qcom,pm6150l
> +          - qcom,pm6350
> +          - qcom,pm7325
> +          - qcom,pm8004
> +          - qcom,pm8005
> +          - qcom,pm8009
> +          - qcom,pm8019
> +          - qcom,pm8110
> +          - qcom,pm8150
> +          - qcom,pm8150b
> +          - qcom,pm8150l
> +          - qcom,pm8226
> +          - qcom,pm8350
> +          - qcom,pm8350b
> +          - qcom,pm8350c
> +          - qcom,pm8841
> +          - qcom,pm8909
> +          - qcom,pm8916
> +          - qcom,pm8941
> +          - qcom,pm8950
> +          - qcom,pm8994
> +          - qcom,pm8998
> +          - qcom,pma8084
> +          - qcom,pmd9635
> +          - qcom,pmi8950
> +          - qcom,pmi8962
> +          - qcom,pmi8994
> +          - qcom,pmi8998
> +          - qcom,pmk8350
> +          - qcom,pmm8155au
> +          - qcom,pmr735a
> +          - qcom,pmr735b
> +          - qcom,pms405
> +          - qcom,pmx55
> +          - qcom,pmx65
> +          - qcom,smb2351
> +      - const: qcom,spmi-pmic
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  labibb:
> +    type: object
> +    $ref: /schemas/regulator/qcom-labibb-regulator.yaml#
> +
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +
> +patternProperties:
> +  "^adc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
> +
> +  "^adc-tm@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/thermal/qcom-spmi-adc-tm5.yaml#
> +
> +  "^audio-codec@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
> +
> +  "extcon@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
> +
> +  "gpio(s)?@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
> +
> +  "pon@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/power/reset/qcom,pon.yaml#
> +
> +  "pwm@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/leds/leds-qcom-lpg.yaml#
> +
> +  "^rtc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/rtc/qcom-pm8xxx-rtc.yaml#
> +
> +  "^temp-alarm@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/thermal/qcom,spmi-temp-alarm.yaml#
> +
> +  "^vibrator@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true # FIXME qcom,pm8916-vib binding not converted yet
> +
> +  "^mpps@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/pinctrl/qcom,pmic-mpp.yaml#
> +
> +  "(.*)?(wled|leds)@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/leds/backlight/qcom-wled.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/spmi/spmi.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spmi@c440000 {
> +        compatible = "qcom,spmi-pmic-arb";
> +        reg = <0x0c440000 0x1100>,
> +              <0x0c600000 0x2000000>,
> +              <0x0e600000 0x100000>,
> +              <0x0e700000 0xa0000>,
> +              <0x0c40a000 0x26000>;
> +        reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +        interrupt-names = "periph_irq";
> +        interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
> +        qcom,ee = <0>;
> +        qcom,channel = <0>;
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        interrupt-controller;
> +        #interrupt-cells = <4>;
> +        cell-index = <0>;
> +
> +        pmi8998_lsid0: pmic@2 {
> +            compatible = "qcom,pmi8998", "qcom,spmi-pmic";
> +            reg = <0x2 SPMI_USID>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            pmi8998_gpio: gpios@c000 {
> +                compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
> +                reg = <0xc000>;
> +                gpio-controller;
> +                gpio-ranges = <&pmi8998_gpio 0 0 14>;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +        };
> +    };

-- 
DEPRECATED: Please use lee@kernel.org
