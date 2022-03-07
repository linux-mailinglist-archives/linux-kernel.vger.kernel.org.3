Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF04CFC0B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiCGK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiCGK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:34 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A40FE9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:17:25 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 768A7100007;
        Mon,  7 Mar 2022 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646648244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SV9pqBiR5a2AXF5zfm2ssETbnhponV7Ada+4xLnpEg4=;
        b=TjbAEZ5GDZMEhFBQ5lCpQT27KTuE/4PD/vKXpNvHuGF2cuUyc2bgC0I1VxnYC/Zx7YvnGm
        KrRFS9XVOZR7VgpBAxLE5vlBEcpAJAKwTS+WBwC0OOXJaclZfVQ14hvEHuLIE13YgvMvyd
        SL6DjQy0rMczBzgiXB/Y2y2pxIJFQQC9sYpsvHQvIe2Wn/xH0uxnf/Yk/e21E3e5gFS63W
        ZgHeYuz7wkGGCK+yp/gKqKRGHRbtC4+BlA1crzDLSZWrddEyOxrzgt+cOc5ns2ITRYbSvA
        BH02vv0VqBogsf+93dcrSWP8bY8j0VbGTJH6tduy3erIt059BNAq+EQ6c+sgxA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 2/2] ARM: at91: pm: add support for sama5d2 secure suspend
Date:   Mon,  7 Mar 2022 11:15:50 +0100
Message-Id: <20220307101550.95538-3-clement.leger@bootlin.com>
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

When running with OP-TEE, the suspend control is handled securely.
Suspend can be entered using PSCI support. Since the sama5d2 supports
multiple suspend modes, add a new CONFIG_ATMEL_SECURE_PM which will
send a SMC call to select the suspend mode at init time.

"atmel.pm_modes" boot argument is still supported for compatibility
purposes but the standby value is actually ignored since PSCI suspend
is used and it only support one mode (suspend).

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/Kconfig      | 12 ++++++++++-
 arch/arm/mach-at91/pm.c         | 38 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h |  4 ++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 02f6b108fd5d..5a6ca38d6303 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -208,7 +208,17 @@ config SOC_SAMA5
 	select SRAM if PM
 
 config ATMEL_PM
-	bool
+	bool "Atmel PM support"
+
+config ATMEL_SECURE_PM
+	bool "Atmel Secure PM support"
+	depends on SOC_SAMA5D2 && ATMEL_PM
+	select ARM_PSCI
+	help
+	  When running under a TEE, the suspend mode must be requested to be set
+	  at TEE level. When enable, this option will use secure monitor calls
+	  to set the suspend level. PSCI is then used to enter suspend.
+	  NOTE: This support is mutually exclusive with CONFIG_ATMEL_PM
 
 config SOC_SAMA7
 	bool
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index dd6f4ce3f766..e40515691540 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -27,6 +27,7 @@
 
 #include "generic.h"
 #include "pm.h"
+#include "sam_secure.h"
 
 #define BACKUP_DDR_PHY_CALIBRATION	(9)
 
@@ -856,6 +857,35 @@ static int __init at91_pm_backup_init(void)
 	return ret;
 }
 
+static void at91_pm_secure_init(void)
+{
+	int suspend_mode;
+	struct arm_smccc_res res;
+
+	suspend_mode = soc_pm.data.suspend_mode;
+
+	res = sam_smccc_call(SAMA5_SMC_SIP_SET_SUSPEND_MODE,
+			     suspend_mode, 0);
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
+
+	pr_info("AT91: Secure PM: using default suspend mode %s\n",
+		pm_modes[suspend_mode].pattern);
+
+	soc_pm.data.suspend_mode = res.a1;
+}
 static const struct of_device_id atmel_shdwc_ids[] = {
 	{ .compatible = "atmel,sama5d2-shdwc" },
 	{ .compatible = "microchip,sam9x60-shdwc" },
@@ -1188,6 +1218,11 @@ void __init sama5d2_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
+	if (IS_ENABLED(CONFIG_ATMEL_SECURE_PM)) {
+		at91_pm_secure_init();
+		return;
+	}
+
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	ret = at91_dt_ramc(false);
@@ -1262,6 +1297,9 @@ static int __init at91_pm_modes_select(char *str)
 	soc_pm.data.standby_mode = standby;
 	soc_pm.data.suspend_mode = suspend;
 
+	if (IS_ENABLED(CONFIG_ATMEL_SECURE_PM))
+		pr_warn("AT91: Secure PM: ignoring standby mode\n");
+
 	return 0;
 }
 early_param("atmel.pm_modes", at91_pm_modes_select);
diff --git a/arch/arm/mach-at91/sam_secure.h b/arch/arm/mach-at91/sam_secure.h
index 360036672f52..1e7d8b20ba1e 100644
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
 
-- 
2.34.1

