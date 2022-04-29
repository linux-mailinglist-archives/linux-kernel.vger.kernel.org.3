Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E1514523
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356311AbiD2JQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356224AbiD2JQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:16:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D56EC7A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/XnIwFvLfCFC901rwzd7CKlhwSGmJGDCTrEVmJLlO3I=; b=UQV2pxmonTCHlLYW9sR8xYyfTT
        tEcZ1GS0e3gkJWBtVTY9i4UZZt1DwzZnMA6+qFmEocU6D/7yUeQWAwlxcVnN2YmaigSj2BVjSNont
        aQDHS96r0Jh+KpP0YwHnati7NBvNLuDa0DnXNlXM8oxDTlkT1A4jM5QMfcFsHiBxkKqVVVlbjuS1f
        O2BDOPNxWTqUkatkY6ZeX8DHw8lfNMzdlJ9b/WPIAxcUxrBbSqnixr4u7U8IrU1gocOu7ipQx2Dqu
        Ms7yp6VcDbos+ZLTDv4S23v7Gu55V+C1a+etCYCHmTvenqOdGcA+HFbLUe24z4g+l/q2NaM8Jpa5S
        OHWXkK0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkMgR-009ZOd-O1; Fri, 29 Apr 2022 09:13:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 775B598038F; Fri, 29 Apr 2022 11:13:01 +0200 (CEST)
Date:   Fri, 29 Apr 2022 11:13:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        jiangshanlai@gmail.com, Andrew.Cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v3] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220429091301.GR2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since the upper regs don't exist for ia32 code, preserving them
doesn't hurt and it simplifies the code.

If there was any attack surface on this, that attack surface already
exists for INT80 and needs to be otherwise dealt with.

Notably:

 - SYSENTER: didn't clear si, dx, cx.
 - SYSCALL, INT80: *do* clear si since the C functions don't take a
   second argument.

Add a clear_rsi argument to CLEAR_REGS for these 3 sites, and have
SYSENTER clear everything (no code relies on those registers not being
cleared and selftests pass).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061fb7c6e..526eba74b84c 100644
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
@@ -92,13 +94,16 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-.macro CLEAR_REGS
+.macro CLEAR_REGS clear_rsi=0
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
 	 * well before they could be put to use in a speculative execution
 	 * gadget.
 	 */
+	.if \clear_rsi
+	xorl	%esi,  %esi	/* nospec si  */
+	.endif
 	xorl	%edx,  %edx	/* nospec dx  */
 	xorl	%ecx,  %ecx	/* nospec cx  */
 	xorl	%r8d,  %r8d	/* nospec r8  */
@@ -111,12 +116,11 @@ For 32-bit we have the following conventions - kernel is built with
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
 	xorl	%r15d, %r15d	/* nospec r15 */
-
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
-	CLEAR_REGS
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1 clear_rsi=0
+	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret save_rdi=\save_rdi
+	CLEAR_REGS clear_rsi=\clear_rsi
 .endm
 
 .macro POP_REGS pop_rdi=1 skip_r11rcx=0
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007cddbd..4ca8d6bfbe6b 100644
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
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS clear_rsi=1
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
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS clear_rsi=1
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
+	PUSH_AND_CLEAR_REGS rax=$-ENOSYS save_rdi=0 clear_rsi=1
 	UNWIND_HINT_REGS
 
 	cld

