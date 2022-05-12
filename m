Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F0524514
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349342AbiELFi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiELFix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:38:53 -0400
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CE21687C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:38:44 -0700 (PDT)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id GAY00136;
        Thu, 12 May 2022 13:38:36 +0800
Received: from localhost.localdomain (172.16.34.28) by GCY-MBS-28.TCL.com
 (10.136.3.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 12 May
 2022 13:38:36 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@kernel.org>
CC:     <tang.ding@tcl.com>, <wu-yan@tcl.com>
Subject: [PATCH] sched/core: fix the order of update sched_reset_on_fork and policy
Date:   Thu, 12 May 2022 13:38:16 +0800
Message-ID: <20220512053816.27687-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.34.28]
X-ClientProxiedBy: GCY-EXS-09.TCL.com (10.74.128.159) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   202251213383689c2c2f6db613b8e7646a1c0d3f54138
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When child process is forked during updating scheduler policy of parent
process, there is a small time window that child copy inconsistent
policy parameters from the parent, which cause unexpected high priority
to unprivileged child. This may cause unexpected behavior of child
process(even hog the cpu and hang the system in some scenario).

Resource manager(privileged)               App task(unprivileged)
sched_setscheduler(p,
 policy=SCHED_FIFO|SCHED_RESET_ON_FORK)
                                             p->policy is SCHED_FIFO
...                                          p->sched_reset_on_fork is 1
                                           ...
                                           clone
sched_setscheduler(p,policy=SCHED_NORMAL)   -kernel_clone
 -_sched_setscheduler                        -copy_process
  -__sched_setscheduler                       -dup_task_struct
   set p->sched_reset_on_fork to 0             copy p's task struct we get
   ...                                           policy = SCHED_FIFO
                                                 sched_reset_on_fork = 0
   set p->policy = SCHED_NORMAL                this leak FIFO priority to
                                               to child task.

Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
Cc: Tang Ding <tang.ding@tcl.com>
---
 kernel/fork.c       | 28 +++++++++++++++++++++++++++-
 kernel/sched/core.c | 20 +++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f1e89007f228..90f3c3f59316 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -871,12 +871,19 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 	*stackend = STACK_END_MAGIC;	/* for overflow detection */
 }
 
+static inline bool has_rt_dl_policy(struct task_struct *tsk)
+{
+	int policy = tsk->policy;
+	return policy == SCHED_FIFO || policy == SCHED_RR ||
+		policy == SCHED_DEADLINE;
+}
+
 static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
 	struct task_struct *tsk;
 	unsigned long *stack;
 	struct vm_struct *stack_vm_area __maybe_unused;
-	int err;
+	int err, reset_on_fork;
 
 	if (node == NUMA_NO_NODE)
 		node = tsk_fork_get_node(orig);
@@ -893,7 +900,26 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 	stack_vm_area = task_stack_vm_area(tsk);
 
+	reset_on_fork = orig->sched_reset_on_fork;
+	/*
+	 * Match the barrier before 'sched_reset_on_fork = 0' in __sched_setscheduler,
+	 * this guarantees that if we see 'sched_reset_on_fork = 0' we must also see
+	 * 'policy = SCHED_NORMAL' when the child is forked during updating parent to
+	 * noraml class by sched_setscheduler(SCHED_NORMAL)
+	 */
+	smp_rmb();
 	err = arch_dup_task_struct(tsk, orig);
+	tsk->sched_reset_on_fork = reset_on_fork;
+	if (!reset_on_fork && has_rt_dl_policy(tsk)) {
+	        /*
+		 * Match the barrier after 'sched_reset_on_fork = 1' in __sched_setscheduler,
+		 * this guarantees that if we see 'policy=SCHED_FIFO' we must also see
+		 * 'sched_reset_on_fork = 1' when the child is forked during updating parent
+		 * to rt class by sched_setscheduler(SCHED_FIFO|SCHED_RESET_ON_FORK)
+		 */
+		smp_rmb();
+		tsk->sched_reset_on_fork = orig->sched_reset_on_fork;
+	}
 
 	/*
 	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1eec4925b8c6..8d12f29fd888 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7447,7 +7447,6 @@ static int __sched_setscheduler(struct task_struct *p,
 		goto unlock;
 	}
 
-	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
 	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
@@ -7472,6 +7471,15 @@ static int __sched_setscheduler(struct task_struct *p,
 		put_prev_task(rq, p);
 
 	prev_class = p->sched_class;
+	if (reset_on_fork && !p->sched_reset_on_fork) {
+		p->sched_reset_on_fork = 1;
+		/*
+		 * Make sure sched_reset_on_fork(1) visible before updating sched policy
+		 * to avoid rt/deadline priority leak to unprivileged child process if
+		 * it is forked during sched policy change of parent process.
+		 */
+		smp_wmb();
+	}
 
 	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
 		__setscheduler_params(p, attr);
@@ -7479,6 +7487,16 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 	__setscheduler_uclamp(p, attr);
 
+	if (!reset_on_fork && p->sched_reset_on_fork) {
+		/*
+		 * Make sure p's sched policy visible before reset sched_reset_on_fork(0)
+		 * to avoid rt/deadline priority leak to unprivileged child process if
+		 * it is forked during sched policy change of parent process.
+		 */
+		smp_wmb();
+		p->sched_reset_on_fork = 0;
+	}
+
 	if (queued) {
 		/*
 		 * We enqueue to tail when the priority of a task is
-- 
2.25.1

