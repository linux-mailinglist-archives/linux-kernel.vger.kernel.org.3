Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888C526653
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382155AbiEMPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382158AbiEMPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:39:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A85435DEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:39:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF5B113E;
        Fri, 13 May 2022 08:39:33 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC80A3F73D;
        Fri, 13 May 2022 08:39:30 -0700 (PDT)
Date:   Fri, 13 May 2022 16:39:28 +0100
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
Subject: Re: [PATCH -next v4 6/7] arm64: add {get, put}_user to machine check
 safe
Message-ID: <Yn57sGpZPo90EXkE@lakrids>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-7-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420030418.3189040-7-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:04:17AM +0000, Tong Tiangen wrote:
> Add {get, put}_user() to machine check safe.
> 
> If get/put fail due to hardware memory error, only the relevant processes
> are affected, so killing the user process and isolate the user page with
> hardware memory errors is a more reasonable choice than kernel panic.
> 
> Add new extable type EX_TYPE_UACCESS_MC_ERR_ZERO which can be used for
> uaccess that can be recovered from hardware memory errors. The difference
> from EX_TYPE_UACCESS_MC is that this type also sets additional two target
> register which save error code and value needs to be set zero.

Why does this need to be in any way distinct from the existing
EX_TYPE_UACCESS_ERR_ZERO ?

Other than the case where we currently (ab)use that for
copy_{to,from}_kernel_nofault(), where do we *not* want to use
EX_TYPE_UACCESS_ERR_ZERO and *not* recover from a memory error?

Thanks,
Mark.

> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/include/asm/asm-extable.h | 14 ++++++++++++++
>  arch/arm64/include/asm/uaccess.h     |  4 ++--
>  arch/arm64/mm/extable.c              |  4 ++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
> index 75b2c00e9523..80410899a9ad 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -13,6 +13,7 @@
>  
>  /* _MC indicates that can fixup from machine check errors */
>  #define EX_TYPE_UACCESS_MC		5
> +#define EX_TYPE_UACCESS_MC_ERR_ZERO	6
>  
>  #ifdef __ASSEMBLY__
>  
> @@ -78,6 +79,15 @@
>  #define EX_DATA_REG(reg, gpr)						\
>  	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
>  
> +#define _ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, zero)		\
> +	__DEFINE_ASM_GPR_NUMS							\
> +	__ASM_EXTABLE_RAW(#insn, #fixup,					\
> +			  __stringify(EX_TYPE_UACCESS_MC_ERR_ZERO),		\
> +			  "("							\
> +			    EX_DATA_REG(ERR, err) " | "				\
> +			    EX_DATA_REG(ZERO, zero)				\
> +			  ")")
> +
>  #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
>  	__DEFINE_ASM_GPR_NUMS						\
>  	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
> @@ -90,6 +100,10 @@
>  #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
>  	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
>  
> +
> +#define _ASM_EXTABLE_UACCESS_MC_ERR(insn, fixup, err)			\
> +	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, wzr)
> +
>  #define EX_DATA_REG_DATA_SHIFT	0
>  #define EX_DATA_REG_DATA	GENMASK(4, 0)
>  #define EX_DATA_REG_ADDR_SHIFT	5
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index e8dce0cc5eaa..e41b47df48b0 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
>  	asm volatile(							\
>  	"1:	" load "	" reg "1, [%2]\n"			\
>  	"2:\n"								\
> -	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
> +	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(1b, 2b, %w0, %w1)		\
>  	: "+r" (err), "=&r" (x)						\
>  	: "r" (addr))
>  
> @@ -325,7 +325,7 @@ do {									\
>  	asm volatile(							\
>  	"1:	" store "	" reg "1, [%2]\n"			\
>  	"2:\n"								\
> -	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
> +	_ASM_EXTABLE_UACCESS_MC_ERR(1b, 2b, %w0)			\
>  	: "+r" (err)							\
>  	: "r" (x), "r" (addr))
>  
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 525876c3ebf4..1023ccdb2f89 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -88,6 +88,7 @@ bool fixup_exception(struct pt_regs *regs)
>  	case EX_TYPE_BPF:
>  		return ex_handler_bpf(ex, regs);
>  	case EX_TYPE_UACCESS_ERR_ZERO:
> +	case EX_TYPE_UACCESS_MC_ERR_ZERO:
>  		return ex_handler_uaccess_err_zero(ex, regs);
>  	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
>  		return ex_handler_load_unaligned_zeropad(ex, regs);
> @@ -107,6 +108,9 @@ bool fixup_exception_mc(struct pt_regs *regs)
>  	switch (ex->type) {
>  	case EX_TYPE_UACCESS_MC:
>  		return ex_handler_uaccess_type(ex, regs, FIXUP_TYPE_MC);
> +	case EX_TYPE_UACCESS_MC_ERR_ZERO:
> +		return ex_handler_uaccess_err_zero(ex, regs);
> +
>  	}
>  
>  	return false;
> -- 
> 2.25.1
> 
