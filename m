Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232B4C03CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiBVV1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiBVV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:27:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E27B55B;
        Tue, 22 Feb 2022 13:27:04 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:27:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645565222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKX2ehwQx1rBrOY9dgJejssquU0nQTuF5xjXIt4Zbmo=;
        b=MMUcuWaGPR4kGXWGS821ZzKciXcBE06hkTt+8yLczoWfgvAC4benChoLvgU+3XOfh3xcmK
        Sv9ssNaL6G0eVW+/HLRd1Hsebtm0O5eLZcingp9Ju6R9n7vrW+z5tJMPEsNq5ZXULGjSJJ
        +r4aRxO6eZdv30/hWyoOkcLSyyc0TFpK5EFN2nx3XEr1LH4rZPvfmjacBqi4nBywXc+Kcw
        ye/sWevZ9V3Rib6F7ESX9PQp6c+m4nvTfjS315CpmVHll8WBnK8QsCTRcr+4GzqCCi1y8H
        QD8GdyAOl4DiBq4zIuXq9p/bYRCW3cqx4k1k0QhtT5hw+X/YjhmVQFS25D6CCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645565222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKX2ehwQx1rBrOY9dgJejssquU0nQTuF5xjXIt4Zbmo=;
        b=PYSYJ683y88FkbuOOagHA9EX06Uw16s0MDswapjw7UIz7blFlt3xQSCdOj//qj9mUUyT01
        O5p4ZaSBxNkEsfCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] fork, IA64: Provide alloc_thread_stack_node() for IA64
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220217102406.3697941-4-bigeasy@linutronix.de>
References: <20220217102406.3697941-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164556522143.16921.2330247822699922897.tip-bot2@tip-bot2>
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

Commit-ID:     2bb0529c0bc0698f3baf3e88ffd61a18eef252a7
Gitweb:        https://git.kernel.org/tip/2bb0529c0bc0698f3baf3e88ffd61a18eef252a7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 17 Feb 2022 11:24:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Feb 2022 22:25:01 +01:00

fork, IA64: Provide alloc_thread_stack_node() for IA64

Provide a generic alloc_thread_stack_node() for IA64 and
CONFIG_ARCH_THREAD_STACK_ALLOCATOR which returns stack pointer and sets
task_struct::stack so it behaves exactly like the other implementations.

Rename IA64's alloc_thread_stack_node() and add the generic version to the
fork code so it is in one place _and_ to drastically lower the chances of
fat fingering the IA64 code.  Do the same for free_thread_stack().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220217102406.3697941-4-bigeasy@linutronix.de

---
 arch/ia64/include/asm/thread_info.h |  6 +++---
 kernel/fork.c                       | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
index 51d20cb..1684716 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -55,15 +55,15 @@ struct thread_info {
 #ifndef ASM_OFFSETS_C
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + IA64_TASK_SIZE))
-#define alloc_thread_stack_node(tsk, node)	\
+#define arch_alloc_thread_stack_node(tsk, node)	\
 		((unsigned long *) ((char *) (tsk) + IA64_TASK_SIZE))
 #define task_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA64_TASK_SIZE))
 #else
 #define current_thread_info()	((struct thread_info *) 0)
-#define alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
+#define arch_alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
 #define task_thread_info(tsk)	((struct thread_info *) 0)
 #endif
-#define free_thread_stack(tsk)	/* nothing */
+#define arch_free_thread_stack(tsk)	/* nothing */
 #define task_stack_page(tsk)	((void *)(tsk))
 
 #define __HAVE_THREAD_FUNCTIONS
diff --git a/kernel/fork.c b/kernel/fork.c
index 30c01ce..7b70c47 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -330,6 +330,23 @@ void thread_stack_cache_init(void)
 }
 
 # endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
+
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
+{
+	unsigned long *stack;
+
+	stack = arch_alloc_thread_stack_node(tsk, node);
+	tsk->stack = stack;
+	return stack;
+}
+
+static void free_thread_stack(struct task_struct *tsk)
+{
+	arch_free_thread_stack(tsk);
+	tsk->stack = NULL;
+}
+
 #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
