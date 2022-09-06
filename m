Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437265AEBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiIFOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiIFOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:01:33 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D01057F;
        Tue,  6 Sep 2022 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1662471339; bh=CGyEzQ7Ohr5A/cWCuHJ4L2zyjQiyb+aYxH/EYO9OTGU=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=PvaKeuuyqsDS6jTFvvDc+oQyBZ900VRvVuiY9zEzWgmQT2bghS1tGDnZtAfNrqt7m
         4RmcEsomUuSZM/1n/E7qULITo1PFJMgVP95voEjg4QO00/noepJqEaKyKXghW8eI2O
         K2NtwwAVGZ8J/TnTs+7PaCHZGbTUqfeR2mGac+CI=
Date:   Tue, 6 Sep 2022 15:35:39 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Message-ID: <20220906133539.6ghjlzbs2ozgsa7v@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tom,

On Tue, Sep 06, 2022 at 10:47:13PM +1000, Tom Fitzhenry wrote:
> Pinephone Pro includes a AzureWave AW-CM256SM wifi (sdio0) and
> bt (uart0) combo module, which is based on Cypress
> CYP43455 (BCM43455).
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>  .../dts/rockchip/rk3399-pinephone-pro.dts     | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index 2e058c3150256..096238126e4c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -43,6 +43,20 @@ key-power {
>  		};
>  	};
>  
> +	/* Power sequence for SDIO WiFi module */
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&rk818 1>;
> +		clock-names = "ext_clock";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h_pin>;
> +		post-power-on-delay-ms = <100>;
> +		power-off-delay-us = <500000>;

Do we really need such long delays? Almost no boards in rockchip/ use such
delays at all, and if they do they don't usually use power off delay.

> +		/* WL_REG_ON on module */
> +		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	vcc_sys: vcc-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc_sys";
> @@ -360,11 +374,31 @@ vsel2_pin: vsel2-pin {
>  		};
>  	};
>  
> +	sdio-pwrseq {
> +		wifi_enable_h_pin: wifi-enable-h-pin {
> +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
>  	sound {
>  		vcc1v8_codec_en: vcc1v8-codec-en {
>  			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
>  		};
>  	};
> +
> +	wireless-bluetooth {
> +		bt_wake_pin: bt-wake-pin {
> +			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_host_wake_pin: bt-host-wake-pin {
> +			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +
> +		bt_reset_pin: bt-reset-pin {
> +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
>  };
>  
>  &sdmmc {

see below

> @@ -380,6 +414,20 @@ &sdmmc {
>  	status = "okay";
>  };
>  
> +&sdio0 {

sd'i'o0 comes before 'm' in the alphabet.

> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;
> +	keep-power-in-suspend;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +	sd-uhs-sdr104;
> +	status = "okay";

It might also be good to add the wifi node, and hookup the interrupt line and
pinctrls, so that WoW works, while you're at it.

See eg. https://elixir.bootlin.com/linux/v5.19.7/source/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts#L30

Looks like WIFI_HOST_WAKE_L is hooked to GPIO4_D0/PCIE_CLKREQnB_u according
to the schematic. Let's hope GPIO4_D will consider 1.8V as high, because SoC
GPIO4_D is in 3.0V domain and VDDIO of wifi chip is 1.8V.

Other than that,

Reviewed-by: Ondřej Jirman <megi@xff.cz>

Thank you and kind regards,
	o.
