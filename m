Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D191056B7C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbiGHKxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbiGHKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:52:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3156884EF3;
        Fri,  8 Jul 2022 03:52:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A5CF106F;
        Fri,  8 Jul 2022 03:52:57 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 824413F70D;
        Fri,  8 Jul 2022 03:52:55 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v13 7/7] arm64: dts: allwinner: h616: Add X96 Mate TV box support
Date:   Fri,  8 Jul 2022 11:52:35 +0100
Message-Id: <20220708105235.3983266-8-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708105235.3983266-1-andre.przywara@arm.com>
References: <20220708105235.3983266-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X96 Mate is an Allwinner H616 based TV box, featuring:
  - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
  - 2GiB/4GiB RAM (fully usable!)
  - 16/32/64GiB eMMC
  - 100Mbps Ethernet (via embedded AC200 EPHY, not yet supported)
  - Unsupported Allwinner WiFi chip
  - 2 x USB 2.0 host ports
  - HDMI port
  - IR receiver
  - 5V/2A DC power supply via barrel plug

Add a basic devicetree for it, with SD card and eMMC working, as
well as serial and the essential peripherals, like the AXP PMIC.

This DT is somewhat minimal, and should work on many other similar TV
boxes with the Allwinner H616 chip.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../dts/allwinner/sun50i-h616-x96-mate.dts    | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index df2214e6d946a..6a96494a2e0a3 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -39,3 +39,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
new file mode 100644
index 0000000000000..6619db34714a4
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2021 Arm Ltd.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "X96 Mate";
+	compatible = "hechuang,x96-mate", "allwinner,sun50i-h616";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ir {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dcdce>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdce>;
+	vqmmc-supply = <&reg_bldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp305: pmic@745 {
+		compatible = "x-powers,axp305", "x-powers,axp805",
+			     "x-powers,axp806";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x745>;
+
+		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-sys";
+			};
+
+			/* Enabled by the Android BSP */
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3-ext";
+				status = "disabled";
+			};
+
+			/* Enabled by the Android BSP */
+			reg_aldo3: aldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3-ext2";
+				status = "disabled";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Enabled by the Android BSP */
+			reg_bldo2: bldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8-2";
+				status = "disabled";
+			};
+
+			bldo3 {
+				/* unused */
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			cldo1 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-name = "vcc2v5";
+			};
+
+			cldo2 {
+				/* unused */
+			};
+
+			cldo3 {
+				/* unused */
+			};
+
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <1360000>;
+				regulator-max-microvolt = <1360000>;
+				regulator-name = "vdd-dram";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-eth-mmc";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
-- 
2.25.1

