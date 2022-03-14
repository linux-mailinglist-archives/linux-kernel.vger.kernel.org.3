Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE604D7E82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiCNJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiCNJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2033527A;
        Mon, 14 Mar 2022 02:28:17 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N1nMKWa4Wte7sPkoEe/iOaoqC5bC9zSROJdxbx1qa0w=;
        b=2lCk2c2/zFn9e9E9o39wX8lkdgMH7nb3K+DQbj++Div1a2l4RpgmW6iG8DRh5tDgpm4ZO5
        567DAZ1mmNW1gQGPvsYU3WBwA5LJf7qUd+a13+iwvnGSEAO4z2DNZLAUk2V+u3qMDQsKFq
        Xk4VpnshQiLWPCFmrkvnoV4ySnwQtNp1WXz7iY46Wlni5G2Id5oTk56km2cPFMVoM5R+xl
        PrvZycjFqLU6PldcyvjsABaWZyFSSdXeRi8XJ5cDnYt1HrzxHHq3N8b2RjYdoHmqOUdgT6
        EyklSy7wLOl5j7fcwFJPt2jx23WprRq/1zVENgNL9bciKx1dDEqoO+cXnA7r6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N1nMKWa4Wte7sPkoEe/iOaoqC5bC9zSROJdxbx1qa0w=;
        b=Fc+0uLo1Eh5zrC4500rsdTcJ1ua5VoGeWR0cTG3V8Y2pW5k4+uBDBuVhyhrnGGv7zL8yst
        skjtocMsHIg0/kDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/rcu: Stop allowing RCU_SOFTIRQ in idle
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164725009509.16921.13309674186697759166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0345691b24c076655ce8f0f4bfd24cba3467ccbd
Gitweb:        https://git.kernel.org/tip/0345691b24c076655ce8f0f4bfd24cba3467ccbd
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 08 Feb 2022 17:16:34 +01:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 07 Mar 2022 23:01:34 +01:00

tick/rcu: Stop allowing RCU_SOFTIRQ in idle

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
 include/linux/interrupt.h |  8 +++++-
 kernel/time/tick-sched.c  | 50 ++++++++++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9367f1c..9613326 100644
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
index 566ad5b..2d76c91 100644
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
