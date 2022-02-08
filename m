Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480A34ADE15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382890AbiBHQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiBHQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:16:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0EC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A4F2B81BDD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795C3C340EF;
        Tue,  8 Feb 2022 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337002;
        bh=Vs+f44lnIytigGrVrSLdddTGPc/R0+RbyevkTBO4lDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQfLUiJyd68l6VijxFrp22OLIznr/JZtNc4GHEChy1E7TVLfk8fpIqn+2fU5A0QJo
         vTEifznow0XuSy7yFo0DLtu6VOa3+hpfjr1JMpQGrGOt4/lse1f74875y9Kixt9IG5
         st7bHcha7BbGAvcoAG0te44ocZif55surenEU+UmqYGVZrFLdCsae9UzNMK3pXlV/T
         /4L+1NBBkAKYZXe8xCrXaYkv1zr+feR2q75HpreGKHH9whSVW4dhOB8nPeo+XFgQTa
         KG2mmgHLqSYEtBU6aPjMvwHtea50vV/0IesNGkA18jEV2dYiLAXrugFjJATYJSln9N
         sqcFF56iUM8Ug==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/3] tick/rcu: Remove obsolete rcu_needs_cpu() parameters
Date:   Tue,  8 Feb 2022 17:16:33 +0100
Message-Id: <20220208161635.544701-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208161635.544701-1-frederic@kernel.org>
References: <20220208161635.544701-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 858f4d429946..5fed476f977f 100644
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
index 53209d669400..6cc91291d078 100644
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
index a4c25a6283b0..80faf2273ce9 100644
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
index 17a283ce2b20..2abb5112feb9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -768,7 +768,7 @@ static inline bool local_timer_softirq_pending(void)
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
+	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
 
@@ -791,7 +791,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
+	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
@@ -802,10 +802,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
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
-- 
2.25.1

