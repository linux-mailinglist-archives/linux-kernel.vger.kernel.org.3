Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFD4704E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbhLJPxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbhLJPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:52:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF0C08EA76;
        Fri, 10 Dec 2021 07:46:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t9so15609336wrx.7;
        Fri, 10 Dec 2021 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V8dbMLdLeFN1Yp4W56MxB9vLr2wQ/s5ZM4A7eRTdO2g=;
        b=d/HX/pYMRgqgBtHOZlTH/3rCyaiuYSR/jy3AOw+WihtWxhBsqXCMPwJR2gUfrmwOEz
         /LquJWodpKakpw1c62swvB9tmohICsolmqHVDWhL3KUbuBDiX31Fr98fgrd4VfrhA1iC
         m26LkR2MudBnJwqYJMqaiu/YAvjnhhoXgqe3J2lNBk8Nm9gcYZNWFRIp7O80F7JGVWoN
         4IePWlyxZCPxZhbRSY18R0iks2oZxXhtjNZ9wkZGQ5R9OQBgC2TNw3xlTTN7VKDNgPGz
         t9mU8EMsTPeMCXyNMkzx02MIcuyhelzgnYT9qsO8Z7B2b4/abcF0fZlFnLAHx0cYOGrZ
         ZB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V8dbMLdLeFN1Yp4W56MxB9vLr2wQ/s5ZM4A7eRTdO2g=;
        b=Y7SKSW+Jdl5I7c0LP97QgGjt9KgwkKd5NbFQ0j/i1Qw27wR9N3SwOE55ItwUX1rTUs
         dYUNKx0Ac5Nm+TQF9fpyaCkPfyW8fc+/57h0DNbbRTZbKSWnNTIcJhO8bwGx9oeF8DIW
         1sD+4OwESsPqZpzxrucrujUrlRxkd+VeI70dGxoBj+XyXn1aLou3JNqceiMuBob3RDHH
         hpNEx+oSBS6Zixke6cqcFE5eIExiVbvoHSrLHeVn5GrgtWrwO3KfSrfPIYVNHey6q/Av
         VVV07fqgMS5YJdhKe1UjB8qAvmixY250UvB1q2medqg8FtT6SCfo5TrUukTfhb+yIDUk
         a6nw==
X-Gm-Message-State: AOAM53055Lo+RZM+QwbWHxpgF9MjgRQOQX88PX+82LsA4eXeuokxGKuZ
        Q5YVjiQdf5yxnIBqKrwOQ50=
X-Google-Smtp-Source: ABdhPJznvYqGalIXosxWrvn+3E7JX8HTe5uaGcyXZphYEcQRwUVwawsZwfoVqd/5IDV2B1456U5xDg==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr14647872wrv.13.1639151188591;
        Fri, 10 Dec 2021 07:46:28 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id t11sm2862767wrz.97.2021.12.10.07.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:46:27 -0800 (PST)
Date:   Fri, 10 Dec 2021 16:46:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/24] ARM: tegra: Add device-tree for ASUS
 Transformer EeePad TF101
Message-ID: <YbN2T5guOfIRLXg1@orome>
References: <20211208173609.4064-1-digetx@gmail.com>
 <20211208173609.4064-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IZW3MBWVDgtX5YyB"
Content-Disposition: inline
In-Reply-To: <20211208173609.4064-6-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IZW3MBWVDgtX5YyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 08:35:50PM +0300, Dmitry Osipenko wrote:
> From: Nikola Milosavljevic <mnidza@outlook.com>
>=20
> Add device-tree for Tegra20-based ASUS Transformer EeePad TF101.
>=20
> Link: https://wiki.postmarketos.org/wiki/ASUS_Eee_Pad_Transformer_(asus-t=
f101)
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Co-developed-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> Signed-off-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> Signed-off-by: Nikola Milosavljevic <mnidza@outlook.com>
> Co-developed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile               |    1 +
>  arch/arm/boot/dts/tegra20-asus-tf101.dts | 1191 ++++++++++++++++++++++
>  2 files changed, 1192 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tegra20-asus-tf101.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8a2dfdf01ce3..8fdebf7c1afe 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1304,6 +1304,7 @@ dtb-$(CONFIG_MACH_SUNIV) +=3D \
>  	suniv-f1c100s-licheepi-nano.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) +=3D \
>  	tegra20-acer-a500-picasso.dtb \
> +	tegra20-asus-tf101.dtb \
>  	tegra20-harmony.dtb \
>  	tegra20-colibri-eval-v3.dtb \
>  	tegra20-colibri-iris.dtb \
> diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts=
/tegra20-asus-tf101.dts
> new file mode 100644
> index 000000000000..4dc0722c28f5
> --- /dev/null
> +++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
> @@ -0,0 +1,1191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +#include <dt-bindings/input/atmel-maxtouch.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +#include "tegra20.dtsi"
> +#include "tegra20-cpu-opp.dtsi"
> +#include "tegra20-cpu-opp-microvolt.dtsi"
> +
> +/ {
> +	model =3D "ASUS EeePad Transformer TF101";
> +	compatible =3D "asus,tf101", "nvidia,tegra20";
> +	chassis-type =3D "convertible";
> +
> +	aliases {
> +		mmc0 =3D &sdmmc4; /* eMMC */
> +		mmc1 =3D &sdmmc3; /* MicroSD */
> +		mmc2 =3D &sdmmc1; /* WiFi */
> +
> +		rtc0 =3D &pmic;
> +		rtc1 =3D "/rtc@7000e000";
> +
> +		serial0 =3D &uartd;
> +		serial1 =3D &uartc; /* Bluetooth */
> +		serial2 =3D &uartb; /* GPS */
> +	};
> +
> +	/*
> +	 * The decompressor and also some bootloaders rely on a
> +	 * pre-existing /chosen node to be available to insert the
> +	 * command line and merge other ATAGS info.
> +	 */
> +	chosen {};
> +
> +	memory@0 {
> +		reg =3D <0x00000000 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		ramoops@2ffe0000 {
> +			compatible =3D "ramoops";
> +			reg =3D <0x2ffe0000 0x10000>;	/* 64kB */
> +			console-size =3D <0x8000>;	/* 32kB */
> +			record-size =3D <0x400>;		/*  1kB */
> +			ecc-size =3D <16>;
> +		};
> +
> +		linux,cma@30000000 {
> +			compatible =3D "shared-dma-pool";
> +			alloc-ranges =3D <0x30000000 0x10000000>;
> +			size =3D <0x10000000>; /* 256MiB */
> +			linux,cma-default;
> +			reusable;
> +		};
> +	};
> +
> +	host1x@50000000 {
> +		dc@54200000 {
> +			rgb {
> +				status =3D "okay";
> +
> +				port@0 {
> +					lcd_output: endpoint {
> +						remote-endpoint =3D <&lvds_encoder_input>;
> +						bus-width =3D <18>;
> +					};
> +				};
> +			};
> +		};
> +
> +		hdmi@54280000 {
> +			status =3D "okay";
> +
> +			vdd-supply =3D <&hdmi_vdd_reg>;
> +			pll-supply =3D <&hdmi_pll_reg>;
> +			hdmi-supply =3D <&vdd_hdmi_en>;
> +
> +			nvidia,ddc-i2c-bus =3D <&hdmi_ddc>;
> +			nvidia,hpd-gpio =3D <&gpio TEGRA_GPIO(N, 7)
> +				GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio@6000d000 {
> +		charging-enable-hog {
> +			gpio-hog;
> +			gpios =3D <TEGRA_GPIO(R, 6) GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +	};

Isn't this something that we may want to change at some point? My
understanding is that GPIO hogs are permanent, so it won't be possible
to grab GPIO R.6 and change this.

Are there any plans to allow setting this at runtime?

[...]
> +	i2c2: i2c@7000c400 {
> +		status =3D "okay";
> +		clock-frequency =3D <100000>;
> +	};
> +
> +	i2cmux {

This doesn't belong here. The ordering is by unit-address and everything
without unit-address needs to move after the nodes with unit-addresses
and be sorted alphabetically.

> +		compatible =3D "i2c-mux-pinctrl";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		i2c-parent =3D <&i2c2>;
> +
> +		pinctrl-names =3D "ddc", "pta", "idle";
> +		pinctrl-0 =3D <&state_i2cmux_ddc>;
> +		pinctrl-1 =3D <&state_i2cmux_pta>;
> +		pinctrl-2 =3D <&state_i2cmux_idle>;
> +
> +		hdmi_ddc: i2c@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		lvds_ddc: i2c@1 {
> +			reg =3D <1>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			smart-battery@b {
> +				compatible =3D "ti,bq20z75", "sbs,sbs-battery";
> +				reg =3D <0xb>;
> +				sbs,i2c-retry-count =3D <2>;
> +				sbs,poll-retry-count =3D <10>;
> +				power-supplies =3D <&mains>;
> +			};
> +		};
> +	};
> +
> +	i2c@7000c500 {
> +		status =3D "okay";
> +		clock-frequency =3D <400000>;
> +	};
> +
> +	i2c@7000d000 {
> +		status =3D "okay";
> +		clock-frequency =3D <400000>;
> +
> +		pmic: pmic@34 {
> +			compatible =3D "ti,tps6586x";
> +			reg =3D <0x34>;
> +			interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			ti,system-power-controller;
> +
> +			#gpio-cells =3D <2>;
> +			gpio-controller;
> +
> +			sys-supply =3D <&vdd_5v0_sys>;
> +			vin-sm0-supply =3D <&sys_reg>;
> +			vin-sm1-supply =3D <&sys_reg>;
> +			vin-sm2-supply =3D <&sys_reg>;
> +			vinldo01-supply =3D <&sm2_reg>;
> +			vinldo23-supply =3D <&sm2_reg>;
> +			vinldo4-supply =3D <&sm2_reg>;
> +			vinldo678-supply =3D <&sm2_reg>;
> +			vinldo9-supply =3D <&sm2_reg>;
> +
> +			regulators {
> +				sys_reg: sys {
> +					regulator-name =3D "vdd_sys";
> +					regulator-always-on;
> +				};
> +
> +				vdd_core: sm0 {
> +					regulator-name =3D "vdd_sm0,vdd_core";
> +					regulator-min-microvolt =3D <950000>;
> +					regulator-max-microvolt =3D <1300000>;
> +					regulator-coupled-with =3D <&rtc_vdd &vdd_cpu>;
> +					regulator-coupled-max-spread =3D <170000 550000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +
> +					nvidia,tegra-core-regulator;
> +				};
> +
> +				vdd_cpu: sm1 {
> +					regulator-name =3D "vdd_sm1,vdd_cpu";
> +					regulator-min-microvolt =3D <750000>;
> +					regulator-max-microvolt =3D <1125000>;
> +					regulator-coupled-with =3D <&vdd_core &rtc_vdd>;
> +					regulator-coupled-max-spread =3D <550000 550000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +
> +					nvidia,tegra-cpu-regulator;
> +				};
> +
> +				sm2_reg: sm2 {
> +					regulator-name =3D "vdd_sm2,vin_ldo*";
> +					regulator-min-microvolt =3D <3700000>;
> +					regulator-max-microvolt =3D <3700000>;
> +					regulator-always-on;
> +				};
> +
> +				/* LDO0 is not connected to anything */
> +
> +				ldo1 {
> +					regulator-name =3D "vdd_ldo1,avdd_pll*";
> +					regulator-min-microvolt =3D <1100000>;
> +					regulator-max-microvolt =3D <1100000>;
> +					regulator-always-on;
> +				};
> +
> +				rtc_vdd: ldo2 {
> +					regulator-name =3D "vdd_ldo2,vdd_rtc";
> +					regulator-min-microvolt =3D <950000>;
> +					regulator-max-microvolt =3D <1300000>;
> +					regulator-coupled-with =3D <&vdd_core &vdd_cpu>;
> +					regulator-coupled-max-spread =3D <170000 550000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +
> +					nvidia,tegra-rtc-regulator;
> +				};
> +
> +				ldo3 {
> +					regulator-name =3D "vdd_ldo3,avdd_usb*";
> +					regulator-min-microvolt =3D <3300000>;
> +					regulator-max-microvolt =3D <3300000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo4 {
> +					regulator-name =3D "vdd_ldo4,avdd_osc,vddio_sys";
> +					regulator-min-microvolt =3D <1800000>;
> +					regulator-max-microvolt =3D <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				vcore_emmc: ldo5 {
> +					regulator-name =3D "vdd_ldo5,vcore_mmc";
> +					regulator-min-microvolt =3D <2850000>;
> +					regulator-max-microvolt =3D <2850000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo6 {
> +					regulator-name =3D "vdd_ldo6,avdd_vdac";
> +					regulator-min-microvolt =3D <1800000>;
> +					regulator-max-microvolt =3D <1800000>;
> +				};
> +
> +				hdmi_vdd_reg: ldo7 {
> +					regulator-name =3D "vdd_ldo7,avdd_hdmi,vdd_fuse";
> +					regulator-min-microvolt =3D <3300000>;
> +					regulator-max-microvolt =3D <3300000>;
> +				};
> +
> +				hdmi_pll_reg: ldo8 {
> +					regulator-name =3D "vdd_ldo8,avdd_hdmi_pll";
> +					regulator-min-microvolt =3D <1800000>;
> +					regulator-max-microvolt =3D <1800000>;
> +				};
> +
> +				ldo9 {
> +					regulator-name =3D "vdd_ldo9,avdd_2v85,vdd_ddr_rx";
> +					regulator-min-microvolt =3D <2850000>;
> +					regulator-max-microvolt =3D <2850000>;
> +					regulator-always-on;
> +				};
> +
> +				ldo_rtc {
> +					regulator-name =3D "vdd_rtc_out,vdd_cell";
> +					regulator-min-microvolt =3D <3300000>;
> +					regulator-max-microvolt =3D <3300000>;
> +					regulator-always-on;
> +				};
> +			};
> +		};
> +
> +		nct1008: temperature-sensor@4c {
> +			compatible =3D "onnn,nct1008";
> +			reg =3D <0x4c>;
> +			vcc-supply =3D <&vdd_3v3_sys>;
> +
> +			interrupt-parent =3D <&gpio>;
> +			interrupts =3D <TEGRA_GPIO(N, 6) IRQ_TYPE_EDGE_FALLING>;
> +
> +			#thermal-sensor-cells =3D <1>;
> +		};
> +	};
> +
> +	pmc@7000e400 {
> +		nvidia,invert-interrupt;
> +		nvidia,suspend-mode =3D <1>;
> +		nvidia,cpu-pwr-good-time =3D <2000>;
> +		nvidia,cpu-pwr-off-time =3D <100>;
> +		nvidia,core-pwr-good-time =3D <3845 3845>;
> +		nvidia,core-pwr-off-time =3D <458>;
> +		nvidia,sys-clock-req-active-high;
> +		core-supply =3D <&vdd_core>;
> +	};
> +
> +	/* Peripheral USB via ASUS connector */
> +	usb@c5000000 {
> +		compatible =3D "nvidia,tegra20-udc";
> +		status =3D "okay";
> +		dr_mode =3D "peripheral";
> +	};
> +
> +	usb-phy@c5000000 {
> +		status =3D "okay";
> +		dr_mode =3D "peripheral";
> +		nvidia,xcvr-setup-use-fuses;
> +		nvidia,xcvr-lsfslew =3D <2>;
> +		nvidia,xcvr-lsrslew =3D <2>;
> +		vbus-supply =3D <&vdd_5v0_sys>;
> +	};
> +
> +	/* Dock's USB port */
> +	usb@c5008000 {
> +		status =3D "okay";
> +	};
> +
> +	usb-phy@c5008000 {
> +		status =3D "okay";
> +		nvidia,xcvr-setup-use-fuses;
> +		vbus-supply =3D <&vdd_5v0_sys>;
> +	};
> +
> +	brcm_wifi_pwrseq: wifi-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +
> +		clocks =3D <&tegra_pmc TEGRA_PMC_CLK_BLINK>;
> +		clock-names =3D "ext_clock";
> +
> +		reset-gpios =3D <&gpio TEGRA_GPIO(K, 6) GPIO_ACTIVE_LOW>;
> +		post-power-on-delay-ms =3D <200>;
> +		power-off-delay-us =3D <200>;
> +	};
> +
> +	sdmmc1: mmc@c8000000 {
> +		status =3D "okay";
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		assigned-clocks =3D <&tegra_car TEGRA20_CLK_SDMMC1>;
> +		assigned-clock-parents =3D <&tegra_car TEGRA20_CLK_PLL_C>;
> +		assigned-clock-rates =3D <40000000>;
> +
> +		max-frequency =3D <40000000>;
> +		keep-power-in-suspend;
> +		bus-width =3D <4>;
> +		non-removable;
> +
> +		mmc-pwrseq =3D <&brcm_wifi_pwrseq>;
> +		vmmc-supply =3D <&vdd_3v3_sys>;
> +		vqmmc-supply =3D <&vdd_3v3_sys>;
> +
> +		/* Azurewave AW-NH615 BCM4329B1 */
> +		wifi@1 {
> +			compatible =3D "brcm,bcm4329-fmac";
> +			reg =3D <1>;
> +
> +			interrupt-parent =3D <&gpio>;
> +			interrupts =3D <TEGRA_GPIO(S, 0) IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "host-wake";
> +		};
> +	};
> +
> +	sdmmc3: mmc@c8000400 {
> +		status =3D "okay";
> +		bus-width =3D <4>;
> +		cd-gpios =3D <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
> +		wp-gpios =3D <&gpio TEGRA_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
> +		power-gpios =3D <&gpio TEGRA_GPIO(I, 6) GPIO_ACTIVE_HIGH>;
> +		vmmc-supply =3D <&vdd_3v3_sys>;
> +		vqmmc-supply =3D <&vdd_3v3_sys>;
> +	};
> +
> +	sdmmc4: mmc@c8000600 {
> +		status =3D "okay";
> +		bus-width =3D <8>;
> +		vmmc-supply =3D <&vcore_emmc>;
> +		vqmmc-supply =3D <&vdd_3v3_sys>;
> +		non-removable;
> +	};
> +
> +	mains: ac-adapter-detect {
> +		compatible =3D "gpio-charger";
> +		charger-type =3D "mains";
> +		gpios =3D <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_LOW>;
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +
> +		enable-gpios =3D <&gpio TEGRA_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
> +		power-supply =3D <&vdd_3v3_sys>;
> +		pwms =3D <&pwm 2 4000000>;
> +
> +		brightness-levels =3D <7 255>;
> +		num-interpolated-steps =3D <248>;
> +		default-brightness-level =3D <20>;
> +	};
> +
> +	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
> +	clk32k_in: clock-32k-in {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <32768>;
> +		#clock-cells =3D <0>;
> +	};
> +
> +	cpus {
> +		cpu0: cpu@0 {
> +			cpu-supply =3D <&vdd_cpu>;
> +			operating-points-v2 =3D <&cpu0_opp_table>;
> +			#cooling-cells =3D <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			cpu-supply =3D <&vdd_cpu>;
> +			operating-points-v2 =3D <&cpu0_opp_table>;
> +			#cooling-cells =3D <2>;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible =3D "gpio-keys";
> +
> +		dock-hall-sensor {
> +			label =3D "Lid";
> +			gpios =3D <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_LID>;
> +			debounce-interval =3D <500>;
> +			wakeup-event-action =3D <EV_ACT_ASSERTED>;
> +			wakeup-source;
> +		};
> +
> +		power {
> +			label =3D "Power";
> +			gpios =3D <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_POWER>;
> +			debounce-interval =3D <10>;
> +			wakeup-event-action =3D <EV_ACT_ASSERTED>;
> +			wakeup-source;
> +		};
> +
> +		volume-up {
> +			label =3D "Volume Up";
> +			gpios =3D <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEUP>;
> +			debounce-interval =3D <10>;
> +			wakeup-event-action =3D <EV_ACT_ASSERTED>;
> +			wakeup-source;
> +		};
> +
> +		volume-down {
> +			label =3D "Volume Down";
> +			gpios =3D <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEDOWN>;
> +			debounce-interval =3D <10>;
> +			wakeup-event-action =3D <EV_ACT_ASSERTED>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	lvds-encoder {
> +		compatible =3D "ti,sn75lvds83", "lvds-encoder";
> +
> +		powerdown-gpios =3D <&gpio TEGRA_GPIO(B, 2) GPIO_ACTIVE_LOW>;
> +		power-supply =3D <&vdd_3v3_sys>;
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				reg =3D <0>;
> +
> +				lvds_encoder_input: endpoint {
> +					remote-endpoint =3D <&lcd_output>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg =3D <1>;
> +
> +				lvds_encoder_output: endpoint {
> +					remote-endpoint =3D <&panel_input>;
> +				};
> +			};
> +		};
> +	};
> +
> +	display-panel {
> +		compatible =3D "panel-lvds";
> +
> +		/* AUO B101EW05 using custom timings */
> +
> +		backlight =3D <&backlight>;
> +		ddc-i2c-bus =3D <&lvds_ddc>;
> +		power-supply =3D <&vdd_pnl_reg>;
> +
> +		width-mm =3D <218>;
> +		height-mm =3D <135>;
> +
> +		data-mapping =3D "jeida-18";
> +
> +		panel-timing {
> +			clock-frequency =3D <71200000>;
> +			hactive =3D <1280>;
> +			vactive =3D <800>;
> +			hfront-porch =3D <8>;
> +			hback-porch =3D <18>;
> +			hsync-len =3D <184>;
> +			vsync-len =3D <3>;
> +			vfront-porch =3D <4>;
> +			vback-porch =3D <8>;
> +		};
> +
> +		port {
> +			panel_input: endpoint {
> +				remote-endpoint =3D <&lvds_encoder_output>;
> +			};
> +		};
> +	};
> +
> +	vdd_5v0_sys: regulator-0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd_5v0";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +	};
> +
> +	vdd_3v3_sys: regulator-1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd_3v3_vs";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-always-on;
> +		vin-supply =3D <&vdd_5v0_sys>;
> +	};
> +
> +	regulator-2 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pcie_vdd";
> +		regulator-min-microvolt =3D <1500000>;
> +		regulator-max-microvolt =3D <1500000>;
> +		gpio =3D <&pmic 0 GPIO_ACTIVE_HIGH>;
> +		regulator-always-on;
> +	};
> +
> +	vdd_pnl_reg: regulator-3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd_pnl";
> +		regulator-min-microvolt =3D <2800000>;
> +		regulator-max-microvolt =3D <2800000>;
> +		gpio =3D <&gpio TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vdd_1v8_sys: regulator-4 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd_1v8_vs";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		regulator-always-on;
> +		vin-supply =3D <&vdd_5v0_sys>;
> +	};
> +
> +	vdd_hdmi_en: regulator-5 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vdd_5v0_hdmi_en";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		regulator-always-on;
> +		vin-supply =3D <&vdd_5v0_sys>;
> +		gpio =3D <&gpio TEGRA_GPIO(V, 5) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sound {
> +		compatible =3D "asus,tegra-audio-wm8903-tf101",
> +			     "nvidia,tegra-audio-wm8903";
> +		nvidia,model =3D "Asus EeePad Transformer WM8903";
> +
> +		nvidia,audio-routing =3D
> +			"Headphone Jack", "HPOUTR",
> +			"Headphone Jack", "HPOUTL",
> +			"Int Spk", "ROP",
> +			"Int Spk", "RON",
> +			"Int Spk", "LOP",
> +			"Int Spk", "LON",
> +			"Mic Jack", "MICBIAS",
> +			"IN1L", "Mic Jack";
> +
> +		nvidia,i2s-controller =3D <&tegra_i2s1>;
> +		nvidia,audio-codec =3D <&wm8903>;
> +
> +		nvidia,spkr-en-gpios =3D <&wm8903 2 GPIO_ACTIVE_HIGH>;
> +		nvidia,hp-det-gpios =3D <&gpio TEGRA_GPIO(W, 2) GPIO_ACTIVE_LOW>;
> +		nvidia,headset;
> +
> +		clocks =3D <&tegra_car TEGRA20_CLK_PLL_A>,
> +			 <&tegra_car TEGRA20_CLK_PLL_A_OUT0>,
> +			 <&tegra_car TEGRA20_CLK_CDEV1>;
> +		clock-names =3D "pll_a", "pll_a_out0", "mclk";
> +	};
> +
> +	thermal-zones {
> +		skin-thermal {
> +			polling-delay-passive =3D <1000>; /* milliseconds */
> +			polling-delay =3D <0>; /* milliseconds */
> +
> +			thermal-sensors =3D <&nct1008 0>;
> +		};
> +
> +		cpu-thermal {
> +			polling-delay-passive =3D <1000>; /* milliseconds */
> +			polling-delay =3D <5000>; /* milliseconds */
> +
> +			thermal-sensors =3D <&nct1008 1>;
> +
> +			trips {
> +				trip0: cpu-alert0 {
> +					/* start throttling at 50C */
> +					temperature =3D <50000>;
> +					hysteresis =3D <200>;
> +					type =3D "passive";
> +				};
> +
> +				trip1: cpu-crit {
> +					/* shut down at 60C */
> +					temperature =3D <60000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&trip0>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
> +	memory-controller@7000f400 {
> +		nvidia,use-ram-code;
> +
> +		emc-tables@3 {
> +			reg =3D <0x3>;
> +
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			lpddr2 {
> +				compatible =3D "elpida,B8132B2PB-6D-F", "jedec,lpddr2-s4";
> +				revision-id1 =3D <1>;
> +				density =3D <2048>;
> +				io-width =3D <16>;
> +			};
> +
> +			emc-table@25000 {

Ugh... looking at the bindings for this the naming here is rather
unfortunate. emc-tables@3 and emc-table@*... the top-level emc-tables
are really tables, but the emc-table@* are really entries or rows in
that table, not tables themselves. It's also rather unfortunate that we
duplicate the frequency in both the "reg" and "clock-frequency"
properties. One of them would've been enough.

Anyway, looks like this has basically been like this since forever, so
not much that can be done about it.

Again, the memory-controller node needs to be sorted differently. There
are other occurrences of this throughout the file.

Thierry

--IZW3MBWVDgtX5YyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGzdkwACgkQ3SOs138+
s6HaKA//UF5LkZ+ESX++mK8RslWeb7KUWdEgEMp4acdU8C3pujjyRpe24P53eOcB
wMz+WeT40mCpmllGU5MJcIE8aM3O3lWZfP+MQdgbGlBZ6sis5vYhv1Qmaj9G65KV
4tN7XP3tSK1KrSG52BS4AsZyJCwnPQXzXR4j9ykGGSe8wYCR87iKzSwW2KMDmyjN
AOMmRf4No8HGCPUqOR0dF5QE31Ff/X5YvFsr7gydZAR0fVl/M1Mb2y9g0UFv6MO6
BidEY0T8/mkfCVl0ZYu+ETHSD+P2byHR/kNrEQpb1XJWEuU1tiCCM1JaP8Zoj3un
+IU2HmRprlQhZ1NBge0a3ZEeGQ2iCHJ4Ss38nA8tS2DS8qFWbBhjPejn8RbkN4jb
2NjzRRhSlp5W53eCAB7lFqz+paH9lIFtsMSU5H9VG1sV9VxfwKMRpYqYP1MhSp27
ikN63Wh3DPNeUPCCYUljIOXIWl3hZKOGMDk7fAeL9obFrE45GRUsl4rvf+t5435V
TkPY0gf6SwuJ+TutpZzVjVG+/WUmh8k8fgWXx2sl579QfQsN5yo3h3g2PnBYizxl
fLdS2II4S/81y0WW91IcaaZTlJaHKft3BXYGguXlF13mseuo7l24hhhy7jfV9JaI
KDVcfPmKsOVpLQteC4+/7cjyU7gqZD9AImCgjUJfCbsmneqyTgs=
=BjkC
-----END PGP SIGNATURE-----

--IZW3MBWVDgtX5YyB--
