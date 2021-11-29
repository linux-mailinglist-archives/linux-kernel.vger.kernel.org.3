Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EF4612EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbhK2Ky0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:54:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35558
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354131AbhK2KwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:52:25 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 639203F1A9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638182946;
        bh=69uDV6+NSSzTLekCuEt6hqxoScJTyrGyQw8QVGaKhp0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fv1h3Mf+DRANGNwm7pSGJnUy9gplZOGVXNOjnpK1IdgsIGSf/XoHHgepttxCobNIT
         K7FPtxdno8ZZTsW9Qo91HqqScLhzvAH8cCx6QksLpUmck8oXz2HbS6gotyddAZblys
         lZJ0ViIt3R9O61eBcY1l1t58xguHUxoqwllgYOqhMieRWKPz/3q+knmuQTKfyXs2vT
         Y5bCFOtZb6UR2u+M1VYMzrRBQZvPLre6F5CIgaX6KlZ2C2s6D/8yPQxpPNrbnCEIf6
         SHkSnBCyjD2tGjNIP0k/AejNTrBnQkgeB6nJJYg/Y9SBQqKjZdRsaOEDCpSvI/Hndm
         O/ldHXq5AiyKg==
Received: by mail-ed1-f70.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so13333146edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 02:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69uDV6+NSSzTLekCuEt6hqxoScJTyrGyQw8QVGaKhp0=;
        b=YJTQ4XzjE5IJUDxcc7QGAd9nUlj8PNtDfgkveuO8P/BjXfhcL69BfColg4FnM7sOnV
         6rC9H6RqqLTBb8atRkqDmSqUaSehdc/vWEgxBh7wYAY0Nrmls7islLHcDqZgFJXkf7S5
         LvF/klqlvRsh1iLqna6M0z9VtF1Z+LgKaYKBM6kONeSO6Scb/TdQW8oyl2DrTXBC1qbi
         DbtEQJsKeomu8b4brQ9dKmKpzcIKotTwiL1bY9568lXJOqstiQcAqNVAZk7eqX+1PXH2
         /FSo5IztUoy9GNDsjplDwQMrg952xZsJsj2e4J777yFswTYHPbXMGM234e83W23wUXuL
         XpLA==
X-Gm-Message-State: AOAM531rRAwq/1q+JO9GHqjoIQmuJalL5/P476wSpYq4Jk2lHzbp2cTY
        eWaSFyv3ER1lBzcgV7SrN1YbUJ5qho2s7p5rxxMPV3KO6C4mGvBMHruId5ZT44bbpiTcV3Xew7W
        daUoUmgCJHS4Q4S1c8D87H3W/h4dCHfzITmwv/6kQ1xSlW5sqaJE+u/dPkg==
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr73037639edb.158.1638182945923;
        Mon, 29 Nov 2021 02:49:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmXbFy3arQelp17/Nf74m271ptnaMDsiIG4wCHXzbZkZDzfMJPRNMIWEnZ2OQx6Nb4zGvoEjHMTy9UTUc44Zs=
X-Received: by 2002:a05:6402:4242:: with SMTP id g2mr73037598edb.158.1638182945634;
 Mon, 29 Nov 2021 02:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <20211129014007.286478-3-wefu@redhat.com>
In-Reply-To: <20211129014007.286478-3-wefu@redhat.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Mon, 29 Nov 2021 11:48:54 +0100
Message-ID: <CA+zEjCsPR4C0EmUHUKwMtoU0jj_33S_kBZJWD1NLGnXK9yjOZw@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] riscv: add RISC-V Svpbmt extension supports
To:     wefu@redhat.com
Cc:     anup.patel@wdc.com, atishp04@gmail.com, palmer@dabbelt.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 2:42 AM <wefu@redhat.com> wrote:
>
> From: Wei Fu <wefu@redhat.com>
>
> This patch follows the standard pure RISC-V Svpbmt extension in
> privilege spec to solve the non-coherent SOC dma synchronization
> issues.
>
> Here is the svpbmt PTE format:
> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   N     MT     RSW    D   A   G   U   X   W   R   V
>         ^
>
> Of the Reserved bits [63:54] in a leaf PTE, the high bit is already
> allocated (as the N bit), so bits [62:61] are used as the MT (aka
> MemType) field. This field specifies one of three memory types that
> are close equivalents (or equivalent in effect) to the three main x86
> and ARMv8 memory types - as shown in the following table.
>
> RISC-V
> Encoding &
> MemType     RISC-V Description
> ----------  ------------------------------------------------
> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> 11 - Rsvd   Reserved for future standard use
>
> The standard protection_map[] needn't be modified because the "PMA"
> type keeps the highest bits zero. And the whole modification is
> limited in the arch/riscv/* and using a global variable
> (__svpbmt) as _PAGE_MASK/IO/NOCACHE for pgprot_noncached
> (&writecombine) in pgtable.h. We also add _PAGE_CHG_MASK to filter
> PFN than before.
>
> Enable it in devicetree - (Add "riscv,svpbmt" in the mmu of cpu node)
>  - mmu:
>      riscv,svpmbt
>
> Signed-off-by: Wei Fu <wefu@redhat.com>
> Co-developed-by: Liu Shaohua <liush@allwinnertech.com>
> Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Drew Fustini <drew@beagleboard.org>
> Cc: Wei Fu <wefu@redhat.com>
> Cc: Wei Wu <lazyparser@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Greg Favor <gfavor@ventanamicro.com>
> Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
> Cc: Jonathan Behrens <behrensj@mit.edu>
> Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
> Cc: Bill Huffman <huffman@cadence.com>
> Cc: Nick Kossifidis <mick@ics.forth.gr>
> Cc: Allen Baum <allen.baum@esperantotech.com>
> Cc: Josh Scheid <jscheid@ventanamicro.com>
> Cc: Richard Trauben <rtrauben@gmail.com>
> ---
>  arch/riscv/include/asm/fixmap.h       |  2 +-
>  arch/riscv/include/asm/pgtable-64.h   | 21 ++++++++++++---
>  arch/riscv/include/asm/pgtable-bits.h | 39 +++++++++++++++++++++++++--
>  arch/riscv/include/asm/pgtable.h      | 39 ++++++++++++++++++++-------
>  arch/riscv/kernel/cpufeature.c        | 35 ++++++++++++++++++++++++
>  arch/riscv/mm/init.c                  |  5 ++++
>  6 files changed, 126 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 54cbf07fb4e9..5acd99d08e74 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -43,7 +43,7 @@ enum fixed_addresses {
>         __end_of_fixed_addresses
>  };
>
> -#define FIXMAP_PAGE_IO         PAGE_KERNEL
> +#define FIXMAP_PAGE_IO         PAGE_IOREMAP
>
>  #define __early_set_fixmap     __set_fixmap
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 228261aa9628..16d251282b1d 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -59,14 +59,29 @@ static inline void pud_clear(pud_t *pudp)
>         set_pud(pudp, __pud(0));
>  }
>
> +static inline unsigned long _chg_of_pmd(pmd_t pmd)
> +{
> +       return (pmd_val(pmd) & _PAGE_CHG_MASK);
> +}
> +
> +static inline unsigned long _chg_of_pud(pud_t pud)
> +{
> +       return (pud_val(pud) & _PAGE_CHG_MASK);
> +}
> +
> +static inline unsigned long _chg_of_pte(pte_t pte)
> +{
> +       return (pte_val(pte) & _PAGE_CHG_MASK);
> +}

Those functions are used to extract the pfn from a page table entry,
IMO it would be clearer if those functions would look like that:

static inline unsigned long pmd_to_pfn(pmd_t pmd)
{
    return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
}

> +
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -       return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return (pmd_t *)pfn_to_virt(_chg_of_pud(pud) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline struct page *pud_page(pud_t pud)
>  {
> -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page(_chg_of_pud(pud) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> @@ -76,7 +91,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +       return _chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT;
>  }
>

Like this one actually, so if this exists for other levels, I would
suggest to modify those functions to directly mask the PMA bits and
use those in the whole code instead of manually extracting the pfn.

>  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index 2ee413912926..e5b0fce4ddc5 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -7,7 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_BITS_H
>
>  /*
> - * PTE format:
> + * rv32 PTE format:
>   * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   *       PFN      reserved for SW   D   A   G   U   X   W   R   V
>   */
> @@ -24,6 +24,40 @@
>  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
>  #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
>
> +#if !defined(__ASSEMBLY__) && defined(CONFIG_64BIT)
> +/*
> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> + * [62:61] Memory Type definitions:
> + *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
> + *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> + *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> + *  11 - Rsvd   Reserved for future standard use
> + */
> +#define _SVPBMT_PMA            0UL
> +#define _SVPBMT_NC             (1UL << 61)
> +#define _SVPBMT_IO             (1UL << 62)
> +#define _SVPBMT_MASK           (_SVPBMT_NC | _SVPBMT_IO)
> +
> +extern struct __svpbmt_struct {
> +       unsigned long mask;
> +       unsigned long pma;
> +       unsigned long nocache;
> +       unsigned long io;
> +} __svpbmt __cacheline_aligned;
> +
> +#define _PAGE_MASK             __svpbmt.mask

To me, _PAGE_MASK means something else:
https://elixir.bootlin.com/linux/latest/source/arch/s390/include/asm/page.h#L16
Maybe something more explicit like _PAGE_SVPBMT_MASK?

> +#define _PAGE_PMA              __svpbmt.pma
> +#define _PAGE_NOCACHE          __svpbmt.nocache
> +#define _PAGE_IO               __svpbmt.io
> +#else
> +#define _PAGE_MASK             0
> +#define _PAGE_PMA              0
> +#define _PAGE_NOCACHE          0
> +#define _PAGE_IO               0
> +#endif /* !__ASSEMBLY__ && CONFIG_64BIT */
> +
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
>
> @@ -38,7 +72,8 @@
>  /* Set of bits to preserve across pte_modify() */
>  #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ | \
>                                           _PAGE_WRITE | _PAGE_EXEC |    \
> -                                         _PAGE_USER | _PAGE_GLOBAL))
> +                                         _PAGE_USER | _PAGE_GLOBAL |   \
> +                                         _PAGE_MASK))
>  /*
>   * when all of R/W/X are zero, the PTE is a pointer to the next level
>   * of the page table; otherwise, it is a leaf PTE.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bf204e7c1f74..0f7a6541015f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -138,7 +138,8 @@
>                                 | _PAGE_PRESENT \
>                                 | _PAGE_ACCESSED \
>                                 | _PAGE_DIRTY \
> -                               | _PAGE_GLOBAL)
> +                               | _PAGE_GLOBAL \
> +                               | _PAGE_PMA)
>
>  #define PAGE_KERNEL            __pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_READ       __pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> @@ -148,11 +149,9 @@
>
>  #define PAGE_TABLE             __pgprot(_PAGE_TABLE)
>
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
> - * change the properties of memory regions.
> - */
> -#define _PAGE_IOREMAP _PAGE_KERNEL
> +#define _PAGE_IOREMAP  ((_PAGE_KERNEL & ~_PAGE_MASK) | _PAGE_IO)
> +
> +#define PAGE_IOREMAP           __pgprot(_PAGE_IOREMAP)
>
>  extern pgd_t swapper_pg_dir[];
>
> @@ -232,12 +231,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
>
>  static inline struct page *pmd_page(pmd_t pmd)
>  {
> -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return pfn_to_page(_chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +       return (unsigned long)pfn_to_virt(_chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT);
>  }
>
>  static inline pte_t pmd_pte(pmd_t pmd)
> @@ -253,7 +252,7 @@ static inline pte_t pud_pte(pud_t pud)
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> +       return (_chg_of_pte(pte) >> _PAGE_PFN_SHIFT);
>  }
>
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> @@ -492,6 +491,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>         return ptep_test_and_clear_young(vma, address, ptep);
>  }
>
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +       unsigned long prot = pgprot_val(_prot);
> +
> +       prot &= ~_PAGE_MASK;
> +       prot |= _PAGE_IO;
> +
> +       return __pgprot(prot);
> +}
> +
> +#define pgprot_writecombine pgprot_writecombine
> +static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
> +{
> +       unsigned long prot = pgprot_val(_prot);
> +
> +       prot &= ~_PAGE_MASK;
> +       prot |= _PAGE_NOCACHE;
> +
> +       return __pgprot(prot);
> +}
> +
>  /*
>   * THP functions
>   */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index d959d207a40d..fa7480cb8b87 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/bitmap.h>
>  #include <linux/of.h>
> +#include <linux/pgtable.h>
>  #include <asm/processor.h>
>  #include <asm/hwcap.h>
>  #include <asm/smp.h>
> @@ -59,6 +60,38 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
>  }
>  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
>
> +static void __init mmu_supports_svpbmt(void)
> +{
> +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> +       struct device_node *node;
> +       const char *str;
> +
> +       for_each_of_cpu_node(node) {
> +               if (of_property_read_string(node, "mmu-type", &str))
> +                       continue;
> +
> +               if (!strncmp(str + 6, "none", 4))
> +                       continue;
> +
> +               if (of_property_read_string(node, "mmu", &str))
> +                       continue;
> +
> +               if (strncmp(str + 6, "svpmbt", 6))
> +                       continue;
> +       }
> +
> +       __svpbmt.pma            = _SVPBMT_PMA;
> +       __svpbmt.nocache        = _SVPBMT_NC;
> +       __svpbmt.io             = _SVPBMT_IO;
> +       __svpbmt.mask           = _SVPBMT_MASK;
> +#endif
> +}
> +
> +static void __init mmu_supports(void)
> +{
> +       mmu_supports_svpbmt();
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>         struct device_node *node;
> @@ -67,6 +100,8 @@ void __init riscv_fill_hwcap(void)
>         size_t i, j, isa_len;
>         static unsigned long isa2hwcap[256] = {0};
>
> +       mmu_supports();
> +
>         isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
>         isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
>         isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..e4e658165ee1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -854,3 +854,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>         return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#if defined(CONFIG_64BIT)
> +struct __svpbmt_struct __svpbmt __ro_after_init;
> +EXPORT_SYMBOL(__svpbmt);
> +#endif
> --
> 2.25.4
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
