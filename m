Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A789C557FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiFWQcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Jun 2022 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiFWQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:31:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3746B28
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:31:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o4PkE-0002xb-Gk; Thu, 23 Jun 2022 18:31:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christoph Muellner <christoph.muellner@vrull.eu>
Cc:     Christoph =?ISO-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Subject: Re: [RFC PATCH v2] riscv: Add Zawrs support for spinlocks
Date:   Thu, 23 Jun 2022 18:31:49 +0200
Message-ID: <1903087.PYKUYFuaPT@diego>
In-Reply-To: <20220623152948.1607295-1-christoph.muellner@vrull.eu>
References: <20220623152948.1607295-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Donnerstag, 23. Juni 2022, 17:29:48 CEST schrieb Christoph Muellner:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> The current RISC-V code uses the generic ticket lock implementation,
> that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> Currently, RISC-V uses the generic implementation of these macros.
> This patch introduces a RISC-V specific implementation, of these
> macros, that peels off the first loop iteration and modifies the waiting
> loop such, that it is possible to use the WRS.STO instruction of the Zawrs
> ISA extension to stall the CPU.
> 
> The resulting implementation of smp_cond_load_*() will only work for
> 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> This is caused by the restrictions of the LR instruction (RISC-V only
> has LR.W and LR.D). Compiler assertions guard this new restriction.
> 
> This patch uses the existing RISC-V ISA extension framework
> to detect the presents of Zawrs at run-time.
> If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.
> 
> The whole mechanism is gated by Kconfig setting, which defaults to Y.
> 
> The Zawrs specification can be found here:
> https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> 
> Note, that the Zawrs extension is not frozen or ratified yet.
> Therefore this patch is an RFC and not intended to get merged.
> 
> Changes since v1:
> * Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
> * Fixing type checking code in __smp_load_reserved*
> * Adjustments according to the specification change
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>

With the matching Qemu-Patch on
- rv64 + Debian rootfs
- rv32 + 32bit-Buildroot rootfs

Tested-by: Heiko Stuebner <heiko@sntech.de>

apart from the one nit below
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  arch/riscv/Kconfig                   | 11 ++++
>  arch/riscv/include/asm/barrier.h     | 92 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/errata_list.h | 19 +++++-
>  arch/riscv/include/asm/hwcap.h       |  3 +-
>  arch/riscv/kernel/cpu.c              |  1 +
>  arch/riscv/kernel/cpufeature.c       | 13 ++++
>  6 files changed, 136 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 32ffef9f6e5b..9d40569237c9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -358,6 +358,17 @@ config RISCV_ISA_C
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZAWRS
> +	bool "Zawrs extension support"
> +	depends on !XIP_KERNEL
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
> index d0e24aaa2aa0..1f9628aaa7cb 100644
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
> @@ -42,6 +44,64 @@ do {									\
>  	___p1;								\
>  })
>  
> +#if __riscv_xlen == 64
> +

nit: I guess we could do without the extra blanks?
asm.h does so, and also the #else block below also doesn't
use them ;-) . But I guess that is more a style debate

> +#define __riscv_lrsc_word(t)						\
> +	(sizeof(t) == sizeof(int) ||					\
> +	 sizeof(t) == sizeof(long))
> +
> +#elif __riscv_xlen == 32
> +
> +#define __riscv_lrsc_word(t)						\
> +	(sizeof(t) == sizeof(int))
> +
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif /* __riscv_xlen */

[...]

Thanks
Heiko


