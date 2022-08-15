Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26100592F85
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiHONN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242703AbiHONNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:13:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A707D12D3E;
        Mon, 15 Aug 2022 06:13:22 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2CEB381D0;
        Mon, 15 Aug 2022 13:06:29 +0000 (UTC)
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
Subject: [PATCH 1/9] clocksource/drivers/timer-ti-dm: Drop unused functions
Date:   Mon, 15 Aug 2022 16:12:42 +0300
Message-Id: <20220815131250.34603-2-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815131250.34603-1-tony@atomide.com>
References: <20220815131250.34603-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still have some unused functions left, let's drop them.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 51 -------------------------------
 include/clocksource/timer-ti-dm.h |  7 -----
 2 files changed, 58 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -388,16 +388,6 @@ static inline u32 omap_dm_timer_reserved_systimer(int id)
 	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
 }
 
-int omap_dm_timer_reserve_systimer(int id)
-{
-	if (omap_dm_timer_reserved_systimer(id))
-		return -ENODEV;
-
-	omap_reserved_systimers |= (1 << (id - 1));
-
-	return 0;
-}
-
 static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -499,20 +489,6 @@ static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
 }
 
-/**
- * omap_dm_timer_request_by_cap - Request a timer by capability
- * @cap:	Bit mask of capabilities to match
- *
- * Find a timer based upon capabilities bit mask. Callers of this function
- * should use the definitions found in the plat/dmtimer.h file under the
- * comment "timer capabilities used in hwmod database". Returns pointer to
- * timer handle on success and a NULL pointer on failure.
- */
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
-{
-	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
-}
-
 /**
  * omap_dm_timer_request_by_node - Request a timer by device-tree node
  * @np:		Pointer to device-tree timer node
@@ -606,17 +582,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 #endif
 
-int omap_dm_timer_trigger(struct omap_dm_timer *timer)
-{
-	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
-		return -EINVAL;
-	}
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	return 0;
-}
-
 static int omap_dm_timer_start(struct omap_dm_timer *timer)
 {
 	u32 l;
@@ -833,22 +798,6 @@ static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int
 	return 0;
 }
 
-int omap_dm_timers_active(void)
-{
-	struct omap_dm_timer *timer;
-
-	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->reserved)
-			continue;
-
-		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
-		    OMAP_TIMER_CTRL_ST) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
 	struct omap_dm_timer *timer = dev_get_drvdata(dev);
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -119,17 +119,10 @@ struct omap_dm_timer {
 	struct notifier_block nb;
 };
 
-int omap_dm_timer_reserve_systimer(int id);
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
-
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
 
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
 
-int omap_dm_timer_trigger(struct omap_dm_timer *timer);
-
-int omap_dm_timers_active(void);
-
 /*
  * Do not use the defines below, they are not needed. They should be only
  * used by dmtimer.c and sys_timer related code.
-- 
2.37.1
