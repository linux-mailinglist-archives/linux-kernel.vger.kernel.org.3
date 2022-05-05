Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281651C523
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381990AbiEEQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381473AbiEEQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:33:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA2895C65A;
        Thu,  5 May 2022 09:30:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85844106F;
        Thu,  5 May 2022 09:30:12 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D2573FA31;
        Thu,  5 May 2022 09:30:10 -0700 (PDT)
Date:   Thu, 5 May 2022 17:30:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 10/21] treewide: Drop function_nocfi
Message-ID: <YnP7j+miotxYM6fu@FVFF77S0Q05N.cambridge.arm.com>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429203644.2868448-11-samitolvanen@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:36:33PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, we no longer need function_nocfi() as
> the compiler won't change function references to point to a
> jump table. Remove all implementations and uses of the macro.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/compiler.h         | 16 ----------------
>  arch/arm64/include/asm/ftrace.h           |  2 +-
>  arch/arm64/include/asm/mmu_context.h      |  2 +-
>  arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
>  arch/arm64/kernel/cpufeature.c            |  2 +-
>  arch/arm64/kernel/ftrace.c                |  2 +-
>  arch/arm64/kernel/machine_kexec.c         |  2 +-
>  arch/arm64/kernel/psci.c                  |  2 +-
>  arch/arm64/kernel/smp_spin_table.c        |  2 +-
>  drivers/firmware/psci/psci.c              |  4 ++--
>  drivers/misc/lkdtm/usercopy.c             |  2 +-
>  include/linux/compiler.h                  | 10 ----------
>  12 files changed, 11 insertions(+), 37 deletions(-)

Nice!

I also believe that in most cases we can drop the __nocfi annotation on callers
now that we can mark the called assembly function with SYM_TYPED_FUNC_START().

In most cases we needed the __nocfi annotation on a caller because it was
invoking an assembly function at an unusual virtual address (which differed
from the link address), and the existing CFI scheme couldn't handle that. The
kCFI scheme should handle that fine so long as the type ID before the function
is accessible.

The other odd case was where we had the non-cfi address of a target function
(e.g. for callback structures populated in assembly), and that doesn't matter
with kCFI.

In looking at the below I spotted some latent issues. I'll prepare some patches
for those.

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
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1494cfa8639b..c96d47cb8f46 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -26,7 +26,7 @@
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #else
> -#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
> +#define MCOUNT_ADDR		((unsigned long)_mcount)
>  #endif
>  
>  /* The BL at the callsite's adjusted rec->ip */
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 6770667b34a3..c9df5ab2c448 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -164,7 +164,7 @@ static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
>  		ttbr1 |= TTBR_CNP_BIT;
>  	}
>  
> -	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
> +	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
>  
>  	cpu_install_idmap();
>  	replace_phys(ttbr1);


As long as we create `idmap_cpu_replace_ttbr1` with SYM_TYPED_FUNC_START(), we
can drop `__nocfi` from `cpu_replace_ttbr1`

[...]

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index d72c4b4d389c..dae07d99508b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1619,7 +1619,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>  	if (arm64_use_ng_mappings)
>  		return;
>  
> -	remap_fn = (void *)__pa_symbol(function_nocfi(idmap_kpti_install_ng_mappings));
> +	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
>  
>  	cpu_install_idmap();
>  	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));

There' a latent bug here with the existing CFI scheme, since
`kpti_install_ng_mappings` isn't marked with __nocfi, and should explode when
calling `idmap_kpti_install_ng_mappings` via the idmap.

With the kCFI scheme we instead need to mark `idmap_kpti_install_ng_mappings`
with SYM_TYPED_FUNC_START().

[...]

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index e16b248699d5..4eb5388aa5a6 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -204,7 +204,7 @@ void machine_kexec(struct kimage *kimage)
>  		typeof(cpu_soft_restart) *restart;
>  
>  		cpu_install_idmap();
> -		restart = (void *)__pa_symbol(function_nocfi(cpu_soft_restart));
> +		restart = (void *)__pa_symbol(cpu_soft_restart);
>  		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
>  			0, 0);
>  	} else {

There' a latent bug here with the existing CFI scheme, since
`machine_kexec` isn't marked with __nocfi, and should explode when calling
`cpu_soft_restart` via the idmap.

With the kCFI scheme we instead need to mark `cpu_soft_restart` with
SYM_TYPED_FUNC_START(). It's currently marked as SYM_CODE() because it doesn't
follow the usual function call conventions, but that also means it's broken for
BTI, and for now (without something like objtool caring about function calling
conventions) SYM_FUNC_START() is fine.

Thanks,
Mark.
