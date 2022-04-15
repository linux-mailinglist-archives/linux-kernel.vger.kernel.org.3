Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8050293A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiDOMA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352866AbiDOL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:46 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1359A994F;
        Fri, 15 Apr 2022 04:57:14 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 409703F642;
        Fri, 15 Apr 2022 13:57:12 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/23] ARM: dts: qcom-msm8974*: Consolidate I2C/UART/SDHCI
Date:   Fri, 15 Apr 2022 13:56:29 +0200
Message-Id: <20220415115633.575010-20-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up and commonize (where possible and it makes sense to) I2C, UART
and SDHCI nodes and pin configurations.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../arm/boot/dts/qcom-apq8074-dragonboard.dts |  61 ++---
 .../boot/dts/qcom-msm8974-fairphone-fp2.dts   |  14 +-
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 117 +--------
 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   |  63 ++---
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 245 +++++++++++++++++-
 .../boot/dts/qcom-msm8974pro-samsung-klte.dts |  78 ++----
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 141 ++--------
 7 files changed, 332 insertions(+), 387 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index f47020cf7a90..3051a861ff0c 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -26,9 +26,6 @@ &blsp2_i2c5 {
 	status = "okay";
 	clock-frequency = <200000>;
 
-	pinctrl-0 = <&i2c11_pins>;
-	pinctrl-names = "default";
-
 	eeprom: eeprom@52 {
 		compatible = "atmel,24c128";
 		reg = <0x52>;
@@ -256,48 +253,25 @@ &sdhc_1 {
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
-	cd-gpios = <&tlmm 62 0x1>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
 
+	cd-gpios = <&tlmm 62 0x1>;
 	vmmc-supply = <&pm8941_l21>;
 	vqmmc-supply = <&pm8941_l13>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 };
 
 &tlmm {
-	i2c11_pins: i2c11 {
-		mux {
-			pins = "gpio83", "gpio84";
-			function = "blsp_i2c11";
-		};
-	};
-
-	spi8_default: spi8_default {
-		mosi {
-			pins = "gpio45";
-			function = "blsp_spi8";
-		};
-		miso {
-			pins = "gpio46";
-			function = "blsp_spi8";
-		};
-		cs {
-			pins = "gpio47";
-			function = "blsp_spi8";
-		};
-		clk {
-			pins = "gpio48";
-			function = "blsp_spi8";
-		};
-	};
-
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
@@ -311,15 +285,7 @@ cmd-data {
 		};
 	};
 
-	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-		pins = "gpio62";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	sdhc2_pin_a: sdhc2-pin-active {
+	sdc2_on: sdc2-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <10>;
@@ -331,5 +297,12 @@ cmd-data {
 			drive-strength = <6>;
 			bias-pull-up;
 		};
+
+		cd {
+			pins = "gpio62";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
index 7056c6f7145d..7ae0b15e50f9 100644
--- a/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts
@@ -321,8 +321,9 @@ &sdhc_1 {
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
@@ -331,12 +332,13 @@ &sdhc_2 {
 	vmmc-supply = <&pm8941_l21>;
 	vqmmc-supply = <&pm8941_l13>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 };
 
 &tlmm {
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
@@ -350,7 +352,7 @@ cmd-data {
 		};
 	};
 
-	sdhc2_pin_a: sdhc2-pin-active {
+	sdc2_on: sdc2-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <10>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 6537950c30ba..7e4e723f1dc3 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -59,9 +59,6 @@ &blsp1_i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-
 	charger: bq24192@6b {
 		compatible = "ti,bq24192";
 		reg = <0x6b>;
@@ -93,9 +90,6 @@ &blsp1_i2c2 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
 	synaptics@70 {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x70>;
@@ -126,9 +120,6 @@ &blsp1_i2c3 {
 	status = "okay";
 	clock-frequency = <100000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c3_pins>;
-
 	avago_apds993@39 {
 		compatible = "avago,apds9930";
 		reg = <0x39>;
@@ -144,9 +135,6 @@ &blsp2_i2c5 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c11_pins>;
-
 	led-controller@38 {
 		compatible = "ti,lm3630a";
 		status = "okay";
@@ -168,9 +156,6 @@ &blsp2_i2c6 {
 	status = "okay";
 	clock-frequency = <100000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c12_pins>;
-
 	mpu6515@68 {
 		compatible = "invensense,mpu6515";
 		reg = <0x68>;
@@ -212,9 +197,6 @@ &blsp1_uart1 {
 &blsp2_uart4 {
 	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&blsp2_uart4_pin_a>;
-
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <3000000>;
@@ -533,8 +515,9 @@ &sdhc_1 {
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
@@ -545,11 +528,9 @@ &sdhc_2 {
 	vqmmc-supply = <&pm8941_s3>;
 	non-removable;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a>;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 
 	bcrmf@1 {
 		compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
@@ -563,7 +544,7 @@ bcrmf@1 {
 };
 
 &tlmm {
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
@@ -577,7 +558,7 @@ cmd-data {
 		};
 	};
 
-	sdhc2_pin_a: sdhc2-pin-active {
+	sdc2_on: sdc2-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <6>;
@@ -591,54 +572,6 @@ cmd-data {
 		};
 	};
 
-	i2c1_pins: i2c1 {
-		mux {
-			pins = "gpio2", "gpio3";
-			function = "blsp_i2c1";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c2_pins: i2c2 {
-		mux {
-			pins = "gpio6", "gpio7";
-			function = "blsp_i2c2";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c3_pins: i2c3 {
-		mux {
-			pins = "gpio10", "gpio11";
-			function = "blsp_i2c3";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c11_pins: i2c11 {
-		mux {
-			pins = "gpio83", "gpio84";
-			function = "blsp_i2c11";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c12_pins: i2c12 {
-		mux {
-			pins = "gpio87", "gpio88";
-			function = "blsp_i2c12";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
 	mpu6515_pin: mpu6515 {
 		irq {
 			pins = "gpio73";
@@ -693,38 +626,4 @@ shutdown {
 			function = "gpio";
 		};
 	};
-
-	blsp2_uart4_pin_a: blsp2-uart4-pin-active {
-		tx {
-			pins = "gpio53";
-			function = "blsp_uart10";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-
-		rx {
-			pins = "gpio54";
-			function = "blsp_uart10";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		cts {
-			pins = "gpio55";
-			function = "blsp_uart10";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		rts {
-			pins = "gpio56";
-			function = "blsp_uart10";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
index 870e0aeb4d05..c2e423d2a21e 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-rhine.dtsi
@@ -55,9 +55,6 @@ &blsp1_i2c2 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
 	synaptics@2c {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x2c>;
@@ -90,9 +87,6 @@ rmi4-f11@11 {
 
 &blsp1_uart2 {
 	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&blsp1_uart2_pin_a>;
 };
 
 &blsp2_dma {
@@ -350,8 +344,9 @@ &sdhc_1 {
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
@@ -362,8 +357,9 @@ &sdhc_2 {
 
 	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 };
 
 &smbb {
@@ -389,35 +385,7 @@ pin {
 		};
 	};
 
-	blsp1_uart2_pin_a: blsp1-uart2-pin-active {
-		rx {
-			pins = "gpio5";
-			function = "blsp_uart2";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		tx {
-			pins = "gpio4";
-			function = "blsp_uart2";
-
-			drive-strength = <4>;
-			bias-disable;
-		};
-	};
-
-	i2c2_pins: i2c2 {
-		mux {
-			pins = "gpio6", "gpio7";
-			function = "blsp_i2c2";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
@@ -431,15 +399,7 @@ cmd-data {
 		};
 	};
 
-	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-		pins = "gpio62";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-		};
-
-	sdhc2_pin_a: sdhc2-pin-active {
+	sdc2_on: sdc-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <10>;
@@ -451,5 +411,12 @@ cmd-data {
 			drive-strength = <6>;
 			bias-pull-up;
 		};
+
+		cd {
+			pins = "gpio62";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index a34e8262d315..2a3dfbb29e9f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -466,6 +466,9 @@ sdhc_3: sdhci@f9864900 {
 			clock-names = "core", "iface", "xo";
 			bus-width = <4>;
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			status = "disabled";
 		};
 
@@ -482,6 +485,9 @@ sdhc_2: sdhci@f98a4900 {
 			clock-names = "core", "iface", "xo";
 			bus-width = <4>;
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			status = "disabled";
 		};
 
@@ -510,6 +516,9 @@ blsp1_i2c1: i2c@f9923000 {
 			interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c1_default>;
+			pinctrl-1 = <&blsp1_i2c1_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -521,6 +530,9 @@ blsp1_i2c2: i2c@f9924000 {
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c2_default>;
+			pinctrl-1 = <&blsp1_i2c2_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -532,6 +544,9 @@ blsp1_i2c3: i2c@f9925000 {
 			interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c3_default>;
+			pinctrl-1 = <&blsp1_i2c3_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -543,6 +558,9 @@ blsp1_i2c6: i2c@f9928000 {
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c6_default>;
+			pinctrl-1 = <&blsp1_i2c6_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -591,6 +609,9 @@ blsp2_i2c2: i2c@f9964000 {
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c2_default>;
+			pinctrl-1 = <&blsp2_i2c2_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -602,10 +623,13 @@ blsp2_i2c5: i2c@f9967000 {
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
 			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c5_default>;
+			pinctrl-1 = <&blsp2_i2c5_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		blsp2_i2c6: i2c@f9968000 {
@@ -1185,6 +1209,223 @@ tlmm: pinctrl@fd510000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+			sdc1_off: sdc1-off {
+				clk {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			sdc2_off: sdc2-off {
+				clk {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				cd {
+					pins = "gpio54";
+					bias-disable;
+					drive-strength = <2>;
+				};
+			};
+
+			blsp1_uart2_active: blsp1-uart2-active {
+				rx {
+					pins = "gpio5";
+					function = "blsp_uart2";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				tx {
+					pins = "gpio4";
+					function = "blsp_uart2";
+					drive-strength = <4>;
+					bias-disable;
+				};
+			};
+
+			blsp2_uart1_active: blsp2-uart1-active {
+				tx-rts {
+					pins = "gpio41", "gpio44";
+					function = "blsp_uart7";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx-cts {
+					pins = "gpio42", "gpio43";
+					function = "blsp_uart7";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			blsp2_uart1_sleep: blsp2-uart1-sleep {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_uart4_active: blsp2-uart4-active {
+				tx-rts {
+					pins = "gpio53", "gpio56";
+					function = "blsp_uart10";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx-cts {
+					pins = "gpio54", "gpio55";
+					function = "blsp_uart10";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			blsp1_i2c1_default: blsp1-i2c1-default {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c1_sleep: blsp1-i2c1-sleep {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			blsp1_i2c2_default: blsp1-i2c2-default {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c2_sleep: blsp1-i2c2-sleep {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			blsp1_i2c3_default: blsp1-i2c3-default {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c3_sleep: blsp1-i2c3-sleep {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			/* BLSP1_I2C4 info is missing */
+
+			/* BLSP1_I2C5 info is missing */
+
+			blsp1_i2c6_default: blsp1-i2c6-default {
+				pins = "gpio29", "gpio30";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c6_sleep: blsp1-i2c6-sleep {
+				pins = "gpio29", "gpio30";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+			/* 6 interfaces per QUP, BLSP2 indexes are numbered (n)+6 */
+
+			/* BLSP2_I2C1 info is missing */
+
+			blsp2_i2c2_default: blsp2-i2c2-default {
+				pins = "gpio47", "gpio48";
+				function = "blsp_i2c8";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep {
+				pins = "gpio47", "gpio48";
+				function = "blsp_i2c8";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			/* BLSP2_I2C3 info is missing */
+
+			/* BLSP2_I2C4 info is missing */
+
+			blsp2_i2c5_default: blsp2-i2c5-default {
+				pins = "gpio83", "gpio84";
+				function = "blsp_i2c11";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c5_sleep: blsp2-i2c5-sleep {
+				pins = "gpio83", "gpio84";
+				function = "blsp_i2c11";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			/* BLSP2_I2C6 info is missing - nobody uses it though? */
+
+			spi8_default: spi8_default {
+				mosi {
+					pins = "gpio45";
+					function = "blsp_spi8";
+				};
+				miso {
+					pins = "gpio46";
+					function = "blsp_spi8";
+				};
+				cs {
+					pins = "gpio47";
+					function = "blsp_spi8";
+				};
+				clk {
+					pins = "gpio48";
+					function = "blsp_spi8";
+				};
+			};
 		};
 
 		mmcc: clock-controller@fd8c0000 {
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
index 823dda35fb16..f230a657d0f3 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-samsung-klte.dts
@@ -161,9 +161,6 @@ vreg_panel: panel-regulator {
 &blsp1_i2c2 {
 	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-
 	touchscreen@20 {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x20>;
@@ -197,9 +194,6 @@ rmi4-f12@12 {
 &blsp1_i2c6 {
 	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c6_pins>;
-
 	pmic@60 {
 		reg = <0x60>;
 		compatible = "maxim,max77826";
@@ -300,9 +294,6 @@ &blsp1_uart2 {
 &blsp2_i2c6 {
 	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c12_pins>;
-
 	fuelgauge@36 {
 		compatible = "maxim,max17048";
 		reg = <0x36>;
@@ -668,24 +659,21 @@ &sdhc_1 {
 	vmmc-supply = <&pma8084_l20>;
 	vqmmc-supply = <&pma8084_s4>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 	max-frequency = <100000000>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc3_pin_a>;
-
 	vmmc-supply = <&vreg_wlan>;
 	vqmmc-supply = <&pma8084_s4>;
-
 	non-removable;
 
-	#address-cells = <1>;
-	#size-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 
 	wifi@1 {
 		reg = <1>;
@@ -703,7 +691,6 @@ wifi@1 {
 &sdhc_3 {
 	status = "okay";
 	max-frequency = <100000000>;
-
 	vmmc-supply = <&pma8084_l21>;
 	vqmmc-supply = <&pma8084_l13>;
 
@@ -713,11 +700,12 @@ &sdhc_3 {
 	 * cd-gpios the driver resorts to polling, so hotplug works.
 	 */
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a /* &sdhc2_cd_pin */>;
+	pinctrl-0 = <&sdc3_on /* &sdhc3_cd_pin */>;
 	/* cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>; */
 };
 
 &tlmm {
+	/* This seems suspicious, but somebody with this device should look into it. */
 	blsp2_uart2_pins_active: blsp2-uart2-pins-active {
 		pins = "gpio45", "gpio46", "gpio47", "gpio48";
 		function = "blsp_uart8";
@@ -732,6 +720,7 @@ blsp2_uart2_pins_sleep: blsp2-uart2-pins-sleep {
 		bias-pull-down;
 	};
 
+
 	bt_pins: bt-pins {
 		hostwake {
 			pins = "gpio75";
@@ -747,7 +736,7 @@ devwake {
 		};
 	};
 
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdhc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <4>;
@@ -761,17 +750,14 @@ cmd-data {
 		};
 	};
 
-	sdhc2_pin_a: sdhc2-pin-active {
-		clk-cmd-data {
-			pins = "gpio35", "gpio36", "gpio37", "gpio38",
-				"gpio39", "gpio40";
-			function = "sdc3";
-			drive-strength = <8>;
-			bias-disable;
-		};
+	sdc3_on: sdc3-on {
+		pins = "gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
+		function = "sdc3";
+		drive-strength = <8>;
+		bias-disable;
 	};
 
-	sdhc2_cd_pin: sdhc2-cd {
+	sdhc3_cd_pin: sdc3-cd-on {
 		pins = "gpio62";
 		function = "gpio";
 
@@ -779,7 +765,7 @@ sdhc2_cd_pin: sdhc2-cd {
 		bias-disable;
 	};
 
-	sdhc3_pin_a: sdhc3-pin-active {
+	sdc2_on: sdhc2-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <6>;
@@ -793,36 +779,6 @@ cmd-data {
 		};
 	};
 
-	i2c2_pins: i2c2 {
-		mux {
-			pins = "gpio6", "gpio7";
-			function = "blsp_i2c2";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c6_pins: i2c6 {
-		mux {
-			pins = "gpio29", "gpio30";
-			function = "blsp_i2c6";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c12_pins: i2c12 {
-		mux {
-			pins = "gpio87", "gpio88";
-			function = "blsp_i2c12";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
 	i2c_touchkey_pins: i2c-touchkey {
 		mux {
 			pins = "gpio95", "gpio96";
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index b8b6447b3217..465d01da9d69 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -99,18 +99,12 @@ vreg_wlan: wlan-regulator {
 
 &blsp1_uart2 {
 	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&blsp1_uart2_pin_a>;
 };
 
 &blsp2_i2c2 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c8_pins>;
-
 	synaptics@2c {
 		compatible = "syna,rmi4-i2c";
 		reg = <0x2c>;
@@ -146,9 +140,6 @@ &blsp2_i2c5 {
 	status = "okay";
 	clock-frequency = <355000>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c11_pins>;
-
 	lp8566_wled: backlight@2c {
 		compatible = "ti,lp8556";
 		reg = <0x2c>;
@@ -207,17 +198,12 @@ rom_aeh {
 &blsp2_uart1 {
 	status = "okay";
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&blsp2_uart7_pin_a>;
-
 	bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		max-speed = <3000000>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake_pin>,
-				<&bt_dev_wake_pin>,
-				<&bt_reg_on_pin>;
+		pinctrl-0 = <&bt_host_wake_pin>, <&bt_dev_wake_pin>, <&bt_reg_on_pin>;
 
 		host-wakeup-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
 		device-wakeup-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
@@ -478,8 +464,9 @@ &sdhc_1 {
 	vmmc-supply = <&pm8941_l20>;
 	vqmmc-supply = <&pm8941_s3>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc1_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
 };
 
 &sdhc_2 {
@@ -490,8 +477,9 @@ &sdhc_2 {
 
 	cd-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 
-	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_on>;
+	pinctrl-1 = <&sdc2_off>;
 };
 
 &sdhc_3 {
@@ -502,7 +490,7 @@ &sdhc_3 {
 	non-removable;
 
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdhc3_pin_a>;
+	pinctrl-0 = <&sdc3_on>;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -530,78 +518,6 @@ &smbb {
 };
 
 &tlmm {
-	blsp1_uart2_pin_a: blsp1-uart2-pin-active {
-		rx {
-			pins = "gpio5";
-			function = "blsp_uart2";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		tx {
-			pins = "gpio4";
-			function = "blsp_uart2";
-
-			drive-strength = <4>;
-			bias-disable;
-		};
-	};
-
-	blsp2_uart7_pin_a: blsp2-uart7-pin-active {
-		tx {
-			pins = "gpio41";
-			function = "blsp_uart7";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-
-		rx {
-			pins = "gpio42";
-			function = "blsp_uart7";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		cts {
-			pins = "gpio43";
-			function = "blsp_uart7";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-
-		rts {
-			pins = "gpio44";
-			function = "blsp_uart7";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c8_pins: i2c8 {
-		mux {
-			pins = "gpio47", "gpio48";
-			function = "blsp_i2c8";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	i2c11_pins: i2c11 {
-		mux {
-			pins = "gpio83", "gpio84";
-			function = "blsp_i2c11";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
 	lcd_backlight_en_pin_a: lcd-backlight-vddio {
 		pins = "gpio69";
 		drive-strength = <10>;
@@ -609,7 +525,7 @@ lcd_backlight_en_pin_a: lcd-backlight-vddio {
 		bias-disable;
 	};
 
-	sdhc1_pin_a: sdhc1-pin-active {
+	sdc1_on: sdc1-on {
 		clk {
 			pins = "sdc1_clk";
 			drive-strength = <16>;
@@ -623,15 +539,7 @@ cmd-data {
 		};
 	};
 
-	sdhc2_cd_pin_a: sdhc2-cd-pin-active {
-		pins = "gpio62";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-		};
-
-	sdhc2_pin_a: sdhc2-pin-active {
+	sdc2_on: sdc2-on {
 		clk {
 			pins = "sdc2_clk";
 			drive-strength = <6>;
@@ -643,13 +551,19 @@ cmd-data {
 			drive-strength = <6>;
 			bias-pull-up;
 		};
+
+		cd {
+			pins = "gpio62";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
 	};
 
-	sdhc3_pin_a: sdhc3-pin-active {
+	sdc3_on: sdc3-on {
 		clk {
 			pins = "gpio40";
 			function = "sdc3";
-
 			drive-strength = <10>;
 			bias-disable;
 		};
@@ -657,7 +571,6 @@ clk {
 		cmd {
 			pins = "gpio39";
 			function = "sdc3";
-
 			drive-strength = <10>;
 			bias-pull-up;
 		};
@@ -665,27 +578,22 @@ cmd {
 		data {
 			pins = "gpio35", "gpio36", "gpio37", "gpio38";
 			function = "sdc3";
-
 			drive-strength = <10>;
 			bias-pull-up;
 		};
 	};
 
-	ts_int_pin: synaptics {
-		pin {
-			pins = "gpio86";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-disable;
-			input-enable;
-		};
+	ts_int_pin: ts-int-pin {
+		pins = "gpio86";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
 	};
 
 	bt_host_wake_pin: bt-host-wake {
 		pins = "gpio95";
 		function = "gpio";
-
 		drive-strength = <2>;
 		bias-disable;
 		output-low;
@@ -694,7 +602,6 @@ bt_host_wake_pin: bt-host-wake {
 	bt_dev_wake_pin: bt-dev-wake {
 		pins = "gpio96";
 		function = "gpio";
-
 		drive-strength = <2>;
 		bias-disable;
 	};
-- 
2.35.2

