Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908A4C03D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiBVV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiBVV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A04B8E187;
        Tue, 22 Feb 2022 13:27:05 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:27:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2SftizOYJm0Oa3oZMe4lwD8sUSmZAIEP8u+0K0p48o=;
        b=QtQKhdvBssqDSxlFOd100wKw34gpXxODx6UjNLxvm0ld/3RQlyByF80RftK6E2LqC26hWq
        kCBN32TeZUHJKYNj4PR2s1BG92kUgWIiD/d4sChbk9OsE7wp+Wn6JEmPhVwpyz0K6kHf6c
        8hg/vP6HJ6dhqDifHIRtzivMK7lrtjAeVCWnlUdq2a++33HHosSwAVwxJSjMpgZj71r022
        MRWoOOCxwZcJkCQPda9rYJ9dObACQT6eRCzYa6NRhfC5J88KsLUmr6s6iQFZUkOAheDaqz
        67lmVQQboqw1Op2tFG2Q2lGWo3uOyoUz1DqlyYNjm6tA/BfuH8nv0/twxTaMUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2SftizOYJm0Oa3oZMe4lwD8sUSmZAIEP8u+0K0p48o=;
        b=r4aZx67naC9SVbdsBBF+bA6wRYiTENbpyGoW0BXwZGU/DUm9HgLwwwhbBsRR0LzXuNtcjT
        tkzCwH3rtycrnCAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Redo ifdefs around task stack handling
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-2-bigeasy@linutronix.de>
References: <20220217102406.3697941-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556522311.16921.16318571180509187723.tip-bot2@tip-bot2>
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

Commit-ID:     be9a2277cafd318976d59c41a7f45a934ec43b26
Gitweb:        https://git.kernel.org/tip/be9a2277cafd318976d59c41a7f45a934ec43b26
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:23:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:01 +01:00

fork: Redo ifdefs around task stack handling

The use of ifdef CONFIG_VMAP_STACK is confusing in terms what is
actually happenning and what can happen.

For instance from reading free_thread_stack() it appears that in the
CONFIG_VMAP_STACK case it may receive a non-NULL vm pointer but it may also
be NULL in which case __free_pages() is used to free the stack.  This is
however not the case because in the VMAP case a non-NULL pointer is always
returned here.  Since it looks like this might happen, the compiler creates
the correct dead code with the invocation to __free_pages() and everything
around it. Twice.

Add spaces between the ifdef and the identifer to recognize the ifdef
level which is currently in scope.

Add the current identifer as a comment behind #else and #endif.
Move the code within free_thread_stack() and alloc_thread_stack_node()
into the relevant ifdef blocks.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-2-bigeasy@linutronix.de

---
 kernel/fork.c | 74 ++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index a024bf6..f5cc101 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -185,7 +185,7 @@ static inline void free_task_struct(struct task_struct *tsk)
  */
 # if THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)
 
-#ifdef CONFIG_VMAP_STACK
+#  ifdef CONFIG_VMAP_STACK
 /*
  * vmalloc() is a bit slow, and calling vfree() enough times will force a TLB
  * flush.  Try to minimize the number of calls by caching stacks.
@@ -210,11 +210,9 @@ static int free_vm_stack_cache(unsigned int cpu)
 
 	return 0;
 }
-#endif
 
 static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
-#ifdef CONFIG_VMAP_STACK
 	void *stack;
 	int i;
 
@@ -258,45 +256,53 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 		tsk->stack = stack;
 	}
 	return stack;
-#else
-	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
-					     THREAD_SIZE_ORDER);
-
-	if (likely(page)) {
-		tsk->stack = kasan_reset_tag(page_address(page));
-		return tsk->stack;
-	}
-	return NULL;
-#endif
 }
 
-static inline void free_thread_stack(struct task_struct *tsk)
+static void free_thread_stack(struct task_struct *tsk)
 {
-#ifdef CONFIG_VMAP_STACK
 	struct vm_struct *vm = task_stack_vm_area(tsk);
+	int i;
 
-	if (vm) {
-		int i;
+	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-			memcg_kmem_uncharge_page(vm->pages[i], 0);
+	for (i = 0; i < NR_CACHED_STACKS; i++) {
+		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
+				     tsk->stack_vm_area) != NULL)
+			continue;
 
-		for (i = 0; i < NR_CACHED_STACKS; i++) {
-			if (this_cpu_cmpxchg(cached_stacks[i],
-					NULL, tsk->stack_vm_area) != NULL)
-				continue;
+		tsk->stack = NULL;
+		tsk->stack_vm_area = NULL;
+		return;
+	}
+	vfree_atomic(tsk->stack);
+	tsk->stack = NULL;
+	tsk->stack_vm_area = NULL;
+}
 
-			return;
-		}
+#  else /* !CONFIG_VMAP_STACK */
 
-		vfree_atomic(tsk->stack);
-		return;
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
+{
+	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
+					     THREAD_SIZE_ORDER);
+
+	if (likely(page)) {
+		tsk->stack = kasan_reset_tag(page_address(page));
+		return tsk->stack;
 	}
-#endif
+	return NULL;
+}
 
+static void free_thread_stack(struct task_struct *tsk)
+{
 	__free_pages(virt_to_page(tsk->stack), THREAD_SIZE_ORDER);
+	tsk->stack = NULL;
 }
-# else
+
+#  endif /* CONFIG_VMAP_STACK */
+# else /* !(THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK)) */
+
 static struct kmem_cache *thread_stack_cache;
 
 static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
@@ -312,6 +318,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
 static void free_thread_stack(struct task_struct *tsk)
 {
 	kmem_cache_free(thread_stack_cache, tsk->stack);
+	tsk->stack = NULL;
 }
 
 void thread_stack_cache_init(void)
@@ -321,8 +328,9 @@ void thread_stack_cache_init(void)
 					THREAD_SIZE, NULL);
 	BUG_ON(thread_stack_cache == NULL);
 }
-# endif
-#endif
+
+# endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
@@ -432,10 +440,6 @@ static void release_task_stack(struct task_struct *tsk)
 
 	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
-	tsk->stack = NULL;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area = NULL;
-#endif
 }
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
