Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521B44D3B67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiCIUwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiCIUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920FBAD101;
        Wed,  9 Mar 2022 12:51:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41A93B823D5;
        Wed,  9 Mar 2022 20:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F2C340E8;
        Wed,  9 Mar 2022 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646859081;
        bh=ZUQl8VjoXzxjjlXQpxYp7jLs7LQAHPOAzRTYa+vp71A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OA2O0miFItD1GHJrCIsLcNp/1NSkFzqK3+DHFFnITaEAz3K16E084xNgS+fnzfxuR
         1xOUjrDjKC2W01GEFNLrd6UtCBwcoNQx1x/59BO748C3St6B1LWOfWPH+PBzYjYJ+o
         hR+sXMcR/E3SuBL+qrjH1Jazsze+eG+u2vbZXxx/LWMq9jOdMGKaaazjUyW/qJDj8q
         kMjfK+iooKeaxEKd+EyX0Km6mYoUHNJythjG8Xx42lsl3z6WN68Kvz2wIbcAgsFIwn
         1EmLs2bbIFKYhVabtERmpj1z2B/wBcq9OQW+fXlWmHDN2PvaDyvH5szu2020JEA9E4
         lXKI2AZ9GqVWg==
Date:   Wed, 9 Mar 2022 13:51:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yanteng Si <siyanteng01@gmail.com>, linux-mips@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MIPS: Only use current_stack_pointer on GCC
Message-ID: <YikTQRql+il3HbrK@dev-arch.thelio-3990X>
References: <20220309204537.390428-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309204537.390428-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: I think the subject needs to be updated (I assume this was written
before Nick's fix?).

On Wed, Mar 09, 2022 at 12:45:37PM -0800, Kees Cook wrote:
> Unfortunately, Clang did not have support for "sp" as a global register
> definition, and was crashing after the addition of current_stack_pointer.
> This has been fixed in Clang 15, but earlier Clang versions need to
> avoid this code, so add a versioned test and revert back to the
> open-coded asm instances. Fixes Clang build error:
> 
> fatal error: error in backend: Invalid register name global variable
> 
> Fixes: 200ed341b864 ("mips: Implement "current_stack_pointer"")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Yanteng Si <siyanteng01@gmail.com>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for sending this!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/mips/Kconfig                   | 2 +-
>  arch/mips/include/asm/thread_info.h | 2 ++
>  arch/mips/kernel/irq.c              | 3 ++-
>  arch/mips/lib/uncached.c            | 4 +++-
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 3f58b45fc953..15769013f46e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -4,7 +4,7 @@ config MIPS
>  	default y
>  	select ARCH_32BIT_OFF_T if !64BIT
>  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
> -	select ARCH_HAS_CURRENT_STACK_POINTER
> +	select ARCH_HAS_CURRENT_STACK_POINTER if !CC_IS_CLANG || CLANG_VERSION >= 150000

Nit: This can be 140000, as release/14.x has received the fix:

https://github.com/llvm/llvm-project/commit/0826716786cd4a8c7cbcb8c01e4d9fac46b7a17a

>  	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_KCOV
> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
> index 4463348d2372..ecae7470faa4 100644
> --- a/arch/mips/include/asm/thread_info.h
> +++ b/arch/mips/include/asm/thread_info.h
> @@ -69,7 +69,9 @@ static inline struct thread_info *current_thread_info(void)
>  	return __current_thread_info;
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
>  register unsigned long current_stack_pointer __asm__("sp");
> +#endif
>  
>  #endif /* !__ASSEMBLY__ */
>  
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index fc313c49a417..5e11582fe308 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -75,8 +75,9 @@ void __init init_IRQ(void)
>  #ifdef CONFIG_DEBUG_STACKOVERFLOW
>  static inline void check_stack_overflow(void)
>  {
> -	unsigned long sp = current_stack_pointer;
> +	unsigned long sp;
>  
> +	__asm__ __volatile__("move %0, $sp" : "=r" (sp));
>  	sp &= THREAD_MASK;
>  
>  	/*
> diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
> index f8d4ca046c3e..f80a67c092b6 100644
> --- a/arch/mips/lib/uncached.c
> +++ b/arch/mips/lib/uncached.c
> @@ -40,7 +40,9 @@ unsigned long run_uncached(void *func)
>  	register long ret __asm__("$2");
>  	long lfunc = (long)func, ufunc;
>  	long usp;
> -	long sp = current_stack_pointer;
> +	long sp;
> +
> +	__asm__("move %0, $sp" : "=r" (sp));
>  
>  	if (sp >= (long)CKSEG0 && sp < (long)CKSEG2)
>  		usp = CKSEG1ADDR(sp);
> -- 
> 2.32.0
> 
