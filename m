Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB7597C57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiHRDpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiHRDpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:45:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A969411C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pm17so515090pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cq9WBgnay6MlRUXX21E7/GvZMXn3RD4DJtZwNfGfMLY=;
        b=fTH5AQyb70fbfjzlPmrKwqpWI2SN6Od0VKvQz6oIZ7Fg+Y3Ts8vMIYQ4VzD+NctwzY
         wFtEdbFJXZdB21cu+PUhjUGJHE00nc06JqyfJO2QY8LH1iuTmTZNls53hj+s8uOWSe6J
         zShxU+lDP1bDlf5Yvmq02EBGYehI0YNkQIuVebBAeiJu0QGP5bz0JrDa3fNNDpCHHQ1T
         W4HKzDeZdjN5wGPk85t6j6ikaKoFCV6CAXmWaJhTaVGZeKZnz7yMYPEyQ6/hBPB3v7VC
         1HP9eIqDDKH+soDgezn+mhlwNttM00itCfF6LfVeJzuIf8ag0FhYvFeom1cA3XOL7Thj
         skvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cq9WBgnay6MlRUXX21E7/GvZMXn3RD4DJtZwNfGfMLY=;
        b=N8Aw+AblhwzI/C0kby7mbEamVG+f2mdBAsXqFJrzdaGcdNyQfyTc89+LZZovQT9vEf
         8GB3TjUyl5zab147rl66/g6RnHE5sbo04V3042PYs+ej9p7jTe+SSPKmBCHjGE0yVfTg
         42uSMhAIQsOFWRWOJIiyXylihENVPnBMna3mxa9mfipyAVBW3mJB2sLUozm0M5Agtp6f
         jYOfOidZF9OTxSEa3I2E3fPM8ObCoYMAHF9xEnjFb0ypF6EqZopYDsEnyiGdeAg5PNa1
         6emqj8xGgR9dLEJEyCFYrNRXZjksNA6kolcSqTf65MvF8NTs29mjubtwPJH02HJCGwez
         Vqpg==
X-Gm-Message-State: ACgBeo38KANKPquAzYfTkY66Vg/S7vSFkTLKdxrMJv4a4XDsvtbkSSU6
        hCD/t4RF4vJpJBSXqqUGgm3qKA==
X-Google-Smtp-Source: AA6agR78ZlGtoG4klkFQJzLwLDgdqVBEL6qnJTx9iF7Txr5I02iW14OUuhDG4Ztfzmc0rZ/hI98XLA==
X-Received: by 2002:a17:90b:1b45:b0:1f5:753d:82bc with SMTP id nv5-20020a17090b1b4500b001f5753d82bcmr6778457pjb.68.1660794348305;
        Wed, 17 Aug 2022 20:45:48 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:45:48 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 2/9] sched/fair: remove redundant cpu_cgrp_subsys->fork()
Date:   Thu, 18 Aug 2022 11:43:36 +0800
Message-Id: <20220818034343.87625-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818034343.87625-1-zhouchengming@bytedance.com>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
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

We use cpu_cgrp_subsys->fork() to set task group for the new fair task
in cgroup_post_fork().

Since commit b1e8206582f9 ("sched: Fix yet more sched_fork() races")
has already set_task_rq() for the new fair task in sched_cgroup_fork(),
so cpu_cgrp_subsys->fork() can be removed.

  cgroup_can_fork()	--> pin parent's sched_task_group
  sched_cgroup_fork()
    __set_task_cpu()
      set_task_rq()
  cgroup_post_fork()
    ss->fork() := cpu_cgroup_fork()
      sched_change_group(..., TASK_SET_GROUP)
        task_set_group_fair()
          set_task_rq()  --> can be removed

After this patch's change, task_change_group_fair() only need to
care about task cgroup migration, make the code much simplier.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  | 27 ++++-----------------------
 kernel/sched/fair.c  | 23 +----------------------
 kernel/sched/sched.h |  5 +----
 3 files changed, 6 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 863b5203e357..8e3f1c3f0b2c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -481,8 +481,7 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
  *				p->se.load, p->rt_priority,
  *				p->dl.dl_{runtime, deadline, period, flags, bw, density}
  *  - sched_setnuma():		p->numa_preferred_nid
- *  - sched_move_task()/
- *    cpu_cgroup_fork():	p->sched_task_group
+ *  - sched_move_task():	p->sched_task_group
  *  - uclamp_update_active()	p->uclamp*
  *
  * p->state <- TASK_*:
@@ -10166,7 +10165,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk, int type)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10182,7 +10181,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
-		tsk->sched_class->task_change_group(tsk, type);
+		tsk->sched_class->task_change_group(tsk);
 	else
 #endif
 		set_task_rq(tsk, task_cpu(tsk));
@@ -10213,7 +10212,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, TASK_MOVE_GROUP);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10291,23 +10290,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-/*
- * This is called before wake_up_new_task(), therefore we really only
- * have to set its group bits, all the other stuff does not apply.
- */
-static void cpu_cgroup_fork(struct task_struct *task)
-{
-	struct rq_flags rf;
-	struct rq *rq;
-
-	rq = task_rq_lock(task, &rf);
-
-	update_rq_clock(rq);
-	sched_change_group(task, TASK_SET_GROUP);
-
-	task_rq_unlock(rq, task, &rf);
-}
-
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
@@ -11173,7 +11155,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-	.fork		= cpu_cgroup_fork,
 	.can_attach	= cpu_cgroup_can_attach,
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c5ee08b187ec..4b95599aa951 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11821,15 +11821,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static void task_set_group_fair(struct task_struct *p)
-{
-	struct sched_entity *se = &p->se;
-
-	set_task_rq(p, task_cpu(p));
-	se->depth = se->parent ? se->parent->depth + 1 : 0;
-}
-
-static void task_move_group_fair(struct task_struct *p)
+static void task_change_group_fair(struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
 	set_task_rq(p, task_cpu(p));
@@ -11841,19 +11833,6 @@ static void task_move_group_fair(struct task_struct *p)
 	attach_task_cfs_rq(p);
 }
 
-static void task_change_group_fair(struct task_struct *p, int type)
-{
-	switch (type) {
-	case TASK_SET_GROUP:
-		task_set_group_fair(p);
-		break;
-
-	case TASK_MOVE_GROUP:
-		task_move_group_fair(p);
-		break;
-	}
-}
-
 void free_fair_sched_group(struct task_group *tg)
 {
 	int i;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 628ffa974123..2db7b0494c19 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2195,11 +2195,8 @@ struct sched_class {
 
 	void (*update_curr)(struct rq *rq);
 
-#define TASK_SET_GROUP		0
-#define TASK_MOVE_GROUP		1
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	void (*task_change_group)(struct task_struct *p, int type);
+	void (*task_change_group)(struct task_struct *p);
 #endif
 };
 
-- 
2.37.2

