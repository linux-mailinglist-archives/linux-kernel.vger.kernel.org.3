Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9310054F2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380912AbiFQIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380867AbiFQIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:24:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118A064BE9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:24:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA8681474;
        Fri, 17 Jun 2022 01:24:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6193F792;
        Fri, 17 Jun 2022 01:24:47 -0700 (PDT)
Date:   Fri, 17 Jun 2022 09:24:44 +0100
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
Subject: Re: [PATCH -next v5 2/8] arm64: extable: make uaaccess helper use
 extable type EX_TYPE_UACCESS_ERR_ZERO
Message-ID: <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-3-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528065056.1034168-3-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:50:50AM +0000, Tong Tiangen wrote:
> Currnetly, the extable type used by __arch_copy_from/to_user() is
> EX_TYPE_FIXUP. In fact, It is more clearly to use meaningful
> EX_TYPE_UACCESS_*.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/include/asm/asm-extable.h |  8 ++++++++
>  arch/arm64/include/asm/asm-uaccess.h | 12 ++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
> index 56ebe183e78b..9c94ac1f082c 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -28,6 +28,14 @@
>  	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
>  	.endm
>  
> +/*
> + * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
> + * when an unhandled fault is taken.
> + * ex->data = ~0 means both reg_err and reg_zero is set to wzr(x31).
> + */
> +	.macro          _asm_extable_uaccess, insn, fixup
> +	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_ERR_ZERO, ~0)
> +	.endm

I'm not too keen on using `~0` here, since that also sets other bits in the
data field, and its somewhat opaque.

How painful is it to generate the data fields as with the C version of this
macro, so that we can pass in wzr explciitly for the two sub-fields?

Other than that, this looks good to me.

Thanks,
Mark.

>  /*
>   * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
>   * do nothing.
> diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
> index 0557af834e03..75b211c98dea 100644
> --- a/arch/arm64/include/asm/asm-uaccess.h
> +++ b/arch/arm64/include/asm/asm-uaccess.h
> @@ -61,7 +61,7 @@ alternative_else_nop_endif
>  
>  #define USER(l, x...)				\
>  9999:	x;					\
> -	_asm_extable	9999b, l
> +	_asm_extable_uaccess	9999b, l
>  
>  /*
>   * Generate the assembly for LDTR/STTR with exception table entries.
> @@ -73,8 +73,8 @@ alternative_else_nop_endif
>  8889:		ldtr	\reg2, [\addr, #8];
>  		add	\addr, \addr, \post_inc;
>  
> -		_asm_extable	8888b,\l;
> -		_asm_extable	8889b,\l;
> +		_asm_extable_uaccess	8888b, \l;
> +		_asm_extable_uaccess	8889b, \l;
>  	.endm
>  
>  	.macro user_stp l, reg1, reg2, addr, post_inc
> @@ -82,14 +82,14 @@ alternative_else_nop_endif
>  8889:		sttr	\reg2, [\addr, #8];
>  		add	\addr, \addr, \post_inc;
>  
> -		_asm_extable	8888b,\l;
> -		_asm_extable	8889b,\l;
> +		_asm_extable_uaccess	8888b,\l;
> +		_asm_extable_uaccess	8889b,\l;
>  	.endm
>  
>  	.macro user_ldst l, inst, reg, addr, post_inc
>  8888:		\inst		\reg, [\addr];
>  		add		\addr, \addr, \post_inc;
>  
> -		_asm_extable	8888b,\l;
> +		_asm_extable_uaccess	8888b, \l;
>  	.endm
>  #endif
> -- 
> 2.25.1
> 
