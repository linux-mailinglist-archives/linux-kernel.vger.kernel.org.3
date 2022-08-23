Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0859DCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358279AbiHWLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357526AbiHWLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:35:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D4910A0;
        Tue, 23 Aug 2022 02:27:35 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3quqcTNyN/mUOUlhCcLV5IeXBWpbn7rt3x+6aK7yOxE=;
        b=sxz92VFjnneuL7yMXNDV06kgpKXtb4XO7T33nq9rqaoyzExBGZO+8o9Cu3mtr2M+Wxu9Q7
        l7F7pBOEYyORoBLE6IuIar+ZT1KmnYJ8s+jzBftLC2fnGQ3OnZPF3dENwVy63XJ+YM/jVU
        XU0jbQ4FPscCiv2eDBqC0rrxB2sPD756z554CV6c/l1Pi/VaVonz85j/VjqFyBl3noriii
        +KjGowz7fUwoQY9XYcOrU3c6xJ4RJ+map80asMUe6GsxHIpIZE0UdF6vYI07hUwD3KfNXg
        ro1cuhXt0UZM8TtVnrn9qO1Go969jANoF4PYuTtH7zaFCYzkxeiVEGkTE7gYfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3quqcTNyN/mUOUlhCcLV5IeXBWpbn7rt3x+6aK7yOxE=;
        b=2V8K2x5kVUvQrBfFNBIPaRVhkqPvi//PjfbMaU2qBvu0PHA3VWX+LYYnHgoz6Gaw6RNRFC
        338Vv87CqxuXhNCA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Combine detach into dequeue when migrating task
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-6-zhouchengming@bytedance.com>
References: <20220818124805.601-6-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685291.401.6431095984775044781.tip-bot2@tip-bot2>
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

Commit-ID:     e1f078f50478a51849453341e7356cb298df00cf
Gitweb:        https://git.kernel.org/tip/e1f078f50478a51849453341e7356cb298df00cf
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:48:01 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:18 +02:00

sched/fair: Combine detach into dequeue when migrating task

When we are migrating task out of the CPU, we can combine detach and
propagation into dequeue_entity() to save the detach_entity_cfs_rq()
in migrate_task_rq_fair().

This optimization is like combining DO_ATTACH in the enqueue_entity()
when migrating task to the CPU. So we don't have to traverse the CFS tree
extra time to do the detach_entity_cfs_rq() -> propagate_entity_cfs_rq(),
which wouldn't be called anymore with this patch's change.

detach_task()
  deactivate_task()
    dequeue_task_fair()
      for_each_sched_entity(se)
        dequeue_entity()
          update_load_avg() /* (1) */
            detach_entity_load_avg()

  set_task_cpu()
    migrate_task_rq_fair()
      detach_entity_cfs_rq() /* (2) */
        update_load_avg();
        detach_entity_load_avg();
        propagate_entity_cfs_rq();
          for_each_sched_entity()
            update_load_avg()

This patch save the detach_entity_cfs_rq() called in (2) by doing
the detach_entity_load_avg() for a CPU migrating task inside (1)
(the task being the first se in the loop)

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-6-zhouchengming@bytedance.com
---
 kernel/sched/fair.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52de830..f52e7dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4003,6 +4003,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 #define UPDATE_TG	0x1
 #define SKIP_AGE_LOAD	0x2
 #define DO_ATTACH	0x4
+#define DO_DETACH	0x8
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4032,6 +4033,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq);
 
+	} else if (flags & DO_DETACH) {
+		/*
+		 * DO_DETACH means we're here from dequeue_entity()
+		 * and we are migrating task out of the CPU.
+		 */
+		detach_entity_load_avg(cfs_rq, se);
+		update_tg_load_avg(cfs_rq);
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
@@ -4292,6 +4300,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
+#define DO_DETACH	0x0
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
@@ -4512,6 +4521,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	int action = UPDATE_TG;
+
+	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
+		action |= DO_DETACH;
+
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
@@ -4526,7 +4540,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
 	 */
-	update_load_avg(cfs_rq, se, UPDATE_TG);
+	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
@@ -7078,8 +7092,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
-static void detach_entity_cfs_rq(struct sched_entity *se);
-
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7101,15 +7113,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
 
-	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
-		/*
-		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
-		 * rq->lock and can modify state directly.
-		 */
-		lockdep_assert_rq_held(task_rq(p));
-		detach_entity_cfs_rq(se);
-
-	} else {
+	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
 
 		/*
