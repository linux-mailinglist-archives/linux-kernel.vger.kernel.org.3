Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876A549B7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346195AbiAYPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:31:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiAYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj/UDQFXh46ohFcq4x02lLRgfDUj8Hg+fo7XLxh0iIk=;
        b=ZxEi8X5Iwl/QpIiCJm9sICmY6KkFcM7sXLjCya99qvcT0lG7Vo6tgPwADOiaTBhh5Qkopz
        VENPrk+IfjqMv3D7wtJxWT6hAVbLtO9pd5IvgkbzeOukRuKWvGzGN8rLxHH+m0kjazHnPC
        Mzy2OqcKhDTv9qLIVxLHoeYJjqN5XjYs+ldSXZAgAnvR82S02Pc6/FywaEnvh04pEi8hyL
        svTcZljwuyB4UzOH6QDAT4BxfSX/mWE2IEw/pxXMi+XdHxESovbVus5PIq5mptYQXtPxMe
        XdKjnKANmUzHVAt9YLvsAkxBQyVprNiHbY4rzkWsQ8krgbcT465k+o5a+t6e1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hj/UDQFXh46ohFcq4x02lLRgfDUj8Hg+fo7XLxh0iIk=;
        b=HXCas+atbeSv75w30tw5ujuq3uMWtDrru2A79HoJgaJ9NiXknnIu6clsO3P6FXJ1Ur5RDn
        pNi04qt3jBem7BAA==
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
Subject: [PATCH 5/8] kernel/fork: Move memcg_charge_kernel_stack() into CONFIG_VMAP_STACK.
Date:   Tue, 25 Jan 2022 16:26:49 +0100
Message-Id: <20220125152652.1963111-6-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_charge_kernel_stack() is only used in the CONFIG_VMAP_STACK case.

Move memcg_charge_kernel_stack() into the CONFIG_VMAP_STACK block and
invoke it from within alloc_thread_stack_node().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 69 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index e6337b3c34ff7..73f644482e932 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,6 +211,32 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+	struct vm_struct *vm =3D task_stack_vm_area(tsk);
+	int i;
+	int ret;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
+	BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
+
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+		ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	/*
+	 * If memcg_kmem_charge_page() fails, page's memory cgroup pointer is
+	 * NULL, and memcg_kmem_uncharge_page() in free_thread_stack() will
+	 * ignore this page.
+	 */
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
+	return ret;
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
@@ -230,6 +256,11 @@ static int alloc_thread_stack_node(struct task_struct =
*tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
=20
+		if (memcg_charge_kernel_stack(tsk)) {
+			vfree(s->addr);
+			return -ENOMEM;
+		}
+
 		tsk->stack_vm_area =3D s;
 		tsk->stack =3D s->addr;
 		return 0;
@@ -247,6 +278,11 @@ static int alloc_thread_stack_node(struct task_struct =
*tsk, int node)
 				     0, node, __builtin_return_address(0));
 	if (!stack)
 		return -ENOMEM;
+
+	if (memcg_charge_kernel_stack(tsk)) {
+		vfree(stack);
+		return -ENOMEM;
+	}
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
@@ -417,36 +453,6 @@ static void account_kernel_stack(struct task_struct *t=
sk, int account)
 	}
 }
=20
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
-{
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-	int ret;
-
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
-
-	if (vm) {
-		int i;
-
-		BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
-
-		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			/*
-			 * If memcg_kmem_charge_page() fails, page's
-			 * memory cgroup pointer is NULL, and
-			 * memcg_kmem_uncharge_page() in free_thread_stack()
-			 * will ignore this page.
-			 */
-			ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
-						     0);
-			if (ret)
-				return ret;
-		}
-	}
-#endif
-	return 0;
-}
-
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) !=3D TASK_DEAD))
@@ -908,9 +914,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	if (err)
 		goto free_tsk;
=20
-	if (memcg_charge_kernel_stack(tsk))
-		goto free_stack;
-
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
--=20
2.34.1

