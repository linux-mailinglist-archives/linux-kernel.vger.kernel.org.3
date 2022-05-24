Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF915332DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbiEXVNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiEXVNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:13:53 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D454003
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:13:50 -0700 (PDT)
Received: from [10.1.250.9] (riviera.nat.ds.pw.edu.pl [194.29.137.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id ADAF33F6BE;
        Tue, 24 May 2022 23:36:03 +0200 (CEST)
Message-ID: <311a23c9-e31d-e20d-8ba9-80d3197e8d1d@somainline.org>
Date:   Tue, 24 May 2022 23:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add touchscreen to villager
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2022 22:48, Douglas Anderson wrote:
> This adds the touchscreen to the sc7280-herobrine-villager device
> tree. Note that the touchscreen on villager actually uses the reset
> line and thus we use the more specific "elan,ekth6915" compatible
> which allows us to specify the reset.
>
> The fact that villager's touchscreen uses the reset line can be
> contrasted against the touchscreen for CRD/herobrine-r1. On those
> boards, even though the touchscreen goes to the display, it's not
> hooked up to anything there.
>
> In order to keep the line parked on herobrine/CRD, we'll move the
> pullup from the qcard.dtsi file to the specific boards. This allows us
> to disable the pullup in the villager device tree since the pin is an
> output.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This uses bindings introduced in the patch ("dt-bindings: HID:
> i2c-hid: elan: Introduce bindings for Elan eKTH6915") [1].
>
> [1] https://lore.kernel.org/r/20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid
>
>   .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 11 ++++++++
>   .../qcom/sc7280-herobrine-herobrine-r1.dts    | 11 ++++++++
>   .../dts/qcom/sc7280-herobrine-villager-r0.dts | 25 +++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 -
>   4 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index a4ac33c4fd59..b79d84d7870a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -134,6 +134,17 @@ &sdhc_2 {
>   	status = "okay";
>   };
>   
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */

Please drop this line, this isn't msm-3.4. It's immediately obvious that 
if a pin is referenced by a label and it is not defined in this file 
(because otherwise it wouldn't be both defined and referenced here..), 
it comes from a previously included device tree.


> +
> +/*
> + * This pin goes to the display panel but then doesn't actually do anything
> + * on the panel itself (it doesn't connect to the touchscreen controller).
> + * We'll set a pullup here just to park the line.
> + */
> +&ts_rst_conn {
> +	bias-pull-up;
> +};
> +
>   /* PINCTRL - BOARD-SPECIFIC */
>   
>   /*
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index b69ca09d9bfb..c1647a85a371 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -128,6 +128,17 @@ &sdhc_2 {
>   	status = "okay";
>   };
>   
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */

Ditto


> +
> +/*
> + * This pin goes to the display panel but then doesn't actually do anything
> + * on the panel itself (it doesn't connect to the touchscreen controller).
> + * We'll set a pullup here just to park the line.
> + */
> +&ts_rst_conn {
> +	bias-pull-up;
> +};
> +
>   /* PINCTRL - BOARD-SPECIFIC */
>   
>   /*
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> index d3d6ffad4eff..950b69448109 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
> @@ -46,6 +46,25 @@ trackpad: trackpad@2c {
>   	};
>   };
>   
> +ts_i2c: &i2c13 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@10 {
> +		compatible = "elan,ekth6915";
> +		reg = <0x10>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
> +
> +		vcc33-supply = <&ts_avdd>;
> +	};
> +};
> +
>   &ap_sar_sensor_i2c {
>   	status = "okay";
>   };
> @@ -81,6 +100,12 @@ &sdhc_1 {
>   	status = "okay";
>   };
>   
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */

Ditto


> +
> +&ts_rst_conn {
> +	bias-disable;
> +};
> +
>   /* PINCTRL - BOARD-SPECIFIC */
>   
>   /*
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index d59002d4492e..404936c6bf20 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -604,7 +604,6 @@ ts_int_conn: ts-int-conn {
>   	ts_rst_conn: ts-rst-conn {
>   		pins = "gpio54";
>   		function = "gpio";
> -		bias-pull-up;

If you overwrite it where it should be overwritten, wouldn't it make 
more sense to leave bias-pull-up here as a default configuration for 
boards that don't have a peculiar routed-but-NC line?


Konrad

>   		drive-strength = <2>;
>   	};
>   };
>
