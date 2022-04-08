Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4794F9FA2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiDHWkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 18:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiDHWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 18:40:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38716305045
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TdDWWtph9MKECKwgagF4Td9hLvgzVIbb97HVX6hNwww=; b=FoDPqxcZrN+pGNfk2EgT7ciajf
        IqzkX3jC1sLYm029XW7IbILbsncqxMx8XqqQaBM7ricKnvm4d8tgzz1lIp2FaD5cTCn1nK9XKytds
        O1Y+TE/G8ruQpjjD+Mx/Bhv5y5V3B1g1/EE7p2hbDi6H5Rbmi/k5pd9k0y4FF4e1ZGg/oLQLQQbvc
        HVU8oXLim7wr2DumqvIxXoNdiFr4Uf5c9pjOAanUHpghKWnUZejSsaAcoKIyRgkOx9XaPLtjKhUv9
        V9jLIHApkgAt0lJ6/NpOiTlAdmpXM6rvUYwpebUOdRF7FI+jFqZcIrs8OAmMem17c1JIeGv0HqTb/
        /8q1eCHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncxFM-00AE3x-Ti; Fri, 08 Apr 2022 22:38:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B0A69861C5; Sat,  9 Apr 2022 00:38:27 +0200 (CEST)
Date:   Sat, 9 Apr 2022 00:38:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] x86: PUSH_AND_CLEAR_REGS_COMPAT
Message-ID: <20220408223827.GR2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


How insane?

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/calling.h         | 25 ++++++++----
 arch/x86/entry/entry_64_compat.S | 87 ++--------------------------------------
 2 files changed, 21 insertions(+), 91 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061fb7c6e..7f938704da59 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,13 +63,15 @@ For 32-bit we have the following conventions - kernel is built with
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
@@ -92,7 +94,7 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-.macro CLEAR_REGS
+.macro CLEAR_REGS_lo
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -101,22 +103,31 @@ For 32-bit we have the following conventions - kernel is built with
 	 */
 	xorl	%edx,  %edx	/* nospec dx  */
 	xorl	%ecx,  %ecx	/* nospec cx  */
+	xorl	%ebx,  %ebx	/* nospec rbx */
+	xorl	%ebp,  %ebp	/* nospec rbp */
+.endm
+
+.macro CLEAR_REGS_hi
 	xorl	%r8d,  %r8d	/* nospec r8  */
 	xorl	%r9d,  %r9d	/* nospec r9  */
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
-	xorl	%ebx,  %ebx	/* nospec rbx */
-	xorl	%ebp,  %ebp	/* nospec rbp */
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
 	xorl	%r15d, %r15d	/* nospec r15 */
+.endm
 
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret save_rdi=\save_rdi
+	CLEAR_REGS_lo
+	CLEAR_REGS_hi
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
-	CLEAR_REGS
+.macro PUSH_AND_CLEAR_REGS_COMPAT rdx=%rdx rax=%rax save_ret=0 save_rdi=1
+	CLEAR_REGS_hi
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret save_rdi=\save_rdi
+	CLEAR_REGS_lo
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007cddbd..44a3eaf15de6 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -83,32 +83,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
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
+	PUSH_AND_CLEAR_REGS_COMPAT rax=$-ENOSYS
 	UNWIND_HINT_REGS
 
 	cld
@@ -225,35 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
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
+	PUSH_AND_CLEAR_REGS_COMPAT rax=$-ENOSYS
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
