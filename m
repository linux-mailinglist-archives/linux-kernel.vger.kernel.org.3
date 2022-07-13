Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73D572C21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiGMEFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiGMEFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4DD9E12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso1551709pjk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKSij/GPDZ57EEFoNz665mJfxzgkXH1+vUXpr6VSwJY=;
        b=eneGubHa8PFlN1YCxnRt4gMiCQ5+/JgysKIrq0XJ+MU8ihz2dFyMxsDqEd7UqpjRZt
         YsmWgpn30tg3DEnwwZlLKcjE/VXB1BdwdAQoxICJoFAnsK7OUp2wELYtBvz+67BhxeTr
         ZUz7nflcxfK5UIIK0WCaMP2E7umizdGDfGL/V3JYrx+LO7Aggtcppw7FxIiIgmF9DSAC
         RxTcdqKaKWE8IzZXiwcE/Qjlb1Ak0qrhLVQwuUhjEAPi5883TLux1924LSiwcbtgfnk9
         9PASUKfzclWT3oVJzcfZSNCE2xVg8QXWuTFnM5+IWIxjMLsK8Y26CBztAsrFbKJn1oBv
         IEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKSij/GPDZ57EEFoNz665mJfxzgkXH1+vUXpr6VSwJY=;
        b=V7EmpYZNm5yEevLeYleeBylAOhnp8sJ26tVpAdOe/mf8D6eVoM0p5nvvux2DbYkTpR
         oMCLK0mAxFsygTCTYZ+EsRZe/YdxCUyyftZ1ybPyx+3IbPb12DK5imoZrAB8qX6VSfnH
         SJztBSaCtZ7AmyNSzmVOrq/nS+pUFAaWu4h27Wj7WayGNZsLfXmkYceGYOF7WJZCx7Nh
         8V6h5kig0zfOO8Ghh1VVVoBavbdE3bcv1FIc8N2pQlMZy+/bxoPIJX900iiTj/BYd8Vk
         FJv5bcvw8yxKYy0A00jV80hVJiH17oi7vuUNlJoutuTBbDvNj2g9Ik4yNEAJwq02pSrx
         sRVA==
X-Gm-Message-State: AJIora+TuJfpuNG2TyALkZywr5JKydRUk1U+eNdtieByS70wXm9LMxwD
        JwJvgFW0UEGg1nnYpY7fvGZG+w==
X-Google-Smtp-Source: AGRyM1veB8kwM9MVOHrQSU3lLBJ2yvWET9eeVimsKVpQvM8La0HV6pC6WXGeA42WVuKgxLazBvO+tw==
X-Received: by 2002:a17:90b:3d04:b0:1f0:693f:69c8 with SMTP id pt4-20020a17090b3d0400b001f0693f69c8mr1650960pjb.188.1657685102273;
        Tue, 12 Jul 2022 21:05:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 04/10] sched/fair: remove redundant cpu_cgrp_subsys->fork()
Date:   Wed, 13 Jul 2022 12:04:24 +0800
Message-Id: <20220713040430.25778-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
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
has already set task group for the new fair task in sched_cgroup_fork(),
so cpu_cgrp_subsys->fork() can be removed.

  cgroup_can_fork()	--> pin parent's sched_task_group
  sched_cgroup_fork()
    __set_task_cpu	--> set task group
  cgroup_post_fork()
    ss->fork() := cpu_cgroup_fork()	--> set again

After this patch's change, task_change_group_fair() only need to
care about task cgroup migration, make the code much simplier.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 27 ++++-----------------------
 kernel/sched/fair.c  | 23 +----------------------
 kernel/sched/sched.h |  5 +----
 3 files changed, 6 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c215b5adc707..d85fdea51e3a 100644
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
@@ -10127,7 +10126,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk, int type)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10143,7 +10142,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
-		tsk->sched_class->task_change_group(tsk, type);
+		tsk->sched_class->task_change_group(tsk);
 	else
 #endif
 		set_task_rq(tsk, task_cpu(tsk));
@@ -10174,7 +10173,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, TASK_MOVE_GROUP);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10252,23 +10251,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -11134,7 +11116,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-	.fork		= cpu_cgroup_fork,
 	.can_attach	= cpu_cgroup_can_attach,
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bf595b622656..8992ce5e73d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11634,15 +11634,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -11654,19 +11646,6 @@ static void task_move_group_fair(struct task_struct *p)
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
index 8cc3eb7b86cd..19e0076e4245 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2203,11 +2203,8 @@ struct sched_class {
 
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

