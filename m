Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E849577251
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiGPXTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiGPXSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499F240BE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:54 -0700 (PDT)
Message-ID: <20220716230954.214825322@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vI5x6EFx6DXYrH43rq+rdB9Jx9gwo4XYYQzQFGAOOMo=;
        b=pyMUvyDhd3KvrPWdzTAYMKZH4kd8sncuoLVe3nKcyrzLW0lqm/uI+eU73iy8syu37AT+dA
        8EJYFasoL5Uqz9+dsHUy9pd9/X8fE547yK1meknL94donFnmRg6MRHN71e+aInopW+Z/WX
        L0krV4dn3k/Wm0MUAq0B9t7MQN6x14TxYtx8sgM0JPvr0WUD31++SXRsuc9vYy5uJDCZnF
        lJ88W1YC+dcEmJHdLVhudeq1Yt2GqL4J0Zh3SNUjR+nux9ONcmR+Z25pL9FBBlTiZE3Cnk
        bh5mV/4n8tJGoEEyyIokJ+Nf3nkt7NDZGxRFnUpwmjd4KppabPyvueUaGJhVXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vI5x6EFx6DXYrH43rq+rdB9Jx9gwo4XYYQzQFGAOOMo=;
        b=KorIiSDsmYm1NVLaBldcYK2dArr2vAjLloKFVV++au7sKYQt5k70u69eqE2ab7hn2sey72
        8Z5OoGP2Z0AXqxCw==
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
Subject: [patch 26/38] x86/returnthunk: Allow different return thunks
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation for call depth tracking on Intel SKL CPUs, make it possible
to patch in a SKL specific return thunk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/nospec-branch.h |    6 ++++++
 arch/x86/kernel/alternative.c        |   19 ++++++++++++++-----
 arch/x86/kernel/ftrace.c             |    2 +-
 arch/x86/kernel/static_call.c        |    2 +-
 arch/x86/net/bpf_jit_comp.c          |    2 +-
 5 files changed, 23 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -168,6 +168,12 @@ extern void __x86_return_thunk(void);
 extern void zen_untrain_ret(void);
 extern void entry_ibpb(void);
 
+#ifdef CONFIG_CALL_THUNKS
+extern void (*x86_return_thunk)(void);
+#else
+#define x86_return_thunk	(&__x86_return_thunk)
+#endif
+
 #ifdef CONFIG_RETPOLINE
 
 #define GEN(reg) \
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -509,6 +509,11 @@ void __init_or_module noinline apply_ret
 }
 
 #ifdef CONFIG_RETHUNK
+
+#ifdef CONFIG_CALL_THUNKS
+void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+#endif
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -524,14 +529,18 @@ static int patch_return(void *addr, stru
 {
 	int i = 0;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		return -1;
-
-	bytes[i++] = RET_INSN_OPCODE;
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		if (x86_return_thunk == __x86_return_thunk)
+			return -1;
+
+		i = JMP32_INSN_SIZE;
+		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
+	} else {
+		bytes[i++] = RET_INSN_OPCODE;
+	}
 
 	for (; i < insn->length;)
 		bytes[i++] = INT3_INSN_OPCODE;
-
 	return i;
 }
 
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -358,7 +358,7 @@ create_trampoline(struct ftrace_ops *ops
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, &__x86_return_thunk, JMP32_INSN_SIZE);
+		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
 
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -52,7 +52,7 @@ static void __ref __static_call_transfor
 
 	case RET:
 		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, &__x86_return_thunk);
+			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
 		break;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -430,7 +430,7 @@ static void emit_return(u8 **pprog, u8 *
 	u8 *prog = *pprog;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, &__x86_return_thunk, ip);
+		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))

