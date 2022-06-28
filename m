Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02A55DB70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiF1Czh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiF1Cze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:55:34 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B1BCB0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:55:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VHegwHK_1656384926;
Received: from 30.225.28.186(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VHegwHK_1656384926)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 10:55:27 +0800
Message-ID: <f70675c5-4cf7-45f3-0439-a11d539b6b88@linux.alibaba.com>
Date:   Tue, 28 Jun 2022 10:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: mm: fix linear mapping mem access performace
 degradation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org,
        Yao Hongbo <yaohongbo@linux.alibaba.com>
References: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YrlPfjv2Wf/C77DI@kernel.org>
 <4d18d303-aeed-0beb-a8a4-32893f2d438d@linux.alibaba.com>
 <Yrl9FcVv1wZ5MnRp@kernel.org>
 <ae5c6c07-1d49-ffd2-6f62-69df4308d0bb@linux.alibaba.com>
 <YrnfmpcSzb3rztnK@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YrnfmpcSzb3rztnK@kernel.org>
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

Thanks.

在 2022/6/28 0:49, Mike Rapoport 写道:
> On Mon, Jun 27, 2022 at 06:46:50PM +0800, guanghui.fgh wrote:
>> 在 2022/6/27 17:49, Mike Rapoport 写道:
>>> On Mon, Jun 27, 2022 at 05:24:10PM +0800, guanghui.fgh wrote:
>>>> 在 2022/6/27 14:34, Mike Rapoport 写道:
>>>>
>>>>       On Sun, Jun 26, 2022 at 07:10:15PM +0800, Guanghui Feng wrote:
>>>>
>>>>           The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>>>>           (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>>>>           use non block/section mapping(for crashkernel requires to shrink the region
>>>>           in page granularity). But it will degrade performance when doing larging
>>>>           continuous mem access in kernel(memcpy/memmove, etc).
>>>>
>>>>           There are many changes and discussions:
>>>>           commit 031495635b46
>>>>           commit 1a8e1cef7603
>>>>           commit 8424ecdde7df
>>>>           commit 0a30c53573b0
>>>>           commit 2687275a5843
>>>>
>>>>       Please include oneline summary of the commit. (See section "Describe your
>>>>       changes" in Documentation/process/submitting-patches.rst)
>>>>
>>>> OK, I will add oneline summary in the git commit messages.
>>>>
>>>>           This patch changes mem_map to use block/section mapping with crashkernel.
>>>>           Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
>>>>           mem_map, reserve crashkernel memory. And then walking pagetable to split
>>>>           block/section mapping to non block/section mapping(normally 4K) [[[only]]]
>>>>           for crashkernel mem.
>>>>
>>>>       This already happens when ZONE_DMA/ZONE_DMA32 are disabled. Please explain
>>>>       why is it Ok to change the way the memory is mapped with
>>>>       ZONE_DMA/ZONE_DMA32 enabled.
>>>>
>>>> In short:
>>>>
>>>> 1.building all avail mem with block/section mapping（normally 1G/2M） without
>>>> inspecting crashkernel
>>>> 2. Reserve crashkernel mem as same as previous doing
>>>> 3. only change the crashkernle mem mapping to normal mapping(normally 4k).
>>>> With this method, there are block/section mapping as more as possible.
>>>
>>> This does not answer the question why changing the way the memory is mapped
>>> when there is ZONE_DMA/DMA32 and crashkernel won't cause a regression.
>>>
>> 1.Quoted messages from arch/arm64/mm/init.c
>>
>> "Memory reservation for crash kernel either done early or deferred
>> depending on DMA memory zones configs (ZONE_DMA) --
>>
>> In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
>> here instead of max_zone_phys().  This lets early reservation of
>> crash kernel memory which has a dependency on arm64_dma_phys_limit.
>> Reserving memory early for crash kernel allows linear creation of block
>> mappings (greater than page-granularity) for all the memory bank rangs.
>> In this scheme a comparatively quicker boot is observed.
>>
>> If ZONE_DMA configs are defined, crash kernel memory reservation
>> is delayed until DMA zone memory range size initialization performed in
>> zone_sizes_init().  The defer is necessary to steer clear of DMA zone
>> memory range to avoid overlap allocation.  So crash kernel memory boundaries
>> are not known when mapping all bank memory ranges, which otherwise means not
>> possible to exclude crash kernel range from creating block mappings so
>> page-granularity mappings are created for the entire memory range."
>>
>> Namely, the init order: memblock init--->linear mem mapping(4k mapping for
>> crashkernel, requirinig page-granularity changing))--->zone dma
>> limit--->reserve crashkernel.
>> So when enable ZONE DMA and using crashkernel, the mem mapping using 4k
>> mapping.
>>
>> 2.As mentioned above, when linear mem use 4k mapping simply, there is high
>> dtlb miss(degrade performance).
>> This patch use block/section mapping as far as possible with performance
>> improvement.
>>
>> 3.This patch reserve crashkernel as same as the history(ZONE DMA &
>> crashkernel reserving order), and only change the linear mem mapping to
>> block/section mapping.
> 
> Thank you for the explanation.
> 
> So if I understand correctly, you suggest to reserve the crash kernel
> memory late regardless of ZONE_DMA/32 configuration and then map that memory
> using page level mappings after the memory is reserved.
> 
> This makes sense, but I think the patch has a few shortcomings than need to
> be addressed.
>Yes, It's that.
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/mmu.h |   1 +
>>   arch/arm64/mm/init.c         |   8 +-
>>   arch/arm64/mm/mmu.c          | 274 +++++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 253 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 48f8466..df113cc 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -63,6 +63,7 @@ static inline bool arm64_kernel_unmapped_at_el0(void)
>>   extern void arm64_memblock_init(void);
>>   extern void paging_init(void);
>>   extern void bootmem_init(void);
>> +extern void mapping_crashkernel(void);
> 
> I think map_crashkernel() would be a better name.
OK.
> 
>>   extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
>>   extern void init_mem_pgprot(void);
>>   extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 339ee84..0e7540b 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -388,10 +388,6 @@ void __init arm64_memblock_init(void)
>>   	}
>>   
>>   	early_init_fdt_scan_reserved_mem();
>> -
>> -	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
>> -		reserve_crashkernel();
>> -
>>   	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>>   }
>>   
>> @@ -438,8 +434,8 @@ void __init bootmem_init(void)
>>   	 * request_standard_resources() depends on crashkernel's memory being
>>   	 * reserved, so do it here.
>>   	 */
>> -	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
>> -		reserve_crashkernel();
>> +	reserve_crashkernel();
>> +	mapping_crashkernel();
> 
> This can be called from reserve_crashkernel() directly.
OK
>   
>>   	memblock_dump_all();
>>   }
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 626ec32..0672afd 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -498,6 +498,256 @@ static int __init enable_crash_mem_map(char *arg)
>>   }
>>   early_param("crashkernel", enable_crash_mem_map);
>>   
>> +#ifdef CONFIG_KEXEC_CORE
>> +static phys_addr_t __init early_crashkernel_pgtable_alloc(int shift)
>> +{
>> +	phys_addr_t phys;
>> +	void *ptr;
>> +
>> +	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
>> +					 MEMBLOCK_ALLOC_NOLEAKTRACE);
>> +	if (!phys)
>> +		panic("Failed to allocate page table page\n");
>> +
>> +	ptr = (void *)__phys_to_virt(phys);
>> +	memset(ptr, 0, PAGE_SIZE);
>> +	return phys;
>> +}
>> +
>> +static void init_crashkernel_pte(pmd_t *pmdp, unsigned long addr,
>> +				 unsigned long end,
>> +				 phys_addr_t phys, pgprot_t prot)
>> +{
>> +	pte_t *ptep;
>> +	ptep = pte_offset_kernel(pmdp, addr);
>> +	do {
>> +		set_pte(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>> +		phys += PAGE_SIZE;
>> +	} while (ptep++, addr += PAGE_SIZE, addr != end);
>> +}
>> +
>> +static void alloc_crashkernel_cont_pte(pmd_t *pmdp, unsigned long addr,
>> +				       unsigned long end, phys_addr_t phys,
>> +				       pgprot_t prot,
>> +				       phys_addr_t (*pgtable_alloc)(int),
>> +				       int flags)
>> +{
>> +	unsigned long next;
>> +	pmd_t pmd = READ_ONCE(*pmdp);
>> +
>> +	BUG_ON(pmd_sect(pmd));
>> +	if (pmd_none(pmd)) {
>> +		pmdval_t pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>> +		phys_addr_t pte_phys;
>> +
>> +		if (flags & NO_EXEC_MAPPINGS)
>> +			pmdval |= PMD_TABLE_PXN;
>> +		BUG_ON(!pgtable_alloc);
>> +		pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +		__pmd_populate(pmdp, pte_phys, pmdval);
>> +		pmd = READ_ONCE(*pmdp);
>> +	}
>> +	BUG_ON(pmd_bad(pmd));
>> +
>> +	do {
>> +		pgprot_t __prot = prot;
>> +		next = pte_cont_addr_end(addr, end);
>> +		init_crashkernel_pte(pmdp, addr, next, phys, __prot);
>> +		phys += next - addr;
>> +	} while (addr = next, addr != end);
>> +}
>> +
>> +static void init_crashkernel_pmd(pud_t *pudp, unsigned long addr,
>> +				 unsigned long end, phys_addr_t phys,
>> +				 pgprot_t prot,
>> +				 phys_addr_t (*pgtable_alloc)(int), int flags)
>> +{
>> +	phys_addr_t map_offset;
>> +	unsigned long next;
>> +	pmd_t *pmdp;
>> +	pmdval_t pmdval;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +		if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>> +			phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>> +			pmd_clear(pmdp);
>> +			pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>> +			if (flags & NO_EXEC_MAPPINGS)
>> +				pmdval |= PMD_TABLE_PXN;
>> +			__pmd_populate(pmdp, pte_phys, pmdval);
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +
>> +			map_offset = addr - (addr & PMD_MASK);
>> +			if (map_offset)
>> +			    alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
>> +						phys - map_offset, prot,
>> +						pgtable_alloc, flags);
>> +
>> +			if (next < (addr & PMD_MASK) + PMD_SIZE)
>> +			    alloc_init_cont_pte(pmdp, next, (addr & PUD_MASK) +
>> +						PUD_SIZE, next - addr + phys,
>> +						prot, pgtable_alloc, flags);
>> +		}
>> +		alloc_crashkernel_cont_pte(pmdp, addr, next, phys, prot,
>> +					   pgtable_alloc, flags);
>> +		phys += next - addr;
>> +	} while (pmdp++, addr = next, addr != end);
>> +}
>> +
>> +static void alloc_crashkernel_cont_pmd(pud_t *pudp, unsigned long addr,
>> +				       unsigned long end, phys_addr_t phys,
>> +				       pgprot_t prot,
>> +				       phys_addr_t (*pgtable_alloc)(int),
>> +				       int flags)
>> +{
>> +	unsigned long next;
>> +	pud_t pud = READ_ONCE(*pudp);
>> +
>> +	/*
>> +	 * Check for initial section mappings in the pgd/pud.
>> +	 */
>> +	BUG_ON(pud_sect(pud));
>> +	if (pud_none(pud)) {
>> +		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
>> +		phys_addr_t pmd_phys;
>> +
>> +		if (flags & NO_EXEC_MAPPINGS)
>> +			pudval |= PUD_TABLE_PXN;
>> +		BUG_ON(!pgtable_alloc);
>> +		pmd_phys = pgtable_alloc(PMD_SHIFT);
>> +		__pud_populate(pudp, pmd_phys, pudval);
>> +		pud = READ_ONCE(*pudp);
>> +	}
>> +	BUG_ON(pud_bad(pud));
>> +
>> +	do {
>> +		pgprot_t __prot = prot;
>> +		next = pmd_cont_addr_end(addr, end);
>> +		init_crashkernel_pmd(pudp, addr, next, phys, __prot,
>> +				     pgtable_alloc, flags);
>> +		phys += next - addr;
>> +	} while (addr = next, addr != end);
>> +}
>> +
>> +static void alloc_crashkernel_pud(pgd_t *pgdp, unsigned long addr,
>> +				  unsigned long end, phys_addr_t phys,
>> +				  pgprot_t prot,
>> +				  phys_addr_t (*pgtable_alloc)(int),
>> +				  int flags)
>> +{
>> +	phys_addr_t map_offset;
>> +	unsigned long next;
>> +	pud_t *pudp;
>> +	p4d_t *p4dp = p4d_offset(pgdp, addr);
>> +	p4d_t p4d = READ_ONCE(*p4dp);
>> +	pudval_t pudval;
>> +
>> +	if (p4d_none(p4d)) {
>> +		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN;
>> +		phys_addr_t pud_phys;
>> +
>> +		if (flags & NO_EXEC_MAPPINGS)
>> +			p4dval |= P4D_TABLE_PXN;
>> +		BUG_ON(!pgtable_alloc);
>> +		pud_phys = pgtable_alloc(PUD_SHIFT);
>> +		__p4d_populate(p4dp, pud_phys, p4dval);
>> +		p4d = READ_ONCE(*p4dp);
>> +	}
>> +	BUG_ON(p4d_bad(p4d));
>> +
>> +	/*
>> +	 * No need for locking during early boot. And it doesn't work as
>> +	 * expected with KASLR enabled.
>> +	 */
>> +	if (system_state != SYSTEM_BOOTING)
>> +		mutex_lock(&fixmap_lock);
>> +	pudp = pud_offset(p4dp, addr);
>> +	do {
>> +		next = pud_addr_end(addr, end);
>> +		if (!pud_none(*pudp) && pud_sect(*pudp)) {
>> +			phys_addr_t pmd_phys = pgtable_alloc(PMD_SHIFT);
>> +			pud_clear(pudp);
>> +
>> +			pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN;
>> +			if (flags & NO_EXEC_MAPPINGS)
>> +				pudval |= PUD_TABLE_PXN;
>> +			__pud_populate(pudp, pmd_phys, pudval);
>> +			flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +
>> +			map_offset = addr - (addr & PUD_MASK);
>> +			if (map_offset)
>> +			    alloc_init_cont_pmd(pudp, addr & PUD_MASK, addr,
>> +						phys - map_offset, prot,
>> +						pgtable_alloc, flags);
>> +
>> +			if (next < (addr & PUD_MASK) + PUD_SIZE)
>> +			    alloc_init_cont_pmd(pudp, next, (addr & PUD_MASK) +
>> +						PUD_SIZE, next - addr + phys,
>> +						prot, pgtable_alloc, flags);
>> +		}
>> +		alloc_crashkernel_cont_pmd(pudp, addr, next, phys, prot,
>> +					   pgtable_alloc, flags);
>> +		phys += next - addr;
>> +	} while (pudp++, addr = next, addr != end);
>> +
>> +	if (system_state != SYSTEM_BOOTING)
>> +		mutex_unlock(&fixmap_lock);
>> +}
>> +
>> +static void __create_crashkernel_mapping(pgd_t *pgdir, phys_addr_t phys,
>> +					 unsigned long virt, phys_addr_t size,
>> +					 pgprot_t prot,
>> +					 phys_addr_t (*pgtable_alloc)(int),
>> +					 int flags)
>> +{
>> +	unsigned long addr, end, next;
>> +	pgd_t *pgdp = pgd_offset_pgd(pgdir, virt);
>> +
>> +	/*
>> +	 * If the virtual and physical address don't have the same offset
>> +	 * within a page, we cannot map the region as the caller expects.
>> +	 */
>> +	if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
>> +		return;
>> +
>> +	phys &= PAGE_MASK;
>> +	addr = virt & PAGE_MASK;
>> +	end = PAGE_ALIGN(virt + size);
>> +
>> +	do {
>> +		next = pgd_addr_end(addr, end);
>> +		alloc_crashkernel_pud(pgdp, addr, next, phys, prot,
>> +				      pgtable_alloc, flags);
>> +		phys += next - addr;
>> +	} while (pgdp++, addr = next, addr != end);
>> +}
> 
> __create_crashkernel_mapping() and the helpers it uses resemble very much
> __create_pgd_mapping() and it's helpers. I think a cleaner way would be to
> clear section mappings and than call __create_pgd_mapping() for crash
> kernel memory with block/section mappings disabled.
> 
>> +static void __init map_crashkernel(pgd_t *pgdp, phys_addr_t start,
>> +				   phys_addr_t end, pgprot_t prot, int flags)
>> +{
>> +	__create_crashkernel_mapping(pgdp, start, __phys_to_virt(start),
>> +				     end - start, prot,
>> +				     early_crashkernel_pgtable_alloc, flags);
>> +}
> 
> No need for this, you can call __create_crashkernel_mapping() directly from
> mapping_crashkernel().
> 
>> +
>> +void __init mapping_crashkernel(void)
>> +{
>> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>> +	    return;
>> +
>> +	if (!crash_mem_map || !crashk_res.end)
>> +	    return;
>> +
>> +	map_crashkernel(swapper_pg_dir, crashk_res.start,
>> +			crashk_res.end + 1, PAGE_KERNEL,
>> +			NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>> +}
>> +#else
>> +void __init mapping_crashkernel(void) {}
>> +#endif
>> +
>>   static void __init map_mem(pgd_t *pgdp)
>>   {
>>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>> @@ -527,17 +777,6 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 */
>>   	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>>   
>> -#ifdef CONFIG_KEXEC_CORE
>> -	if (crash_mem_map) {
>> -		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
>> -		    IS_ENABLED(CONFIG_ZONE_DMA32))
>> -			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>> -		else if (crashk_res.end)
>> -			memblock_mark_nomap(crashk_res.start,
>> -			    resource_size(&crashk_res));
>> -	}
>> -#endif
>> -
>>   	/* map all the memory banks */
>>   	for_each_mem_range(i, &start, &end) {
>>   		if (start >= end)
>> @@ -570,19 +809,6 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 * in page granularity and put back unused memory to buddy system
>>   	 * through /sys/kernel/kexec_crash_size interface.
>>   	 */
>> -#ifdef CONFIG_KEXEC_CORE
>> -	if (crash_mem_map &&
>> -	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
>> -		if (crashk_res.end) {
>> -			__map_memblock(pgdp, crashk_res.start,
>> -				       crashk_res.end + 1,
>> -				       PAGE_KERNEL,
>> -				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>> -			memblock_clear_nomap(crashk_res.start,
>> -					     resource_size(&crashk_res));
>> -		}
>> -	}
>> -#endif
>>   }
>>   
>>   void mark_rodata_ro(void)
>> -- 
>> 1.8.3.1
> 
> 
