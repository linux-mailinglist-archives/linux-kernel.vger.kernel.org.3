Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FE4B9D06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiBQKYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiBQKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E9279085;
        Thu, 17 Feb 2022 02:24:12 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqTj/MWZ/KJ2RN1mgDHy03k6dnz1y2VoL1uj4/vvUAQ=;
        b=M2lB99miPqxH2UH/lhrIfA/YEHH0IVoBZN1SLGauILXE8Lrb3NbRJrCW1A1sUNnw6Ygu9M
        t5zOIphs9JUeJvNalDD3DWNloYDBGKd7wcG6kdvfzEHGpfROuCoZTmV85Vb2EiPAjCTiOp
        5WDPQTX/L7Un56QduCdMy6vr65QHBgtEtRFTu5vEPh5S/4aYhreu8JwUjKyjX9ZI6Sh1bm
        1CKWkLu399qUDN6C/Te3ZQLt9HsVeaic5hJtdIBF8O7qI9peOuRzBdLZUuGVhqBT2z6Dn5
        symUrzAbo6lD2fC/cm5GhMxtjWH8cjj8Q9Z+bEbCxxcMeAg3gRz9ngiTE6JI5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqTj/MWZ/KJ2RN1mgDHy03k6dnz1y2VoL1uj4/vvUAQ=;
        b=HkyDWvAfLgoilVNOWERANnOXJy0P3321md/wXHEvPcTKv8pWCpZ9T+BhxLVAi2vyEjifYE
        krFzgMYBh2nuBGAA==
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
Subject: [PATCH v2 1/8] kernel/fork: Redo ifdefs around task's handling.
Date:   Thu, 17 Feb 2022 11:23:59 +0100
Message-Id: <20220217102406.3697941-2-bigeasy@linutronix.de>
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

