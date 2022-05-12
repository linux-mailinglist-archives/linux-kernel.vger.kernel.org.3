Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7025255C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358075AbiELTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358059AbiELTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:34:10 -0400
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120E2375EA;
        Thu, 12 May 2022 12:34:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436302|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.161995-0.000984213-0.83702;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.NjCS17e_1652384045;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NjCS17e_1652384045)
          by smtp.aliyun-inc.com(33.13.195.200);
          Fri, 13 May 2022 03:34:06 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tsbogend@alpha.franken.de, paul@crapouillou.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com
Subject: [PATCH 2/3] MIPS: Ingenic: Refresh device tree for Ingenic SoCs and boards.
Date:   Fri, 13 May 2022 03:33:40 +0800
Message-Id: <1652384021-46309-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1652384021-46309-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add SSI nodes for X1000 SoC and X1830 SoC from Ingenic.
2.Refresh SSI related nodes in CU1000-Neo and CU1830-Neo.
3.The X1830 SoC used by the CU1830-Neo and the X1000 SoC
  used by the CU1000-Neo are both single-core processors,
  therefore the "OST_CLK_PERCPU_TIMER" ABI should not be
  used in the OST nodes of the CU1830-Neo and CU1000-Neo,
  it is just a coincidence that there is no problem now.
  So replace the misused "OST_CLK_PERCPU_TIMER" ABI with
  the correct "OST_CLK_EVENT_TIMER" ABI.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 arch/mips/boot/dts/ingenic/cu1000-neo.dts | 77 ++++++++++++++++---------------
 arch/mips/boot/dts/ingenic/cu1830-neo.dts | 76 +++++++++++++++---------------
 arch/mips/boot/dts/ingenic/x1000.dtsi     | 20 ++++++++
 arch/mips/boot/dts/ingenic/x1830.dtsi     | 39 ++++++++++++++++
 4 files changed, 138 insertions(+), 74 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/cu1000-neo.dts b/arch/mips/boot/dts/ingenic/cu1000-neo.dts
index 9c67b4f..b44d3b1 100644
--- a/arch/mips/boot/dts/ingenic/cu1000-neo.dts
+++ b/arch/mips/boot/dts/ingenic/cu1000-neo.dts
@@ -31,42 +31,6 @@
 		};
 	};
 
-	ssi: spi-gpio {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		num-chipselects = <1>;
-
-		mosi-gpios = <&gpd 2 GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpd 3 GPIO_ACTIVE_HIGH>;
-		sck-gpios = <&gpd 0 GPIO_ACTIVE_HIGH>;
-		cs-gpios = <&gpd 1 GPIO_ACTIVE_HIGH>;
-
-		status = "okay";
-
-		spi-max-frequency = <50000000>;
-
-		sc16is752: expander@0 {
-			compatible = "nxp,sc16is752";
-			reg = <0>; /* CE0 */
-			spi-max-frequency = <4000000>;
-
-			clocks = <&exclk_sc16is752>;
-
-			interrupt-parent = <&gpc>;
-			interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			exclk_sc16is752: sc16is752 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <48000000>;
-			};
-		};
-	};
-
 	wlan_pwrseq: msc1-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 
@@ -90,7 +54,7 @@
 
 &ost {
 	/* 1500 kHz for the system timer and clocksource */
-	assigned-clocks = <&ost OST_CLK_PERCPU_TIMER>, <&ost OST_CLK_GLOBAL_TIMER>;
+	assigned-clocks = <&ost OST_CLK_EVENT_TIMER>, <&ost OST_CLK_GLOBAL_TIMER>;
 	assigned-clock-rates = <1500000>, <1500000>;
 };
 
@@ -101,6 +65,39 @@
 	pinctrl-0 = <&pins_uart2>;
 };
 
+&ssi {
+	status = "okay";
+
+	num-cs = <2>;
+	cs-gpios = <0>, <&gpc 20 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_ssi>;
+
+	sc16is752: expander@0 {
+		compatible = "nxp,sc16is752";
+		reg = <0>; /* CE0 */
+
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+		spi-max-frequency = <4000000>;
+
+		clocks = <&exclk_sc16is752>;
+
+		interrupt-parent = <&gpc>;
+		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		exclk_sc16is752: sc16is752 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+		};
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -225,6 +222,12 @@
 		bias-pull-up;
 	};
 
+	pins_ssi: ssi {
+		function = "ssi";
+		groups = "ssi-dt-d", "ssi-dr-d", "ssi-clk-d", "ssi-ce0-d";
+		bias-disable;
+	};
+
 	pins_i2c0: i2c0 {
 		function = "i2c0";
 		groups = "i2c0-data";
diff --git a/arch/mips/boot/dts/ingenic/cu1830-neo.dts b/arch/mips/boot/dts/ingenic/cu1830-neo.dts
index 0727bc9..461efba 100644
--- a/arch/mips/boot/dts/ingenic/cu1830-neo.dts
+++ b/arch/mips/boot/dts/ingenic/cu1830-neo.dts
@@ -31,42 +31,6 @@
 		};
 	};
 
-	ssi0: spi-gpio {
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		num-chipselects = <1>;
-
-		mosi-gpios = <&gpc 12 GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpc 11 GPIO_ACTIVE_HIGH>;
-		sck-gpios = <&gpc 15 GPIO_ACTIVE_HIGH>;
-		cs-gpios = <&gpc 16 GPIO_ACTIVE_HIGH>;
-
-		status = "okay";
-
-		spi-max-frequency = <50000000>;
-
-		sc16is752: expander@0 {
-			compatible = "nxp,sc16is752";
-			reg = <0>; /* CE0 */
-			spi-max-frequency = <4000000>;
-
-			clocks = <&exclk_sc16is752>;
-
-			interrupt-parent = <&gpb>;
-			interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-
-			exclk_sc16is752: sc16is752 {
-				compatible = "fixed-clock";
-				#clock-cells = <0>;
-				clock-frequency = <48000000>;
-			};
-		};
-	};
-
 	wlan_pwrseq: msc1-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 
@@ -90,7 +54,7 @@
 
 &ost {
 	/* 1500 kHz for the system timer and clocksource */
-	assigned-clocks = <&ost OST_CLK_PERCPU_TIMER>, <&ost OST_CLK_GLOBAL_TIMER>;
+	assigned-clocks = <&ost OST_CLK_EVENT_TIMER>, <&ost OST_CLK_GLOBAL_TIMER>;
 	assigned-clock-rates = <1500000>, <1500000>;
 };
 
@@ -101,6 +65,38 @@
 	pinctrl-0 = <&pins_uart1>;
 };
 
+&ssi0 {
+	status = "okay";
+
+	num-cs = <2>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pins_ssi0>;
+
+	sc16is752: expander@0 {
+		compatible = "nxp,sc16is752";
+		reg = <0>; /* CE0 */
+
+		spi-rx-bus-width = <1>;
+		spi-tx-bus-width = <1>;
+		spi-max-frequency = <4000000>;
+
+		clocks = <&exclk_sc16is752>;
+
+		interrupt-parent = <&gpb>;
+		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		exclk_sc16is752: sc16is752 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+		};
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -229,6 +225,12 @@
 		bias-pull-up;
 	};
 
+	pins_ssi0: ssi0 {
+		function = "ssi0";
+		groups = "ssi0-dt", "ssi0-dr", "ssi0-clk", "ssi0-ce0", "ssi0-ce1";
+		bias-disable;
+	};
+
 	pins_i2c0: i2c0 {
 		function = "i2c0";
 		groups = "i2c0-data";
diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 591692d..958a5ef 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -259,6 +259,25 @@
 		status = "disabled";
 	};
 
+	ssi: spi@10043000 {
+		compatible = "ingenic,x1000-spi";
+		reg = <0x10043000 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <8>;
+
+		clocks = <&cgu X1000_CLK_SSI>;
+		clock-names = "spi";
+
+		dmas = <&pdma X1000_DMA_SSI0_RX 0xffffffff>,
+			   <&pdma X1000_DMA_SSI0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
 	i2c0: i2c-controller@10050000 {
 		compatible = "ingenic,x1000-i2c";
 		reg = <0x10050000 0x1000>;
@@ -304,6 +323,7 @@
 	pdma: dma-controller@13420000 {
 		compatible = "ingenic,x1000-dma";
 		reg = <0x13420000 0x400>, <0x13421000 0x40>;
+
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
index ffe6073..231c72a 100644
--- a/arch/mips/boot/dts/ingenic/x1830.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
@@ -241,6 +241,44 @@
 		status = "disabled";
 	};
 
+	ssi0: spi@10043000 {
+		compatible = "ingenic,x1830-spi", "ingenic,x1000-spi";
+		reg = <0x10043000 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <9>;
+
+		clocks = <&cgu X1830_CLK_SSI0>;
+		clock-names = "spi";
+
+		dmas = <&pdma X1830_DMA_SSI0_RX 0xffffffff>,
+			   <&pdma X1830_DMA_SSI0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
+	ssi1: spi@10044000 {
+		compatible = "ingenic,x1830-spi", "ingenic,x1000-spi";
+		reg = <0x10044000 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <8>;
+
+		clocks = <&cgu X1830_CLK_SSI1>;
+		clock-names = "spi";
+
+		dmas = <&pdma X1830_DMA_SSI1_RX 0xffffffff>,
+			   <&pdma X1830_DMA_SSI1_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
+		status = "disabled";
+	};
+
 	i2c0: i2c-controller@10050000 {
 		compatible = "ingenic,x1830-i2c", "ingenic,x1000-i2c";
 		reg = <0x10050000 0x1000>;
@@ -295,6 +333,7 @@
 	pdma: dma-controller@13420000 {
 		compatible = "ingenic,x1830-dma";
 		reg = <0x13420000 0x400>, <0x13421000 0x40>;
+
 		#dma-cells = <2>;
 
 		interrupt-parent = <&intc>;
-- 
2.7.4

