Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF54F60A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiDFNuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiDFNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:49:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC3096D8DD2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:19:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 529C223A;
        Wed,  6 Apr 2022 04:19:54 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.10.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FC43F718;
        Wed,  6 Apr 2022 04:19:52 -0700 (PDT)
Date:   Wed, 6 Apr 2022 12:19:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH -next V2 4/7] arm64: add copy_from_user to machine
 check safe
Message-ID: <Yk13VJwih44VsCGk@FVFF77S0Q05N>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-5-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406091311.3354723-5-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:13:08AM +0000, Tong Tiangen wrote:
> Add scenarios copy_from_user to machine check safe.
> 
> The data copied is user data and is machine check safe, so just kill
> the user process and isolate the error page, not necessary panic.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/include/asm/asm-uaccess.h | 16 ++++++++++++++++
>  arch/arm64/lib/copy_from_user.S      | 11 ++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 0557af834e03..f31c8978e1af 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -92,4 +92,20 @@ alternative_else_nop_endif
>  
>  		_asm_extable	8888b,\l;
>  	.endm
> +
> +	.macro user_ldp_mc l, reg1, reg2, addr, post_inc
> +8888:		ldtr	\reg1, [\addr];
> +8889:		ldtr	\reg2, [\addr, #8];
> +		add	\addr, \addr, \post_inc;
> +
> +		_asm_extable_mc	8888b, \l;
> +		_asm_extable_mc	8889b, \l;
> +	.endm
> +
> +	.macro user_ldst_mc l, inst, reg, addr, post_inc
> +8888:		\inst		\reg, [\addr];
> +		add		\addr, \addr, \post_inc;
> +
> +		_asm_extable_mc	8888b, \l;
> +	.endm
>  #endif
> diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
> index 34e317907524..d9d7c5291871 100644
> --- a/arch/arm64/lib/copy_from_user.S
> +++ b/arch/arm64/lib/copy_from_user.S
> @@ -21,7 +21,7 @@
>   */
>  
>  	.macro ldrb1 reg, ptr, val
> -	user_ldst 9998f, ldtrb, \reg, \ptr, \val
> +	user_ldst_mc 9998f, ldtrb, \reg, \ptr, \val
>  	.endm
>  
>  	.macro strb1 reg, ptr, val
> @@ -29,7 +29,7 @@
>  	.endm
>  
>  	.macro ldrh1 reg, ptr, val
> -	user_ldst 9997f, ldtrh, \reg, \ptr, \val
> +	user_ldst_mc 9997f, ldtrh, \reg, \ptr, \val
>  	.endm
>  
>  	.macro strh1 reg, ptr, val
> @@ -37,7 +37,7 @@
>  	.endm
>  
>  	.macro ldr1 reg, ptr, val
> -	user_ldst 9997f, ldtr, \reg, \ptr, \val
> +	user_ldst_mc 9997f, ldtr, \reg, \ptr, \val
>  	.endm
>  
>  	.macro str1 reg, ptr, val
> @@ -45,7 +45,7 @@
>  	.endm
>  
>  	.macro ldp1 reg1, reg2, ptr, val
> -	user_ldp 9997f, \reg1, \reg2, \ptr, \val
> +	user_ldp_mc 9997f, \reg1, \reg2, \ptr, \val
>  	.endm
>  
>  	.macro stp1 reg1, reg2, ptr, val
> @@ -62,7 +62,8 @@ SYM_FUNC_START(__arch_copy_from_user)
>  	ret
>  
>  	// Exception fixups
> -9997:	cmp	dst, dstin
> +9997:	cbz	x0, 9998f			// Check machine check exception
> +	cmp	dst, dstin
>  	b.ne	9998f

If you look at the copy template, you'd see that `dstin` *is* x0.

Consier if we took a non-SEA fault. The the fixup handler will overwrite x0,
it's likely `dst` != `dstin`, and we'll branch to the byte-by-byte copy. Or if
we're doing something odd and mmap_min_addr is 0, we can do the wrong thing the
other way around and *not* branch to the byte-by-byte copy when we should.

So this is at best confusing, but likely broken too.

Thanks,
Mark.

>  	// Before being absolutely sure we couldn't copy anything, try harder
>  USER(9998f, ldtrb tmp1w, [srcin])
> -- 
> 2.18.0.huawei.25
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
