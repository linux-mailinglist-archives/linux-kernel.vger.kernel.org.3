Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F6504DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiDRIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbiDRIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:30:28 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AD5C193CF;
        Mon, 18 Apr 2022 01:27:49 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 5A8781C8128F;
        Mon, 18 Apr 2022 16:27:48 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Apr
 2022 16:27:48 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Mon, 18 Apr
 2022 16:27:47 +0800
Received: from localhost.localdomain (172.19.1.47) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 18 Apr 2022 16:27:47 +0800
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <ychuang570808@gmail.com>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <will@kernel.org>,
        <soc@kernel.org>, <cfli0@nuvoton.com>,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v3 3/5] arm64: dts: nuvoton: Add initial support for MA35D1
Date:   Mon, 18 Apr 2022 16:27:36 +0800
Message-ID: <20220418082738.11301-4-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220418082738.11301-1-ychuang3@nuvoton.com>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree files for Nuvoton MA35D1 Soc.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/Makefile               |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile       |   2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts |  24 +++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi    | 111 +++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 1ba04e31a438..7b107fa7414b 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -19,6 +19,7 @@ subdir-y += lg
 subdir-y += marvell
 subdir-y += mediatek
 subdir-y += microchip
+subdir-y += nuvoton
 subdir-y += nvidia
 subdir-y += qcom
 subdir-y += realtek
diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
new file mode 100644
index 000000000000..e1e0c466bf5e
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
new file mode 100644
index 000000000000..95f0facb0476
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for MA35D1 Evaluation Board (EVB)
+ *
+ * Copyright (C) 2022 Nuvoton Technology Corp.
+ */
+
+/dts-v1/;
+#include "ma35d1.dtsi"
+
+/ {
+	model = "Nuvoton MA35D1-EVB";
+	compatible = "nuvoton,ma35d1-evb", "nuvoton,ma35d1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x10000000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
new file mode 100644
index 000000000000..98a9ed1f6816
--- /dev/null
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (c) 2022 Nuvoton Technology Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+/ {
+	compatible = "nuvoton,ma35d1";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x1>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <12000000>;
+	};
+
+	sys: system-controller@40460000 {
+		compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
+		reg = <0x0 0x40460000 0x0 0x400>;
+	};
+
+	reset: reset-controller {
+		compatible = "nuvoton,ma35d1-reset";
+		nuvoton,ma35d1-sys = <&sys>;
+		#reset-cells = <1>;
+	};
+
+	clk: clock-controller@40460200 {
+		compatible = "nuvoton,ma35d1-clk";
+		reg = <0x0 0x40460200 0x0 0x100>;
+		#clock-cells = <1>;
+		assigned-clocks = <&clk CAPLL>,
+				  <&clk DDRPLL>,
+				  <&clk APLL>,
+				  <&clk EPLL>,
+				  <&clk VPLL>;
+		assigned-clock-rates = <1000000000>,
+				       <266000000>,
+				       <180000000>,
+				       <500000000>,
+				       <102000000>;
+		nuvoton,clk-pll-mode = <0 1 0 0 0>;
+	};
+
+	gic: interrupt-controller@50800000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		interrupt-controller;
+		reg = <0x0 0x50801000 0x0 0x1000>,
+		      <0x0 0x50802000 0x0 0x2000>,
+		      <0x0 0x50804000 0x0 0x2000>,
+		      <0x0 0x50806000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x13) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+};
-- 
2.17.1

