Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74D4C5A73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiB0KRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiB0KRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:17:08 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042E6BDC7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:16:32 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 777A83F32C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645956990;
        bh=kmoD7cJEJVkX+3PDX3ngx5DBAJIU55Xem09lH3DyvFU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=aoKzJoNr1Es3Odo5u7zhJDU6gGIThkgoq/TpaK9S4yDlRvrMCPJYcx2CykkgJItHj
         5owkTujBJ7ML9qFg7jlPuGdxhahip7l/iWY3OtgWqJSpJ8jmDXY21gmiuEYypb+inj
         81nyhsmazPDsofZjisBvIBADqSIZDYHblHkbpL05dQQa5CUofEvfxOCOQ2VG6WIPnb
         Tf/TfW/17kYtvrL3UjWIUGreGDbWvh85AXrBmn2/m6/tHrbb95Y6WYy56piUmXcWsW
         whXPip/haTYenRVZLobVSLYQH00s3y3haU2qiVisM/Lqnyf+OgqIltbDNrj7It4Zk/
         v10x1+qQnka5w==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so4080218edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 02:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kmoD7cJEJVkX+3PDX3ngx5DBAJIU55Xem09lH3DyvFU=;
        b=QGtteKw8m0T/dHzZp05NZIOWVp0brb2IfvaGOqI8lbNy5ekCcVtZEKsIUaiJthyiei
         EpygJKXOYK4zXQLOa3wLwJkTvwF418MyHj7Qt6EH5S2u9s6GmGGBH72THOOt7h0TLFyL
         sro7VsJ8qT2TNxu03rMM+rkk+rOZY12tfxdKnAxz2CkG/FpncGt9qyjR6JYRQ/141tVf
         0mofUtHWt3N7teU1Zz3tQNkfxb8n47j6BCTS4s1+56VyZCP5CF0jvSwVg4nB1YuwT/Mk
         1GzPAniEnHGqqeeeRv8zry7PbeVunPgWy0SiT4RtoODzltG4Oqk8H6WY/NDB11bv+Rc7
         BSqg==
X-Gm-Message-State: AOAM532aXMGvNJJWUWeBzly22n6/INSvz7G0hZdBGh7tKbmQ/Z5j7Xdz
        6Mwvs1NGIi72KE0BKnDry9OIbA7zzikhG6KhM6mfjUl4YkoEAkamkM4K1FliBTlJmqe7hNAW3ox
        ZZB1YxODeiBXIm40HeueBkKQB9Gi3a5W7+sYvuyUh4A==
X-Received: by 2002:a17:906:2bd7:b0:6ce:698b:7531 with SMTP id n23-20020a1709062bd700b006ce698b7531mr11343205ejg.146.1645956990009;
        Sun, 27 Feb 2022 02:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUjjBwCh37I+1mUMUa+xGZDH63kIDP8OnGMhJgFxCCnxP5nXkd2cFmHtKPy6Ey882opgZY+w==
X-Received: by 2002:a17:906:2bd7:b0:6ce:698b:7531 with SMTP id n23-20020a1709062bd700b006ce698b7531mr11343191ejg.146.1645956989684;
        Sun, 27 Feb 2022 02:16:29 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id e5-20020a170906374500b006d5825520a7sm3209628ejc.71.2022.02.27.02.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 02:16:29 -0800 (PST)
Message-ID: <94482135-71c2-f9a9-966c-4cd0b66a130b@canonical.com>
Date:   Sun, 27 Feb 2022 11:16:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp TLMM binding
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220225053257.2479279-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220225053257.2479279-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2022 06:32, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform contains a single block of registers
> for the TLMM block. This provides pinconf and pinmux for 228 GPIOs, 2
> UFS_RESET pins and one SDC interface.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
> new file mode 100644
> index 000000000000..4199dfe992e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
> @@ -0,0 +1,153 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sc8280xp-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SC8280XP TLMM block
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block found in the
> +  SC8280XP platform.
> +
> +allOf:
> +  - $ref: "pinctrl.yaml#"

This looks not needed. I see it was added in other QCOM schemas by
https://lore.kernel.org/all/20211202063216.24439-1-zajec5@gmail.com/
(+CC Rafał) but it is already part of qcom,tlmm-common.yaml. I think
there is no need to include it twice.


> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sc8280xp-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  gpio-reserved-ranges: true
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names

I think you do not use it. The example does not have it so it should
fail validation (dt_binding_check).

> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
> +      - patternProperties:
> +          ".*":
> +            $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
> +
> +'$defs':
> +  qcom-sc8280xp-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-1][0-9]|22[0-7])$"
> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset, ufs1_reset ]
> +        minItems: 1
> +        maxItems: 16
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ atest_char, atest_usb, audio_ref, cam_mclk, cci_async, cci_i2c,
> +                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> +                cci_timer5, cci_timer6, cci_timer7, cci_timer8, cci_timer9,
> +                cmu_rng, cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
> +                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, ddr_pxi4, ddr_pxi5,
> +                ddr_pxi6, ddr_pxi7, dp2_hot, dp3_hot, edp0_lcd, edp1_lcd,
> +                edp2_lcd, edp3_lcd, edp_hot, emac0_dll, emac0_mcg0, emac0_mcg1,
> +                emac0_mcg2, emac0_mcg3, emac0_phy, emac0_ptp, emac1_dll0,
> +                emac1_dll1, emac1_mcg0, emac1_mcg1, emac1_mcg2, emac1_mcg3,
> +                emac1_phy, emac1_ptp, gcc_gp1, gcc_gp2, gcc_gp3, gcc_gp4,
> +                gcc_gp5, gpio, hs1_mi2s, hs2_mi2s, hs3_mi2s, ibi_i3c,
> +                jitter_bist, lpass_slimbus, mdp0_vsync0, mdp0_vsync1,
> +                mdp0_vsync2, mdp0_vsync3, mdp0_vsync4, mdp0_vsync5,
> +                mdp0_vsync6, mdp0_vsync7, mdp0_vsync8, mdp1_vsync0,
> +                mdp1_vsync1, mdp1_vsync2, mdp1_vsync3, mdp1_vsync4,
> +                mdp1_vsync5, mdp1_vsync6, mdp1_vsync7, mdp1_vsync8, mdp_vsync,
> +                mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s1_data0,
> +                mi2s1_data1, mi2s1_sck, mi2s1_ws, mi2s2_data0, mi2s2_data1,
> +                mi2s2_sck, mi2s2_ws, mi2s_mclk1, mi2s_mclk2, pcie2a_clkreq,
> +                pcie2b_clkreq, pcie3a_clkreq, pcie3b_clkreq, pcie4_clkreq,
> +                phase_flag, pll_bist, pll_clk, prng_rosc0, prng_rosc1,
> +                prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio, qspi, qspi_clk,
> +                qspi_cs, qup0, qup1, qup2, qup3, qup4, qup5, qup6, qup7, qup8,
> +                qup9, qup10, qup11, qup12, qup13, qup14, qup15, qup16, qup17,
> +                qup18, qup19, qup20, qup21, qup22, qup23, rgmii_0, rgmii_1,
> +                sd_write, sdc40, sdc42, sdc43, sdc4_clk, sdc4_cmd, tb_trig,
> +                tgu, tsense_pwm1, tsense_pwm2, tsense_pwm3, tsense_pwm4,
> +                usb0_dp, usb0_phy, usb0_sbrx, usb0_sbtx, usb0_usb4, usb1_dp,
> +                usb1_phy, usb1_sbrx, usb1_sbtx, usb1_usb4, usb2phy_ac,
> +                vsense_trigger ]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        pinctrl@3100000 {
> +                compatible = "qcom,sc8280x-tlmm";
> +                reg = <0x0f100000 0x300000>;

reg looks different than unit address.


Best regards,
Krzysztof
