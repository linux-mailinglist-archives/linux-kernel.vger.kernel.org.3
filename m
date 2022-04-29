Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A13515676
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiD2VQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiD2VQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:16:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9132D3AD7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LzwMriWDg+MWr0zpRPhpkcVlImwaQ15JxuByzsqGf3A=; b=XOT+TL6zwHIdOle6iACS+2KGZb
        CFdfAJ1DaIycQkj/EweruN76eIw0+ZzUTBgZcnsJQkrpIPJAnsj8ordGEIOxLcRMxDX3Xpu9h3y/b
        vBbszaM6i+eCdG82sAVYkvMByczu1dwtDMAyVWEue4LhB+uAwMs4zLQP/C7VMmnGomfcwQOYbZ+YX
        N3fRmRQIgh6yfdogVo6zgtYfPmSG84vU/g6TAuuqwZFOQcfW7+y35rjm17a8/MsUERpXgX+nEtMnm
        n5+xSndwef3Vizv9QD14hjzKtExL2ARJw3CRS+5E+7M6VzeQvwUoIIlGd/SdQR8la+z7wQHX04hTk
        rIO9lVRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkXv7-009hcz-E1; Fri, 29 Apr 2022 21:12:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD57F3002B1;
        Fri, 29 Apr 2022 23:12:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A76BD20295B20; Fri, 29 Apr 2022 23:12:56 +0200 (CEST)
Date:   Fri, 29 Apr 2022 23:12:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <YmxU2JoswWMYm4nl@hirez.programming.kicks-ass.net>
References: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
 <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBUzURTBBnkO5c5xRC+c9+KFvLXw06h5uQ7gODeiSR-QA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:00:37PM +0800, Lai Jiangshan wrote:
> On Fri, Apr 29, 2022 at 5:13 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > Notably:
> >
> >  - SYSENTER: didn't clear si, dx, cx.
> >  - SYSCALL, INT80: *do* clear si since the C functions don't take a
> >    second argument.
> >
> 
> If CLEAR_REGS for SYSCALL, INT80 clears si, it is better, IMO, to
> make CLEAR_REGS clear si unconditionally.

Well, I didn't want to add the overhead to 64bit native syscalls, but
Linus just suggested the same thing elsewhere. So yeah.

He also suggested cleaning up INT80 like below to get rid of the
save_rdi wart.

(Linus, can I add your SoB to the thing?)

---
Subject: x86/entry: Simplify entry_INT80_compat()
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri Apr 29 22:52:21 CEST 2022

Instead of playing silly games with rdi, use rax for simpler and more
consistent code.

[peterz: Changelog and fix off-by-one in offsets]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64_compat.S |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -362,26 +362,25 @@ SYM_CODE_START(entry_INT80_compat)
 
 	/* switch to thread stack expects orig_ax and rdi to be pushed */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
 
 	/* Need to switch before accessing the thread stack. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
 	/* In the Xen PV case we already run on the thread stack. */
 	ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
 
-	movq	%rsp, %rdi
+	movq	%rsp, %rax
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
-	pushq	6*8(%rdi)		/* regs->ss */
-	pushq	5*8(%rdi)		/* regs->rsp */
-	pushq	4*8(%rdi)		/* regs->eflags */
-	pushq	3*8(%rdi)		/* regs->cs */
-	pushq	2*8(%rdi)		/* regs->ip */
-	pushq	1*8(%rdi)		/* regs->orig_ax */
-	pushq	(%rdi)			/* pt_regs->di */
+	pushq	5*8(%rax)		/* regs->ss */
+	pushq	4*8(%rax)		/* regs->rsp */
+	pushq	3*8(%rax)		/* regs->eflags */
+	pushq	2*8(%rax)		/* regs->cs */
+	pushq	1*8(%rax)		/* regs->ip */
+	pushq	0*8(%rax)		/* regs->orig_ax */
 .Lint80_keep_stack:
 
+	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
 	xorl	%esi, %esi		/* nospec   si */
 	pushq	%rdx			/* pt_regs->dx */
