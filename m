Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86A4C03CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiBVV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiBVV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765E87B55B;
        Tue, 22 Feb 2022 13:27:01 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TLEJCCLKrshPMeXgTvHmbuI9C8JCXQeV5MGfT+J0ig=;
        b=l8Ngv5AZfh18Fu3cZq8Q5R2FSfY6BYzUFFlDS4ok7Vj1lNMd3IYKeNbg04KB4IEXxbfeBO
        w/6Zh0dgUJGj7eFY4SG+1oHSGxf7PlRBjmYHBH6/uihPuejsXK54MSaimQUmj/fK7NqzhO
        T8ot1LJFhhA4jBY+ABNQOnhRk5MCn7YYSOIoLtXnntxCx3mxS3XAmxKSRMGnCGAZCCIOTs
        wjR5TgcG3wII/81slswKhObTXOefeot319s47EMMtHxJ53b2faK1zOcJRLAxkPOeLkdcgT
        SIgqy7rLFoiMkl7MVqHXwKo/emW18f6ze8HvxggiBeqbFn40fENXr7Ct0usKgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TLEJCCLKrshPMeXgTvHmbuI9C8JCXQeV5MGfT+J0ig=;
        b=ZQ8kdwfKuqCbO5A6uddWfAiqCUBM2HO8QjhaD9daoKjpO1wsMCpgWiRRxYbhWhgxilvL1/
        MF7i6OPYJgKC7HDA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Move task stack accounting to do_exit()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-7-bigeasy@linutronix.de>
References: <20220217102406.3697941-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556521911.16921.1452756504269092176.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/core branch of tip:

Commit-ID:     1a03d3f13ffe5dd24142d6db629e72c11b704d99
Gitweb:        https://git.kernel.org/tip/1a03d3f13ffe5dd24142d6db629e72c11b704d99
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:02 +01:00

fork: Move task stack accounting to do_exit()

There is no need to perform the stack accounting of the outgoing task in
its final schedule() invocation which happens with preemption disabled.
The task is leaving, the resources will be freed and the accounting can
happen in do_exit() before the actual schedule invocation which
frees the stack memory.

Move the accounting of the stack memory from release_task_stack() to
exit_task_stack_account() which then can be invoked from do_exit().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-7-bigeasy@linutronix.de

---
 include/linux/sched/task_stack.h |  2 ++-
 kernel/exit.c                    |  1 +-
 kernel/fork.c                    | 35 ++++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index d101505..892562e 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -79,6 +79,8 @@ static inline void *try_get_task_stack(struct task_struct *tsk)
 static inline void put_task_stack(struct task_struct *tsk) {}
 #endif
 
+void exit_task_stack_account(struct task_struct *tsk);
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) != STACK_END_MAGIC)
 
diff --git a/kernel/exit.c b/kernel/exit.c
index b00a25b..c303cff 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -845,6 +845,7 @@ void __noreturn do_exit(long code)
 		put_page(tsk->task_frag.page);
 
 	validate_creds_for_do_exit(tsk);
+	exit_task_stack_account(tsk);
 
 	check_stack_usage();
 	preempt_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index ac63e7f..2582812 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,9 +211,8 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
 
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
+static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
-	struct vm_struct *vm = task_stack_vm_area(tsk);
 	int i;
 	int ret;
 
@@ -239,6 +238,7 @@ err:
 
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
+	struct vm_struct *vm;
 	void *stack;
 	int i;
 
@@ -256,7 +256,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
-		if (memcg_charge_kernel_stack(tsk)) {
+		if (memcg_charge_kernel_stack(s)) {
 			vfree(s->addr);
 			return -ENOMEM;
 		}
@@ -279,7 +279,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	if (!stack)
 		return -ENOMEM;
 
-	if (memcg_charge_kernel_stack(tsk)) {
+	vm = find_vm_area(stack);
+	if (memcg_charge_kernel_stack(vm)) {
 		vfree(stack);
 		return -ENOMEM;
 	}
@@ -288,19 +289,15 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	tsk->stack_vm_area = find_vm_area(stack);
+	tsk->stack_vm_area = vm;
 	tsk->stack = stack;
 	return 0;
 }
 
 static void free_thread_stack(struct task_struct *tsk)
 {
-	struct vm_struct *vm = task_stack_vm_area(tsk);
 	int i;
 
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-		memcg_kmem_uncharge_page(vm->pages[i], 0);
-
 	for (i = 0; i < NR_CACHED_STACKS; i++) {
 		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
 				     tsk->stack_vm_area) != NULL)
@@ -454,12 +451,25 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	}
 }
 
+void exit_task_stack_account(struct task_struct *tsk)
+{
+	account_kernel_stack(tsk, -1);
+
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm;
+		int i;
+
+		vm = task_stack_vm_area(tsk);
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_uncharge_page(vm->pages[i], 0);
+	}
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) != TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
 
-	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
 }
 
@@ -918,6 +928,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
+	account_kernel_stack(tsk, 1);
 
 	err = scs_prepare(tsk, node);
 	if (err)
@@ -961,8 +972,6 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;
 
-	account_kernel_stack(tsk, 1);
-
 	kcov_task_init(tsk);
 	kmap_local_fork(tsk);
 
@@ -981,6 +990,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	return tsk;
 
 free_stack:
+	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
 free_tsk:
 	free_task_struct(tsk);
@@ -2459,6 +2469,7 @@ bad_fork_cleanup_count:
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);
+	exit_task_stack_account(p);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
