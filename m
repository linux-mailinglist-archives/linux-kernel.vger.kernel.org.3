Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2554F3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380558AbiFQJHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381479AbiFQJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:07:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75E6650472
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:07:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6D612FC;
        Fri, 17 Jun 2022 02:07:02 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27AD3F792;
        Fri, 17 Jun 2022 02:06:58 -0700 (PDT)
Date:   Fri, 17 Jun 2022 10:06:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 7/8] arm64: add uaccess to machine check safe
Message-ID: <YqxELtYkqQNibHaX@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-8-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528065056.1034168-8-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:50:55AM +0000, Tong Tiangen wrote:
> If user access fail due to hardware memory error, only the relevant
> processes are affected, so killing the user process and isolate the
> error page with hardware memory errors is a more reasonable choice
> than kernel panic.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

> ---
>  arch/arm64/lib/copy_from_user.S | 8 ++++----
>  arch/arm64/lib/copy_to_user.S   | 8 ++++----

All of these changes are to the *kernel* accesses performed as part of copy
to/from user, and have nothing to do with userspace, so it does not make sense
to mark these as UACCESS.

Do we *actually* need to recover from failues on these accesses? Looking at
_copy_from_user(), the kernel will immediately follow this up with a memset()
to the same address which will be fatal anyway, so this is only punting the
failure for a few instructions.

If we really need to recover from certain accesses to kernel memory we should
add a new EX_TYPE_KACCESS_ERR_ZERO_MC or similar, but we need a strong
rationale as to why that's useful. As things stand I do not beleive it makes
sense for copy to/from user specifically.

>  arch/arm64/mm/extable.c         | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 34e317907524..402dd48a4f93 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -25,7 +25,7 @@
>  	.endm
>  
>  	.macro strb1 reg, ptr, val
> -	strb \reg, [\ptr], \val
> +	USER(9998f, strb \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro ldrh1 reg, ptr, val
> @@ -33,7 +33,7 @@
>  	.endm
>  
>  	.macro strh1 reg, ptr, val
> -	strh \reg, [\ptr], \val
> +	USER(9998f, strh \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro ldr1 reg, ptr, val
> @@ -41,7 +41,7 @@
>  	.endm
>  
>  	.macro str1 reg, ptr, val
> -	str \reg, [\ptr], \val
> +	USER(9998f, str \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro ldp1 reg1, reg2, ptr, val
> @@ -49,7 +49,7 @@
>  	.endm
>  
>  	.macro stp1 reg1, reg2, ptr, val
> -	stp \reg1, \reg2, [\ptr], \val
> +	USER(9998f, stp \reg1, \reg2, [\ptr], \val)
>  	.endm
>  
>  end	.req	x5
> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 802231772608..4134bdb3a8b0 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -20,7 +20,7 @@
>   *	x0 - bytes not copied
>   */
>  	.macro ldrb1 reg, ptr, val
> -	ldrb  \reg, [\ptr], \val
> +	USER(9998f, ldrb  \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro strb1 reg, ptr, val
> @@ -28,7 +28,7 @@
>  	.endm
>  
>  	.macro ldrh1 reg, ptr, val
> -	ldrh  \reg, [\ptr], \val
> +	USER(9998f, ldrh  \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro strh1 reg, ptr, val
> @@ -36,7 +36,7 @@
>  	.endm
>  
>  	.macro ldr1 reg, ptr, val
> -	ldr \reg, [\ptr], \val
> +	USER(9998f, ldr \reg, [\ptr], \val)
>  	.endm
>  
>  	.macro str1 reg, ptr, val
> @@ -44,7 +44,7 @@
>  	.endm
>  
>  	.macro ldp1 reg1, reg2, ptr, val
> -	ldp \reg1, \reg2, [\ptr], \val
> +	USER(9998f, ldp \reg1, \reg2, [\ptr], \val)
>  	.endm
>  
>  	.macro stp1 reg1, reg2, ptr, val
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index c301dcf6335f..8ca8d9639f9f 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -86,10 +86,10 @@ bool fixup_exception_mc(struct pt_regs *regs)
>  	if (!ex)
>  		return false;
>  
> -	/*
> -	 * This is not complete, More Machine check safe extable type can
> -	 * be processed here.
> -	 */
> +	switch (ex->type) {
> +	case EX_TYPE_UACCESS_ERR_ZERO:
> +		return ex_handler_uaccess_err_zero(ex, regs);
> +	}

This addition specifically makes sense to me, so can you split this into a separate patch?

Thanks,
Mark.
