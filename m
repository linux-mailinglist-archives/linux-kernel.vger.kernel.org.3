Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADF5AB393
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiIBObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiIBO1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0E1581A9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cGtjwbCjC/FUhMHf/1kXmsZcQFKDFVc++WobQ3K3nBI=; b=APDtxBO7wjqNEwPgO0C+AlCsSR
        jNRI5vZv7TMLB2lH79K0ZYm5ieuJgvBdwUs0dJNACeD4UsCsiv3rH7alQFYOjZ9ih65DWU/5QZpI9
        qhputzlsedjplmisujZXysSyEddNEdB9Ce+XDFOiv+AXL333sCeC0cimvOvnbxYDV4W+o2yx2KKhs
        fTntF6UwkiWLhmaLU/frMjCH1EDPsZUucb2vCOS5iWszKxy0UHL1W3lLyN0VpTzoruJ2sX6Wx4Pe+
        MGeLkcHktE6C34DJXrYAbF9+sYJQn2wqHQ09dulFVQ5ZQkSLmPmeZ+hLmpKE7pYvuAooUWTLT6/cv
        qZbus9nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77P-008g8r-M2; Fri, 02 Sep 2022 13:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 490E8302E11;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C38952B8EFB63; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130952.167578304@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:21 +0200
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
Subject: [PATCH v2 56/59] x86/ftrace: Remove ftrace_epilogue()
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

Remove the weird jumps to RET and simply use RET.

This then promotes ftrace_stub() to a real function; which becomes
important for kcfi.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -172,20 +172,14 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBA
 	 */
 SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-
-	jmp ftrace_epilogue
+	RET
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
-SYM_FUNC_START(ftrace_epilogue)
-/*
- * This is weak to keep gas from relaxing the jumps.
- */
-SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
+SYM_FUNC_START(ftrace_stub)
 	UNWIND_HINT_FUNC
-	ENDBR
 	RET
-SYM_FUNC_END(ftrace_epilogue)
+SYM_FUNC_END(ftrace_stub)
 
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
@@ -262,14 +256,11 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp,
 	popfq
 
 	/*
-	 * As this jmp to ftrace_epilogue can be a short jump
-	 * it must not be copied into the trampoline.
-	 * The trampoline will add the code to jump
-	 * to the return.
+	 * The trampoline will add the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
-	jmp ftrace_epilogue
+	RET
 
 	/* Swap the flags with orig_rax */
 1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
@@ -280,7 +271,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end,
 	/* Restore flags */
 	popfq
 	UNWIND_HINT_FUNC
-	jmp	ftrace_epilogue
+	RET
 
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)


