Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F655C1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiF1DGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiF1DGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:06:32 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6A13E8A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:06:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VHf8Tas_1656385579;
Received: from 30.225.28.186(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VHf8Tas_1656385579)
          by smtp.aliyun-inc.com;
          Tue, 28 Jun 2022 11:06:20 +0800
Message-ID: <54f13945-fa35-247d-ca33-182931fd05ff@linux.alibaba.com>
Date:   Tue, 28 Jun 2022 11:06:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64: mm: fix linear mapping mem access performace
 degradation
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        jianyong.wu@arm.com, james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        bhe@redhat.com, Yao Hongbo <yaohongbo@linux.alibaba.com>
References: <1656241815-28494-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <YrlPfjv2Wf/C77DI@kernel.org>
 <4d18d303-aeed-0beb-a8a4-32893f2d438d@linux.alibaba.com>
 <Yrl9FcVv1wZ5MnRp@kernel.org>
 <ae5c6c07-1d49-ffd2-6f62-69df4308d0bb@linux.alibaba.com>
 <32aefb80-c59c-74b6-c373-dd24edba0752@huawei.com>
 <075b0a8e-cb7e-70f6-b45a-54cd31886794@linux.alibaba.com>
 <55873a70-da46-b0f6-db81-841a2b5e886a@huawei.com>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <55873a70-da46-b0f6-db81-841a2b5e886a@huawei.com>
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

在 2022/6/28 9:34, Leizhen (ThunderTown) 写道:
> 
> 
> On 2022/6/27 20:25, guanghui.fgh wrote:
>> Thanks.
>>
>> 在 2022/6/27 20:06, Leizhen (ThunderTown) 写道:
>>>
>>>
>>> On 2022/6/27 18:46, guanghui.fgh wrote:
>>>>
>>>>
>>>> 在 2022/6/27 17:49, Mike Rapoport 写道:
>>>>> Please don't post HTML.
>>>>>
>>>>> On Mon, Jun 27, 2022 at 05:24:10PM +0800, guanghui.fgh wrote:
>>>>>> Thanks.
>>>>>>
>>>>>> 在 2022/6/27 14:34, Mike Rapoport 写道:
>>>>>>
>>>>>>        On Sun, Jun 26, 2022 at 07:10:15PM +0800, Guanghui Feng wrote:
>>>>>>
>>>>>>            The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>>>>>>            (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>>>>>>            use non block/section mapping(for crashkernel requires to shrink the region
>>>>>>            in page granularity). But it will degrade performance when doing larging
>>>>>>            continuous mem access in kernel(memcpy/memmove, etc).
>>>>>>
>>>>>>            There are many changes and discussions:
>>>>>>            commit 031495635b46
>>>>>>            commit 1a8e1cef7603
>>>>>>            commit 8424ecdde7df
>>>>>>            commit 0a30c53573b0
>>>>>>            commit 2687275a5843
>>>>>>
>>>>>>        Please include oneline summary of the commit. (See section "Describe your
>>>>>>        changes" in Documentation/process/submitting-patches.rst)
>>>>>>
>>>>>> OK, I will add oneline summary in the git commit messages.
>>>>>>
>>>>>>            This patch changes mem_map to use block/section mapping with crashkernel.
>>>>>>            Firstly, do block/section mapping(normally 2M or 1G) for all avail mem at
>>>>>>            mem_map, reserve crashkernel memory. And then walking pagetable to split
>>>>>>            block/section mapping to non block/section mapping(normally 4K) [[[only]]]
>>>>>>            for crashkernel mem.
>>>>>>
>>>>>>        This already happens when ZONE_DMA/ZONE_DMA32 are disabled. Please explain
>>>>>>        why is it Ok to change the way the memory is mapped with
>>>>>>        ZONE_DMA/ZONE_DMA32 enabled.
>>>>>>
>>>>>> In short:
>>>>>>
>>>>>> 1.building all avail mem with block/section mapping（normally 1G/2M） without
>>>>>> inspecting crashkernel
>>>>>> 2. Reserve crashkernel mem as same as previous doing
>>>>>> 3. only change the crashkernle mem mapping to normal mapping(normally 4k).
>>>>>> With this method, there are block/section mapping as more as possible.
>>>>>
>>>>> This does not answer the question why changing the way the memory is mapped
>>>>> when there is ZONE_DMA/DMA32 and crashkernel won't cause a regression.
>>>>>
>>>> 1.Quoted messages from arch/arm64/mm/init.c
>>>>
>>>> "Memory reservation for crash kernel either done early or deferred
>>>> depending on DMA memory zones configs (ZONE_DMA) --
>>>>
>>>> In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
>>>> here instead of max_zone_phys().  This lets early reservation of
>>>> crash kernel memory which has a dependency on arm64_dma_phys_limit.
>>>> Reserving memory early for crash kernel allows linear creation of block
>>>> mappings (greater than page-granularity) for all the memory bank rangs.
>>>> In this scheme a comparatively quicker boot is observed.
>>>>
>>>> If ZONE_DMA configs are defined, crash kernel memory reservation
>>>> is delayed until DMA zone memory range size initialization performed in
>>>> zone_sizes_init().  The defer is necessary to steer clear of DMA zone
>>>> memory range to avoid overlap allocation.  So crash kernel memory boundaries are not known when mapping all bank memory ranges, which otherwise means not possible to exclude crash kernel range from creating block mappings so page-granularity mappings are created for the entire memory range."
>>>>
>>>> Namely, the init order: memblock init--->linear mem mapping(4k mapping for crashkernel, requirinig page-granularity changing))--->zone dma limit--->reserve crashkernel.
>>>> So when enable ZONE DMA and using crashkernel, the mem mapping using 4k mapping.
>>>>
>>>> 2.As mentioned above, when linear mem use 4k mapping simply, there is high dtlb miss(degrade performance).
>>>> This patch use block/section mapping as far as possible with performance improvement.
>>>>
>>>> 3.This patch reserve crashkernel as same as the history(ZONE DMA & crashkernel reserving order), and only change the linear mem mapping to block/section mapping.
>>>> .
>>>>
>>>
>>> I think Mike Rapoport's probably asking you to answer whether you've
>>> taken into account such as BBM. For example, the following code:
>>> we should prepare the next level pgtable first, then change 2M block
>>> mapping to 4K page mapping, and flush TLB at the end.
>>>> +static void init_crashkernel_pmd(pud_t *pudp, unsigned long addr,
>>> +                 unsigned long end, phys_addr_t phys,
>>> +                 pgprot_t prot,
>>> +                 phys_addr_t (*pgtable_alloc)(int), int flags)
>>> +{
>>> +    phys_addr_t map_offset;
>>> +    unsigned long next;
>>> +    pmd_t *pmdp;
>>> +    pmdval_t pmdval;
>>> +
>>> +    pmdp = pmd_offset(pudp, addr);
>>> +    do {
>>> +        next = pmd_addr_end(addr, end);
>>> +        if (!pmd_none(*pmdp) && pmd_sect(*pmdp)) {
>>> +            phys_addr_t pte_phys = pgtable_alloc(PAGE_SHIFT);
>>> +            pmd_clear(pmdp);
>>> +            pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN;
>>> +            if (flags & NO_EXEC_MAPPINGS)
>>> +                pmdval |= PMD_TABLE_PXN;
>>> +            __pmd_populate(pmdp, pte_phys, pmdval);
>>> +            flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>
>>> The pgtable is empty now. However, memory other than crashkernel may be being accessed.
>> 1.When reserving crashkernel and remapping linear mem mapping, there is only one boot cpu running. There is no other cpu/thread running at the same time.
> 
> So, put this in the code comment?
OK.
> 
> If scalability is considered and unpredictable changes occur in the future, for example,
> other modules also need this mapping function. It would be better to deal with the BBM now,
> and make this public.
OK, could you give me some advice?
> 
> 
>>
>> 2.When clearing block/section mapping, I have flush tlb by flush_tlb_kernel_range. Afterwards rebuilt 4k mapping(I think it's no need flush tlb).
> 
> 
>>
>>>
>>> +
>>> +            map_offset = addr - (addr & PMD_MASK);
>>> +            if (map_offset)
>>> +                alloc_init_cont_pte(pmdp, addr & PMD_MASK, addr,
>>> +                        phys - map_offset, prot,
>>> +                        pgtable_alloc, flags);
>>> +
>>> +            if (next < (addr & PMD_MASK) + PMD_SIZE)
>>> +                alloc_init_cont_pte(pmdp, next, (addr & PUD_MASK) +
>>> +                        PUD_SIZE, next - addr + phys,
>>> +                        prot, pgtable_alloc, flags);
> 
> Here and alloc_crashkernel_pud() should use the raw flags. It may not contain  (NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS)
Yes. the mem out of crashkernel should use block/section mapping as far 
as possible including the LeftMargin and RightMargin.
But I had test it on HiSilicon Kunpeng 920-6426 with it and get 
performacne degrade(without NO_BLOCK_MAPPINGS/NO_CONT_MAPPINGS flags for 
the left/right margin)
It's strange, could you give some advice? Maybe it's good for other arm 
platform except for HiSilicon Kunpeng 920-6426.
> 
>>> +        }
>>> +        alloc_crashkernel_cont_pte(pmdp, addr, next, phys, prot,
>>> +                       pgtable_alloc, flags);
>>> +        phys += next - addr;
>>> +    } while (pmdp++, addr = next, addr != end);
>>> +}
>>>
>> .
>>
> 
