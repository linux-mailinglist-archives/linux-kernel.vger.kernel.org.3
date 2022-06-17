Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704DC54F2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380922AbiFQIbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381016AbiFQIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:31:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C5B69288
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:31:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 537851570;
        Fri, 17 Jun 2022 01:31:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D02323F792;
        Fri, 17 Jun 2022 01:31:35 -0700 (PDT)
Date:   Fri, 17 Jun 2022 09:31:32 +0100
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
Subject: Re: [PATCH -next v5 3/8] arm64: extable: move _cond_extable to
 _cond_uaccess_extable
Message-ID: <Yqw75OjpUHb1eYBR@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-4-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528065056.1034168-4-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:50:51AM +0000, Tong Tiangen wrote:
> Currently, We use _cond_extable for cache maintenance uaccess helper
> caches_clean_inval_user_pou(), so this should be moved over to
> EX_TYPE_UACCESS_ERR_ZERO and rename _cond_extable to _cond_uaccess_extable
> for clarity.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/asm-extable.h | 6 +++---
>  arch/arm64/include/asm/assembler.h   | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
> index 9c94ac1f082c..d01bd94cc4c2 100644
> --- a/arch/arm64/include/asm/asm-extable.h
> +++ b/arch/arm64/include/asm/asm-extable.h
> @@ -40,9 +40,9 @@
>   * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
>   * do nothing.
>   */
> -	.macro		_cond_extable, insn, fixup
> -	.ifnc		\fixup,
> -	_asm_extable	\insn, \fixup
> +	.macro		_cond_uaccess_extable, insn, fixup
> +	.ifnc			\fixup,
> +	_asm_extable_uaccess	\insn, \fixup
>  	.endif
>  	.endm
>  
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 8c5a61aeaf8e..dc422fa437c2 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -423,7 +423,7 @@ alternative_endif
>  	b.lo	.Ldcache_op\@
>  	dsb	\domain
>  
> -	_cond_extable .Ldcache_op\@, \fixup
> +	_cond_uaccess_extable .Ldcache_op\@, \fixup
>  	.endm
>  
>  /*
> @@ -462,7 +462,7 @@ alternative_endif
>  	dsb	ish
>  	isb
>  
> -	_cond_extable .Licache_op\@, \fixup
> +	_cond_uaccess_extable .Licache_op\@, \fixup
>  	.endm
>  
>  /*
> -- 
> 2.25.1
> 
