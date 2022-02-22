Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAD4C03C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiBVV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiBVV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5517C143;
        Tue, 22 Feb 2022 13:27:03 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjwD/neY7piuB2chNxQqwEH9BNkkcrIN0J6tsQrWAoA=;
        b=WkwlhQBaK6DlK3jfwIRFpOYx7Rv2iXCLfVOrXnWhb2/i0hrlriXkO9tW2V/YAhnqmocSSW
        tcwyqukaKy9N6Rhs2TEN5Yo82zx14+iGq+ZGg0kStTeBRiDWgDwmPXGzxXuvCwr3Ck3DAs
        OTuUn2sdkD24nS1ccat1DN7IEPp7PhkV/oCLHYWqRr395PfWtOMZrnGX55687WLoZwAAE+
        rkMFWUZHk73fWDNWnTpISvxplXPnQAyyt9KDVgoPr9VKrUhsQOLzDbWGzMI6QbO0N2Sp9E
        n64Z22N1JMnbkYXWy0zKM/z5pfenAGpg9FpAY8MQoZRJqmMcTQXLLJdteni+ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjwD/neY7piuB2chNxQqwEH9BNkkcrIN0J6tsQrWAoA=;
        b=Qjy0ye2BHVRZCYRrpyQ1jeoiJxQGIjPTwZE13GqhtLH6yuQdwL4tQ/nYvOk1UOh3Lgydj9
        U+mVl0GA0n/ciECQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Don't assign the stack pointer in dup_task_struct()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-5-bigeasy@linutronix.de>
References: <20220217102406.3697941-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556522064.16921.3205026374549240577.tip-bot2@tip-bot2>
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

Commit-ID:     7865aba3ade4cf30f0ac08e015550084a50d9afb
Gitweb:        https://git.kernel.org/tip/7865aba3ade4cf30f0ac08e015550084a50d9afb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:01 +01:00

fork: Don't assign the stack pointer in dup_task_struct()

All four versions of alloc_thread_stack_node() assign now
task_struct::stack in case the allocation was successful.

Let alloc_thread_stack_node() return an error code instead of the stack
pointer and remove the stack assignment in dup_task_struct().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-5-bigeasy@linutronix.de

---
 kernel/fork.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7b70c47..875bd43 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,7 +211,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
 
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
 	int i;
@@ -232,7 +232,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
 
 		tsk->stack_vm_area = s;
 		tsk->stack = s->addr;
-		return s->addr;
+		return 0;
 	}
 
 	/*
@@ -245,17 +245,16 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
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
-		tsk->stack_vm_area = find_vm_area(stack);
-		tsk->stack = stack;
-	}
-	return stack;
+	tsk->stack_vm_area = find_vm_area(stack);
+	tsk->stack = stack;
+	return 0;
 }
 
 static void free_thread_stack(struct task_struct *tsk)
@@ -282,16 +281,16 @@ static void free_thread_stack(struct task_struct *tsk)
 
 #  else /* !CONFIG_VMAP_STACK */
 
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
 					     THREAD_SIZE_ORDER);
 
 	if (likely(page)) {
 		tsk->stack = kasan_reset_tag(page_address(page));
-		return tsk->stack;
+		return 0;
 	}
-	return NULL;
+	return -ENOMEM;
 }
 
 static void free_thread_stack(struct task_struct *tsk)
@@ -305,14 +304,13 @@ static void free_thread_stack(struct task_struct *tsk)
 
 static struct kmem_cache *thread_stack_cache;
 
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
-						  int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
 	stack = kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
 	stack = kasan_reset_tag(stack);
 	tsk->stack = stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
 
 static void free_thread_stack(struct task_struct *tsk)
@@ -332,13 +330,13 @@ void thread_stack_cache_init(void)
 # endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
 #else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
 
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
 
 	stack = arch_alloc_thread_stack_node(tsk, node);
 	tsk->stack = stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
 
 static void free_thread_stack(struct task_struct *tsk)
@@ -895,8 +893,6 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
 	struct task_struct *tsk;
-	unsigned long *stack;
-	struct vm_struct *stack_vm_area __maybe_unused;
 	int err;
 
 	if (node == NUMA_NO_NODE)
@@ -909,24 +905,13 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_tsk;
 
-	stack = alloc_thread_stack_node(tsk, node);
-	if (!stack)
+	err = alloc_thread_stack_node(tsk, node);
+	if (err)
 		goto free_tsk;
 
 	if (memcg_charge_kernel_stack(tsk))
 		goto free_stack;
 
-	stack_vm_area = task_stack_vm_area(tsk);
-
-	/*
-	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
-	 * sure they're properly initialized before using any stack-related
-	 * functions again.
-	 */
-	tsk->stack = stack;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area = stack_vm_area;
-#endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
