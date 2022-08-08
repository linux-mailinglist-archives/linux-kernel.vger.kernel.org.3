Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84558C8D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiHHM6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242678AbiHHM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A8A19E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj1so8748138pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8Jsl+ToANeHS+DRaMdUI/qyZ4cu1x0qwQ9xAfLBcwQ=;
        b=KZTZNnESDtHHURS/uGOMOjrwiDmLzshlTSEGMGU3qR8+0yU7J9TlkvjHghBtcW18EJ
         k2jeiBBPsii66rc73GPea/Dute6I6eow0l2gela1dtnRTq0379wOKrHt+eV7qqmOHzDm
         uBwveyFJJVRK1XJSBUDUoHOprcCZZx6s+wD6rAHirxgHBXpq0oP4oloVEzrFOQVFrqFA
         BG2g1W1Pd7kqZQz7SckBYIa6c/T/5MFIZyUXk2AQeqScWO92bXfA2V3Wj7wStjpOPRah
         18VANXsyooZBSTYkyxUU453CQm8KNA+HEmAJeW41PQ+Hr7pQHWuu+EAH4DxJI20GF5AF
         H0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8Jsl+ToANeHS+DRaMdUI/qyZ4cu1x0qwQ9xAfLBcwQ=;
        b=zH/X9NQg5LgUI5DkZG4kyGVBOl1fpgBPpucZEQnh1dTV9sNpkM69anOLkarw6MW/lB
         7FAfEGJz5rt6it0eE7n0N87lCOT9XeUpfbn70ju5rO5O+xvV1NY+DiVcxt7ebcmnbtIF
         /VOxJjS36fmaBXvrESkh3CifZ0J4ziTyNkbBGtxx5x/YWeUOVGNUOWQL+zUQXZDjTovB
         IgVa6rvFI57w17rZrQpS4SOj86+siJNaFPinj78C0Wl2U5ExbA6o5MCCPG3r9S8Qu5xU
         CSWZi0k5Juv+HRwqdyUE2L/7fAcZl9MdZE9lJX3qarv9X3pOScYah3a0f1fxPBciu7Nb
         sbpQ==
X-Gm-Message-State: ACgBeo1mWt16I3MqJKZ8rcpC+UofuAZy6BjqGfdVMS925QEXB96CcDkI
        bl8VRsC2m98DtKDTeK04ORKH7Q==
X-Google-Smtp-Source: AA6agR7vNTsvKHWcuX7VugFejUBbHh3fJvDJhU+D1bX0xP+AZVI26CMm73YagTBX2QsFkVJDlOwSGA==
X-Received: by 2002:a17:90b:4c07:b0:1f5:40a:8040 with SMTP id na7-20020a17090b4c0700b001f5040a8040mr28716474pjb.121.1659963488880;
        Mon, 08 Aug 2022 05:58:08 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:58:08 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 2/9] sched/fair: remove redundant cpu_cgrp_subsys->fork()
Date:   Mon,  8 Aug 2022 20:57:38 +0800
Message-Id: <20220808125745.22566-3-zhouchengming@bytedance.com>
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
index 64c08993221b..e74e79f783af 100644
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
index a3b0f8b1029e..2c0eb2a4e341 100644
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
index 4c4822141026..74130a69d365 100644
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
 
-- 
2.36.1

