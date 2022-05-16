Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011AA527DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbiEPGpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiEPGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:45:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A12A36332
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 331E660FAD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9735AC341C0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652683525;
        bh=D3lUAY4hlNJZ6LLGX7gEANzHJjEkdI5YUS7i5FAqxd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dtc3IjpLxvyfIxdCNE+layBYLQ4ZXknxZQkgdd6+NfQWVih0hZRoGq8qwIm5kmZON
         awUTnVy2IYzAZdVZR6cs5YxnByg/uk42kSXUAuG5fB/tPMPDsbZHJ6RSa92fmsTNSn
         L4mt22K9fiWBLsCnWlTBHjJzoiZSLVoZ6DD4P/JExx77pUZtUkl0CkN5hU+n1HZViW
         eKBUSXIB5ItlypoZOAhITIEq0hJlQbocdjoB8HCcvjJmr3J0TEsDlHSkwyI29jEInb
         tzC1VIcQ2UZjCgl1dGkT6oVBReSaiLlapBnmh0oYHP7LXnd1WDgqbYYp2i5Pwo2xg2
         8wDECcBOesvaA==
Received: by mail-vs1-f47.google.com with SMTP id v139so14553717vsv.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:45:25 -0700 (PDT)
X-Gm-Message-State: AOAM530nLA4QNWxIjgzPEga91Q0vLt8XnJVbxt2btidU4P+uDeLRexQw
        +mKQm+OICVPFYxUj61leadFJPllw6LlXVqtagw4=
X-Google-Smtp-Source: ABdhPJyxzUVvGkLIvjC+gdVEjJrBOFt+7DJaTB5E/9OivXlM3+ii/g6DW+JL3+PmqgtrE6++xvgwL3kPizihckCaqQo=
X-Received: by 2002:a05:6102:390b:b0:32d:5fc3:bd2c with SMTP id
 e11-20020a056102390b00b0032d5fc3bd2cmr5072698vsu.51.1652683524375; Sun, 15
 May 2022 23:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-2-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-2-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:45:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR_qUnCe6Zeyhn9m=qAASMqXv7GAhqBhL604JKrUNCmcw@mail.gmail.com>
Message-ID: <CAJF2gTR_qUnCe6Zeyhn9m=qAASMqXv7GAhqBhL604JKrUNCmcw@mail.gmail.com>
Subject: Re: [PATCH 01/12] riscv: integrate alternatives better into the main architecture
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, liush <liush@allwinnertech.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, May 12, 2022 at 3:29 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Right now the alternatives need to be explicitly enabled and
> erratas are limited to SiFive ones.
>
> We want to use alternatives not only for patching soc erratas,
> but in the future also for handling different behaviour depending
> on the existence of future extensions.
>
> So move the core alternatives over to the kernel subdirectory
> and move the CONFIG_RISCV_ALTERNATIVE to be a hidden symbol
> which we expect relevant erratas and extensions to just select
> if needed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/Kconfig                          |  9 +++++++++
>  arch/riscv/Kconfig.erratas                  | 13 ++-----------
>  arch/riscv/Kconfig.socs                     |  1 -
>  arch/riscv/Makefile                         |  2 +-
>  arch/riscv/errata/Makefile                  |  1 -
>  arch/riscv/include/asm/alternative-macros.h |  7 ++++---
>  arch/riscv/include/asm/alternative.h        |  8 ++++++++
>  arch/riscv/kernel/Makefile                  |  1 +
>  arch/riscv/{errata => kernel}/alternative.c |  0
>  arch/riscv/kernel/smpboot.c                 |  2 --
>  arch/riscv/kernel/traps.c                   |  2 +-
>  11 files changed, 26 insertions(+), 20 deletions(-)
>  rename arch/riscv/{errata => kernel}/alternative.c (100%)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f8a55d94016d..1ec07aa582a3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -325,6 +325,15 @@ config NODES_SHIFT
>           Specify the maximum number of NUMA Nodes available on the target
>           system.  Increases memory reserved to accommodate various tables.
>
> +config RISCV_ALTERNATIVE
> +       bool
> +       depends on !XIP_KERNEL
> +       help
> +         This Kconfig allows the kernel to automatically patch the
> +         errata required by the execution platform at run time. The
> +         code patching is performed once in the boot stages. It means
> +         that the overhead from this mechanism is just taken once.
> +
>  config RISCV_ISA_C
>         bool "Emit compressed instructions when building Linux"
>         default y
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index 0aacd7052585..c521c2ae2de2 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -1,18 +1,9 @@
>  menu "CPU errata selection"
>
> -config RISCV_ERRATA_ALTERNATIVE
> -       bool "RISC-V alternative scheme"
> -       depends on !XIP_KERNEL
> -       default y
> -       help
> -         This Kconfig allows the kernel to automatically patch the
> -         errata required by the execution platform at run time. The
> -         code patching is performed once in the boot stages. It means
> -         that the overhead from this mechanism is just taken once.
> -
>  config ERRATA_SIFIVE
>         bool "SiFive errata"
> -       depends on RISCV_ERRATA_ALTERNATIVE
> +       depends on !XIP_KERNEL
> +       select RISCV_ALTERNATIVE
>         help
>           All SiFive errata Kconfig depend on this Kconfig. Disabling
>           this Kconfig will disable all SiFive errata. Please say "Y"
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index f6ef358d8a2c..85670dc9fe95 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -14,7 +14,6 @@ config SOC_SIFIVE
>         select CLK_SIFIVE
>         select CLK_SIFIVE_PRCI
>         select SIFIVE_PLIC
> -       select RISCV_ERRATA_ALTERNATIVE if !XIP_KERNEL
>         select ERRATA_SIFIVE if !XIP_KERNEL
>         help
>           This enables support for SiFive SoC platform hardware.
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..a7ed47ce9311 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -103,7 +103,7 @@ endif
>
>  head-y := arch/riscv/kernel/head.o
>
> -core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
> +core-y += arch/riscv/errata/
>  core-$(CONFIG_KVM) += arch/riscv/kvm/
>
>  libs-y += arch/riscv/lib/
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index b8f8740a3e44..0ca1c5281a2d 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -1,2 +1 @@
> -obj-y  += alternative.o
>  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 67406c376389..5dd8d03a13da 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_ALTERNATIVE_MACROS_H
>  #define __ASM_ALTERNATIVE_MACROS_H
>
> -#ifdef CONFIG_RISCV_ERRATA_ALTERNATIVE
> +#ifdef CONFIG_RISCV_ALTERNATIVE
>
>  #ifdef __ASSEMBLY__
>
> @@ -76,7 +76,7 @@
>
>  #endif /* __ASSEMBLY__ */
>
> -#else /* !CONFIG_RISCV_ERRATA_ALTERNATIVE*/
> +#else /* CONFIG_RISCV_ALTERNATIVE */
>  #ifdef __ASSEMBLY__
>
>  .macro __ALTERNATIVE_CFG old_c
> @@ -95,7 +95,8 @@
>         __ALTERNATIVE_CFG(old_c)
>
>  #endif /* __ASSEMBLY__ */
> -#endif /* CONFIG_RISCV_ERRATA_ALTERNATIVE */
> +#endif /* CONFIG_RISCV_ALTERNATIVE */
> +
>  /*
>   * Usage:
>   *   ALTERNATIVE(old_content, new_content, vendor_id, errata_id, CONFIG_k)
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index e625d3cafbed..7b42bcef0ecf 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -12,6 +12,8 @@
>
>  #ifndef __ASSEMBLY__
>
> +#ifdef CONFIG_RISCV_ALTERNATIVE
> +
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/stddef.h>
> @@ -35,5 +37,11 @@ struct errata_checkfunc_id {
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                               unsigned long archid, unsigned long impid);
>
> +#else /* CONFIG_RISCV_ALTERNATIVE */
> +
> +static inline void apply_boot_alternatives(void) { }
> +
> +#endif /* CONFIG_RISCV_ALTERNATIVE */
> +
>  #endif
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 87adbe47bc15..0f8348ac30f1 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -18,6 +18,7 @@ extra-y += head.o
>  extra-y += vmlinux.lds
>
>  obj-y  += soc.o
> +obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
>  obj-y  += cpu.o
>  obj-y  += cpufeature.o
>  obj-y  += entry.o
> diff --git a/arch/riscv/errata/alternative.c b/arch/riscv/kernel/alternative.c
> similarity index 100%
> rename from arch/riscv/errata/alternative.c
> rename to arch/riscv/kernel/alternative.c
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 622f226454d5..a6d13dca1403 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -41,9 +41,7 @@ static DECLARE_COMPLETION(cpu_running);
>  void __init smp_prepare_boot_cpu(void)
>  {
>         init_cpu_topology();
> -#ifdef CONFIG_RISCV_ERRATA_ALTERNATIVE
>         apply_boot_alternatives();
> -#endif
>  }
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index fe92e119e6a3..efa693b325a1 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -86,7 +86,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>         }
>  }
>
> -#if defined (CONFIG_XIP_KERNEL) && defined (CONFIG_RISCV_ERRATA_ALTERNATIVE)
> +#if defined (CONFIG_XIP_KERNEL) && defined (CONFIG_RISCV_ALTERNATIVE)
>  #define __trap_section         __section(".xip.traps")
>  #else
>  #define __trap_section
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
