Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8245AFEED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIGI0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:26:36 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408B5A0626;
        Wed,  7 Sep 2022 01:26:33 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oVqO6-00042j-Sn; Wed, 07 Sep 2022 10:26:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <kc@postmarketos.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Date:   Wed, 07 Sep 2022 10:26:21 +0200
Message-ID: <46977559.XUcTiDjVJD@diego>
In-Reply-To: <57395b20-6352-8414-3078-cdad6bbbe999@postmarketos.org>
References: <Rk3c--Dksit7gaQSddtVEaF5_7FlNYE4KZKQKaLsRu2GXMXoBgp5C2DSPNublHMr6E135nPS2B9JkQyf6aSZjw==@protonmail.internalid> <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk> <57395b20-6352-8414-3078-cdad6bbbe999@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 6. September 2022, 19:38:38 CEST schrieb Caleb Connolly:
> 
> On 06/09/2022 13:47, Tom Fitzhenry wrote:
> > Pinephone Pro includes a AzureWave AW-CM256SM wifi (sdio0) and
> > bt (uart0) combo module, which is based on Cypress
> > CYP43455 (BCM43455).
> > 
> > Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> > ---
> >   .../dts/rockchip/rk3399-pinephone-pro.dts     | 69 +++++++++++++++++++
> >   1 file changed, 69 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > index 2e058c3150256..096238126e4c1 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> > @@ -43,6 +43,20 @@ key-power {
> >   		};
> >   	};
> > 
> > +	/* Power sequence for SDIO WiFi module */
> 
> This comment isn't needed, instead give the node a better name/label
> > +	sdio_pwrseq: sdio-pwrseq {
> 
> 	wifi_pwrseq: sdio-pwrseq-wifi {

I guess, I'd move the components around a tiny bit and go with

	wifi_pwrseq: sdio-wifi-pwrseq {

So far everywhere the "-pwrseq" is at the end and while I don't
think that this is enforced (yet), keeping some sort of consistency
might be nice :-) 


Heiko


> > +		compatible = "mmc-pwrseq-simple";
> > +		clocks = <&rk818 1>;
> > +		clock-names = "ext_clock";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&wifi_enable_h_pin>;
> > +		post-power-on-delay-ms = <100>;
> > +		power-off-delay-us = <500000>;
> > +
> > +		/* WL_REG_ON on module */
> > +		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> >   	vcc_sys: vcc-sys-regulator {
> >   		compatible = "regulator-fixed";
> >   		regulator-name = "vcc_sys";
> > @@ -360,11 +374,31 @@ vsel2_pin: vsel2-pin {
> >   		};
> >   	};
> > 
> > +	sdio-pwrseq {
> > +		wifi_enable_h_pin: wifi-enable-h-pin {
> > +			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> > +
> >   	sound {
> >   		vcc1v8_codec_en: vcc1v8-codec-en {
> >   			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
> >   		};
> >   	};
> > +
> > +	wireless-bluetooth {
> > +		bt_wake_pin: bt-wake-pin {
> > +			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		bt_host_wake_pin: bt-host-wake-pin {
> > +			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +
> > +		bt_reset_pin: bt-reset-pin {
> > +			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> > +		};
> > +	};
> >   };
> > 
> >   &sdmmc {
> > @@ -380,6 +414,20 @@ &sdmmc {
> >   	status = "okay";
> >   };
> > 
> > +&sdio0 {
> > +	bus-width = <4>;
> > +	cap-sd-highspeed;
> > +	cap-sdio-irq;
> > +	disable-wp;
> > +	keep-power-in-suspend;
> > +	mmc-pwrseq = <&sdio_pwrseq>;
> > +	non-removable;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> > +	sd-uhs-sdr104;
> > +	status = "okay";
> > +};
> > +
> >   &sdhci {
> >   	bus-width = <8>;
> >   	mmc-hs200-1_8v;
> > @@ -393,6 +441,27 @@ &tsadc {
> >   	status = "okay";
> >   };
> > 
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> > +	uart-has-rtscts;
> > +	status = "okay";
> > +
> > +	bluetooth {
> > +		compatible = "brcm,bcm4345c5";
> > +		clocks = <&rk818 1>;
> > +		clock-names = "lpo";
> > +		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
> > +		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> > +		max-speed = <1500000>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&bt_host_wake_pin &bt_wake_pin &bt_reset_pin>;
> > +		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> > +		vbat-supply = <&vcc3v3_sys>;
> > +		vddio-supply = <&vcc_1v8>;
> > +	};
> > +};
> > +
> >   &uart2 {
> >   	status = "okay";
> >   };
> > --
> > 2.37.1
> > 
> 




