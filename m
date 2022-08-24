Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8759F494
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiHXHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiHXHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:54:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE383F11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:53:58 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCJGS4rS3zGpnX;
        Wed, 24 Aug 2022 15:52:16 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 15:53:50 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 15:53:49 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH v2 -next] sched: Add update_current_exec_runtime helper
Date:   Wed, 24 Aug 2022 16:28:56 +0800
Message-ID: <20220824082856.15674-1-shangxiaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Wrap repeated code in helper function update_current_exec_runtime for
update the exec time of the current.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
changes in v2:
- remove the redundant invocation of rq_clock_task() in
put_prev_task_stop()
---
 kernel/sched/deadline.c  |  6 +-----
 kernel/sched/rt.c        |  6 +-----
 kernel/sched/sched.h     | 10 ++++++++++
 kernel/sched/stop_task.c | 11 ++++-------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index daa9a7fb5917..d116d2b9d2f9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1333,11 +1333,7 @@ static void update_curr_dl(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 
 	if (dl_entity_is_special(dl_se))
 		return;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index cd07c9367bc2..27e694cf3e37 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1062,11 +1062,7 @@ static void update_curr_rt(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 
 	if (!rt_bandwidth_enabled())
 		return;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ddcfc7837595..7ad65f79cb59 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3163,4 +3163,14 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+static inline void update_current_exec_runtime(struct task_struct *curr,
+						u64 now, u64 delta_exec)
+{
+	curr->se.sum_exec_runtime += delta_exec;
+	account_group_exec_runtime(curr, delta_exec);
+
+	curr->se.exec_start = now;
+	cgroup_account_cputime(curr, delta_exec);
+}
+
 #endif /* _KERNEL_SCHED_SCHED_H */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index d04073a93eb4..85590599b4d6 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -71,20 +71,17 @@ static void yield_task_stop(struct rq *rq)
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
 	struct task_struct *curr = rq->curr;
-	u64 delta_exec;
+	u64 now, delta_exec;
 
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
+	now = rq_clock_task(rq);
+	delta_exec = now - curr->se.exec_start;
 	if (unlikely((s64)delta_exec < 0))
 		delta_exec = 0;
 
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = rq_clock_task(rq);
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec);
 }
 
 /*
-- 
2.17.1

