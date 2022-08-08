Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658258C8DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbiHHM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243140AbiHHM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F878DFB9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so9005636pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D5Ubi901LSb9xg/ubdyA4P0B6D+gtiJzEao+2OesIo=;
        b=ZjR+K8xsIpNJkGEHNI1F+ySJi1fpgkEaCl0za2cj85NZenw4Mkrz+z7Dz75w93YCRV
         bkXNOeCviCz2EtgRqfJ/X3BWNONjj8++r93EMV7PUkHuk1v5q0kPVpCvb6GcJfM03aXj
         4ChSoxzSTkiVQl+SKmcTspWnzKwoGnjYI1hgJzgBKe9hjIRHvzGEzuJjAXlnRInSpLJO
         m67sbESXy2kIZM05rj8iMUD9KkzqavyDVa7j2ksXSdLAxykqiubMEXuVDRKnvMdaanif
         vGGIpnGkMCgkZ1VDgBg7bP9C3WDq0Zt4kUskKmbXrq4+OOZ3NfoW+wvQ1arze66B0hwC
         OngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D5Ubi901LSb9xg/ubdyA4P0B6D+gtiJzEao+2OesIo=;
        b=0Zq5Hlg+gd04N0f0EWP/LT7q75Lf3+So/hIuXgRd6R6MCaEPB+AbQ3m206HXHvN2hS
         8EEVyOpJFrxoHU2ddpz0ZY8ptwqoISSPKrYE6f7/LLri3K1gOQZX2SeEwN2UNxvokVMC
         DGWXdlSGdF+G6zgAvc+/3OjTSRlA2oDC1w8TlAHzOKOBzN2FgeLUdZpe9uRBtrkJEkdL
         VN6MaDSl5kfY8f0LFBRoOAsUZDdUYOcvxt5DBIQJ2CtUWRwoIDTRAPSpv+OrQl3KUR5j
         jsQuLGHZEdhi2AD9HJAnYGbijANC2In5b/5oAKjRFBcA1vZcPHIhfmMWfwXKCj780SVA
         Nktg==
X-Gm-Message-State: ACgBeo0wTaIFSvsq3pOTYTFj8OUc1qHuJBG6ntflh1dE8y3tk0ylEkwN
        2/mheed21NrupFpCP5AB4EIIUA==
X-Google-Smtp-Source: AA6agR59GPV81s2b1VdiIXZhe890vekntkfm0xMPRkOUwDqV7TT4yzuDhRBDVjd9z8jWynX56PfYkw==
X-Received: by 2002:a17:902:cecc:b0:170:9353:f295 with SMTP id d12-20020a170902cecc00b001709353f295mr8828665plg.63.1659963512313;
        Mon, 08 Aug 2022 05:58:32 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:31 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 7/9] sched/fair: allow changing cgroup of new forked task
Date:   Mon,  8 Aug 2022 20:57:43 +0800
Message-Id: <20220808125745.22566-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808125745.22566-1-zhouchengming@bytedance.com>
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
introduce a TASK_NEW state and an unnessary limitation that would fail
when changing cgroup of new forked task.

Because at that time, we can't handle task_change_group_fair() for new
forked fair task which hasn't been woken up by wake_up_new_task(),
which will cause detach on an unattached task sched_avg problem.

This patch delete this unnessary limitation by adding check before do
detach or attach in task_change_group_fair().

So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
only define it in #ifdef CONFIG_RT_GROUP_SCHED.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/sched.h |  5 ++---
 kernel/sched/core.c   | 30 +++++++-----------------------
 kernel/sched/fair.c   |  7 +++++++
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 88b8817b827d..b504e55bbf7a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,10 +95,9 @@ struct task_group;
 #define TASK_WAKEKILL			0x0100
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
-#define TASK_NEW			0x0800
 /* RT specific auxilliary flag to mark RT lock waiters */
-#define TASK_RTLOCK_WAIT		0x1000
-#define TASK_STATE_MAX			0x2000
+#define TASK_RTLOCK_WAIT		0x0800
+#define TASK_STATE_MAX			0x1000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e74e79f783af..d5faa1700bd7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4500,11 +4500,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	__sched_fork(clone_flags, p);
 	/*
-	 * We mark the process as NEW here. This guarantees that
+	 * We mark the process as running here. This guarantees that
 	 * nobody will actually run it, and a signal or other external
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
-	p->__state = TASK_NEW;
+	p->__state = TASK_RUNNING;
 
 	/*
 	 * Make sure we do not leak PI boosting priority to the child.
@@ -4622,7 +4622,6 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	WRITE_ONCE(p->__state, TASK_RUNNING);
 #ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
@@ -10238,36 +10237,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
-	int ret = 0;
 
 	cgroup_taskset_for_each(task, css, tset) {
-#ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
-#endif
-		/*
-		 * Serialize against wake_up_new_task() such that if it's
-		 * running, we're sure to observe its full state.
-		 */
-		raw_spin_lock_irq(&task->pi_lock);
-		/*
-		 * Avoid calling sched_move_task() before wake_up_new_task()
-		 * has happened. This would lead to problems with PELT, due to
-		 * move wanting to detach+attach while we're not attached yet.
-		 */
-		if (READ_ONCE(task->__state) == TASK_NEW)
-			ret = -EINVAL;
-		raw_spin_unlock_irq(&task->pi_lock);
-
-		if (ret)
-			break;
 	}
-	return ret;
+	return 0;
 }
+#endif
 
 static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 {
@@ -11103,7 +11085,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
+#ifdef CONFIG_RT_GROUP_SCHED
 	.can_attach	= cpu_cgroup_can_attach,
+#endif
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
 	.dfl_cftypes	= cpu_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4bc76d95a99d..90aba33a3780 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11669,6 +11669,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_change_group_fair(struct task_struct *p)
 {
+	/*
+	 * We couldn't detach or attach a forked task which
+	 * hasn't been woken up by wake_up_new_task().
+	 */
+	if (!p->on_rq && !se->sum_exec_runtime)
+		return;
+
 	detach_task_cfs_rq(p);
 
 #ifdef CONFIG_SMP
-- 
2.36.1

