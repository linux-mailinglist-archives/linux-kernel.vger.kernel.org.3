Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58F509C17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387570AbiDUJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387606AbiDUJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:22:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B86246
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:20:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nhSyf-0006xi-HQ; Thu, 21 Apr 2022 11:19:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nhSyf-004KkF-VU; Thu, 21 Apr 2022 11:19:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nhSyd-00Bhgn-P4; Thu, 21 Apr 2022 11:19:51 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/2] ARM: dts: stm32: add support for Protonic PRTT1x boards
Date:   Thu, 21 Apr 2022 11:19:49 +0200
Message-Id: <20220421091949.2789488-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421091949.2789488-1-o.rempel@pengutronix.de>
References: <20220421091949.2789488-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This boards are based on STM32MP151AAD3 and use 10BaseT1L for communication.

- PRTT1C - 10BaseT1L switch
- PRTT1S - 10BaseT1L CO2 sensor board
- PRTT1A - 10BaseT1L multi functional controller

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/Makefile                |   4 +
 arch/arm/boot/dts/stm32mp151a-prtt1a.dts  |  52 ++++
 arch/arm/boot/dts/stm32mp151a-prtt1c.dts  | 327 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi | 219 +++++++++++++++
 arch/arm/boot/dts/stm32mp151a-prtt1s.dts  |  63 +++++
 5 files changed, 665 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1a.dts
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1c.dts
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1s.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..ec5b2307e85a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1156,6 +1156,9 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32h743i-disco.dtb \
 	stm32h750i-art-pi.dtb \
 	stm32mp135f-dk.dtb \
+	stm32mp151a-prtt1a.dtb \
+	stm32mp151a-prtt1c.dtb \
+	stm32mp151a-prtt1s.dtb \
 	stm32mp153c-dhcom-drc02.dtb \
 	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dhcor-avenger96.dtb \
@@ -1175,6 +1178,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32mp157c-ev1.dtb \
 	stm32mp157c-lxa-mc1.dtb \
 	stm32mp157c-odyssey.dtb
+
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1a.dts b/arch/arm/boot/dts/stm32mp151a-prtt1a.dts
new file mode 100644
index 000000000000..75874eafde11
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp151a-prtt1a.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Protonic Holland
+ * Author: David Jander <david@protonic.nl>
+ */
+/dts-v1/;
+
+#include "stm32mp151a-prtt1l.dtsi"
+
+/ {
+	model = "Protonic PRTT1A";
+	compatible = "prt,prtt1a", "st,stm32mp151";
+};
+
+&ethernet0 {
+	phy-handle = <&phy0>;
+};
+
+&mdio0 {
+	/* TI DP83TD510E */
+	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id2000.0181";
+		reg = <0>;
+		interrupts-extended = <&gpioa 4 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpioa 3 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10>;
+		reset-deassert-us = <35>;
+	};
+};
+
+&pwm5_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 0, AF2)>; /* TIM5_CH1 */
+	};
+};
+
+&pwm5_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 0, ANALOG)>; /* TIM5_CH1 */
+	};
+};
+
+&timers5 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm5_pins_a>;
+		pinctrl-1 = <&pwm5_sleep_pins_a>;
+		pinctrl-names = "default", "sleep";
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1c.dts b/arch/arm/boot/dts/stm32mp151a-prtt1c.dts
new file mode 100644
index 000000000000..a5d1e279ce75
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp151a-prtt1c.dts
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Protonic Holland
+ * Author: David Jander <david@protonic.nl>
+ */
+/dts-v1/;
+
+#include "stm32mp151a-prtt1l.dtsi"
+
+/ {
+	model = "Protonic PRTT1C";
+	compatible = "prt,prtt1c", "st,stm32mp151";
+
+	clock_ksz9031: clock-ksz9031 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	clock_sja1105: clock-sja1105 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	mdio0: mdio {
+		compatible = "virtual,mdio-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpioc 1 GPIO_ACTIVE_HIGH
+			 &gpioa 2 GPIO_ACTIVE_HIGH>;
+
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpiod 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&ethernet0 {
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+};
+
+&gpioa {
+	gpio-line-names =
+		"", "", "", "PHY0_nRESET", "PHY0_nINT", "", "", "",
+		"", "", "", "", "", "", "", "SPI1_nSS";
+};
+
+&gpiod {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"WFM_RESET", "", "", "", "", "", "", "";
+};
+
+&gpioe {
+	gpio-line-names =
+		"SDMMC2_nRESET", "", "", "", "", "", "SPI1_nRESET", "",
+		"", "", "", "", "WFM_nIRQ", "", "", "";
+};
+
+&gpiog {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "PHY3_nINT",
+		"PHY1_nINT", "PHY3_nRESET", "PHY2_nINT", "PHY2_nRESET",
+		"PHY1_nRESET", "SPE1_PWR", "SPE0_PWR", "";
+};
+
+&mdio0 {
+	/* All this DP83TD510E PHYs can't be probed before switch@0 is
+	 * probed so we need to use compatible with PHYid
+	 */
+	/* TI DP83TD510E */
+	t1l0_phy: ethernet-phy@6 {
+		compatible = "ethernet-phy-id2000.0181";
+		reg = <6>;
+		interrupts-extended = <&gpioa 4 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpioa 3 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10>;
+		reset-deassert-us = <35>;
+	};
+
+	/* TI DP83TD510E */
+	t1l1_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-id2000.0181";
+		reg = <7>;
+		interrupts-extended = <&gpiog 8 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpiog 12 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10>;
+		reset-deassert-us = <35>;
+	};
+
+	/* TI DP83TD510E */
+	t1l2_phy: ethernet-phy@10 {
+		compatible = "ethernet-phy-id2000.0181";
+		reg = <10>;
+		interrupts-extended = <&gpiog 10 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpiog 11 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10>;
+		reset-deassert-us = <35>;
+	};
+
+	/* Micrel KSZ9031 */
+	rj45_phy: ethernet-phy@2 {
+		reg = <2>;
+		interrupts-extended = <&gpiog 7 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <1000>;
+
+		clocks = <&clock_ksz9031>;
+	};
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
+	disable-wp;
+	disable-cd;
+	none-removable;
+	no-sd;
+	no-sdio;
+	no-1-8-v;
+	st,neg-edge;
+	bus-width = <8>;
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&sdmmc2_b4_od_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+			 <STM32_PINMUX('B', 4, AF9)>; /* SDMMC2_D3 */
+	};
+};
+
+&sdmmc2_b4_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+			 <STM32_PINMUX('B', 7, AF10)>, /* SDMMC2_D1 */
+			 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC2_D2 */
+			 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC2_D3 */
+			 <STM32_PINMUX('G', 6, AF10)>; /* SDMMC2_CMD */
+	};
+};
+
+&sdmmc2_b4_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC2_D0 */
+			 <STM32_PINMUX('B', 7, ANALOG)>, /* SDMMC2_D1 */
+			 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC2_D2 */
+			 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC2_D3 */
+			 <STM32_PINMUX('E', 3, ANALOG)>, /* SDMMC2_CK */
+			 <STM32_PINMUX('G', 6, ANALOG)>; /* SDMMC2_CMD */
+	};
+};
+
+&sdmmc2_d47_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 8, AF9)>, /* SDMMC2_D4 */
+			 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
+			 <STM32_PINMUX('C', 6, AF10)>, /* SDMMC2_D6 */
+			 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
+	};
+};
+
+&sdmmc2_d47_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('A', 8, ANALOG)>, /* SDMMC2_D4 */
+			 <STM32_PINMUX('A', 9, ANALOG)>, /* SDMMC2_D5 */
+			 <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC2_D6 */
+			 <STM32_PINMUX('D', 3, ANALOG)>; /* SDMMC2_D7 */
+	};
+};
+
+&sdmmc3 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc3_b4_pins_b>;
+	pinctrl-1 = <&sdmmc3_b4_od_pins_b>;
+	pinctrl-2 = <&sdmmc3_b4_sleep_pins_b>;
+	disable-wp;
+	disable-cd;
+	none-removable;
+	no-1-8-v;
+	st,neg-edge;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_3v3>;
+        mmc-pwrseq = <&wifi_pwrseq>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	mmc@1 {
+		compatible = "silabs,wf200";
+		reg = <1>;
+	};
+};
+
+&sdmmc3_b4_od_pins_b {
+	pins1 {
+		pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+			 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+			 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+			 <STM32_PINMUX('D', 7, AF10)>; /* SDMMC3_D3 */
+	};
+};
+
+&sdmmc3_b4_pins_b {
+	pins1 {
+		pinmux = <STM32_PINMUX('D', 1, AF10)>, /* SDMMC3_D0 */
+			 <STM32_PINMUX('D', 4, AF10)>, /* SDMMC3_D1 */
+			 <STM32_PINMUX('D', 5, AF10)>, /* SDMMC3_D2 */
+			 <STM32_PINMUX('D', 7, AF10)>, /* SDMMC3_D3 */
+			 <STM32_PINMUX('D', 0, AF10)>; /* SDMMC3_CMD */
+	};
+};
+
+&sdmmc3_b4_sleep_pins_b {
+	pins {
+		pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* SDMMC3_D0 */
+			 <STM32_PINMUX('D', 4, ANALOG)>, /* SDMMC3_D1 */
+			 <STM32_PINMUX('D', 5, ANALOG)>, /* SDMMC3_D2 */
+			 <STM32_PINMUX('D', 7, ANALOG)>, /* SDMMC3_D3 */
+			 <STM32_PINMUX('G', 15, ANALOG)>, /* SDMMC3_CK */
+			 <STM32_PINMUX('D', 0, ANALOG)>; /* SDMMC3_CMD */
+	};
+};
+
+&spi1 {
+	pinctrl-0 = <&spi1_pins_a1>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpioa 15 GPIO_ACTIVE_LOW>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+
+	switch@0 {
+		compatible = "nxp,sja1105q";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+		spi-rx-delay-us = <1>;
+		spi-tx-delay-us = <1>;
+		spi-cpha;
+
+		reset-gpios = <&gpioe 6 GPIO_ACTIVE_LOW>;
+
+		clocks = <&clock_sja1105>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "t1l0";
+				phy-mode = "rmii";
+				phy-handle = <&t1l0_phy>;
+			};
+
+			port@1 {
+				reg = <1>;
+				label = "t1l1";
+				phy-mode = "rmii";
+				phy-handle = <&t1l1_phy>;
+			};
+
+			port@2 {
+				reg = <2>;
+				label = "t1l2";
+				phy-mode = "rmii";
+				phy-handle = <&t1l2_phy>;
+			};
+
+			port@3 {
+				reg = <3>;
+				label = "rj45";
+				phy-handle = <&rj45_phy>;
+				phy-mode = "rgmii-id";
+			};
+
+			port@4 {
+				reg = <4>;
+				label = "cpu";
+				ethernet = <&ethernet0>;
+				phy-mode = "rmii";
+
+				fixed-link {
+					speed = <100>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+&pinctrl {
+	spi1_pins_a1: spi1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
+				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 6, AF5)>; /* SPI1_MISO */
+			bias-disable;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
new file mode 100644
index 000000000000..455b144ede7c
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Protonic Holland
+ * Author: David Jander <david@protonic.nl>
+ */
+/dts-v1/;
+
+#include "stm32mp151.dtsi"
+#include "stm32mp15-pinctrl.dtsi"
+#include "stm32mp15xxad-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		ethernet0 = &ethernet0;
+		mdio-gpio0 = &mdio0;
+		serial0 = &uart4;
+	};
+
+	led-controller-0 {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
+			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+
+	/* DP83TD510E PHYs have max MDC rate of 1.75MHz. Since we can't reduce
+	 * stmmac MDC clock without reducing system bus rate, we need to use
+	 * gpio based MDIO bus.
+	 */
+	mdio0: mdio {
+		compatible = "virtual,mdio-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpioc 1 GPIO_ACTIVE_HIGH
+			 &gpioa 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&ethernet0 {
+	pinctrl-0 = <&ethernet0_rmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rmii_sleep_pins_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rmii";
+	status = "okay";
+};
+
+&ethernet0_rmii_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 12, AF11)>, /* ETH1_RMII_TXD0 */
+			 <STM32_PINMUX('B', 13, AF11)>, /* ETH1_RMII_TXD1 */
+			 <STM32_PINMUX('B', 11, AF11)>; /* ETH1_RMII_TX_EN */
+	};
+	pins2 {
+		pinmux = <STM32_PINMUX('C', 4, AF11)>,  /* ETH1_RMII_RXD0 */
+			 <STM32_PINMUX('C', 5, AF11)>,  /* ETH1_RMII_RXD1 */
+			 <STM32_PINMUX('A', 1, AF11)>,  /* ETH1_RMII_REF_CLK input */
+			 <STM32_PINMUX('A', 7, AF11)>;  /* ETH1_RMII_CRS_DV */
+	};
+};
+
+&ethernet0_rmii_sleep_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 12, ANALOG)>, /* ETH1_RMII_TXD0 */
+			 <STM32_PINMUX('B', 13, ANALOG)>, /* ETH1_RMII_TXD1 */
+			 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_RMII_TX_EN */
+			 <STM32_PINMUX('C', 4, ANALOG)>,  /* ETH1_RMII_RXD0 */
+			 <STM32_PINMUX('C', 5, ANALOG)>,  /* ETH1_RMII_RXD1 */
+			 <STM32_PINMUX('A', 1, ANALOG)>,  /* ETH1_RMII_REF_CLK */
+			 <STM32_PINMUX('A', 7, ANALOG)>;  /* ETH1_RMII_CRS_DV */
+	};
+};
+
+&qspi {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a>;
+	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a>;
+	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <104000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
+&qspi_bk1_pins_a {
+	pins1 {
+		bias-pull-up;
+		drive-push-pull;
+		slew-rate = <1>;
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	/* cd-gpios = <&gpiog 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; */
+	disable-wp;
+	disable-cd;
+	/* st,sig-dir; */
+	st,neg-edge;
+	/* st,use-ckin; */
+	bus-width = <4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_3v3>;
+	status = "okay";
+};
+
+&sdmmc1_b4_od_pins_a {
+	pins1 {
+		bias-pull-up;
+	};
+	pins2 {
+		bias-pull-up;
+	};
+};
+
+&sdmmc1_b4_pins_a {
+	pins1 {
+		bias-pull-up;
+	};
+	pins2 {
+		bias-pull-up;
+	};
+};
+
+&uart4 {
+	pinctrl-names = "default", "sleep", "idle";
+	pinctrl-0 = <&uart4_pins_a>;
+	pinctrl-1 = <&uart4_sleep_pins_a>;
+	pinctrl-2 = <&uart4_idle_pins_a>;
+	status = "okay";
+};
+
+&uart4_idle_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 9, ANALOG)>; /* UART4_TX */
+	};
+	pins2 {
+		pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+		bias-pull-up;
+	};
+};
+
+&uart4_pins_a {
+	pins1 {
+		pinmux = <STM32_PINMUX('B', 9, AF8)>; /* UART4_TX */
+		bias-disable;
+		drive-push-pull;
+		slew-rate = <0>;
+	};
+	pins2 {
+		pinmux = <STM32_PINMUX('B', 2, AF8)>; /* UART4_RX */
+		bias-pull-up;
+	};
+};
+
+&uart4_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('B', 9, ANALOG)>, /* UART4_TX */
+			<STM32_PINMUX('B', 2, ANALOG)>; /* UART4_RX */
+	};
+};
+
+&usbh_ehci {
+	phys = <&usbphyc_port0>;
+	phy-names = "usb";
+	status = "okay";
+};
+
+&usbotg_hs {
+	dr_mode = "host";
+	pinctrl-0 = <&usbotg_hs_pins_a>;
+	pinctrl-names = "default";
+	phys = <&usbphyc_port1 0>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port1 {
+	phy-supply = <&reg_3v3>;
+};
diff --git a/arch/arm/boot/dts/stm32mp151a-prtt1s.dts b/arch/arm/boot/dts/stm32mp151a-prtt1s.dts
new file mode 100644
index 000000000000..ad25929e64e6
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp151a-prtt1s.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) Protonic Holland
+ * Author: David Jander <david@protonic.nl>
+ */
+/dts-v1/;
+
+#include "stm32mp151a-prtt1l.dtsi"
+
+/ {
+	model = "Protonic PRTT1S";
+	compatible = "prt,prtt1s", "st,stm32mp151";
+};
+
+&ethernet0 {
+	phy-handle = <&phy0>;
+};
+
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	clock-frequency = <100000>;
+	/delete-property/dmas;
+	/delete-property/dma-names;
+	status = "okay";
+
+	humidity-sensor@40 {
+		compatible = "ti,hdc1080";
+		reg = <0x40>;
+	};
+
+	co2-sensor@62 {
+		compatible = "sensirion,scd41";
+		reg = <0x62>;
+	};
+};
+
+&i2c1_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
+			 <STM32_PINMUX('D', 13, AF5)>; /* I2C1_SDA */
+	};
+};
+
+&i2c1_sleep_pins_a {
+	pins {
+		pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
+			 <STM32_PINMUX('D', 13, ANALOG)>; /* I2C1_SDA */
+	};
+};
+
+&mdio0 {
+	/* TI DP83TD510E */
+	phy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-id2000.0181";
+		reg = <0>;
+		interrupts-extended = <&gpioa 4 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpioa 3 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10>;
+		reset-deassert-us = <35>;
+	};
+};
-- 
2.30.2

