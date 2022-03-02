Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB114CADA4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbiCBSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiCBSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:35:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83571D64ED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:34:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405871480;
        Wed,  2 Mar 2022 10:34:55 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A30463F73D;
        Wed,  2 Mar 2022 10:34:52 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched/deadline: Move bandwidth mgmt and reclaim functions into sched class source file
Date:   Wed,  2 Mar 2022 19:34:29 +0100
Message-Id: <20220302183433.333029-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302183433.333029-1-dietmar.eggemann@arm.com>
References: <20220302183433.333029-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the deadline bandwidth management (admission control) functions
__dl_add(), __dl_sub() and __dl_overflow() as well as the bandwidth
reclaim function __dl_update() from private task scheduler header file
to the deadline sched class source file.
The functions are only used internally so they don't have to be
exported.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 44 ++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    | 49 -----------------------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ed4251fa87c7..81bf97648e42 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -128,6 +128,21 @@ static inline bool dl_bw_visited(int cpu, u64 gen)
 	rd->visit_gen = gen;
 	return false;
 }
+
+static inline
+void __dl_update(struct dl_bw *dl_b, s64 bw)
+{
+	struct root_domain *rd = container_of(dl_b, struct root_domain, dl_bw);
+	int i;
+
+	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
+			 "sched RCU must be held");
+	for_each_cpu_and(i, rd->span, cpu_active_mask) {
+		struct rq *rq = cpu_rq(i);
+
+		rq->dl.extra_bw += bw;
+	}
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -148,8 +163,37 @@ static inline bool dl_bw_visited(int cpu, u64 gen)
 {
 	return false;
 }
+
+static inline
+void __dl_update(struct dl_bw *dl_b, s64 bw)
+{
+	struct dl_rq *dl = container_of(dl_b, struct dl_rq, dl_bw);
+
+	dl->extra_bw += bw;
+}
 #endif
 
+static inline
+void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+{
+	dl_b->total_bw -= tsk_bw;
+	__dl_update(dl_b, (s32)tsk_bw / cpus);
+}
+
+static inline
+void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+{
+	dl_b->total_bw += tsk_bw;
+	__dl_update(dl_b, -((s32)tsk_bw / cpus));
+}
+
+static inline bool
+__dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
+{
+	return dl_b->bw != -1 &&
+	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
+}
+
 static inline
 void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8b8516b8452..4dfc3b02df61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -301,29 +301,6 @@ struct dl_bw {
 	u64			total_bw;
 };
 
-static inline void __dl_update(struct dl_bw *dl_b, s64 bw);
-
-static inline
-void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
-{
-	dl_b->total_bw -= tsk_bw;
-	__dl_update(dl_b, (s32)tsk_bw / cpus);
-}
-
-static inline
-void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
-{
-	dl_b->total_bw += tsk_bw;
-	__dl_update(dl_b, -((s32)tsk_bw / cpus));
-}
-
-static inline bool __dl_overflow(struct dl_bw *dl_b, unsigned long cap,
-				 u64 old_bw, u64 new_bw)
-{
-	return dl_b->bw != -1 &&
-	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
-}
-
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
@@ -2748,32 +2725,6 @@ extern void nohz_run_idle_balance(int cpu);
 static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
-#ifdef CONFIG_SMP
-static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
-{
-	struct root_domain *rd = container_of(dl_b, struct root_domain, dl_bw);
-	int i;
-
-	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
-			 "sched RCU must be held");
-	for_each_cpu_and(i, rd->span, cpu_active_mask) {
-		struct rq *rq = cpu_rq(i);
-
-		rq->dl.extra_bw += bw;
-	}
-}
-#else
-static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
-{
-	struct dl_rq *dl = container_of(dl_b, struct dl_rq, dl_bw);
-
-	dl->extra_bw += bw;
-}
-#endif
-
-
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 struct irqtime {
 	u64			total;
-- 
2.25.1

