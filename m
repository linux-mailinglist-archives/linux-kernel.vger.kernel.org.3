Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405A15A2281
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiHZH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiHZH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:59:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D9B7E8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:59:52 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDXJJ3g7WzGpj0;
        Fri, 26 Aug 2022 15:58:08 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:59:50 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:59:49 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next v2] sched/deadline: Add dl_task_is_earliest_deadline helper
Date:   Fri, 26 Aug 2022 16:34:53 +0800
Message-ID: <20220826083453.698-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Wrap repeated code in helper function dl_task_is_earliest_deadline, which
return true if there is no deadline task on the rq at all, or task's
deadline earlier than the whole rq.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- pick a more descriptive function name rather than compare_task_rq.
---
 kernel/sched/deadline.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d116d2b9d2f9..34271aff4712 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1810,6 +1810,14 @@ static void yield_task_dl(struct rq *rq)
 
 #ifdef CONFIG_SMP
 
+static inline bool dl_task_is_earliest_deadline(struct task_struct *p,
+						 struct rq *rq)
+{
+	return (!rq->dl.dl_nr_running ||
+		dl_time_before(p->dl.deadline,
+			       rq->dl.earliest_dl.curr));
+}
+
 static int find_later_rq(struct task_struct *task);
 
 static int
@@ -1852,9 +1860,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 		int target = find_later_rq(p);
 
 		if (target != -1 &&
-				(dl_time_before(p->dl.deadline,
-					cpu_rq(target)->dl.earliest_dl.curr) ||
-				(cpu_rq(target)->dl.dl_nr_running == 0)))
+		    dl_task_is_earliest_deadline(p, cpu_rq(target)))
 			cpu = target;
 	}
 	rcu_read_unlock();
@@ -2221,9 +2227,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 
 		later_rq = cpu_rq(cpu);
 
-		if (later_rq->dl.dl_nr_running &&
-		    !dl_time_before(task->dl.deadline,
-					later_rq->dl.earliest_dl.curr)) {
+		if (!dl_task_is_earliest_deadline(task, later_rq)) {
 			/*
 			 * Target rq has tasks of equal or earlier deadline,
 			 * retrying does not release any lock and is unlikely
@@ -2251,9 +2255,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		 * its earliest one has a later deadline than our
 		 * task, the rq is a good one.
 		 */
-		if (!later_rq->dl.dl_nr_running ||
-		    dl_time_before(task->dl.deadline,
-				   later_rq->dl.earliest_dl.curr))
+		if (dl_task_is_earliest_deadline(task, later_rq))
 			break;
 
 		/* Otherwise we try again. */
@@ -2424,9 +2426,7 @@ static void pull_dl_task(struct rq *this_rq)
 		 *  - it will preempt the last one we pulled (if any).
 		 */
 		if (p && dl_time_before(p->dl.deadline, dmin) &&
-		    (!this_rq->dl.dl_nr_running ||
-		     dl_time_before(p->dl.deadline,
-				    this_rq->dl.earliest_dl.curr))) {
+		    dl_task_is_earliest_deadline(p, this_rq)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));
 
-- 
2.17.1

