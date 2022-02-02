Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC64A6905
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiBBAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:05:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42960 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbiBBAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:04:36 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643760274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neBd7VsOMbUMFR6PMS7C+obWvPyp6JMYXI1ks/Y8WS4=;
        b=dcCV8sMFSZH7L7FQNrYo1AUakKq5AbOQmnfxqUvU9on3uX6bp40g5kQN7hF8NhCsAzQH+h
        GsxTb2ZmWCWDQFMUOcdskrq9c21B8SIFDFp0aq8samN3F5tyaAuqBxegEyN49F3m0OaQPo
        1rgnXSqOqaCjJJyQaAL+u8+8xE+5Hag01TrP1/J+OTOXrWDC3F46eSMeAD2Bete7LztCSv
        zRwRA0ihlA1Ngq77EuKOa0Pgw2lN3+MW3mqzjQGQcLA8cWbpDVA7ycWAzN2nIHoLn0SVim
        jtKXfqYe54wvxNQ+7rmuegljYQHa2cvbZYLKltz3MrREiOm3Gw+Ad4x9chHIZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643760274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=neBd7VsOMbUMFR6PMS7C+obWvPyp6JMYXI1ks/Y8WS4=;
        b=MpsRx+4r4+E3ehAA+L0k0ph8Kk7tgPP0iLJ6RzLPZazdxY1UzlZ0Tf90dcn3VG9YvR2+y5
        byN9vTij0kJX6IAg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 18/29] x86/boot: Avoid #VE during boot for TDX platforms
In-Reply-To: <20220124150215.36893-19-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-19-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:04:34 +0100
Message-ID: <87sft2w2ul.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>
> Change the common boot code to work on TDX and non-TDX systems.
> This should have no functional effect on non-TDX systems.

Emphasis on should? :)

> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -643,12 +643,25 @@ SYM_CODE_START(trampoline_32bit_src)
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
>  	btsl	$_EFER_LME, %eax
> +	/* Avoid writing EFER if no change was made (for TDX guest) */
> +	jc	1f
>  	wrmsr
> -	popl	%edx
> +1:	popl	%edx
>  	popl	%ecx
>  
>  	/* Enable PAE and LA57 (if required) paging modes */

This comment should move after the #endif below and here it wants a
comment which explains why reading cr4 and the following code sequence
is correct. If you write up that comment then you'll figure out that it
is incorrect.

> -	movl	$X86_CR4_PAE, %eax
> +	movl	%cr4, %eax

Assume CR4 has X86_CR4_MCE set then how is the below correct when
CONFIG_X86_MCE=n? Not to talk about any other bits which might be set in
CR4 and are only cleared by the CONFIG_X86_MCE dependent 'andl'.

> +#ifdef CONFIG_X86_MCE
> +	/*
> +	 * Preserve CR4.MCE if the kernel will enable #MC support.  Clearing
> +	 * MCE may fault in some environments (that also force #MC support).
> +	 * Any machine check that occurs before #MC support is fully configured
> +	 * will crash the system regardless of the CR4.MCE value set here.
> +	 */
> +	andl	$X86_CR4_MCE, %eax
> +#endif

So this wants to be

#ifdef CONFIG_X86_MCE
	movl	%cr4, %eax
	andl	$X86_CR4_MCE, %eax
#else
	movl	$0, %eax
#endif

No?

> +	orl	$X86_CR4_PAE, %eax
>  	testl	%edx, %edx
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> @@ -662,8 +675,12 @@ SYM_CODE_START(trampoline_32bit_src)
>  	pushl	$__KERNEL_CS
>  	pushl	%eax
>  
> -	/* Enable paging again */
> -	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
> +	/*
> +	 * Enable paging again.  Keep CR0.NE set, FERR# is no longer used
> +	 * to handle x87 FPU errors and clearing NE may fault in some
> +	 * environments.

FERR# is no longer used is really not informative here. The point is
that any x86 CPU which is supported by the kernel requires CR0_NE to be
set. This code was wrong from the very beginning because 64bit CPUs
never supported #FERR. The reason why it exists is Copy&Pasta without
brain applied and the sad fact that the hardware does not enforce it in
native mode for whatever reason. So this want's to be a seperate patch
with a coherent comment and changelong.

> +	 */
> +	movl	$(X86_CR0_PG | X86_CR0_NE | X86_CR0_PE), %eax
>  	movl	%eax, %cr0
>  
>  	/* Enable PAE mode, PGE and LA57 */
> -	movl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
> +	movq	%cr4, %rcx

See above...

> +#ifdef CONFIG_X86_MCE
> +	/*
> +	 * Preserve CR4.MCE if the kernel will enable #MC support.  Clearing
> +	 * MCE may fault in some environments (that also force #MC support).
> +	 * Any machine check that occurs before #MC support is fully configured
> +	 * will crash the system regardless of the CR4.MCE value set here.
> +	 */
> +	andl	$X86_CR4_MCE, %ecx
> +#endif
> +	orl	$(X86_CR4_PAE | X86_CR4_PGE), %ecx
>  #ifdef CONFIG_X86_5LEVEL
>  	testl	$1, __pgtable_l5_enabled(%rip)
>  	jz	1f
> @@ -246,13 +256,23 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	/* Setup EFER (Extended Feature Enable Register) */
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
> +	/*
> +	 * Preserve current value of EFER for comparison and to skip
> +	 * EFER writes if no change was made (for TDX guest)
> +	 */
> +	movl    %eax, %edx
>  	btsl	$_EFER_SCE, %eax	/* Enable System Call */
>  	btl	$20,%edi		/* No Execute supported? */
>  	jnc     1f
>  	btsl	$_EFER_NX, %eax
>  	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
> -1:	wrmsr				/* Make changes effective */
>  
> +	/* Avoid writing EFER if no change was made (for TDX guest) */
> +1:	cmpl	%edx, %eax
> +	je	1f
> +	xor	%edx, %edx
> +	wrmsr				/* Make changes effective */
> +1:
>  	/* Setup cr0 */
>  	movl	$CR0_STATE, %eax
>  	/* Make changes effective */
> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
> index ae112a91592f..170f248d5769 100644
> --- a/arch/x86/realmode/rm/trampoline_64.S
> +++ b/arch/x86/realmode/rm/trampoline_64.S
> @@ -143,13 +143,28 @@ SYM_CODE_START(startup_32)
>  	movl	%eax, %cr3
>  
>  	# Set up EFER
> +	movl	$MSR_EFER, %ecx
> +	rdmsr
> +	/*
> +	 * Skip writing to EFER if the register already has desired
> +	 * value (to avoid #VE for the TDX guest).
> +	 */
> +	cmp	pa_tr_efer, %eax
> +	jne	.Lwrite_efer
> +	cmp	pa_tr_efer + 4, %edx
> +	je	.Ldone_efer
> +.Lwrite_efer:
>  	movl	pa_tr_efer, %eax
>  	movl	pa_tr_efer + 4, %edx
> -	movl	$MSR_EFER, %ecx
>  	wrmsr
>  
> -	# Enable paging and in turn activate Long Mode
> -	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_PE), %eax
> +.Ldone_efer:
> +	/*
> +	 * Enable paging and in turn activate Long Mode. Keep CR0.NE set, FERR#
> +	 * is no longer used to handle x87 FPU errors and clearing NE may fault
> +	 * in some environments.
> +	 */
> +	movl	$(X86_CR0_PG | X86_CR0_WP | X86_CR0_NE | X86_CR0_PE),
> %eax

See above.

>  	movl	%eax, %cr0
>  
>  	/*
> @@ -169,7 +184,11 @@ SYM_CODE_START(pa_trampoline_compat)
>  	movl	$rm_stack_end, %esp
>  	movw	$__KERNEL_DS, %dx
>  
> -	movl	$X86_CR0_PE, %eax
> +	/*
> +	 * Keep CR0.NE set, FERR# is no longer used to handle x87 FPU errors
> +	 * and clearing NE may fault in some environments.
> +	 */
> +	movl	$(X86_CR0_NE | X86_CR0_PE), %eax

Ditto.

>  	movl	%eax, %cr0
>  	ljmpl   $__KERNEL32_CS, $pa_startup_32
>  SYM_CODE_END(pa_trampoline_compat)

Thanks,

        tglx
