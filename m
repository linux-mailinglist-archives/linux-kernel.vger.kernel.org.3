Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B704B9D04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbiBQKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbiBQKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B8279085;
        Thu, 17 Feb 2022 02:24:14 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEsTUOSaWCSEZQKtwmhfwzPA5QEczAckklkj6p/jMls=;
        b=ykFHdezJ3RFsbfhL4QVCanbtjZSidvlMttr1xwuY/oHDFg+XteKL8d/s7tSVym8qEcwkoT
        hXxeMHupJcJF3sbp7YJUIZpSM8pyPCMNEMpv4IRexx7fqbTV2PXsjCtGagwLOAHJEWAE+3
        nmQEmbIn5gdmJOYONGvpHrn4X7II+2NA1agbBfHb/5QOvj/Sr8/cQyoNzk0HB9D6ga+1fV
        qxXJcJxnTGkT3FkD314AkFkOv1QUjk2ww++oQLi9kTnkJQAr44O0tvpi/Qy7S0a2vAcHME
        4/ZP8sZiHhDGi3buT5hCOYpVqDtFZ9H1bshnwGsX/YJepfO0w/bU/qPMEzQY1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEsTUOSaWCSEZQKtwmhfwzPA5QEczAckklkj6p/jMls=;
        b=mXjFPopJFMNHPL94dGaalBh9Ao2w2Jvw5Fz3OleuR78Ucnuev9W17RZaSEnaoPUn81xdFM
        filAtZAZgBrsmCCQ==
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
Subject: [PATCH v2 7/8] kernel/fork: Only cache the VMAP stack in finish_task_switch().
Date:   Thu, 17 Feb 2022 11:24:05 +0100
Message-Id: <20220217102406.3697941-8-bigeasy@linutronix.de>
In-Reply-To: <20220217102406.3697941-1-bigeasy@linutronix.de>
References: <20220217102406.3697941-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 kernel/fork.c | 76 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 984f69d6f211f..aa17ed2a2afc7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -193,6 +193,41 @@ static inline void free_task_struct(struct task_struct=
 *tsk)
 #define NR_CACHED_STACKS 2
 static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
=20
+struct vm_stack {
+	struct rcu_head rcu;
+	struct vm_struct *stack_vm_area;
+};
+
+static bool try_release_thread_stack_to_cache(struct vm_struct *vm)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL, vm) !=3D NULL)
+			continue;
+		return true;
+	}
+	return false;
+}
+
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	struct vm_stack *vm_stack =3D container_of(rh, struct vm_stack, rcu);
+
+	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
+		return;
+
+	vfree(vm_stack);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct vm_stack *vm_stack =3D tsk->stack;
+
+	vm_stack->stack_vm_area =3D tsk->stack_vm_area;
+	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+}
+
 static int free_vm_stack_cache(unsigned int cpu)
 {
 	struct vm_struct **cached_vm_stacks =3D per_cpu_ptr(cached_stacks, cpu);
@@ -296,24 +331,27 @@ static int alloc_thread_stack_node(struct task_struct=
 *tsk, int node)
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	int i;
+	if (!try_release_thread_stack_to_cache(tsk->stack_vm_area))
+		thread_stack_delayed_free(tsk);
=20
-	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
-		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
-				     tsk->stack_vm_area) !=3D NULL)
-			continue;
-
-		tsk->stack =3D NULL;
-		tsk->stack_vm_area =3D NULL;
-		return;
-	}
-	vfree_atomic(tsk->stack);
 	tsk->stack =3D NULL;
 	tsk->stack_vm_area =3D NULL;
 }
=20
 #  else /* !CONFIG_VMAP_STACK */
=20
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	__free_pages(virt_to_page(rh), THREAD_SIZE_ORDER);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh =3D tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page =3D alloc_pages_node(node, THREADINFO_GFP,
@@ -328,7 +366,7 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	thread_stack_delayed_free(tsk);
 	tsk->stack =3D NULL;
 }
=20
@@ -337,6 +375,18 @@ static void free_thread_stack(struct task_struct *tsk)
=20
 static struct kmem_cache *thread_stack_cache;
=20
+static void thread_stack_free_rcu(struct rcu_head *rh)
+{
+	kmem_cache_free(thread_stack_cache, rh);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct rcu_head *rh =3D tsk->stack;
+
+	call_rcu(rh, thread_stack_free_rcu);
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
@@ -348,7 +398,7 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	kmem_cache_free(thread_stack_cache, tsk->stack);
+	thread_stack_delayed_free(tsk);
 	tsk->stack =3D NULL;
 }
=20
--=20
2.34.1

