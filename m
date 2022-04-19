Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE75506384
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbiDSEw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348361AbiDSEve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:51:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865D2F3B6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:48:51 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmt-0002ua-FW; Tue, 19 Apr 2022 06:48:27 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1ngfmr-0047RO-R0; Tue, 19 Apr 2022 06:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH v2 11/17] ARM: dts: imx6dl-victgo.dts: Factor out common parts to imx6qdl-victgo.dtsi
Date:   Tue, 19 Apr 2022 06:48:18 +0200
Message-Id: <20220419044824.981747-12-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Jander <david@protonic.nl>

These parts are common to imx6qdl-vicut1.dtsi.

This patch is preparation to unify victgo and vicut1 DTs.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-victgo.dts   | 649 +------------------------
 arch/arm/boot/dts/imx6qdl-victgo.dtsi | 658 ++++++++++++++++++++++++++
 2 files changed, 659 insertions(+), 648 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-victgo.dtsi

diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 7fc5bb499cbc..6d61e87405f4 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -5,76 +5,13 @@
  */
 
 /dts-v1/;
-#include <dt-bindings/display/sdtv-standards.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/media/tvp5150.h>
-#include <dt-bindings/sound/fsl-imx-audmux.h>
 #include "imx6dl.dtsi"
+#include "imx6qdl-victgo.dtsi"
 
 / {
 	model = "Kverneland TGO";
 	compatible = "kvg,victgo", "fsl,imx6dl";
 
-	chosen {
-		stdout-path = &uart4;
-	};
-
-	backlight_lcd: backlight {
-		compatible = "pwm-backlight";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_backlight>;
-		pwms = <&pwm1 0 5000000 0>;
-		brightness-levels = <0 16 64 255>;
-		num-interpolated-steps = <16>;
-		default-brightness-level = <48>;
-		power-supply = <&reg_3v3>;
-		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
-	};
-
-	backlight_led: backlight_led {
-		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000 0>;
-		brightness-levels = <0 16 64 255>;
-		num-interpolated-steps = <16>;
-		default-brightness-level = <48>;
-		power-supply = <&reg_3v3>;
-	};
-
-	connector {
-		compatible = "composite-video-connector";
-		label = "Composite0";
-		sdtv-standards = <SDTV_STD_PAL_B>;
-
-		port {
-			comp0_out: endpoint {
-				remote-endpoint = <&tvp5150_comp0_in>;
-			};
-		};
-	};
-
-	counter-0 {
-		compatible = "interrupt-counter";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_counter0>;
-		gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
-	};
-
-	counter-1 {
-		compatible = "interrupt-counter";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_counter1>;
-		gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
-	};
-
-	counter-2 {
-		compatible = "interrupt-counter";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_counter2>;
-		gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -101,33 +38,6 @@ iio-hwmon {
 		io-channels = <&vdiv_vaccu>, <&vdiv_hitch_pos>;
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_leds>;
-
-		led-0 {
-			label = "debug0";
-			function = LED_FUNCTION_HEARTBEAT;
-			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		led-1 {
-			label = "debug1";
-			function = LED_FUNCTION_DISK;
-			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "disk-activity";
-		};
-
-		led-2 {
-			label = "power_led";
-			function = LED_FUNCTION_POWER;
-			gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
-			default-state = "on";
-		};
-	};
-
 	panel {
 		compatible = "lg,lb070wv8";
 		backlight = <&backlight_lcd>;
@@ -146,29 +56,6 @@ clk50m_phy: phy-clock {
 		clock-frequency = <50000000>;
 	};
 
-	reg_1v8: regulator-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_3v3: regulator-3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_otg_vbus: regulator-otg-vbus {
-		compatible = "regulator-fixed";
-		regulator-name = "otg-vbus";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	rotary-encoder {
 		compatible = "rotary-encoder";
 		pinctrl-0 = <&pinctrl_rotary_ch>;
@@ -181,33 +68,6 @@ rotary-encoder {
 		wakeup-source;
 	};
 
-	sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "prti6q-sgtl5000";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,widgets =
-			"Microphone", "Microphone Jack",
-			"Line", "Line In Jack",
-			"Headphone", "Headphone Jack",
-			"Speaker", "External Speaker";
-		simple-audio-card,routing =
-			"MIC_IN", "Microphone Jack",
-			"LINE_IN", "Line In Jack",
-			"Headphone Jack", "HP_OUT",
-			"External Speaker", "LINE_OUT";
-
-		simple-audio-card,cpu {
-			sound-dai = <&ssi1>;
-			system-clock-frequency = <0>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&codec>;
-			bitclock-master;
-			frame-master;
-		};
-	};
-
 	thermal-zones {
 		chassis-thermal {
 			polling-delay = <20000>;
@@ -275,63 +135,6 @@ vdiv_hitch_pos: voltage-divider-hitch-pos {
 	};
 };
 
-&audmux {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux>;
-	status = "okay";
-
-	mux-ssi1 {
-		fsl,audmux-port = <0>;
-		fsl,port-config = <
-			IMX_AUDMUX_V2_PTCR_SYN		0
-			IMX_AUDMUX_V2_PTCR_TFSEL(2)	0
-			IMX_AUDMUX_V2_PTCR_TCSEL(2)	0
-			IMX_AUDMUX_V2_PTCR_TFSDIR	0
-			IMX_AUDMUX_V2_PTCR_TCLKDIR	IMX_AUDMUX_V2_PDCR_RXDSEL(2)
-		>;
-	};
-
-	mux-pins3 {
-		fsl,audmux-port = <2>;
-		fsl,port-config = <
-			IMX_AUDMUX_V2_PTCR_SYN		IMX_AUDMUX_V2_PDCR_RXDSEL(0)
-			0				IMX_AUDMUX_V2_PDCR_TXRXEN
-		>;
-	};
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can1>;
-	termination-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
-	termination-ohms = <150>;
-	status = "okay";
-};
-
-&can2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_can2>;
-	status = "okay";
-};
-
-&clks {
-	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
-};
-
-&ecspi1 {
-	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1>;
-	status = "okay";
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <20000000>;
-	};
-};
-
 &ecspi2 {
 	cs-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	pinctrl-names = "default";
@@ -412,25 +215,6 @@ &gpio1 {
 		"", "", "", "", "", "", "", "ETH_MDC";
 };
 
-&gpio2 {
-	gpio-line-names =
-		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
-		"", "LED_PWM", "", "", "",
-			"", "", "",
-		"", "", "", "", "", "ISB_IN2", "ISB_nIN1", "ON_SWITCH",
-		"POWER_LED", "", "", "", "", "", "", "";
-};
-
-&gpio3 {
-	gpio-line-names =
-		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "", "", "",
-		"ECSPI1_SCLK", "ECSPI1_MISO", "ECSPI1_MOSI", "ECSPI1_SS1",
-			"CPU_ON1_FB", "USB_OTG_OC", "USB_OTG_PWR", "YACO_IRQ",
-		"TSS_TXD", "TSS_RXD", "", "", "", "", "YACO_BOOT0",
-			"YACO_RESET";
-};
-
 &gpio4 {
 	gpio-line-names =
 		"", "", "", "", "", "", "UART4_TXD", "UART4_RXD",
@@ -462,55 +246,7 @@ &gpio6 {
 		"", "", "", "", "", "", "", "";
 };
 
-&gpio7 {
-	gpio-line-names =
-		"EMMC_DAT5", "EMMC_DAT4", "EMMC_CMD", "EMMC_CLK", "EMMC_DAT0",
-			"EMMC_DAT1", "EMMC_DAT2", "EMMC_DAT3",
-		"EMMC_RST", "", "", "", "CAM_DETECT", "", "", "",
-		"", "EMMC_DAT7", "EMMC_DAT6", "", "", "", "", "",
-		"", "", "", "", "", "", "", "";
-};
-
 &i2c1 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c1>;
-	status = "okay";
-
-	codec: audio-codec@a {
-		compatible = "fsl,sgtl5000";
-		reg = <0xa>;
-		#sound-dai-cells = <0>;
-		clocks = <&clks 201>;
-		VDDA-supply = <&reg_3v3>;
-		VDDIO-supply = <&reg_3v3>;
-		VDDD-supply = <&reg_1v8>;
-	};
-
-	video-decoder@5c {
-		compatible = "ti,tvp5150";
-		reg = <0x5c>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			tvp5150_comp0_in: endpoint {
-				remote-endpoint = <&comp0_out>;
-			};
-		};
-
-		/* Output port 2 is video output pad */
-		port@2 {
-			reg = <2>;
-
-			tvp5151_to_ipu1_csi0_mux: endpoint {
-				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
-			};
-		};
-	};
-
 	keypad@70 {
 		compatible = "holtek,ht16k33";
 		pinctrl-names = "default";
@@ -534,236 +270,9 @@ MATRIX_KEY(5, 1, KEY_F3)
 			MATRIX_KEY(6, 1, KEY_F1)
 		      >;
 	};
-
-	/* additional i2c devices are added automatically by the boot loader */
-};
-
-&i2c3 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-
-	adc@49 {
-		compatible = "ti,ads1015";
-		reg = <0x49>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@4 {
-			reg = <4>;
-			ti,gain = <3>;
-			ti,datarate = <3>;
-		};
-
-		channel@5 {
-			reg = <5>;
-			ti,gain = <3>;
-			ti,datarate = <3>;
-		};
-
-		channel@6 {
-			reg = <6>;
-			ti,gain = <3>;
-			ti,datarate = <3>;
-		};
-
-		channel@7 {
-			reg = <7>;
-			ti,gain = <3>;
-			ti,datarate = <3>;
-		};
-	};
-
-	rtc@51 {
-		compatible = "nxp,pcf8563";
-		reg = <0x51>;
-	};
-
-	tsens0: temperature-sensor@70 {
-		compatible = "ti,tmp103";
-		reg = <0x70>;
-		#thermal-sensor-cells = <0>;
-	};
-};
-
-&ipu1_csi0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ipu1_csi0>;
-	status = "okay";
-};
-
-&ipu1_csi0_mux_from_parallel_sensor {
-	remote-endpoint = <&tvp5151_to_ipu1_csi0_mux>;
-};
-
-&ldb {
-	status = "okay";
-
-	lvds-channel@0 {
-		status = "okay";
-
-		port@4 {
-			reg = <4>;
-
-			lvds0_out: endpoint {
-				remote-endpoint = <&panel_in>;
-			};
-		};
-	};
-};
-
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
-};
-
-&pwm3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm3>;
-	status = "okay";
-};
-
-&ssi1 {
-	#sound-dai-cells = <0>;
-	fsl,mode = "ac97-slave";
-	status = "okay";
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	status = "okay";
-};
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
-};
-
-&uart5 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart5>;
-	status = "okay";
-};
-
-&usbh1 {
-	pinctrl-names = "default";
-	phy_type = "utmi";
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usbotg {
-	vbus-supply = <&reg_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg>;
-	phy_type = "utmi";
-	dr_mode = "host";
-	disable-over-current;
-	status = "okay";
-};
-
-&usdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc1>;
-	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-	no-1-8-v;
-	disable-wp;
-	cap-sd-highspeed;
-	no-mmc;
-	no-sdio;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3>;
-	bus-width = <8>;
-	no-1-8-v;
-	non-removable;
-	no-sd;
-	no-sdio;
-	status = "okay";
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog>;
-
-	pinctrl_audmux: audmuxgrp {
-		fsl,pins = <
-			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1			0x030b0
-			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x130b0
-			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x130b0
-			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x110b0
-			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x130b0
-		>;
-	};
-
-	pinctrl_backlight: backlightgrp {
-		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT7__GPIO4_IO28		0x1b0b0
-		>;
-	};
-
-	pinctrl_can1: can1grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b000
-			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x3008
-			/* CAN1_SR */
-			MX6QDL_PAD_KEY_COL3__GPIO4_IO12			0x13008
-			/* CAN1_TERM */
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x1b088
-		>;
-	};
-
-	pinctrl_can2: can2grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b000
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x3008
-			/* CAN2_SR */
-			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13			0x13008
-		>;
-	};
-
-	pinctrl_counter0: counter0grp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_D0__GPIO2_IO00			0x1b000
-		>;
-	};
-
-	pinctrl_counter1: counter1grp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01			0x1b000
-		>;
-	};
-
-	pinctrl_counter2: counter2grp {
-		fsl,pins = <
-			MX6QDL_PAD_NANDF_D2__GPIO2_IO02			0x1b000
-		>;
-	};
-
-	pinctrl_ecspi1: ecspi1grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__ECSPI1_MISO			0x100b1
-			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI			0x100b1
-			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK			0x100b1
-			/* CS */
-			MX6QDL_PAD_EIM_D19__GPIO3_IO19			0x000b1
-		>;
-	};
-
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins = <
 			MX6QDL_PAD_DISP0_DAT16__ECSPI2_MOSI		0x100b1
@@ -802,102 +311,12 @@ MX6QDL_PAD_EIM_CS0__GPIO2_IO23			0x1b0b0
 		>;
 	};
 
-	pinctrl_hog: hoggrp {
-		fsl,pins = <
-			/* ITU656_nRESET */
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02			0x1b0b0
-			/* CAM1_MIRROR */
-			MX6QDL_PAD_GPIO_3__GPIO1_IO03			0x130b0
-			/* CAM2_MIRROR */
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x130b0
-			/* CAM_nDETECT */
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x1b0b0
-			/* ISB_IN1 */
-			MX6QDL_PAD_EIM_A16__GPIO2_IO22			0x130b0
-			/* ISB_nIN2 */
-			MX6QDL_PAD_EIM_A17__GPIO2_IO21			0x1b0b0
-			/* WARN_LIGHT */
-			MX6QDL_PAD_EIM_A19__GPIO2_IO19			0x100b0
-			/* ON2_FB */
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02			0x100b0
-			/* YACO_nIRQ */
-			MX6QDL_PAD_EIM_D23__GPIO3_IO23			0x1b0b0
-			/* YACO_BOOT0 */
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30			0x130b0
-			/* YACO_nRESET */
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31			0x1b0b0
-			/* FORCE_ON1 */
-			MX6QDL_PAD_EIM_EB2__GPIO2_IO30			0x1b0b0
-			/* AUDIO_nRESET */
-			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21		0x1f0b0
-			/* ITU656_nPDN */
-			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b0b0
-
-			/* New in HW revision 1 */
-			/* ON1_FB */
-			MX6QDL_PAD_EIM_D20__GPIO3_IO20			0x100b0
-			/* DIP1_FB */
-			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18			0x1b0b0
-		>;
-	};
-
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001f8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001f8b1
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
-		>;
-	};
-
-	pinctrl_ipu1_csi0: ipu1csi0grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
-			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
-			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
-		>;
-	};
-
 	pinctrl_keypad: keypadgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_19__GPIO4_IO05			0x1b0b0
 		>;
 	};
 
-	pinctrl_leds: ledsgrp {
-		fsl,pins = <
-			/* DEBUG0 */
-			MX6QDL_PAD_DI0_DISP_CLK__GPIO4_IO16		0x1b0b0
-			/* DEBUG1 */
-			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17		0x1b0b0
-			/* POWER_LED */
-			MX6QDL_PAD_EIM_CS1__GPIO2_IO24			0x1b0b0
-		>;
-	};
-
-	pinctrl_pwm1: pwm1grp {
-		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT8__PWM1_OUT			0x1b0b0
-		>;
-	};
-
-	pinctrl_pwm3: pwm3grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b0
-		>;
-	};
-
 	pinctrl_rotary_ch: rotarychgrp {
 		fsl,pins = <
 			MX6QDL_PAD_NANDF_D3__GPIO2_IO03			0x1b0b0
@@ -911,70 +330,4 @@ MX6QDL_PAD_DISP0_DAT14__GPIO5_IO08		0x1b0b0
 			MX6QDL_PAD_DISP0_DAT15__GPIO5_IO09		0x1b0b0
 		>;
 	};
-
-	/* YaCO AUX Uart */
-	pinctrl_uart1: uart1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA		0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
-		>;
-	};
-
-	/* YaCO Touchscreen UART */
-	pinctrl_uart3: uart3grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b1
-		>;
-	};
-
-	pinctrl_uart4: uart4grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
-		>;
-	};
-
-	pinctrl_uart5: uart5grp {
-		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
-			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
-		>;
-	};
-
-	pinctrl_usbotg: usbotggrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__USB_OTG_OC			0x1b0b0
-			/* power enable, high active */
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0
-		>;
-	};
-
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x170f9
-			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x100f9
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x170f9
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x170f9
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x170f9
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x170f9
-			MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
-		>;
-	};
-
-	pinctrl_usdhc3: usdhc3grp {
-		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
-			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10099
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17099
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17099
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17099
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17099
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17099
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17099
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17099
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
-			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
-		>;
-	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-victgo.dtsi b/arch/arm/boot/dts/imx6qdl-victgo.dtsi
new file mode 100644
index 000000000000..386e2ca39424
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-victgo.dtsi
@@ -0,0 +1,658 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2016 Protonic Holland
+ * Copyright (c) 2020 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
+ */
+
+#include <dt-bindings/display/sdtv-standards.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/media/tvp5150.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+/ {
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	backlight_lcd: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_backlight>;
+		pwms = <&pwm1 0 5000000 0>;
+		brightness-levels = <0 16 64 255>;
+		num-interpolated-steps = <16>;
+		default-brightness-level = <48>;
+		power-supply = <&reg_3v3>;
+		enable-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+	};
+
+	backlight_led: backlight_led {
+		compatible = "pwm-backlight";
+		pwms = <&pwm3 0 5000000 0>;
+		brightness-levels = <0 16 64 255>;
+		num-interpolated-steps = <16>;
+		default-brightness-level = <48>;
+		power-supply = <&reg_3v3>;
+	};
+
+	connector {
+		compatible = "composite-video-connector";
+		label = "Composite0";
+		sdtv-standards = <SDTV_STD_PAL_B>;
+
+		port {
+			comp0_out: endpoint {
+				remote-endpoint = <&tvp5150_comp0_in>;
+			};
+		};
+	};
+
+	counter-0 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter0>;
+		gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+	};
+
+	counter-1 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter1>;
+		gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+	};
+
+	counter-2 {
+		compatible = "interrupt-counter";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_counter2>;
+		gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds>;
+
+		led-0 {
+			label = "debug0";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "debug1";
+			function = LED_FUNCTION_DISK;
+			gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "disk-activity";
+		};
+
+		led-2 {
+			label = "power_led";
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_otg_vbus: regulator-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "otg-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "prti6q-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Line", "Line In Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "External Speaker";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"External Speaker", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&ssi1>;
+			system-clock-frequency = <0>; /* Do NOT call fsl_ssi_set_dai_sysclk! */
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			bitclock-master;
+			frame-master;
+		};
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+
+	mux-ssi1 {
+		fsl,audmux-port = <0>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN		0
+			IMX_AUDMUX_V2_PTCR_TFSEL(2)	0
+			IMX_AUDMUX_V2_PTCR_TCSEL(2)	0
+			IMX_AUDMUX_V2_PTCR_TFSDIR	0
+			IMX_AUDMUX_V2_PTCR_TCLKDIR	IMX_AUDMUX_V2_PDCR_RXDSEL(2)
+		>;
+	};
+
+	mux-pins3 {
+		fsl,audmux-port = <2>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN		IMX_AUDMUX_V2_PDCR_RXDSEL(0)
+			0				IMX_AUDMUX_V2_PDCR_TXRXEN
+		>;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1>;
+	termination-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+	termination-ohms = <150>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2>;
+	status = "okay";
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
+};
+
+&ecspi1 {
+	cs-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
+&gpio2 {
+	gpio-line-names =
+		"YACO_WHEEL", "YACO_RADAR", "YACO_PTO", "", "", "", "", "",
+		"", "LED_PWM", "", "", "",
+			"", "", "",
+		"", "", "", "", "", "ISB_IN2", "ISB_nIN1", "ON_SWITCH",
+		"POWER_LED", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"ECSPI1_SCLK", "ECSPI1_MISO", "ECSPI1_MOSI", "ECSPI1_SS1",
+			"CPU_ON1_FB", "USB_OTG_OC", "USB_OTG_PWR", "YACO_IRQ",
+		"TSS_TXD", "TSS_RXD", "", "", "", "", "YACO_BOOT0",
+			"YACO_RESET";
+};
+
+&gpio7 {
+	gpio-line-names =
+		"EMMC_DAT5", "EMMC_DAT4", "EMMC_CMD", "EMMC_CLK", "EMMC_DAT0",
+			"EMMC_DAT1", "EMMC_DAT2", "EMMC_DAT3",
+		"EMMC_RST", "", "", "", "CAM_DETECT", "", "", "",
+		"", "EMMC_DAT7", "EMMC_DAT6", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	codec: audio-codec@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0xa>;
+		#sound-dai-cells = <0>;
+		clocks = <&clks 201>;
+		VDDA-supply = <&reg_3v3>;
+		VDDIO-supply = <&reg_3v3>;
+		VDDD-supply = <&reg_1v8>;
+	};
+
+	video-decoder@5c {
+		compatible = "ti,tvp5150";
+		reg = <0x5c>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tvp5150_comp0_in: endpoint {
+				remote-endpoint = <&comp0_out>;
+			};
+		};
+
+		/* Output port 2 is video output pad */
+		port@2 {
+			reg = <2>;
+
+			tvp5151_to_ipu1_csi0_mux: endpoint {
+				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+			};
+		};
+	};
+
+	/* additional i2c devices are added automatically by the boot loader */
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	adc@49 {
+		compatible = "ti,ads1015";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@4 {
+			reg = <4>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		channel@5 {
+			reg = <5>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		channel@6 {
+			reg = <6>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+
+		channel@7 {
+			reg = <7>;
+			ti,gain = <3>;
+			ti,datarate = <3>;
+		};
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	tsens0: temperature-sensor@70 {
+		compatible = "ti,tmp103";
+		reg = <0x70>;
+		#thermal-sensor-cells = <0>;
+	};
+};
+
+&ipu1_csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu1_csi0>;
+	status = "okay";
+};
+
+&ipu1_csi0_mux_from_parallel_sensor {
+	remote-endpoint = <&tvp5151_to_ipu1_csi0_mux>;
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel@0 {
+		status = "okay";
+
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	phy_type = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	phy_type = "utmi";
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	disable-wp;
+	cap-sd-highspeed;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	no-sd;
+	no-sdio;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_audmux: audmuxgrp {
+		fsl,pins = <
+			/* SGTL5000 sys_mclk */
+			MX6QDL_PAD_CSI0_MCLK__CCM_CLKO1			0x030b0
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x130b0
+		>;
+	};
+
+	pinctrl_backlight: backlightgrp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT7__GPIO4_IO28		0x1b0b0
+		>;
+	};
+
+	pinctrl_can1: can1grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b000
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x3008
+			/* CAN1_SR */
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12			0x13008
+			/* CAN1_TERM */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x1b088
+		>;
+	};
+
+	pinctrl_can2: can2grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b000
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x3008
+			/* CAN2_SR */
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13			0x13008
+		>;
+	};
+
+	pinctrl_counter0: counter0grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00			0x1b000
+		>;
+	};
+
+	pinctrl_counter1: counter1grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01			0x1b000
+		>;
+	};
+
+	pinctrl_counter2: counter2grp {
+		fsl,pins = <
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02			0x1b000
+		>;
+	};
+
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO			0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI			0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK			0x100b1
+			/* CS */
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19			0x000b1
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			/* ITU656_nRESET */
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02			0x1b0b0
+			/* CAM1_MIRROR */
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03			0x130b0
+			/* CAM2_MIRROR */
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x130b0
+			/* CAM_nDETECT */
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x1b0b0
+			/* ISB_IN1 */
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22			0x130b0
+			/* ISB_nIN2 */
+			MX6QDL_PAD_EIM_A17__GPIO2_IO21			0x1b0b0
+			/* WARN_LIGHT */
+			MX6QDL_PAD_EIM_A19__GPIO2_IO19			0x100b0
+			/* ON2_FB */
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02			0x100b0
+			/* YACO_nIRQ */
+			MX6QDL_PAD_EIM_D23__GPIO3_IO23			0x1b0b0
+			/* YACO_BOOT0 */
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30			0x130b0
+			/* YACO_nRESET */
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31			0x1b0b0
+			/* FORCE_ON1 */
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30			0x1b0b0
+			/* AUDIO_nRESET */
+			MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21		0x1f0b0
+			/* ITU656_nPDN */
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b0b0
+
+			/* New in HW revision 1 */
+			/* ON1_FB */
+			MX6QDL_PAD_EIM_D20__GPIO3_IO20			0x100b0
+			/* DIP1_FB */
+			MX6QDL_PAD_DI0_PIN2__GPIO4_IO18			0x1b0b0
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001f8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl_ipu1_csi0: ipu1csi0grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
+		>;
+	};
+
+	pinctrl_leds: ledsgrp {
+		fsl,pins = <
+			/* DEBUG0 */
+			MX6QDL_PAD_DI0_DISP_CLK__GPIO4_IO16		0x1b0b0
+			/* DEBUG1 */
+			MX6QDL_PAD_DI0_PIN15__GPIO4_IO17		0x1b0b0
+			/* POWER_LED */
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24			0x1b0b0
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DISP0_DAT8__PWM1_OUT			0x1b0b0
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b0
+		>;
+	};
+
+	/* YaCO AUX Uart */
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
+		>;
+	};
+
+	/* YaCO Touchscreen UART */
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__USB_OTG_OC			0x1b0b0
+			/* power enable, high active */
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x170f9
+			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x100f9
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x170f9
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x170f9
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x170f9
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x170f9
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01			0x1b0b0
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17099
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10099
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17099
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17099
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17099
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17099
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17099
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17099
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17099
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17099
+			MX6QDL_PAD_SD3_RST__SD3_RESET			0x1b0b1
+		>;
+	};
+};
-- 
2.30.2

