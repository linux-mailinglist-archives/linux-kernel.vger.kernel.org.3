Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92F54AC27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiFNIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356334AbiFNIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:44:12 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A728266B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:44:02 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(29251:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Tue, 14 Jun 2022 16:31:21 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v18 08/10] ARM: sunplus: Add initial support for Sunplus SP7021 SoC
Date:   Tue, 14 Jun 2022 16:31:07 +0800
Message-Id: <932bd48e7d17748a308ee487785243b141dafda1.1655194858.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1655194858.git.qinjian@cqplus1.com>
References: <cover.1655194858.git.qinjian@cqplus1.com>
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
 arch/arm/mach-sunplus/Makefile |  8 ++++++++
 arch/arm/mach-sunplus/sp7021.c | 16 ++++++++++++++++
 6 files changed, 55 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 arch/arm/mach-sunplus/Makefile
 create mode 100644 arch/arm/mach-sunplus/sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7d157cb..9d4cf62eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2814,6 +2814,7 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d..300929f58 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -695,6 +695,8 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
+source "arch/arm/mach-sunplus/Kconfig"
+
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de..ec7ec5a05 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -217,6 +217,7 @@ machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
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
index 000000000..d211de6af
--- /dev/null
+++ b/arch/arm/mach-sunplus/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+# Object file lists.
+
+obj-$(CONFIG_SOC_SP7021)	+= sp7021.o
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

