Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533ED4CFC1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiCGLAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiCGK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:35 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A8B1523
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:17:24 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80DB510001A;
        Mon,  7 Mar 2022 10:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646648243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TZJ67Qf5npxgRoNb/48DKjrSfSErIPD2XpuA2RT2wg=;
        b=an72McpjP8B3OkO7jW56TLtGhSr2iWjdcchaiD5cNEVqZeZybpLNGyy4Y1MpxQlqIlm31+
        WqCJD3ZQ/fp9BTvYz482zc8PnsOG+bI1oA9BOCujbuPohBZx8lPnreCM8m+vFQLUl/KsxF
        iwvandNv5rN/4keXXW+B8xIFRzj17A41qA/bf2dkh7dNLF/PvmRHmIWapD5L+VC8Q+sXYK
        A0GMva5ZGNdf+T+LKk5N2r/tP/dvViwRJ7yOO+TSvZAU51Pma64Vp3ZR8/GtqYJSogQJiL
        Xzcugksi3FY/8JnsbCu407xC0u6IaSj1IWr/TDrMBeN1PVKk+/3DyN01r8bwmA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 1/2] ARM: at91: add code to handle secure calls
Date:   Mon,  7 Mar 2022 11:15:49 +0100
Message-Id: <20220307101550.95538-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307101550.95538-1-clement.leger@bootlin.com>
References: <20220307101550.95538-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since OP-TEE now has a more complete support for sama5d2, add necessary
code to perform SMC calls. The detection of OP-TEE is based on a
specific device-tree node path (/firmware/optee) such has done by some
other SoC. A check is added to avoid doing SMC calls without having
OP-TEE.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/Makefile     |  2 +-
 arch/arm/mach-at91/sam_secure.c | 46 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h | 14 ++++++++++
 arch/arm/mach-at91/sama5.c      |  2 ++
 4 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/sam_secure.c
 create mode 100644 arch/arm/mach-at91/sam_secure.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 522b680b6446..0dcc37180588 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,7 +7,7 @@
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
-obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
+obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
 obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
diff --git a/arch/arm/mach-at91/sam_secure.c b/arch/arm/mach-at91/sam_secure.c
new file mode 100644
index 000000000000..2a01f7a7d13f
--- /dev/null
+++ b/arch/arm/mach-at91/sam_secure.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022, Microchip
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/of.h>
+
+#include "sam_secure.h"
+
+static bool optee_available;
+
+#define SAM_SIP_SMC_STD_CALL_VAL(func_num) \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
+	ARM_SMCCC_OWNER_SIP, (func_num))
+
+struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1)
+{
+	struct arm_smccc_res res = {.a0 = -1};
+
+	if (WARN_ON(!optee_available))
+		return res;
+
+	arm_smccc_smc(SAM_SIP_SMC_STD_CALL_VAL(fn), arg0, arg1, 0, 0, 0, 0, 0,
+		      &res);
+
+	return res;
+}
+
+void __init sam_secure_init(void)
+{
+	struct device_node *np;
+
+	/*
+	 * We only check that the OP-TEE node is present and available. The
+	 * OP-TEE kernel driver is not needed for the type of interaction made
+	 * with OP-TEE here so the driver's status is not checked.
+	 */
+	np = of_find_node_by_path("/firmware/optee");
+	if (np && of_device_is_available(np))
+		optee_available = true;
+	of_node_put(np);
+
+	if (optee_available)
+		pr_info("Running under OP-TEE firmware\n");
+}
diff --git a/arch/arm/mach-at91/sam_secure.h b/arch/arm/mach-at91/sam_secure.h
new file mode 100644
index 000000000000..360036672f52
--- /dev/null
+++ b/arch/arm/mach-at91/sam_secure.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022, Microchip
+ */
+
+#ifndef SAM_SECURE_H
+#define SAM_SECURE_H
+
+#include <linux/arm-smccc.h>
+
+void __init sam_secure_init(void);
+struct arm_smccc_res sam_smccc_call(u32 fn, u32 arg0, u32 arg1);
+
+#endif /* SAM_SECURE_H */
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 89dab7cf01e8..de5dd28b392e 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -14,6 +14,7 @@
 #include <asm/system_misc.h>
 
 #include "generic.h"
+#include "sam_secure.h"
 
 static void __init sama5_dt_device_init(void)
 {
@@ -47,6 +48,7 @@ MACHINE_END
 static void __init sama5d2_init(void)
 {
 	of_platform_default_populate(NULL, NULL, NULL);
+	sam_secure_init();
 	sama5d2_pm_init();
 }
 
-- 
2.34.1

