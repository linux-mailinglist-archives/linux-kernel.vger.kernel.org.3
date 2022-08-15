Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA2592F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbiHONNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiHONNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:13:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60AB01AF1D;
        Mon, 15 Aug 2022 06:13:33 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 032098231;
        Mon, 15 Aug 2022 13:06:39 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] clocksource/drivers/timer-ti-dm: Move private defines to the driver
Date:   Mon, 15 Aug 2022 16:12:46 +0300
Message-Id: <20220815131250.34603-6-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815131250.34603-1-tony@atomide.com>
References: <20220815131250.34603-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These defines are only used by timer-ti-dm driver.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 62 +++++++++++++++++++++++++++++++
 include/clocksource/timer-ti-dm.h | 62 -------------------------------
 2 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -33,6 +33,68 @@
 
 #include <clocksource/timer-ti-dm.h>
 
+/*
+ * timer errata flags
+ *
+ * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
+ * errata prevents us from using posted mode on these devices, unless the
+ * timer counter register is never read. For more details please refer to
+ * the OMAP3/4/5 errata documents.
+ */
+#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
+
+/* posted mode types */
+#define OMAP_TIMER_NONPOSTED			0x00
+#define OMAP_TIMER_POSTED			0x01
+
+/* register offsets with the write pending bit encoded */
+#define	WPSHIFT					16
+
+#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
+							| (WP_TCLR << WPSHIFT))
+
+#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
+							| (WP_TCRR << WPSHIFT))
+
+#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
+							| (WP_TLDR << WPSHIFT))
+
+#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
+							| (WP_TTGR << WPSHIFT))
+
+#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
+							| (WP_TMAR << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
+							| (WP_TPIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
+							| (WP_TNIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
+							| (WP_TCVR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
+
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -52,10 +52,6 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
-/* posted mode types */
-#define OMAP_TIMER_NONPOSTED			0x00
-#define OMAP_TIMER_POSTED			0x01
-
 /* timer capabilities used in hwmod database */
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
@@ -63,16 +59,6 @@
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
 #define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
 
-/*
- * timer errata flags
- *
- * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
- * errata prevents us from using posted mode on these devices, unless the
- * timer counter register is never read. For more details please refer to
- * the OMAP3/4/5 errata documents.
- */
-#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
-
 struct timer_regs {
 	u32 ocp_cfg;
 	u32 tidr;
@@ -192,52 +178,4 @@ u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 #define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
 #define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
 
-/* register offsets with the write pending bit encoded */
-#define	WPSHIFT					16
-
-#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
-							| (WP_TCLR << WPSHIFT))
-
-#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
-							| (WP_TCRR << WPSHIFT))
-
-#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
-							| (WP_TLDR << WPSHIFT))
-
-#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
-							| (WP_TTGR << WPSHIFT))
-
-#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
-							| (WP_TMAR << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
-							| (WP_TPIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
-							| (WP_TNIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
-							| (WP_TCVR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
-
 #endif /* __CLOCKSOURCE_DMTIMER_H */
-- 
2.37.1
