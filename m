Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C655CDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiF1H5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343816AbiF1H5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:57:38 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B51573B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:57:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHgOW1q_1656403054;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VHgOW1q_1656403054)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 15:57:34 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched/core: Make tasks with the same cookie pairs on SMT siblings
Date:   Tue, 28 Jun 2022 15:57:25 +0800
Message-Id: <1656403045-100840-4-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the number of tasks in the runqueue of SMT siblings are equal, we call
the core balanced, otherwise unbalanced. If the core is balanced, everytime
we pick next task, we can pick a pair of tasks with the same cookie for
each SMT sibling, and forceidle will be avoided.

 - Migrate the task if source core and destination core can balance
     If ck->nr_running of src_cpu is the highest among the source core, and
     ck->nr_running of dst_cpu is the lowest among the destination core,
     migrate the task.

 - Select cookie matched idle CPU or idle CPU with the lowest
   ck->nr_running among the core
     In the fast path of task wakeup, if ck->nr_running of the cpu is the
     lowest among the core, we can select this cpu to wake up.

 - Find cookie matched idlest CPU or cookie matched CPU with the lowest
   ck->nr_running among the core
     In the slow path of task wakeup, if ck->nr_running of the cpu is the
     lowest among the core, we can select this cpu to wake up.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/fair.c  |  4 ++--
 kernel/sched/sched.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78795a9..c18a716 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6096,7 +6096,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		struct rq *rq = cpu_rq(i);
 
-		if (!sched_core_cookie_match(rq, p))
+		if (!sched_core_cookie_match(NULL, rq, p))
 			continue;
 
 		if (sched_idle_cpu(i))
@@ -7681,7 +7681,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	 * Don't migrate task if the task's cookie does not match
 	 * with the destination CPU's core cookie.
 	 */
-	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+	if (!(sched_core_cookie_match(env->src_rq, env->dst_rq, p)))
 		return 1;
 
 	if (sysctl_sched_migration_cost == 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d852c67..ee0e558 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1195,6 +1195,56 @@ struct sched_core_cookie {
 };
 
 /*
+ * When tasks with the same cookie can make pairs on SMT siblings, forceidle can be
+ * avoided a lot, so when wake up and load balance, we try to make and keep the pairs
+ * with the same cookie on SMT siblings.
+ */
+static inline bool
+sched_core_make_pair_balance(struct rq *src_rq, struct rq *dst_rq, struct task_struct *p)
+{
+	struct sched_core_cookie *ck = (struct sched_core_cookie *)p->core_cookie;
+	unsigned int src_cpu, dst_cpu, t;
+	unsigned int src_nr_running, dst_nr_running;
+
+	if (!ck)
+		return true;
+
+	/*
+	 * When load balance, if ck->nr_running on src_cpu is less than that on SMT
+	 * siblings, don't migrate the task.
+	 */
+	if (src_rq) {
+		if (!sched_core_enabled(src_rq))
+			return true;
+		src_cpu = cpu_of(src_rq);
+		src_nr_running = *per_cpu_ptr(ck->nr_running, src_cpu);
+		for_each_cpu(t, cpu_smt_mask(src_cpu)) {
+			if (t == src_cpu)
+				continue;
+			if (*per_cpu_ptr(ck->nr_running, t) >= src_nr_running)
+				return false;
+		}
+
+	}
+
+	/*
+	 * If task p can make pair the cookied task with p->core_cookie on the
+	 * dst core, we can wake up task p on dst_rq, or migrate it to dst_rq.
+	 */
+	dst_cpu = cpu_of(dst_rq);
+	dst_nr_running = *per_cpu_ptr(ck->nr_running, dst_cpu);
+	for_each_cpu(t, cpu_smt_mask(dst_cpu)) {
+		if (t == dst_cpu)
+			continue;
+		if (*per_cpu_ptr(ck->nr_running, t) <= dst_nr_running)
+			return false;
+	}
+
+	return true;
+}
+
+
+/*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
  * when core scheduling is enabled.
  * A special case is that the task's cookie always matches with CPU's core
@@ -1206,19 +1256,21 @@ static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
 	if (!sched_core_enabled(rq))
 		return true;
 
-	return rq->core->core_cookie == p->core_cookie;
+	return rq->core->core_cookie == p->core_cookie ||
+		sched_core_make_pair_balance(NULL, rq, p);
 }
 
-static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+static inline bool
+sched_core_cookie_match(struct rq *src_rq, struct rq *dst_rq, struct task_struct *p)
 {
 	bool idle_core = true;
 	int cpu;
 
 	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
-	if (!sched_core_enabled(rq))
+	if (!sched_core_enabled(dst_rq))
 		return true;
 
-	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
+	for_each_cpu(cpu, cpu_smt_mask(cpu_of(dst_rq))) {
 		if (!available_idle_cpu(cpu)) {
 			idle_core = false;
 			break;
@@ -1229,7 +1281,8 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie == p->core_cookie;
+	return idle_core || dst_rq->core->core_cookie == p->core_cookie ||
+		sched_core_make_pair_balance(src_rq, dst_rq, p);
 }
 
 static inline bool sched_group_cookie_match(struct rq *rq,
@@ -1243,7 +1296,7 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 		return true;
 
 	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
-		if (sched_core_cookie_match(rq, p))
+		if (sched_core_cookie_match(NULL, rq, p))
 			return true;
 	}
 	return false;
-- 
1.8.3.1

