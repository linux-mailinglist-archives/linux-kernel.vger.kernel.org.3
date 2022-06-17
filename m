Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D395C54F348
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381141AbiFQIn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381080AbiFQInw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:43:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DCAC69483
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:43:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C51E12FC;
        Fri, 17 Jun 2022 01:43:51 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAF43F792;
        Fri, 17 Jun 2022 01:43:47 -0700 (PDT)
Date:   Fri, 17 Jun 2022 09:43:44 +0100
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
Subject: Re: [PATCH -next v5 4/8] arm64: extable: cleanup redundant extable
 type EX_TYPE_FIXUP
Message-ID: <Yqw+wKSUFMZN5P/M@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-5-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528065056.1034168-5-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:50:52AM +0000, Tong Tiangen wrote:
> Currently, extable type EX_TYPE_FIXUP is no place to use, We can safely
> remove it.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/asm-extable.h | 20 ++++----------------
>  arch/arm64/mm/extable.c              |  9 ---------
>  2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
> index d01bd94cc4c2..1f2974467273 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -3,11 +3,10 @@
>  #define __ASM_ASM_EXTABLE_H
>  
>  #define EX_TYPE_NONE			0
> -#define EX_TYPE_FIXUP			1
> -#define EX_TYPE_BPF			2
> -#define EX_TYPE_UACCESS_ERR_ZERO	3
> -#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
> -#define EX_TYPE_KACCESS_ERR_ZERO	5
> +#define EX_TYPE_BPF			1
> +#define EX_TYPE_UACCESS_ERR_ZERO	2
> +#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	3
> +#define EX_TYPE_KACCESS_ERR_ZERO	4
>  
>  #ifdef __ASSEMBLY__
>  
> @@ -20,14 +19,6 @@
>  	.short		(data);				\
>  	.popsection;
>  
> -/*
> - * Create an exception table entry for `insn`, which will branch to `fixup`
> - * when an unhandled fault is taken.
> - */
> -	.macro		_asm_extable, insn, fixup
> -	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
> -	.endm
> -
>  /*
>   * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
>   * when an unhandled fault is taken.
> @@ -62,9 +53,6 @@
>  	".short		(" data ")\n"			\
>  	".popsection\n"
>  
> -#define _ASM_EXTABLE(insn, fixup) \
> -	__ASM_EXTABLE_RAW(#insn, #fixup, __stringify(EX_TYPE_FIXUP), "0")
> -
>  #define EX_DATA_REG_ERR_SHIFT	0
>  #define EX_DATA_REG_ERR		GENMASK(4, 0)
>  #define EX_DATA_REG_ZERO_SHIFT	5
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 056591e5ca80..228d681a8715 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -16,13 +16,6 @@ get_ex_fixup(const struct exception_table_entry *ex)
>  	return ((unsigned long)&ex->fixup + ex->fixup);
>  }
>  
> -static bool ex_handler_fixup(const struct exception_table_entry *ex,
> -			     struct pt_regs *regs)
> -{
> -	regs->pc = get_ex_fixup(ex);
> -	return true;
> -}
> -
>  static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
>  					struct pt_regs *regs)
>  {
> @@ -72,8 +65,6 @@ bool fixup_exception(struct pt_regs *regs)
>  		return false;
>  
>  	switch (ex->type) {
> -	case EX_TYPE_FIXUP:
> -		return ex_handler_fixup(ex, regs);
>  	case EX_TYPE_BPF:
>  		return ex_handler_bpf(ex, regs);
>  	case EX_TYPE_UACCESS_ERR_ZERO:
> -- 
> 2.25.1
> 
