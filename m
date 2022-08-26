Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C65A1EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbiHZCkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiHZCkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:40:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB41AF00
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 19:40:19 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDPCb4gFMzGprV;
        Fri, 26 Aug 2022 10:38:35 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 10:40:17 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 10:40:16 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] sched/deadline: Add start_new_instance helper
Date:   Fri, 26 Aug 2022 11:15:21 +0800
Message-ID: <20220826031521.13391-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Wrap repeated code in helper function start_new_instance, which set
the deadline and runtiem of input dl_se based on pi_of(dl_se). Note that
setup_new_dl_entity originally set the deadline and runtime base on
dl_se, which should equals to pi_of(dl_se) for non-boosted task.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/sched/deadline.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4a40a462717c..5e9c28847610 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -770,6 +770,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
+static inline void start_new_instance(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	/* for non-boosted task, pi_of(dl_se) == dl_se */
+	dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+	dl_se->runtime = pi_of(dl_se)->dl_runtime;
+}
+
 /*
  * We are being explicitly informed that a new instance is starting,
  * and this means that:
@@ -803,8 +810,7 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
 	 * future; in fact, we must consider execution overheads (time
 	 * spent on hardirq context, etc.).
 	 */
-	dl_se->deadline = rq_clock(rq) + dl_se->dl_deadline;
-	dl_se->runtime = dl_se->dl_runtime;
+	start_new_instance(dl_se, rq);
 }
 
 /*
@@ -836,10 +842,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
 	 */
-	if (dl_se->dl_deadline == 0) {
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
-	}
+	if (dl_se->dl_deadline == 0)
+		start_new_instance(dl_se, rq);
 
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
 		dl_se->runtime = 0;
@@ -866,8 +870,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		start_new_instance(dl_se, rq);
 	}
 
 	if (dl_se->dl_yielded)
@@ -1024,8 +1027,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 			return;
 		}
 
-		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
-		dl_se->runtime = pi_of(dl_se)->dl_runtime;
+		start_new_instance(dl_se, rq);
 	}
 }
 
-- 
2.17.1

