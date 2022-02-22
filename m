Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5C4BFBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiBVPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiBVPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:11:10 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C7710EC4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:10:44 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0614AFF808;
        Tue, 22 Feb 2022 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645542643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtKL8F/Jq2zYU6K+/py9GTxpMsuM+hyFjUkbGMfpBM8=;
        b=fpCxi/gpQB8ymagHFzpSGHRh9evnDJfs8mijFq206mD+Yy/+eAZpotSk6Q7xmKRtKC7vsL
        55v7gXCYcoCZ4WHRhrcnQX20PDTtRSc5GPGEf2AdetXvvvxPIz6byxlThuvejkgAyOLXKR
        7uk48uZSRIKDZOeDP/VAwyeMJlZR1T9lJGs3SEgCkYtDuWAodQLkcbhbUAqQ10tlquglkw
        G70LtGtP2N0o+XEKKN28HP3TU249JHgbG1Hytv+wiyNRruTH08VjaPozBBG4e552gObvzh
        H7SSg3MRhTJtW6BKWxeewGMMeoUrVHK3CZ9ZfMSg779uR76bT3Ka0HItU0CI/g==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 2/4] ARM: at91: pm: move "atmel.pm_modes" parsing into a common file
Date:   Tue, 22 Feb 2022 16:08:44 +0100
Message-Id: <20220222150846.255307-3-clement.leger@bootlin.com>
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

In order to add secure suspend support, split out code that will be
reused to parse the boot argument "atmel.pm_modes".

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 arch/arm/mach-at91/Makefile    |  2 +-
 arch/arm/mach-at91/pm.c        | 31 ++-------------------------
 arch/arm/mach-at91/pm.h        |  7 ++++++
 arch/arm/mach-at91/pm_common.c | 39 ++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_common.c

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 0dcc37180588..23620ccf7ab6 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
 obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
 
 # Power Management
-obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o
+obj-$(CONFIG_ATMEL_PM)		+= pm.o pm_suspend.o pm_common.o
 
 ifeq ($(CONFIG_CPU_V7),y)
 AFLAGS_pm_suspend.o := -march=armv7-a
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index dd6f4ce3f766..b575304ccf63 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -99,15 +99,6 @@ static struct at91_soc_pm soc_pm = {
 	},
 };
 
-static const match_table_t pm_modes __initconst = {
-	{ AT91_PM_STANDBY,	"standby" },
-	{ AT91_PM_ULP0,		"ulp0" },
-	{ AT91_PM_ULP0_FAST,    "ulp0-fast" },
-	{ AT91_PM_ULP1,		"ulp1" },
-	{ AT91_PM_BACKUP,	"backup" },
-	{ -1, NULL },
-};
-
 #define at91_ramc_read(id, field) \
 	__raw_readl(soc_pm.data.ramc[id] + field)
 
@@ -1243,25 +1234,7 @@ void __init sama7_pm_init(void)
 
 static int __init at91_pm_modes_select(char *str)
 {
-	char *s;
-	substring_t args[MAX_OPT_ARGS];
-	int standby, suspend;
-
-	if (!str)
-		return 0;
-
-	s = strsep(&str, ",");
-	standby = match_token(s, pm_modes, args);
-	if (standby < 0)
-		return 0;
-
-	suspend = match_token(str, pm_modes, args);
-	if (suspend < 0)
-		return 0;
-
-	soc_pm.data.standby_mode = standby;
-	soc_pm.data.suspend_mode = suspend;
-
-	return 0;
+	return at91_pm_common_modes_select(str, &soc_pm.data.standby_mode,
+					   &soc_pm.data.suspend_mode);
 }
 early_param("atmel.pm_modes", at91_pm_modes_select);
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 53bdc9000e44..e9f7f9841afd 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -40,6 +40,13 @@ struct at91_pm_data {
 	unsigned int pmc_mckr_offset;
 	unsigned int pmc_version;
 };
+
+#include <linux/parser.h>
+
+extern const match_table_t pm_modes;
+
+int at91_pm_common_modes_select(char *str, int *standby_mode, int *suspend_mode);
+
 #endif
 
 #endif
diff --git a/arch/arm/mach-at91/pm_common.c b/arch/arm/mach-at91/pm_common.c
new file mode 100644
index 000000000000..45b74fb0a211
--- /dev/null
+++ b/arch/arm/mach-at91/pm_common.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/kernel.h>
+#include <linux/parser.h>
+#include <linux/string.h>
+
+#include "pm.h"
+
+const match_table_t pm_modes __initconst = {
+	{ AT91_PM_STANDBY,	"standby" },
+	{ AT91_PM_ULP0,		"ulp0" },
+	{ AT91_PM_ULP0_FAST,    "ulp0-fast" },
+	{ AT91_PM_ULP1,		"ulp1" },
+	{ AT91_PM_BACKUP,	"backup" },
+	{ -1, NULL },
+};
+
+int at91_pm_common_modes_select(char *str, int *standby_mode, int *suspend_mode)
+{
+	char *s;
+	substring_t args[MAX_OPT_ARGS];
+	int standby, suspend;
+
+	if (!str)
+		return 0;
+
+	s = strsep(&str, ",");
+	standby = match_token(s, pm_modes, args);
+	if (standby < 0)
+		return 0;
+
+	suspend = match_token(str, pm_modes, args);
+	if (suspend < 0)
+		return 0;
+
+	*standby_mode = standby;
+	*suspend_mode = suspend;
+
+	return 0;
+}
-- 
2.34.1

