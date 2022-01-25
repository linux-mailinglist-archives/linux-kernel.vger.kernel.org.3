Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3903149B79F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349573AbiAYP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbiAYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8EEC06173D;
        Tue, 25 Jan 2022 07:27:04 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtVdugESSAgwLZkgGw6B4IbpoYwN4O1FoYFGCZKHn08=;
        b=BRFDQIGu6F0Y1Y7UvLHxSKLIVioNHnsHpN+tv1qGvIfSfPWfTDoxJ7qtygnNOkhoTtLrcw
        1+pbiF9+RO8vTdWYhR6hRY5O87xMSwBQ57K9TPHfur4Xp0eGyNGQXhzcCp12Zvnxq013Sq
        DUUn0Kl/F7HJj5bw9tx6rkDQCbNftU5dtBdPWBIYDxTC5LVn7mhkhcZ3WDSTBLoNnjIQx5
        tsKDi2PU3M48yKl1RE2erUYO9tIDRlRvZJ+XAs2I+TB7h6s7s74g0Q6yZ/PTS+IVZQvzV0
        h2W29xc1J364zYvMk410rQwoSBOg2p6MF91sIDJPArmSJBCJMcFV/EV6Jx3mqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtVdugESSAgwLZkgGw6B4IbpoYwN4O1FoYFGCZKHn08=;
        b=P54Yamdt4wFUM05Xa4Y6fzqJ5s5kccBP4hY+WXTH5pAEXIhbSTIZUhf6w2ngqpvH+PH3eC
        HWpWqMiXcgSFkkCA==
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/8] kernel/fork: Move task stack account to do_exit().
Date:   Tue, 25 Jan 2022 16:26:50 +0100
Message-Id: <20220125152652.1963111-7-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to perform the stack accounting of the outgoing task in
its final schedule() invocation which happens with disabled preemption.
The task is leaving, the resources will be freed and the accounting can
happen in do_exit() before the actual schedule invocation which
frees the stack memory.

Move the accounting of the stack memory from release_task_stack() to
exit_task_stack_account() which then can be invoked from do_exit().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched/task_stack.h |  2 ++
 kernel/exit.c                    |  1 +
 kernel/fork.c                    | 35 +++++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_st=
ack.h
index d10150587d819..892562ebbd3aa 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -79,6 +79,8 @@ static inline void *try_get_task_stack(struct task_struct=
 *tsk)
 static inline void put_task_stack(struct task_struct *tsk) {}
 #endif
=20
+void exit_task_stack_account(struct task_struct *tsk);
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) !=3D STACK_END_MAGIC)
=20
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25bb4ab93..c303cffe7fdb4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -845,6 +845,7 @@ void __noreturn do_exit(long code)
 		put_page(tsk->task_frag.page);
=20
 	validate_creds_for_do_exit(tsk);
+	exit_task_stack_account(tsk);
=20
 	check_stack_usage();
 	preempt_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index 73f644482e932..5f4e659a922e1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,9 +211,8 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
+static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
 	int i;
 	int ret;
=20
@@ -239,6 +238,7 @@ static int memcg_charge_kernel_stack(struct task_struct=
 *tsk)
=20
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
+	struct vm_struct *vm;
 	void *stack;
 	int i;
=20
@@ -256,7 +256,7 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
=20
-		if (memcg_charge_kernel_stack(tsk)) {
+		if (memcg_charge_kernel_stack(s)) {
 			vfree(s->addr);
 			return -ENOMEM;
 		}
@@ -279,7 +279,8 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
 	if (!stack)
 		return -ENOMEM;
=20
-	if (memcg_charge_kernel_stack(tsk)) {
+	vm =3D find_vm_area(stack);
+	if (memcg_charge_kernel_stack(vm)) {
 		vfree(stack);
 		return -ENOMEM;
 	}
@@ -288,19 +289,15 @@ static int alloc_thread_stack_node(struct task_struct=
 *tsk, int node)
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	tsk->stack_vm_area =3D find_vm_area(stack);
+	tsk->stack_vm_area =3D vm;
 	tsk->stack =3D stack;
 	return 0;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
 	int i;
=20
-	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-		memcg_kmem_uncharge_page(vm->pages[i], 0);
-
 	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
 		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
 				     tsk->stack_vm_area) !=3D NULL)
@@ -453,12 +450,25 @@ static void account_kernel_stack(struct task_struct *=
tsk, int account)
 	}
 }
=20
+void exit_task_stack_account(struct task_struct *tsk)
+{
+	account_kernel_stack(tsk, -1);
+
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm;
+		int i;
+
+		vm =3D task_stack_vm_area(tsk);
+		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_uncharge_page(vm->pages[i], 0);
+	}
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) !=3D TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
=20
-	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
 }
=20
@@ -917,6 +927,7 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
+	account_kernel_stack(tsk, 1);
=20
 	err =3D scs_prepare(tsk, node);
 	if (err)
@@ -960,8 +971,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	tsk->wake_q.next =3D NULL;
 	tsk->worker_private =3D NULL;
=20
-	account_kernel_stack(tsk, 1);
-
 	kcov_task_init(tsk);
 	kmap_local_fork(tsk);
=20
@@ -980,6 +989,7 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	return tsk;
=20
 free_stack:
+	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
 free_tsk:
 	free_task_struct(tsk);
@@ -2448,6 +2458,7 @@ static __latent_entropy struct task_struct *copy_proc=
ess(
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);
+	exit_task_stack_account(p);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
--=20
2.34.1

