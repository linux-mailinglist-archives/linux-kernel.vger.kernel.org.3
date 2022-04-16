Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7605033F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiDPE3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiDPE25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0210FDC5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q12so9588669pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0btSP+exSEnJoJwm80JMqbXTxt3SdLF14yl5KtJTWc8=;
        b=Dz9+tCwkww74TeicnNLlq08qOU8uJnd1GOLVlXDqv/o+1B09tEPoV+5OrLqJK8AwFJ
         hO6EFk+RowmFjqFi4IyhFE2UDnjxnNOKQfyh76hcyiELiz4zTteGwIFQ8QkCi65Za7gR
         suqhOExWns/QiEeXj3BEJ4TBZFEZjIgcSL/X3etvm0jPL1D3D4hSmLif7/BzVR/sP/gv
         5hpyCjgTUS3cmTD+LYViWatEfprQ8HRNBGud7xwsuf1K/DRVYzFV6688zx3qoMkUs7oQ
         B1MI8G1IQZWPnqbW74uNy3HCJx+1ZGKiF806DeFh1hQF9AuE1/itKNh+uYtPnHWbSO7a
         jL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0btSP+exSEnJoJwm80JMqbXTxt3SdLF14yl5KtJTWc8=;
        b=DL8YI9e2ufqs5WFeNJy12n6fa8bQBmjw0zL2tz5W/1fqoFAEK09PztWjof/k2bw29w
         buXCCh7MccXJV6nbD8jzoeMi1TcwjiNX2ypojPTJSbc77l+iBmcQGMLk7Iaj/yM4Vag4
         2qNzLC22KWnwCIErrjlw6rRtdmu4CgqbDubPXSNuC2vmQ2bt//5B69XbVRg3M1aGEHvT
         LUCIPtudtkpOP6PBiYf2LGNzPkSWCqoWoyICY2az+hti2Aveks8eG6nmio30rk1KZfy7
         YWFEqMzDIkiPMXkRYIiaWOo9/PnvlYfcZM5LB9HJ48AhlHjSD65uxmJs11thYYF8A3L8
         pixA==
X-Gm-Message-State: AOAM530Tial9aMPQlaGGC53G0QVR1ALFADYvSo9sonUmqH807hoeFGws
        WbnYK1kEyxSDhd0OgA5187Tew9jGMhM=
X-Google-Smtp-Source: ABdhPJxHKlmEu3pOcLG2uWvFqqtwJqU/JEaCkyF51Lx4B2mPmnxxm97BsjoY434nCp8D0qMRx5MIrw==
X-Received: by 2002:a65:53cc:0:b0:382:8506:f1a6 with SMTP id z12-20020a6553cc000000b003828506f1a6mr1708797pgr.44.1650083185271;
        Fri, 15 Apr 2022 21:26:25 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:24 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 6/6] xtensa: support coprocessors on SMP
Date:   Fri, 15 Apr 2022 21:25:59 -0700
Message-Id: <20220416042559.2035015-7-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
coprocessor_flush_release_all to do flush followed by release
efficiently.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/coprocessor.h |  3 +-
 arch/xtensa/include/asm/thread_info.h |  7 ++-
 arch/xtensa/include/asm/traps.h       |  7 +++
 arch/xtensa/kernel/asm-offsets.c      |  8 ++-
 arch/xtensa/kernel/coprocessor.S      | 43 +++++++++++-----
 arch/xtensa/kernel/entry.S            | 17 +++++++
 arch/xtensa/kernel/process.c          | 70 +++++++++++++++++----------
 arch/xtensa/kernel/traps.c            | 13 ++++-
 8 files changed, 125 insertions(+), 43 deletions(-)

diff --git a/arch/xtensa/include/asm/coprocessor.h b/arch/xtensa/include/asm/coprocessor.h
index a360efced7e7..dc53bd015c5f 100644
--- a/arch/xtensa/include/asm/coprocessor.h
+++ b/arch/xtensa/include/asm/coprocessor.h
@@ -142,10 +142,11 @@ typedef struct { XCHAL_CP6_SA_LIST(2) } xtregs_cp6_t
 typedef struct { XCHAL_CP7_SA_LIST(2) } xtregs_cp7_t
 	__attribute__ ((aligned (XCHAL_CP7_SA_ALIGN)));
 
-extern struct thread_info* coprocessor_owner[XCHAL_CP_MAX];
+struct thread_info;
 void coprocessor_flush(struct thread_info *ti, int cp_index);
 void coprocessor_release_all(struct thread_info *ti);
 void coprocessor_flush_all(struct thread_info *ti);
+void coprocessor_flush_release_all(struct thread_info *ti);
 
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
index c9c5f59db420..6b292facf7a7 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -12,6 +12,7 @@
 
 #include <asm/ptrace.h>
 
+struct thread_info;
 /*
  * Per-CPU exception handling data structure.
  * EXCSAVE1 points to it.
@@ -25,6 +26,10 @@ struct exc_table {
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
@@ -33,6 +38,8 @@ struct exc_table {
 	void *default_handler[EXCCAUSE_N];
 };
 
+DECLARE_PER_CPU(struct exc_table, exc_table);
+
 /*
  * handler must be either of the following:
  *  void (*)(struct pt_regs *regs);
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
index 8bcbabbff38a..1e2bfcf9f0cf 100644
--- a/arch/xtensa/kernel/coprocessor.S
+++ b/arch/xtensa/kernel/coprocessor.S
@@ -115,9 +115,32 @@
 
 ENTRY(fast_coprocessor)
 
+	s32i	a3, a2, PT_AREG3
+
+#ifdef CONFIG_SMP
+	/*
+	 * Check if any coprocessor context is live on another CPU
+	 * and if so go through the C-level coprocessor exception handler
+	 * to flush it to memory.
+	 */
+
+	GET_THREAD_INFO (a0, a2)
+	l32i	a3, a0, THREAD_CPENABLE
+	beqz	a3, .Lload_local
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
@@ -150,9 +173,9 @@ ENTRY(fast_coprocessor)
 
 	/* Retrieve previous owner. (a3 still holds CP number) */
 
-	movi	a0, coprocessor_owner	# list of owners
+	rsr	a0, excsave1		# exc_table
 	addx4	a0, a3, a0		# entry for CP
-	l32i	a4, a0, 0
+	l32i	a4, a0, EXC_TABLE_COPROCESSOR_OWNER
 
 	beqz	a4, 1f			# skip 'save' if no previous owner
 
@@ -178,13 +201,15 @@ ENTRY(fast_coprocessor)
 
 	rsr	a3, exccause
 	addi	a3, a3, -EXCCAUSE_COPROCESSOR0_DISABLED
-	movi	a0, coprocessor_owner
+	rsr	a0, excsave1		# exc_table
 	addx4	a0, a3, a0
 
 	/* Set new 'owner' (a0 points to the CP owner, a3 contains the CP nr) */
 
 1:	GET_THREAD_INFO (a4, a1)
-	s32i	a4, a0, 0
+	l32i	a5, a4, THREAD_CPU
+	s32i	a4, a0, EXC_TABLE_COPROCESSOR_OWNER
+	s32i	a5, a4, THREAD_CP_OWNER_CPU
 
 	/* Get context save area and call load routine. */
 
@@ -245,12 +270,4 @@ ENTRY(coprocessor_flush)
 
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
index b9bcb2cd74dd..033443b4ce87 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -2087,9 +2087,26 @@ ENTRY(_switch_to)
 	/* Switch CPENABLE */
 
 #if (XTENSA_HAVE_COPROCESSORS || XTENSA_HAVE_IO_PORTS)
+#ifdef CONFIG_SMP
 	l32i	a3, a5, THREAD_CPENABLE
+	beqz	a3, 1f
+	l32i	a6, a5, THREAD_CP_OWNER_CPU
+	l32i	a7, a5, THREAD_CPU
+	beq	a6, a7, 1f	# load 0 into CPENABLE if current CPU is not the owner
+	movi	a3, 0
+1:
 	xsr	a3, cpenable
+
+	l32i	a6, a4, THREAD_CP_OWNER_CPU
+	l32i	a7, a4, THREAD_CPU
+	bne	a6, a7, 1f	# skip saving CPENABLE if current CPU was not the owner
 	s32i	a3, a4, THREAD_CPENABLE
+1:
+#else
+	l32i	a3, a5, THREAD_CPENABLE
+	xsr	a3, cpenable
+	s32i	a3, a4, THREAD_CPENABLE
+#endif
 #endif
 
 #if XCHAL_HAVE_EXCLUSIVE
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index e8bfbca5f001..a17c37fbd93c 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/regs.h>
 #include <asm/hw_breakpoint.h>
+#include <asm/traps.h>
 
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
@@ -63,52 +64,70 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 #if XTENSA_HAVE_COPROCESSORS
 
-void coprocessor_release_all(struct thread_info *ti)
+static void local_coprocessor_release_all(void *info)
 {
-	unsigned long cpenable;
+	struct thread_info *ti = info;
+	struct thread_info **coprocessor_owner;
 	int i;
 
-	/* Make sure we don't switch tasks during this operation. */
-
-	preempt_disable();
+	coprocessor_owner = this_cpu_ptr(&exc_table)->coprocessor_owner;
 
 	/* Walk through all cp owners and release it for the requested one. */
 
-	cpenable = ti->cpenable;
-
 	for (i = 0; i < XCHAL_CP_MAX; i++) {
-		if (coprocessor_owner[i] == ti) {
-			coprocessor_owner[i] = 0;
-			cpenable &= ~(1 << i);
-		}
+		if (coprocessor_owner[i] == ti)
+			coprocessor_owner[i] = NULL;
 	}
-
-	ti->cpenable = cpenable;
+	ti->cpenable = 0;
 	if (ti == current_thread_info())
 		xtensa_set_sr(0, cpenable);
+}
 
-	preempt_enable();
+void coprocessor_release_all(struct thread_info *ti)
+{
+	if (ti->cpenable)
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_release_all,
+					 ti, true);
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
+
+void coprocessor_flush_all(struct thread_info *ti)
+{
+	if (ti->cpenable)
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_flush_all,
+					 ti, true);
+}
 
-	preempt_enable();
+static void local_coprocessor_flush_release_all(void *info)
+{
+	local_coprocessor_flush_all(info);
+	local_coprocessor_release_all(info);
+}
+
+void coprocessor_flush_release_all(struct thread_info *ti)
+{
+	if (ti->cpenable)
+		smp_call_function_single(ti->cp_owner_cpu,
+					 local_coprocessor_flush_release_all,
+					 ti, true);
 }
 
 #endif
@@ -140,8 +159,7 @@ void flush_thread(void)
 {
 #if XTENSA_HAVE_COPROCESSORS
 	struct thread_info *ti = current_thread_info();
-	coprocessor_flush_all(ti);
-	coprocessor_release_all(ti);
+	coprocessor_flush_release_all(ti);
 #endif
 	flush_ptrace_hw_breakpoint(current);
 }
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index f6855eb92614..9b8a76d4fc05 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -72,6 +72,9 @@ static void do_nmi(struct pt_regs *regs);
 static void do_unaligned_user(struct pt_regs *regs);
 #endif
 static void do_multihit(struct pt_regs *regs);
+#if XTENSA_HAVE_COPROCESSORS
+static void do_coprocessor(struct pt_regs *regs);
+#endif
 static void do_debug(struct pt_regs *regs);
 
 /*
@@ -84,7 +87,8 @@ static void do_debug(struct pt_regs *regs);
 #define USER		0x02
 
 #define COPROCESSOR(x)							\
-{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER, fast_coprocessor }
+{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, USER, fast_coprocessor },	\
+{ EXCCAUSE_COPROCESSOR ## x ## _DISABLED, 0, do_coprocessor }
 
 typedef struct {
 	int cause;
@@ -342,6 +346,13 @@ static void do_unaligned_user(struct pt_regs *regs)
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

