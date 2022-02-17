Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD54B9D16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiBQKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:24:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbiBQKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D267B279088;
        Thu, 17 Feb 2022 02:24:12 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645093451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N2u0jEiOBJ6wA9k02f9xsIuHCuLjYtxcfKJUOlNMLQ=;
        b=H0EKjk7I/SZP8KecVeRo8F34dE26bMiGuqMRhhNn2faGqFl9i0TwohmIh1RB/vnOmdkZKZ
        ROY3XT9G1a42F0mKD7iTeFlgmmMfsea3JJQBL7oM9u9hNnRCoHyXlFzA1MtOksKChenIbL
        sDhe0eY99uw83YGpHomRFj6nU7PjwaYS/y5x+Qi6j1wdmNDPSt+2occBZ/Ts2CW1dlgi7E
        9pputWC5iMWxBiUGbygfkzzlKFCNcSbCiiSkzcep59udDEzQSWVHkoYvaaKGQbNiyiAy0l
        HNF6i96r9kweUnYCmKCNwqHtwtSLhGTJ3dQC52R+oGz8V0xLDrQawhHLD4cdag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645093451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N2u0jEiOBJ6wA9k02f9xsIuHCuLjYtxcfKJUOlNMLQ=;
        b=KBpF/ASSmzKE2Tt+Yfj+cGQipTlGHBBUnCt8T+3yweP6Vg+EhGR6tF4wC5hP41n9E1ANh0
        tO+9oZNalGNGEmBg==
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
Subject: [PATCH v2 3/8] kernel/fork, IA64: Provide a alloc_thread_stack_node() for IA64.
Date:   Thu, 17 Feb 2022 11:24:01 +0100
Message-Id: <20220217102406.3697941-4-bigeasy@linutronix.de>
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
 kernel/fork.c                       | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

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
index c47dcba5d66d2..a6697215fe663 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -330,6 +330,23 @@ void thread_stack_cache_init(void)
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
+static void free_thread_stack(struct task_struct *tsk)
+{
+	arch_free_thread_stack(tsk);
+	tsk->stack =3D NULL;
+}
+
 #endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
 /* SLAB cache for signal_struct structures (tsk->signal) */
--=20
2.34.1

