Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE91468F80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbhLFDHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:07:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbhLFDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:07:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74413B80EE3;
        Mon,  6 Dec 2021 03:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911BFC00446;
        Mon,  6 Dec 2021 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638759833;
        bh=hqhG2Y9st+pVq0sURpovbuLgs/PcAjMH+0qgkDxyZBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfJdR9r58mmPGF44Jyo/fLSCKZx7fnFibjC0ElMOhr0sBOc+IiLPIHDUJBXZ2Bdy0
         kCHYZmB3UOS8z3ZMb+RIuvKpZKnrHYn2WfwVMapUT1U/jMdILU+3462G0ye2w6y8DA
         7zH11TQ0ICZ8UXYmxeMHRvcbRhJL/kuvcF0D+Yx0kRkRYle74FWAUNBbplDmdJ7xwk
         fzaIFioLwPwVNS//xBR2TjjB1zVBIcgbARV9SA4Z10XpfNuNRtzvqmqFGGhuAiP3cK
         nZ8bWWNSJ6QtSWMaAGCuHsKsw4JT3m7HErmSADYQHwFhE606IooH2n9+a3f3uAngNq
         r5kyIh1NPaEWg==
Date:   Mon, 6 Dec 2021 11:03:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     benjamin.tissoires@redhat.com, s.hauer@pengutronix.de,
        dmitry.torokhov@gmail.com, Ping.Cheng@wacom.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        alistair23@gmail.com, tatsunosuke.tobita@wacom.com,
        linux-input@vger.kernel.org, Jason.Gerecke@wacom.com,
        linux-kernel@vger.kernel.org, jikos@kernel.org,
        martin.chen@wacom.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 3/3] ARM: dts: imx7d: remarkable2: add wacom
 digitizer device
Message-ID: <20211206030343.GA4216@dragon>
References: <20211202115622.40153-1-alistair@alistair23.me>
 <20211202115622.40153-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202115622.40153-4-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 09:56:22PM +1000, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Please write up some commit log.

Shawn

> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 59 +++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 89cbf13097a4..a2a91bfdd98e 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -34,6 +34,19 @@ reg_brcm: regulator-brcm {
>  		startup-delay-us = <150>;
>  	};
>  
> +	reg_digitizer: regulator-digitizer {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_3V3_DIGITIZER";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&pinctrl_digitizer_reg>;
> +		pinctrl-1 = <&pinctrl_digitizer_reg>;
> +		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <100000>; /* 100 ms */
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> @@ -51,6 +64,26 @@ &clks {
>  	assigned-clock-rates = <0>, <32768>;
>  };
>  
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	wacom_digitizer: digitizer@9 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x09>;
> +		hid-descr-addr = <0x01>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wacom>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +		vdd-supply = <&reg_digitizer>;
> +	};
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -117,6 +150,25 @@ &wdog1 {
>  	fsl,ext-reset-output;
>  };
>  
> +&iomuxc_lpsr {
> +	pinctrl_digitizer_reg: digitizerreggrp {
> +		fsl,pins = <
> +			/* DIGITIZER_PWR_EN */
> +			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14
> +		>;
> +	};
> +
> +	pinctrl_wacom: wacomgrp {
> +		fsl,pins = <
> +			/*MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x00000014 FWE */
> +			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x00000074 /* PDCTB */
> +			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
> +			/*MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x00000014 WACOM PWR ENABLE */
> +			/*MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x00000074 WACOM RESET */
> +		>;
> +	};
> +};
> +
>  &iomuxc {
>  	pinctrl_brcm_reg: brcmreggrp {
>  		fsl,pins = <
> @@ -125,6 +177,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
>  		>;
>  	};
>  
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> +			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> -- 
> 2.31.1
> 
