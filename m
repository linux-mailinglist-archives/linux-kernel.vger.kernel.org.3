Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8947558F40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiFXDog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiFXDo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:44:28 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6673FBD8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:44:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101d96fe0a5so2197653fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LsVAWFxXYW9U7WkPksAuQVnNc7dyC8As5T0zm8UW5hA=;
        b=D5WWm9pkGorlJ7Oa+cZXIDW1PD5SceZfIHMI8VXpHeIGLw0b83jZdMGGX8XbWbZfO4
         K8rThFQLq1mkrE73KGALs4VVkDn8WobG02FY9KvRwfmW3VD5Cjz/12OORsaiqSmB36hl
         5ns1Hr7gwIp6AKa9Lptj0zjZFtKHqwrEBsYR21yUcj84TM7gjgN4EVd5xRDm4xnXOHfG
         ePFn3k5mw/rBp/Z1lR+HfB/YfhEFFJRH/Yowku94N3PZjpL5gzd/2Zwx+Cj6q4SmJdD/
         iQJn98KTUvlRXgDwymt1y/haALFj9Z4kZhAQeLY98COTUK/SJn19XewzWzL2glXXj3Yi
         GSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LsVAWFxXYW9U7WkPksAuQVnNc7dyC8As5T0zm8UW5hA=;
        b=PNHSsqvdprurSxuUpBHA2DGuNBCEflay9nyQqi8MO38yy0hf2XbHojk7bxwU6JUVhs
         i4H51Ep8qAeqYpvKqdfGU3rxeg5nf5nv0Eaxq0/BtjwXGkPAmlujqmJlRykbF5V2PUBi
         tg/Et95TnmfDB9x8MqRgyVGqUXFcxGwqq8ZPiXyhhMl1v2IaA/dwK0GiNt5WGEim3Jh8
         QybTTWBBa0+sMVx3pPY4HRJonQU83S9VRuqNAZZ+Gx/ljm2p9xGeA5wjSikBovO73n73
         m0VelYGqY1EJ00RHARgvZ9a0XALPf1KPSoYVIMiOH/6AY9WcFjA4KforlFjll06iReN2
         uv7Q==
X-Gm-Message-State: AJIora/QA9pwW30bs+b/Jmz+jw6UbVjZ9nXfVhiRTrmev3cccAmVHkYH
        LlW4I45vjfXmeDc4dBWuujHjIw==
X-Google-Smtp-Source: AGRyM1tsiqNsqAvJu0wE+gfTif8LTF9rrpM54BGnBx5SoMvZNMqeZ0rwn08kFQqwe9EasV4DxsivsA==
X-Received: by 2002:a05:6870:6195:b0:100:ee8a:ce86 with SMTP id a21-20020a056870619500b00100ee8ace86mr906630oah.40.1656042265790;
        Thu, 23 Jun 2022 20:44:25 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m28-20020a9d609c000000b0060c0b3c1b2asm907505otj.33.2022.06.23.20.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:44:25 -0700 (PDT)
Date:   Thu, 23 Jun 2022 22:44:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 4/8] dt-bindings: pinctrl: qcom: Add ipq5018 pinctrl
 bindings
Message-ID: <YrUzFgB+PxYViH5L@builder.lan>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-5-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621161126.15883-5-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jun 11:11 CDT 2022, Sricharan R wrote:

> From: Varadarajan Narayanan <quic_varada@quicinc.com>
> 
> Add device tree binding Documentation details for ipq5018
> pinctrl driver.
> 
> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  .../pinctrl/qcom,ipq5018-pinctrl.yaml         | 145 ++++++++++++++++++
>  1 file changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
> new file mode 100644
> index 000000000000..9b16c08bd127
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-pinctrl.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5018-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. IPQ5018 TLMM block
> +
> +maintainers:
> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> +  - Sricharan R <quic_srichara@quicinc.com>
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  IPQ5018 platform.
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq5018-pinctrl

qcom,ipq5018-tlmm please

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Specifies the TLMM summary IRQ
> +    maxItems: 1

Please rely on qcom,tlmm-common.yaml, in line with e.g.
qcom,sc8280xp-pinctrl.yaml.

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    description:
> +      Specifies the PIN numbers and Flags, as defined in defined in
> +      include/dt-bindings/interrupt-controller/irq.h
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description: Specifying the pin number and flags, as defined in
> +      include/dt-bindings/gpio/gpio.h
> +    const: 2
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +#PIN CONFIGURATION NODES
> +patternProperties:
> +  '-pinmux$':

This will only allow describing properties directly in the state node,
not under subnodes. Please update according to e.g. sc8280xp

Also, please use the suffix "-state"

> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "/schemas/pinctrl/pincfg-node.yaml"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([1-9]|[1-7][0-9]|80)$"

According to the implementation you should only accept
"^gpio([1-9]|[1-3][0-9]|4[0-6]$"

> +        minItems: 1
> +        maxItems: 4
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
> +          audio_pdm0, audio_pdm1, audio_rxbclk, audio_rxd, audio_rxfsync,
> +          audio_rxmclk, audio_txbclk, audio_txd, audio_txfsync, audio_txmclk,
> +          blsp0_i2c, blsp0_spi, blsp0_uart0, blsp0_uart1, blsp1_i2c0,
> +          blsp1_i2c1, blsp1_spi0, blsp1_spi1, blsp1_uart0, blsp1_uart1,
> +          blsp1_uart2, blsp2_i2c0, blsp2_i2c1, blsp2_spi, blsp2_spi0,
> +          blsp2_spi1, btss0, btss1, btss10, btss11, btss12, btss13, btss2,
> +          btss3, btss4, btss5, btss6, btss7, btss8, btss9, burn0, burn1,
> +          cri_trng, cri_trng0, cri_trng1, cxc_clk, cxc_data, dbg_out, eud_gpio,
> +          gcc_plltest, gcc_tlmm, gpio, mac0, mac1, mdc, mdio, pcie0_clk,
> +          pcie0_wake, pcie1_clk, pcie1_wake, pll_test, prng_rosc, pwm0, pwm1,
> +          pwm2, pwm3, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1,
> +          qdss_cti_trig_in_b0, qdss_cti_trig_in_b1, qdss_cti_trig_out_a0,
> +          qdss_cti_trig_out_a1, qdss_cti_trig_out_b0, qdss_cti_trig_out_b1,
> +          qdss_traceclk_a, qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
> +          qdss_tracedata_a, qdss_tracedata_b, qspi_clk, qspi_cs, qspi0, qspi1,
> +          qspi2, qspi3, reset_out, sdc1_clk, sdc1_cmd, sdc10, sdc11, sdc12,
> +          sdc13, wci0, wci1, wci2, wci3, wci4, wci5, wci6, wci7, wsa_swrm,
> +          wsi_clk3, wsi_data3, wsis_reset, xfem0, xfem1, xfem2, xfem3, xfem4,
> +          xfem5, xfem6, xfem7 ]
> +
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.
> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      bias-disable: true
> +
> +      output-high: true
> +
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        tlmm: pinctrl@1000000 {
> +              compatible = "qcom,ipq5018-pinctrl";
> +              reg = <0x01000000 0x300000>;
> +              interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +              interrupt-controller;
> +              #interrupt-cells = <2>;
> +              gpio-controller;
> +              #gpio-cells = <2>;
> +              gpio-ranges = <&tlmm 0 80>;

I think this should be 47.

Regards,
Bjorn

> +
> +              serial3-pinmux {
> +                      pins = "gpio44", "gpio45";
> +                      function = "blsp0_uart0";
> +                      drive-strength = <8>;
> +                      bias-pull-down;
> +              };
> +        };
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
