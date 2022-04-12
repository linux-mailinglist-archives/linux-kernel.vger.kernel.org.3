Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9354FE4BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357052AbiDLPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357076AbiDLPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:31:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF625C369
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649777316; x=1681313316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/f3HFnQlFD4IpOdJmljw6mNj9T0rlSpe8YQVJAXamr0=;
  b=jkJjShNUPmQSLekPwkeP7nOoRnFxiJ4AkjKbuZoS2hlf1MhONw1RNDWP
   5Mpg3/CCAdMnP1UcO27XroaLQl63Juw4ezj7VJ19UK1sOVu13EHkXKQLI
   s3kiWALhizapJ1ZFqUn0ctaIAj0f4OAIw8sv/Xan0I/+vwAxaNbL1/LYO
   5wQ52UCJs/Zha7CT4nfqREtPvQ4lQleNBriiJG/mtLfULPVR3Mhnwm1XU
   A9RGlcY0/UIw8U3FbW6TQNvlSvWtuk13TqcW6XbuEQEmHUn0Jn2sxh0fT
   HmBqCk8Nnnm5m8yqyjGwZautG6wmrkgAQOMtXPHK8pp6v6seGzzaxGGZq
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,254,1643698800"; 
   d="scan'208";a="159838696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2022 08:28:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 12 Apr 2022 08:28:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 12 Apr 2022 08:28:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/4] ARM: at91: pm: introduce macros for pm mode replacement
Date:   Tue, 12 Apr 2022 18:30:44 +0300
Message-ID: <20220412153046.50014-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220412153046.50014-1-claudiu.beznea@microchip.com>
References: <20220412153046.50014-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce macros to replace standby/suspend mode if they depends on
controllers that failed to map (or other errors). Macros keep track
of the complementary mode to avoid having set the same AT91 PM mode
for both suspend and standby.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 83 +++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 7ea4c7f13d28..2a52ddac7692 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -888,10 +888,63 @@ static const struct of_device_id atmel_shdwc_ids[] = {
 	{ /* sentinel. */ }
 };
 
+/*
+ * Replaces _mode_to_replace with a supported mode that doesn't depend
+ * on controller pointed by _map_bitmask
+ * @_maps: u32 array containing AT91_PM_IOMAP() flags and indexed by AT91
+ * PM mode
+ * @_map_bitmask: AT91_PM_IOMAP() bitmask; if _mode_to_replace depends on
+ * controller represented by _map_bitmask, _mode_to_replace needs to be
+ * updated
+ * @_mode_to_replace: standby_mode or suspend_mode that need to be
+ * updated
+ * @_mode_to_check: standby_mode or suspend_mode; this is needed here
+ * to avoid having standby_mode and suspend_mode set with the same AT91
+ * PM mode
+ */
+#define AT91_PM_REPLACE_MODE(_maps, _map_bitmask, _mode_to_replace,	\
+			     _mode_to_check)				\
+	do {								\
+		if (((_maps)[(_mode_to_replace)]) & (_map_bitmask)) {	\
+			int _mode_to_use, _mode_complementary;		\
+			/* Use ULP0 if it doesn't need _map_bitmask. */	\
+			if (!((_maps)[AT91_PM_ULP0] & (_map_bitmask))) {\
+				_mode_to_use = AT91_PM_ULP0;		\
+				_mode_complementary = AT91_PM_STANDBY;	\
+			} else {					\
+				_mode_to_use = AT91_PM_STANDBY;		\
+				_mode_complementary = AT91_PM_STANDBY;	\
+			}						\
+									\
+			if ((_mode_to_check) != _mode_to_use)		\
+				(_mode_to_replace) = _mode_to_use;	\
+			else						\
+				(_mode_to_replace) = _mode_complementary;\
+		}							\
+	} while (0)
+
+/*
+ * Replaces standby and suspend modes with default supported modes:
+ * ULP0 and STANDBY.
+ * @_maps: u32 array indexed by AT91 PM mode containing AT91_PM_IOMAP()
+ * flags
+ * @_map: controller specific name; standby and suspend mode need to be
+ * replaced in order to not depend on this controller
+ */
+#define AT91_PM_REPLACE_MODES(_maps, _map)				\
+	do {								\
+		AT91_PM_REPLACE_MODE((_maps), BIT(AT91_PM_IOMAP_##_map),\
+				     (soc_pm.data.standby_mode),	\
+				     (soc_pm.data.suspend_mode));	\
+		AT91_PM_REPLACE_MODE((_maps), BIT(AT91_PM_IOMAP_##_map),\
+				     (soc_pm.data.suspend_mode),	\
+				     (soc_pm.data.standby_mode));	\
+	} while (0)
+
 static void __init at91_pm_modes_init(const u32 *maps, int len)
 {
 	struct device_node *np;
-	int ret, mode;
+	int ret;
 
 	ret = at91_pm_backup_init();
 	if (ret) {
@@ -906,17 +959,7 @@ static void __init at91_pm_modes_init(const u32 *maps, int len)
 		np = of_find_matching_node(NULL, atmel_shdwc_ids);
 		if (!np) {
 			pr_warn("%s: failed to find shdwc!\n", __func__);
-
-			/* Use ULP0 if it doesn't needs SHDWC.*/
-			if (!(maps[AT91_PM_ULP0] & AT91_PM_IOMAP(SHDWC)))
-				mode = AT91_PM_ULP0;
-			else
-				mode = AT91_PM_STANDBY;
-
-			if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SHDWC))
-				soc_pm.data.standby_mode = mode;
-			if (maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SHDWC))
-				soc_pm.data.suspend_mode = mode;
+			AT91_PM_REPLACE_MODES(maps, SHDWC);
 		} else {
 			soc_pm.data.shdwc = of_iomap(np, 0);
 			of_node_put(np);
@@ -928,21 +971,7 @@ static void __init at91_pm_modes_init(const u32 *maps, int len)
 		np = of_find_compatible_node(NULL, NULL, "atmel,sama5d2-sfrbu");
 		if (!np) {
 			pr_warn("%s: failed to find sfrbu!\n", __func__);
-
-			/*
-			 * Use ULP0 if it doesn't need SHDWC or if SHDWC
-			 * was already located.
-			 */
-			if (!(maps[AT91_PM_ULP0] & AT91_PM_IOMAP(SHDWC)) ||
-			    soc_pm.data.shdwc)
-				mode = AT91_PM_ULP0;
-			else
-				mode = AT91_PM_STANDBY;
-
-			if (maps[soc_pm.data.standby_mode] & AT91_PM_IOMAP(SFRBU))
-				soc_pm.data.standby_mode = mode;
-			if (maps[soc_pm.data.suspend_mode] & AT91_PM_IOMAP(SFRBU))
-				soc_pm.data.suspend_mode = mode;
+			AT91_PM_REPLACE_MODES(maps, SFRBU);
 		} else {
 			soc_pm.data.sfrbu = of_iomap(np, 0);
 			of_node_put(np);
-- 
2.32.0

