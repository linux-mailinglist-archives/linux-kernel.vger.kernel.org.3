Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ABC5283B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbiEPMA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbiEPMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:00:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A9217049;
        Mon, 16 May 2022 04:59:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j28so3928398eda.13;
        Mon, 16 May 2022 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAIC5XO8Gpb1Psqm27VnVBwo9ZckV1Uf+O9pRsgrc5w=;
        b=OIvDXjnaMI0BsLHjcaWoVSJs5Viu/U5uHaGQReMYDOP7UJaZ6MXnPLv/AAzsyBqy2n
         mkV3NDKqXkhrPcDAwbbGY3GUVr7wfpxHT69hWEQlZqg0jZ130gMEdw+H0GddlPUNrFHX
         PKWDmpqSPLrHjAbaOI/uXr+v/KSnsPuTkCfEZ88MUsIiQoXQsF2oibwDM8hQYbkvoIT6
         UX72PTPxnXpUreeBX5dNRGBkwn3Vd/Bv9ssl9hgMKSYM127EohSvTLcc4QfvsUW9f+rA
         BWGybNqbuKf/z5VAZ+5TVPNIyYovWS+cCpidSs9qkY5kfeHPHm7ZXHwnE0QJE8wpwMZl
         UxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAIC5XO8Gpb1Psqm27VnVBwo9ZckV1Uf+O9pRsgrc5w=;
        b=yLaq4hjgdvXi5K6PFpsg4ucdZfLiYvWaI9tcFAD20vMML04muuCo5GGEKltNmFmHB8
         LhO8BjoLOX70LntXXEtOWOxlgZTAQLYCqTMDUILB4AIanKKchcwXlJc7rdjbnqlTCvCx
         z/gsk4SZ/pFALzLqN8pA6oOCdrHl9HWc5nuQ2HaoiySckRAGqko39k/zn4jhfW4FGnBH
         spE3OOlzqCNMaLuAMxyvJpO3u+cNsoXz0XgGCEhHw1AbqXF3iGU4yTWjpXejdCcGBCxq
         rcGU7guu1bZDZZpPyJ1GaT/5jMbtOehsvEOqF0526uDEN+K0zC2wxBrHiGlcqs2z8RXa
         dIRg==
X-Gm-Message-State: AOAM532z2K/Rca+AqDKd13Jup1OMNfwET9xzzLgdzrCPuF2yeRd235aR
        N2KY+QtjnGrxOF0ibpP2BkQ=
X-Google-Smtp-Source: ABdhPJzK3rkJ3N/5/Nwzqwf7yEjeiEjJlq6CVlniW4meeZ/cWtoYSjGiYM/l7xsYzrzhuYwLYi8nwQ==
X-Received: by 2002:a05:6402:3552:b0:427:e36a:e839 with SMTP id f18-20020a056402355200b00427e36ae839mr12724834edd.351.1652702379491;
        Mon, 16 May 2022 04:59:39 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:39 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v1 14/17] ARM: dts: imx6q-apalis: Add support for Toradex Ixora V1.2 carrier boards
Date:   Mon, 16 May 2022 13:58:42 +0200
Message-Id: <20220516115846.58328-15-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The Ixora V1.2 carrier board adds SW relevant new features compared to
the V1.1 version.

- An I2C EEPROM is added.
- The SD card slot got a switchable 3.3V supply.
- Pull ups on the SD card signals are not assembled to faciliate 1.8V
  speed modes.
- The CAN transceivers got a switchable 3.3V supply.

Add a new device tree and, as the differences are so small rework the
device tree for V1.1 to include the V1.2 device tree and adjust as
needed.
Drop adding the toradex,apalis_imx6q-ixora to the dtb compatible to
adhere to the binding yaml document.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 178 +----------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts | 290 ++++++++++++++++++
 3 files changed, 303 insertions(+), 166 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0ad8339e07d8..55fbe4f8c598 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -544,6 +544,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-apalis-eval.dtb \
 	imx6q-apalis-ixora.dtb \
 	imx6q-apalis-ixora-v1.1.dtb \
+	imx6q-apalis-ixora-v1.2.dtb \
 	imx6q-apf6dev.dtb \
 	imx6q-arm2.dtb \
 	imx6q-b450v3.dtb \
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 2d0324103804..44637d606e61 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -5,187 +5,33 @@
  * Copyright 2011 Linaro Ltd.
  */
 
-/dts-v1/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include "imx6q.dtsi"
-#include "imx6qdl-apalis.dtsi"
+#include "imx6q-apalis-ixora-v1.2.dts"
 
 / {
 	model = "Toradex Apalis iMX6Q/D Module on Ixora Carrier Board V1.1";
-	compatible = "toradex,apalis_imx6q-ixora-v1.1",
-		     "toradex,apalis_imx6q-ixora", "toradex,apalis_imx6q",
+	compatible = "toradex,apalis_imx6q-ixora-v1.1", "toradex,apalis_imx6q",
 		     "fsl,imx6q";
 
-	aliases {
-		i2c0 = &i2c1;
-		i2c1 = &i2c3;
-		i2c2 = &i2c2;
-		rtc0 = &rtc_i2c;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds_ixora>;
-
-		led4-green {
-			label = "LED_4_GREEN";
-			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
-		};
 
-		led4-red {
-			label = "LED_4_RED";
-			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
-		};
-
-		led5-green {
-			label = "LED_5_GREEN";
-			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
-		};
-
-		led5-red {
-			label = "LED_5_RED";
-			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
-		};
-	};
 };
 
+/delete-node/ &eeprom;
+/delete-node/ &reg_3v3_vmmc;
+/delete-node/ &reg_can1_supply;
+/delete-node/ &reg_can2_supply;
+
 &can1 {
-	status = "okay";
+	/delete-property/ xceiver-supply;
 };
 
 &can2 {
-	status = "okay";
-};
-
-/* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
-&i2c1 {
-	status = "okay";
-
-	/* M41T0M6 real time clock on carrier board */
-	rtc_i2c: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
-};
-
-/*
- * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
- * board)
- */
-&i2c3 {
-	status = "okay";
-};
-
-&pcie {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_reset_moci>;
-	/* active-high meaning opposite of regular PERST# active-low polarity */
-	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
-	reset-gpio-active-high;
-	status = "okay";
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&pwm2 {
-	status = "okay";
-};
-
-&pwm3 {
-	status = "okay";
-};
-
-&pwm4 {
-	status = "okay";
-};
-
-&reg_usb_otg_vbus {
-	status = "okay";
-};
-
-&reg_usb_host_vbus {
-	status = "okay";
-};
-
-&sata {
-	status = "okay";
-};
-
-&sound_spdif {
-	status = "okay";
-};
-
-&spdif {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart4 {
-	status = "okay";
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_host_vbus>;
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	status = "okay";
+	/delete-property/ xceiver-supply;
 };
 
 /* MMC1 */
 &usdhc1 {
+	/delete-property/ cap-power-off-card;
+	/delete-property/ pinctrl-1;
+	/delete-property/ vmmc-supply;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_mmc_cd>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&iomuxc {
-	pinctrl_leds_ixora: ledsixoragrp {
-		fsl,pins = <
-			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0x1b0b0
-			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12 0x1b0b0
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x1b0b0
-			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x1b0b0
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
new file mode 100644
index 000000000000..7770697fde5e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.2.dts
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2014-2022 Toradex
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6q.dtsi"
+#include "imx6qdl-apalis.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX6Q/D Module on Ixora Carrier Board V1.2";
+	compatible = "toradex,apalis_imx6q-ixora-v1.2", "toradex,apalis_imx6q",
+		     "fsl,imx6q";
+
+	aliases {
+		i2c0 = &i2c1;
+		i2c1 = &i2c3;
+		i2c2 = &i2c2;
+		rtc0 = &rtc_i2c;
+		rtc1 = &snvs_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_ixora>;
+
+		led4-green {
+			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+			label = "LED_4_GREEN";
+		};
+
+		led4-red {
+			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+			label = "LED_4_RED";
+		};
+
+		led5-green {
+			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+			label = "LED_5_GREEN";
+		};
+
+		led5-red {
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			label = "LED_5_RED";
+		};
+	};
+
+	reg_3v3_vmmc: regulator-3v3-vmmc {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 0 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_vmmc>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3v3_vmmc";
+		startup-delay-us = <100>;
+	};
+
+	reg_can1_supply: regulator-can1-supply {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can1_power>;
+		regulator-name = "can1_supply";
+	};
+
+	reg_can2_supply: regulator-can2-supply {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can2_power>;
+		regulator-name = "can2_supply";
+	};
+};
+
+&can1 {
+	xceiver-supply = <&reg_can1_supply>;
+	status = "okay";
+};
+
+&can2 {
+	xceiver-supply = <&reg_can2_supply>;
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart24_forceoff>;
+
+	/*
+	 * uart-2-4-on-x21-enable-hog enables the UART transceiver for Apalis
+	 * UART2 and UART3. If one wants to disable the transceiver force
+	 * the GPIO to output-low, if one wants to control the transceiver
+	 * from user space delete the hog node.
+	 */
+	uart-2-4-on-x21-enable-hog {
+		gpio-hog;
+		gpios = <11 GPIO_ACTIVE_HIGH>; /* MXM3 180 */
+		output-high;
+	};
+};
+
+/* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
+&i2c1 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/*
+ * I2C3_SDA/SCL (CAM) on MXM3 pin 201/203 (e.g. camera sensor on carrier
+ * board)
+ */
+&i2c3 {
+	status = "okay";
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_moci>;
+	/* active-high meaning opposite of regular PERST# active-low polarity */
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	reset-gpio-active-high;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&reg_usb_host_vbus {
+	status = "okay";
+};
+
+&reg_usb_otg_vbus {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&sound_spdif {
+	status = "okay";
+};
+
+&spdif {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_host_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	status = "okay";
+};
+
+/* MMC1 */
+&usdhc1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_mmc_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_4bit_sleep &pinctrl_mmc_cd_sleep>;
+	bus-width = <4>;
+	cap-power-off-card;
+	vmmc-supply = <&reg_3v3_vmmc>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_enable_3v3_vmmc: enable3v3vmmcgrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00 0x1b0b0
+		>;
+	};
+
+	pinctrl_enable_can1_power: enablecan1powergrp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x1b0b0
+		>;
+	};
+
+	pinctrl_enable_can2_power: enablecan2powergrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_DA15__GPIO3_IO15 0x1b0b0
+		>;
+	};
+
+	pinctrl_uart24_forceoff: uart24forceoffgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__GPIO1_IO11 0x1b0b0
+		>;
+	};
+
+	pinctrl_leds_ixora: ledsixoragrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0x1b0b0
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12 0x1b0b0
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01 0x1b0b0
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x1b0b0
+		>;
+	};
+
+	pinctrl_mmc_cd_sleep: mmccdslpgrp {
+		fsl,pins = <
+			 /* MMC1 CD */
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x0
+		>;
+	};
+
+	pinctrl_usdhc1_4bit_sleep: usdhc1-4bitslpgrp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD     0x3000
+			MX6QDL_PAD_SD1_CLK__SD1_CLK     0x3000
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0  0x3000
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1  0x3000
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2  0x3000
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3  0x3000
+		>;
+	};
+};
-- 
2.20.1

