Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0493B4A004C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbiA1SqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbiA1SqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79762C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 10:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B44E61D0D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 18:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8B3C340E6;
        Fri, 28 Jan 2022 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643395561;
        bh=tmg5tqWxrNUjL1aQmmYQBWTKs6R9ohKioeAuiOX9yVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbUpNxC2KlnIW8Zf7qUELgsBoXzne8oOqLQQqyG7KGdmdVQjYOYhJhXUMdQYuoGCT
         UJmCkm4Fj/XMm0BuZD/M8GMm6wpqacwY3rMOFwK2sgdiO3FWg+4D28Vjtsaqk4JKcP
         1CCii4/NWqjns2vzsiDFHRiYxkm2Ioa/sV3PfbOlF9GBRh+WQSw4zCEjmZQdyenHdu
         BhyJm8B7QalLAIDlExaa+B4WOmMlnbynWKVSeBqODrTho1O6s+4NkaQtxnD47N7InI
         O5FpQHGhH2+LAdNZf5xs697XX3WQalBnnbEiEe/zERfx9y/1U8qd9pdhHhRKgDFF6+
         VXdhVpoDLa70A==
Date:   Fri, 28 Jan 2022 11:45:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
Message-ID: <YfQ54x8zglPT/YnL@dev-arch.archlinux-ax161>
References: <20220128114446.740575-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128114446.740575-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 12:44:45PM +0100, Marco Elver wrote:
> The randomize_kstack_offset feature is unconditionally compiled in when
> the architecture supports it.
> 
> To add constraints on compiler versions, we require a dedicated Kconfig
> variable. Therefore, introduce RANDOMIZE_KSTACK_OFFSET.
> 
> Furthermore, this option is now also configurable by EXPERT kernels:
> while the feature is supposed to have zero performance overhead when
> disabled, due to its use of static branches, there are few cases where
> giving a distribution the option to disable the feature entirely makes
> sense. For example, in very resource constrained environments, which
> would never enable the feature to begin with, in which case the
> additional kernel code size increase would be redundant.
> 
> Signed-off-by: Marco Elver <elver@google.com>

From a Kconfig perspective:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/Kconfig                     | 23 ++++++++++++++++++-----
>  include/linux/randomize_kstack.h |  5 +++++
>  init/main.c                      |  2 +-
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..2cde48d9b77c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1159,16 +1159,29 @@ config HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	  to the compiler, so it will attempt to add canary checks regardless
>  	  of the static branch state.
>  
> -config RANDOMIZE_KSTACK_OFFSET_DEFAULT
> -	bool "Randomize kernel stack offset on syscall entry"
> +config RANDOMIZE_KSTACK_OFFSET
> +	bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
> +	default y
>  	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	help
>  	  The kernel stack offset can be randomized (after pt_regs) by
>  	  roughly 5 bits of entropy, frustrating memory corruption
>  	  attacks that depend on stack address determinism or
> -	  cross-syscall address exposures. This feature is controlled
> -	  by kernel boot param "randomize_kstack_offset=on/off", and this
> -	  config chooses the default boot state.
> +	  cross-syscall address exposures.
> +
> +	  The feature is controlled via the "randomize_kstack_offset=on/off"
> +	  kernel boot param, and if turned off has zero overhead due to its use
> +	  of static branches (see JUMP_LABEL).
> +
> +	  If unsure, say Y.
> +
> +config RANDOMIZE_KSTACK_OFFSET_DEFAULT
> +	bool "Default state of kernel stack offset randomization"
> +	depends on RANDOMIZE_KSTACK_OFFSET
> +	help
> +	  Kernel stack offset randomization is controlled by kernel boot param
> +	  "randomize_kstack_offset=on/off", and this config chooses the default
> +	  boot state.
>  
>  config ARCH_OPTIONAL_KERNEL_RWX
>  	def_bool n
> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> index bebc911161b6..91f1b990a3c3 100644
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_RANDOMIZE_KSTACK_H
>  #define _LINUX_RANDOMIZE_KSTACK_H
>  
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>  #include <linux/kernel.h>
>  #include <linux/jump_label.h>
>  #include <linux/percpu-defs.h>
> @@ -50,5 +51,9 @@ void *__builtin_alloca(size_t size);
>  		raw_cpu_write(kstack_offset, offset);			\
>  	}								\
>  } while (0)
> +#else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> +#define add_random_kstack_offset()		do { } while (0)
> +#define choose_random_kstack_offset(rand)	do { } while (0)
> +#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
>  
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 65fa2e41a9c0..560f45c27ffe 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -853,7 +853,7 @@ static void __init mm_init(void)
>  	pti_init();
>  }
>  
> -#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>  DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>  			   randomize_kstack_offset);
>  DEFINE_PER_CPU(u32, kstack_offset);
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
