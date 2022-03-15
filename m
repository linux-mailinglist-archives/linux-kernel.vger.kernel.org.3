Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FC4D993A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbiCOKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347309AbiCOKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9114E37A0B;
        Tue, 15 Mar 2022 03:44:02 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmmASHlkcf5Hp91+7lwgNYLB7yjdOiAdTxaIDY85l8w=;
        b=T3OXFS4QaNuOGkkOJyx2SfWToECP5vcUiBC6IS7nYfgkdiKLYdWhDCDlexw8Xd6Ft+2OUl
        ZrawwTQXc64i1S5JmGM+pUMTHITRTpS4ndDJEy/ZS/qti0xF3PI39QdRCw460AkMv1E9cl
        bHg+tHYhNolkMfcJHLhLrTMY0n+NqJThviaeiwlDwtQ9SJj5nZKjbsZehD1jUP3ZjF6xd2
        VTDymbWtBTBImketkmSL/DkoovHPzziLuOV4pADy5F+lg7yXogWSGE6zFY3mVC8hJrr0Wc
        gWDNO6dqPiupP5yXb4t5py1bI/+9CupDDR2Ra4e8elAIC8G1sJ4oLUdrFpLI8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmmASHlkcf5Hp91+7lwgNYLB7yjdOiAdTxaIDY85l8w=;
        b=k/3wTRt0htZDvsPkYEWct+qhCDC//ySTnCgM76cQ+vkwocK6x00nQtxRY3ccYxFaUZPBDU
        eFpKZ8T717OI0jBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,bpf: Add ENDBR instructions to prologue and
 trampoline
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.464998838@infradead.org>
References: <20220308154318.464998838@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104013.16921.14632925793308506332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     58912710558889629daae3e0824daacab663bd4a
Gitweb:        https://git.kernel.org/tip/58912710558889629daae3e0824daacab663bd4a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:38 +01:00

x86/ibt,bpf: Add ENDBR instructions to prologue and trampoline

With IBT enabled builds we need ENDBR instructions at indirect jump
target sites, since we start execution of the JIT'ed code through an
indirect jump, the very first instruction needs to be ENDBR.

Similarly, since eBPF tail-calls use indirect branches, their landing
site needs to be an ENDBR too.

The trampolines need similar adjustment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.464998838@infradead.org
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0ecb140..b592ea0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -46,6 +46,12 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 #define EMIT4_off32(b1, b2, b3, b4, off) \
 	do { EMIT4(b1, b2, b3, b4); EMIT(off, 4); } while (0)
 
+#ifdef CONFIG_X86_KERNEL_IBT
+#define EMIT_ENDBR()	EMIT(gen_endbr(), 4)
+#else
+#define EMIT_ENDBR()
+#endif
+
 static bool is_imm8(int value)
 {
 	return value <= 127 && value >= -128;
@@ -241,7 +247,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	11
+#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
 
 static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 {
@@ -286,6 +292,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
+	EMIT_ENDBR();
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
@@ -296,6 +303,10 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	}
 	EMIT1(0x55);             /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+
+	/* X86_TAIL_CALL_OFFSET is here */
+	EMIT_ENDBR();
+
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
@@ -384,6 +395,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
 
+	/*
+	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
+	 * with an ENDBR instruction.
+	 */
+	if (is_endbr(*(u32 *)ip))
+		ip += ENDBR_INSN_SIZE;
+
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
@@ -2024,14 +2042,18 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	ip_off = stack_size;
 
-	if (flags & BPF_TRAMP_F_SKIP_FRAME)
+	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
+		if (is_endbr(*(u32 *)orig_call))
+			orig_call += ENDBR_INSN_SIZE;
 		orig_call += X86_PATCH_SIZE;
+	}
 
 	prog = image;
 
+	EMIT_ENDBR();
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
