Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C34FEEA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiDMFob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiDMFoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDA20BF0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE3361C2C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D8C385BD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649828523;
        bh=UroexlyaOJ612A7j7r35/w0UlBKtJvaBUe7hpU+WntA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aYvOsu9rlOGXKLHcD2ErlWv5t2hQd15h4rxJyRpzfPRwdskPCf4fiuEjnLospz1IV
         l63Yq5LMQRo9zHLQ3Hi4k27qyJyUd+CStHsWecjjs9f3OqKz6ClDWKb+utr4Q9+t73
         uvb/u9V+HSeErUlFA4FZfS9IvcUhvQgoS734A/xJV/LjDR4B9/32cSeESoc1FaU4ES
         m6kyIXAgUeb8WU2QX+JO2QRa/XL+bJyd2oiFL8+F9AqQVAkv7FRinUKVrczX5onXwy
         2AbjGTgm5D4hmjDfyIogZmvPzA2se6Uw8LTk6RR1l2I4Ef8m/Vs19HkdGDxtbQbCUS
         bDW0GdC5SwDfg==
Received: by mail-vs1-f42.google.com with SMTP id a127so622795vsa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:42:03 -0700 (PDT)
X-Gm-Message-State: AOAM5301ZTvGbjgXjG8Zb8t2zbocuMdUQkEfFwdlfKGG4RUj37ONFfZB
        4Nlp514iPYmoXA5EwDzz5Q36vSaB/SEGYGA1Q40=
X-Google-Smtp-Source: ABdhPJyngkJWZ3iQRI4D4DlYUOwZZwnSYipvNk62gxblNW8wDygahYcGLA1AIpSG4yfsB0URYMx/GMPTm3NnNpN0F6I=
X-Received: by 2002:a67:d48d:0:b0:328:2e7b:977a with SMTP id
 g13-20020a67d48d000000b003282e7b977amr5843137vsj.51.1649828522323; Tue, 12
 Apr 2022 22:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-13-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-13-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Apr 2022 13:41:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR=JexYCOpuYAndtrLEGQwO7-ZC0kLb3+Air000q-84Ww@mail.gmail.com>
Message-ID: <CAJF2gTR=JexYCOpuYAndtrLEGQwO7-ZC0kLb3+Air000q-84Ww@mail.gmail.com>
Subject: Re: [PATCH v9 12/12] riscv: add memory-type errata for T-Head
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Apr 13, 2022 at 11:05 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Some current cpus based on T-Head cores implement memory-types
> way different than described in the svpbmt spec even going
> so far as using PTE bits marked as reserved.
>
> Add the T-Head vendor-id and necessary errata code to
> replace the affected instructions.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/riscv/Kconfig.erratas             | 20 +++++++
>  arch/riscv/errata/Makefile             |  1 +
>  arch/riscv/errata/sifive/errata.c      |  7 ++-
>  arch/riscv/errata/thead/Makefile       |  1 +
>  arch/riscv/errata/thead/errata.c       | 82 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h   |  6 ++
>  arch/riscv/include/asm/errata_list.h   | 50 +++++++++++++++-
>  arch/riscv/include/asm/pgtable-64.h    | 18 +++++-
>  arch/riscv/include/asm/pgtable.h       | 18 +++++-
>  arch/riscv/include/asm/vendorid_list.h |  1 +
>  arch/riscv/kernel/alternative.c        | 12 ++++
>  arch/riscv/kernel/cpufeature.c         |  7 ++-
>  arch/riscv/mm/init.c                   |  1 +
>  13 files changed, 215 insertions(+), 9 deletions(-)
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index c521c2ae2de2..12036e65648e 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -33,4 +33,24 @@ config ERRATA_SIFIVE_CIP_1200
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD
> +       bool "T-HEAD errata"
> +       select RISCV_ALTERNATIVE
> +       help
> +         All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> +         this Kconfig will disable all T-HEAD errata. Please say "Y"
> +         here if your platform uses T-HEAD CPU cores.
> +
> +         Otherwise, please say "N" here to avoid unnecessary overhead.
> +
> +config ERRATA_THEAD_PBMT
> +       bool "Apply T-Head memory type errata"
> +       depends on ERRATA_THEAD && 64BIT
> +       default y
> +       help
> +         This will apply the memory type errata to handle the non-standard
> +         memory type bits in page-table-entries on T-Head SoCs.
> +
> +         If you don't know what to do here, say "Y".
> +
>  endmenu
> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index 0ca1c5281a2d..a1055965fbee 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> +obj-$(CONFIG_ERRATA_THEAD) += thead/
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index 3e39587a49dc..672f02b21ce0 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -88,10 +88,15 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
>                                                unsigned int stage)
>  {
>         struct alt_entry *alt;
> -       u32 cpu_req_errata = sifive_errata_probe(archid, impid);
> +       u32 cpu_req_errata;
>         u32 cpu_apply_errata = 0;
>         u32 tmp;
>
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               return;
> +
> +       cpu_req_errata = sifive_errata_probe(archid, impid);
> +
>         for (alt = begin; alt < end; alt++) {
>                 if (alt->vendor_id != SIFIVE_VENDOR_ID)
>                         continue;
> diff --git a/arch/riscv/errata/thead/Makefile b/arch/riscv/errata/thead/Makefile
> new file mode 100644
> index 000000000000..2d644e19caef
> --- /dev/null
> +++ b/arch/riscv/errata/thead/Makefile
> @@ -0,0 +1 @@
> +obj-y += errata.o
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> new file mode 100644
> index 000000000000..e5d75270b99c
> --- /dev/null
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 Heiko Stuebner <heiko@sntech.de>
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/errata_list.h>
> +#include <asm/patch.h>
> +#include <asm/vendorid_list.h>
> +
> +struct errata_info {
> +       char name[ERRATA_STRING_LENGTH_MAX];
> +       bool (*check_func)(unsigned long arch_id, unsigned long impid);
> +       unsigned int stage;
> +};
> +
> +static bool errata_mt_check_func(unsigned long  arch_id, unsigned long impid)
> +{
> +       if (arch_id != 0 || impid != 0)
> +               return false;
> +       return true;
> +}
> +
> +static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
> +       {
> +               .name = "memory-types",
> +               .stage = RISCV_ALTERNATIVES_EARLY_BOOT,
> +               .check_func = errata_mt_check_func
> +       },
> +};
> +
> +static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
> +{
> +       const struct errata_info *info;
> +       u32 cpu_req_errata = 0;
> +       int idx;
> +
> +       for (idx = 0; idx < ERRATA_THEAD_NUMBER; idx++) {
> +               info = &errata_list[idx];
> +
> +               if ((stage == RISCV_ALTERNATIVES_MODULE ||
> +                    info->stage == stage) && info->check_func(archid, impid))
> +                       cpu_req_errata |= (1U << idx);
> +       }
> +
> +       return cpu_req_errata;
> +}
> +
> +void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +                                             unsigned long archid, unsigned long impid,
> +                                             unsigned int stage)
> +{
> +       struct alt_entry *alt;
> +       u32 cpu_req_errata = thead_errata_probe(stage, archid, impid);
> +       u32 tmp;
> +
> +       for (alt = begin; alt < end; alt++) {
> +               if (alt->vendor_id != THEAD_VENDOR_ID)
> +                       continue;
> +               if (alt->errata_id >= ERRATA_THEAD_NUMBER)
> +                       continue;
> +
> +               tmp = (1U << alt->errata_id);
> +               if (cpu_req_errata & tmp) {
> +                       /* On vm-alternatives, the mmu isn't running yet */
> +                       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +                               memcpy((void *)__pa_symbol(alt->old_ptr),
> +                                      (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
> +                       else
> +                               patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +               }
> +       }
> +
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               local_flush_icache_all();
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 64936356c37c..6511dd73e812 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -21,8 +21,10 @@
>
>  #define RISCV_ALTERNATIVES_BOOT                0 /* alternatives applied during regular boot */
>  #define RISCV_ALTERNATIVES_MODULE      1 /* alternatives applied during module-init */
> +#define RISCV_ALTERNATIVES_EARLY_BOOT  2 /* alternatives applied before mmu start */
>
>  void __init apply_boot_alternatives(void);
> +void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
>
>  struct alt_entry {
> @@ -41,6 +43,9 @@ struct errata_checkfunc_id {
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                               unsigned long archid, unsigned long impid,
>                               unsigned int stage);
> +void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +                            unsigned long archid, unsigned long impid,
> +                            unsigned int stage);
>
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                                  unsigned int stage);
> @@ -48,6 +53,7 @@ void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  #else /* CONFIG_RISCV_ALTERNATIVE */
>
>  static inline void apply_boot_alternatives(void) { }
> +static inline void apply_early_boot_alternatives(void) { }
>  static inline void apply_module_alternatives(void *start, size_t length) { }
>
>  #endif /* CONFIG_RISCV_ALTERNATIVE */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index dbfcd9b72bd8..9e2888dbb5b1 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -14,6 +14,11 @@
>  #define        ERRATA_SIFIVE_NUMBER 2
>  #endif
>
> +#ifdef CONFIG_ERRATA_THEAD
> +#define        ERRATA_THEAD_PBMT 0
> +#define        ERRATA_THEAD_NUMBER 1
> +#endif
> +
>  #define        CPUFEATURE_SVPBMT 0
>  #define        CPUFEATURE_NUMBER 1
>
> @@ -42,12 +47,51 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,    \
>   * in the default case.
>   */
>  #define ALT_SVPBMT_SHIFT 61
> +#define ALT_THEAD_PBMT_SHIFT 59
>  #define ALT_SVPBMT(_val, prot)                                         \
> -asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,    \
> -               CPUFEATURE_SVPBMT, CONFIG_RISCV_ISA_SVPBMT)             \
> +asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                   \
> +                 "li %0, %1\t\nslli %0,%0,%3", 0,                      \
> +                       CPUFEATURE_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,     \
> +                 "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,        \
> +                       ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)    \
>                 : "=r"(_val)                                            \
>                 : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),               \
> -                 "I"(ALT_SVPBMT_SHIFT))
> +                 "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),            \
> +                 "I"(ALT_SVPBMT_SHIFT),                                \
> +                 "I"(ALT_THEAD_PBMT_SHIFT))
> +
> +#ifdef CONFIG_ERRATA_THEAD_PBMT
> +/*
> + * IO/NOCACHE memory types are handled together with svpbmt,
> + * so on T-Head chips, check if no other memory type is set,
> + * and set the non-0 PMA type if applicable.
> + */
> +#define ALT_THEAD_PMA(_val)                                            \
> +asm volatile(ALTERNATIVE(                                              \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop\n\t"                                                       \
> +       "nop",                                                          \
> +       "li      t3, %2\n\t"                                            \
> +       "slli    t3, t3, %4\n\t"                                        \
> +       "and     t3, %0, t3\n\t"                                        \
> +       "bne     t3, zero, 2f\n\t"                                      \
> +       "li      t3, %3\n\t"                                            \
> +       "slli    t3, t3, %4\n\t"                                        \
> +       "or      %0, %0, t3\n\t"                                        \
> +       "2:",  THEAD_VENDOR_ID,                                         \
> +               ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)            \
> +       : "+r"(_val)                                                    \
> +       : "0"(_val),                                                    \
> +         "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),              \
> +         "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),                 \
> +         "I"(ALT_THEAD_PBMT_SHIFT))
> +#else
> +#define ALT_THEAD_PMA(_val)
> +#endif
>
>  #endif /* __ASSEMBLY__ */
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 2354501f0203..e4ff3e0ab887 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -86,6 +86,18 @@ typedef struct {
>  #define _PAGE_IO_SVPBMT                (1UL << 62)
>  #define _PAGE_MTMASK_SVPBMT    (_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
>
> +/*
> + * [63:59] T-Head Memory Type definitions:
> + *
> + * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
> + * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
> + */
> +#define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | (1UL << 60))
> +#define _PAGE_NOCACHE_THEAD    0UL
> +#define _PAGE_IO_THEAD         (1UL << 63)
> +#define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
> +
>  static inline u64 riscv_page_mtmask(void)
>  {
>         u64 val;
> @@ -193,7 +205,11 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
>
>  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>  {
> -       return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> +       unsigned long prot_val = pgprot_val(prot);
> +
> +       ALT_THEAD_PMA(prot_val);
> +
> +       return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
>  }
>
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index c55341b72de1..6f0a260d3f2c 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -250,7 +250,11 @@ static inline void pmd_clear(pmd_t *pmdp)
>
>  static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
>  {
> -       return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> +       unsigned long prot_val = pgprot_val(prot);
> +
> +       ALT_THEAD_PMA(prot_val);
> +
> +       return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
>  }
>
>  static inline unsigned long _pgd_pfn(pgd_t pgd)
> @@ -289,7 +293,11 @@ static inline unsigned long pte_pfn(pte_t pte)
>  /* Constructs a page table entry */
>  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
>  {
> -       return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> +       unsigned long prot_val = pgprot_val(prot);
> +
> +       ALT_THEAD_PMA(prot_val);
> +
> +       return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
>  }
>
>  #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
> @@ -398,7 +406,11 @@ static inline int pmd_protnone(pmd_t pmd)
>  /* Modify page protection bits */
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
> +       unsigned long newprot_val = pgprot_val(newprot);
> +
> +       ALT_THEAD_PMA(newprot_val);
> +
> +       return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
>  }
>
>  #define pgd_ERROR(e) \
> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
> index 9d934215b3c8..cb89af3f0704 100644
> --- a/arch/riscv/include/asm/vendorid_list.h
> +++ b/arch/riscv/include/asm/vendorid_list.h
> @@ -6,5 +6,6 @@
>  #define ASM_VENDOR_LIST_H
>
>  #define SIFIVE_VENDOR_ID       0x489
> +#define THEAD_VENDOR_ID                0x5b7
>
>  #endif
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index 27f722ae452b..e7980bf17e8b 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -42,6 +42,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
>         case SIFIVE_VENDOR_ID:
>                 cpu_mfr_info->vendor_patch_func = sifive_errata_patch_func;
>                 break;
> +#endif
> +#ifdef CONFIG_ERRATA_THEAD
> +       case THEAD_VENDOR_ID:
> +               cpu_mfr_info->vendor_patch_func = thead_errata_patch_func;
> +               break;
>  #endif
>         default:
>                 cpu_mfr_info->vendor_patch_func = NULL;
> @@ -82,6 +87,13 @@ void __init apply_boot_alternatives(void)
>                             RISCV_ALTERNATIVES_BOOT);
>  }
>
> +void __init apply_early_boot_alternatives(void)
> +{
> +       _apply_alternatives((struct alt_entry *)__alt_start,
> +                           (struct alt_entry *)__alt_end,
> +                           RISCV_ALTERNATIVES_EARLY_BOOT);
> +}
> +
>  #ifdef CONFIG_MODULES
>  void apply_module_alternatives(void *start, size_t length)
>  {
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index f514b949c6a7..dea3ea19deee 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -254,7 +254,12 @@ struct cpufeature_info {
>  static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
>  {
>  #ifdef CONFIG_RISCV_ISA_SVPBMT
> -       return riscv_isa_extension_available(NULL, SVPBMT);
> +       switch (stage) {
> +       case RISCV_ALTERNATIVES_EARLY_BOOT:
> +               return false;
> +       default:
> +               return riscv_isa_extension_available(NULL, SVPBMT);
> +       }
>  #endif
>
>         return false;
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9535bea8688c..1d35a0667db3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -935,6 +935,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
>  #endif
>
> +       apply_early_boot_alternatives();
>         pt_ops_set_early();
>
>         /* Setup early PGD for fixmap */
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
