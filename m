Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF4B518D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiECTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbiECTo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:44:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0037AAD;
        Tue,  3 May 2022 12:41:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id p18so21005010edr.7;
        Tue, 03 May 2022 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9JX3y8IaqlCXj5IWV//z2uRp23lIuvJxUg7SiEiGuI=;
        b=kzaQfR2YFUsbNNZxqp1mnk4+AFG88lyR3POakO2mLh9Uh/O4syItvLaCWFSoWgs9VM
         vimniSS8/GSud2Jl+WjnNqNhgv8LZKorx9AhfKBOx1UR5Dat4Iff/CV19mP+7FyBrK3l
         mYCeijEPwOIoc4iBK4y1hPOuiDuQ67JLy9uryZtUBxPylC//8B/3EJB4EHRFUpT2Rfj5
         ckOm+KAn4tjRZg/Bi6OjvjvuD4KErUx45wgv5E+a5GU4Wg3/YA7wUN4BVKAcWvSAxHAr
         KcudMyDNqMq7beKhMpk12s2wp0tDy3QT4MA4G5m/S7mVpOLVkQ1Z3dya2tulF4+mUoPC
         887w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9JX3y8IaqlCXj5IWV//z2uRp23lIuvJxUg7SiEiGuI=;
        b=iPVe4NhVnC5vb8VWRVLQOoIhNEiw+uPt0FXBSYGtccdWf4zvYmSLUg3CRfEsf1ooqr
         2HnFEqUuGvG6VobrMz23OM8dIGcGI2WTKjfqUMYawccr69urE5KrIYz80FKUKHBV1bTA
         /AbfVxzfLRGBNT/j60tEutivRqJ2NPV+jUGqYU6YJkL0z2+8AjBBIm9LtylFaGUCo/CB
         8b0FI7V+FysYiExrtngDiVTCPWkoK9D5gLgjqT65Hf3+T2JM3/0FOPWVNXMdjq/Pv3SX
         K2Si2jvLEl9/gJql3bqcLn5hQE02XNxxoNBuU4eM96e4XVK0BODaHwA+NJVHxXrfA1YA
         C3ng==
X-Gm-Message-State: AOAM5311OmrJz/uX2z8H7RJp/WD+qU+wesYnBUGqgBWMnu4ZhxURmuTu
        GNmW4e5zDmr772jffPDO3cE=
X-Google-Smtp-Source: ABdhPJws2LTHm0qvCA3N5Xhz0+SB57jiBQ1ihhQnzf+2g6rFPzKw8hWxUAA+7calG/lyVeGZ1bv8qA==
X-Received: by 2002:a50:fb83:0:b0:425:cb1f:dc57 with SMTP id e3-20020a50fb83000000b00425cb1fdc57mr19626557edq.150.1651606882335;
        Tue, 03 May 2022 12:41:22 -0700 (PDT)
Received: from kista.localnet (cpe1-3-76.cable.triera.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm8147584edx.50.2022.05.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:41:22 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 5/6] arm64: dts: allwinner: h616: Add OrangePi Zero 2 board support
Date:   Tue, 03 May 2022 21:41:21 +0200
Message-ID: <7374416.EvYhyI6sBW@kista>
In-Reply-To: <20220428230933.15262-6-andre.przywara@arm.com>
References: <20220428230933.15262-1-andre.przywara@arm.com> <20220428230933.15262-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 29. april 2022 ob 01:09:32 CEST je Andre Przywara napisal(a):
> The OrangePi Zero 2 is a development board with the new H616 SoC. It
> comes with the following features:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 512MiB/1GiB DDR3 DRAM
>   - AXP305 PMIC
>   - Raspberry-Pi-1 compatible GPIO header
>   - extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
>   - 1 USB 2.0 host port
>   - 1 USB 2.0 type C port (power supply + OTG)
>   - MicroSD slot
>   - on-board 2MiB bootable SPI NOR flash
>   - 1Gbps Ethernet port (via RTL8211F PHY)
>   - micro-HDMI port
>   - unsupported Allwinner WiFi/BT chip
> 
> For more details see: https://linux-sunxi.org/Orange_Pi_Zero_2

Please no external links.

> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 203 ++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-
zero2.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/
allwinner/Makefile
> index 8fa5c060a4fe..df2214e6d946 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -38,3 +38,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts b/
arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> new file mode 100644
> index 000000000000..ca07cae698ce
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.

2022?

> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model = "OrangePi Zero2";
> +	compatible = "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		ethernet0 = &emac0;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&pio 2 12 GPIO_ACTIVE_HIGH>; /* PC12 
*/
> +			default-state = "on";
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&pio 2 13 GPIO_ACTIVE_HIGH>; /* PC13 
*/
> +		};
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the USB-C socket 
*/
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&emac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ext_rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-supply = <&reg_dcdce>;
> +	allwinner,rx-delay-ps = <3100>;
> +	allwinner,tx-delay-ps = <700>;
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +
> +	axp305: pmic@745 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x745>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			reg_aldo2: aldo2 {	/* 3.3V on headers 
*/
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext";
> +			};
> +
> +			reg_aldo3: aldo3 {	/* 3.3V on headers 
*/
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			bldo2 {
> +				/* unused */
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				/* reserved */
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1500000>;
> +				regulator-max-microvolt = 
<1500000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-boot-on;

As discussed in the past, this will cause reboot issues because Linux will 
turn down above regulator and thus SD card will stop working. This should be 
always on.

And please add pio regulators, this is something we always add later...

Best regards,
Jernej

> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&spi0  {
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> -- 
> 2.35.3
> 
> 


