Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CB564AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiGDAV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiGDAVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:21:03 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B99B42AD1;
        Sun,  3 Jul 2022 17:20:59 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:20:55 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id ABEDE205845A;
        Mon,  4 Jul 2022 09:20:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:20:55 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 664BD1DDD;
        Mon,  4 Jul 2022 09:20:55 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/9] ARM: dts: uniphier: Use GIC interrupt definitions
Date:   Mon,  4 Jul 2022 09:20:22 +0900
Message-Id: <1656894026-15707-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
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
 arch/arm/boot/dts/uniphier-ld4-ref.dts  |  4 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi     | 49 +++++++++++--------
 arch/arm/boot/dts/uniphier-ld6b-ref.dts |  4 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts |  4 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi    | 64 +++++++++++++++----------
 arch/arm/boot/dts/uniphier-pro5.dtsi    | 50 ++++++++++---------
 arch/arm/boot/dts/uniphier-pxs2.dtsi    | 56 ++++++++++++----------
 arch/arm/boot/dts/uniphier-sld8-ref.dts |  4 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi    | 49 +++++++++++--------
 9 files changed, 163 insertions(+), 121 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index e2d25c9160bd..e007db084787 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -36,11 +36,11 @@ memory@80000000 {
 };
 
 &ethsc {
-	interrupts = <1 8>;
+	interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serialsc {
-	interrupts = <1 8>;
+	interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serial0 {
diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index b52957ccda0d..9dceff12a633 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -6,6 +6,7 @@
 //   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "socionext,uniphier-ld4";
@@ -55,7 +56,8 @@ l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(512 * 1024)>;
 			cache-sets = <256>;
@@ -69,7 +71,7 @@ spi: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -80,7 +82,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -91,7 +93,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -102,7 +104,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -113,7 +115,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 29 4>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -140,7 +142,7 @@ i2c0: i2c@58400000 {
 			reg = <0x58400000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 1>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -154,7 +156,7 @@ i2c1: i2c@58480000 {
 			reg = <0x58480000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 1>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -168,7 +170,7 @@ i2c2: i2c@58500000 {
 			reg = <0x58500000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 1>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -182,7 +184,7 @@ i2c3: i2c@58580000 {
 			reg = <0x58580000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 1>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -240,8 +242,13 @@ peri_rst: reset {
 		dmac: dma-controller@5a000000 {
 			compatible = "socionext,uniphier-mio-dmac";
 			reg = <0x5a000000 0x1000>;
-			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
-				     <0 71 4>, <0 72 4>, <0 73 4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mio_clk 7>;
 			resets = <&mio_rst 7>;
 			#dma-cells = <1>;
@@ -251,7 +258,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
@@ -271,7 +278,7 @@ emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&mio_clk 1>;
@@ -289,7 +296,7 @@ usb0: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
-			interrupts = <0 80 4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
@@ -303,7 +310,7 @@ usb1: usb@5a810100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
-			interrupts = <0 81 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
@@ -317,7 +324,7 @@ usb2: usb@5a820100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a820100 0x100>;
-			interrupts = <0 82 4>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 10>,
@@ -358,14 +365,16 @@ efuse@130 {
 		timer@60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x104>;
+			interrupts = <GIC_PPI 11
+				(GIC_CPU_MASK_RAW(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer@60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x104>;
+			interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_RAW(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
@@ -407,7 +416,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 4f5e8848cecf..223a78b4a761 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
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
 
 &serial0 {
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index cc2cae935b5d..48f7f23bab91 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -39,11 +39,11 @@ memory@80000000 {
 };
 
 &ethsc {
-	interrupts = <2 8>;
+	interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serialsc {
-	interrupts = <2 8>;
+	interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 };
 
 &serial0 {
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index cf62821c69ca..7102c3de8db2 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -6,6 +6,7 @@
 //   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "socionext,uniphier-pro4";
@@ -63,7 +64,8 @@ l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(768 * 1024)>;
 			cache-sets = <256>;
@@ -77,7 +79,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -88,7 +90,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -99,7 +101,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -110,7 +112,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -121,7 +123,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -148,7 +150,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -162,7 +164,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -176,7 +178,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -190,7 +192,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -206,7 +208,7 @@ i2c5: i2c@58785000 {
 			reg = <0x58785000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 9>;
 			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
@@ -218,7 +220,7 @@ i2c6: i2c@58786000 {
 			reg = <0x58786000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 26 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 10>;
 			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
@@ -274,8 +276,14 @@ peri_rst: reset {
 		dmac: dma-controller@5a000000 {
 			compatible = "socionext,uniphier-mio-dmac";
 			reg = <0x5a000000 0x1000>;
-			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
-				     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mio_clk 7>;
 			resets = <&mio_rst 7>;
 			#dma-cells = <1>;
@@ -285,7 +293,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
@@ -305,7 +313,7 @@ emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&mio_clk 1>;
@@ -323,7 +331,7 @@ sd1: mmc@5a600000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a600000 0x200>;
-			interrupts = <0 85 4>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_sd1>;
 			clocks = <&mio_clk 2>;
@@ -339,7 +347,7 @@ usb2: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
-			interrupts = <0 80 4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
@@ -355,7 +363,7 @@ usb3: usb@5a810100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
-			interrupts = <0 81 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb3>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
@@ -431,7 +439,7 @@ efuse@200 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -446,14 +454,16 @@ aidet: interrupt-controller@5fc20000 {
 		timer@60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x304>;
+			interrupts = <GIC_PPI 11
+				(GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer@60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x304>;
+			interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
@@ -485,7 +495,7 @@ eth: ethernet@65000000 {
 			compatible = "socionext,uniphier-pro4-ave4";
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
 			clock-names = "gio", "ether", "ether-gb", "ether-phy";
@@ -508,7 +518,8 @@ usb0: usb@65a00000 {
 			status = "disabled";
 			reg = <0x65a00000 0xcd00>;
 			interrupt-names = "host", "peripheral";
-			interrupts = <0 134 4>, <0 135 4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -561,7 +572,8 @@ usb1: usb@65c00000 {
 			status = "disabled";
 			reg = <0x65c00000 0xcd00>;
 			interrupt-names = "host", "peripheral";
-			interrupts = <0 137 4>, <0 138 4>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -605,7 +617,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 3525125832dd..64cdd0c62e55 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -5,6 +5,8 @@
 // Copyright (C) 2015-2016 Socionext Inc.
 //   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
 / {
 	compatible = "socionext,uniphier-pro5";
 	#address-cells = <1>;
@@ -135,7 +137,8 @@ l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
 			      <0x506c0000 0x400>;
-			interrupts = <0 190 4>, <0 191 4>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(2 * 1024 * 1024)>;
 			cache-sets = <512>;
@@ -148,7 +151,8 @@ l3: cache-controller@500c8000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
 			      <0x506c8000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(2 * 1024 * 1024)>;
 			cache-sets = <512>;
@@ -162,7 +166,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -175,7 +179,7 @@ spi1: spi@54006100 {
 			reg = <0x54006100 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 216 4>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
 			clocks = <&peri_clk 11>;	/* common with spi0 */
@@ -186,7 +190,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -197,7 +201,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -208,7 +212,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -219,7 +223,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -246,7 +250,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -260,7 +264,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -274,7 +278,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -288,7 +292,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -304,7 +308,7 @@ i2c5: i2c@58785000 {
 			reg = <0x58785000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 9>;
 			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
@@ -316,7 +320,7 @@ i2c6: i2c@58786000 {
 			reg = <0x58786000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 26 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 10>;
 			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
@@ -415,7 +419,7 @@ efuse@400 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -430,14 +434,16 @@ aidet: interrupt-controller@5fc20000 {
 		timer@60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x304>;
+			interrupts = <GIC_PPI 11
+				(GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer@60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x304>;
+			interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
@@ -470,7 +476,7 @@ usb0: usb@65a00000 {
 			status = "disabled";
 			reg = <0x65a00000 0xcd00>;
 			interrupt-names = "host";
-			interrupts = <0 134 4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -534,7 +540,7 @@ usb1: usb@65c00000 {
 			status = "disabled";
 			reg = <0x65c00000 0xcd00>;
 			interrupt-names = "host";
-			interrupts = <0 137 4>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>, <&pinctrl_usb2>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -650,7 +656,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
@@ -663,7 +669,7 @@ emmc: mmc@68400000 {
 			compatible = "socionext,uniphier-sd-v3.1";
 			status = "disabled";
 			reg = <0x68400000 0x800>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sd_clk 1>;
@@ -679,7 +685,7 @@ sd: mmc@68800000 {
 			compatible = "socionext,uniphier-sd-v3.1";
 			status = "disabled";
 			reg = <0x68800000 0x800>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index c6288c772a7d..7d8c437b8f8b 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -6,6 +6,7 @@
 //   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -161,7 +162,10 @@ l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
 			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(1280 * 1024)>;
 			cache-sets = <512>;
@@ -175,7 +179,7 @@ spi0: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -188,7 +192,7 @@ spi1: spi@54006100 {
 			reg = <0x54006100 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 216 4>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi1>;
 			clocks = <&peri_clk 12>;
@@ -199,7 +203,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -210,7 +214,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -221,7 +225,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -232,7 +236,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 177 4>;
+			interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -259,7 +263,7 @@ gpio: gpio@55000000 {
 		audio@56000000 {
 			compatible = "socionext,uniphier-pxs2-aio";
 			reg = <0x56000000 0x80000>;
-			interrupts = <0 144 4>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ain1>,
 				    <&pinctrl_ain2>,
@@ -317,7 +321,7 @@ i2c0: i2c@58780000 {
 			reg = <0x58780000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -331,7 +335,7 @@ i2c1: i2c@58781000 {
 			reg = <0x58781000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 4>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -345,7 +349,7 @@ i2c2: i2c@58782000 {
 			reg = <0x58782000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 4>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -359,7 +363,7 @@ i2c3: i2c@58783000 {
 			reg = <0x58783000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 4>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -373,7 +377,7 @@ i2c4: i2c@58784000 {
 			reg = <0x58784000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 45 4>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 8>;
 			resets = <&peri_rst 8>;
 			clock-frequency = <400000>;
@@ -385,7 +389,7 @@ i2c5: i2c@58785000 {
 			reg = <0x58785000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 25 4>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 9>;
 			resets = <&peri_rst 9>;
 			clock-frequency = <400000>;
@@ -397,7 +401,7 @@ i2c6: i2c@58786000 {
 			reg = <0x58786000 0x80>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 26 4>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&peri_clk 10>;
 			resets = <&peri_rst 10>;
 			clock-frequency = <400000>;
@@ -454,7 +458,7 @@ emmc: mmc@5a000000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a000000 0x800>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&sd_clk 1>;
@@ -470,7 +474,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v3.1.1";
 			status = "disabled";
 			reg = <0x5a400000 0x800>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
@@ -515,7 +519,7 @@ efuse@200 {
 		xdmac: dma-controller@5fc10000 {
 			compatible = "socionext,uniphier-xdmac";
 			reg = <0x5fc10000 0x5300>;
-			interrupts = <0 188 4>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			dma-channels = <16>;
 			#dma-cells = <2>;
 		};
@@ -530,14 +534,16 @@ aidet: interrupt-controller@5fc20000 {
 		timer@60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0xf04>;
+			interrupts = <GIC_PPI 11
+				(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer@60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0xf04>;
+			interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
@@ -566,7 +572,7 @@ sys_rst: reset {
 
 			pvtctl: thermal-sensor {
 				compatible = "socionext,uniphier-pxs2-thermal";
-				interrupts = <0 3 4>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <0>;
 				socionext,tmod-calibration = <0x0f86 0x6844>;
 			};
@@ -576,7 +582,7 @@ eth: ethernet@65000000 {
 			compatible = "socionext,uniphier-pxs2-ave4";
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
-			interrupts = <0 66 4>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
 			clock-names = "ether";
@@ -598,7 +604,7 @@ usb0: usb@65a00000 {
 			status = "disabled";
 			reg = <0x65a00000 0xcd00>;
 			interrupt-names = "dwc_usb3";
-			interrupts = <0 134 4>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb2>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -694,7 +700,7 @@ usb1: usb@65c00000 {
 			status = "disabled";
 			reg = <0x65c00000 0xcd00>;
 			interrupt-names = "dwc_usb3";
-			interrupts = <0 137 4>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>, <&pinctrl_usb3>;
 			clock-names = "ref", "bus_early", "suspend";
@@ -780,7 +786,7 @@ nand: nand-controller@68000000 {
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 65 4>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
 			clock-names = "nand", "nand_x", "ecc";
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index b73647bafc63..2446f9e15360 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -36,11 +36,11 @@ memory@80000000 {
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
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 96a766deb8d1..67b12dfe513b 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -6,6 +6,7 @@
 //   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
 
 #include <dt-bindings/gpio/uniphier-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "socionext,uniphier-sld8";
@@ -55,7 +56,8 @@ l2: cache-controller@500c0000 {
 			compatible = "socionext,uniphier-system-cache";
 			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
 			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-size = <(256 * 1024)>;
 			cache-sets = <256>;
@@ -69,7 +71,7 @@ spi: spi@54006000 {
 			reg = <0x54006000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 39 4>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_spi0>;
 			clocks = <&peri_clk 11>;
@@ -80,7 +82,7 @@ serial0: serial@54006800 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006800 0x40>;
-			interrupts = <0 33 4>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart0>;
 			clocks = <&peri_clk 0>;
@@ -91,7 +93,7 @@ serial1: serial@54006900 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006900 0x40>;
-			interrupts = <0 35 4>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart1>;
 			clocks = <&peri_clk 1>;
@@ -102,7 +104,7 @@ serial2: serial@54006a00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006a00 0x40>;
-			interrupts = <0 37 4>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart2>;
 			clocks = <&peri_clk 2>;
@@ -113,7 +115,7 @@ serial3: serial@54006b00 {
 			compatible = "socionext,uniphier-uart";
 			status = "disabled";
 			reg = <0x54006b00 0x40>;
-			interrupts = <0 29 4>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_uart3>;
 			clocks = <&peri_clk 3>;
@@ -144,7 +146,7 @@ i2c0: i2c@58400000 {
 			reg = <0x58400000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 41 1>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c0>;
 			clocks = <&peri_clk 4>;
@@ -158,7 +160,7 @@ i2c1: i2c@58480000 {
 			reg = <0x58480000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 42 1>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c1>;
 			clocks = <&peri_clk 5>;
@@ -172,7 +174,7 @@ i2c2: i2c@58500000 {
 			reg = <0x58500000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 43 1>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c2>;
 			clocks = <&peri_clk 6>;
@@ -186,7 +188,7 @@ i2c3: i2c@58580000 {
 			reg = <0x58580000 0x40>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0 44 1>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_i2c3>;
 			clocks = <&peri_clk 7>;
@@ -244,8 +246,13 @@ peri_rst: reset {
 		dmac: dma-controller@5a000000 {
 			compatible = "socionext,uniphier-mio-dmac";
 			reg = <0x5a000000 0x1000>;
-			interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
-				     <0 71 4>, <0 72 4>, <0 73 4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mio_clk 7>;
 			resets = <&mio_rst 7>;
 			#dma-cells = <1>;
@@ -255,7 +262,7 @@ sd: mmc@5a400000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a400000 0x200>;
-			interrupts = <0 76 4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default", "uhs";
 			pinctrl-0 = <&pinctrl_sd>;
 			pinctrl-1 = <&pinctrl_sd_uhs>;
@@ -275,7 +282,7 @@ emmc: mmc@5a500000 {
 			compatible = "socionext,uniphier-sd-v2.91";
 			status = "disabled";
 			reg = <0x5a500000 0x200>;
-			interrupts = <0 78 4>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_emmc>;
 			clocks = <&mio_clk 1>;
@@ -293,7 +300,7 @@ usb0: usb@5a800100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a800100 0x100>;
-			interrupts = <0 80 4>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb0>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 8>,
@@ -307,7 +314,7 @@ usb1: usb@5a810100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a810100 0x100>;
-			interrupts = <0 81 4>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb1>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 9>,
@@ -321,7 +328,7 @@ usb2: usb@5a820100 {
 			compatible = "socionext,uniphier-ehci", "generic-ehci";
 			status = "disabled";
 			reg = <0x5a820100 0x100>;
-			interrupts = <0 82 4>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2>;
 			clocks = <&sys_clk 8>, <&mio_clk 7>, <&mio_clk 10>,
@@ -362,14 +369,16 @@ efuse@200 {
 		timer@60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x104>;
+			interrupts = <GIC_PPI 11
+				(GIC_CPU_MASK_RAW(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer@60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x104>;
+			interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_RAW(1) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&arm_timer_clk>;
 		};
 
@@ -411,7 +420,7 @@ nand: nand-controller@68000000 {
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

