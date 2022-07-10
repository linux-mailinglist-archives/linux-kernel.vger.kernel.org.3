Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC05656CF79
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiGJOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 10:33:10 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80512AEE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 07:33:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIrYmg6_1657463579;
Received: from 30.32.64.246(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIrYmg6_1657463579)
          by smtp.aliyun-inc.com;
          Sun, 10 Jul 2022 22:33:01 +0800
Message-ID: <999cc14c-9fa4-5edb-ef56-160904a5c16e@linux.alibaba.com>
Date:   Sun, 10 Jul 2022 22:32:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] arm64: mm: fix linear mem mapping access performance
 degradation
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
To:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com
Cc:     alikernel-developer@linux.alibaba.com
References: <f0dd1176-39f1-0a08-d0e2-627dd437aa5f@linux.alibaba.com>
 <1657460657-25698-1-git-send-email-guanghuifeng@linux.alibaba.com>
In-Reply-To: <1657460657-25698-1-git-send-email-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike Rapoport, Catalin Marinas, I have rewrited the patch to handle 
tlb conflict and Circular dependency.
Namely,

(1)When doing work for rebuiling crashkernel mem, the pgd is 
swapper_pg_dir in use.

(2)Firstly, I change the swapper_pg_dir pgd to idmap_pg_dir.
    As idmap_pg_dir use ttbr0_el1 and without any tlb confict in ttbr1_el1.
Afterward I flush all the tlb(all the swapper_pg_dir tlb cache flushed).

Later, I change idmap_pg_dir pgd to use init_pg_dir and flush tlb again. 
Therefor, there is no tlb conflict when rebuiding with 
init_pg_dir(without any tlb cache for swapper_pg_dir).

(3)When switch to init_pg_dir, I can saftely modify swapper_pg_dir 
pagetable withou any [[[Circular dependency]]] and tlb conflict.
Namely, When unmapping or modifying any swapper_pg_dir pagetable, I will 
use fix map to access the mem.

I have test it and work well. Could you give me some advice?

Thanks.

在 2022/7/10 21:44, Guanghui Feng 写道:
> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
> use non block/section mapping(for crashkernel requires to shrink the region
> in page granularity). But it will degrade performance when doing larging
> continuous mem access in kernel(memcpy/memmove, etc).
> 
> There are many changes and discussions:
> commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
> platforms with no DMA memory zones")
> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into
> mem_init()")
> commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel
> reservation is required")
> 
> This patch changes mem_map to use block/section mapping with crashkernel.
> Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
> mem_map, reserve crashkernel memory. And then walking pagetable to split
> block/section mapping to non block/section mapping(normally 4K) [[[only]]]
> for crashkernel mem. So the linear mem mapping use block/section mapping
> as more as possible. We will reduce the cpu dTLB miss conspicuously, and
> accelerate mem access about 10-20% performance improvement.
> 
> I have tested it with pft(Page Fault Test) and fio, obtained great
> performace improvement.
> 
> For fio test:
> 1.prepare ramdisk
>    modprobe -r brd
>    modprobe brd rd_nr=1 rd_size=67108864
>    dmsetup remove_all
>    wipefs -a --force /dev/ram0
>    mkfs -t ext4 -E lazy_itable_init=0,lazy_journal_init=0 -q -F /dev/ram0
>    mkdir -p /fs/ram0
>    mount -t ext4 /dev/ram0 /fs/ram0
> 
> 2.prepare fio paremeter in x.fio file:
> [global]
> bs=4k
> ioengine=psync
> iodepth=128
> size=32G
> direct=1
> invalidate=1
> group_reporting
> thread=1
> rw=read
> directory=/fs/ram0
> numjobs=1
> 
> [task_0]
> cpus_allowed=16
> stonewall=1
> 
> 3.run testcase:
> perf stat -e dTLB-load-misses fio x.fio
> 
> 4.contrast
> ------------------------
> 			without patch		with patch
> fio READ		aggrb=1493.2MB/s	aggrb=1775.3MB/s
> dTLB-load-misses	1,818,320,693		438,729,774
> time elapsed(s)		70.500326434		62.877316408
> user(s)			15.926332000		15.684721000
> sys(s)			54.211939000		47.046165000
> 
> 5.conclusion
> Using this patch will reduce dTLB misses and improve performace greatly.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>   arch/arm64/include/asm/mmu.h         |   1 +
>   arch/arm64/include/asm/mmu_context.h |  28 ++++
>   arch/arm64/mm/init.c                 |   8 +-
>   arch/arm64/mm/mmu.c                  | 305 +++++++++++++++++++++++++----------
>   arch/arm64/mm/proc.S                 |  19 +++
>   5 files changed, 267 insertions(+), 94 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 48f8466..1a46b81 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -63,6 +63,7 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>   extern void arm64_memblock_init(void);
>   extern void paging_init(void);
>   extern void bootmem_init(void);
> +extern void map_crashkernel(void);
>   extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
>   extern void init_mem_pgprot(void);
>   extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 6770667..10dffd4 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -139,6 +139,34 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
>   	isb();
>   }
>   
> +static inline void __nocfi cpu_replace_ttbr1_with_phys(phys_addr_t ttbr1)
> +{
> +	typedef void (ttbr_replace_func)(phys_addr_t);
> +	extern ttbr_replace_func idmap_cpu_replace_ttbr1_with_flush_tlb;
> +	ttbr_replace_func *replace_phys;
> +
> +	/* phys_to_ttbr() zeros lower 2 bits of ttbr with 52-bit PA */
> +	ttbr1 = phys_to_ttbr(ttbr1);
> +
> +	if (system_supports_cnp()) {
> +		/*
> +		 * cpu_replace_ttbr1() is used when there's a boot CPU
> +		 * up (i.e. cpufeature framework is not up yet) and
> +		 * latter only when we enable CNP via cpufeature's
> +		 * enable() callback.
> +		 * Also we rely on the cpu_hwcap bit being set before
> +		 * calling the enable() function.
> +		 */
> +		ttbr1 |= TTBR_CNP_BIT;
> +	}
> +
> +	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1_with_flush_tlb));
> +
> +	cpu_install_idmap();
> +	replace_phys(ttbr1);
> +	cpu_uninstall_idmap();
cpu_install_idmap will Swtich to use idmap_pg_dir with use [[[ttbr0_el1]]].
swapper_gp_dir use the [[[ttbr1_el0]]], so there is no tlb conflit to 
idmap_pg_dir(the different address space range).

When switching to idmap_pg_dir, there also will be a tlb flush all.

Afterward, the idmap_cpu_replace_ttbr1_with_flush_tlb will run in 
idmap_pg_dir pgd and change the pgd to another pgd complying with the 
parameter ttbr1.

So, there is no tlb conflict when switching pgd.

Namely, I can change ttbr1 pgd safely without any tlb conflict.

> +}
> +
>   /*
>    * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
>    * avoiding the possibility of conflicting TLB entries being allocated.
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84..241d27e 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -190,6 +190,7 @@ static void __init reserve_crashkernel(void)
>   	crashk_res.start = crash_base;
>   	crashk_res.end = crash_base + crash_size - 1;
>   	insert_resource(&iomem_resource, &crashk_res);
> +	map_crashkernel();
>   }
>   
>   /*
> @@ -388,10 +389,6 @@ void __init arm64_memblock_init(void)
>   	}
>   
>   	early_init_fdt_scan_reserved_mem();
> -
> -	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
> -		reserve_crashkernel();
> -
>   	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>   }
>   
> @@ -438,8 +435,7 @@ void __init bootmem_init(void)
>   	 * request_standard_resources() depends on crashkernel's memory being
>   	 * reserved, so do it here.
>   	 */
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
> -		reserve_crashkernel();
> +	reserve_crashkernel();
>   
>   	memblock_dump_all();
>   }
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32..3e30c82 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -42,6 +42,7 @@
>   #define NO_BLOCK_MAPPINGS	BIT(0)
>   #define NO_CONT_MAPPINGS	BIT(1)
>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define NO_SEC_REMAPPINGS	BIT(3)	/* rebuild with non block/sec mapping*/
>   
>   u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
>   u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
> @@ -155,8 +156,22 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>   	return ((old ^ new) & ~mask) == 0;
>   }
>   
> +static void pte_clear_cont(pte_t *ptep)
> +{
> +	int i = 0;
> +	pte_t pte = READ_ONCE(*ptep);
> +	if (pte_none(pte) || !pte_cont(pte))
> +		return;
> +	ptep -= ((u64)ptep / sizeof(pte_t)) &
> +		((1 << CONFIG_ARM64_CONT_PTE_SHIFT) - 1);
> +	do {
> +		pte = pte_mknoncont(READ_ONCE(*ptep));
> +		set_pte(ptep, pte);
> +	} while (++ptep, ++i < CONT_PTES);
> +}
> +
>   static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot)
> +		     phys_addr_t phys, pgprot_t prot, int flags)
>   {
>   	pte_t *ptep;
>   
> @@ -164,6 +179,9 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   	do {
>   		pte_t old_pte = READ_ONCE(*ptep);
>   
> +		if (flags & NO_SEC_REMAPPINGS)
> +			pte_clear_cont(ptep);
> +
>   		set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>   
>   		/*
> @@ -179,6 +197,22 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   	pte_clear_fixmap();
>   }
>   
> +static inline void allock_pte_page(pmd_t *pmdp,
> +				   phys_addr_t (*pgtable_alloc)(int),
> +				   int flags)
> +{
> +	pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +	phys_addr_t pte_phys;
> +	if (!pmd_none(READ_ONCE(*pmdp)))
> +		return;
> +
> +	if (flags & NO_EXEC_MAPPINGS)
> +		pmdval |= PMD_TABLE_PXN;
> +	BUG_ON(!pgtable_alloc);
> +	pte_phys = pgtable_alloc(PAGE_SHIFT);
> +	__pmd_populate(pmdp, pte_phys, pmdval);
> +}
> +
>   static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   				unsigned long end, phys_addr_t phys,
>   				pgprot_t prot,
> @@ -189,17 +223,8 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   	pmd_t pmd = READ_ONCE(*pmdp);
>   
>   	BUG_ON(pmd_sect(pmd));
> -	if (pmd_none(pmd)) {
> -		pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> -		phys_addr_t pte_phys;
> -
> -		if (flags & NO_EXEC_MAPPINGS)
> -			pmdval |= PMD_TABLE_PXN;
> -		BUG_ON(!pgtable_alloc);
> -		pte_phys = pgtable_alloc(PAGE_SHIFT);
> -		__pmd_populate(pmdp, pte_phys, pmdval);
> -		pmd = READ_ONCE(*pmdp);
> -	}
> +	allock_pte_page(pmdp, pgtable_alloc, flags);
> +	pmd = READ_ONCE(*pmdp);
>   	BUG_ON(pmd_bad(pmd));
>   
>   	do {
> @@ -208,16 +233,71 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   		next = pte_cont_addr_end(addr, end);
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
> -		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> -		    (flags & NO_CONT_MAPPINGS) == 0)
> +		if (!(flags & NO_SEC_REMAPPINGS) &&
> +		   (((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> +		   (flags & NO_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> -		init_pte(pmdp, addr, next, phys, __prot);
> +		init_pte(pmdp, addr, next, phys, __prot, flags);
>   
>   		phys += next - addr;
>   	} while (addr = next, addr != end);
>   }
>   
> +static void pmd_clear_cont(pmd_t *pmdp)
> +{
> +	int i = 0;
> +	pmd_t pmd = READ_ONCE(*pmdp);
> +	if (pmd_none(pmd) || !pmd_sect(pmd) || !pmd_cont(pmd))
> +		return;
> +	pmdp -= ((u64)pmdp / sizeof(pmd_t)) &
> +		((1 << CONFIG_ARM64_CONT_PMD_SHIFT) - 1);
> +	do {
> +		pmd = READ_ONCE(*pmdp);
> +		pmd = pte_pmd(pte_mknoncont(pmd_pte(pmd)));
> +		set_pmd(pmdp, pmd);
> +	} while (++pmdp, ++i < CONT_PMDS);
> +}
> +
> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
> +			   phys_addr_t phys, pgprot_t prot,
> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +	unsigned long next;
> +	pmd_t *pmdp;
> +	phys_addr_t map_offset;
> +
> +	pmdp = pmd_set_fixmap_offset(pudp, addr);
> +	do {
> +		next = pmd_addr_end(addr, end);
> +
> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +			pmd_clear_cont(pmdp);
> +			pmd_clear(pmdp);
> +			allock_pte_page(pmdp, pgtable_alloc, flags);
> +
> +			map_offset = addr - (addr & PMD_MASK);
> +			if (map_offset)
> +			    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
> +						phys - map_offset, prot,
> +						pgtable_alloc,
> +						flags & (~NO_SEC_REMAPPINGS));
> +
> +			if (next < (addr & PMD_MASK) + PMD_SIZE)
> +			    alloc_init_cont_pte(pmdp, next,
> +					       (addr & PUD_MASK) + PUD_SIZE,
> +					        next - addr + phys,
> +						prot, pgtable_alloc,
> +						flags & (~NO_SEC_REMAPPINGS));
> +		}
> +		alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +				    pgtable_alloc, flags);
> +		phys += next - addr;
> +	} while (pmdp++, addr = next, addr != end);
> +
> +	pmd_clear_fixmap();
> +}
> +
>   static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>   		     phys_addr_t phys, pgprot_t prot,
>   		     phys_addr_t (*pgtable_alloc)(int), int flags)
> @@ -255,6 +335,22 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>   	pmd_clear_fixmap();
>   }
>   
> +static inline void alloc_pmd_page(pud_t *pudp, phys_addr_t (*pgtable_alloc)(int), int flags)
> +{
> +
> +	pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
> +	phys_addr_t pmd_phys;
> +
> +	if (!pud_none(READ_ONCE(*pudp)))
> +		return;
> +
> +	if (flags & NO_EXEC_MAPPINGS)
> +		pudval |= PUD_TABLE_PXN;
> +	BUG_ON(!pgtable_alloc);
> +	pmd_phys = pgtable_alloc(PMD_SHIFT);
> +	__pud_populate(pudp, pmd_phys, pudval);
> +}
> +
>   static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>   				unsigned long end, phys_addr_t phys,
>   				pgprot_t prot,
> @@ -267,17 +363,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>   	 * Check for initial section mappings in the pgd/pud.
>   	 */
>   	BUG_ON(pud_sect(pud));
> -	if (pud_none(pud)) {
> -		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
> -		phys_addr_t pmd_phys;
> -
> -		if (flags & NO_EXEC_MAPPINGS)
> -			pudval |= PUD_TABLE_PXN;
> -		BUG_ON(!pgtable_alloc);
> -		pmd_phys = pgtable_alloc(PMD_SHIFT);
> -		__pud_populate(pudp, pmd_phys, pudval);
> -		pud = READ_ONCE(*pudp);
> -	}
> +	alloc_pmd_page(pudp, pgtable_alloc, flags);
> +	pud = READ_ONCE(*pudp);
>   	BUG_ON(pud_bad(pud));
>   
>   	do {
> @@ -286,16 +373,80 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>   		next = pmd_cont_addr_end(addr, end);
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
> -		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
> +		if (!(flags & NO_SEC_REMAPPINGS) &&
> +		   (((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
>   		    (flags & NO_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> -		init_pmd(pudp, addr, next, phys, __prot, pgtable_alloc, flags);
> +		if (flags & NO_SEC_REMAPPINGS)
> +			init_pmd_remap(pudp, addr, next, phys, __prot,
> +				       pgtable_alloc, flags);
> +		else
> +			init_pmd(pudp, addr, next, phys, __prot,
> +				 pgtable_alloc, flags);
>   
>   		phys += next - addr;
>   	} while (addr = next, addr != end);
>   }
>   
> +static void init_pud_remap(pud_t *pudp, unsigned long addr, unsigned long next,
> +			   phys_addr_t phys, pgprot_t prot,
> +			   phys_addr_t (*pgtable_alloc)(int),
> +			   int flags)
> +{
> +	phys_addr_t map_offset;
> +
> +	if (!pud_none(*pudp) && pud_sect(*pudp)) {
> +		pud_clear(pudp);
> +		alloc_pmd_page(pudp, pgtable_alloc, flags);
> +
> +		map_offset = addr - (addr & PUD_MASK);
> +		if (map_offset)
> +		    alloc_init_cont_pmd(pudp, addr & PUD_MASK,
> +					addr, phys - map_offset,
> +					prot, pgtable_alloc,
> +					flags &	(~NO_SEC_REMAPPINGS));
> +
> +		if (next < (addr & PUD_MASK) + PUD_SIZE)
> +		    alloc_init_cont_pmd(pudp, next,
> +				       (addr & PUD_MASK) + PUD_SIZE,
> +					next - addr + phys,
> +					prot, pgtable_alloc,
> +					flags & (~NO_SEC_REMAPPINGS));
> +	}
> +	alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> +			    pgtable_alloc, flags);
> +}
> +
> +static void init_pud(pud_t *pudp, unsigned long addr, unsigned long next,
> +		     phys_addr_t phys, pgprot_t prot,
> +		     phys_addr_t (*pgtable_alloc)(int),
> +		     int flags)
> +{
> +	pud_t old_pud = READ_ONCE(*pudp);
> +	/*
> +	 * For 4K granule only, attempt to put down a 1GB block
> +	 */
> +	if (pud_sect_supported() &&
> +	   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> +	   (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		pud_set_huge(pudp, phys, prot);
> +
> +		/*
> +		 * After the PUD entry has been populated once, we
> +		 * only allow updates to the permission attributes.
> +		 */
> +		BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
> +					      READ_ONCE(pud_val(*pudp))));
> +	} else {
> +		alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> +				    pgtable_alloc, flags);
> +
> +		BUG_ON(pud_val(old_pud) != 0 &&
> +		       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
> +	}
> +}
> +
>   static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>   			   phys_addr_t phys, pgprot_t prot,
>   			   phys_addr_t (*pgtable_alloc)(int),
> @@ -325,37 +476,22 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>   	 */
>   	if (system_state != SYSTEM_BOOTING)
>   		mutex_lock(&fixmap_lock);
> +
>   	pudp = pud_set_fixmap_offset(p4dp, addr);
>   	do {
> -		pud_t old_pud = READ_ONCE(*pudp);
> -
>   		next = pud_addr_end(addr, end);
>   
> -		/*
> -		 * For 4K granule only, attempt to put down a 1GB block
> -		 */
> -		if (pud_sect_supported() &&
> -		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> -			pud_set_huge(pudp, phys, prot);
> -
> -			/*
> -			 * After the PUD entry has been populated once, we
> -			 * only allow updates to the permission attributes.
> -			 */
> -			BUG_ON(!pgattr_change_is_safe(pud_val(old_pud),
> -						      READ_ONCE(pud_val(*pudp))));
> -		} else {
> -			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> -					    pgtable_alloc, flags);
> -
> -			BUG_ON(pud_val(old_pud) != 0 &&
> -			       pud_val(old_pud) != READ_ONCE(pud_val(*pudp)));
> -		}
> +		if (flags & NO_SEC_REMAPPINGS)
> +			init_pud_remap(pudp, addr, next, phys, prot,
> +				       pgtable_alloc, flags);
> +		else
> +			init_pud(pudp, addr, next, phys, prot, pgtable_alloc,
> +				 flags);
>   		phys += next - addr;
>   	} while (pudp++, addr = next, addr != end);
>   
>   	pud_clear_fixmap();
> +
>   	if (system_state != SYSTEM_BOOTING)
>   		mutex_unlock(&fixmap_lock);
>   }
> @@ -483,20 +619,37 @@ void __init mark_linear_text_alias_ro(void)
>   			    PAGE_KERNEL_RO);
>   }
>   
> -static bool crash_mem_map __initdata;
> -
> -static int __init enable_crash_mem_map(char *arg)
> +#ifdef CONFIG_KEXEC_CORE
> +void __init map_crashkernel(void)
>   {
> -	/*
> -	 * Proper parameter parsing is done by reserve_crashkernel(). We only
> -	 * need to know if the linear map has to avoid block mappings so that
> -	 * the crashkernel reservations can be unmapped later.
> -	 */
> -	crash_mem_map = true;
> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> +	    return;
>   
> -	return 0;
> +	if (!crashk_res.end)
> +	    return;
> +
> +	cpu_replace_ttbr1_with_phys(__pa_symbol(init_pg_dir));
> +	init_mm.pgd = init_pg_dir;
> +
> +	__create_pgd_mapping(swapper_pg_dir, crashk_res.start,
> +			     __phys_to_virt(crashk_res.start),
> +			     crashk_res.end + 1 - crashk_res.start, PAGE_KERNEL,
> +			     early_pgtable_alloc,
> +			     NO_EXEC_MAPPINGS | NO_SEC_REMAPPINGS);
> +
> +	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> +	init_mm.pgd = swapper_pg_dir;
> +
> +	memblock_phys_free(__pa_symbol(init_pg_dir),
> +			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
>   }

Because unmap_hotplug_range work with swapper_gp_dir pgd. There are many 
changes needed for working with init_pg_dir pgd.
So that I use the init_pg_dir and __create_pgd_mapping to direct 
walk/modify swapper_gp_dir pagetable.

When finishing it, free the init_pg_dir memblock.

> -early_param("crashkernel", enable_crash_mem_map);
> +#else
> +void __init map_crashkernel(void)
> +{
> +	memblock_phys_free(__pa_symbol(init_pg_dir),
> +			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
> +}
> +#endif
>   
>   static void __init map_mem(pgd_t *pgdp)
>   {
> @@ -527,17 +680,6 @@ static void __init map_mem(pgd_t *pgdp)
>   	 */
>   	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>   
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map) {
> -		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
> -		    IS_ENABLED(CONFIG_ZONE_DMA32))
> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> -		else if (crashk_res.end)
> -			memblock_mark_nomap(crashk_res.start,
> -			    resource_size(&crashk_res));
> -	}
> -#endif
> -
>   	/* map all the memory banks */
>   	for_each_mem_range(i, &start, &end) {
>   		if (start >= end)
> @@ -570,19 +712,6 @@ static void __init map_mem(pgd_t *pgdp)
>   	 * in page granularity and put back unused memory to buddy system
>   	 * through /sys/kernel/kexec_crash_size interface.
>   	 */
> -#ifdef CONFIG_KEXEC_CORE
> -	if (crash_mem_map &&
> -	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		if (crashk_res.end) {
> -			__map_memblock(pgdp, crashk_res.start,
> -				       crashk_res.end + 1,
> -				       PAGE_KERNEL,
> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> -			memblock_clear_nomap(crashk_res.start,
> -					     resource_size(&crashk_res));
> -		}
> -	}
> -#endif
>   }
>   
>   void mark_rodata_ro(void)
> @@ -774,8 +903,8 @@ void __init paging_init(void)
>   	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>   	init_mm.pgd = swapper_pg_dir;
>   
> -	memblock_phys_free(__pa_symbol(init_pg_dir),
> -			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
> +	//memblock_phys_free(__pa_symbol(init_pg_dir),
> +	//		   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
>   
>   	memblock_allow_resize();
>   }
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 50bbed9..161bae6 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -178,6 +178,25 @@ SYM_FUNC_END(cpu_do_resume)
>   	isb
>   .endm
>   
> +SYM_FUNC_START(idmap_cpu_replace_ttbr1_with_flush_tlb)
> +	save_and_disable_daif flags=x2
> +
> +	__idmap_cpu_set_reserved_ttbr1 x1, x3
> +
> +	offset_ttbr1 x0, x3
> +	msr	ttbr1_el1, x0
> +	isb
> +
> +	restore_daif x2
> +
> +	dsb nshst
> +	tlbi	vmalle1
> +	dsb	nsh
> +	isb
> +
> +	ret
> +SYM_FUNC_END(idmap_cpu_replace_ttbr1_with_flush_tlb)
> +
Switch ttbr1 to pgd(refer to x0), and flush tlb all.

>   /*
>    * void idmap_cpu_replace_ttbr1(phys_addr_t ttbr1)
>    *
