Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F1A507B55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357814AbiDSU4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiDSU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:56:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468DF40A0B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Pp7b7E7AVDeMb0DdCtRbojjkzRPx2ePj4YA90yzEPsg=; b=FkvkgHcXy5HsjoxRaMVVETCNXO
        yfgxL63f1nuizpnPwa07uYyj2ACn8TJsjn3rMg5PCecEq7i0D9A+wJ8u6FThqluHRN8CVBtsVq8I3
        vVcCNsAFPM127lCOK3VUqn8PufYnZ/zWDzVAIebFtENdYvlHu4XID0eP2jzSzWTJSxqf8ZPoj+on3
        acrxuvzKx2xlxOOTFCVRNJMZxp/ipJAz9vm2hRFlpjtjQrMOUVfVcYpSFZAWBJgPAP4Q3XWv1Xc44
        c7M/9qiuP6q3tRprEvD6ECZKhE+jU6v5cDJxxJtc6pm8d6472z6g+VZuCpJ0jyaRIPYScc5CG2BFg
        /0AdgYCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngur2-003UlB-My; Tue, 19 Apr 2022 20:53:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A80A30040C;
        Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3FBD72B526F04; Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Message-ID: <20220419205241.339242797@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 19 Apr 2022 22:41:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        jiangshanlai@gmail.com, Andrew.Cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
References: <20220419204109.520779286@infradead.org>
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

Since the upper regs don't exist for ia32 code, preserving them
doesn't hurt and it simplifies the code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h         |    9 ++--
 arch/x86/entry/entry_64_compat.S |   87 +--------------------------------------
 2 files changed, 8 insertions(+), 88 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,13 +63,15 @@ For 32-bit we have the following convent
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
 	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
 	.else
+	.if \save_rdi
 	pushq   %rdi		/* pt_regs->di */
+	.endif
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
@@ -111,11 +113,10 @@ For 32-bit we have the following convent
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
 	xorl	%r15d, %r15d	/* nospec r15 */
-
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret save_rdi=\save_rdi
 	CLEAR_REGS
 .endm
 
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
@@ -381,35 +328,7 @@ SYM_CODE_START(entry_INT80_compat)
 	pushq	1*8(%rdi)		/* regs->orig_ax */
 	pushq	(%rdi)			/* pt_regs->di */
 .Lint80_keep_stack:
-
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
+	PUSH_AND_CLEAR_REGS save_rdi=0
 	UNWIND_HINT_REGS
 
 	cld


