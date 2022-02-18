Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E084BBE29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiBRRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiBRRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA84C78C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=crfK2m3A0PkwFovs44xq+zg31NP78S5dlyz1kHRltPY=; b=q4Phk6WNn6uGR95Ns+LR0HGc9i
        1XxrggRhMyKVW24akfv4irqT7efimR+/wApSscWq9+y63Vp0VxtwM+z21Y33BifO12vK9+nEGO04O
        7Sz+ZXW69hYF3m8RYLOnLoXPIeNUa+qbH+i+zZ3lwjKhLNLvMkM/e4l8FyrhMYDdu2nPGXS8nVqmP
        X2D8A9Ft9JXM1LrAS0b5/Tbwlv/Z8D5AsPSfEuroaBr+bWqwFuO9NCp7wGXQ9sPmycp+4YJb4uXap
        2w5540rwS2x41bUYbYupGL/KTrfg2ejJfj8IfCXpoml40rSqGHUnz1oFMANZRs0599FeSZesCH7SQ
        G75wykkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBW-CJ; Fri, 18 Feb 2022 17:14:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0941300EB5;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2C11E206D2383; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.160786220@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 10/29] x86/bpf: Add ENDBR instructions to prologue
References: <20220218164902.008644515@infradead.org>
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

Note: this shifts the trampoline patch site by 5 bytes but I've not
yet figured out where this is used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/net/bpf_jit_comp.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -46,6 +46,12 @@ static u8 *emit_code(u8 *ptr, u32 bytes,
 #define EMIT4_off32(b1, b2, b3, b4, off) \
 	do { EMIT4(b1, b2, b3, b4); EMIT(off, 4); } while (0)
 
+#ifdef CONFIG_X86_IBT
+#define EMIT_ENDBR() EMIT4(0xf3, 0x0f, 0x1e, 0xfa)
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
+#define X86_TAIL_CALL_OFFSET	(11 + 4*IS_ENABLED(CONFIG_X86_IBT))
 
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


