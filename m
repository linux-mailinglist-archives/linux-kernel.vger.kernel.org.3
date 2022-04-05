Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7A4F5271
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390058AbiDFCtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585494AbiDEX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C5403D7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 15:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10C76190D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA40C385A0;
        Tue,  5 Apr 2022 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649197242;
        bh=qJghuGy/OuEqalpvRzR2kBCn0g3XnrF0PtfYrf8Qnho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEIBisQvUi2erYjNPoIy9BoeCr8KLxb26lSWeFpx5gGe2SeeYU9nkopCf90wWxg/v
         RyV8YdIEIh5Pu9r3D8Pg78/08K26fFvnn0ONOh/Xxo1xBUxsGOr6clGX1QfidivmUG
         35huDiCvB6dke3UbzIWt3oYTUC8FXIk5LMn6GIrkkZbtJI1j41EM8LUMBepuGwHNMZ
         u7wO/3lkKQfQIQh+tLoJ1WCYX0dQVXYgB3kOKydJ5KWyFtR2QLMtNLszbFXl4O4/xF
         dVpadq7flnYzS03d2nU5ql5kg5L0MoDQCYJKxDvs3tpguA+64XRZwvZ4eQQDV+9ZVA
         JV1ntbdelGbZg==
Date:   Tue, 5 Apr 2022 15:20:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] cfi: Use __builtin_function_start
Message-ID: <YkzAtwW4KtZ22ySb@thelio-3990X>
References: <20220405221618.633743-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405221618.633743-1-samitolvanen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 03:16:18PM -0700, Sami Tolvanen wrote:
> Clang 14 added support for the __builtin_function_start function,
> which allows us to implement the function_nocfi macro without
> architecture-specific inline assembly and in a way that also works
> with static initializers.
> 
> Change CONFIG_CFI_CLANG to depend on Clang >= 14, define
> function_nocfi using __builtin_function_start, and remove the arm64
> inline assembly implementation.
> 
> Link: https://github.com/llvm/llvm-project/commit/ec2e26eaf63558934f5b73a6e530edc453cf9508
> Link: https://github.com/ClangBuiltLinux/linux/issues/1353
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v2:
> - Changed CFI_CLANG to depend on Clang 14 instead of
>   __builtin_function_start.
> - Squashed all three patches into one.
> 
> ---
>  arch/Kconfig                      |  5 +----
>  arch/arm64/include/asm/compiler.h | 16 ----------------
>  include/linux/compiler-clang.h    | 10 ++++++++++
>  3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 29b0167c088b..c1627bce4a3a 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -723,10 +723,7 @@ config ARCH_SUPPORTS_CFI_CLANG
>  config CFI_CLANG
>  	bool "Use Clang's Control Flow Integrity (CFI)"
>  	depends on LTO_CLANG && ARCH_SUPPORTS_CFI_CLANG
> -	# Clang >= 12:
> -	# - https://bugs.llvm.org/show_bug.cgi?id=46258
> -	# - https://bugs.llvm.org/show_bug.cgi?id=47479
> -	depends on CLANG_VERSION >= 120000
> +	depends on CLANG_VERSION >= 140000
>  	select KALLSYMS
>  	help
>  	  This option enables Clang’s forward-edge Control Flow Integrity
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index dc3ea4080e2e..6fb2e6bcc392 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -23,20 +23,4 @@
>  #define __builtin_return_address(val)					\
>  	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
>  
> -#ifdef CONFIG_CFI_CLANG
> -/*
> - * With CONFIG_CFI_CLANG, the compiler replaces function address
> - * references with the address of the function's CFI jump table
> - * entry. The function_nocfi macro always returns the address of the
> - * actual function instead.
> - */
> -#define function_nocfi(x) ({						\
> -	void *addr;							\
> -	asm("adrp %0, " __stringify(x) "\n\t"				\
> -	    "add  %0, %0, :lo12:" __stringify(x)			\
> -	    : "=r" (addr));						\
> -	addr;								\
> -})
> -#endif
> -
>  #endif /* __ASM_COMPILER_H */
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index babb1347148c..c84fec767445 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -69,6 +69,16 @@
>  #define __nocfi		__attribute__((__no_sanitize__("cfi")))
>  #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
>  
> +#if defined(CONFIG_CFI_CLANG)
> +/*
> + * With CONFIG_CFI_CLANG, the compiler replaces function address
> + * references with the address of the function's CFI jump table
> + * entry. The function_nocfi macro always returns the address of the
> + * actual function instead.
> + */
> +#define function_nocfi(x)	__builtin_function_start(x)
> +#endif
> +
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> -- 
> 2.35.1.1094.g7c7d902a7c-goog
> 
