Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFD54BBE2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiBRRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiBRRPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A474C7A1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=n09cSUUt8kmqGH7bH8N8CKGVS+b2rhhGAV948lm4hj4=; b=CKd1O32y3JuE9QAzcd1ocBeNsd
        xUav//8E1xDunH1IvglsLdPozFDYg2XlhucR7BfiyISDWriYGJOLqxqdPIVmDJc8T6rEikVz95cnq
        Y/a1kmmBONUn03yJPi6qxy78QLE3qJzBU012qEH5miHHhUlmXn5LHSq6dkp2g/HJx3qCapQ+ZZFxP
        MpedixxhqenJJT+byQdQeBgGewOT7YL4oYnBIjmvwIXjgpqfgV+f9M4M+ro0a7GxzlhmpfKA0QHU9
        4doe1/zshuVFa6KO6rxEzISKTW9MiWw6Rur6tjPl4XA6zEG4M8aGnRQX6lGy8m3pARgvpfGOZsFCz
        IhhARznQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBg-JB; Fri, 18 Feb 2022 17:14:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE4C3301A50;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4FC2A213C1E73; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.637954642@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 18/29] x86/ibt,ftrace: Annotate ftrace code patching
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

Notably the noinline is required to generate sane code; without it GCC
think's it's awesome to fold in a constant to the code reloc which
puts it in the wrong place to match with the ANNOTATE_NOENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace.c    |    2 +-
 arch/x86/kernel/ftrace_64.S |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -69,7 +69,7 @@ static const char *ftrace_nop_replace(vo
 	return x86_nops[5];
 }
 
-static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
+static noinline const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
 	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -145,6 +145,7 @@ SYM_FUNC_START(ftrace_caller)
 	movq %rcx, RSP(%rsp)
 
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -155,6 +156,7 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SY
 	movq $0, CS(%rsp)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Handlers can change the RIP */
@@ -169,6 +171,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
 	 * layout here.
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
@@ -179,6 +182,7 @@ SYM_FUNC_START(ftrace_epilogue)
  * It is also used to copy the RET for trampolines.
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
+	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	RET
 SYM_FUNC_END(ftrace_epilogue)
@@ -192,6 +196,7 @@ SYM_FUNC_START(ftrace_regs_caller)
 	/* save_mcount_regs fills in first two parameters */
 
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -221,6 +226,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_pt
 	leaq (%rsp), %rcx
 
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -248,6 +254,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 */
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jnz	1f
 
 	restore_mcount_regs
@@ -261,6 +268,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp,
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */
@@ -284,6 +292,7 @@ SYM_FUNC_START(__fentry__)
 	jnz trace
 
 SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	RET
 
 trace:


