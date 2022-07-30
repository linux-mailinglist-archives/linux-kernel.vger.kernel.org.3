Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97CC585C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbiG3Uxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiG3Uxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 16:53:45 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6711659A;
        Sat, 30 Jul 2022 13:53:43 -0700 (PDT)
Received: from [192.168.1.101] (abxi232.neoplus.adsl.tpnet.pl [83.9.2.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 18BD13F70B;
        Sat, 30 Jul 2022 22:53:39 +0200 (CEST)
Message-ID: <c074cd3f-3398-f0ff-bbca-5e7ff157cc7e@somainline.org>
Date:   Sat, 30 Jul 2022 22:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: Add LID
 switch
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.07.2022 21:36, Bjorn Andersson wrote:
> Add gpio-keys for exposing the LID switch state.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 84dc92dda0b8..f3246cc13d15 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -7,6 +7,8 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "sc8280xp.dtsi"
> @@ -26,6 +28,21 @@ backlight {
>  		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_int_state>;
> +
> +		switch-lid {
> +			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
>  	vreg_edp_bl: regulator-edp-bl {
>  		compatible = "regulator-fixed";
>  
> @@ -347,6 +364,14 @@ reset {
>  		};
>  	};
>  
> +	hall_int_state: hall-int-state {
> +		pins = "gpio107";
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-disable;
> +	};
> +
>  	qup0_i2c4_default: qup0-i2c4-default-state {
>  		pins = "gpio171", "gpio172";
>  		function = "qup4";
