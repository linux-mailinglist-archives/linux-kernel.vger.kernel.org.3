Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1011574021
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGMXll convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Jul 2022 19:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGMXl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:41:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9552DC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:41:19 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oBlym-0008AU-FZ; Thu, 14 Jul 2022 01:41:16 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian =?ISO-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Date:   Thu, 14 Jul 2022 01:41:15 +0200
Message-ID: <12878108.O9o76ZdvQC@diego>
In-Reply-To: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Am Donnerstag, 14. Juli 2022, 00:22:23 CEST schrieb Christian Kohlschütter:
> mmc/SD-card initialization may sometimes fail on NanoPi r4s with
> "mmc1: problem reading SD Status register" /
> "mmc1: error -110 whilst initialising SD card"
> 
> Moreover, rebooting would also sometimes hang.
> 

Nit: here the commit message should continue with something like:
-----
This is caused by the vcc3v0-sd regulator referencing the wrong gpio.

Fix the regulator to use the correct pin and drop the always-on property.
-----
> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> index 8c0ff6c96e03..91789801ab03 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>  	vcc3v0_sd: vcc3v0-sd {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;

The interesting question would be how nano-pi-specific that gpio is.

I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple board types,
so can you check in schematics if gpio0-d6 is always used on all of them?

Thanks
Heiko

>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sdmmc0_pwr_h>;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		regulator-min-microvolt = <3000000>;
>  		regulator-max-microvolt = <3000000>;
>  		regulator-name = "vcc3v0_sd";
> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>  
>  	sdmmc {
>  		sdmmc0_det_l: sdmmc0-det-l {
> -			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
>  		};
>  
>  		sdmmc0_pwr_h: sdmmc0-pwr-h {
> 




