Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3185156AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiD2VVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiD2VUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:20:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858473D1FB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D34NuQX1GBXxZROMvCSKmxzJzqzR2dxQL3+sXErw3DA=; b=uBpSf0CIwp/Uwtg33Z10evUfcy
        PZxIaVBvJ4Z+lSeEzQdjAUOkSqX/4UmM+fgNvNr/K1rMUoytJsAch4s57CuDcDIv5mS+7+nsTMNHx
        sDs7eaVVQRkdSWTKtt8bl7eW4a3+EmgpfJT2l+v4qJhkxdRofKgR7qsYIvrJVfhhCDOQYx8jj3DXW
        7pVhZjtkLTnMBsCW8oycmSxHnnTWTQtwL2hd8Wlwe2RF9Kw+fjRd+f9mPGXyAIzqmOQC1utxt1yfS
        sPjvwrPI5zhJhc653gqqB2mnf1q9FG6Mmp123WJ6mqFAD9bjkWO3azwzsCa/LxeUR5/2tenInLDFT
        KBSZ/WvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkXzO-00Co55-Ba; Fri, 29 Apr 2022 21:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C10E83001EA;
        Fri, 29 Apr 2022 23:17:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB41A20295B20; Fri, 29 Apr 2022 23:17:20 +0200 (CEST)
Date:   Fri, 29 Apr 2022 23:17:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <YmxV4P7zZTN/aAm6@hirez.programming.kicks-ass.net>
References: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
 <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com>
 <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:12:56PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 29, 2022 at 08:00:37PM +0800, Lai Jiangshan wrote:
> > On Fri, Apr 29, 2022 at 5:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Notably:
> > >
> > >  - SYSENTER: didn't clear si, dx, cx.
> > >  - SYSCALL, INT80: *do* clear si since the C functions don't take a
> > >    second argument.
> > >
> > 
> > If CLEAR_REGS for SYSCALL, INT80 clears si, it is better, IMO, to
> > make CLEAR_REGS clear si unconditionally.
> 
> Well, I didn't want to add the overhead to 64bit native syscalls, but
> Linus just suggested the same thing elsewhere. So yeah.
> 
> He also suggested cleaning up INT80 like below to get rid of the
> save_rdi wart.

Which then results in...

---
Subject: x86,entry: Use PUSH_AND_CLEAR_REGS for compat
From: Peter Zijlstra <peterz@infradead.org>
Date: Sat, 9 Apr 2022 00:38:27 +0200

Since the upper regs don't exist for ia32 code, preserving them
doesn't hurt and it simplifies the code.

If there was any attack surface on this, that attack surface already
exists for INT80 and needs to be otherwise dealt with.

Notably:

 - 32bit SYSENTER: didn't clear si, dx, cx.
 - 32bit SYSCALL, INT80: *do* clear si since the C functions don't
   take a second argument.
 - 64bit: don't clear si since the C functions take a second argument.

SYSENTER should be clearing all those 3 registers, nothing uses them
and selftests pass. Unconditionally clear rsi since it simplifies
code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h         |    1 
 arch/x86/entry/entry_64_compat.S |   87 +--------------------------------------
 2 files changed, 4 insertions(+), 84 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -99,6 +99,7 @@ For 32-bit we have the following convent
 	 * well before they could be put to use in a speculative execution
 	 * gadget.
 	 */
+	xorl	%esi,  %esi	/* nospec si  */
 	xorl	%edx,  %edx	/* nospec dx  */
 	xorl	%ecx,  %ecx	/* nospec cx  */
 	xorl	%r8d,  %r8d	/* nospec r8  */
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -83,32 +83,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
 	movl	%eax, %eax
 
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	pushq	%rdx			/* pt_regs->dx */
-	pushq	%rcx			/* pt_regs->cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   $0			/* pt_regs->r12 = 0 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   $0			/* pt_regs->r13 = 0 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   $0			/* pt_regs->r14 = 0 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   $0			/* pt_regs->r15 = 0 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	cld
@@ -225,35 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_saf
 SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   $0			/* pt_regs->r9  = 0 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   $0			/* pt_regs->r10 = 0 */
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   $0			/* pt_regs->r11 = 0 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   $0			/* pt_regs->r12 = 0 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   $0			/* pt_regs->r13 = 0 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   $0			/* pt_regs->r14 = 0 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   $0			/* pt_regs->r15 = 0 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi
@@ -380,35 +327,7 @@ SYM_CODE_START(entry_INT80_compat)
 	pushq	0*8(%rax)		/* regs->orig_ax */
 .Lint80_keep_stack:
 
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	xorl	%esi, %esi		/* nospec   si */
-	pushq	%rdx			/* pt_regs->dx */
-	xorl	%edx, %edx		/* nospec   dx */
-	pushq	%rcx			/* pt_regs->cx */
-	xorl	%ecx, %ecx		/* nospec   cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   %r8			/* pt_regs->r8 */
-	xorl	%r8d, %r8d		/* nospec   r8 */
-	pushq   %r9			/* pt_regs->r9 */
-	xorl	%r9d, %r9d		/* nospec   r9 */
-	pushq   %r10			/* pt_regs->r10*/
-	xorl	%r10d, %r10d		/* nospec   r10 */
-	pushq   %r11			/* pt_regs->r11 */
-	xorl	%r11d, %r11d		/* nospec   r11 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	xorl	%ebx, %ebx		/* nospec   rbx */
-	pushq   %rbp                    /* pt_regs->rbp */
-	xorl	%ebp, %ebp		/* nospec   rbp */
-	pushq   %r12                    /* pt_regs->r12 */
-	xorl	%r12d, %r12d		/* nospec   r12 */
-	pushq   %r13                    /* pt_regs->r13 */
-	xorl	%r13d, %r13d		/* nospec   r13 */
-	pushq   %r14                    /* pt_regs->r14 */
-	xorl	%r14d, %r14d		/* nospec   r14 */
-	pushq   %r15                    /* pt_regs->r15 */
-	xorl	%r15d, %r15d		/* nospec   r15 */
-
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	cld
