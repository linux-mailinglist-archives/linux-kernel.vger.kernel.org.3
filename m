Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D219A51D343
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390117AbiEFIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390103AbiEFIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:25:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91278101CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651825281; x=1683361281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0nyIRt8+P2D4T0o2FTpGORg0xuUTljsVHNnTBd1d7Q=;
  b=hOpxAHo+m27Sez9sZo6PpM/1W6EJOKwOczL7m50tCMf6c18j+G8JHvlA
   QQ6O8HqPf9UOaOse9JPfmhYPIbXgqn0x3K2Bn5rNo+XZpMnKdn0ZicLLk
   59qg7XqPdaDKYENK5WiS7IgktdV0V1Ho1MXGFwB0Jaz/OPr0wX+Jk4ABL
   zJyCcBg7Do2fo7002Vl/ZyJezMaUvTCoXxmZIpOpJShNlUQpQ1h+YtFD8
   xuIYt+SxSwMD/i/9sE6emlUvJ3foUa4DogULFaSehSj7fROx7rxp/yi6Q
   rgRJiSjsVE77o9wHOsbQuCHO59eOdVCjwWglG4VkBSqFaYvbKfvn9z4vb
   A==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="158023612"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2022 01:21:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 6 May 2022 01:21:20 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 6 May 2022 01:21:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/4] ARM: at91: pm: introduce macros for pm mode replacement
Date:   Fri, 6 May 2022 11:23:33 +0300
Message-ID: <20220506082335.3817259-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
References: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

