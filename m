Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD0259DEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358307AbiHWLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357507AbiHWLfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:35:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93033C6FCA;
        Tue, 23 Aug 2022 02:27:34 -0700 (PDT)
Date:   Tue, 23 Aug 2022 09:27:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661246852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyzG3mvyM6Gd6hVw30kZRtU1uzuuX6J/DlDIkwhgKaA=;
        b=cK43PRmwtVlAjsz8WPg13QwW0AnVJei88dFb5W3tfqA2Jo6jeS/CUAO++gv5EXkcZ/7Ohg
        z3IlBKc1M1/v6nB++WmHCQb21a6Ok9ZZrnOkcGr1fdIu+8asE+1lBDopFFPR6NINuuNOkq
        BGJsB98EnqZXPWYlATOlTFlygKzcPpbu36Cs717J35S9Vz8VRf1DsVDOaC6zXZ5ds+8fGS
        25Guzk/wwF0mxReGJO1I20uFBoolAxFLiJCvOCUepXu/Okar26kZIdQx3iS6lkxn+8ejH5
        wkVrJ90zeR+6F7jISqClUUEhYtaFsyxeJJH5Qvz+Pbe0nNTnvdV4HiHCk1/XzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661246852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyzG3mvyM6Gd6hVw30kZRtU1uzuuX6J/DlDIkwhgKaA=;
        b=mmtvnGxNbiewSFBAwW4Rf6GWovRXU8JBbossi6NiKKlgPT6+FLflLZC9La2f5F4EtmpyJi
        ayQmeXo90XUE6mCQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Allow changing cgroup of new forked task
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220818124805.601-8-zhouchengming@bytedance.com>
References: <20220818124805.601-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166124685097.401.5171298774176649405.tip-bot2@tip-bot2>
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

Commit-ID:     df16b71c686cb096774e30153c9ce6756450796c
Gitweb:        https://git.kernel.org/tip/df16b71c686cb096774e30153c9ce6756450796c
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Thu, 18 Aug 2022 20:48:03 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Aug 2022 11:01:19 +02:00

sched/fair: Allow changing cgroup of new forked task

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20220818124805.601-8-zhouchengming@bytedance.com
---
 kernel/sched/core.c | 25 +++++--------------------
 kernel/sched/fair.c |  7 +++++++
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e74e79f..603a80e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10238,36 +10238,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -11103,7 +11086,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
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
index e92bc05..fd1aa4c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11676,6 +11676,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_change_group_fair(struct task_struct *p)
 {
+	/*
+	 * We couldn't detach or attach a forked task which
+	 * hasn't been woken up by wake_up_new_task().
+	 */
+	if (READ_ONCE(p->__state) == TASK_NEW)
+		return;
+
 	detach_task_cfs_rq(p);
 
 #ifdef CONFIG_SMP
