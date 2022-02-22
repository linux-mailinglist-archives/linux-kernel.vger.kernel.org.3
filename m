Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33C4C03CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiBVV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiBVV12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703267B571;
        Tue, 22 Feb 2022 13:27:02 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:26:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1KobKfROGuhaG2oaiPqWbvyFzgdo63Th7Q5VX3E4tE=;
        b=4ymFaxAFdRHH+4EdFpJxibjuQXpVfvistSwS70skDZ2eewwzUVe5TGsaiFuqp103kCyTSv
        a6AyciNHwlzC43lvLBwmXkZ0VmHn7KdBfyU21h4MCiedMnxx2Jv2e7Je/68d9YYMNnSDEC
        KySUTTOwps5HKLFstSKGWnqaVbb+JwH5QFWCgDKcNrZ1U0iZkz7fGmQnESNJ/nQ5YCtI0y
        XLupJP3uLwSRahrbuK3KO8Iwz9PHtf4Ef2f56O3VeiGCLuN+Kjt1nD8/yQmgdgmi/ZCw7j
        SpoT5Xd141rCHNIsbj/iUK29x0h4ZN4IdP+Z4JiZICVIubI1eoovpdhJh+Smow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1KobKfROGuhaG2oaiPqWbvyFzgdo63Th7Q5VX3E4tE=;
        b=mPE4Fk6AAX3i48cQYM2m2khqwb33d39hBzTdt7FGHmX7K4NEdP3BUPIPsjW7rsb276ARyD
        h582Fb2o0UdKzWCQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork: Move memcg_charge_kernel_stack() into
 CONFIG_VMAP_STACK
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-6-bigeasy@linutronix.de>
References: <20220217102406.3697941-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556521986.16921.15713300732475801540.tip-bot2@tip-bot2>
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

Commit-ID:     f1c1a9ee00e4c53c9ccc03ec1aff4792948a25eb
Gitweb:        https://git.kernel.org/tip/f1c1a9ee00e4c53c9ccc03ec1aff4792948a25eb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:01 +01:00

fork: Move memcg_charge_kernel_stack() into CONFIG_VMAP_STACK

memcg_charge_kernel_stack() is only used in the CONFIG_VMAP_STACK case.

Move memcg_charge_kernel_stack() into the CONFIG_VMAP_STACK block and
invoke it from within alloc_thread_stack_node().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-6-bigeasy@linutronix.de

---
 kernel/fork.c | 69 ++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 875bd43..ac63e7f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -211,6 +211,32 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
 
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+	struct vm_struct *vm = task_stack_vm_area(tsk);
+	int i;
+	int ret;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
+	BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+
+	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+		ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
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
+	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
+	return ret;
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
@@ -230,6 +256,11 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
 
+		if (memcg_charge_kernel_stack(tsk)) {
+			vfree(s->addr);
+			return -ENOMEM;
+		}
+
 		tsk->stack_vm_area = s;
 		tsk->stack = s->addr;
 		return 0;
@@ -247,6 +278,11 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
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
@@ -418,36 +454,6 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	}
 }
 
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
-{
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm = task_stack_vm_area(tsk);
-	int ret;
-
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 != 0);
-
-	if (vm) {
-		int i;
-
-		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
-
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			/*
-			 * If memcg_kmem_charge_page() fails, page's
-			 * memory cgroup pointer is NULL, and
-			 * memcg_kmem_uncharge_page() in free_thread_stack()
-			 * will ignore this page.
-			 */
-			ret = memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
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
 	if (WARN_ON(READ_ONCE(tsk->__state) != TASK_DEAD))
@@ -909,9 +915,6 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_tsk;
 
-	if (memcg_charge_kernel_stack(tsk))
-		goto free_stack;
-
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
