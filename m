Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE03567C19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiGFCty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGFCtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:49:53 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918915A3E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:49:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VIW9-BM_1657075784;
Received: from 30.225.28.170(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VIW9-BM_1657075784)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 10:49:45 +0800
Message-ID: <7bf7c5ea-16eb-b02f-8ef5-bb94c157236d@linux.alibaba.com>
Date:   Wed, 6 Jul 2022 10:49:43 +0800
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
References: <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
 <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck> <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com> <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com> <YsSi9HAOOzbPYN+w@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <YsSi9HAOOzbPYN+w@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

在 2022/7/6 4:45, Mike Rapoport 写道:
> On Tue, Jul 05, 2022 at 06:05:01PM +0100, Catalin Marinas wrote:
>> On Tue, Jul 05, 2022 at 06:57:53PM +0300, Mike Rapoport wrote:
>>> On Tue, Jul 05, 2022 at 04:34:09PM +0100, Catalin Marinas wrote:
>>>> On Tue, Jul 05, 2022 at 06:02:02PM +0300, Mike Rapoport wrote:
>>>>> +void __init remap_crashkernel(void)
>>>>> +{
>>>>> +#ifdef CONFIG_KEXEC_CORE
>>>>> +	phys_addr_t start, end, size;
>>>>> +	phys_addr_t aligned_start, aligned_end;
>>>>> +
>>>>> +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
>>>>> +	    return;
>>>>> +
>>>>> +	if (!crashk_res.end)
>>>>> +	    return;
>>>>> +
>>>>> +	start = crashk_res.start & PAGE_MASK;
>>>>> +	end = PAGE_ALIGN(crashk_res.end);
>>>>> +
>>>>> +	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
>>>>> +	aligned_end = ALIGN(end, PUD_SIZE);
>>>>> +
>>>>> +	/* Clear PUDs containing crash kernel memory */
>>>>> +	unmap_hotplug_range(__phys_to_virt(aligned_start),
>>>>> +			    __phys_to_virt(aligned_end), false, NULL);
>>>>
>>>> What I don't understand is what happens if there's valid kernel data
>>>> between aligned_start and crashk_res.start (or the other end of the
>>>> range).
>>>
>>> Data shouldn't go anywhere :)
>>>
>>> There is
>>>
>>> +	/* map area from PUD start to start of crash kernel with large pages */
>>> +	size = start - aligned_start;
>>> +	__create_pgd_mapping(swapper_pg_dir, aligned_start,
>>> +			     __phys_to_virt(aligned_start),
>>> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
>>>
>>> and
>>>
>>> +	/* map area from end of crash kernel to PUD end with large pages */
>>> +	size = aligned_end - end;
>>> +	__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
>>> +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
>>>
>>> after the unmap, so after we tear down a part of a linear map we
>>> immediately recreate it, just with a different page size.
>>>
>>> This all happens before SMP, so there is no concurrency at that point.
>>
>> That brief period of unmap worries me. The kernel text, data and stack
>> are all in the vmalloc space but any other (memblock) allocation to this
>> point may be in the unmapped range before and after the crashkernel
>> reservation. The interrupts are off, so I think the only allocation and
>> potential access that may go in this range is the page table itself. But
>> it looks fragile to me.
> 
> I agree there are chances there will be an allocation from the unmapped
> range.
> 
> We can make sure this won't happen, though. We can cap the memblock
> allocations with memblock_set_current_limit(aligned_end) or
> memblock_reserve(algined_start, aligned_end) until the mappings are
> restored.
>   
>> -- 
>> Catalin
> 
I think there is no need to worry about vmalloc mem.

1.As mentioned above,
When reserving crashkernel and remapping linear mem mapping, there is 
only one boot cpu running. There is no other cpu/thread running at the 
same time.

2.Although vmalloc may alloc mem from the ummaped area, but we will 
rebuid remapping using pte level mapping which keeps virtual address to 
the same physical address
(At the same time, no other cpu/thread is access vmalloc mem).

As a result, it has no effect to vmalloc mem.
