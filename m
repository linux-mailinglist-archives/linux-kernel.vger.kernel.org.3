Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9138508AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379670AbiDTOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiDTOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:30:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA1443DC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12622B81EB2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E809C385A4;
        Wed, 20 Apr 2022 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650464837;
        bh=kRue8UYppimeZ4GCFiUVzoXvs5yFCMygQF0LIsQLeBU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=uVJ6QTXoD8T0flzb1kO3j4UkGVDSwdkUWh7cNrIn8cqn9yPUcr/8XQRWNgAMocIHv
         GbAf8bRh2IZjeLBcivAV0WuC/L5cu1Yd2uksDlSN/T8LYzSQ4Q+tgcTX9cQx1jzmFS
         bsjs49RHMvtVg/OfWRzRXAYwx99RmzpNruwYpxk2fCWNU9+vVxPchX9XCOFliYTGEI
         JezZj4xDUqbgsIkYsaEbWu6Da9KMCjpe93Fofh1mrakoCGTEYEju5l9N7dZo2dKB2G
         wCidG2BcXqG+ieijRHbzWpWd6UbaeW1W2DnNLe3E5xWg/AvRli3QwEvfMd0nGXG+lH
         OJ0M8lnLKv4WQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 25FC927C0054;
        Wed, 20 Apr 2022 10:27:16 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 20 Apr 2022 10:27:16 -0400
X-ME-Sender: <xms:QxhgYvCDFANpIMB4TAXEC64rWWSDoELan9xU6KCZ7iwkuR5rfyL1og>
    <xme:QxhgYljpe8eqaQVd4VwLKUbVgTmkNqBFAqfSjQlKv2_XJ17hLa51acBKitTp9NFIr
    UE8oWCdb-2uBGkEIOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddtgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeffveffudegfeeguefgvdetteehfeekhedufefhveefhfehgeelffel
    gefhkeetkeenucffohhmrghinheptghomhhprghtrdhssgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudduiedukeehieefvddqvdeifeduieeitdekqdhluhhtoh
    eppehkvghrnhgvlhdrohhrgheslhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:QxhgYqnC56eS9rKNLLYPyi4kFYelWdJQdBnrJpVQU3_iMJ_NyV5vSw>
    <xmx:QxhgYhwkQf2FP5Z3WBG4i1fh9Snjxibd_gtlaCbeIEsZuZNsLXVojw>
    <xmx:QxhgYkRMQSnx_MeKICB0DwSDrqz9WqG6kY-GpMNypXb9WjzP5x3bbw>
    <xmx:RBhgYqMBgNbfoMZzvgAa8tackKPJuVSwmcQNNVDx1PU69cAzoAPkaQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 84B6321E0073; Wed, 20 Apr 2022 10:27:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-568-g521196dd5d-fm-20220414.001-g521196dd
Mime-Version: 1.0
Message-Id: <ed167304-0d43-42fb-9da1-1358dded3a2f@www.fastmail.com>
In-Reply-To: <20220419205241.339242797@infradead.org>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.339242797@infradead.org>
Date:   Wed, 20 Apr 2022 07:26:54 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Andrew Cooper" <Andrew.Cooper3@citrix.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Apr 19, 2022, at 1:41 PM, Peter Zijlstra wrote:
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.

They exist for compat code, though, and should be preserved for ABI purposes. Programs that do int $0x80 in 64-bit code do exist.

>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/calling.h         |    9 ++--
>  arch/x86/entry/entry_64_compat.S |   87 +--------------------------------------
>  2 files changed, 8 insertions(+), 88 deletions(-)
>
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -63,13 +63,15 @@ For 32-bit we have the following convent
>   * for assembly code:
>   */
> 
> -.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
> +.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1
>  	.if \save_ret
>  	pushq	%rsi		/* pt_regs->si */
>  	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
>  	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
>  	.else
> +	.if \save_rdi
>  	pushq   %rdi		/* pt_regs->di */
> +	.endif
>  	pushq   %rsi		/* pt_regs->si */
>  	.endif
>  	pushq	\rdx		/* pt_regs->dx */
> @@ -111,11 +113,10 @@ For 32-bit we have the following convent
>  	xorl	%r13d, %r13d	/* nospec r13 */
>  	xorl	%r14d, %r14d	/* nospec r14 */
>  	xorl	%r15d, %r15d	/* nospec r15 */
> -
>  .endm
> 
> -.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
> -	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
> +.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0 save_rdi=1
> +	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret save_rdi=\save_rdi
>  	CLEAR_REGS
>  .endm
> 
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -83,32 +83,7 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_af
>  	movl	%eax, %eax
> 
>  	pushq	%rax			/* pt_regs->orig_ax */
> -	pushq	%rdi			/* pt_regs->di */
> -	pushq	%rsi			/* pt_regs->si */
> -	pushq	%rdx			/* pt_regs->dx */
> -	pushq	%rcx			/* pt_regs->cx */
> -	pushq	$-ENOSYS		/* pt_regs->ax */
> -	pushq   $0			/* pt_regs->r8  = 0 */
> -	xorl	%r8d, %r8d		/* nospec   r8 */
> -	pushq   $0			/* pt_regs->r9  = 0 */
> -	xorl	%r9d, %r9d		/* nospec   r9 */
> -	pushq   $0			/* pt_regs->r10 = 0 */
> -	xorl	%r10d, %r10d		/* nospec   r10 */
> -	pushq   $0			/* pt_regs->r11 = 0 */
> -	xorl	%r11d, %r11d		/* nospec   r11 */
> -	pushq   %rbx                    /* pt_regs->rbx */
> -	xorl	%ebx, %ebx		/* nospec   rbx */
> -	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
> -	xorl	%ebp, %ebp		/* nospec   rbp */
> -	pushq   $0			/* pt_regs->r12 = 0 */
> -	xorl	%r12d, %r12d		/* nospec   r12 */
> -	pushq   $0			/* pt_regs->r13 = 0 */
> -	xorl	%r13d, %r13d		/* nospec   r13 */
> -	pushq   $0			/* pt_regs->r14 = 0 */
> -	xorl	%r14d, %r14d		/* nospec   r14 */
> -	pushq   $0			/* pt_regs->r15 = 0 */
> -	xorl	%r15d, %r15d		/* nospec   r15 */
> -
> +	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
>  	UNWIND_HINT_REGS
> 
>  	cld
> @@ -225,35 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_saf
>  SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
>  	movl	%eax, %eax		/* discard orig_ax high bits */
>  	pushq	%rax			/* pt_regs->orig_ax */
> -	pushq	%rdi			/* pt_regs->di */
> -	pushq	%rsi			/* pt_regs->si */
> -	xorl	%esi, %esi		/* nospec   si */
> -	pushq	%rdx			/* pt_regs->dx */
> -	xorl	%edx, %edx		/* nospec   dx */
> -	pushq	%rbp			/* pt_regs->cx (stashed in bp) */
> -	xorl	%ecx, %ecx		/* nospec   cx */
> -	pushq	$-ENOSYS		/* pt_regs->ax */
> -	pushq   $0			/* pt_regs->r8  = 0 */
> -	xorl	%r8d, %r8d		/* nospec   r8 */
> -	pushq   $0			/* pt_regs->r9  = 0 */
> -	xorl	%r9d, %r9d		/* nospec   r9 */
> -	pushq   $0			/* pt_regs->r10 = 0 */
> -	xorl	%r10d, %r10d		/* nospec   r10 */
> -	pushq   $0			/* pt_regs->r11 = 0 */
> -	xorl	%r11d, %r11d		/* nospec   r11 */
> -	pushq   %rbx                    /* pt_regs->rbx */
> -	xorl	%ebx, %ebx		/* nospec   rbx */
> -	pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
> -	xorl	%ebp, %ebp		/* nospec   rbp */
> -	pushq   $0			/* pt_regs->r12 = 0 */
> -	xorl	%r12d, %r12d		/* nospec   r12 */
> -	pushq   $0			/* pt_regs->r13 = 0 */
> -	xorl	%r13d, %r13d		/* nospec   r13 */
> -	pushq   $0			/* pt_regs->r14 = 0 */
> -	xorl	%r14d, %r14d		/* nospec   r14 */
> -	pushq   $0			/* pt_regs->r15 = 0 */
> -	xorl	%r15d, %r15d		/* nospec   r15 */
> -
> +	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
>  	UNWIND_HINT_REGS
> 
>  	movq	%rsp, %rdi
> @@ -381,35 +328,7 @@ SYM_CODE_START(entry_INT80_compat)
>  	pushq	1*8(%rdi)		/* regs->orig_ax */
>  	pushq	(%rdi)			/* pt_regs->di */
>  .Lint80_keep_stack:
> -
> -	pushq	%rsi			/* pt_regs->si */
> -	xorl	%esi, %esi		/* nospec   si */
> -	pushq	%rdx			/* pt_regs->dx */
> -	xorl	%edx, %edx		/* nospec   dx */
> -	pushq	%rcx			/* pt_regs->cx */
> -	xorl	%ecx, %ecx		/* nospec   cx */
> -	pushq	$-ENOSYS		/* pt_regs->ax */
> -	pushq   %r8			/* pt_regs->r8 */
> -	xorl	%r8d, %r8d		/* nospec   r8 */
> -	pushq   %r9			/* pt_regs->r9 */
> -	xorl	%r9d, %r9d		/* nospec   r9 */
> -	pushq   %r10			/* pt_regs->r10*/
> -	xorl	%r10d, %r10d		/* nospec   r10 */
> -	pushq   %r11			/* pt_regs->r11 */
> -	xorl	%r11d, %r11d		/* nospec   r11 */
> -	pushq   %rbx                    /* pt_regs->rbx */
> -	xorl	%ebx, %ebx		/* nospec   rbx */
> -	pushq   %rbp                    /* pt_regs->rbp */
> -	xorl	%ebp, %ebp		/* nospec   rbp */
> -	pushq   %r12                    /* pt_regs->r12 */
> -	xorl	%r12d, %r12d		/* nospec   r12 */
> -	pushq   %r13                    /* pt_regs->r13 */
> -	xorl	%r13d, %r13d		/* nospec   r13 */
> -	pushq   %r14                    /* pt_regs->r14 */
> -	xorl	%r14d, %r14d		/* nospec   r14 */
> -	pushq   %r15                    /* pt_regs->r15 */
> -	xorl	%r15d, %r15d		/* nospec   r15 */
> -
> +	PUSH_AND_CLEAR_REGS save_rdi=0
>  	UNWIND_HINT_REGS
> 
>  	cld
