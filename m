Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1C59F38B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHXGS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiHXGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:18:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C340972850
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:18:23 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCG632LpCzkWd6;
        Wed, 24 Aug 2022 14:14:51 +0800 (CST)
Received: from kwepemm600008.china.huawei.com (7.193.23.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 14:18:18 +0800
Received: from huawei.com (10.175.100.227) by kwepemm600008.china.huawei.com
 (7.193.23.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 14:18:17 +0800
From:   Shang XiaoJing <shangxiaojing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <shangxiaojing@huawei.com>
Subject: [PATCH -next] sched: Add update_current_exec_runtime helper
Date:   Wed, 24 Aug 2022 14:53:26 +0800
Message-ID: <20220824065326.10583-1-shangxiaojing@huawei.com>
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

Wrap repeated code in helper function update_current_exec_runtime for
update the exec time of the current.

Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
---
 kernel/sched/deadline.c  |  6 +-----
 kernel/sched/rt.c        |  6 +-----
 kernel/sched/sched.h     | 10 ++++++++++
 kernel/sched/stop_task.c |  6 +-----
 4 files changed, 13 insertions(+), 15 deletions(-)

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
index d04073a93eb4..027068779126 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -80,11 +80,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = rq_clock_task(rq);
-	cgroup_account_cputime(curr, delta_exec);
+	update_current_exec_runtime(curr, rq_clock_task(rq), delta_exec);
 }
 
 /*
-- 
2.17.1

