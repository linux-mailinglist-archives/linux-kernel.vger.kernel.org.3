Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4AC4BFBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiBVPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiBVPLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:11:11 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2810EC4D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:10:45 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B4240FF802;
        Tue, 22 Feb 2022 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645542644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OimyuXNq782pNwOtB/pBEMyzaWO+JIoSHKWQ8Ypj6U=;
        b=Kv5dL0wB6hkRopQz6doaUNuuJ+L4cBd0D4YI9/JE6dcGFAf03c+e44ZYpHqDQUjJB79w6x
        fYUIUroB7po1d3xLdYOvUqdfC+jeLStUz3USa7Gp1w3Ys8/HAfFKEIatest9KQBtcqdXBn
        Po5kU20En9IYv3HLLSsMrT8clkulscl16qfQplVGj5doSj2cobjY6NjmCgYapMis4+RP56
        bi3aiRpHfaMr+tPC7BhGMWlV85s/XnFM+im1PTlbYrayFAi/ZhSn0j+AKJS6pjOd88PzzE
        1pt6vAQpgyGNdYDUBfb4tz/75E7AWsPdXrut9+uJ+jGj1z5+XwPQJIm3bQRIRg==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 3/4] ARM: at91: pm: add support for sama5d2 secure suspend
Date:   Tue, 22 Feb 2022 16:08:45 +0100
Message-Id: <20220222150846.255307-4-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222150846.255307-1-clement.leger@bootlin.com>
References: <20220222150846.255307-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running with OP-TEE, the suspend control is handled securely.
Since the sama5d2 supports multiple suspend modes add a new
CONFIG_ATMEL_SECURE_PM which is mutually exclusive with CONFIG_ATMEL_PM
and allows to issue a SMC call to select the suspend mode.
"atmel.pm_modes" boot argument is still supported for compatibility
purposes but the standby value is actually ignored since PSCI suspend
is used and it only support one mode (suspend).

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/Kconfig          | 14 ++++++-
 arch/arm/mach-at91/Makefile         |  1 +
 arch/arm/mach-at91/pm_secure.c      | 64 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h     |  4 ++
 include/linux/platform_data/atmel.h |  2 +-
 5 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_secure.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 02f6b108fd5d..bb11a914ad3e 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -201,14 +201,24 @@ config SOC_SAM_V7
 config SOC_SAMA5
 	bool
 	select ATMEL_AIC5_IRQ
-	select ATMEL_PM if PM
 	select ATMEL_SDRAMC
 	select MEMORY
 	select SOC_SAM_V7
 	select SRAM if PM
 
 config ATMEL_PM
-	bool
+	bool "Atmel PM support"
+	default y if SOC_SAMA5 && PM
+	depends on !ATMEL_SECURE_PM
+
+config ATMEL_SECURE_PM
+	bool "Atmel Secure PM support"
+	depends on SOC_SAMA5D2 && PM
+	help
+	  When running under a TEE, the suspend mode must be requested to be set
+	  at TEE level. When enable, this option will use secure monitor calls
+	  to set the suspend level.
+	  NOTE: This support is mutually exclusive with CONFIG_ATMEL_PM
 
 config SOC_SAMA7
 	bool
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 23620ccf7ab6..ebd88de8d0e7 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
 # Power Management
 obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o pm_common.o
+obj-$(CONFIG_ATMEL_SECURE_PM)	+= pm_secure.o pm_common.o
 
 ifeq ($(CONFIG_CPU_V7),y)
 AFLAGS_pm_suspend.o := -march=armv7-a
diff --git a/arch/arm/mach-at91/pm_secure.c b/arch/arm/mach-at91/pm_secure.c
new file mode 100644
index 000000000000..2f63ff8c6226
--- /dev/null
+++ b/arch/arm/mach-at91/pm_secure.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012, Bootlin
+ */
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/parser.h>
+#include <linux/string.h>
+#include "generic.h"
+#include "sam_secure.h"
+#include "pm.h"
+
+static int suspend_mode = AT91_PM_ULP0;
+
+static void at91_pm_secure_init(void)
+{
+	struct arm_smccc_res res;
+
+	res = sam_smccc_call(SAMA5_SMC_SIP_SET_SUSPEND_MODE, suspend_mode, 0);
+	if (res.a0 == 0) {
+		pr_info("AT91: Secure PM: suspend mode set to %s\n",
+			pm_modes[suspend_mode].pattern);
+		return;
+	}
+
+	pr_warn("AT91: Secure PM: %s mode not supported !\n",
+		pm_modes[suspend_mode].pattern);
+
+	res = sam_smccc_call(SAMA5_SMC_SIP_GET_SUSPEND_MODE, 0, 0);
+	if (res.a0 == 0) {
+		pr_warn("AT91: Secure PM: failed to get default mode\n");
+		return;
+	}
+	suspend_mode = res.a1;
+
+	pr_info("AT91: Secure PM: using default suspend mode %s\n",
+		pm_modes[suspend_mode].pattern);
+}
+
+void __init sama5_pm_init(void)
+{
+}
+
+void __init sama5d2_pm_init(void)
+{
+	at91_pm_secure_init();
+}
+
+int at91_suspend_entering_slow_clock(void)
+{
+	return (suspend_mode >= AT91_PM_ULP0);
+}
+EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
+
+static int __init at91_pm_modes_select(char *str)
+{
+	int dummy;
+
+	pr_warn("AT91: Secure PM: ignoring standby mode\n");
+
+	return at91_pm_common_modes_select(str, &dummy, &suspend_mode);
+}
+early_param("atmel.pm_modes", at91_pm_modes_select);
diff --git a/arch/arm/mach-at91/sam_secure.h b/arch/arm/mach-at91/sam_secure.h
index af19e24ca59e..b169317f61f6 100644
--- a/arch/arm/mach-at91/sam_secure.h
+++ b/arch/arm/mach-at91/sam_secure.h
@@ -8,6 +8,10 @@
 
 #include <linux/arm-smccc.h>
 
+/* Secure Monitor mode APIs */
+#define SAMA5_SMC_SIP_SET_SUSPEND_MODE	0x400
+#define SAMA5_SMC_SIP_GET_SUSPEND_MODE	0x401
+
 void __init sam_secure_init(void);
 struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1);
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 73f63be509c4..cbb19712b4f0 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -7,7 +7,7 @@
 #define __ATMEL_H__
 
 /* FIXME: this needs a better location, but gets stuff building again */
-#ifdef CONFIG_ATMEL_PM
+#if defined(CONFIG_ATMEL_PM) || defined(CONFIG_ATMEL_SECURE_PM)
 extern int at91_suspend_entering_slow_clock(void);
 #else
 static inline int at91_suspend_entering_slow_clock(void)
-- 
2.34.1

