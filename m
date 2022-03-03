Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14A04CBCB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiCCLee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCCLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7F17C43E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xB4u1Jy3hvc7M0RTBy37w5M/ndZ42JCBNtJfPEBqWsQ=; b=KEf+27uqmVOCXbYPLDqOuNo1/X
        qg5rPn0kyTMHmguWRyF6ett2gaZlJYZbDghUhNY/R5MJlYOJDV/wBKSNr949ejJ3EkJU5sSKf7Ooq
        ppArmtbT/sr85FwIWukbKssPhK3RoA5gkeQBtAK5su0znPSTAvhlIeVNEBxpXyBCDB1hhiu17fpUO
        fgsHluAhlHq1m+CM9n9kEfy//s+WVROnGO8aIPWC3XEigYS5JRFcH4bw3ZRSQmkEsDYcMnZtRD+te
        bJ7CD15SNmuZQ3r6lpprMVyJBSNxYokdiJNufpCGsLWnmZ36boGRpACEtErApsix61riroaFOuBJw
        KekwM7Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00BaH7-Be; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0CA96302D58;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8438130126B5C; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.604331683@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 27/39] x86/ibt,ftrace: Annotate ftrace code patching
References: <20220303112321.422525803@infradead.org>
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

These are code patching sites, not indirect targets.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace_64.S |    7 +++++++
 1 file changed, 7 insertions(+)

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
@@ -192,6 +195,7 @@ SYM_FUNC_START(ftrace_regs_caller)
 	/* save_mcount_regs fills in first two parameters */
 
 SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -221,6 +225,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_pt
 	leaq (%rsp), %rcx
 
 SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -248,6 +253,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_
 	 */
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jnz	1f
 
 	restore_mcount_regs
@@ -261,6 +267,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_jmp,
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	jmp ftrace_epilogue
 
 	/* Swap the flags with orig_rax */


