Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A457F064
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiGWQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbiGWQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:54 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B1D1CB18;
        Sat, 23 Jul 2022 09:05:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w29so5441735qtv.9;
        Sat, 23 Jul 2022 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGlzOdw/zZrqM4wqtskTwWxXkoP7apfLLBludDKnPXs=;
        b=dultQPYNhydpavkteengAwQd5LY1O6Nk+xKIWXhtYK8Qiwmp2/ulpAWEtKtw99XrMn
         BqmHENg5XZDF/DnPn9oiw3r9I+iME8WPYeF9EPI2t7ij+wXeN1NDeuJHE5fw6GIm4a9I
         WiD0eZERAQBPipW/L5FjLFX5eoiNlyXSWWI2MjDozgLwhJusU81xLw7pfeMVgv27N3g3
         FvGLKoJNkXWeFP5DDKSS1rAqAze4Z92EZr247w1Yz/xJJiA4dITWVb9iqNEDfgDtoF/m
         mRHS3N3rd8G+kvukkjNtYIC5VLWBbO0pBHzXaG5SI0c5Kf7vgnxp+l2piCySuw+KqX/O
         uIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGlzOdw/zZrqM4wqtskTwWxXkoP7apfLLBludDKnPXs=;
        b=gdr4rBhPyePeEjV6+xut+xcIxD05lHSrrV1EK+mF0/OrApR4JIgYpFbqcEQKPlHONX
         2VwO5dsb9V6FaaNnhz21StCqh4IF8zrxrMIhHrtyq+CM3S7EetsNumkRcMSKU7EsWUPh
         WCbn4r20EULAY1BRi2QN+Xfld5AQnKh7+sjPrR35S24mf3ZaSpeIC79Xc4Ci8S4Mrcld
         uZ7ggpZrb/X2/cSTMq95OwOKKN8eiS7Ko4KV4Ew5u1eDgynUMV9YPoVfmFtnC7xEKYox
         wJutB0vvaDFJLy6o50I5Etmnvs62ble00Od5dGIdoMzAmXUtIrMJeww2QMvgaxM+jky8
         rtXg==
X-Gm-Message-State: AJIora/GhVXD8JSBksZ+bq6UtMn3W8ZlHrYALyajCk5vt9KHDXv/Saye
        A1xi8vMrdOXDLpfF0SFzx3o=
X-Google-Smtp-Source: AGRyM1v8sOq/FRaRo1q+xTR1KpwNKs1KJKzIzYWWnA05oxapkVR5vtaQh4vlsXLgK2PQnu00So2gqA==
X-Received: by 2002:ac8:5d8b:0:b0:31e:ed61:b5a7 with SMTP id d11-20020ac85d8b000000b0031eed61b5a7mr4181672qtx.259.1658592339016;
        Sat, 23 Jul 2022 09:05:39 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:38 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v5 11/12] ARM: dts: imx: Add i.MXRT1170-EVK support
Date:   Sat, 23 Jul 2022 12:05:12 -0400
Message-Id: <20220723160513.271692-12-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP i.MXRT1170 Evaluation Kit (EVK) provides a platform for rapid
evaluation of the i.MXRT, which features NXP's implementation of the Arm
Cortex-M7 and M4 core.

The EVK provides 64 MB SDRAM, 128 MB Quad SPI flash, Micro SD card socket,
two USB 2.0 OTG, and two Ethernet ports.

This patch aims to support the preliminary booting up features
as follows:
GPIO
LPUART
SD/MMC

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Add ipg clock for gpt
 - Change mmc, uart and gpt compatibles
 - Group fsl,pins for dtbs_check
 - Remove underscore from pinctrl_usbotg1_id
 - Remove unused fsl,mux_mask
 - Rename ccm to clock-controller
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
---
 arch/arm/boot/dts/Makefile          |   3 +-
 arch/arm/boot/dts/imxrt1170-evk.dts | 110 +++++++++++
 arch/arm/boot/dts/imxrt1170.dtsi    | 276 ++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index edfbedaa6168..a3f152ef78f7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -766,7 +766,8 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
 	imx7ulp-com.dtb \
 	imx7ulp-evk.dtb
 dtb-$(CONFIG_SOC_IMXRT) += \
-	imxrt1050-evk.dtb
+	imxrt1050-evk.dtb \
+	imxrt1170-evk.dtb
 dtb-$(CONFIG_SOC_LAN966) += \
 	lan966x-pcb8291.dtb \
 	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
diff --git a/arch/arm/boot/dts/imxrt1170-evk.dts b/arch/arm/boot/dts/imxrt1170-evk.dts
new file mode 100644
index 000000000000..cac74d86168f
--- /dev/null
+++ b/arch/arm/boot/dts/imxrt1170-evk.dts
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2022
+ * Author(s):  Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+
+/dts-v1/;
+#include "imxrt1170.dtsi"
+#include "imxrt1170-pinfunc.h"
+
+/ {
+	model = "NXP imxrt1170-evk board";
+	compatible = "fsl,imxrt1170-evk", "fsl,imxrt1170";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		gpio5 = &gpio6;
+		gpio6 = &gpio7;
+		gpio7 = &gpio8;
+		gpio8 = &gpio9;
+		gpio9 = &gpio10;
+		gpio10 = &gpio11;
+		gpio11 = &gpio12;
+		gpio12 = &gpio13;
+		mmc0 = &usdhc1;
+		serial0 = &lpuart1;
+		usbphy0 = &usbphy1;
+	};
+
+	memory@20240000 {
+		device_type = "memory";
+		reg = <0x20240000 0xf0000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x4000000>;
+	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pwm0>;
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio9 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart1>;
+	status = "okay";
+};
+
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1_id>;
+	disable-over-current;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_lpuart1: lpuart1grp {
+		fsl,pins = <IOMUXC_GPIO_AD_24_LPUART1_TXD 0xf1>,
+			   <IOMUXC_GPIO_AD_25_LPUART1_RXD 0xf1>;
+	};
+
+	pinctrl_pwm0: pwm0grp {
+		fsl,pins = <IOMUXC_GPIO_AD_11_USB_OTG1_OC 0xf1>;
+	};
+
+	pinctrl_usbotg1_id: usbotg1idgrp {
+		fsl,pins = <IOMUXC_GPIO_AD_09_USBPHY1_OTG_ID 0xf1>;
+	};
+
+	pinctrl_usdhc0: usdhc0grp {
+		fsl,pins = <IOMUXC_GPIO_AD_32_USDHC1_CD_B		0x1B000>,
+			   <IOMUXC_GPIO_AD_34_USDHC1_VSELECT		0xB069>,
+			   <IOMUXC_GPIO_SD_B1_00_USDHC1_CMD		0x17061>,
+			   <IOMUXC_GPIO_SD_B1_01_USDHC1_CLK		0x17061>,
+			   <IOMUXC_GPIO_SD_B1_05_USDHC1_DATA3		0x17061>,
+			   <IOMUXC_GPIO_SD_B1_04_USDHC1_DATA2		0x17061>,
+			   <IOMUXC_GPIO_SD_B1_03_USDHC1_DATA1		0x17061>,
+			   <IOMUXC_GPIO_SD_B1_02_USDHC1_DATA0		0x17061>;
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc0>;
+	pinctrl-1 = <&pinctrl_usdhc0>;
+	pinctrl-2 = <&pinctrl_usdhc0>;
+	pinctrl-3 = <&pinctrl_usdhc0>;
+	status = "okay";
+	broken-cd;
+};
diff --git a/arch/arm/boot/dts/imxrt1170.dtsi b/arch/arm/boot/dts/imxrt1170.dtsi
new file mode 100644
index 000000000000..64c130933ee8
--- /dev/null
+++ b/arch/arm/boot/dts/imxrt1170.dtsi
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2022
+ * Author(s):  Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+
+#include "armv7-m.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/imxrt1170-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x40000>;
+			no-map;
+			linux,dma-default;
+		};
+	};
+
+	clocks {
+		osc: osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+
+		rcosc16M: rcosc16M {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <16000000>;
+		};
+
+		osc32k: osc32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		osc3M: osc3M {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <3000000>;
+		};
+	};
+
+	soc {
+		anatop: anatop@40c84000 {
+			compatible = "fsl,imxrt-anatop";
+			reg = <0x40c84000 0x4000>;
+		};
+
+		clks: clock-controller@40cc0000 {
+			compatible = "fsl,imxrt1170-ccm";
+			reg = <0x40cc0000 0x4000>;
+			clocks = <&osc>, <&rcosc16M>, <&osc32k>;
+			clock-names = "osc", "rcosc16M", "osc32k";
+			#clock-cells = <1>;
+		};
+
+		edma1: dma-controller@40070000 {
+			#dma-cells = <2>;
+			compatible = "fsl,imx7ulp-edma";
+			reg = <0x40070000 0x4000>,
+				<0x40074000 0x4000>;
+			dma-channels = <32>;
+			interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>, <8>,
+				<9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
+			clock-names = "dma", "dmamux0";
+			clocks = <&clks IMXRT1170_CLK_BUS>,
+				 <&clks IMXRT1170_CLK_M4>;
+		};
+
+		gpio1: gpio@4012c000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x4012c000 0x4000>;
+			interrupts = <100>, <101>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@40130000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40130000 0x4000>;
+			interrupts = <102>, <103>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@40134000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40134000 0x4000>;
+			interrupts = <104>, <105>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio4: gpio@40138000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40138000 0x4000>;
+			interrupts = <106>, <107>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio5: gpio@4013c000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x4013c000 0x4000>;
+			interrupts = <108>, <109>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio6: gpio@40140000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40140000 0x4000>;
+			interrupts = <61>, <62>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio7: gpio@40c5c000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c5c000 0x4000>;
+			interrupts = <99>, <99>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio8: gpio@40c60000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c60000 0x4000>;
+			interrupts = <99>, <99>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio9: gpio@40c64000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c64000 0x4000>;
+			interrupts = <99>, <99>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio10: gpio@40c68000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c68000 0x4000>;
+			interrupts = <99>, <99>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio11: gpio@40c6c000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c6c000 0x4000>;
+			interrupts = <99>, <99>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio12: gpio@40c70000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40c70000 0x4000>;
+			interrupts = <61>, <62>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio13: gpio@40ca0000 {
+			compatible = "fsl,imxrt1170-gpio", "fsl,imx35-gpio";
+			reg = <0x40ca0000 0x4000>;
+			interrupts = <93>, <93>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpt: timer@400ec000 {
+			compatible = "fsl,imxrt1170-gpt", "fsl,imx6dl-gpt";
+			reg = <0x400ec000 0x4000>;
+			interrupts = <119>;
+			clocks = <&osc3M>, <&osc3M>;
+			clock-names = "ipg", "per";
+		};
+
+		iomuxc: iomuxc@400e8000 {
+			compatible = "fsl,imxrt1170-iomuxc";
+			reg = <0x400e8000 0x4000>;
+		};
+
+		lpuart1: serial@4007c000 {
+			compatible = "fsl,imxrt1170-lpuart", "fsl,imxrt1050-lpuart";
+			reg = <0x4007c000 0x4000>;
+			interrupts = <20>;
+			clocks = <&clks IMXRT1170_CLK_LPUART1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		usdhc1: mmc@40418000 {
+			compatible = "fsl,imxrt1170-usdhc", "fsl,imxrt1050-usdhc";
+			reg = <0x40418000 0x10000>;
+			interrupts = <133>;
+			clocks = <&clks IMXRT1170_CLK_BUS>,
+				<&clks IMXRT1170_CLK_BUS>,
+				<&clks IMXRT1170_CLK_USDHC1>;
+			clock-names = "ipg", "ahb", "per";
+			bus-width = <4>;
+			fsl,wp-controller;
+			no-1-8-v;
+			max-frequency = <4000000>;
+			fsl,tuning-start-tap = <20>;
+			fsl,tuning-step= <2>;
+			status = "disabled";
+		};
+
+		usbmisc1: usbmisc@40430200 {
+			compatible = "fsl,imx7ulp-usbmisc";
+			#index-cells = <1>;
+			reg = <0x40430200 0x200>;
+		};
+
+		usbotg1: usb@40430000 {
+			compatible = "fsl,imx7ulp-usb";
+			reg = <0x40430000 0x200>;
+			interrupts = <136>;
+			clocks = <&clks IMXRT1170_CLK_USB>;
+			phys = <&usbphy1>;
+			fsl,usbmisc = <&usbmisc1 0>;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@40434000 {
+			compatible = "fsl,imx7ulp-usbphy";
+			reg = <0x40434000 0x1000>;
+			interrupts = <90>;
+			clocks = <&clks IMXRT1170_CLK_USB>;
+			#phy-cells = <0>;
+		};
+
+	};
+};
-- 
2.36.1

