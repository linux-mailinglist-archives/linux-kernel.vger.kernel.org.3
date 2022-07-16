Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B857726F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiGPXTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbiGPXS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EC248ED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:57 -0700 (PDT)
Message-ID: <20220716230954.334016834@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JmwYsQ7+uISrRi4cJKfiAFmtnwD9cDnZcOisEZqN7rE=;
        b=Y4f3yv1tiUXLMSoEhK8pBnTVdnIdbL7FEYKUxVEvtWTWBlk6PvLiuDgpYv5li2Q5SUl/El
        En3rhJME7li1fKebNegETdJ1t8ralugC0iZLVmoxoOptapH/kUSs0vbeaapcvzwho8wTzO
        eS6G/9pFCz27pZpMUKT8CQOZ7VNr6Wwu+4D0h/zBz1ecPgq9gAxZ6ZsuM4Zs5a2TI2XACo
        ZKMWmOqckJZSn3ommbgxvipvSmLVkM852ojZYpJRYUE0r5MHiDpiQW9Yos2s0rW6R9u1d7
        Ma0wSzm6/I9ttuY1heJdFdAhHKyq1BryCAHRILbLahRzxqzZb5yAUwmBPVb8sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=JmwYsQ7+uISrRi4cJKfiAFmtnwD9cDnZcOisEZqN7rE=;
        b=/7uHClugvGXw7OrtFyG2O1NUp0u6sGK1/MVNbnTBen2DIAy/XWb64WktPT4kMNeEOZ9lkU
        XmgpinIDVW2il7CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 28/38] x86/retbleed: Add SKL return thunk
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address the Intel SKL RSB underflow issue in software it's required to
do call depth tracking.

Provide a return thunk for call depth tracking on Intel SKL CPUs.

The tracking does not use a counter. It uses uses arithmetic shift
right on call entry and logical shift left on return.

The depth tracking variable is initialized to 0x8000.... when the call
depth is zero. The arithmetic shift right sign extends the MSB and
saturates after the 12th call. The shift count is 5 so the tracking covers
12 nested calls. On return the variable is shifted left logically so it
becomes zero again.

 CALL	 	   	RET
 0: 0x8000000000000000	0x0000000000000000
 1: 0xfc00000000000000	0xf000000000000000
...
11: 0xfffffffffffffff8	0xfffffffffffffc00
12: 0xffffffffffffffff	0xffffffffffffffe0

After a return buffer fill the depth is credited 12 calls before the next
stuffing has to take place.

There is a inaccuracy for situations like this:

   10 calls
    5 returns
    3 calls
    4 returns
    3 calls
    ....

The shift count might cause this to be off by one in either direction, but
there is still a cushion vs. the RSB depth. The algorithm does not claim to
be perfect, but it should obfuscate the problem enough to make exploitation
extremly difficult.

The theory behind this is:

RSB is a stack with depth 16 which is filled on every call. On the return
path speculation "pops" entries to speculate down the call chain. Once the
speculative RSB is empty it switches to other predictors, e.g. the Branch
History Buffer, which can be mistrained by user space and misguide the
speculation path to a gadget.

Call depth tracking is designed to break this speculation path by stuffing
speculation trap calls into the RSB which are never getting a corresponding
return executed. This stalls the prediction path until it gets resteered,

The assumption is that stuffing at the 12th return is sufficient to break
the speculation before it hits the underflow and the fallback to the other
predictors. Testing confirms that it works. Johannes, one of the retbleed
researchers. tried to attack this approach but failed.

There is obviously no scientific proof that this will withstand future
research progress, but all we can do right now is to speculate about it.

The SAR/SHL usage was suggested by Andi Kleen.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S            |   10 +--
 arch/x86/include/asm/nospec-branch.h |  114 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c         |    5 +
 arch/x86/lib/retpoline.S             |   30 +++++++++
 4 files changed, 149 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -287,6 +287,7 @@ SYM_FUNC_END(__switch_to_asm)
 SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // copy_thread
+	CALL_DEPTH_ACCOUNT
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -331,7 +332,7 @@ SYM_CODE_START(xen_error_entry)
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 	RET
 SYM_CODE_END(xen_error_entry)
 
@@ -975,7 +976,7 @@ SYM_CODE_START(paranoid_entry)
 	 * CR3 above, keep the old value in a callee saved register.
 	 */
 	IBRS_ENTER save_reg=%r15
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	RET
 SYM_CODE_END(paranoid_entry)
@@ -1060,7 +1061,7 @@ SYM_CODE_START(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	/* Put us onto the real thread stack. */
@@ -1095,6 +1096,7 @@ SYM_CODE_START(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	CALL_DEPTH_ACCOUNT
 	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ANNOTATE_UNRET_END
 	RET
@@ -1113,7 +1115,7 @@ SYM_CODE_START(error_entry)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -11,8 +11,53 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
+#include <asm/percpu.h>
 
 #define RETPOLINE_THUNK_SIZE	32
+#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+
+/*
+ * Call depth tracking for Intel SKL CPUs to address the RSB underflow
+ * issue in software.
+ *
+ * The tracking does not use a counter. It uses uses arithmetic shift
+ * right on call entry and logical shift left on return.
+ *
+ * The depth tracking variable is initialized to 0x8000.... when the call
+ * depth is zero. The arithmetic shift right sign extends the MSB and
+ * saturates after the 12th call. The shift count is 5 for both directions
+ * so the tracking covers 12 nested calls.
+ *
+ *  Call
+ *  0: 0x8000000000000000	0x0000000000000000
+ *  1: 0xfc00000000000000	0xf000000000000000
+ * ...
+ * 11: 0xfffffffffffffff8	0xfffffffffffffc00
+ * 12: 0xffffffffffffffff	0xffffffffffffffe0
+ *
+ * After a return buffer fill the depth is credited 12 calls before the
+ * next stuffing has to take place.
+ *
+ * There is a inaccuracy for situations like this:
+ *
+ *  10 calls
+ *   5 returns
+ *   3 calls
+ *   4 returns
+ *   3 calls
+ *   ....
+ *
+ * The shift count might cause this to be off by one in either direction,
+ * but there is still a cushion vs. the RSB depth. The algorithm does not
+ * claim to be perfect and it can be speculated around by the CPU, but it
+ * is considered that it obfuscates the problem enough to make exploitation
+ * extremly difficult.
+ */
+#define RET_DEPTH_SHIFT			5
+#define RSB_RET_STUFF_LOOPS		16
+#define RET_DEPTH_INIT			0x8000000000000000ULL
+#define RET_DEPTH_INIT_FROM_CALL	0xfc00000000000000ULL
+#define RET_DEPTH_CREDIT		0xffffffffffffffffULL
 
 /*
  * Fill the CPU return stack buffer.
@@ -31,7 +76,28 @@
  * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
  */
 
-#define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+#define CREDIT_CALL_DEPTH					\
+	movq	$-1, PER_CPU_VAR(__x86_call_depth);
+
+#define RESET_CALL_DEPTH					\
+	mov	$0x80, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);
+
+#define RESET_CALL_DEPTH_FROM_CALL				\
+	mov	$0xfc, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);
+
+#define INCREMENT_CALL_DEPTH					\
+	sarq	$5, %gs:__x86_call_depth
+#else
+#define CREDIT_CALL_DEPTH
+#define RESET_CALL_DEPTH
+#define INCREMENT_CALL_DEPTH
+#define RESET_CALL_DEPTH_FROM_CALL
+#endif
 
 /*
  * Google experimented with loop-unrolling and this turned out to be
@@ -59,7 +125,9 @@
 774:						\
 	add	$(BITS_PER_LONG/8) * 2, sp;	\
 	dec	reg;				\
-	jnz	771b;
+	jnz	771b;				\
+						\
+	CREDIT_CALL_DEPTH
 
 #ifdef __ASSEMBLY__
 
@@ -145,11 +213,32 @@
  * where we have a stack but before any RET instruction.
  */
 .macro UNTRAIN_RET
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY)
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
 	ANNOTATE_UNRET_END
-	ALTERNATIVE_2 "",						\
-	              CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB
+	ALTERNATIVE_3 "",						\
+		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
+		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
+.macro UNTRAIN_RET_FROM_CALL
+#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_IBPB_ENTRY) || \
+	defined(CONFIG_X86_FEATURE_CALL_DEPTH)
+	ANNOTATE_UNRET_END
+	ALTERNATIVE_3 "",						\
+		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
+		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
+		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
+#endif
+.endm
+
+
+.macro CALL_DEPTH_ACCOUNT
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+	ALTERNATIVE "",							\
+		    __stringify(INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
@@ -174,6 +263,19 @@ extern void (*x86_return_thunk)(void);
 #define x86_return_thunk	(&__x86_return_thunk)
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+extern void __x86_return_skl(void);
+
+static inline void x86_set_skl_return_thunk(void)
+{
+	x86_return_thunk = &__x86_return_skl;
+}
+
+DECLARE_PER_CPU(u64, __x86_call_depth);
+#else
+static inline void x86_set_skl_return_thunk(void) {}
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2002,6 +2002,11 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+DEFINE_PER_CPU(u64, __x86_call_depth);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_call_depth);
+#endif
+
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -8,6 +8,7 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/percpu.h>
 #include <asm/frame.h>
 
 	.section .text.__x86.indirect_thunk
@@ -140,3 +141,32 @@ SYM_FUNC_END(zen_untrain_ret)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+
+	.align 64
+SYM_FUNC_START(__x86_return_skl)
+	ANNOTATE_NOENDBR
+	/* Keep the hotpath in a 16byte I-fetch */
+	shlq	$5, PER_CPU_VAR(__x86_call_depth)
+	jz	1f
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+1:
+	.rept	16
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call	2f
+	int3
+2:
+	.endr
+	add	$(8*16), %rsp
+
+	CREDIT_CALL_DEPTH
+
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_FUNC_END(__x86_return_skl)
+
+#endif /* CONFIG_CALL_DEPTH_TRACKING */

