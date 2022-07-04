Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66B564AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiGDAWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGDAWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:22:20 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2685163F2;
        Sun,  3 Jul 2022 17:21:59 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:21:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 04AAD2011974;
        Mon,  4 Jul 2022 09:21:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:21:39 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 903321DDD;
        Mon,  4 Jul 2022 09:21:38 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/9] arm64: dts: uniphier: Use GIC interrupt definitions
Date:   Mon,  4 Jul 2022 09:21:10 +0900
Message-Id: <1656894074-15751-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1656894074-15751-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use human-readable definitions for GIC interrupt type and flag, instead of
hard-coding the numbers. No functional change.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11-ref.dts  |  4 +-
 .../boot/dts/socionext/uniphier-ld11.dtsi     | 51 ++++++++--------
 .../dts/socionext/uniphier-ld20-akebi96.dts   |  2 +-
 .../boot/dts/socionext/uniphier-ld20-ref.dts  |  4 +-
 .../boot/dts/socionext/uniphier-ld20.dtsi     | 60 ++++++++++---------
 .../boot/dts/socionext/uniphier-pxs3-ref.dts  |  4 +-
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 56 ++++++++---------
 7 files changed, 93 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 41b47f5d2ed7..414aeb99e68f 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -39,11 +39,11 @@ memory@80000000 {
 };
 
 &ethsc {
-	interrupts = <0 8>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serialsc {
-	interrupts = <0 8>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serial0 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 6fa4de24526a..6a7d7973e9dd 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "socionext,uniphier-ld11";
@@ -102,10 +103,10 @@ emmc_pwrseq: emmc-pwrseq {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 4>,
-			     <1 14 4>,
-			     <1 11 4>,
-			     <1 10 4>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	reserved-memory {
@@ -131,7 +132,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -144,7 +145,7 @@ spi1: spi@54006100 {
 			reg = <0x54006100 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 216 4>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
 			clocks = <&peri_clk 12>;
@@ -155,7 +156,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -166,7 +167,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -177,7 +178,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -188,7 +189,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -223,7 +224,7 @@ gpio: gpio@55000000 {
 		audio@56000000 {
 			compatible = "socionext,uniphier-ld11-aio";
 			reg = <0x56000000 0x80000>;
-			interrupts = <0 144 4>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_aout1>,
 				    <&pinctrl_aoutiec1>;
@@ -323,7 +324,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -337,7 +338,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -350,7 +351,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 6>;
 			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
@@ -362,7 +363,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -376,7 +377,7 @@ i2c4: i2c@58784000 {
 			reg = <0x58784000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 45 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c4>;
 			clocks = <&peri_clk 8>;
@@ -389,7 +390,7 @@ i2c5: i2c@58785000 {
 			reg = <0x58785000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 9>;
 			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
@@ -440,7 +441,7 @@ peri_rst: reset {
 		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
@@ -460,7 +461,7 @@ usb0: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
-			interrupts = <0 243 4>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
@@ -476,7 +477,7 @@ usb1: usb@5a810100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
-			interrupts = <0 244 4>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
@@ -492,7 +493,7 @@ usb2: usb@5a820100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a820100 0x100>;
-			interrupts = <0 245 4>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 10>,
@@ -573,7 +574,7 @@ efuse@200 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -591,7 +592,7 @@ gic: interrupt-controller@5fe00000 {
 			      <0x5fe40000 0x80000>;	/* GICR */
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 4>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		sysctrl@61840000 {
@@ -618,7 +619,7 @@ eth: ethernet@65000000 {
 			compatible = "socionext,uniphier-ld11-ave4";
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "ether";
 			clocks = <&sys_clk 6>;
 			reset-names = "ether";
@@ -640,7 +641,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
index b55b70ded015..fba454adae7d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
@@ -110,7 +110,7 @@ usb-over-spi@0 {
 		spi-max-frequency = <12500000>;
 		interrupt-parent = <&gpio>;
 		interrupt-names = "udc";
-		interrupts = <0 2>;
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 8c111588c9a1..a5f2083f8b75 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -39,11 +39,11 @@ memory@80000000 {
 };
 
 &ethsc {
-	interrupts = <0 8>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serialsc {
-	interrupts = <0 8>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serial0 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index debab9f0e3e1..62e5892b4f8e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -176,10 +177,10 @@ emmc_pwrseq: emmc-pwrseq {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 4>,
-			     <1 14 4>,
-			     <1 11 4>,
-			     <1 10 4>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	thermal-zones {
@@ -236,7 +237,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -249,7 +250,7 @@ spi1: spi@54006100 {
 			reg = <0x54006100 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 216 4>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
 			clocks = <&peri_clk 12>;
@@ -262,7 +263,7 @@ spi2: spi@54006200 {
 			reg = <0x54006200 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 229 4>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi2>;
 			clocks = <&peri_clk 13>;
@@ -275,7 +276,7 @@ spi3: spi@54006300 {
 			reg = <0x54006300 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 230 4>;
+			interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi3>;
 			clocks = <&peri_clk 14>;
@@ -286,7 +287,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -297,7 +298,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -308,7 +309,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -319,7 +320,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -348,7 +349,7 @@ gpio: gpio@55000000 {
 		audio@56000000 {
 			compatible = "socionext,uniphier-ld20-aio";
 			reg = <0x56000000 0x80000>;
-			interrupts = <0 144 4>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_aout1>,
 				    <&pinctrl_aoutiec1>;
@@ -448,7 +449,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -462,7 +463,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -475,7 +476,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 6>;
 			resets = <&peri_rst 6>;
 			clock-frequency = <400000>;
@@ -487,7 +488,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -501,7 +502,7 @@ i2c4: i2c@58784000 {
 			reg = <0x58784000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 45 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c4>;
 			clocks = <&peri_clk 8>;
@@ -514,7 +515,7 @@ i2c5: i2c@58785000 {
 			reg = <0x58785000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 9>;
 			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
@@ -570,7 +571,7 @@ peri_rst: reset {
 		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
@@ -590,7 +591,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sd>;
 			clocks = <&sd_clk 0>;
@@ -675,7 +676,7 @@ usb_hs_i2: trim@5a,0 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -693,7 +694,7 @@ gic: interrupt-controller@5fe00000 {
 			      <0x5fe80000 0x80000>;	/* GICR */
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 4>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		sysctrl@61840000 {
@@ -717,7 +718,7 @@ watchdog {
 
 			pvtctl: thermal-sensor {
 				compatible = "socionext,uniphier-ld20-thermal";
-				interrupts = <0 3 4>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <0>;
 				socionext,tmod-calibration = <0x0f22 0x68ee>;
 			};
@@ -727,7 +728,7 @@ eth: ethernet@65000000 {
 			compatible = "socionext,uniphier-ld20-ave4";
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
 			clock-names = "ether";
@@ -749,7 +750,7 @@ usb: usb@65a00000 {
 			status = "disabled";
 			reg = <0x65a00000 0xcd00>;
 			interrupt-names = "host";
-			interrupts = <0 134 4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb1>,
 				    <&pinctrl_usb2>, <&pinctrl_usb3>;
@@ -915,7 +916,8 @@ pcie: pcie@66000000 {
 				<0x82000000 0 0x20000000 0x20000000 0 0x0ffe0000>;
 			#interrupt-cells = <1>;
 			interrupt-names = "dma", "msi";
-			interrupts = <0 224 4>, <0 225 4>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
 					<0 0 0 2 &pcie_intc 1>,	/* INTB */
@@ -928,7 +930,7 @@ pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 226 4>;
+				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -950,7 +952,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index feb070f934e9..506c7b9ff50d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -40,11 +40,11 @@ memory@80000000 {
 };
 
 &ethsc {
-	interrupts = <4 8>;
+	interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serialsc {
-	interrupts = <4 8>;
+	interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &spi0 {
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index e96e7ed98717..7304dee2e504 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -135,10 +136,10 @@ emmc_pwrseq: emmc-pwrseq {
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <1 13 4>,
-			     <1 14 4>,
-			     <1 11 4>,
-			     <1 10 4>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	thermal-zones {
@@ -195,7 +196,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -208,7 +209,7 @@ spi1: spi@54006100 {
 			reg = <0x54006100 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 216 4>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
 			clocks = <&peri_clk 12>;
@@ -219,7 +220,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -230,7 +231,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -241,7 +242,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -252,7 +253,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -284,7 +285,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -298,7 +299,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -312,7 +313,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -326,7 +327,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -340,7 +341,7 @@ i2c6: i2c@58786000 {
 			reg = <0x58786000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 26 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 10>;
 			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
@@ -396,7 +397,7 @@ peri_rst: reset {
 		emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
 			reg = <0x5a000000 0x400>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sys_clk 4>;
@@ -416,7 +417,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
@@ -505,7 +506,7 @@ usb_hs_i2: trim@5a,0 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -523,7 +524,7 @@ gic: interrupt-controller@5fe00000 {
 			      <0x5fe80000 0x80000>;	/* GICR */
 			interrupt-controller;
 			#interrupt-cells = <3>;
-			interrupts = <1 9 4>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		sysctrl@61840000 {
@@ -547,7 +548,7 @@ watchdog {
 
 			pvtctl: thermal-sensor {
 				compatible = "socionext,uniphier-pxs3-thermal";
-				interrupts = <0 3 4>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <0>;
 				socionext,tmod-calibration = <0x0f22 0x68ee>;
 			};
@@ -557,7 +558,7 @@ eth0: ethernet@65000000 {
 			compatible = "socionext,uniphier-pxs3-ave4";
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
 			clock-names = "ether";
@@ -578,7 +579,7 @@ eth1: ethernet@65200000 {
 			compatible = "socionext,uniphier-pxs3-ave4";
 			status = "disabled";
 			reg = <0x65200000 0x8500>;
-			interrupts = <0 67 4>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether1_rgmii>;
 			clock-names = "ether";
@@ -600,7 +601,7 @@ usb0: usb@65a00000 {
 			status = "disabled";
 			reg = <0x65a00000 0xcd00>;
 			interrupt-names = "dwc_usb3";
-			interrupts = <0 134 4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb2>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -702,7 +703,7 @@ usb1: usb@65c00000 {
 			status = "disabled";
 			reg = <0x65c00000 0xcd00>;
 			interrupt-names = "dwc_usb3";
-			interrupts = <0 137 4>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>, <&pinctrl_usb3>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -812,7 +813,8 @@ pcie: pcie@66000000 {
 				<0x82000000 0 0x20000000 0x20000000 0 0x0ffe0000>;
 			#interrupt-cells = <1>;
 			interrupt-names = "dma", "msi";
-			interrupts = <0 224 4>, <0 225 4>;
+			interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
 					<0 0 0 2 &pcie_intc 1>,	/* INTB */
@@ -825,7 +827,7 @@ pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
 				#interrupt-cells = <1>;
 				interrupt-parent = <&gic>;
-				interrupts = <0 226 4>;
+				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -847,7 +849,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
-- 
2.25.1

