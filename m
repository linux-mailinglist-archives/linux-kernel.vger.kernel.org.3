Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DD74D1C87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348498AbiCHP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiCHP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B604F9DE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jkRoquxw2WD1gglc8D6dyg1oP6jPgeuTkeXdItrBtV0=; b=TBEoxvw+fRU8U4fUhpQj08tfhk
        tS2vddFe4D6H2k0jv4Z+8noTn10DVs8zp1s0GFZ823iUp7rukq1E8qqBK/CA2ryvFHAeVrs9z557l
        jKLibaP2TaG9vOpd+JzgWplR9oVlWHo2nUA7Ui77QZFS77t2XXoK+l6YvwMmA+fEZc0JwO1qxjBjM
        d+58Qqs9G/j9nk1vJ8GSsCLEGu05N7bMTm58D/bSGsJag5lJWJPkXdMiVmtGXQgTN0Fep2acDEygh
        burEl2L53KrjqguEhsuWusGGHb1zt3RJxlRRC8TFYEhNf2aUzFrjMItowEaxyuOTkGj4buH0f72hZ
        c3C5fyTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUiW-LS; Tue, 08 Mar 2022 15:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C97F30276B;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3F5F22B561923; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.347296408@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 20/45] x86/ibt,ftrace: Make function-graph play nice
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

Return trampoline must not use indirect branch to return; while this
preserves the RSB, it is fundamentally incompatible with IBT. Instead
use a retpoline like ROP gadget that defeats IBT while not unbalancing
the RSB.

And since ftrace_stub is no longer a plain RET, don't use it to copy
from. Since RET is a trivial instruction, poke it directly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace.c    |    9 ++-------
 arch/x86/kernel/ftrace_64.S |   21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -316,12 +316,12 @@ create_trampoline(struct ftrace_ops *ops
 	unsigned long offset;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long retq;
 	unsigned long *ptr;
 	void *trampoline;
 	void *ip;
 	/* 48 8b 15 <offset> is movq <offset>(%rip), %rdx */
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
+	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
 	int ret;
 
@@ -359,12 +359,7 @@ create_trampoline(struct ftrace_ops *ops
 		goto fail;
 
 	ip = trampoline + size;
-
-	/* The trampoline ends with ret(q) */
-	retq = (unsigned long)ftrace_stub;
-	ret = copy_from_kernel_nofault(ip, (void *)retq, RET_SIZE);
-	if (WARN_ON(ret < 0))
-		goto fail;
+	memcpy(ip, retq, RET_SIZE);
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -176,10 +176,10 @@ SYM_FUNC_END(ftrace_caller);
 SYM_FUNC_START(ftrace_epilogue)
 /*
  * This is weak to keep gas from relaxing the jumps.
- * It is also used to copy the RET for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	UNWIND_HINT_FUNC
+	ENDBR
 	RET
 SYM_FUNC_END(ftrace_epilogue)
 
@@ -284,6 +284,7 @@ SYM_FUNC_START(__fentry__)
 	jnz trace
 
 SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
+	ENDBR
 	RET
 
 trace:
@@ -307,7 +308,7 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_FUNC_START(return_to_handler)
-	subq  $24, %rsp
+	subq  $16, %rsp
 
 	/* Save the return values */
 	movq %rax, (%rsp)
@@ -319,7 +320,19 @@ SYM_FUNC_START(return_to_handler)
 	movq %rax, %rdi
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
-	addq $24, %rsp
-	JMP_NOSPEC rdi
+
+	addq $16, %rsp
+	/*
+	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
+	 * since IBT would demand that contain ENDBR, which simply isn't so for
+	 * return addresses. Use a retpoline here to keep the RSB balanced.
+	 */
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call .Ldo_rop
+	int3
+.Ldo_rop:
+	mov %rdi, (%rsp)
+	UNWIND_HINT_FUNC
+	RET
 SYM_FUNC_END(return_to_handler)
 #endif


