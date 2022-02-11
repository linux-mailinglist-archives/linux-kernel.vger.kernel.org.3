Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4174B1A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbiBKAOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:14:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiBKANI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:13:08 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38452270A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:13:07 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id o19so20123859ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESp2E7pfeoT/Ep8DHoSveXOnYfjxa2ukAzQSH1Y2Mbs=;
        b=nVaWv9+tvMOBlqULefkviMb0X2xJzyBEFJNLBLgFypUfrS9vTOk+HH58OehkxWlcZr
         Si91yfok32pxuoZ5Bzq+dDPBqb92Csd46d7KQznJqWiv42AwQmuhrp9GBODqhzq5nC7Q
         grpJdLL8r+9zvTSfTQgPa0EOw9FZjYqlYoFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESp2E7pfeoT/Ep8DHoSveXOnYfjxa2ukAzQSH1Y2Mbs=;
        b=SN+BA+UK60Mv2Lwn+SXAhQIU+26EGzpOvqT7f6XhuiCj6PPJoRszfE9UcZYcVeIbul
         FL6m20CAG50OynVGI93iqRAwPzrhMM4sCO23pIMQYD09k5DgELyRZvC5roUvJ0pwARu2
         o0J5HB03kqfMEOqZwNthn3PBNtA0SLEoZw4ai1n2p4fCj6i1SifprKOc4qlR+MgcTl+J
         +1VSJiaq150dLIQZFUB71/LjTajoXcd8LZ5xiOtUXvPt1sTJgrVO9a1GcECUOUvJoE+c
         QaNfE+tpy0eaqFsixx//JDVk5dky6xQ2dO2I7EqnYfH8WyMbDt3CBEitZcQZM+jCNCA1
         pRWA==
X-Gm-Message-State: AOAM533+PvSbkqRr3bh1cAINZwjofWBh3ZE2h1k/wn8QdyiG83RuEnyp
        1hzCmR3MDAP5rvo2eVIrhC7lT8e1y9DEwddpnsG2
X-Google-Smtp-Source: ABdhPJzv5y7rMTiwliOC7ZtzsES1QyzKHnNjh0FOdc2dd9fKr9gwE4F6V691iqLUDyE1u9OUro8JLlJVhXV5ZHVCw8U=
X-Received: by 2002:a25:8b0a:: with SMTP id i10mr10088995ybl.651.1644538386314;
 Thu, 10 Feb 2022 16:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <20220209123800.269774-15-heiko@sntech.de>
In-Reply-To: <20220209123800.269774-15-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 10 Feb 2022 16:12:55 -0800
Message-ID: <CAOnJCU+zoSfvyFg0swotCt1NH9bHOr4OX0g4H97ZkV4-UpSyNw@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] riscv: add memory-type errata for T-Head
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:41 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Some current cpus based on T-Head cores implement memory-types
> way different than described in the svpbmt spec even going
> so far as using PTE bits marked as reserved.
>
> Add the T-Head vendor-id and necessary errata code to
> replace the affected instructions.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig.erratas             | 19 ++++++
>  arch/riscv/errata/Makefile             |  1 +
>  arch/riscv/errata/sifive/errata.c      |  7 ++-
>  arch/riscv/errata/thead/Makefile       |  1 +
>  arch/riscv/errata/thead/errata.c       | 85 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/alternative.h   |  5 ++
>  arch/riscv/include/asm/errata_list.h   | 47 ++++++++++++--
>  arch/riscv/include/asm/pgtable-64.h    | 18 +++++-
>  arch/riscv/include/asm/pgtable.h       | 18 +++++-
>  arch/riscv/include/asm/vendorid_list.h |  1 +
>  arch/riscv/kernel/alternative.c        | 14 +++++
>  arch/riscv/kernel/cpufeature.c         |  2 +
>  arch/riscv/mm/init.c                   |  1 +
>  13 files changed, 210 insertions(+), 9 deletions(-)
>  create mode 100644 arch/riscv/errata/thead/Makefile
>  create mode 100644 arch/riscv/errata/thead/errata.c
>
> diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> index d18be8ff0245..380ec039c3dc 100644
> --- a/arch/riscv/Kconfig.erratas
> +++ b/arch/riscv/Kconfig.erratas
> @@ -31,4 +31,23 @@ config ERRATA_SIFIVE_CIP_1200
>
>           If you don't know what to do here, say "Y".
>
> +config ERRATA_THEAD
> +       bool "T-HEAD errata"
> +       help
> +         All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> +         this Kconfig will disable all T-HEAD errata. Please say "Y"
> +         here if your platform uses T-HEAD CPU cores.
> +
> +         If you don't know what to do here, say "Y".
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
> index 4fe03ac41fd7..f933d6cdf304 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -84,10 +84,15 @@ void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *
>                                      unsigned int stage)
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
> index 000000000000..fd8e0538a3f0
> --- /dev/null
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -0,0 +1,85 @@
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
> +       u32 cpu_apply_errata = 0;
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
> +
> +                       cpu_apply_errata |= tmp;
> +               }
> +       }
> +
> +       if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> +               local_flush_icache_all();
> +}
> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index cf3b22173834..d1154c91ab03 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -19,8 +19,10 @@
>
>  #define RISCV_ALTERNATIVES_BOOT                0 /* alternatives applied during regular boot */
>  #define RISCV_ALTERNATIVES_MODULE      1 /* alternatives applied during module-init */
> +#define RISCV_ALTERNATIVES_EARLY_BOOT  2 /* alternatives applied before mmu start */
>

But this stage invoked is used after RISCV_ALTERNATIVES_BOOT

>  void __init apply_boot_alternatives(void);
> +void __init apply_early_boot_alternatives(void);
>  void apply_module_alternatives(void *start, size_t length);
>
>  struct alt_entry {
> @@ -39,6 +41,9 @@ struct errata_checkfunc_id {
>  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                               unsigned long archid, unsigned long impid,
>                               unsigned int stage);
> +void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +                            unsigned long archid, unsigned long impid,
> +                            unsigned int stage);
>
>  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
>                                  unsigned int stage);
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index a4a9b0842922..4fac46b82c16 100644
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
> @@ -42,10 +47,44 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,    \
>   * in the default case.
>   */
>  #define ALT_SVPBMT_SHIFT 61
> -#define ALT_SVPBMT(_val, prot)                                         \
> -asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,    \
> -               CPUFEATURE_SVPBMT, CONFIG_64BIT)                        \
> -               : "=r"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT), "I"(ALT_SVPBMT_SHIFT))
> +#define ALT_THEAD_PBMT_SHIFT 59
> +#define ALT_SVPBMT(_val, prot)                                                         \
> +asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                                   \
> +                 "li %0, %1\t\nslli %0,%0,%3", 0, CPUFEATURE_SVPBMT, CONFIG_64BIT,     \
> +                 "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID, ERRATA_THEAD_PBMT,     \
> +                                               CONFIG_ERRATA_THEAD_PBMT)               \
> +               : "=r"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),                  \
> +                              "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),               \
> +                              "I"(ALT_SVPBMT_SHIFT), "I"(ALT_THEAD_PBMT_SHIFT))
> +
> +#ifdef CONFIG_ERRATA_THEAD_PBMT
> +/*
> + * IO/NOCACHE memory types are handled together with svpbmt,
> + * so on T-Head chips, check if no other memory type is set,
> + * and set the non-0 PMA type if applicable.
> + */
> +#define ALT_THEAD_PMA(_val)                                                            \
> +asm volatile(ALTERNATIVE(                                                              \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop\n\t"                                                                       \
> +       "nop",                                                                          \
> +       "li      t3, %2\n\t"                                                            \
> +       "slli    t3, t3, %4\n\t"                                                        \
> +       "and     t3, %0, t3\n\t"                                                        \
> +       "bne     t3, zero, 2f\n\t"                                                      \
> +       "li      t3, %3\n\t"                                                            \
> +       "slli    t3, t3, %4\n\t"                                                        \
> +       "or      %0, %0, t3\n\t"                                                        \
> +       "2:",  THEAD_VENDOR_ID, ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)            \
> +       : "+r"(_val) : "0"(_val), "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),      \
> +                      "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),  "I"(ALT_THEAD_PBMT_SHIFT))
> +#else
> +#define ALT_THEAD_PMA(_val)
> +#endif
>
>  #endif /* __ASSEMBLY__ */
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 07ba3416cb19..6d59e4695200 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -69,6 +69,18 @@ typedef struct {
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
> @@ -167,7 +179,11 @@ static inline bool mm_pud_folded(struct mm_struct *mm)
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
> index b8abc75dfe01..3d0c4c144093 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -245,7 +245,11 @@ static inline void pmd_clear(pmd_t *pmdp)
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
> @@ -284,7 +288,11 @@ static inline unsigned long pte_pfn(pte_t pte)
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
> @@ -393,7 +401,11 @@ static inline int pmd_protnone(pmd_t pmd)
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
> index e6c9de9f9ba6..3f6ad91f524c 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -48,6 +48,11 @@ static void __init init_alternative(void)
>         case SIFIVE_VENDOR_ID:
>                 vendor_patch_func = sifive_errata_patch_func;
>                 break;
> +#endif
> +#ifdef CONFIG_ERRATA_THEAD
> +       case THEAD_VENDOR_ID:
> +               vendor_patch_func = thead_errata_patch_func;
> +               break;
>  #endif
>         default:
>                 vendor_patch_func = NULL;
> @@ -85,6 +90,15 @@ void __init apply_boot_alternatives(void)
>                             RISCV_ALTERNATIVES_BOOT);
>  }
>
> +void __init apply_early_boot_alternatives(void)
> +{
> +       init_alternative();
> +
> +       _apply_alternatives((struct alt_entry *)__alt_start,
> +                           (struct alt_entry *)__alt_end,
> +                           RISCV_ALTERNATIVES_EARLY_BOOT);
> +}
> +

The name is a bit confusing as there is another "apply_boot_alternatives"
which was called earlier than "apply_early_boot_alternatives".


>  #ifdef CONFIG_MODULES
>  void apply_module_alternatives(void *start, size_t length)
>  {
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 7bce66ee7ce7..ecc248e5dab7 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -224,6 +224,8 @@ static bool cpufeature_svpbmt_check_func(unsigned int stage)
>
>  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>         switch (stage) {
> +       case RISCV_ALTERNATIVES_EARLY_BOOT:
> +               return false;
>         case RISCV_ALTERNATIVES_BOOT:
>                 return cpufeature_svpbmt_check_fdt();
>         default:
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index cf4d018b7d66..7216db5d6a2c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -819,6 +819,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
>  #endif
>
> +       apply_early_boot_alternatives();
>         pt_ops_set_early();
>
>         /* Setup early PGD for fixmap */
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish
