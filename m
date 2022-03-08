Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8484D1C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbiCHP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348052AbiCHP4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:05 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2964F9C1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eML9RLDC/cQALZAn3V17jKIU3Pd2WZbKiLikbOlkBgk=; b=k7dqYZIW8opId2R5YfBfyKs2ST
        oeegECYJWXUKSW3ABcuOmV0T9d1SGZV08N4V8KQn0IOlpJCj9DU5VPExha6cZd+Fr7/lGjpHnG1Fi
        kabPaMf9PwkN+yDln0jkZufHNAD/ONAAeMsc6zy+EzSuhk2EuJm4pxuk7MaiNOn2qUO0eEJdtkUg/
        ahJPgWe2zTwM8vACbyLqmdS0iwbkAV56MaJA7N6BmccV0zpbJXcahBGO6gHgNVXukM6rrq8Zu/Rgr
        zd9YhcKGIPayeuSd+8J5FAEQbaDsEsH7/pte7LMSkkoaPFYHkvb1xlooW/p1s1koSWZPidA8DcIOp
        gwcAz6NA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUiX-LV; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F722302AD4;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 509702B561927; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.464998838@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 22/45] x86/ibt,bpf: Add ENDBR instructions to prologue and trampoline
References: <20220308153011.021123062@infradead.org>
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
 arch/x86/net/bpf_jit_comp.c |   16 ++++++++++++++--
 kernel/bpf/trampoline.c     |   20 ++++----------------
 2 files changed, 18 insertions(+), 18 deletions(-)

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
+#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
 
 static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
 {
@@ -286,6 +292,7 @@ static void emit_prologue(u8 **pprog, u3
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
+	EMIT_ENDBR();
 	memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
 	prog += X86_PATCH_SIZE;
 	if (!ebpf_from_cbpf) {
@@ -296,6 +303,10 @@ static void emit_prologue(u8 **pprog, u3
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
@@ -2028,10 +2039,11 @@ int arch_prepare_bpf_trampoline(struct b
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		orig_call += X86_PATCH_SIZE;
+		orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
 
 	prog = image;
 
+	EMIT_ENDBR();
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */


