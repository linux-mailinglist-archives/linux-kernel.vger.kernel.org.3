Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213F57726D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiGPXUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiGPXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:19:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D0252AE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:20 -0700 (PDT)
Message-ID: <20220716230954.898341815@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HH2MkrvtK0knlQv3/gUUgzX0UyCTF610TO5DDeIkhWw=;
        b=PBHxgX2+WigfBNkvD7Of6EcTXx/UDDGItxPo8f/XXmduIkPi9RaFlHcHILHSM5JG0ReOTA
        LYKgnQeQhjdrGM4fKeByD7EdPxop06kG4D15E74OjjBRPV5EgO0BZLDxeNaRxrc48wogOI
        0YP11YnQ4SW1uejuew21VugEQEGDNV25puv/PfsiIdVG4+tsz7O4FyGIufqXpLZlQ0YvZ8
        Clg4rZlO4B7fW1OWUDvzmxbabqWsHmO9aMUDyeuprXybVSalp/L/6MyGnItKVM1gfxuqoX
        YhnWkgNUw32eelHBk8srfoWPNxB6HD8+b0zCHkDBt1o0XMWuK1dHl4JwVOctSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HH2MkrvtK0knlQv3/gUUgzX0UyCTF610TO5DDeIkhWw=;
        b=c7acqDlncM0gMIpLjjNqUDuLayxkpvQQvqvBe2LijisEKrJVujCO5bVgwNX/Q3McCmKopG
        i5lXsar61xZugwBA==
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
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch 37/38] x86/bpf: Emit call depth accounting if required
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:09 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that calls in BPF jitted programs are emitting call depth accounting
when enabled to keep the call/return balanced. The return thunk jump is
already injected due to the earlier retbleed mitigations.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/alternative.h |    6 +++++
 arch/x86/kernel/callthunks.c       |   19 ++++++++++++++++
 arch/x86/net/bpf_jit_comp.c        |   43 ++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 15 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -95,6 +95,7 @@ extern void callthunks_patch_module_call
 extern void callthunks_module_free(struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
 extern bool is_callthunk(void *addr);
+extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -109,6 +110,11 @@ static __always_inline bool is_callthunk
 {
 	return false;
 }
+static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
+							  void *func)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -706,6 +706,25 @@ int callthunk_get_kallsym(unsigned int s
 	return ret;
 }
 
+#ifdef CONFIG_BPF_JIT
+int x86_call_depth_emit_accounting(u8 **pprog, void *func)
+{
+	unsigned int tmpl_size = callthunk_desc.template_size;
+	void *tmpl = callthunk_desc.template;
+
+	if (!thunks_initialized)
+		return 0;
+
+	/* Is function call target a thunk? */
+	if (is_callthunk(func))
+		return 0;
+
+	memcpy(*pprog, tmpl, tmpl_size);
+	*pprog += tmpl_size;
+	return tmpl_size;
+}
+#endif
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -340,6 +340,12 @@ static int emit_call(u8 **pprog, void *f
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
+static int emit_rsb_call(u8 **pprog, void *func, void *ip)
+{
+	x86_call_depth_emit_accounting(pprog, func);
+	return emit_patch(pprog, func, ip, 0xE8);
+}
+
 static int emit_jump(u8 **pprog, void *func, void *ip)
 {
 	return emit_patch(pprog, func, ip, 0xE9);
@@ -1431,19 +1437,26 @@ st:			if (is_imm8(insn->off))
 			break;
 
 			/* call */
-		case BPF_JMP | BPF_CALL:
+		case BPF_JMP | BPF_CALL: {
+			int offs;
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
 				/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 				EMIT3_off32(0x48, 0x8B, 0x85,
 					    -round_up(bpf_prog->aux->stack_depth, 8) - 8);
-				if (!imm32 || emit_call(&prog, func, image + addrs[i - 1] + 7))
+				if (!imm32)
 					return -EINVAL;
+				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
 			} else {
-				if (!imm32 || emit_call(&prog, func, image + addrs[i - 1]))
+				if (!imm32)
 					return -EINVAL;
+				offs = x86_call_depth_emit_accounting(&prog, func);
 			}
+			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
+				return -EINVAL;
 			break;
+		}
 
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
@@ -1808,10 +1821,10 @@ static int invoke_bpf_prog(const struct
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
 	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
-	if (emit_call(&prog,
-		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
-		      __bpf_prog_enter, prog))
-			return -EINVAL;
+	if (emit_rsb_call(&prog,
+			  p->aux->sleepable ? __bpf_prog_enter_sleepable :
+			  __bpf_prog_enter, prog))
+		return -EINVAL;
 	/* remember prog start time returned by __bpf_prog_enter */
 	emit_mov_reg(&prog, true, BPF_REG_6, BPF_REG_0);
 
@@ -1831,7 +1844,7 @@ static int invoke_bpf_prog(const struct
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
 	/* call JITed bpf program or interpreter */
-	if (emit_call(&prog, p->bpf_func, prog))
+	if (emit_rsb_call(&prog, p->bpf_func, prog))
 		return -EINVAL;
 
 	/*
@@ -1855,10 +1868,10 @@ static int invoke_bpf_prog(const struct
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
 	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
-	if (emit_call(&prog,
-		      p->aux->sleepable ? __bpf_prog_exit_sleepable :
-		      __bpf_prog_exit, prog))
-			return -EINVAL;
+	if (emit_rsb_call(&prog,
+			  p->aux->sleepable ? __bpf_prog_exit_sleepable :
+			  __bpf_prog_exit, prog))
+		return -EINVAL;
 
 	*pprog = prog;
 	return 0;
@@ -2123,7 +2136,7 @@ int arch_prepare_bpf_trampoline(struct b
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_enter, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_enter, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2151,7 +2164,7 @@ int arch_prepare_bpf_trampoline(struct b
 		restore_regs(m, &prog, nr_args, regs_off);
 
 		/* call original function */
-		if (emit_call(&prog, orig_call, prog)) {
+		if (emit_rsb_call(&prog, orig_call, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -2194,7 +2207,7 @@ int arch_prepare_bpf_trampoline(struct b
 		im->ip_epilogue = prog;
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
-		if (emit_call(&prog, __bpf_tramp_exit, prog)) {
+		if (emit_rsb_call(&prog, __bpf_tramp_exit, prog)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}

