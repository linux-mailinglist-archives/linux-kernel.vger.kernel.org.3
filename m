Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7349B7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349509AbiAYPaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:30:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345447AbiAYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqTj/MWZ/KJ2RN1mgDHy03k6dnz1y2VoL1uj4/vvUAQ=;
        b=LbbMdRo1XXg6KVBHbbqPBcqdbG25p3Spy5dyBjTDPwNUCaIo1Et6mXdc9EdWJ9RKagpE8P
        sdXgUE914mMUVB54BVaZrA15CKnzZ1EXhfbgG0TuW88AIpdytOJ18S/dLyS79RcUvI+Bxc
        mwdiLCIdbLZEwKFHWlfh2PYFyREEqcpyJZyEV/JrJBw/xEW8jXJf/HpsG6qr3gpfH016Es
        ZWlHUrx6j1U+Ho2rQwYxaGySdQOYhYS9J4f4scTOKgrt4mmgkOxKStCwrHi7h6zS+zaVo6
        0irxj1KR1lJEc+QvGUkaOjaleOZg2/aiqcIxlxXnzw0fg5gNrR9pUyZ5en8RJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqTj/MWZ/KJ2RN1mgDHy03k6dnz1y2VoL1uj4/vvUAQ=;
        b=Ztyu45yMZ5XpxvMPjIGx8jVo3+SiuxbOyIjYqQ8Zrcfg3HpFXcPvaOZb6qVCWRcytPYA30
        4W3V+fxptbgZFaDg==
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
Subject: [PATCH 1/8] kernel/fork: Redo ifdefs around task's handling.
Date:   Tue, 25 Jan 2022 16:26:45 +0100
Message-Id: <20220125152652.1963111-2-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of ifdef CONFIG_VMAP_STACK is confusing in terms what is
actually happenning and what can happen.
For instance from reading free_thread_stack() it appears that in the
CONFIG_VMAP_STACK case we may receive a non-NULL vm pointer but it may
also be NULL in which case __free_pages() is used to free the stack.
This is however not the case because in the VMAP case a non-NULL pointer
is always returned here.
Since it looks like this might happen, the compiler creates the correct
dead code with the invocation to __free_pages() and everything around
it. Twice.

Add spaces between the ifdef and the identifer to recognize the ifdef
level that we are currently in.
Add the current identifer as a comment behind #else and #endif.
Move the code within free_thread_stack() and alloc_thread_stack_node()
into the relavant ifdef block.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 74 +++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b219..f63c0af6002da 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -185,7 +185,7 @@ static inline void free_task_struct(struct task_struct =
*tsk)
  */
 # if THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK)
=20
-#ifdef CONFIG_VMAP_STACK
+#  ifdef CONFIG_VMAP_STACK
 /*
  * vmalloc() is a bit slow, and calling vfree() enough times will force a =
TLB
  * flush.  Try to minimize the number of calls by caching stacks.
@@ -210,11 +210,9 @@ static int free_vm_stack_cache(unsigned int cpu)
=20
 	return 0;
 }
-#endif
=20
 static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
 {
-#ifdef CONFIG_VMAP_STACK
 	void *stack;
 	int i;
=20
@@ -258,7 +256,34 @@ static unsigned long *alloc_thread_stack_node(struct t=
ask_struct *tsk, int node)
 		tsk->stack =3D stack;
 	}
 	return stack;
-#else
+}
+
+static void free_thread_stack(struct task_struct *tsk)
+{
+	struct vm_struct *vm =3D task_stack_vm_area(tsk);
+	int i;
+
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
+
+	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
+				     tsk->stack_vm_area) !=3D NULL)
+			continue;
+
+		tsk->stack =3D NULL;
+		tsk->stack_vm_area =3D NULL;
+		return;
+	}
+	vfree_atomic(tsk->stack);
+	tsk->stack =3D NULL;
+	tsk->stack_vm_area =3D NULL;
+}
+
+#  else /* !CONFIG_VMAP_STACK */
+
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+{
 	struct page *page =3D alloc_pages_node(node, THREADINFO_GFP,
 					     THREAD_SIZE_ORDER);
=20
@@ -267,36 +292,17 @@ static unsigned long *alloc_thread_stack_node(struct =
task_struct *tsk, int node)
 		return tsk->stack;
 	}
 	return NULL;
-#endif
 }
=20
-static inline void free_thread_stack(struct task_struct *tsk)
+static void free_thread_stack(struct task_struct *tsk)
 {
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-
-	if (vm) {
-		int i;
-
-		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-			memcg_kmem_uncharge_page(vm->pages[i], 0);
-
-		for (i =3D 0; i < NR_CACHED_STACKS; i++) {
-			if (this_cpu_cmpxchg(cached_stacks[i],
-					NULL, tsk->stack_vm_area) !=3D NULL)
-				continue;
-
-			return;
-		}
-
-		vfree_atomic(tsk->stack);
-		return;
-	}
-#endif
-
 	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	tsk->stack =3D NULL;
 }
-# else
+
+#  endif /* CONFIG_VMAP_STACK */
+# else /* !(THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK)) */
+
 static struct kmem_cache *thread_stack_cache;
=20
 static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
@@ -312,6 +318,7 @@ static unsigned long *alloc_thread_stack_node(struct ta=
sk_struct *tsk,
 static void free_thread_stack(struct task_struct *tsk)
 {
 	kmem_cache_free(thread_stack_cache, tsk->stack);
+	tsk->stack =3D NULL;
 }
=20
 void thread_stack_cache_init(void)
@@ -321,8 +328,9 @@ void thread_stack_cache_init(void)
 					THREAD_SIZE, NULL);
 	BUG_ON(thread_stack_cache =3D=3D NULL);
 }
-# endif
-#endif
+
+# endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
@@ -432,10 +440,6 @@ static void release_task_stack(struct task_struct *tsk)
=20
 	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
-	tsk->stack =3D NULL;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area =3D NULL;
-#endif
 }
=20
 #ifdef CONFIG_THREAD_INFO_IN_TASK
--=20
2.34.1

