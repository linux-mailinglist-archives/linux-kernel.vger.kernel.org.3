Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B4509D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388196AbiDUKOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388148AbiDUKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33041A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x1so4585114pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTfshzxRTEMLQRI/J9G1hMPuN37PhOfpR9h2SvwiA7U=;
        b=fSR+WpWR2pxnicfYIxtyhNCG+5HgYKNAkxNjVaLnUpu1lHUYS20kIsk0iEGaw1VDvU
         H9YAPpGbuxt+0rJzq1wZXn0BzwrxOBChbpgD+ljl95c9/CN5DJjKEAqD+UNG5InjGyx2
         Kri2akuAxVKU9kL+BkjqE0jLOzugXLZ3xhUdUQI6RiJnLot0eGQc1lxGfoh12/dA7BQW
         te/PNEBLhTkUIEAHiJ7dhA9sn2q+gbmpcHXEbhqQ17oY6aCsJSW+HaSczMCCCfBRqRX8
         EuYNGxSoS6O+wWRdwqmrN7TEHRHR3N1MdkB00BzWausdEMlmvgwh/xDxqk5+Zv/B7TRM
         ZaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTfshzxRTEMLQRI/J9G1hMPuN37PhOfpR9h2SvwiA7U=;
        b=1IvQmCv+PS//PeMuUWHPfTGKVC88LQBDJfL9+JGSMY58USh+kC8eN4b1Qn8mfxRx1h
         uqmLkaCXpZkXVMYKxiFoxTSVxBRUaLLvjtJur0/E35/eZlF0JIovVDrKcICXXMY2AwOA
         vm0YDezwuRj8vWhBaXsaVbT3z40tOgrZTWf66w6knwAxgdAKcknWoBYAdqH/8wtvOMdX
         J58LOJHkLnMEUdfqk1mz74erDwuywCk1WS7i2vwAbNJGf9vIpfMZwoJsGUmcACZ+mNF3
         BSv0+07uaPZUAMY8ja7GGKf+NHGfUgIc7oMl9t6FYy/SIEleQAeS0WrhF34djayjJHM/
         yJJw==
X-Gm-Message-State: AOAM533qN0sQCfThLJvfdvmPjI9X7QIOlaTnlD0bbopb9vyD0RZ7cGyd
        vKymI/BLaQ6FlWHMMoph1QM=
X-Google-Smtp-Source: ABdhPJxPOBfaSmTnfbIRkPCPXCFoT7pTrMdW2VLdXuy4w8kdYZVClGWS715Mpos24ZgSEgg00HqVRA==
X-Received: by 2002:a63:1114:0:b0:3aa:30b3:dd5f with SMTP id g20-20020a631114000000b003aa30b3dd5fmr12072366pgl.222.1650535869284;
        Thu, 21 Apr 2022 03:11:09 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:11:08 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 10/10] xtensa: support coprocessors on SMP
Date:   Thu, 21 Apr 2022 03:10:33 -0700
Message-Id: <20220421101033.216394-11-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current coprocessor support on xtensa only works correctly on
uniprocessor configurations. Make it work on SMP too and keep it lazy.

Make coprocessor_owner array per-CPU and move it to struct exc_table for
easy access from the fast_coprocessor exception handler. Allow task to
have live coprocessors only on single CPU, record this CPU number in the
struct thread_info::cp_owner_cpu. Change struct thread_info::cpenable
meaning to be 'coprocessors live on cp_owner_cpu'.
Introduce C-level coprocessor exception handler that flushes and
releases live coprocessors of the task taking 'coprocessor disabled'
exception and call it from the fast_coprocessor handler when the task
has live coprocessors on other CPU.
Make coprocessor_flush_all and coprocessor_release_all work correctly
when called from any CPU by sending IPI to the cp_owner_cpu. Add
function coprocessor_flush_release_all to do flush followed by release
atomically. Add function local_coprocessors_flush_release_all to flush
and release all coprocessors on the local CPU and use it to flush
coprocessor contexts from the CPU that goes offline.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- document rules for coprocessor context management
- clean up context management from the LKMM point of view, introduce
  and document barriers
- support CPU hotplug

 arch/xtensa/include/asm/coprocessor.h |   4 +-
 arch/xtensa/include/asm/thread_info.h |   7 +-
 arch/xtensa/include/asm/traps.h       |   6 ++
 arch/xtensa/kernel/asm-offsets.c      |   8 +-
 arch/xtensa/kernel/coprocessor.S      | 122 +++++++++++++++++++-------
 arch/xtensa/kernel/entry.S            |  12 ++-
 arch/xtensa/kernel/process.c          | 112 +++++++++++++++++------
 arch/xtensa/kernel/ptrace.c           |   3 +-
 arch/xtensa/kernel/signal.c           |   3 +-
 arch/xtensa/kernel/smp.c              |   7 ++
 arch/xtensa/kernel/traps.c            |  13 ++-
 11 files changed, 230 insertions(+), 67 deletions(-)

diff --git a/arch/xtensa/include/asm/coprocessor.h b/arch/xtensa/include/asm/coprocessor.h
index a360efced7e7..3b1a0d5d2169 100644
--- a/arch/xtensa/include/asm/coprocessor.h
+++ b/arch/xtensa/include/asm/coprocessor.h
@@ -142,10 +142,12 @@ typedef struct { XCHAL_CP6_SA_LIST(2) } xtregs_cp6_t
 typedef struct { XCHAL_CP7_SA_LIST(2) } xtregs_cp7_t
 	__attribute__ ((aligned (XCHAL_CP7_SA_ALIGN)));
 
-extern struct thread_info* coprocessor_owner[XCHAL_CP_MAX];
+struct thread_info;
 void coprocessor_flush(struct thread_info *ti, int cp_index);
 void coprocessor_release_all(struct thread_info *ti);
 void coprocessor_flush_all(struct thread_info *ti);
+void coprocessor_flush_release_all(struct thread_info *ti);
+void local_coprocessors_flush_release_all(void);
 
 #endif	/* XTENSA_HAVE_COPROCESSORS */
 
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index f6fcbba1d02f..52974317a6b6 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -52,12 +52,17 @@ struct thread_info {
 	__u32			cpu;		/* current CPU */
 	__s32			preempt_count;	/* 0 => preemptable,< 0 => BUG*/
 
-	unsigned long		cpenable;
 #if XCHAL_HAVE_EXCLUSIVE
 	/* result of the most recent exclusive store */
 	unsigned long		atomctl8;
 #endif
 
+	/*
+	 * If i-th bit is set then coprocessor state is loaded into the
+	 * coprocessor i on CPU cp_owner_cpu.
+	 */
+	unsigned long		cpenable;
+	u32			cp_owner_cpu;
 	/* Allocate storage for extra user states and coprocessor states. */
 #if XTENSA_HAVE_COPROCESSORS
 	xtregs_coprocessor_t	xtregs_cp;
diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index 514376eff58c..6f74ccc0c7ea 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -27,6 +27,10 @@ struct exc_table {
 	void *fixup;
 	/* For passing a parameter to fixup */
 	void *fixup_param;
+#if XTENSA_HAVE_COPROCESSORS
+	/* Pointers to owner struct thread_info */
+	struct thread_info *coprocessor_owner[XCHAL_CP_MAX];
+#endif
 	/* Fast user exception handlers */
 	void *fast_user_handler[EXCCAUSE_N];
 	/* Fast kernel exception handlers */
@@ -35,6 +39,8 @@ struct exc_table {
 	xtensa_exception_handler *default_handler[EXCCAUSE_N];
 };
 
+DECLARE_PER_CPU(struct exc_table, exc_table);
+
 xtensa_exception_handler *
 __init trap_set_handler(int cause, xtensa_exception_handler *handler);
 
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index 37278e2785fb..e3b9cf4c2289 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -91,10 +91,12 @@ int main(void)
 	/* struct thread_info (offset from start_struct) */
 	DEFINE(THREAD_RA, offsetof (struct task_struct, thread.ra));
 	DEFINE(THREAD_SP, offsetof (struct task_struct, thread.sp));
-	DEFINE(THREAD_CPENABLE, offsetof (struct thread_info, cpenable));
 #if XCHAL_HAVE_EXCLUSIVE
 	DEFINE(THREAD_ATOMCTL8, offsetof (struct thread_info, atomctl8));
 #endif
+	DEFINE(THREAD_CPENABLE, offsetof(struct thread_info, cpenable));
+	DEFINE(THREAD_CPU, offsetof(struct thread_info, cpu));
+	DEFINE(THREAD_CP_OWNER_CPU, offsetof(struct thread_info, cp_owner_cpu));
 #if XTENSA_HAVE_COPROCESSORS
 	DEFINE(THREAD_XTREGS_CP0, offsetof(struct thread_info, xtregs_cp.cp0));
 	DEFINE(THREAD_XTREGS_CP1, offsetof(struct thread_info, xtregs_cp.cp1));
@@ -137,6 +139,10 @@ int main(void)
 	DEFINE(EXC_TABLE_DOUBLE_SAVE, offsetof(struct exc_table, double_save));
 	DEFINE(EXC_TABLE_FIXUP, offsetof(struct exc_table, fixup));
 	DEFINE(EXC_TABLE_PARAM, offsetof(struct exc_table, fixup_param));
+#if XTENSA_HAVE_COPROCESSORS
+	DEFINE(EXC_TABLE_COPROCESSOR_OWNER,
+	       offsetof(struct exc_table, coprocessor_owner));
+#endif
 	DEFINE(EXC_TABLE_FAST_USER,
 	       offsetof(struct exc_table, fast_user_handler));
 	DEFINE(EXC_TABLE_FAST_KERNEL,
diff --git a/arch/xtensa/kernel/coprocessor.S b/arch/xtensa/kernel/coprocessor.S
index 95412409c49e..ef33e76e07d8 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -19,6 +19,26 @@
 #include <asm/current.h>
 #include <asm/regs.h>
 
+/*
+ * Rules for coprocessor state manipulation on SMP:
+ *
+ * - a task may have live coprocessors only on one CPU.
+ *
+ * - whether coprocessor context of task T is live on some CPU is
+ *   denoted by T's thread_info->cpenable.
+ *
+ * - non-zero thread_info->cpenable means that thread_info->cp_owner_cpu
+ *   is valid in the T's thread_info. Zero thread_info->cpenable means that
+ *   coprocessor context is valid in the T's thread_info.
+ *
+ * - if a coprocessor context of task T is live on CPU X, only CPU X changes
+ *   T's thread_info->cpenable, cp_owner_cpu and coprocessor save area.
+ *   This is done by making sure that for the task T with live coprocessor
+ *   on CPU X cpenable SR is 0 when T runs on any other CPU Y.
+ *   When fast_coprocessor exception is taken on CPU Y it goes to the
+ *   C-level do_coprocessor that uses IPI to make CPU X flush T's coprocessors.
+ */
+
 #if XTENSA_HAVE_COPROCESSORS
 
 /*
@@ -101,9 +121,37 @@
 
 ENTRY(fast_coprocessor)
 
+	s32i	a3, a2, PT_AREG3
+
+#ifdef CONFIG_SMP
+	/*
+	 * Check if any coprocessor context is live on another CPU
+	 * and if so go through the C-level coprocessor exception handler
+	 * to flush it to memory.
+	 */
+	GET_THREAD_INFO (a0, a2)
+	l32i	a3, a0, THREAD_CPENABLE
+	beqz	a3, .Lload_local
+
+	/*
+	 * Pairs with smp_wmb in local_coprocessor_release_all
+	 * and with both memws below.
+	 */
+	memw
+	l32i	a3, a0, THREAD_CPU
+	l32i	a0, a0, THREAD_CP_OWNER_CPU
+	beq	a0, a3, .Lload_local
+
+	rsr	a0, ps
+	l32i	a3, a2, PT_AREG3
+	bbci.l	a0, PS_UM_BIT, 1f
+	call0	user_exception
+1:	call0	kernel_exception
+#endif
+
 	/* Save remaining registers a1-a3 and SAR */
 
-	s32i	a3, a2, PT_AREG3
+.Lload_local:
 	rsr	a3, sar
 	s32i	a1, a2, PT_AREG1
 	s32i	a3, a2, PT_SAR
@@ -117,6 +165,9 @@ ENTRY(fast_coprocessor)
 	s32i	a5, a1, PT_AREG5
 	s32i	a6, a1, PT_AREG6
 	s32i	a7, a1, PT_AREG7
+	s32i	a8, a1, PT_AREG8
+	s32i	a9, a1, PT_AREG9
+	s32i	a10, a1, PT_AREG10
 
 	/* Find coprocessor number. Subtract first CP EXCCAUSE from EXCCAUSE */
 
@@ -139,51 +190,66 @@ ENTRY(fast_coprocessor)
 	addx8	a7, a3, a7
 	addx4	a7, a3, a7
 
-	/* Retrieve previous owner. (a3 still holds CP number) */
+	/* Retrieve previous owner (a8). */
 
-	movi	a0, coprocessor_owner	# list of owners
+	rsr	a0, excsave1		# exc_table
 	addx4	a0, a3, a0		# entry for CP
-	l32i	a4, a0, 0
+	l32i	a8, a0, EXC_TABLE_COPROCESSOR_OWNER
 
-	beqz	a4, 1f			# skip 'save' if no previous owner
+	/* Set new owner (a9). */
 
-	/* Disable coprocessor for previous owner. (a2 = 1 << CP number) */
+	GET_THREAD_INFO (a9, a1)
+	l32i	a4, a9, THREAD_CPU
+	s32i	a9, a0, EXC_TABLE_COPROCESSOR_OWNER
+	s32i	a4, a9, THREAD_CP_OWNER_CPU
 
-	l32i	a5, a4, THREAD_CPENABLE
-	xor	a5, a5, a2		# (1 << cp-id) still in a2
-	s32i	a5, a4, THREAD_CPENABLE
+	/*
+	 * Enable coprocessor for the new owner. (a2 = 1 << CP number)
+	 * This can be done before loading context into the coprocessor.
+	 */
+	l32i	a4, a9, THREAD_CPENABLE
+	or	a4, a4, a2
 
 	/*
-	 * Get context save area and call save routine.
-	 * (a4 still holds previous owner (thread_info), a3 CP number)
+	 * Make sure THREAD_CP_OWNER_CPU is in memory before updating
+	 * THREAD_CPENABLE
 	 */
+	memw				# (2)
+	s32i	a4, a9, THREAD_CPENABLE
 
-	l32i	a2, a7, CP_REGS_TAB_OFFSET
-	l32i	a3, a7, CP_REGS_TAB_SAVE
-	add	a2, a2, a4
-	callx0	a3
+	beqz	a8, 1f			# skip 'save' if no previous owner
 
-	/* Note that only a0 and a1 were preserved. */
+	/* Disable coprocessor for previous owner. (a2 = 1 << CP number) */
 
-	rsr	a3, exccause
-	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
-	movi	a0, coprocessor_owner
-	addx4	a0, a3, a0
+	l32i	a10, a8, THREAD_CPENABLE
+	xor	a10, a10, a2
 
-	/* Set new 'owner' (a0 points to the CP owner, a3 contains the CP nr) */
+	/* Get context save area and call save routine. */
 
-1:	GET_THREAD_INFO (a4, a1)
-	s32i	a4, a0, 0
+	l32i	a2, a7, CP_REGS_TAB_OFFSET
+	l32i	a3, a7, CP_REGS_TAB_SAVE
+	add	a2, a2, a8
+	callx0	a3
 
+	/*
+	 * Make sure coprocessor context and THREAD_CP_OWNER_CPU are in memory
+	 * before updating THREAD_CPENABLE
+	 */
+	memw				# (3)
+	s32i	a10, a8, THREAD_CPENABLE
+1:
 	/* Get context save area and call load routine. */
 
 	l32i	a2, a7, CP_REGS_TAB_OFFSET
 	l32i	a3, a7, CP_REGS_TAB_LOAD
-	add	a2, a2, a4
+	add	a2, a2, a9
 	callx0	a3
 
 	/* Restore all registers and return from exception handler. */
 
+	l32i	a10, a1, PT_AREG10
+	l32i	a9, a1, PT_AREG9
+	l32i	a8, a1, PT_AREG8
 	l32i	a7, a1, PT_AREG7
 	l32i	a6, a1, PT_AREG6
 	l32i	a5, a1, PT_AREG5
@@ -233,12 +299,4 @@ ENTRY(coprocessor_flush)
 
 ENDPROC(coprocessor_flush)
 
-	.data
-
-ENTRY(coprocessor_owner)
-
-	.fill XCHAL_CP_MAX, 4, 0
-
-END(coprocessor_owner)
-
 #endif /* XTENSA_HAVE_COPROCESSORS */
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index f2c789a5a92a..3255d4f61844 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -2071,8 +2071,16 @@ ENTRY(_switch_to)
 
 #if (XTENSA_HAVE_COPROCESSORS || XTENSA_HAVE_IO_PORTS)
 	l32i	a3, a5, THREAD_CPENABLE
-	xsr	a3, cpenable
-	s32i	a3, a4, THREAD_CPENABLE
+#ifdef CONFIG_SMP
+	beqz	a3, 1f
+	memw			# pairs with memw (2) in fast_coprocessor
+	l32i	a6, a5, THREAD_CP_OWNER_CPU
+	l32i	a7, a5, THREAD_CPU
+	beq	a6, a7, 1f	# load 0 into CPENABLE if current CPU is not the owner
+	movi	a3, 0
+1:
+#endif
+	wsr	a3, cpenable
 #endif
 
 #if XCHAL_HAVE_EXCLUSIVE
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index e8bfbca5f001..7e38292dd07a 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/traps.h>
 
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
@@ -63,52 +64,114 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 #if XTENSA_HAVE_COPROCESSORS
 
-void coprocessor_release_all(struct thread_info *ti)
+void local_coprocessors_flush_release_all(void)
 {
-	unsigned long cpenable;
-	int i;
+	struct thread_info **coprocessor_owner;
+	struct thread_info *unique_owner[XCHAL_CP_MAX];
+	int n = 0;
+	int i, j;
 
-	/* Make sure we don't switch tasks during this operation. */
+	coprocessor_owner = this_cpu_ptr(&exc_table)->coprocessor_owner;
+	xtensa_set_sr(XCHAL_CP_MASK, cpenable);
 
-	preempt_disable();
+	for (i = 0; i < XCHAL_CP_MAX; i++) {
+		struct thread_info *ti = coprocessor_owner[i];
 
-	/* Walk through all cp owners and release it for the requested one. */
+		if (ti) {
+			coprocessor_flush(ti, i);
 
-	cpenable = ti->cpenable;
+			for (j = 0; j < n; j++)
+				if (unique_owner[j] == ti)
+					break;
+			if (j == n)
+				unique_owner[n++] = ti;
 
-	for (i = 0; i < XCHAL_CP_MAX; i++) {
-		if (coprocessor_owner[i] == ti) {
-			coprocessor_owner[i] = 0;
-			cpenable &= ~(1 << i);
+			coprocessor_owner[i] = NULL;
 		}
 	}
+	for (i = 0; i < n; i++) {
+		/* pairs with memw (1) in fast_coprocessor and memw in switch_to */
+		smp_wmb();
+		unique_owner[i]->cpenable = 0;
+	}
+	xtensa_set_sr(0, cpenable);
+}
 
-	ti->cpenable = cpenable;
+static void local_coprocessor_release_all(void *info)
+{
+	struct thread_info *ti = info;
+	struct thread_info **coprocessor_owner;
+	int i;
+
+	coprocessor_owner = this_cpu_ptr(&exc_table)->coprocessor_owner;
+
+	/* Walk through all cp owners and release it for the requested one. */
+
+	for (i = 0; i < XCHAL_CP_MAX; i++) {
+		if (coprocessor_owner[i] == ti)
+			coprocessor_owner[i] = NULL;
+	}
+	/* pairs with memw (1) in fast_coprocessor and memw in switch_to */
+	smp_wmb();
+	ti->cpenable = 0;
 	if (ti == current_thread_info())
 		xtensa_set_sr(0, cpenable);
+}
 
-	preempt_enable();
+void coprocessor_release_all(struct thread_info *ti)
+{
+	if (ti->cpenable) {
+		/* pairs with memw (2) in fast_coprocessor */
+		smp_rmb();
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_release_all,
+					 ti, true);
+	}
 }
 
-void coprocessor_flush_all(struct thread_info *ti)
+static void local_coprocessor_flush_all(void *info)
 {
-	unsigned long cpenable, old_cpenable;
+	struct thread_info *ti = info;
+	struct thread_info **coprocessor_owner;
+	unsigned long old_cpenable;
 	int i;
 
-	preempt_disable();
-
-	old_cpenable = xtensa_get_sr(cpenable);
-	cpenable = ti->cpenable;
-	xtensa_set_sr(cpenable, cpenable);
+	coprocessor_owner = this_cpu_ptr(&exc_table)->coprocessor_owner;
+	old_cpenable = xtensa_xsr(ti->cpenable, cpenable);
 
 	for (i = 0; i < XCHAL_CP_MAX; i++) {
-		if ((cpenable & 1) != 0 && coprocessor_owner[i] == ti)
+		if (coprocessor_owner[i] == ti)
 			coprocessor_flush(ti, i);
-		cpenable >>= 1;
 	}
 	xtensa_set_sr(old_cpenable, cpenable);
+}
 
-	preempt_enable();
+void coprocessor_flush_all(struct thread_info *ti)
+{
+	if (ti->cpenable) {
+		/* pairs with memw (2) in fast_coprocessor */
+		smp_rmb();
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_flush_all,
+					 ti, true);
+	}
+}
+
+static void local_coprocessor_flush_release_all(void *info)
+{
+	local_coprocessor_flush_all(info);
+	local_coprocessor_release_all(info);
+}
+
+void coprocessor_flush_release_all(struct thread_info *ti)
+{
+	if (ti->cpenable) {
+		/* pairs with memw (2) in fast_coprocessor */
+		smp_rmb();
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_flush_release_all,
+					 ti, true);
+	}
 }
 
 #endif
@@ -140,8 +203,7 @@ void flush_thread(void)
 {
 #if XTENSA_HAVE_COPROCESSORS
 	struct thread_info *ti = current_thread_info();
-	coprocessor_flush_all(ti);
-	coprocessor_release_all(ti);
+	coprocessor_flush_release_all(ti);
 #endif
 	flush_ptrace_hw_breakpoint(current);
 }
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index 323c678a691f..22cdaa6729d3 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -171,8 +171,7 @@ static int tie_set(struct task_struct *target,
 
 #if XTENSA_HAVE_COPROCESSORS
 	/* Flush all coprocessors before we overwrite them. */
-	coprocessor_flush_all(ti);
-	coprocessor_release_all(ti);
+	coprocessor_flush_release_all(ti);
 	ti->xtregs_cp.cp0 = newregs->cp0;
 	ti->xtregs_cp.cp1 = newregs->cp1;
 	ti->xtregs_cp.cp2 = newregs->cp2;
diff --git a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
index 6f68649e86ba..c9ffd42db873 100644
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -162,8 +162,7 @@ setup_sigcontext(struct rt_sigframe __user *frame, struct pt_regs *regs)
 		return err;
 
 #if XTENSA_HAVE_COPROCESSORS
-	coprocessor_flush_all(ti);
-	coprocessor_release_all(ti);
+	coprocessor_flush_release_all(ti);
 	err |= __copy_to_user(&frame->xtregs.cp, &ti->xtregs_cp,
 			      sizeof (frame->xtregs.cp));
 #endif
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index ed7c188ebedc..e861ce76ad38 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -30,6 +30,7 @@
 #include <linux/thread_info.h>
 
 #include <asm/cacheflush.h>
+#include <asm/coprocessor.h>
 #include <asm/kdebug.h>
 #include <asm/mmu_context.h>
 #include <asm/mxregs.h>
@@ -273,6 +274,12 @@ int __cpu_disable(void)
 	 */
 	set_cpu_online(cpu, false);
 
+#if XTENSA_HAVE_COPROCESSORS
+	/*
+	 * Flush coprocessor contexts that are active on the current CPU.
+	 */
+	local_coprocessors_flush_release_all();
+#endif
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 62c497605128..138a86fbe9d7 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -57,6 +57,9 @@ static void do_nmi(struct pt_regs *regs);
 static void do_unaligned_user(struct pt_regs *regs);
 #endif
 static void do_multihit(struct pt_regs *regs);
+#if XTENSA_HAVE_COPROCESSORS
+static void do_coprocessor(struct pt_regs *regs);
+#endif
 static void do_debug(struct pt_regs *regs);
 
 /*
@@ -69,7 +72,8 @@ static void do_debug(struct pt_regs *regs);
 #define USER		0x02
 
 #define COPROCESSOR(x)							\
-{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER|KRNL, fast_coprocessor }
+{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER|KRNL, fast_coprocessor },\
+{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, 0, do_coprocessor }
 
 typedef struct {
 	int cause;
@@ -327,6 +331,13 @@ static void do_unaligned_user(struct pt_regs *regs)
 }
 #endif
 
+#if XTENSA_HAVE_COPROCESSORS
+static void do_coprocessor(struct pt_regs *regs)
+{
+	coprocessor_flush_release_all(current_thread_info());
+}
+#endif
+
 /* Handle debug events.
  * When CONFIG_HAVE_HW_BREAKPOINT is on this handler is called with
  * preemption disabled to avoid rescheduling and keep mapping of hardware
-- 
2.30.2

