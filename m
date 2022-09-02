Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87CC5AB36F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiIBO1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiIBO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E1211519F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dU2Gcv7fJ6+XDB4dHrX1+Ks1xNnLuKHyEB6BsKn/hys=; b=gDP+G+ubAw6CYtRqJTETmY3XRV
        f4DtdBEIggptmpCsrGzAtbzP0Exj5E/I5hnv+MaQJ8OXuU+jn9ijiWTyHm+6/EskhjEHcZmJ1qfKi
        gCt1cZfQrlusMHP9Fd9P6t4EIjdqZ4WkQ/VDRzBaLWmS4s6z7PrPdF4hTpFpoPAHDJ84j2//IPPbN
        wA4M3hmzBQWKstFLP8n5CqQRHcuzL+t0VbiG/H08UPUcuCUd6hw7whsKEoaRYDnvomVVuIZGwkHzb
        s1B8v/wYelQEg8ZRuLjjJFjs+E1rhUxE5mMDjuDVgwy0Stz8XTJUXl/V7ovbi72NJYviA9OsnS+lQ
        15ozaF2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-0074T7-RK; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EA083015B5;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 52E122B1E1E5B; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.606609517@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:37 +0200
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
Subject: [PATCH v2 12/59] x86/entry: Align SYM_CODE_START() variants
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

From: Thomas Gleixner <tglx@linutronix.de>

Explicitly align a bunch of commonly called SYM_CODE_START() symbols.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   12 ++++++++----
 arch/x86/entry/thunk_64.S |    4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -284,7 +284,8 @@ SYM_FUNC_END(__switch_to_asm)
  * r12: kernel thread arg
  */
 .pushsection .text, "ax"
-SYM_CODE_START(ret_from_fork)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR // copy_thread
 	movq	%rax, %rdi
@@ -828,7 +829,8 @@ EXPORT_SYMBOL(asm_load_gs_index)
  *
  * C calling convention: exc_xen_hypervisor_callback(struct *pt_regs)
  */
-SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
+	__FUNC_ALIGN
+SYM_CODE_START_LOCAL_NOALIGN(exc_xen_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -856,7 +858,8 @@ SYM_CODE_END(exc_xen_hypervisor_callback
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-SYM_CODE_START(xen_failsafe_callback)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	movl	%ds, %ecx
@@ -1516,7 +1519,8 @@ SYM_CODE_END(ignore_sysret)
 #endif
 
 .pushsection .text, "ax"
-SYM_CODE_START(rewind_stack_and_make_dead)
+	__FUNC_ALIGN
+SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -11,7 +11,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func
-SYM_FUNC_START_NOALIGN(\name)
+SYM_FUNC_START(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -36,7 +36,7 @@ SYM_FUNC_END(\name)
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 
-SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
+SYM_CODE_START_LOCAL(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9


