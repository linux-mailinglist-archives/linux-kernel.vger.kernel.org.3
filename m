Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0F568C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiGFPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiGFPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:18:34 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3855AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:18:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIYaV52_1657120703;
Received: from 30.225.28.170(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIYaV52_1657120703)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 23:18:24 +0800
Message-ID: <9974bea5-4db9-0104-c9c9-d9b49c390f1b@linux.alibaba.com>
Date:   Wed, 6 Jul 2022 23:18:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
To:     Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck> <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com> <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com> <YsSi9HAOOzbPYN+w@kernel.org>
 <YsVeKPzaO0SJdwFW@arm.com> <YsWULnvZZxoHtyRo@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YsWULnvZZxoHtyRo@kernel.org>
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

在 2022/7/6 21:54, Mike Rapoport 写道:
> On Wed, Jul 06, 2022 at 11:04:24AM +0100, Catalin Marinas wrote:
>> On Tue, Jul 05, 2022 at 11:45:40PM +0300, Mike Rapoport wrote:
>>> On Tue, Jul 05, 2022 at 06:05:01PM +0100, Catalin Marinas wrote:
>>>> On Tue, Jul 05, 2022 at 06:57:53PM +0300, Mike Rapoport wrote:
>>>>> On Tue, Jul 05, 2022 at 04:34:09PM +0100, Catalin Marinas wrote:
>>>>>> On Tue, Jul 05, 2022 at 06:02:02PM +0300, Mike Rapoport wrote:
>>>>>>> +void __init remap_crashkernel(void)
>>>>>>> +{
>>>>>>> +#ifdef CONFIG_KEXEC_CORE
>>>>>>> +	phys_addr_t start, end, size;
>>>>>>> +	phys_addr_t aligned_start, aligned_end;
>>>>>>> +
>>>>>>> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>>>>>>> +	    return;
>>>>>>> +
>>>>>>> +	if (!crashk_res.end)
>>>>>>> +	    return;
>>>>>>> +
>>>>>>> +	start = crashk_res.start & PAGE_MASK;
>>>>>>> +	end = PAGE_ALIGN(crashk_res.end);
>>>>>>> +
>>>>>>> +	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
>>>>>>> +	aligned_end = ALIGN(end, PUD_SIZE);
>>>>>>> +
>>>>>>> +	/* Clear PUDs containing crash kernel memory */
>>>>>>> +	unmap_hotplug_range(__phys_to_virt(aligned_start),
>>>>>>> +			    __phys_to_virt(aligned_end), false, NULL);
>>>>>>
>>>>>> What I don't understand is what happens if there's valid kernel data
>>>>>> between aligned_start and crashk_res.start (or the other end of the
>>>>>> range).
>>>>>
>>>>> Data shouldn't go anywhere :)
>>>>>
>>>>> There is
>>>>>
>>>>> +	/* map area from PUD start to start of crash kernel with large pages */
>>>>> +	size = start - aligned_start;
>>>>> +	__create_pgd_mapping(swapper_pg_dir, aligned_start,
>>>>> +			     __phys_to_virt(aligned_start),
>>>>> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
>>>>>
>>>>> and
>>>>>
>>>>> +	/* map area from end of crash kernel to PUD end with large pages */
>>>>> +	size = aligned_end - end;
>>>>> +	__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
>>>>> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
>>>>>
>>>>> after the unmap, so after we tear down a part of a linear map we
>>>>> immediately recreate it, just with a different page size.
>>>>>
>>>>> This all happens before SMP, so there is no concurrency at that point.
>>>>
>>>> That brief period of unmap worries me. The kernel text, data and stack
>>>> are all in the vmalloc space but any other (memblock) allocation to this
>>>> point may be in the unmapped range before and after the crashkernel
>>>> reservation. The interrupts are off, so I think the only allocation and
>>>> potential access that may go in this range is the page table itself. But
>>>> it looks fragile to me.
>>>
>>> I agree there are chances there will be an allocation from the unmapped
>>> range.
>>>
>>> We can make sure this won't happen, though. We can cap the memblock
>>> allocations with memblock_set_current_limit(aligned_end) or
>>> memblock_reserve(algined_start, aligned_end) until the mappings are
>>> restored.
>>
>> We can reserve the region just before unmapping to avoid new allocations
>> for the page tables but we can't do much about pages already allocated
>> prior to calling remap_crashkernel().
> 
> Right, this was bothering me too after I re-read you previous email.
> 
> One thing I can think of is to only remap the crash kernel memory if it is
> a part of an allocation that exactly fits into one ore more PUDs.
> 
> Say, in reserve_crashkernel() we try the memblock_phys_alloc() with
> PUD_SIZE as alignment and size rounded up to PUD_SIZE. If this allocation
> succeeds, we remap the entire area that now contains only memory allocated
> in reserve_crashkernel() and free the extra memory after remapping is done.
> If the large allocation fails, we fall back to the original size and
> alignment and don't allow unmapping crash kernel memory in
> arch_kexec_protect_crashkres().
>   
>> -- 
>> Catalin
> 
Thanks.

There is a new method.
I think we should use the patch v3(similar but need add some changes)

1.We can walk crashkernle block/section pagetable,
[[[(keep the origin block/section mapping valid]]]
rebuild the pte level page mapping for the crashkernel mem
rebuild left & right margin mem(which is in same block/section mapping 
but out of crashkernel mem) with block/section mapping

2.'replace' the origin block/section mapping by new builded mapping 
iterately

With this method, all the mem mapping keep valid all the time.

3.the patch v3 link:
https://lore.kernel.org/linux-mm/6dc308db-3685-4df5-506a-71f9e3794ec8@linux.alibaba.com/T/
(Need some changes)
