Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911654C2F50
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiBXPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiBXPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CEB148651
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=K24Vs4Ton0aBeorNN97HJrh1/zNIG3PjdxAh/1Q/WZI=; b=Dbd+zOK9+eQTFtGqgsmjirbIAf
        P88T+Rhvwf+YvR8CqZjVUsv23HIu9266BilgPmt66pitvyDobzT+DuAXDxV8AMTdjmV5xcTwRbZp3
        769fPO2kTXGgb+Afw3ZIJoKjNcfqKt6ykg0vbcaSn4EfiZu4NyKHrc9mw1N+4u2ctC6gSmxmAUhwy
        iUj175YCgfU9Dzw0tLXeG3f3+leEB03DxH0cjCAx6bLc8/k4NYrGL8prOGbXgzxU8PYotOQI3/ym7
        JYKGUYVgSJ44cKZQd8kHtsnNLC71wayhNYro0pDCWKTKhkQtSzu3bEfLF6iFUaHzCtG0QAsEtjzg+
        4/x2NHgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-004s25-OZ; Thu, 24 Feb 2022 15:17:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38A653017B1;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5E4102B354787; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.950111925@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and trampoline
References: <20220224145138.952963315@infradead.org>
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

With IBT enabled builds we need ENDBR instructions at indirect jump
target sites, since we start execution of the JIT'ed code through an
indirect jump, the very first instruction needs to be ENDBR.

Similarly, since eBPF tail-calls use indirect branches, their landing
site needs to be an ENDBR too.

The trampolines need similar adjustment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c |   37 +++++++++++++++++++++++++++++++------
 kernel/bpf/trampoline.c     |   20 ++++----------------
 2 files changed, 35 insertions(+), 22 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -46,6 +46,12 @@ static u8 *emit_code(u8 *ptr, u32 bytes,
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
+#define X86_TAIL_CALL_OFFSET	(11 + 4*HAS_KERNEL_IBT)
 
 static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 {
@@ -286,16 +292,21 @@ static void emit_prologue(u8 **pprog, u3
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
-	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
+	EMIT_ENDBR();
+	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);		/*    =  5 */
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
 		if (tail_call_reachable && !is_subprog)
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
+			EMIT2(0x31, 0xC0); /* xor eax, eax */	/* +2 =  7 */
 		else
 			EMIT2(0x66, 0x90); /* nop2 */
 	}
-	EMIT1(0x55);             /* push rbp */
-	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+	EMIT1(0x55);             /* push rbp */			/* +1 =  8 */
+	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */		/* +3 = 11 */
+
+	/* X86_TAIL_CALL_OFFSET is here */
+	EMIT_ENDBR();
+
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
@@ -339,9 +350,18 @@ static int __bpf_arch_text_poke(void *ip
 	u8 *prog;
 	int ret;
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	if (is_endbr(*(u32 *)ip))
+		ip += 4;
+#endif
+
 	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
 	if (old_addr) {
 		prog = old_insn;
+#ifdef CONFIG_X86_KERNEL_IBT
+		if (is_endbr(*(u32 *)old_addr))
+			old_addr += 4;
+#endif
 		ret = t == BPF_MOD_CALL ?
 		      emit_call(&prog, old_addr, ip) :
 		      emit_jump(&prog, old_addr, ip);
@@ -352,6 +372,10 @@ static int __bpf_arch_text_poke(void *ip
 	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
 	if (new_addr) {
 		prog = new_insn;
+#ifdef CONFIG_X86_KERNEL_IBT
+		if (is_endbr(*(u32 *)new_addr))
+			new_addr += 4;
+#endif
 		ret = t == BPF_MOD_CALL ?
 		      emit_call(&prog, new_addr, ip) :
 		      emit_jump(&prog, new_addr, ip);
@@ -2028,10 +2052,11 @@ int arch_prepare_bpf_trampoline(struct b
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		orig_call += X86_PATCH_SIZE;
+		orig_call += X86_PATCH_SIZE + 4*HAS_KERNEL_IBT;
 
 	prog = image;
 
+	EMIT_ENDBR();
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -117,18 +117,6 @@ static void bpf_trampoline_module_put(st
 	tr->mod = NULL;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -160,12 +148,12 @@ static int modify_fentry(struct bpf_tram
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
 	void *ip = tr->func.addr;
+	unsigned long faddr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	faddr = ftrace_location((unsigned long)ip);
+	if (faddr)
+		tr->func.ftrace_managed = true;
 
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;


