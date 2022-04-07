Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85094F781A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiDGHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiDGHte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:49:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB301B60AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:47:32 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYthQ4WdzzFpWm;
        Thu,  7 Apr 2022 15:45:10 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 15:47:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <mcgrof@kernel.org>, <nizhen@uniontech.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] sched: Fix build warning without CONFIG_SYSCTL
Date:   Thu, 7 Apr 2022 15:47:01 +0800
Message-ID: <20220407074701.35040-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IF CONFIG_SYSCTL is n, build warn:

kernel/sched/core.c:1782:12: warning: ‘sysctl_sched_uclamp_handler’ defined but not used [-Wunused-function]
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~

sysctl_sched_uclamp_handler() is used while CONFIG_SYSCTL enabled,
wrap all related code with CONFIG_SYSCTL to fix this.

Fixes: ef2637285297 ("sched: Move uclamp_util sysctls to core.c")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/sched/core.c | 65 +++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d50d4ddc7ddc..3f862a455402 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1306,10 +1306,10 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 static DEFINE_MUTEX(uclamp_mutex);
 
 /* Max allowed minimum utilization */
-static unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
+static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
 /* Max allowed maximum utilization */
-static unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+static unsigned int __maybe_unused sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
 /*
  * By default RT tasks run at the maximum performance point/capacity of the
@@ -1456,33 +1456,6 @@ static void uclamp_update_util_min_rt_default(struct task_struct *p)
 	task_rq_unlock(rq, p, &rf);
 }
 
-static void uclamp_sync_util_min_rt_default(void)
-{
-	struct task_struct *g, *p;
-
-	/*
-	 * copy_process()			sysctl_uclamp
-	 *					  uclamp_min_rt = X;
-	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
-	 *   // link thread			  smp_mb__after_spinlock()
-	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
-	 *   sched_post_fork()			  for_each_process_thread()
-	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
-	 *
-	 * Ensures that either sched_post_fork() will observe the new
-	 * uclamp_min_rt or for_each_process_thread() will observe the new
-	 * task.
-	 */
-	read_lock(&tasklist_lock);
-	smp_mb__after_spinlock();
-	read_unlock(&tasklist_lock);
-
-	rcu_read_lock();
-	for_each_process_thread(g, p)
-		uclamp_update_util_min_rt_default(p);
-	rcu_read_unlock();
-}
-
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
@@ -1762,6 +1735,11 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css)
 }
 
 static void cpu_util_update_eff(struct cgroup_subsys_state *css);
+#endif
+
+#ifdef CONFIG_SYSCTL
+#ifdef CONFIG_UCLAMP_TASK
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 static void uclamp_update_root_tg(void)
 {
 	struct task_group *tg = &root_task_group;
@@ -1779,6 +1757,33 @@ static void uclamp_update_root_tg(void)
 static void uclamp_update_root_tg(void) { }
 #endif
 
+static void uclamp_sync_util_min_rt_default(void)
+{
+	struct task_struct *g, *p;
+
+	/*
+	 * copy_process()			sysctl_uclamp
+	 *					  uclamp_min_rt = X;
+	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
+	 *   // link thread			  smp_mb__after_spinlock()
+	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
+	 *   sched_post_fork()			  for_each_process_thread()
+	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
+	 *
+	 * Ensures that either sched_post_fork() will observe the new
+	 * uclamp_min_rt or for_each_process_thread() will observe the new
+	 * task.
+	 */
+	read_lock(&tasklist_lock);
+	smp_mb__after_spinlock();
+	read_unlock(&tasklist_lock);
+
+	rcu_read_lock();
+	for_each_process_thread(g, p)
+		uclamp_update_util_min_rt_default(p);
+	rcu_read_unlock();
+}
+
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1843,6 +1848,8 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 
 	return result;
 }
+#endif
+#endif
 
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
-- 
2.17.1

