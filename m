Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D62523DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347033AbiEKThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347025AbiEKThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:37:04 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740C6D1B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:37:00 -0700 (PDT)
Received: from [192.168.1.101] (abxh168.neoplus.adsl.tpnet.pl [83.9.1.168])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B829D3F8BC;
        Wed, 11 May 2022 21:36:58 +0200 (CEST)
Message-ID: <5f4a1d96-84e1-0387-dee1-e65e9c459051@somainline.org>
Date:   Wed, 11 May 2022 21:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974-sony: Enable LPG
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
 <20220504205411.1510667-2-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220504205411.1510667-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2022 22:54, Bjorn Andersson wrote:
> Both Castor and Honami has RGB LEDs driven by the PM8941 LPG, define
> these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 30 +++++++++++++++++++
>  ...-msm8974pro-sony-xperia-shinano-castor.dts | 30 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> index 1d21de46f85c..9891d0d40945 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
> @@ -3,6 +3,7 @@
>  #include "qcom-pm8841.dtsi"
>  #include "qcom-pm8941.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  / {
> @@ -172,6 +173,35 @@ gpio_keys_pin_a: gpio-keys-active {
>  	};
>  };
>  
> +&pm8941_lpg {
> +	status = "okay";
> +
> +	qcom,power-source = <1>;
> +
> +	rgb-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <7>;
Hi,

please sync regs and unit addresses (and sort them while at it).

Konrad
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@2 {
> +			reg = <6>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@3 {
> +			reg = <5>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +};
> +
>  &pm8941_wled {
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> index 9bd8faea61a5..da1593192306 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> @@ -3,6 +3,7 @@
>  #include "qcom-pm8841.dtsi"
>  #include "qcom-pm8941.dtsi"
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  
>  / {
> @@ -288,6 +289,35 @@ lcd_dcdc_en_pin_a: lcd-dcdc-en-active {
>  
>  };
>  
> +&pm8941_lpg {
> +	status = "okay";
> +
> +	qcom,power-source = <1>;
> +
> +	rgb-led {
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_STATUS;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@1 {
> +			reg = <7>;
> +			color = <LED_COLOR_ID_RED>;
> +		};
> +
> +		led@2 {
> +			reg = <6>;
> +			color = <LED_COLOR_ID_GREEN>;
> +		};
> +
> +		led@3 {
> +			reg = <5>;
> +			color = <LED_COLOR_ID_BLUE>;
> +		};
> +	};
> +};
> +
>  &rpm_requests {
>  	pm8941-regulators {
>  		compatible = "qcom,rpm-pm8941-regulators";
> 
