Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC31F55CF55
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbiF1H5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiF1H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:57:37 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23F1C924
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:57:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VHgOW1N_1656403053;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VHgOW1N_1656403053)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 15:57:34 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sched/core: Introduce nr_running percpu for each cookie
Date:   Tue, 28 Jun 2022 15:57:24 +0800
Message-Id: <1656403045-100840-3-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a percpu count to struct sched_core_cookie, which indicates how
many tasks with this cookie in the runqueue of this cpu.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c       |  7 +++++++
 kernel/sched/core_sched.c | 16 ++++++++--------
 kernel/sched/sched.h      |  9 +++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 263d764..9f71042 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -235,21 +235,28 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 
 void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
+	struct sched_core_cookie *ck = (struct sched_core_cookie *)p->core_cookie;
+
 	rq->core->core_task_seq++;
 
 	if (!p->core_cookie)
 		return;
 
 	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
+
+	*per_cpu_ptr(ck->nr_running, rq->cpu) += 1;
 }
 
 void sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags)
 {
+	struct sched_core_cookie *ck = (struct sched_core_cookie *)p->core_cookie;
+
 	rq->core->core_task_seq++;
 
 	if (sched_core_enqueued(p)) {
 		rb_erase(&p->core_node, &rq->core_tree);
 		RB_CLEAR_NODE(&p->core_node);
+		*per_cpu_ptr(ck->nr_running, rq->cpu) -= 1;
 	}
 
 	/*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index ba2466c..65ab9fcb 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,20 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-/*
- * A simple wrapper around refcount. An allocated sched_core_cookie's
- * address is used to compute the cookie of the task.
- */
-struct sched_core_cookie {
-	refcount_t refcnt;
-};
-
 static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
+	int cpu;
+
 	if (!ck)
 		return 0;
 
 	refcount_set(&ck->refcnt, 1);
+
+	ck->nr_running = alloc_percpu(unsigned int);
+	for_each_possible_cpu(cpu)
+		*per_cpu_ptr(ck->nr_running, cpu) = 0;
+
 	sched_core_get();
 
 	return (unsigned long)ck;
@@ -25,6 +24,7 @@ static void sched_core_put_cookie(unsigned long cookie)
 	struct sched_core_cookie *ptr = (void *)cookie;
 
 	if (ptr && refcount_dec_and_test(&ptr->refcnt)) {
+		free_percpu(ptr->nr_running);
 		kfree(ptr);
 		sched_core_put();
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b14b6b..d852c67 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1186,6 +1186,15 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 /*
+ * A simple wrapper around refcount. An allocated sched_core_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_cookie {
+	refcount_t refcnt;
+	unsigned int __percpu *nr_running;
+};
+
+/*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
  * when core scheduling is enabled.
  * A special case is that the task's cookie always matches with CPU's core
-- 
1.8.3.1

