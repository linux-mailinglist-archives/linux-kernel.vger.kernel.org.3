Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AB4D0C10
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiCGXbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiCGXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:31:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0954689
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDF6611F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AA3C340EF;
        Mon,  7 Mar 2022 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646695848;
        bh=u+BvVr/Wp6XjLXmh6ySV7xAFGMyKknzpmr77j0QOXWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4fDMTFGtdpupDac8y6U971sTR3tGZFpKv51M9q2anrEJsNwd8oxj3RADec2rsFTh
         KhIhq/XmS1kAcUvuJaEPrOPUJECoWSarHeDZVIOkKsr8lQ9bCCSmfiQvRo2dsED9at
         R1HM0Icfq0BzoSCyQ8QdaGJHJaHkrAhnKXodtBA4hCoxhWy6VN1S/H6LBxef+/A9hQ
         5P5u7QE2SC0J3VrI2f6uugb56TTlWxKUtk/q1WVq4pzNaLaLAPfv2onDhL+H1B2udw
         Y/UGBuJP2p0BXVpHbcrbe8speQOh5ZTpIXJiWhXCxzE9Mi53cA9E7w42F67wYFa29F
         Urpg1bgHe23aA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/4] tick/rcu: Stop allowing RCU_SOFTIRQ in idle
Date:   Tue,  8 Mar 2022 00:30:33 +0100
Message-Id: <20220307233034.34550-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307233034.34550-1-frederic@kernel.org>
References: <20220307233034.34550-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU_SOFTIRQ used to be special in that it could be raised on purpose
within the idle path to prevent from stopping the tick. Some code still
prevents from unnecessary warnings related to this specific behaviour
while entering in dynticks-idle mode.

However the nohz layout has changed quite a bit in ten years, and the
removal of CONFIG_RCU_FAST_NO_HZ has been the final straw to this
safe-conduct. Now the RCU_SOFTIRQ vector is expected to be raised from
sane places.

A remaining corner case is admitted though when the vector is invoked
in fragile hotplug path.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/interrupt.h |  8 ++++++-
 kernel/time/tick-sched.c  | 50 +++++++++++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9367f1cb2e3c..9613326d2f8a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -579,7 +579,13 @@ enum
 	NR_SOFTIRQS
 };
 
-#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+/*
+ * Ignoring the RCU vector after ksoftirqd is parked is fine
+ * because:
+ * 	1) rcutree_migrate_callbacks() takes care of the queue.
+ * 	2) rcu_report_dead() reports the final quiescent states.
+ */
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ))
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 566ad5bd83e9..2d76c91b85de 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -999,6 +999,45 @@ static void tick_nohz_full_update_tick(struct tick_sched *ts)
 	__tick_nohz_full_update_tick(ts, ktime_get());
 }
 
+/*
+ * A pending softirq outside an IRQ (or softirq disabled section) context
+ * should be waiting for ksoftirqd to handle it. Therefore we shouldn't
+ * reach here due to the need_resched() early check in can_stop_idle_tick().
+ *
+ * However if we are between CPUHP_AP_SMPBOOT_THREADS and CPU_TEARDOWN_CPU on the
+ * cpu_down() process, softirqs can still be raised while ksoftirqd is parked,
+ * triggering the below since wakep_softirqd() is ignored.
+ *
+ */
+static bool report_idle_softirq(void)
+{
+	static int ratelimit;
+	unsigned int pending = local_softirq_pending();
+
+	if (likely(!pending))
+		return false;
+
+	/* Some softirqs claim to be safe against hotplug and ksoftirqd parking */
+	if (!cpu_active(smp_processor_id())) {
+		pending &= ~SOFTIRQ_HOTPLUG_SAFE_MASK;
+		if (!pending)
+			return false;
+	}
+
+	if (ratelimit < 10)
+		return false;
+
+	/* On RT, softirqs handling may be waiting on some lock */
+	if (!local_bh_blocked())
+		return false;
+
+	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
+		pending);
+	ratelimit++;
+
+	return true;
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
@@ -1025,17 +1064,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (need_resched())
 		return false;
 
-	if (unlikely(local_softirq_pending())) {
-		static int ratelimit;
-
-		if (ratelimit < 10 && !local_bh_blocked() &&
-		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
-				(unsigned int) local_softirq_pending());
-			ratelimit++;
-		}
+	if (unlikely(report_idle_softirq()))
 		return false;
-	}
 
 	if (tick_nohz_full_enabled()) {
 		/*
-- 
2.25.1

