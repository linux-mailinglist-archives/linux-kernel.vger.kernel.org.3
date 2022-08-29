Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996DA5A4616
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiH2Jal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiH2Jai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:30:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89F25280
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:30:37 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGQ6Y3n18zYcxY;
        Mon, 29 Aug 2022 17:26:13 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 17:30:35 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 17:30:34 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH] sched/deadline: Add should_push_task_away helper
Date:   Mon, 29 Aug 2022 18:05:33 +0800
Message-ID: <20220829100533.19153-1-shangxiaojing@huawei.com>
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

Wrap complex and repeated code in helper function should_push_task_away,
which will return true when task b should be pushed to other cores
because of task a.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/sched/deadline.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index daa9a7fb5917..8e14dc21d829 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1814,6 +1814,15 @@ static void yield_task_dl(struct rq *rq)
 
 #ifdef CONFIG_SMP
 
+static inline bool should_push_task_away(struct task_struct *a,
+					  struct task_struct *b)
+{
+	return unlikely(dl_task(a)) &&
+	       (a->nr_cpus_allowed < 2 ||
+		!dl_entity_preempt(&b->dl, &a->dl)) &&
+	       b->nr_cpus_allowed > 1;
+}
+
 static int find_later_rq(struct task_struct *task);
 
 static int
@@ -1840,10 +1849,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
-		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
-		    p->nr_cpus_allowed > 1;
+	select_rq = should_push_task_away(curr, p);
 
 	/*
 	 * Take the capacity of the CPU into account to
@@ -2477,10 +2483,7 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
 	if (!task_running(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
-	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
-	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	    should_push_task_away(rq->curr, p)) {
 		push_dl_tasks(rq);
 	}
 }
-- 
2.17.1

