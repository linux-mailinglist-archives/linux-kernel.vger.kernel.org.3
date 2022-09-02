Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2D5AB3A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiIBOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiIBO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054EBEA156
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kMUuDcFUgc9UaxyV3UbtUWkODc8RvW8xK23tMclc5FI=; b=laeXU9GZSyDuEsTQrxT4bU8vdF
        8Pde8yYiX75aOVnSJKhrMMW0L/w4FJ0xdPRXK+TQdy4P5X75/AlSrsuaFfJChzEAJP2fyUNIVVSMX
        rCoXOtrwtk/SVOoUMHVbT+6RSAB6YwR/yE6GaB1soZ4Zn2xguy0u3zB4JKDiKIYbOrAgddAX4ZZ9X
        0UfLM7tZyLHSJIQryrUAE90yV/+KqH6D1KxAFU1QrEnl32TzCZ4Jq1uPSaXxpu1Rkrrsz7jAENJqw
        exHUYDoQrtD+WdrjArABk2Skb3Zr4+w7gNvxqyFVvHmhfkUBaEvjQx6a97iqNsUkIk1sOpcfk2yux
        dB9SWh3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-0074UH-Fl; Fri, 02 Sep 2022 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E000302D9D;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7D8652B8EFB55; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130951.440125229@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:14 +0200
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
Subject: [PATCH v2 49/59] x86/retpoline: Add SKL retthunk retpolines
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

From: Peter Zijlstra <peterz@infradead.org>

Ensure that retpolines do the proper call accounting so that the return
accounting works correctly.

Specifically; retpolines are used to replace both 'jmp *%reg' and
'call *%reg', however these two cases do not have the same accounting
requirements. Therefore split things up and provide two different
retpoline arrays for SKL.

The 'jmp *%reg' case needs no accounting, the
__x86_indirect_jump_thunk_array[] covers this. The retpoline is
changed to not use the return thunk; it's a simple call;ret construct.

[ strictly speaking it should do:
	andq $(~0x1f), PER_CPU_VAR(__x86_call_depth)
  but we can argue this can be covered by the fuzz we already have
  in the accounting depth (12) vs the RSB depth (16) ]

The 'call *%reg' case does need accounting, the
__x86_indirect_call_thunk_array[] covers this. Again, this retpoline
avoids the use of the return-thunk, in this case to avoid double
accounting.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |   12 +++++
 arch/x86/kernel/alternative.c        |   59 +++++++++++++++++++++++++++--
 arch/x86/lib/retpoline.S             |   71 +++++++++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c          |    5 +-
 4 files changed, 135 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -288,6 +288,8 @@
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
@@ -317,6 +319,16 @@ static inline void x86_set_skl_return_th
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+#define GEN(reg)						\
+	extern retpoline_thunk_t __x86_indirect_call_thunk_ ## reg;
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+#define GEN(reg)						\
+	extern retpoline_thunk_t __x86_indirect_jump_thunk_ ## reg;
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
 #ifdef CONFIG_X86_64
 
 /*
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -377,6 +377,56 @@ static int emit_indirect(int op, int reg
 	return i;
 }
 
+static inline bool is_jcc32(struct insn *insn)
+{
+	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
+	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
+}
+
+static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	u8 op = insn->opcode.bytes[0];
+	int i = 0;
+
+	/*
+	 * Clang does 'weird' Jcc __x86_indirect_thunk_r11 conditional
+	 * tail-calls. Deal with them.
+	 */
+	if (is_jcc32(insn)) {
+		bytes[i++] = op;
+		op = insn->opcode.bytes[1];
+		goto clang_jcc;
+	}
+
+	if (insn->length == 6)
+		bytes[i++] = 0x2e; /* CS-prefix */
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		__text_gen_insn(bytes+i, op, addr+i,
+				__x86_indirect_call_thunk_array[reg],
+				CALL_INSN_SIZE);
+		i += CALL_INSN_SIZE;
+		break;
+
+	case JMP32_INSN_OPCODE:
+clang_jcc:
+		__text_gen_insn(bytes+i, op, addr+i,
+				__x86_indirect_jump_thunk_array[reg],
+				JMP32_INSN_SIZE);
+		i += JMP32_INSN_SIZE;
+		break;
+
+	default:
+		WARN("%pS %px %*ph\n", addr, addr, 6, addr);
+		return -1;
+	}
+
+	WARN_ON_ONCE(i != insn->length);
+
+	return i;
+}
+
 /*
  * Rewrite the compiler generated retpoline thunk calls.
  *
@@ -409,8 +459,12 @@ static int patch_retpoline(void *addr, s
 	BUG_ON(reg == 4);
 
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE))
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+			return emit_call_track_retpoline(addr, insn, reg, bytes);
+
 		return -1;
+	}
 
 	op = insn->opcode.bytes[0];
 
@@ -427,8 +481,7 @@ static int patch_retpoline(void *addr, s
 	 *   [ NOP ]
 	 * 1:
 	 */
-	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
-	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
+	if (is_jcc32(insn)) {
 		cc = insn->opcode.bytes[1] & 0xf;
 		cc ^= 1; /* invert condition */
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -14,17 +14,18 @@
 
 	.section .text.__x86.indirect_thunk
 
-.macro RETPOLINE reg
+
+.macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call    .Ldo_rop_\@
-.Lspec_trap_\@:
-	UNWIND_HINT_EMPTY
-	pause
-	lfence
-	jmp .Lspec_trap_\@
+	int3
 .Ldo_rop_\@:
 	mov     %\reg, (%_ASM_SP)
 	UNWIND_HINT_FUNC
+.endm
+
+.macro RETPOLINE reg
+	POLINE \reg
 	RET
 .endm
 
@@ -54,7 +55,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
  */
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
@@ -66,10 +66,65 @@ SYM_CODE_START(__x86_indirect_thunk_arra
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_END(__x86_indirect_thunk_array)
 
-#define GEN(reg) EXPORT_THUNK(reg)
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+.macro CALL_THUNK reg
+	.align RETPOLINE_THUNK_SIZE
+
+SYM_INNER_LABEL(__x86_indirect_call_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+
+	CALL_DEPTH_ACCOUNT
+	POLINE \reg
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+.endm
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_call_thunk_array)
+
+#define GEN(reg) CALL_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_call_thunk_array)
+
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_call_thunk_ ## reg)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
+.macro JUMP_THUNK reg
+	.align RETPOLINE_THUNK_SIZE
+
+SYM_INNER_LABEL(__x86_indirect_jump_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
+	POLINE \reg
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+.endm
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_START(__x86_indirect_jump_thunk_array)
+
+#define GEN(reg) JUMP_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align RETPOLINE_THUNK_SIZE
+SYM_CODE_END(__x86_indirect_jump_thunk_array)
+
+#define GEN(reg) __EXPORT_THUNK(__x86_indirect_jump_thunk_ ## reg)
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+#endif
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -417,7 +417,10 @@ static void emit_indirect_jump(u8 **ppro
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+			emit_jump(&prog, &__x86_indirect_jump_thunk_array[reg], ip);
+		else
+			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
 		EMIT2(0xFF, 0xE0 + reg);
 	}


