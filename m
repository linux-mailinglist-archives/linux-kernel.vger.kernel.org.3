Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC54616F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhK2Nt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:49:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37916 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbhK2NrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:47:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89E52B81187
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FFEC004E1;
        Mon, 29 Nov 2021 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638193439;
        bh=xW+x1uYxNBzgqFp264zeci+o3oTSBW/7ZrxQA9tyRuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QodEdWR6Sm9RXCTGPerV2RX2Ij2iynpfAFlB79yXSsn+SvShw5fl/12EJ9GcxU6ZL
         jHtNQ/zR7iZ7IhH8/2O0XvRhcslIa2FjL66HlqEwJW5va/E0DLmai5Iikkre9Kq7xb
         TGP1XC57zmn9EKcjIhhaLpZDBmKoXZULRc2W76zdSh8sldpWRmvgtgG6P31THfM2Xf
         6Tcxnuedz9bi5T1zxZvHDQImKAZMP+EunFpDPLOaYN6KdzYDVPUfp1saWwockHLaac
         UoFCaha0b1VjNwUc7K5HuI63tO6O+0ATtM3zoarMZYcdlongc8aQ6V3n7vg/J+NUH7
         1q76eylBlgPmg==
Date:   Mon, 29 Nov 2021 21:36:42 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
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
Subject: Re: [PATCH V4 2/2] riscv: add RISC-V Svpbmt extension supports
Message-ID: <20211129213634.1fe31b10@xhacker>
In-Reply-To: <20211129014007.286478-3-wefu@redhat.com>
References: <20211129014007.286478-1-wefu@redhat.com>
        <20211129014007.286478-3-wefu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 09:40:07 +0800
wefu@redhat.com wrote:

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
>  	__end_of_fixed_addresses
>  };
>  
> -#define FIXMAP_PAGE_IO		PAGE_KERNEL
> +#define FIXMAP_PAGE_IO		PAGE_IOREMAP
>  
>  #define __early_set_fixmap	__set_fixmap
>  
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 228261aa9628..16d251282b1d 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -59,14 +59,29 @@ static inline void pud_clear(pud_t *pudp)
>  	set_pud(pudp, __pud(0));
>  }
>  
> +static inline unsigned long _chg_of_pmd(pmd_t pmd)
> +{
> +	return (pmd_val(pmd) & _PAGE_CHG_MASK);
> +}
> +
> +static inline unsigned long _chg_of_pud(pud_t pud)
> +{
> +	return (pud_val(pud) & _PAGE_CHG_MASK);
> +}
> +
> +static inline unsigned long _chg_of_pte(pte_t pte)
> +{
> +	return (pte_val(pte) & _PAGE_CHG_MASK);
> +}
> +
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +	return (pmd_t *)pfn_to_virt(_chg_of_pud(pud) >> _PAGE_PFN_SHIFT);
>  }
>  
>  static inline struct page *pud_page(pud_t pud)
>  {
> -	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +	return pfn_to_page(_chg_of_pud(pud) >> _PAGE_PFN_SHIFT);
>  }
>  
>  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> @@ -76,7 +91,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>  
>  static inline unsigned long _pmd_pfn(pmd_t pmd)
>  {
> -	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +	return _chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT;
>  }
>  
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
> +#define _SVPBMT_PMA		0UL
> +#define _SVPBMT_NC		(1UL << 61)
> +#define _SVPBMT_IO		(1UL << 62)
> +#define _SVPBMT_MASK		(_SVPBMT_NC | _SVPBMT_IO)
> +
> +extern struct __svpbmt_struct {
> +	unsigned long mask;
> +	unsigned long pma;
> +	unsigned long nocache;
> +	unsigned long io;
> +} __svpbmt __cacheline_aligned;
> +
> +#define _PAGE_MASK		__svpbmt.mask
> +#define _PAGE_PMA		__svpbmt.pma
> +#define _PAGE_NOCACHE		__svpbmt.nocache
> +#define _PAGE_IO		__svpbmt.io
> +#else
> +#define _PAGE_MASK		0
> +#define _PAGE_PMA		0
> +#define _PAGE_NOCACHE		0
> +#define _PAGE_IO		0
> +#endif /* !__ASSEMBLY__ && CONFIG_64BIT */
> +
>  #define _PAGE_SPECIAL   _PAGE_SOFT
>  #define _PAGE_TABLE     _PAGE_PRESENT
>  
> @@ -38,7 +72,8 @@
>  /* Set of bits to preserve across pte_modify() */
>  #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
>  					  _PAGE_WRITE | _PAGE_EXEC |	\
> -					  _PAGE_USER | _PAGE_GLOBAL))
> +					  _PAGE_USER | _PAGE_GLOBAL |	\
> +					  _PAGE_MASK))
>  /*
>   * when all of R/W/X are zero, the PTE is a pointer to the next level
>   * of the page table; otherwise, it is a leaf PTE.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index bf204e7c1f74..0f7a6541015f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -138,7 +138,8 @@
>  				| _PAGE_PRESENT \
>  				| _PAGE_ACCESSED \
>  				| _PAGE_DIRTY \
> -				| _PAGE_GLOBAL)
> +				| _PAGE_GLOBAL \
> +				| _PAGE_PMA)
>  
>  #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
>  #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
> @@ -148,11 +149,9 @@
>  
>  #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
>  
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
> - * change the properties of memory regions.
> - */
> -#define _PAGE_IOREMAP _PAGE_KERNEL
> +#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MASK) | _PAGE_IO)
> +
> +#define PAGE_IOREMAP		__pgprot(_PAGE_IOREMAP)
>  
>  extern pgd_t swapper_pg_dir[];
>  
> @@ -232,12 +231,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
>  
>  static inline struct page *pmd_page(pmd_t pmd)
>  {
> -	return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +	return pfn_to_page(_chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT);
>  }
>  
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> -	return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> +	return (unsigned long)pfn_to_virt(_chg_of_pmd(pmd) >> _PAGE_PFN_SHIFT);
>  }
>  
>  static inline pte_t pmd_pte(pmd_t pmd)
> @@ -253,7 +252,7 @@ static inline pte_t pud_pte(pud_t pud)
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -	return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> +	return (_chg_of_pte(pte) >> _PAGE_PFN_SHIFT);
>  }
>  
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> @@ -492,6 +491,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>  	return ptep_test_and_clear_young(vma, address, ptep);
>  }
>  
> +#define pgprot_noncached pgprot_noncached
> +static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> +{
> +	unsigned long prot = pgprot_val(_prot);
> +
> +	prot &= ~_PAGE_MASK;
> +	prot |= _PAGE_IO;
> +
> +	return __pgprot(prot);
> +}
> +
> +#define pgprot_writecombine pgprot_writecombine
> +static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
> +{
> +	unsigned long prot = pgprot_val(_prot);
> +
> +	prot &= ~_PAGE_MASK;
> +	prot |= _PAGE_NOCACHE;
> +
> +	return __pgprot(prot);
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

IIRC, Christoph suggested a CONFIG_RISCV_SVPBMT when reviewing v3. What
about that idea?

> +	struct device_node *node;
> +	const char *str;
> +
> +	for_each_of_cpu_node(node) {
> +		if (of_property_read_string(node, "mmu-type", &str))
> +			continue;
> +
> +		if (!strncmp(str + 6, "none", 4))
> +			continue;
> +
> +		if (of_property_read_string(node, "mmu", &str))
> +			continue;
> +
> +		if (strncmp(str + 6, "svpmbt", 6))
> +			continue;
> +	}
> +
> +	__svpbmt.pma		= _SVPBMT_PMA;
> +	__svpbmt.nocache	= _SVPBMT_NC;
> +	__svpbmt.io		= _SVPBMT_IO;
> +	__svpbmt.mask		= _SVPBMT_MASK;
> +#endif
> +}
> +
> +static void __init mmu_supports(void)

can we remove this function currently? Instead, directly call
mmu_supports_svpbmt()?

> +{
> +	mmu_supports_svpbmt();
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
> @@ -67,6 +100,8 @@ void __init riscv_fill_hwcap(void)
>  	size_t i, j, isa_len;
>  	static unsigned long isa2hwcap[256] = {0};
>  
> +	mmu_supports();
> +
>  	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
>  	isa2hwcap['a'] = isa2hwcap['A'] = COMPAT_HWCAP_ISA_A;
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..e4e658165ee1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -854,3 +854,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	return vmemmap_populate_basepages(start, end, node, NULL);
>  }
>  #endif
> +
> +#if defined(CONFIG_64BIT)
> +struct __svpbmt_struct __svpbmt __ro_after_init;

Added the structure for all RV64 including NOMMU case and those platforms
which doen't want SVPBMT at all, I believe Christoph's CONFIG_RISCV_SVPBMT
suggestion can solve this problem.

> +EXPORT_SYMBOL(__svpbmt);
> +#endif

