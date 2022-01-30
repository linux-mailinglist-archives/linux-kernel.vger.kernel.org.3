Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E234A36FC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355273AbiA3Ovs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355221AbiA3Ovi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:51:38 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69AC061748;
        Sun, 30 Jan 2022 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OvBhMw6bbt8t09pV2B0Kb8ULJ5bT1lgq8sPAOrF0Cws=; b=TTHaYvHJJgLUE/W0pUjtbYDjx5
        1ETRZ72wpwoniYQXNswhsnuLf0gepRjve5rjOIRY3SU960pHwrJ/UQO0o9Gnkj+58tp9VyEiyjGDU
        PJ2b7zYQQCw70xnORXAAfVYe7vmaQ6Qw0jYvHpsn3U9Tgry+lrkliTYlYDqOuu14OliE=;
Received: from p200300daa716f900d40f7dfd86c385e0.dip0.t-ipconnect.de ([2003:da:a716:f900:d40f:7dfd:86c3:85e0] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nEBY7-0002if-3R; Sun, 30 Jan 2022 15:51:27 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 03/13] ARM: Add basic support for Airoha EN7523 SoC
Date:   Sun, 30 Jan 2022 15:51:06 +0100
Message-Id: <20220130145116.88406-4-nbd@nbd.name>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220130145116.88406-1-nbd@nbd.name>
References: <20220130145116.88406-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

EN7523 is an armv8 based silicon used inside broadband access type devices
such as xPON and xDSL. It shares various silicon blocks with MediaTek
silicon such as the MT7622.

Add basic support for Airoha EN7523, enough for booting to console.

The UART is basically 8250-compatible, except for the clock selection.
A clock-frequency value is synthesized to get this to run at 115200 bps.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/Kconfig                 |  12 ++++
 arch/arm/Makefile                |   1 +
 arch/arm/boot/dts/Makefile       |   2 +
 arch/arm/boot/dts/en7523-evb.dts |  27 +++++++
 arch/arm/boot/dts/en7523.dtsi    | 117 +++++++++++++++++++++++++++++++
 arch/arm/mach-airoha/Makefile    |   2 +
 arch/arm/mach-airoha/airoha.c    |  16 +++++
 7 files changed, 177 insertions(+)
 create mode 100644 arch/arm/boot/dts/en7523-evb.dts
 create mode 100644 arch/arm/boot/dts/en7523.dtsi
 create mode 100644 arch/arm/mach-airoha/Makefile
 create mode 100644 arch/arm/mach-airoha/airoha.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 796fc8017f5d..57ef390d3146 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -572,6 +572,18 @@ config ARCH_VIRT
 	select HAVE_ARM_ARCH_TIMER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 
+config ARCH_AIROHA
+	bool "Airoha SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V3
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
+	select COMMON_CLK
+	help
+	  Support for Airoha EN7523 SoCs
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 77172d555c7e..34baf885573a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -160,6 +160,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_ACTIONS)		+= actions
+machine-$(CONFIG_ARCH_AIROHA)		+= airoha
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_ASPEED)           += aspeed
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e41eca79c950..5c2dd47b58b0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -187,6 +187,8 @@ dtb-$(CONFIG_ARCH_DAVINCI) += \
 	da850-lego-ev3.dtb
 dtb-$(CONFIG_ARCH_DIGICOLOR) += \
 	cx92755_equinox.dtb
+dtb-$(CONFIG_ARCH_AIROHA) += \
+	en7523-evb.dtb
 dtb-$(CONFIG_ARCH_EXYNOS3) += \
 	exynos3250-artik5-eval.dtb \
 	exynos3250-monk.dtb \
diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
new file mode 100644
index 000000000000..69754ef9a628
--- /dev/null
+++ b/arch/arm/boot/dts/en7523-evb.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+/* Bootloader installs ATF here */
+/memreserve/ 0x80000000 0x200000;
+
+#include "en7523.dtsi"
+
+/ {
+	model = "Airoha EN7523 Evaluation Board";
+	compatible = "airoha,en7523-evb", "airoha,en7523";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+		stdout-path = "serial0:115200n8";
+		linux,usable-memory-range = <0x80200000 0x1fe00000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
new file mode 100644
index 000000000000..f1d4c03aad89
--- /dev/null
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		npu_binary@84000000 {
+			no-map;
+			reg = <0x84000000 0xA00000>;
+		};
+
+		npu_flag@84B0000 {
+			no-map;
+			reg = <0x84B00000 0x100000>;
+		};
+
+		npu_pkt@85000000 {
+			no-map;
+			reg = <0x85000000 0x1A00000>;
+		};
+
+		npu_phyaddr@86B00000 {
+			no-map;
+			reg = <0x86B00000 0x100000>;
+		};
+
+		npu_rxdesc@86D00000 {
+			no-map;
+			reg = <0x86D00000 0x100000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
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
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			clock-frequency = <80000000>;
+			next-level-cache = <&L2_0>;
+		};
+
+		L2_0: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+
+	gic: interrupt-controller@9000000 {
+		compatible = "arm,gic-v3";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x09000000 0x20000>,
+		      <0x09080000 0x80000>,
+		      <0x09400000 0x2000>,
+		      <0x09500000 0x2000>,
+		      <0x09600000 0x20000>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	uart1: serial@1fbf0000 {
+		compatible = "ns16550";
+		reg = <0x1fbf0000 0x30>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <1843200>;
+		status = "okay";
+	};
+};
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
new file mode 100644
index 000000000000..a5857d0d02eb
--- /dev/null
+++ b/arch/arm/mach-airoha/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y			+= airoha.o
diff --git a/arch/arm/mach-airoha/airoha.c b/arch/arm/mach-airoha/airoha.c
new file mode 100644
index 000000000000..ea23b5abb478
--- /dev/null
+++ b/arch/arm/mach-airoha/airoha.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Device Tree support for Airoha SoCs
+ *
+ * Copyright (c) 2022 Felix Fietkau <nbd@nbd.name>
+ */
+#include <asm/mach/arch.h>
+
+static const char * const airoha_board_dt_compat[] = {
+	"airoha,en7523",
+	NULL,
+};
+
+DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
+	.dt_compat	= airoha_board_dt_compat,
+MACHINE_END
-- 
2.32.0 (Apple Git-132)

