Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CED53EDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiFFSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiFFSiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:38:17 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47561E77C7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:38:16 -0700 (PDT)
Received: from [10.1.250.9] (unknown [194.29.137.21])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 66C2020069;
        Mon,  6 Jun 2022 20:38:14 +0200 (CEST)
Message-ID: <8e4b4388-4be2-7837-ca03-6d0d5985f43a@somainline.org>
Date:   Mon, 6 Jun 2022 20:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: msm8974: re-add missing pinctrl
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220606160421.1641778-1-luca@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220606160421.1641778-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2022 18:04, Luca Weiss wrote:
> As part of a recent cleanup commit, the pinctrl for a few uart and i2c
> nodes was removed. Adjust the names and/or add it back and assign it to
> the uart and i2c nodes.
>
> Fixes: 1dfe967ec7cf ("ARM: dts: qcom-msm8974*: Consolidate I2C/UART/SDHCI")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Bjorn, could you please pick this up for -fixes so it lands in an
> upcoming 5.19-rc?

No idea how I did this. Thanks for spotting it though.


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   arch/arm/boot/dts/qcom-msm8974.dtsi | 30 +++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 814ad0b46232..c3b8a6d63027 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -506,6 +506,8 @@ blsp1_uart2: serial@f991e000 {
>   			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
>   			clock-names = "core", "iface";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&blsp1_uart2_default>;
>   			status = "disabled";
>   		};
>   
> @@ -581,6 +583,9 @@ blsp2_uart1: serial@f995d000 {
>   			interrupts = <GIC_SPI 113 IRQ_TYPE_NONE>;
>   			clocks = <&gcc GCC_BLSP2_UART1_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
>   			clock-names = "core", "iface";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp2_uart1_default>;
> +			pinctrl-1 = <&blsp2_uart1_sleep>;
>   			status = "disabled";
>   		};
>   
> @@ -599,6 +604,8 @@ blsp2_uart4: serial@f9960000 {
>   			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&gcc GCC_BLSP2_UART4_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
>   			clock-names = "core", "iface";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&blsp2_uart4_default>;
>   			status = "disabled";
>   		};
>   
> @@ -639,6 +646,9 @@ blsp2_i2c6: i2c@f9968000 {
>   			interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
>   			clock-names = "core", "iface";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp2_i2c6_default>;
> +			pinctrl-1 = <&blsp2_i2c6_sleep>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   		};
> @@ -1256,7 +1266,7 @@ cd {
>   				};
>   			};
>   
> -			blsp1_uart2_active: blsp1-uart2-active {
> +			blsp1_uart2_default: blsp1-uart2-default {
>   				rx {
>   					pins = "gpio5";
>   					function = "blsp_uart2";
> @@ -1272,7 +1282,7 @@ tx {
>   				};
>   			};
>   
> -			blsp2_uart1_active: blsp2-uart1-active {
> +			blsp2_uart1_default: blsp2-uart1-default {
>   				tx-rts {
>   					pins = "gpio41", "gpio44";
>   					function = "blsp_uart7";
> @@ -1295,7 +1305,7 @@ blsp2_uart1_sleep: blsp2-uart1-sleep {
>   				bias-pull-down;
>   			};
>   
> -			blsp2_uart4_active: blsp2-uart4-active {
> +			blsp2_uart4_default: blsp2-uart4-default {
>   				tx-rts {
>   					pins = "gpio53", "gpio56";
>   					function = "blsp_uart10";
> @@ -1406,7 +1416,19 @@ blsp2_i2c5_sleep: blsp2-i2c5-sleep {
>   				bias-pull-up;
>   			};
>   
> -			/* BLSP2_I2C6 info is missing - nobody uses it though? */
> +			blsp2_i2c6_default: blsp2-i2c6-default {
> +				pins = "gpio87", "gpio88";
> +				function = "blsp_i2c12";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			blsp2_i2c6_sleep: blsp2-i2c6-sleep {
> +				pins = "gpio87", "gpio88";
> +				function = "blsp_i2c12";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
>   
>   			spi8_default: spi8_default {
>   				mosi {
