Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EC4FB43A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiDKG7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbiDKG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:59:37 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55A462CC8B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:57:05 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1173:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 11 Apr 2022 14:49:06 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v13 8/9] ARM: sunplus: Add initial support for Sunplus SP7021 SoC
Date:   Mon, 11 Apr 2022 14:49:58 +0800
Message-Id: <c6fd4e91d55caee869c9c05896d668a450e42cd1.1649659095.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649659095.git.qinjian@cqplus1.com>
References: <cover.1649659095.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims to add an initial support for Sunplus SP7021 SoC.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                    |  1 +
 arch/arm/Kconfig               |  2 ++
 arch/arm/Makefile              |  1 +
 arch/arm/mach-sunplus/Kconfig  | 27 +++++++++++++++++++++++++++
 arch/arm/mach-sunplus/Makefile |  9 +++++++++
 arch/arm/mach-sunplus/sp7021.c | 16 ++++++++++++++++
 6 files changed, 56 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 arch/arm/mach-sunplus/Makefile
 create mode 100644 arch/arm/mach-sunplus/sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf6873295..38890c055 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2747,6 +2747,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40e..1ee9a27a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -693,6 +693,8 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
+source "arch/arm/mach-sunplus/Kconfig"
+
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 77172d555..1e19d2f4b 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -216,6 +216,7 @@ machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
 machine-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
+machine-$(CONFIG_ARCH_SUNPLUS)		+= sunplus
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U8500)		+= ux500
diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
new file mode 100644
index 000000000..be20425c2
--- /dev/null
+++ b/arch/arm/mach-sunplus/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+menuconfig ARCH_SUNPLUS
+	bool "Sunplus SoCs"
+	depends on ARCH_MULTI_V7
+	help
+	  Support for Sunplus SoC family: SP7021 and succeeding SoC-based systems,
+	  such as the Banana Pi BPI-F2S development board (and derivatives).
+	  (<http://www.sinovoip.com.cn/ecp_view.asp?id=586>)
+	  (<https://tibbo.com/store/plus1.html>)
+
+config SOC_SP7021
+	bool "Sunplus SP7021 SoC support"
+	depends on ARCH_SUNPLUS
+	default ARCH_SUNPLUS
+	select HAVE_ARM_ARCH_TIMER
+	select ARM_GIC
+	select ARM_PSCI
+	select PINCTRL
+	select PINCTRL_SPPCTL
+	select SERIAL_SUNPLUS
+	select SERIAL_SUNPLUS_CONSOLE
+	help
+	  Support for Sunplus SP7021 SoC. It is based on ARM 4-core
+	  Cortex-A7 with various peripherals (ex: I2C, SPI, SDIO,
+	  Ethernet and etc.), FPGA interface,  chip-to-chip bus.
+	  It is designed for industrial control.
diff --git a/arch/arm/mach-sunplus/Makefile b/arch/arm/mach-sunplus/Makefile
new file mode 100644
index 000000000..c902580a7
--- /dev/null
+++ b/arch/arm/mach-sunplus/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+
+obj-$(CONFIG_SOC_SP7021)	+= sp7021.o
+
diff --git a/arch/arm/mach-sunplus/sp7021.c b/arch/arm/mach-sunplus/sp7021.c
new file mode 100644
index 000000000..774d0a5bd
--- /dev/null
+++ b/arch/arm/mach-sunplus/sp7021.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <asm/mach/arch.h>
+
+static const char *sp7021_compat[] __initconst = {
+	"sunplus,sp7021",
+	NULL
+};
+
+DT_MACHINE_START(SP7021_DT, "SP7021")
+	.dt_compat	= sp7021_compat,
+MACHINE_END
-- 
2.33.1

