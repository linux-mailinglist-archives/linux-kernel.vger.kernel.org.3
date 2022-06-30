Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736765619A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiF3Lyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiF3Lye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:54:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0753451B06
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:54:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VHsMWrI_1656590066;
Received: from 30.225.28.186(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VHsMWrI_1656590066)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 19:54:27 +0800
Message-ID: <4eb79882-162d-182b-6230-64898ae61582@linux.alibaba.com>
Date:   Thu, 30 Jun 2022 19:54:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] arm64: mm: fix linear mapping mem access performance
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
References: <1656578288-11259-1-git-send-email-guanghuifeng@linux.alibaba.com>
In-Reply-To: <1656578288-11259-1-git-send-email-guanghuifeng@linux.alibaba.com>
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

I'm very sorry!
Please DO'T review this patch, I have rewrited it.

在 2022/6/30 16:38, Guanghui Feng 写道:
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
>   arch/arm64/include/asm/mmu.h |   1 +
>   arch/arm64/mm/init.c         |   8 +--
>   arch/arm64/mm/mmu.c          | 163 ++++++++++++++++++++++++++++++-------------
>   3 files changed, 116 insertions(+), 56 deletions(-)
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
> index 626ec32..c832848 100644
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
> @@ -156,11 +157,12 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>   }
>   
>   static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot)
> +		     phys_addr_t phys, pgprot_t prot, int flags)
>   {
>   	pte_t *ptep;
>   
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
> +	ptep = (flags & NO_SEC_REMAPPINGS) ? pte_offset_kernel(pmdp, addr) :
> +		pte_set_fixmap_offset(pmdp, addr);
>   	do {
>   		pte_t old_pte = READ_ONCE(*ptep);
>   
> @@ -176,7 +178,8 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   		phys += PAGE_SIZE;
>   	} while (ptep++, addr += PAGE_SIZE, addr != end);
>   
> -	pte_clear_fixmap();
> +	if (!(flags & NO_SEC_REMAPPINGS))
> +		pte_clear_fixmap();
>   }
>   
>   static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> @@ -208,11 +211,12 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>   		next = pte_cont_addr_end(addr, end);
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
> -		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
> +		if (!(flags & NO_SEC_REMAPPINGS) &&
> +		   (((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>   		    (flags & NO_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> -		init_pte(pmdp, addr, next, phys, __prot);
> +		init_pte(pmdp, addr, next, phys, __prot, flags);
>   
>   		phys += next - addr;
>   	} while (addr = next, addr != end);
> @@ -224,15 +228,44 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>   {
>   	unsigned long next;
>   	pmd_t *pmdp;
> +	phys_addr_t map_offset;
> +	pmdval_t pmdval;
>   
> -	pmdp = pmd_set_fixmap_offset(pudp, addr);
> +	pmdp = (flags & NO_SEC_REMAPPINGS) ? pmd_offset(pudp, addr) :
> +		pmd_set_fixmap_offset(pudp, addr);
>   	do {
>   		pmd_t old_pmd = READ_ONCE(*pmdp);
>   
>   		next = pmd_addr_end(addr, end);
>   
> -		/* try section mapping first */
> -		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
> +		if (flags & NO_SEC_REMAPPINGS) {
> +			if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
> +				phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
> +				pmd_clear(pmdp);
> +				pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
> +				if (flags & NO_EXEC_MAPPINGS)
> +					pmdval |= PMD_TABLE_PXN;
> +				__pmd_populate(pmdp, pte_phys, pmdval);
> +				flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +				map_offset = addr - (addr & PMD_MASK);
> +				if (map_offset)
> +				    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
> +							phys - map_offset, prot,
> +							pgtable_alloc,
> +							flags & (~NO_SEC_REMAPPINGS));
> +
> +				if (next < (addr & PMD_MASK) + PMD_SIZE)
> +				    alloc_init_cont_pte(pmdp, next,
> +						       (addr & PUD_MASK) + PUD_SIZE,
> +						        next - addr + phys,
> +							prot, pgtable_alloc,
> +							flags & (~NO_SEC_REMAPPINGS));
> +			}
> +			alloc_init_cont_pte(pmdp, addr, next, phys, prot,
> +					    pgtable_alloc, flags);
> +		}/* try section mapping first */
> +		else if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>   			pmd_set_huge(pmdp, phys, prot);
>   
> @@ -252,7 +285,8 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>   		phys += next - addr;
>   	} while (pmdp++, addr = next, addr != end);
>   
> -	pmd_clear_fixmap();
> +	if (!(flags & NO_SEC_REMAPPINGS))
> +		pmd_clear_fixmap();
>   }
>   
>   static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> @@ -286,7 +320,8 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>   		next = pmd_cont_addr_end(addr, end);
>   
>   		/* use a contiguous mapping if the range is suitably aligned */
> -		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
> +		if (!(flags & NO_SEC_REMAPPINGS) &&
> +		   (((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
>   		    (flags & NO_CONT_MAPPINGS) == 0)
>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>   
> @@ -301,7 +336,9 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>   			   phys_addr_t (*pgtable_alloc)(int),
>   			   int flags)
>   {
> +	phys_addr_t map_offset;
>   	unsigned long next;
> +	pudval_t pudval;
>   	pud_t *pudp;
>   	p4d_t *p4dp = p4d_offset(pgdp, addr);
>   	p4d_t p4d = READ_ONCE(*p4dp);
> @@ -325,18 +362,48 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>   	 */
>   	if (system_state != SYSTEM_BOOTING)
>   		mutex_lock(&fixmap_lock);
> -	pudp = pud_set_fixmap_offset(p4dp, addr);
> +
> +	pudp = (flags & NO_SEC_REMAPPINGS) ? pud_offset(p4dp, addr) :
> +		pud_set_fixmap_offset(p4dp, addr);
>   	do {
>   		pud_t old_pud = READ_ONCE(*pudp);
> -
>   		next = pud_addr_end(addr, end);
>   
> +		if (flags & NO_SEC_REMAPPINGS) {
> +			if (!pud_none(*pudp) && pud_sect(*pudp)) {
> +				phys_addr_t pmd_phys = pgtable_alloc(PMD_SHIFT);
> +				pud_clear(pudp);
> +				pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
> +				if (flags & NO_EXEC_MAPPINGS)
> +					pudval |= PUD_TABLE_PXN;
> +
> +				__pud_populate(pudp, pmd_phys, pudval);
> +				flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +
> +				map_offset = addr - (addr & PUD_MASK);
> +				if (map_offset)
> +				    alloc_init_cont_pmd(pudp, addr & PUD_MASK,
> +							addr, phys - map_offset,
> +							prot, pgtable_alloc,
> +							flags &	(~NO_SEC_REMAPPINGS));
> +
> +				if (next < (addr & PUD_MASK) + PUD_SIZE)
> +				    alloc_init_cont_pmd(pudp, next,
> +						       (addr & PUD_MASK) +
> +							PUD_SIZE,
> +							next - addr + phys,
> +							prot, pgtable_alloc,
> +							flags & (~NO_SEC_REMAPPINGS));
> +			}
> +			alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> +					    pgtable_alloc, flags);
> +		}
>   		/*
>   		 * For 4K granule only, attempt to put down a 1GB block
>   		 */
> -		if (pud_sect_supported() &&
> -		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> +		else if (pud_sect_supported() &&
> +			((addr | next | phys) & ~PUD_MASK) == 0 &&
> +			(flags & NO_BLOCK_MAPPINGS) == 0) {
>   			pud_set_huge(pudp, phys, prot);
>   
>   			/*
> @@ -355,7 +422,8 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>   		phys += next - addr;
>   	} while (pudp++, addr = next, addr != end);
>   
> -	pud_clear_fixmap();
> +	if (!(flags & NO_SEC_REMAPPINGS))
> +		pud_clear_fixmap();
>   	if (system_state != SYSTEM_BOOTING)
>   		mutex_unlock(&fixmap_lock);
>   }
> @@ -483,20 +551,39 @@ void __init mark_linear_text_alias_ro(void)
>   			    PAGE_KERNEL_RO);
>   }
>   
> -static bool crash_mem_map __initdata;
> +#ifdef CONFIG_KEXEC_CORE
> +static phys_addr_t __init early_crashkernel_pgtable_alloc(int shift)
> +{
> +	phys_addr_t phys;
> +	void *ptr;
>   
> -static int __init enable_crash_mem_map(char *arg)
> +	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
> +					 MEMBLOCK_ALLOC_NOLEAKTRACE);
> +	if (!phys)
> +		panic("Failed to allocate page table page\n");
> +
> +	ptr = (void *)__phys_to_virt(phys);
> +	memset(ptr, 0, PAGE_SIZE);
> +	return phys;
> +}
> +
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
> +	__create_pgd_mapping(swapper_pg_dir, crashk_res.start,
> +			     __phys_to_virt(crashk_res.start),
> +			     crashk_res.end + 1 - crashk_res.start, PAGE_KERNEL,
> +			     early_crashkernel_pgtable_alloc,
> +			     NO_EXEC_MAPPINGS | NO_SEC_REMAPPINGS);
>   }
> -early_param("crashkernel", enable_crash_mem_map);
> +#else
> +void __init map_crashkernel(void) {}
> +#endif
>   
>   static void __init map_mem(pgd_t *pgdp)
>   {
> @@ -527,17 +614,6 @@ static void __init map_mem(pgd_t *pgdp)
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
> @@ -570,19 +646,6 @@ static void __init map_mem(pgd_t *pgdp)
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
