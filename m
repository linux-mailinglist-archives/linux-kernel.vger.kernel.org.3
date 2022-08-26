Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5925A243D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343826AbiHZJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiHZJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:25:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F47C2E93
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:25:35 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDZ951wDWzkWjV;
        Fri, 26 Aug 2022 17:22:01 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 17:25:34 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 17:25:32 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next v2] sched/deadline: Add replenish_dl_new_period helper
Date:   Fri, 26 Aug 2022 18:00:37 +0800
Message-ID: <20220826100037.12146-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600008.china.huawei.com (7.193.23.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap repeated code in helper function replenish_dl_new_period, which set
the deadline and runtime of input dl_se based on pi_of(dl_se). Note that
setup_new_dl_entity originally set the deadline and runtime base on
dl_se, which should equals to pi_of(dl_se) for non-boosted task.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- fix comment msg
- pick a more descriptive function name rather than start_new_instance.
---
 kernel/sched/deadline.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 34271aff4712..3bf4b12ec5b7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -770,6 +770,14 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
+static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
+					    struct rq *rq)
+{
+	/* for non-boosted task, pi_of(dl_se) == dl_se */
+	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+}
+
 /*
  * We are being explicitly informed that a new instance is starting,
  * and this means that:
@@ -803,8 +811,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	 * future; in fact, we must consider execution overheads (time
 	 * spent on hardirq context, etc.).
 	 */
-	dl_se->deadline = rq_clock(rq) + dl_se->dl_deadline;
-	dl_se->runtime = dl_se->dl_runtime;
+	replenish_dl_new_period(dl_se, rq);
 }
 
 /*
@@ -836,10 +843,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
 	 */
-	if (dl_se->dl_deadline == 0) {
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
-	}
+	if (dl_se->dl_deadline == 0)
+		replenish_dl_new_period(dl_se, rq);
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -866,8 +871,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		replenish_dl_new_period(dl_se, rq);
 	}
 
 	if (dl_se->dl_yielded)
@@ -1024,8 +1028,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 			return;
 		}
 
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		replenish_dl_new_period(dl_se, rq);
 	}
 }
 
-- 
2.17.1

