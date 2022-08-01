Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E65586384
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiHAE2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbiHAE2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EB2DFBD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q22so1235214plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFH8NHGJSUxhHtDtnk+1UL0mZ/w91LaurRijcSElzyc=;
        b=Ha82v9KNGhCiFujRAf0gBjJg8QepWcRRBMiEJ0OWomqfxXW7Uu7JIaHfkhH7v1xyJb
         0BimZu2020tux6gYkxv8xAzCWLA5PlFd1MSC1W7X6xkJZKaWvNwn1IPS0UOUWARrOWJp
         9ApMIdatqLjpyxQtV6bpwR+umQ7hwy6iYqmCrunhgGi+tVA7lcGabFWWw+WLc8gkSBW/
         kMp73uxtzB8EspQwoON/ZsSFdclmGJyctw4l/yZ1iW0aijEgEjLJXvumGVxVA+1FEw8m
         iN3iUTeDYCYZ4gSWOkzJ8eo0kBD+uBpYy4hzDURn1BnlriCzun8h3GTJ1nkEQz7xHtlZ
         PYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFH8NHGJSUxhHtDtnk+1UL0mZ/w91LaurRijcSElzyc=;
        b=PZDkxZdWYzg3mNMvz6fY2q2UOU9Ag++A9Sothi11f94WgXwxOGO5OQjizbcHa9K6U5
         jbORuvQiqu6t6m0/TQnGWiUIr17xF0g7yEwXYKli3ClnEr1WD/hv+bs510Gdjjfe2kVl
         KLjAPQY2MC0A+C+IIAtOmW77/JfSyFHznQy0esTxoN5uf5AQWQlfqZTPDhYn2CJJtS+T
         u2GCJpp92LNsWDoJTOh6Agvlu6fIPP+KxTs96FZmKwWnPPTUKJQoWF5jgaK/+cdnYxMb
         2hghxRIz8BHaWnmdK+dRcDiB2xX7XJtI1YIGVMJMd/IBr5l03ONYieS17ovFUptaQxZr
         BjnQ==
X-Gm-Message-State: ACgBeo1OfRt9lS5aI9IWzeE6AvWH3yFXGavaYg2uXyNxbOcOSZmaoKrr
        rp5ZvQq1agPJG5XITwbb848+bw==
X-Google-Smtp-Source: AA6agR4PdlbV0N3lzrlOFesTrwTTeKDgxIxFuz10fcTjT/8h7hJ099PHU6qVgKJQxMVh5hFizv/diA==
X-Received: by 2002:a17:902:e750:b0:16c:761:6e96 with SMTP id p16-20020a170902e75000b0016c07616e96mr14716714plf.0.1659328089424;
        Sun, 31 Jul 2022 21:28:09 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 02/10] sched/fair: remove redundant cpu_cgrp_subsys->fork()
Date:   Mon,  1 Aug 2022 12:27:37 +0800
Message-Id: <20220801042745.7794-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801042745.7794-1-zhouchengming@bytedance.com>
References: <20220801042745.7794-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5555e49c4e12..614d7180c99e 100644
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
@@ -10125,7 +10124,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static void sched_change_group(struct task_struct *tsk, int type)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -10141,7 +10140,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
-		tsk->sched_class->task_change_group(tsk, type);
+		tsk->sched_class->task_change_group(tsk);
 	else
 #endif
 		set_task_rq(tsk, task_cpu(tsk));
@@ -10172,7 +10171,7 @@ void sched_move_task(struct task_struct *tsk)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, TASK_MOVE_GROUP);
+	sched_change_group(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10250,23 +10249,6 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -11132,7 +11114,6 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-	.fork		= cpu_cgroup_fork,
 	.can_attach	= cpu_cgroup_can_attach,
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77cd2bad17a8..89626b115660 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11661,15 +11661,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
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
@@ -11681,19 +11673,6 @@ static void task_move_group_fair(struct task_struct *p)
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

