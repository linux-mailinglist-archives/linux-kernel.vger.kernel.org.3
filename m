Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A750D1D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiDXNIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiDXNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:08:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FE13DC3;
        Sun, 24 Apr 2022 06:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2282E60DF5;
        Sun, 24 Apr 2022 13:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C71C385A7;
        Sun, 24 Apr 2022 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650805529;
        bh=2X5hMs183RqeHSVY1PeHySg2Ltw/F1NKTy9wX+4K8bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMrftHpBO0GWHjcMWBNpkF88AXfqDai7dGL4dx8syqFGEuMWDsOJRnWdsiTuy5ezB
         NHCnrkUl8ZiFdWw8KVZqHgK4w3RESkC+3VAawZeFBDYOq7FQyPmvUGhDswxvN+xq8m
         YjnKShTMNpH5scZKDC1ChN55lQOdKUNbvv8CBVflgxvUWK1FvXk9Fr3DPbAKy/MH7d
         X4N+nqSa2WDgVjIMbIOJ3+cnqtnAYDAxIm/+iVjhLmHIvG4BchGyq9MkD7rmsmubcy
         NMA0gitQH1hpf3hvBUSIhTG2F07qUHfVSmdzyI7Bvsa9DoQmzIJuHT3gxq4yfHHw7z
         pWGJmFrCXg9vQ==
Date:   Sun, 24 Apr 2022 21:05:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/14] ARM: dts: imx6ull-colibri: add touchscreen
 device nodes
Message-ID: <20220424130522.GW391514@dragon>
References: <20220414085106.18621-1-marcel@ziswiler.com>
 <20220414085106.18621-6-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414085106.18621-6-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:50:57AM +0200, Marcel Ziswiler wrote:
> From: Denys Drozdov <denys.drozdov@toradex.com>
> 
> Move all Atmel nodes from the board-level into the main module-level
> device tree and prepare the device trees for use with Atmel MXT device
> tree overlays. Also, add required pinmux groups.
> 
> The common scheme for pin groups in touch screen overlays is as follows:
> - pinctrl_atmel_conn - SODIMM 106/107 pins for INT/RST signals (default)
> - pinctrl_atmel_adap - SODIMM   28/30 pins for INT/RST signals.
> 
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |  4 +-
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |  4 +-
>  arch/arm/boot/dts/imx6ull-colibri.dtsi        | 39 +++++++++++++------
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
> index 95a11b8bcbdb..5e55a6c820bc 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
> @@ -15,10 +15,10 @@ memory@80000000 {
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
> -		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio6 &pinctrl_gpio7>;
> +		&pinctrl_gpio4 &pinctrl_gpio6 &pinctrl_gpio7>;
>  };
>  
>  &iomuxc_snvs {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio2 &pinctrl_snvs_gpio3>;
> +	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio3>;
>  };
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> index 9f1e38282bee..6e8ddb07e11d 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> @@ -26,13 +26,13 @@ &cpu0 {
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
> -		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio7>;
> +		&pinctrl_gpio4 &pinctrl_gpio7>;
>  
>  };
>  
>  &iomuxc_snvs {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_snvs_gpio1 &pinctrl_snvs_gpio2>;
> +	pinctrl-0 = <&pinctrl_snvs_gpio1>;
>  };
>  
>  &usdhc2 {
> diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> index e619da3b00b3..b2345a5573f4 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> @@ -124,6 +124,19 @@ &i2c1 {
>  	pinctrl-1 = <&pinctrl_i2c1_gpio>;
>  	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	status = "okay";
> +
> +	/* Atmel maxtouch controller */
> +	atmel_mxt_ts: touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_atmel_conn>;
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;       /* SODIMM_107, INT */
> +		reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;   /* SODIMM_106, RST */
> +		status = "disabled";
> +	};
>  };
>  
>  &i2c2 {
> @@ -241,6 +254,20 @@ MX6UL_PAD_GPIO1_IO09__GPIO1_IO09        0x3000 /* SODIMM 2 */
>  		>;
>  	};
>  
> +	pinctrl_atmel_adap: atmel_adap_group {

Use hyphen instead of underscore in node name, and try to keep the
naming style consistent with other pinctrl nodes.

Shawn

> +		fsl,pins = <
> +			MX6UL_PAD_NAND_DQS__GPIO4_IO16          0xb0a0  /* SODIMM 28 */
> +			MX6UL_PAD_ENET1_TX_EN__GPIO2_IO05       0xb0a0  /* SODIMM 30 */
> +		>;
> +	};
> +
> +	pinctrl_atmel_conn: atmel_conn_group {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_MOD__GPIO1_IO10          0xb0a0  /* SODIMM 106 */
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04     0xb0a0	/* SODIMM 107 */
> +		>;
> +	};
> +
>  	pinctrl_can_int: canint-grp {
>  		fsl,pins = <
>  			MX6UL_PAD_ENET1_TX_DATA1__GPIO2_IO04	0x13010	/* SODIMM 73 */
> @@ -347,12 +374,6 @@ MX6UL_PAD_CSI_DATA07__GPIO4_IO28	0x10b0 /* SODIMM 65 */
>  		>;
>  	};
>  
> -	pinctrl_gpio5: gpio5-grp { /* ATMEL MXT TOUCH */
> -		fsl,pins = <
> -			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0xb0a0 /* SODIMM 106 */
> -		>;
> -	};
> -
>  	pinctrl_gpio6: gpio6-grp { /* Wifi pins */
>  		fsl,pins = <
>  			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0x10b0 /* SODIMM 89 */
> @@ -606,12 +627,6 @@ MX6ULL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x110a0	/* SODIMM 138 */
>  		>;
>  	};
>  
> -	pinctrl_snvs_gpio2: snvs-gpio2-grp { /* ATMEL MXT TOUCH */
> -		fsl,pins = <
> -			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0xb0a0	/* SODIMM 107 */
> -		>;
> -	};
> -
>  	pinctrl_snvs_gpio3: snvs-gpio3-grp { /* Wifi pins */
>  		fsl,pins = <
>  			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x130a0	/* SODIMM 127 */
> -- 
> 2.35.1
> 
