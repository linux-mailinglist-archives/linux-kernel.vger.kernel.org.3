Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11134B9D05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiBQKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:24:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiBQKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D35279089;
        Thu, 17 Feb 2022 02:24:13 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eh6w4p7U+VnlRGvHFngCmwGKSGGucQC6c+wAAkZxo88=;
        b=rUtZKv7N8+ne95KUmtvRgIWk22VnECkOmLuG+eh92IbcxGKSuMtqJgyQWCgh46M26cqTlI
        1QNgo5ZVBsPEPim92P6GY4DqRVCBTk73+ETrw5rkVN6d2SkmeLEFYHMnq9/sm6WXqx6g/y
        Ekrvr4fyM8gCfkN9xul3lS+wGGy3+ztZqNGepZaoc0FwrhlJpWzkxdcZtrI1H3R+hnyitP
        F7iTYezko30lgWWuSVySVz1cALv0Vyq6rCQzUHK0loCrEJ1aWU5X36rgVKU/Dark6543u6
        PAeqAfqhWZlc18cjroFcCb0byWt5tVIOkvx/AwY5++DFE94PWbJxWNsyVzMFzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eh6w4p7U+VnlRGvHFngCmwGKSGGucQC6c+wAAkZxo88=;
        b=7xZmJB1nVW1pBGcM8XTu/6mGLTwkl/9uEQTLGEWSdxFe5szKjFWo489qXlHtU3P0ShA4Zo
        7IZbBqYc+uEKPkDQ==
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
Subject: [PATCH v2 5/8] kernel/fork: Move memcg_charge_kernel_stack() into CONFIG_VMAP_STACK.
Date:   Thu, 17 Feb 2022 11:24:03 +0100
Message-Id: <20220217102406.3697941-6-bigeasy@linutronix.de>
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

memcg_charge_kernel_stack() is only used in the CONFIG_VMAP_STACK case.

Move memcg_charge_kernel_stack() into the CONFIG_VMAP_STACK block and
invoke it from within alloc_thread_stack_node().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 69 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 546bea2e3b28a..919bdcf21b8e5 100644
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
@@ -418,36 +454,6 @@ static void account_kernel_stack(struct task_struct *t=
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
@@ -909,9 +915,6 @@ static struct task_struct *dup_task_struct(struct task_=
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

