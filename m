Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968134BC79A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiBSKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:15:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiBSKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:14:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01B197239;
        Sat, 19 Feb 2022 02:14:40 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645265678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6cpSbpb3HNg5OpcQztYBFwfVmZOjGqlCPweghhXxvs=;
        b=hIYsuivXynaf9KpcC6Yv8Wt5GguG+7szHmuFUaDRwDvtHvOLMxLBx+0N/vadkoS3C0azjp
        GJTaVI7IVnz0X5nenzr6pujpNYx86KZAVp6K2rzbpvXQojxNqf/77OChQgdsMGX+6MbySB
        Dc1sGd1/amZGXqXlzKzgKiNRRoct6O9Dltfqx23jvaPoHl97DqcpM9hOaKH15BLyGQI1c8
        OMvD7AQrlWbTUR2eSdgXOi8ernAbJp0qX5E7pTXSfLLVV210s5M5DJT84LKeDZ3sFD82cR
        9Jlv+xhVRVGEP8DA3nKzNnWa2pdwUKUkgmQecTt4vQhrthtwWg57DrQ++iGznQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645265678;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6cpSbpb3HNg5OpcQztYBFwfVmZOjGqlCPweghhXxvs=;
        b=5SmZ5B+H5vAxzW8gUvklEfMjKAxoXwc+bqPGrjFOXwoy6mKlmalEafux9Qc+GD3TX6ccLr
        yRy9Y64XduiKLOCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix yet more sched_fork() races
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
References: <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164526567729.16921.5416435160262961553.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b1e8206582f9d680cff7d04828708c8b6ab32957
Gitweb:        https://git.kernel.org/tip/b1e8206582f9d680cff7d04828708c8b6ab32957
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Feb 2022 10:16:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:05 +01:00

sched: Fix yet more sched_fork() races

Where commit 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an
invalid sched_task_group") fixed a fork race vs cgroup, it opened up a
race vs syscalls by not placing the task on the runqueue before it
gets exposed through the pidhash.

Commit 13765de8148f ("sched/fair: Fix fault in reweight_entity") is
trying to fix a single instance of this, instead fix the whole class
of issues, effectively reverting this commit.

Fixes: 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an invalid sched_task_group")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net
---
 include/linux/sched/task.h |  4 ++--
 kernel/fork.c              | 13 ++++++++++++-
 kernel/sched/core.c        | 34 +++++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index b9198a1..e84e54d 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -54,8 +54,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_post_fork(struct task_struct *p,
-			    struct kernel_clone_args *kargs);
+extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528..c607d23 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2267,6 +2267,17 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_put_pidfd;
 
 	/*
+	 * Now that the cgroups are pinned, re-clone the parent cgroup and put
+	 * the new task on the correct runqueue. All this *before* the task
+	 * becomes visible.
+	 *
+	 * This isn't part of ->can_fork() because while the re-cloning is
+	 * cgroup specific, it unconditionally needs to place the task on a
+	 * runqueue.
+	 */
+	sched_cgroup_fork(p, args);
+
+	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
 	 * not want user-space to be able to predict the process start-time by
@@ -2376,7 +2387,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
-	sched_post_fork(p, args);
+	sched_post_fork(p);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcf0c18..9745613 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1214,9 +1214,8 @@ int tg_nop(struct task_group *tg, void *data)
 }
 #endif
 
-static void set_load_weight(struct task_struct *p)
+static void set_load_weight(struct task_struct *p, bool update_load)
 {
-	bool update_load = !(READ_ONCE(p->__state) & TASK_NEW);
 	int prio = p->static_prio - MAX_RT_PRIO;
 	struct load_weight *load = &p->se.load;
 
@@ -4407,7 +4406,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 			p->static_prio = NICE_TO_PRIO(0);
 
 		p->prio = p->normal_prio = p->static_prio;
-		set_load_weight(p);
+		set_load_weight(p, false);
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -4425,6 +4424,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 	init_entity_runnable_average(&p->se);
 
+
 #ifdef CONFIG_SCHED_INFO
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
@@ -4440,18 +4440,23 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
-#ifdef CONFIG_CGROUP_SCHED
-	struct task_group *tg;
-#endif
 
+	/*
+	 * Because we're not yet on the pid-hash, p->pi_lock isn't strictly
+	 * required yet, but lockdep gets upset if rules are violated.
+	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 #ifdef CONFIG_CGROUP_SCHED
-	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
-			  struct task_group, css);
-	p->sched_task_group = autogroup_task_group(p, tg);
+	if (1) {
+		struct task_group *tg;
+		tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
+				  struct task_group, css);
+		tg = autogroup_task_group(p, tg);
+		p->sched_task_group = tg;
+	}
 #endif
 	rseq_migrate(p);
 	/*
@@ -4462,7 +4467,10 @@ void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+}
 
+void sched_post_fork(struct task_struct *p)
+{
 	uclamp_post_fork(p);
 }
 
@@ -6922,7 +6930,7 @@ void set_user_nice(struct task_struct *p, long nice)
 		put_prev_task(rq, p);
 
 	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p);
+	set_load_weight(p, true);
 	old_prio = p->prio;
 	p->prio = effective_prio(p);
 
@@ -7213,7 +7221,7 @@ static void __setscheduler_params(struct task_struct *p,
 	 */
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
-	set_load_weight(p);
+	set_load_weight(p, true);
 }
 
 /*
@@ -9446,7 +9454,7 @@ void __init sched_init(void)
 #endif
 	}
 
-	set_load_weight(&init_task);
+	set_load_weight(&init_task, false);
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
