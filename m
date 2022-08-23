Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069759DCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358456AbiHWLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357886AbiHWLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:36:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02169910A8;
        Tue, 23 Aug 2022 02:27:38 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZtTtlT3Ek/uhaDXZRzX2YYiBkkyi0eObGUW5WssUak=;
        b=EL8AwDik2Z8YQTjls+4PjCIyLUrauWHi5D5jPiijPyTmlUrT12wy8ZZRjvvmdibfhFgP65
        /an8m5vdHTMc6AP8MEQbU4SP83BtLZa60YNTpnnWPGreJ1hdZZt/8mTeYj11fsTupPWqHU
        zofDha3UVezb3/ytu7qKQ18mqlM7D9b65bQ2MURgYaGm4+fKsyO+xJHHZpCXSJq8MHN2Q0
        UlwThh3m1uKUA1PHiwYw22zHTjN8eGcmMTz05ESARQTPGrtVGtZmGATeYTOZyc2CKcP/5b
        g+457C1EH4e3tXJ2XMG1TUfGQtF5Hokv1CMqwKx3oiefnELSdRd8lrBq8+jyJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZtTtlT3Ek/uhaDXZRzX2YYiBkkyi0eObGUW5WssUak=;
        b=ey58db+XBW5cHO493UGnXTZZzCHIvIIkA/05da1wtXhXZcVby5PnMYvweNarQx3Jhw3liW
        SNyHCp1AyBXdN1Bg==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove redundant cpu_cgrp_subsys->fork()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-3-zhouchengming@bytedance.com>
References: <20220818124805.601-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685590.401.15944614410686814398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     39c4261191bf05e7eb310f852980a6d0afe5582a
Gitweb:        https://git.kernel.org/tip/39c4261191bf05e7eb310f852980a6d0afe5582a
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:47:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:17 +02:00

sched/fair: Remove redundant cpu_cgrp_subsys->fork()

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20220818124805.601-3-zhouchengming@bytedance.com
---
 kernel/sched/core.c  | 27 ++++-----------------------
 kernel/sched/fair.c  | 23 +----------------------
 kernel/sched/sched.h |  5 +----
 3 files changed, 6 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 64c0899..e74e79f 100644
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
@@ -10114,7 +10113,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk, int type)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10130,7 +10129,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
-		tsk->sched_class->task_change_group(tsk, type);
+		tsk->sched_class->task_change_group(tsk);
 	else
 #endif
 		set_task_rq(tsk, task_cpu(tsk));
@@ -10161,7 +10160,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, TASK_MOVE_GROUP);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10239,23 +10238,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -11121,7 +11103,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-	.fork		= cpu_cgroup_fork,
 	.can_attach	= cpu_cgroup_can_attach,
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a3b0f8b..2c0eb2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11657,15 +11657,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -11677,19 +11669,6 @@ static void task_move_group_fair(struct task_struct *p)
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
index 4c48221..74130a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,11 +2193,8 @@ struct sched_class {
 
 	void (*update_curr)(struct rq *rq);
 
-#define TASK_SET_GROUP		0
-#define TASK_MOVE_GROUP		1
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
-	void (*task_change_group)(struct task_struct *p, int type);
+	void (*task_change_group)(struct task_struct *p);
 #endif
 };
 
