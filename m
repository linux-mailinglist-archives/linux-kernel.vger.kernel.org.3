Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C35A76E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiHaGtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaGtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:49:31 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776EA1D57
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:49:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VNq13Hu_1661928558;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VNq13Hu_1661928558)
          by smtp.aliyun-inc.com;
          Wed, 31 Aug 2022 14:49:26 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Fix the bug that sched_core_find() may return throttled task
Date:   Wed, 31 Aug 2022 14:49:18 +0800
Message-Id: <1661928558-108473-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs_rq is throttled, the cookie'd task in this cfs_rq wouldn't
dequeue from the core tree, and sched_core_find() may return this task,
which will result that the throttled task running on the cpu.

To resolve this problem, we pick the first cookie matched task and
unthrottled task.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c  | 6 ++++++
 kernel/sched/fair.c  | 7 +++++++
 kernel/sched/sched.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b604223..a34acd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -271,6 +271,12 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	struct rb_node *node;
 
 	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
+	while (node && task_throttled(__node_2_sc(node))) {
+		node = rb_next(node);
+		if (node && cookie != __node_2_sc(node)->core_cookie)
+			node = NULL;
+	}
+
 	/*
 	 * The idle task always matches any cookie!
 	 */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf3300b..4878a25 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11563,6 +11563,13 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 
 	return delta > 0;
 }
+
+inline int task_throttled(struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
+
+	return cfs_rq_throttled(cfs_rq);
+}
 #else
 static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f616e0c..c6e3955 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1285,6 +1285,7 @@ static inline bool sched_core_enqueued(struct task_struct *p)
 
 extern void sched_core_get(void);
 extern void sched_core_put(void);
+extern int task_throttled(struct task_struct *p);
 
 #else /* !CONFIG_SCHED_CORE */
 
-- 
1.8.3.1

