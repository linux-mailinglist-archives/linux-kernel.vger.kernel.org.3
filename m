Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0380A53BA9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiFBOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:21:52 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E921E08
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:21:48 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nwlhp-0000PL-HA; Thu, 02 Jun 2022 16:21:45 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Muellner <christoph.muellner@vrull.io>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Muellner <christoph.muellner@vrull.eu>
Subject: Re: [RFC PATCH] riscv: Add Zawrs support for spinlocks
Date:   Thu, 02 Jun 2022 16:21:44 +0200
Message-ID: <2280429.BjyWNHgNrj@diego>
In-Reply-To: <20220602141032.169907-1-christoph.muellner@vrull.io>
References: <20220602141032.169907-1-christoph.muellner@vrull.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 2. Juni 2022, 16:10:32 CEST schrieb Christoph Muellner:
> The current RISC-V code uses the generic ticket lock implementation,
> that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> Currently, RISC-V uses the generic implementation of these macros.
> This patch introduces a RISC-V specific implementation, of these
> macros, that peels off the first loop iteration and modifies the waiting
> loop such, that it is possible to use the WRS instruction of the Zawrs
> ISA extension to stall the CPU.
> 
> The resulting implementation of smp_cond_load_*() will only work for
> 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> This is caused by the restrictions of the LR instruction (RISC-V only
> has LR.W and LR.D). Compiler assertions guard this new restriction.
> 
> This patch uses the existing RISC-V ISA extension framework
> to detect the presents of Zawrs at run-time.
> If available a NOP instruction will be replaced by WRS.
> A similar patch could add support for the PAUSE instruction of
> the Zihintpause ISA extension.
> 
> The whole mechanism is gated by Kconfig setting, which defaults to Y.
> 
> The Zawrs specification can be found here:
> https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> 
> Note, that the Zawrs extension is not frozen or ratified yet.
> Therefore this patch is an RFC and not intended to get merged.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@vrull.io>

I'm not sure what happened here, but I got the patch 2 times
(16:06 and 16:10 CEST).

response to the other patch:

cool to see the cpufeature patching get a new member :-) .

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

together with the qemu-patch:
Tested-by: Heiko Stuebner <heiko@sntech.de>



> ---
>  arch/riscv/Kconfig                   | 10 +++
>  arch/riscv/include/asm/barrier.h     | 97 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 12 +++-
>  arch/riscv/include/asm/hwcap.h       |  3 +-
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 13 ++++
>  6 files changed, 133 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 905e550e0fd3..054872317d4a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -358,6 +358,16 @@ config RISCV_ISA_C
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZAWRS
> +	bool "Zawrs extension support"
> +	select RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the Zawrs extension
> +	   (wait for reservation set) and enable its usage.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config RISCV_ISA_SVPBMT
>  	bool "SVPBMT extension support"
>  	depends on 64BIT && MMU
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index d0e24aaa2aa0..69b8f1f4b80c 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -12,6 +12,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/errata_list.h>
> +
>  #define nop()		__asm__ __volatile__ ("nop")
>  
>  #define RISCV_FENCE(p, s) \
> @@ -42,6 +44,69 @@ do {									\
>  	___p1;								\
>  })
>  
> +#if __riscv_xlen == 64
> +
> +#define __riscv_lrsc_word(t)						\
> +	(sizeof(t) == sizeof(int) ||					\
> +	 sizeof(t) == sizeof(long))
> +
> +#define __riscv_lr(ptr)							\
> +	sizeof(*ptr) == sizeof(int) ? "lr.w" : "lr.d"
> +
> +#elif __riscv_xlen == 32
> +
> +#define __riscv_lrsc_word(ptr)						\
> +	(sizeof(*ptr) == sizeof(int))
> +
> +#define __riscv_lr(t) "lr.w"
> +
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif /* __riscv_xlen */
> +
> +#define compiletime_assert_atomic_lrsc_type(t)				\
> +	compiletime_assert(__riscv_lrsc_word(t),			\
> +		"Need type compatible with LR/SC instructions.")
> +
> +#define ___smp_load_reservedN(pfx, ptr)					\
> +({									\
> +	typeof(*ptr) ___p1;						\
> +	__asm__ __volatile__ ("lr." pfx "	%[p], %[c]\n"		\
> +			      : [p]"=&r" (___p1), [c]"+A"(*ptr));	\
> +	___p1;								\
> +})
> +
> +#define ___smp_load_reserved32(ptr)					\
> +	___smp_load_reservedN("w", ptr)
> +
> +#define ___smp_load_reserved64(ptr)					\
> +	___smp_load_reservedN("d", ptr)
> +
> +#define __smp_load_reserved_relaxed(ptr)				\
> +({									\
> +	typeof(*ptr) ___p1;						\
> +	compiletime_assert_atomic_lrsc_type(*ptr);			\
> +	if (sizeof(*ptr) == 32) {					\
> +		___p1 = ___smp_load_reserved32(ptr);			\
> +	} else {							\
> +		___p1 = ___smp_load_reserved64(ptr);			\
> +	}								\
> +	___p1;								\
> +})
> +
> +#define __smp_load_reserved_acquire(ptr)				\
> +({									\
> +	typeof(*ptr) ___p1;						\
> +	compiletime_assert_atomic_lrsc_type(*ptr);			\
> +	if (sizeof(*ptr) == 32) {					\
> +		___p1 = ___smp_load_reserved32(ptr);			\
> +	} else {							\
> +		___p1 = ___smp_load_reserved64(ptr);			\
> +	}								\
> +	RISCV_FENCE(r,rw);						\
> +	___p1;								\
> +})
> +
>  /*
>   * This is a very specific barrier: it's currently only used in two places in
>   * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
> @@ -69,6 +134,38 @@ do {									\
>   */
>  #define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
>  
> +#define smp_cond_load_relaxed(ptr, cond_expr)				\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	VAL = READ_ONCE(*__PTR);					\
> +	if (!cond_expr) {						\
> +		for (;;) {						\
> +			VAL = __smp_load_reserved_relaxed(__PTR);	\
> +			if (cond_expr)					\
> +				break;					\
> +			ALT_WRS();					\
> +		}							\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +
> +#define smp_cond_load_acquire(ptr, cond_expr)				\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	VAL = smp_load_acquire(__PTR);					\
> +	if (!cond_expr) {						\
> +		for (;;) {						\
> +			VAL = __smp_load_reserved_acquire(__PTR);	\
> +			if (cond_expr)					\
> +				break;					\
> +			ALT_WRS();					\
> +		}							\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 9e2888dbb5b1..b9aa0b346493 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -19,8 +19,9 @@
>  #define	ERRATA_THEAD_NUMBER 1
>  #endif
>  
> -#define	CPUFEATURE_SVPBMT 0
> -#define	CPUFEATURE_NUMBER 1
> +#define	CPUFEATURE_ZAWRS 0
> +#define	CPUFEATURE_SVPBMT 1
> +#define	CPUFEATURE_NUMBER 2
>  
>  #ifdef __ASSEMBLY__
>  
> @@ -42,6 +43,13 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
>  		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
>  		: : "r" (addr) : "memory")
>  
> +#define ZAWRS_WRS	".long 0x1000073"
> +#define ALT_WRS()							\
> +asm volatile(ALTERNATIVE(						\
> +	"nop\n\t",							\
> +	ZAWRS_WRS "\n\t",						\
> +	0, CPUFEATURE_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
> +
>  /*
>   * _val is marked as "will be overwritten", so need to set it to 0
>   * in the default case.
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 4e2486881840..c7dd8cc38bec 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -51,7 +51,8 @@ extern unsigned long elf_hwcap;
>   * available logical extension id.
>   */
>  enum riscv_isa_ext_id {
> -	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZAWRS = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_SSCOFPMF,
>  	RISCV_ISA_EXT_SVPBMT,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..6c3a10ff5358 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,6 +87,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index dea3ea19deee..fc2c47a1784b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> +				SET_ISA_EXT_MAP("zawrs", RISCV_ISA_EXT_ZAWRS);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> @@ -251,6 +252,14 @@ struct cpufeature_info {
>  	bool (*check_func)(unsigned int stage);
>  };
>  
> +static bool __init_or_module cpufeature_zawrs_check_func(unsigned int stage)
> +{
> +	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	return riscv_isa_extension_available(NULL, ZAWRS);
> +}
> +
>  static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
>  {
>  #ifdef CONFIG_RISCV_ISA_SVPBMT
> @@ -267,6 +276,10 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
>  
>  static const struct cpufeature_info __initdata_or_module
>  cpufeature_list[CPUFEATURE_NUMBER] = {
> +	{
> +		.name = "zawrs",
> +		.check_func = cpufeature_zawrs_check_func
> +	},
>  	{
>  		.name = "svpbmt",
>  		.check_func = cpufeature_svpbmt_check_func
> 




