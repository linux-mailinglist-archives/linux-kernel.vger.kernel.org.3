Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548E4E53AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiCWN6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242324AbiCWN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:58:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D747DE3E;
        Wed, 23 Mar 2022 06:57:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 189301F42E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648043818;
        bh=mWjnVUyljPCx6yHFuusfX4leGM+bnmiEtQmrfkcCWe0=;
        h=From:To:Cc:Subject:Date:From;
        b=AJgFaQaaDAEIeCo8XIzkDJredMfoMy+Y2NBFbuegCi3IZWlZiprmEKBvHXAnyxWcG
         sMVdX6tG1q8uF7j5E+MXt6dD+1olY8IU2PdHKfaGNZYEewJKMPhRzj5aTwbCBQmFf6
         Es9UQ9Z+M1Nc3gEIVc7Lrv5zLPwYX5De45s5ERtd00/1hGq1E92mKmMXRcBfjS50Xd
         Y3vCVNe4ZlZyELHb+MnX6BJK5XFLKM75xVEC65EwG6+1z7ot0zFjJdCCvmy6GXDixO
         KgHzxC7LE8YSY2C1Yb1gmr4D8A65HW2fXiyKcxiwLD3bG1c4EJnAgzsSULGhN1nRfY
         gBPxClHMJ4g6A==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Cc:     ariel.dalessandro@collabora.com, broonie@kernel.org,
        festevam@gmail.com, krzysztof.kozlowski@canonical.com,
        lgirdwood@gmail.com, michael@amarulasolutions.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx audio card node
Date:   Wed, 23 Mar 2022 10:56:01 -0300
Message-Id: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BSH SystemMaster (SMM) S2 PRO board comes with an audio card based on
tlv320aic31xx family codec.

The audio card exposes two playback devices, one of them using the EASRC
(Enhanced Asynchronous Sample Rate Converter) module. Note that this
would require SDMA and EASRC firmware in order to work.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
index c6a8ed6745c1..fbbb3367037b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "imx8mn-bsh-smm-s2-common.dtsi"
+#include <dt-bindings/sound/tlv320aic31xx.h>
 
 / {
 	model = "BSH SMM S2 PRO";
@@ -16,6 +17,65 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x0 0x20000000>;
 	};
+
+	sound-tlv320aic31xx {
+		compatible = "fsl,imx-audio-tlv320aic31xx";
+		model = "tlv320aic31xx-hifi";
+		audio-cpu = <&sai3>;
+		audio-codec = <&tlv320dac3101>;
+		audio-asrc = <&easrc>;
+		audio-routing =
+			"Ext Spk", "SPL",
+			"Ext Spk", "SPR";
+		mclk-id = <PLL_CLKIN_BCLK>;
+	};
+
+	vdd_input: vdd_input {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_input";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+};
+
+&easrc {
+	fsl,asrc-rate = <48000>;
+	fsl,asrc-format = <10>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	tlv320dac3101: audio-codec@18 {
+		compatible = "ti,tlv320dac3101";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dac_rst>;
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		HPVDD-supply = <&buck4_reg>;
+		SPRVDD-supply = <&vdd_input>;
+		SPLVDD-supply = <&vdd_input>;
+		AVDD-supply = <&buck4_reg>;
+		IOVDD-supply = <&buck4_reg>;
+		DVDD-supply = <&buck5_reg>;
+		reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		ai31xx-micbias-vg = <MICBIAS_AVDDV>;
+		clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
+	};
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
 };
 
 /* eMMC */
@@ -30,6 +90,36 @@ &usdhc1 {
 };
 
 &iomuxc {
+	pinctrl_dac_rst: dacrstgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* DAC_RST */
+		>;
+	};
+
+	pinctrl_espi2: espi2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK		0x082
+			MX8MN_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI		0x082
+			MX8MN_IOMUXC_ECSPI2_MISO_ECSPI2_MISO		0x082
+			MX8MN_IOMUXC_ECSPI2_SS0_ECSPI2_SS0		0x040
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL			0x400000c3
+			MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA			0x400000c3
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC		0xd6
+			MX8MN_IOMUXC_SAI3_TXC_SAI3_TX_BCLK		0xd6
+			MX8MN_IOMUXC_SAI3_TXD_SAI3_TX_DATA0		0xd6
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000090
-- 
2.34.1

