Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA229562A90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGAEgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGAEgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:36:09 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2396759A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:36:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VHxsaoR_1656650160;
Received: from 30.225.28.186(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VHxsaoR_1656650160)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 12:36:02 +0800
Message-ID: <f8ee2f3f-d0ed-3291-ec04-f7f754ab1931@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 12:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] arm64: mm: fix linear mapping mem access performance
 degradation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        ardb@kernel.org, linux-mm@kvack.org, yaohongbo@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
References: <1656586222-98555-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <Yr2pT8SLznI6beqS@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <Yr2pT8SLznI6beqS@kernel.org>
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

在 2022/6/30 21:46, Mike Rapoport 写道:
> Hi,
> 
> On Thu, Jun 30, 2022 at 06:50:22PM +0800, Guanghui Feng wrote:
>> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>> use non block/section mapping(for crashkernel requires to shrink the region
>> in page granularity). But it will degrade performance when doing larging
>> continuous mem access in kernel(memcpy/memmove, etc).
>>
>> There are many changes and discussions:
>> commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
>> platforms with no DMA memory zones")
>> commit 0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into
>> mem_init()")
>> commit 2687275a5843 ("arm64: Force NO_BLOCK_MAPPINGS if crashkernel
>> reservation is required")
>>
>> This patch changes mem_map to use block/section mapping with crashkernel.
>> Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
>> mem_map, reserve crashkernel memory. And then walking pagetable to split
>> block/section mapping to non block/section mapping(normally 4K) [[[only]]]
>> for crashkernel mem. So the linear mem mapping use block/section mapping
>> as more as possible. We will reduce the cpu dTLB miss conspicuously, and
>> accelerate mem access about 10-20% performance improvement.
> 
> ...
>   
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/mmu.h |   1 +
>>   arch/arm64/mm/init.c         |   8 +-
>>   arch/arm64/mm/mmu.c          | 231 ++++++++++++++++++++++++++++++-------------
>>   3 files changed, 168 insertions(+), 72 deletions(-)
> 
> ...
> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 626ec32..4b779cf 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -42,6 +42,7 @@
>>   #define NO_BLOCK_MAPPINGS	BIT(0)
>>   #define NO_CONT_MAPPINGS	BIT(1)
>>   #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>> +#define NO_SEC_REMAPPINGS	BIT(3)	/* rebuild with non block/sec mapping*/
>>   
>>   u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
>>   u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
>> @@ -156,11 +157,12 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>>   }
>>   
>>   static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> -		     phys_addr_t phys, pgprot_t prot)
>> +		     phys_addr_t phys, pgprot_t prot, int flags)
>>   {
>>   	pte_t *ptep;
>>   
>> -	ptep = pte_set_fixmap_offset(pmdp, addr);
>> +	ptep = (flags & NO_SEC_REMAPPINGS) ? pte_offset_kernel(pmdp, addr) :
>> +		pte_set_fixmap_offset(pmdp, addr);
>>   	do {
>>   		pte_t old_pte = READ_ONCE(*ptep);
>>   
>> @@ -176,7 +178,8 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   		phys += PAGE_SIZE;
>>   	} while (ptep++, addr += PAGE_SIZE, addr != end);
>>   
>> -	pte_clear_fixmap();
>> +	if (!(flags & NO_SEC_REMAPPINGS))
>> +		pte_clear_fixmap();
>>   }
>>   
>>   static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> @@ -208,16 +211,59 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   		next = pte_cont_addr_end(addr, end);
>>   
>>   		/* use a contiguous mapping if the range is suitably aligned */
>> -		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>> +		if (!(flags & NO_SEC_REMAPPINGS) &&
>> +		   (((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>>   		    (flags & NO_CONT_MAPPINGS) == 0)
>>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> -		init_pte(pmdp, addr, next, phys, __prot);
>> +		init_pte(pmdp, addr, next, phys, __prot, flags);
>>   
>>   		phys += next - addr;
>>   	} while (addr = next, addr != end);
>>   }
>>   
>> +static void init_pmd_remap(pud_t *pudp, unsigned long addr, unsigned long end,
>> +			   phys_addr_t phys, pgprot_t prot,
>> +			   phys_addr_t (*pgtable_alloc)(int), int flags)
>> +{
>> +	unsigned long next;
>> +	pmd_t *pmdp;
>> +	phys_addr_t map_offset;
>> +	pmdval_t pmdval;
>> +
>> +	pmdp = pmd_offset(pudp, addr);
>> +	do {
>> +		next = pmd_addr_end(addr, end);
>> +
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
>> +						pgtable_alloc,
>> +						flags & (~NO_SEC_REMAPPINGS));
>> +
>> +			if (next < (addr & PMD_MASK) + PMD_SIZE)
>> +			    alloc_init_cont_pte(pmdp, next,
>> +					       (addr & PUD_MASK) + PUD_SIZE,
>> +					        next - addr + phys,
>> +						prot, pgtable_alloc,
>> +						flags & (~NO_SEC_REMAPPINGS));
>> +		}
>> +		alloc_init_cont_pte(pmdp, addr, next, phys, prot,
>> +				    pgtable_alloc, flags);
>> +		phys += next - addr;
>> +	} while (pmdp++, addr = next, addr != end);
>> +}
> 
> There is still to much duplicated code here and in init_pud_remap().
> 
> Did you consider something like this:
> 
> void __init map_crashkernel(void)
> {
> 	int flags = NO_EXEC_MAPPINGS | NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 	u64 size;
> 
> 	/*
> 	 * check if crash kernel supported, reserved etc
> 	 */
> 
> 
> 	size = crashk_res.end + 1 - crashk_res.start;
> 
> 	__remove_pgd_mapping(swapper_pg_dir, __phys_to_virt(start), size);
> 	__create_pgd_mapping(swapper_pg_dir, crashk_res.start,
> 			     __phys_to_virt(crashk_res.start), size,
> 			     PAGE_KERNEL, early_pgtable_alloc, flags);
> }
> 
I'm trying do this.
But I think it's the Inverse Process of mem mapping and also generates 
duplicated code(Boundary judgment, pagetable modify).

When removing the pgd mapping, it may split pud/pmd section which also 
needs [[[rebuild and clear]]] some pagetable.
> ...
> 
