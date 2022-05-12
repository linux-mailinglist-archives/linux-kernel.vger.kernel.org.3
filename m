Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F7524B21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353057AbiELLNK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 07:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353055AbiELLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:13:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9462216
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:12:56 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1np6kZ-0001eb-5Y; Thu, 12 May 2022 13:12:55 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Dao Lu <daolu@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Dao Lu <daolu@rivosinc.com>
Subject: Re: [PATCH] arch/riscv: Add Zihintpause extension support
Date:   Thu, 12 May 2022 13:12:54 +0200
Message-ID: <4061745.1IzOArtZ34@diego>
In-Reply-To: <20220512033045.1101909-1-daolu@rivosinc.com>
References: <20220512033045.1101909-1-daolu@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 12. Mai 2022, 05:30:45 CEST schrieb Dao Lu:
> This patch:
>   1. Build with _zihintpause if the toolchain has support for it
>   2. Detects if the platform supports the extension
>   3. Use PAUSE for cpu_relax if both toolchain and the platform support it

This simply explains what the patch does, which is also pretty easy to
see by just reading the patch, so doesn't provide real additional value.

Please use the commit message to provide more background on what
you want to achieve. I.e. a short explanation what it is.

-----
Implement support for the ZiHintPause extension.

The PAUSE instruction is a HINT that indicates the current hart’s rate of
instruction retirement should be temporarily reduced or paused.
-----

The second sentence obviously comes directly from the riscv-spec pdf ;-)

There is one nit below too and with that fixed

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

On a Qemu build with your extension patch for it, also
Tested-by: Heiko Stuebner <heiko@sntech.de>


> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>  arch/riscv/Makefile                     |  4 ++++
>  arch/riscv/include/asm/hwcap.h          |  1 +
>  arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
>  arch/riscv/kernel/cpu.c                 |  1 +
>  arch/riscv/kernel/cpufeature.c          |  7 +++++++
>  5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..900a8fda1a2d 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>  
> +# Check if the toolchain supports Zihintpause extension
> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> +
>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>  
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..caa9ee5459b4 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 134388cbaaa1..106b35ba8cac 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -4,15 +4,28 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/jump_label.h>
>  #include <asm/barrier.h>
> +#include <asm/hwcap.h>
>  
> +extern struct static_key_false riscv_pause_available;
>  static inline void cpu_relax(void)
>  {
> +	if (!static_branch_likely(&riscv_pause_available)) {
>  #ifdef __riscv_muldiv
> -	int dummy;
> -	/* In lieu of a halt instruction, induce a long-latency stall. */
> -	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> +		int dummy;
> +		/* In lieu of a halt instruction, induce a long-latency stall. */
> +		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>  #endif
> +	} else {
> +#ifdef __riscv_zihintpause
> +		/*
> +		 * Reduce instruction retirement.
> +		 * This assumes the PC changes.
> +		 */
> +		__asm__ __volatile__ ("pause");
> +#endif
> +	}
>  	barrier();
>  }
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..89e563e9c4cc 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..327c19507dbb 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>  #ifdef CONFIG_FPU
>  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
>  #endif
> +DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
> +EXPORT_SYMBOL_GPL(riscv_pause_available);
>  
>  /**
>   * riscv_isa_extension_base() - Get base extension word
> @@ -192,6 +194,7 @@ void __init riscv_fill_hwcap(void)
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> +				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> @@ -213,6 +216,10 @@ void __init riscv_fill_hwcap(void)
>  
>  	}
>  
> +	if (__riscv_isa_extension_available(riscv_isa, RISCV_ISA_EXT_ZIHINTPAUSE)) {
> +		static_branch_enable(&riscv_pause_available);
> +	}
> +

You don't really need the braces for the single call to static_branch_enable


>  	/* We don't support systems with F but without D, so mask those out
>  	 * here. */
>  	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
> 


Heiko



