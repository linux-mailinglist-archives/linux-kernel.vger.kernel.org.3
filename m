Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB27549B79B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349223AbiAYP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbiAYP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC75C06173B;
        Tue, 25 Jan 2022 07:27:01 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BK2stH6hi6EZUuAUSqM+wo9W+aB6VBt7vWmGOsrxxmc=;
        b=OdceoFbM/Wj57SOd6znbsQY3MsmXlbOmk2bulXpIvPSxnzQm7R0BwkELtv6vVlI5hKnX4F
        Ccifq7s4rqwa+UVzThVCk/7ZhtprWmpcwMes5t9HbSN5RuB4iU7luXDt+9C/YlRrSFBSQi
        gxeYx33SItNN1Al8detKvINuFmMotqq9nWnqSAr7S5iVigIznBRvRoOJfT+FRhz/wnPULJ
        tRZAr0+6YokMkavLhGUnbpeCQu33bUSV1xLgJ+a0Dufi1KSYGKFiZailzwIQ8FPng5YT9N
        7DtaCIFfVki5IUv0wgsiuTFH1C1VxEVbYHMrl3rUcSB2TKWO5w9zK4tykDk4Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BK2stH6hi6EZUuAUSqM+wo9W+aB6VBt7vWmGOsrxxmc=;
        b=lIrRCHtHgCkL017Fxh1X/FsxD1FIWUvZS/FahKHPt4RhzD/rn8mjQXTS3d/dscUwBshGy1
        NbDxytNDCzJFr1Dg==
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
Subject: [PATCH 4/8] kernel/fork: Don't assign the stack pointer in dup_task_struct().
Date:   Tue, 25 Jan 2022 16:26:48 +0100
Message-Id: <20220125152652.1963111-5-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All four versions of alloc_thread_stack_node() assign now
task_struct::stack in case the allocation was successful.

Let alloc_thread_stack_node() return an error code instead of the stack
pointer and remove the stack assignment in dup_task_struct().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index a0d58ae6fac76..e6337b3c34ff7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,7 +211,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
 	int i;
@@ -232,7 +232,7 @@ static unsigned long *alloc_thread_stack_node(struct ta=
sk_struct *tsk, int node)
=20
 		tsk->stack_vm_area =3D s;
 		tsk->stack =3D s->addr;
-		return s->addr;
+		return 0;
 	}
=20
 	/*
@@ -245,17 +245,16 @@ static unsigned long *alloc_thread_stack_node(struct =
task_struct *tsk, int node)
 				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
-
+	if (!stack)
+		return -ENOMEM;
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	if (stack) {
-		tsk->stack_vm_area =3D find_vm_area(stack);
-		tsk->stack =3D stack;
-	}
-	return stack;
+	tsk->stack_vm_area =3D find_vm_area(stack);
+	tsk->stack =3D stack;
+	return 0;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -282,16 +281,16 @@ static void free_thread_stack(struct task_struct *tsk)
=20
 #  else /* !CONFIG_VMAP_STACK */
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page =3D alloc_pages_node(node, THREADINFO_GFP,
 					     THREAD_SIZE_ORDER);
=20
 	if (likely(page)) {
 		tsk->stack =3D kasan_reset_tag(page_address(page));
-		return tsk->stack;
+		return 0;
 	}
-	return NULL;
+	return -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -305,14 +304,13 @@ static void free_thread_stack(struct task_struct *tsk)
=20
 static struct kmem_cache *thread_stack_cache;
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
-						  int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
 	stack =3D kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
 	stack =3D kasan_reset_tag(stack);
 	tsk->stack =3D stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -332,13 +330,13 @@ void thread_stack_cache_init(void)
 # endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
 #else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
=20
 	stack =3D arch_alloc_thread_stack_node(tsk, node);
 	tsk->stack =3D stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk, bool cache_only)
@@ -894,8 +892,6 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int n=
ode)
 {
 	struct task_struct *tsk;
-	unsigned long *stack;
-	struct vm_struct *stack_vm_area __maybe_unused;
 	int err;
=20
 	if (node =3D=3D NUMA_NO_NODE)
@@ -908,24 +904,13 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig, int node)
 	if (err)
 		goto free_tsk;
=20
-	stack =3D alloc_thread_stack_node(tsk, node);
-	if (!stack)
+	err =3D alloc_thread_stack_node(tsk, node);
+	if (err)
 		goto free_tsk;
=20
 	if (memcg_charge_kernel_stack(tsk))
 		goto free_stack;
=20
-	stack_vm_area =3D task_stack_vm_area(tsk);
-
-	/*
-	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
-	 * sure they're properly initialized before using any stack-related
-	 * functions again.
-	 */
-	tsk->stack =3D stack;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area =3D stack_vm_area;
-#endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
--=20
2.34.1

