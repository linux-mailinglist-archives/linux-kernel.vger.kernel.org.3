Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36E4B59B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357380AbiBNSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:15:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353069AbiBNSP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:15:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F965481;
        Mon, 14 Feb 2022 10:15:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 19:15:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644862518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anRVS1fry9D8pOiefrpwSc71Ez7gdOv+1V2jtNDKsvs=;
        b=hXWUhRJzo07ffmexBu36d5g7K8M1GetPqH4IQzBG0phmlxpCRRycd0fa81SGO5tqolmry7
        xM1/vNjsk4rmcxuQKInPpZJ8AYLn7QFKqdHNyGG9nEjGRiM572LHLfvNGOZHauSjSoyNjF
        7dzhKIDnR3yfAuD6x3/iR8H6A6ExQLHPLEADcBbLdy89ULLKpt939zr+UNrq5zGJvsLlhF
        6rRUYJnDotdUXJv1NHW7hvmPofwjtksyOH+SuI0bt+yMucWfsSc10sj0+3T3h0QJ3V5//L
        GCy7noi+PrjP5bq+JUTGtnoK01nWSUdm8fXQfG2A/h2cRLJAA8Vv3sEX6Fi7Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644862518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anRVS1fry9D8pOiefrpwSc71Ez7gdOv+1V2jtNDKsvs=;
        b=ONNUoukiJi1gNx1D7Nn7adk9D0uA1t7xz/Nkckb1v0zZhkyl72iyShjfM5191H8p3OqJRp
        Q9NLyel6oWGEnKBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 7/8] kernel/fork: Only cache the VMAP stack in
 finish_task_switch().
Message-ID: <YgqcNFrCsXi/XCCh@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-8-bigeasy@linutronix.de>
 <00f9c7a6-2d1d-f871-e9bc-00e2217f40f9@kernel.org>
 <YgpGnFlTS+2Ugfw4@linutronix.de>
 <YgpJ41q35k+KCsk4@linutronix.de>
 <YgqJV0LREU9IDJxl@linutronix.de>
 <YgqV1BLbCx5V+6tq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgqV1BLbCx5V+6tq@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task stack could be deallocated later. For fork()/exec() kind of
workloads (say a shell script executing several commands) it is
important that the stack is released in finish_task_switch() so that in
VMAP_STACK case it can be cached and reused in the new task.

For PREEMPT_RT it would be good if the wake-up in vfree_atomic() could
be avoided in the scheduling path. Far worse are the other
free_thread_stack() implementations which invoke __free_pages()/
kmem_cache_free() with disabled preemption.

Cache the stack in free_thread_stack() in the VMAP_STACK case and
RCU-delay the free path otherwise. Free the stack in the RCU callback.
In the VMAP_STACK case this is another opportunity to fill the cache.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

If that works and there are no other objection then I'm going to repost
the complete series.

 kernel/fork.c | 76 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 984f69d6f211f..aa17ed2a2afc7 100644
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
 
-- 
2.34.1

