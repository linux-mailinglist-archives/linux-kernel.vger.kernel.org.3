Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F04C03CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiBVV1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiBVV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B657B550;
        Tue, 22 Feb 2022 13:27:00 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:26:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hnS8yXfEREgwfivWd8IfE/vOMfid7XfmJhvieSSweM=;
        b=3iWQbzaRtH3Tq001IafeFx7BwVm/D9LfO/bCWjRPk6hIHX7Y9SJIKaYSflchRAWnmDFVh8
        kNXWZInbH5KY8kP7DOaCpTwlr11kqPToaYIwA9JnNMP2ywKBRuZGEFrK8KJRAsOSZvQRhX
        LbVhD2Dn4lxGhDjgljJTAe4kSHI1FfiamHQs5biCL6eq1J52kBAHyuNlAvpfpHx02OxpAe
        H+B7+jmzc2bhrWCnH5d7ydVwxhJWWn9b1b51+XU/IxtvYCTO1c5PRgZpjqnyrN5F5ZqmPb
        faV8Cz348s+6PHW1gnTZwNyYU1XreHD3fLCRHYoFOsX0Rzq4ZiH6k/Eq/uErvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hnS8yXfEREgwfivWd8IfE/vOMfid7XfmJhvieSSweM=;
        b=cFuU6nDrI6sFv0Cv3CZ9/VLDbiETQJQUJ2Q0lm8cN+22EuFc3AR3/3jhDXRvpDh/cUaWbH
        udR5i+IiMGEPksDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Only cache the VMAP stack in finish_task_switch()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-8-bigeasy@linutronix.de>
References: <20220217102406.3697941-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556521837.16921.8430861751279136153.tip-bot2@tip-bot2>
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

Commit-ID:     e540bf3162e822d7a1f07e69e3bb1b4f925ca368
Gitweb:        https://git.kernel.org/tip/e540bf3162e822d7a1f07e69e3bb1b4f925ca368
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:02 +01:00

fork: Only cache the VMAP stack in finish_task_switch()

The task stack could be deallocated later, but for fork()/exec() kind of
workloads (say a shell script executing several commands) it is important
that the stack is released in finish_task_switch() so that in VMAP_STACK
case it can be cached and reused in the new task.

For PREEMPT_RT it would be good if the wake-up in vfree_atomic() could
be avoided in the scheduling path. Far worse are the other
free_thread_stack() implementations which invoke __free_pages()/
kmem_cache_free() with disabled preemption.

Cache the stack in free_thread_stack() in the VMAP_STACK case and
RCU-delay the free path otherwise. Free the stack in the RCU callback.
In the VMAP_STACK case this is another opportunity to fill the cache.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-8-bigeasy@linutronix.de

---
 kernel/fork.c | 76 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 2582812..177bc64 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -193,6 +193,41 @@ static inline void free_task_struct(struct task_struct *tsk)
 #define NR_CACHED_STACKS 2
 static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
 
+struct vm_stack {
+	struct rcu_head rcu;
+	struct vm_struct *stack_vm_area;
+};
+
+static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) != NULL)
+			continue;
+		return true;
+	}
+	return false;
+}
+
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
+
+	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
+		return;
+
+	vfree(vm_stack);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct vm_stack *vm_stack = tsk->stack;
+
+	vm_stack->stack_vm_area = tsk->stack_vm_area;
+	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+}
+
 static int free_vm_stack_cache(unsigned int cpu)
 {
 	struct vm_struct **cached_vm_stacks = per_cpu_ptr(cached_stacks, cpu);
@@ -296,24 +331,27 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 static void free_thread_stack(struct task_struct *tsk)
 {
-	int i;
+	if (!try_release_thread_stack_to_cache(tsk->stack_vm_area))
+		thread_stack_delayed_free(tsk);
 
-	for (i = 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
-				     tsk->stack_vm_area) != NULL)
-			continue;
-
-		tsk->stack = NULL;
-		tsk->stack_vm_area = NULL;
-		return;
-	}
-	vfree_atomic(tsk->stack);
 	tsk->stack = NULL;
 	tsk->stack_vm_area = NULL;
 }
 
 #  else /* !CONFIG_VMAP_STACK */
 
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh = tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
@@ -328,7 +366,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 static void free_thread_stack(struct task_struct *tsk)
 {
-	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	thread_stack_delayed_free(tsk);
 	tsk->stack = NULL;
 }
 
@@ -337,6 +375,18 @@ static void free_thread_stack(struct task_struct *tsk)
 
 static struct kmem_cache *thread_stack_cache;
 
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	kmem_cache_free(thread_stack_cache, rh);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh = tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
@@ -348,7 +398,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 static void free_thread_stack(struct task_struct *tsk)
 {
-	kmem_cache_free(thread_stack_cache, tsk->stack);
+	thread_stack_delayed_free(tsk);
 	tsk->stack = NULL;
 }
 
