Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED4E517273
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiEBP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiEBP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:27:15 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C113D1E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:23:40 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F398D240006;
        Mon,  2 May 2022 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651505018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epNsehOQ5G2G1dNlTN4p4tzZ/vqrI4nGDtqFzUY+KDg=;
        b=UWVp04zye+oewABRxix51t0TRsFXXR3pLjoejridAOZVIoUAaZGVHC0dkBUK97Qc4LOOHG
        h/Y59+vPypLBYLcCZjf1RRUv2vcJc7Sab1eha4osGA7LF9lmzgYiupY1l0VzcwDKIL7x/Z
        EzyQuIHjB0u+F7Nb/Uj5Us1BrOAp1xH4RFI8tO+6lzRboOJ2/99mzViA0WN+vN0lodshUB
        r/8fjiiyUsVvPevw06ErSaoVXMH45EpSTZ/a9vaW23m+9rkQ2bTtv+XG7VAuF2noDSv94Z
        ShyC061S5uaVWNylxQJvLOEOkd66AtRzpuGsDij3YknopqkNhWkJ7Dvla2npFA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/2] ARM: at91: pm: add support for sama5d2 secure suspend
Date:   Mon,  2 May 2022 17:22:19 +0200
Message-Id: <20220502152219.216758-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220502152219.216758-1-clement.leger@bootlin.com>
References: <20220502152219.216758-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/mach-at91/Kconfig      | 11 +++++++++-
 arch/arm/mach-at91/pm.c         | 36 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/sam_secure.h |  4 ++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 279810381256..0e05da5b0aa3 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -209,7 +209,16 @@ config SOC_SAMA5
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
 
 config SOC_SAMA7
 	bool
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 0fd609e26615..d6886af9b205 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -27,6 +27,7 @@
 
 #include "generic.h"
 #include "pm.h"
+#include "sam_secure.h"
 
 #define BACKUP_DDR_PHY_CALIBRATION	(9)
 
@@ -881,6 +882,35 @@ static int __init at91_pm_backup_init(void)
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
@@ -1213,6 +1243,12 @@ void __init sama5d2_pm_init(void)
 	if (!IS_ENABLED(CONFIG_SOC_SAMA5D2))
 		return;
 
+	if (IS_ENABLED(CONFIG_ATMEL_SECURE_PM)) {
+		pr_warn("AT91: Secure PM: ignoring standby mode\n");
+		at91_pm_secure_init();
+		return;
+	}
+
 	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
 	at91_pm_modes_init(iomaps, ARRAY_SIZE(iomaps));
 	ret = at91_dt_ramc(false);
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

