Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77A4D2435
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbiCHW0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350726AbiCHW0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E4583BD;
        Tue,  8 Mar 2022 14:25:25 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gm9S4UxEFEYJAUz2hPwmy3t6xAndwByHQYXpSxyyxdQ=;
        b=lqVPQmjpxbJcg2oJ6+jSUEJjxyBA5n2MMkdK0vFECG6x1yT6otcWZ0qHr9wj3n4HeqBNUR
        8d5v7gsy/W1bvK0olD0Rlf6B9lGLvcv9Qcz+E5BmVXl8I1+JOASoULKXTNMz5Hv4+AN34R
        ATE3sLv/FHpnvkFchnc1iIgVcAVc/5PK9VzyDF3dGlpYQffres+qDbrPDjK/GsHGyk4fF8
        Iy2OCwO4LdYoyIWfgKxv9t9hq4aR2RzAfyzaEbfPIXVGh/Cixyg0Wza6Uy2Edss5e/FuAl
        wQEtGvzSfnpz7mA6Vl2Upj9/5UcOJvJb169+HI8jyB8AOpnr4MRZizN7u7kvnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gm9S4UxEFEYJAUz2hPwmy3t6xAndwByHQYXpSxyyxdQ=;
        b=hC5W+GGG4lwqCv9BLgKPDviY3J+sLgqJWjMnfuU2znZK0wT38h0rdhwTKOwRZQhqKOt/Uz
        ZEHO3uf9J06L+NBw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Move bandwidth mgmt and reclaim
 functions into sched class source file
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-3-dietmar.eggemann@arm.com>
References: <20220302183433.333029-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677832305.16921.17722689986095840391.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f1304ecbef3c9f4aec119ce2a07335d3a0bc55a6
Gitweb:        https://git.kernel.org/tip/f1304ecbef3c9f4aec119ce2a07335d3a0bc55a6
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:39 +01:00

sched/deadline: Move bandwidth mgmt and reclaim functions into sched class source file

Move the deadline bandwidth management (admission control) functions
__dl_add(), __dl_sub() and __dl_overflow() as well as the bandwidth
reclaim function __dl_update() from private task scheduler header file
to the deadline sched class source file.
The functions are only used internally so they don't have to be
exported.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-3-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 44 ++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h    | 49 +----------------------------------------
 2 files changed, 44 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ed4251f..81bf976 100644
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
@@ -148,9 +163,38 @@ static inline bool dl_bw_visited(int cpu, u64 gen)
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
 
 static inline
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
+static inline
 void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 {
 	u64 old = dl_rq->running_bw;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8b8516..4dfc3b0 100644
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
