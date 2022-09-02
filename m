Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF125AB3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiIBOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiIBO2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB09D21253
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=X/IUBCmCb5A2KwbDyGB9KbfI8YqN9o2Z0aQEZCxibuA=; b=jrw6PCH0I5uBl7UVpaf716JRxL
        tsQ5J2L24X29M3hhfN5xSI1bP7+htqgeCn9X9w4vCk0fCyH03MSYxoRUbh6ik3aspFuRp6iAkr92y
        xSMVKQ+f38M+sUtyVUT+RurLpxsNDjc1J2xtO8p4v577SPScqj2Ws3H0H413CDkimfBtL5rQTBui1
        ZG2wpdhz94RRIUsoIuj6mSxdADFy0Z9oFoFjzaN6TFu1J06rf+/q6WrXXQPK9pZ6ytmebza+KUGC4
        /Go5lpC/aDn4XzVDs4uo4xx/AMasvclfQgz1oRofT4JdOHl0R81MBEtwcHEJ+KEqP0pwJ2oBjd6XW
        uM5G8JCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-0074UI-Fj; Fri, 02 Sep 2022 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DD3B302D92;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 743862B8EFB58; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130951.336829336@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 48/59] x86/retbleed: Add SKL return thunk
References: <20220902130625.217071627@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S            |   10 +-
 arch/x86/include/asm/current.h       |    3 
 arch/x86/include/asm/nospec-branch.h |  118 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/asm-offsets.c        |    3 
 arch/x86/kvm/svm/vmenter.S           |    1 
 arch/x86/lib/retpoline.S             |   31 +++++++++
 6 files changed, 156 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -288,6 +288,7 @@ SYM_FUNC_END(__switch_to_asm)
 SYM_CODE_START_NOALIGN(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // copy_thread
+	CALL_DEPTH_ACCOUNT
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -332,7 +333,7 @@ SYM_CODE_START(xen_error_entry)
 	UNWIND_HINT_FUNC
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 	RET
 SYM_CODE_END(xen_error_entry)
 
@@ -977,7 +978,7 @@ SYM_CODE_START(paranoid_entry)
 	 * CR3 above, keep the old value in a callee saved register.
 	 */
 	IBRS_ENTER save_reg=%r15
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	RET
 SYM_CODE_END(paranoid_entry)
@@ -1062,7 +1063,7 @@ SYM_CODE_START(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	/* Put us onto the real thread stack. */
@@ -1097,6 +1098,7 @@ SYM_CODE_START(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	CALL_DEPTH_ACCOUNT
 	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ANNOTATE_UNRET_END
 	RET
@@ -1115,7 +1117,7 @@ SYM_CODE_START(error_entry)
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 	IBRS_ENTER
-	UNTRAIN_RET
+	UNTRAIN_RET_FROM_CALL
 
 	/*
 	 * Pretend that the exception came from user mode: set up pt_regs
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -17,6 +17,9 @@ struct pcpu_hot {
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+			u64			call_depth;
+#endif
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
 			u16			softirq_pending;
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -12,8 +12,80 @@
 #include <asm/msr-index.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
+#include <asm/current.h>
 
-#define RETPOLINE_THUNK_SIZE	32
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
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+#define CREDIT_CALL_DEPTH					\
+	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define ASM_CREDIT_CALL_DEPTH					\
+	movq	$-1, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define RESET_CALL_DEPTH					\
+	mov	$0x80, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define RESET_CALL_DEPTH_FROM_CALL				\
+	mov	$0xfc, %rax;					\
+	shl	$56, %rax;					\
+	movq	%rax, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#define INCREMENT_CALL_DEPTH					\
+	sarq	$5, %gs:pcpu_hot + X86_call_depth;
+
+#define ASM_INCREMENT_CALL_DEPTH				\
+	sarq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth);
+
+#else
+#define CREDIT_CALL_DEPTH
+#define RESET_CALL_DEPTH
+#define INCREMENT_CALL_DEPTH
+#define RESET_CALL_DEPTH_FROM_CALL
+#endif
 
 /*
  * Fill the CPU return stack buffer.
@@ -32,6 +104,7 @@
  * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
  */
 
+#define RETPOLINE_THUNK_SIZE	32
 #define RSB_CLEAR_LOOPS		32	/* To forcibly overwrite all entries */
 
 /*
@@ -60,7 +133,8 @@
 	dec	reg;					\
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
-	lfence;
+	lfence;						\
+	ASM_CREDIT_CALL_DEPTH
 #else
 /*
  * i386 doesn't unconditionally have LFENCE, as such it can't
@@ -185,11 +259,32 @@
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
+		    __stringify(ASM_INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
@@ -214,6 +309,17 @@ extern void (*x86_return_thunk)(void);
 #define x86_return_thunk	(&__x86_return_thunk)
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+extern void __x86_return_skl(void);
+
+static inline void x86_set_skl_return_thunk(void)
+{
+	x86_return_thunk = &__x86_return_skl;
+}
+#else
+static inline void x86_set_skl_return_thunk(void) {}
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -110,6 +110,9 @@ static void __used common(void)
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+	OFFSET(X86_call_depth, pcpu_hot, call_depth);
+#endif
 
 	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
 		BLANK();
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -5,9 +5,11 @@
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <asm/asm-offsets.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/percpu.h>
 #include <asm/frame.h>
 
 	.section .text.__x86.indirect_thunk
@@ -140,3 +142,32 @@ SYM_FUNC_END(zen_untrain_ret)
 EXPORT_SYMBOL(__x86_return_thunk)
 
 #endif /* CONFIG_RETHUNK */
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+
+	.align 64
+SYM_FUNC_START(__x86_return_skl)
+	ANNOTATE_NOENDBR
+	/* Keep the hotpath in a 16byte I-fetch */
+	shlq	$5, PER_CPU_VAR(pcpu_hot + X86_call_depth)
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


