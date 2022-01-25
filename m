Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78D549B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiAYPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:30:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50066 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbiAYP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:27:13 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643124419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xLz/KFQPrcQSXuWbgpl53d0fa2nP/lvm2qQeThafk4=;
        b=C5CRHCNiIL8NoJnSyTplmuSII/XcUiBucgWr4RnrEbVqLqWk5Dzh4SEXmg0eaXutRIQtPp
        Hl4Pzc/zgVGwFh6QHQd8JXidKPGcmK4kEn6QgroyuzVJMwG7WMVwzE6tlcX/zPB42sveAg
        GNrz62fODQBajX+1+iSPWzM7rLyUpBXawJQXPrKFey2WTdIsPuem2cigyZAn6AlwzyUIhg
        1rzx3k1nq0I7Ipz3r7mKJKarhp8RIB2XqWjAnmXIgZiIPNemO4KxQk7io1Xvp40lpWVdtY
        se3hQFwzYYSpWEhuV/rzrvUMn2aDRGH0amYvo7P4yK1zVwg9N7VjthSmRdSpog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643124419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xLz/KFQPrcQSXuWbgpl53d0fa2nP/lvm2qQeThafk4=;
        b=8akRmo7tr2grKpZNHAYd8lvaTO6c5JidOQH+CcHp5XfufJxZs5qeebl3PB1jnbuvQMre+6
        ssHHpcpS+lES8GCQ==
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
Subject: [PATCH 3/8] kernel/fork, IA64: Provide a alloc_thread_stack_node() for IA64.
Date:   Tue, 25 Jan 2022 16:26:47 +0100
Message-Id: <20220125152652.1963111-4-bigeasy@linutronix.de>
In-Reply-To: <20220125152652.1963111-1-bigeasy@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a generic alloc_thread_stack_node() for IA64/
CONFIG_ARCH_THREAD_STACK_ALLOCATOR which returns stack pointer and sets
task_struct::stack so it behaves exactly like the other implementations.

Rename IA64's alloc_thread_stack_node() and add the generic version to
the fork code so it is in one place _and_ to drastically lower chances
of fat fingering the IA64 code.
Do the same for free_thread_stack().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/ia64/include/asm/thread_info.h |  6 +++---
 kernel/fork.c                       | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/th=
read_info.h
index 51d20cb377062..1684716f08201 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -55,15 +55,15 @@ struct thread_info {
 #ifndef ASM_OFFSETS_C
 /* how to get the thread information struct from C */
 #define current_thread_info()	((struct thread_info *) ((char *) current + =
IA64_TASK_SIZE))
-#define alloc_thread_stack_node(tsk, node)	\
+#define arch_alloc_thread_stack_node(tsk, node)	\
 		((unsigned long *) ((char *) (tsk) + IA64_TASK_SIZE))
 #define task_thread_info(tsk)	((struct thread_info *) ((char *) (tsk) + IA=
64_TASK_SIZE))
 #else
 #define current_thread_info()	((struct thread_info *) 0)
-#define alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
+#define arch_alloc_thread_stack_node(tsk, node)	((unsigned long *) 0)
 #define task_thread_info(tsk)	((struct thread_info *) 0)
 #endif
-#define free_thread_stack(tsk)	/* nothing */
+#define arch_free_thread_stack(tsk)	/* nothing */
 #define task_stack_page(tsk)	((void *)(tsk))
=20
 #define __HAVE_THREAD_FUNCTIONS
diff --git a/kernel/fork.c b/kernel/fork.c
index c47dcba5d66d2..a0d58ae6fac76 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -330,6 +330,22 @@ void thread_stack_cache_init(void)
 }
=20
 # endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
+#else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
+
+static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+{
+	unsigned long *stack;
+
+	stack =3D arch_alloc_thread_stack_node(tsk, node);
+	tsk->stack =3D stack;
+	return stack;
+}
+
+static void free_thread_stack(struct task_struct *tsk, bool cache_only)
+{
+	arch_free_thread_stack(tsk);
+}
+
 #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
 /* SLAB cache for signal_struct structures (tsk->signal) */
--=20
2.34.1

