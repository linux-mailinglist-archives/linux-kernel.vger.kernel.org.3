Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D344D7E81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiCNJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiCNJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5917E34;
        Mon, 14 Mar 2022 02:28:18 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yYl7CB7j63UBU3Jg//CDwUXS2tRDp63txHBjUgu6exo=;
        b=DSfVSSVjIN+YZtuWJOMJE7q1yCN3flH61fhcspNcd5vg1J6M7cvOjUzpKbEUCSJ7hsDJY4
        Q/Wyy+4IaaB6gmdfdBceuM+GfwpbBsiM9yZoHZgQusc8yuJUU/6CscqqVoIqewxEQyCcmY
        kPFm/sAMt6mf0e90Mi9D9y6/xyuH18c3NJ55VAm7BkeFfxK4m13r0TdX25qSepAfd4P3jB
        /2m9/2nj6pBk6cNI13BVgqU2hdl4KNv0ZkvpUILuLD9aqEOU7CSZlVQMd4AQM0jZs1BRVb
        RtO8cRJvtw4K0K1MM3hFZYivMNYTjKWpTkE4vF8tcqNcvlnSf4tJZYwTiUSE2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yYl7CB7j63UBU3Jg//CDwUXS2tRDp63txHBjUgu6exo=;
        b=c+MT3EBVru7I+TzJCKzvl9sM3NioOj6xNC4ILy1OzOn4gAmf7J3uBIcUrSqLFcfEmaNBcB
        auHymPaQs1tkNzDg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/rcu: Remove obsolete rcu_needs_cpu() parameters
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164725009622.16921.3910394351313618828.tip-bot2@tip-bot2>
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

Commit-ID:     2984539959dbaf4e65e19bf90c2419304a81a985
Gitweb:        https://git.kernel.org/tip/2984539959dbaf4e65e19bf90c2419304a81a985
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 08 Feb 2022 17:16:33 +01:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 07 Mar 2022 23:01:26 +01:00

tick/rcu: Remove obsolete rcu_needs_cpu() parameters

With the removal of CONFIG_RCU_FAST_NO_HZ, the parameters in
rcu_needs_cpu() are not necessary anymore. Simply remove them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/rcutiny.h  |  3 +--
 include/linux/rcutree.h  |  2 +-
 kernel/rcu/tree.c        |  3 +--
 kernel/time/tick-sched.c | 10 ++++------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 858f4d4..5fed476 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -64,9 +64,8 @@ static inline void rcu_softirq_qs(void)
 		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
 
-static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+static inline int rcu_needs_cpu(void)
 {
-	*nextevt = KTIME_MAX;
 	return 0;
 }
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 53209d6..6cc9129 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -19,7 +19,7 @@
 
 void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
-int rcu_needs_cpu(u64 basem, u64 *nextevt);
+int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6..80faf22 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1086,9 +1086,8 @@ void rcu_irq_enter_irqson(void)
  * Just check whether or not this CPU has non-offloaded RCU callbacks
  * queued.
  */
-int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+int rcu_needs_cpu(void)
 {
-	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
 		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c89f50a..566ad5b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -785,7 +785,7 @@ static inline bool local_timer_softirq_pending(void)
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
+	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
 
@@ -808,7 +808,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
+	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
@@ -819,10 +819,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tmr = get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer = next_tmr;
-		/* Take the next rcu event into account */
-		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
+		next_tick = get_next_timer_interrupt(basejiff, basemono);
+		ts->next_timer = next_tick;
 	}
 
 	/*
