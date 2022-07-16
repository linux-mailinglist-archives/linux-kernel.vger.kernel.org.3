Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77757724C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiGPXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiGPXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0352F2316D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:00 -0700 (PDT)
Message-ID: <20220716230954.395957513@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NshALtucQnymJ2WeE+UdxR6xGfxJcgehG3zhGvwcNYE=;
        b=cmNoIR/Nd13Op6eENfywnX5YX3Z7qMI1LTE0yMmp3CE0xfzSHEnZcTK+ZqDax/a0EGxz3g
        vDPO0hmznLDoCQzjpvuI0Mx+DbiXq6RaXS1qUHH3MIbULdBZXzaCK0dgJeQ2HtmxFkyz78
        IN0WeM/iFuGCQ9tV3/4V3Dj6oa5hdFSpAreybu9fS9OVtpyHmEmB4zdFAnEL8hDSVYd/PJ
        4rxlyWOqRNjhwQ4BFmC0+J+m78uTqiBhLPC+ybedZ2b2qJu7Lwu3vMkeeqB2gi1xgaPwcY
        gWTyj9HxtuoxRvbD06qBoakP7p9ShJRv7W+KrLlopgpcVdqhBi43nIymV3OnfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NshALtucQnymJ2WeE+UdxR6xGfxJcgehG3zhGvwcNYE=;
        b=Bgn4iEM4KKgMrcLrRw90Qr6YklxVs4CQalimSI3lbrqSjbRpxI4PKKhUARgAzusucdIX7m
        dN5TN+aDzngGK8Bw==
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
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 29/38] x86/retpoline: Add SKL retthunk retpolines
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:56 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/include/asm/nospec-branch.h |   12 +++++
 arch/x86/kernel/alternative.c        |   43 +++++++++++++++++++--
 arch/x86/lib/retpoline.S             |   71 +++++++++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c          |    5 +-
 4 files changed, 119 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -252,6 +252,8 @@
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
+extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
 extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
@@ -283,6 +285,16 @@ static inline void x86_set_skl_return_th
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
@@ -377,6 +377,38 @@ static int emit_indirect(int op, int reg
 	return i;
 }
 
+static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	u8 op = insn->opcode.bytes[0];
+	int i = 0;
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
+		__text_gen_insn(bytes+i, op, addr+i,
+				__x86_indirect_jump_thunk_array[reg],
+				JMP32_INSN_SIZE);
+		i += JMP32_INSN_SIZE;
+		break;
+
+	default:
+		BUG();
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
@@ -408,11 +440,16 @@ static int patch_retpoline(void *addr, s
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
+	op = insn->opcode.bytes[0];
+
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE))
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+		if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
+			i += emit_call_track_retpoline(addr, insn, reg, bytes);
+			return i;
+		}
 		return -1;
-
-	op = insn->opcode.bytes[0];
+	}
 
 	/*
 	 * Convert:
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -13,17 +13,18 @@
 
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
 
@@ -53,7 +54,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
  */
 
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
-#define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
@@ -65,10 +65,65 @@ SYM_CODE_START(__x86_indirect_thunk_arra
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

