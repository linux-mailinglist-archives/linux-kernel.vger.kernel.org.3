Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD756578B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiGDNlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGDNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:41:15 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E843B10A5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:41:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VINPxtk_1656942066;
Received: from 30.225.28.131(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0VINPxtk_1656942066)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 21:41:08 +0800
Message-ID: <3e6f5c5d-3503-8625-be6e-132daa0390f3@linux.alibaba.com>
Date:   Mon, 4 Jul 2022 21:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
To:     Will Deacon <will@kernel.org>
Cc:     baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, ardb@kernel.org, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <20220704103523.GC31437@willie-the-truck>
 <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck>
 <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20220704131516.GC31684@willie-the-truck>
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

在 2022/7/4 21:15, Will Deacon 写道:
> On Mon, Jul 04, 2022 at 08:05:59PM +0800, guanghui.fgh wrote:
>>
>>
>> 在 2022/7/4 19:14, Will Deacon 写道:
>>> On Mon, Jul 04, 2022 at 06:58:20PM +0800, guanghui.fgh wrote:
>>>>
>>>>
>>>> 在 2022/7/4 18:35, Will Deacon 写道:
>>>>> On Sat, Jul 02, 2022 at 11:57:53PM +0800, Guanghui Feng wrote:
>>>>>> The arm64 can build 2M/1G block/sectiion mapping. When using DMA/DMA32 zone
>>>>>> (enable crashkernel, disable rodata full, disable kfence), the mem_map will
>>>>>> use non block/section mapping(for crashkernel requires to shrink the region
>>>>>> in page granularity). But it will degrade performance when doing larging
>>>>>> continuous mem access in kernel(memcpy/memmove, etc).
>>>>>
>>>>> Hmm. It seems a bit silly to me that we take special care to unmap the
>>>>> crashkernel from the linear map even when can_set_direct_map() is false, as
>>>>> we won't be protecting the main kernel at all!
>>>>>
>>>>> Why don't we just leave the crashkernel mapped if !can_set_direct_map()
>>>>> and then this problem just goes away?
>>>>
>>>> This question had been asked lask week.
>>>
>>> Sorry, I didn't spot that. Please could you link me to the conversation, as
>>> I'm still unable to find it in my inbox?
>>
>> Please access this link:
>> https://lore.kernel.org/linux-arm-kernel/075b0a8e-cb7e-70f6-b45a-54cd31886794@linux.alibaba.com/T/
> 
> Sorry, but I read through the thread and I still can't find where the
> possibility of leaving the crashkernel mapped was discussed >
>>>> 1.Quoted messages from arch/arm64/mm/init.c
>>>>
>>>> "Memory reservation for crash kernel either done early or deferred
>>>> depending on DMA memory zones configs (ZONE_DMA) --
>>>>
>>>> In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
>>>> here instead of max_zone_phys().  This lets early reservation of
>>>> crash kernel memory which has a dependency on arm64_dma_phys_limit.
>>>> Reserving memory early for crash kernel allows linear creation of block
>>>> mappings (greater than page-granularity) for all the memory bank rangs.
>>>> In this scheme a comparatively quicker boot is observed.
>>>>
>>>> If ZONE_DMA configs are defined, crash kernel memory reservation
>>>> is delayed until DMA zone memory range size initialization performed in
>>>> zone_sizes_init().  The defer is necessary to steer clear of DMA zone
>>>> memory range to avoid overlap allocation.
>>>>
>>>> [[[
>>>> So crash kernel memory boundaries are not known when mapping all bank memory
>>>> ranges, which otherwise means not possible to exclude crash kernel range
>>>> from creating block mappings so page-granularity mappings are created for
>>>> the entire memory range.
>>>> ]]]"
>>>>
>>>> Namely, the init order: memblock init--->linear mem mapping(4k mapping for
>>>> crashkernel, requirinig page-granularity changing))--->zone dma
>>>> limit--->reserve crashkernel.
>>>> So when enable ZONE DMA and using crashkernel, the mem mapping using 4k
>>>> mapping.
>>>
>>> Yes, I understand that is how things work today but I'm saying that we may
>>> as well leave the crashkernel mapped (at block granularity) if
>>> !can_set_direct_map() and then I think your patch becomes a lot simpler.
>>
>> But Page-granularity mapppings are necessary for crash kernel memory range
>> for shrinking its size via /sys/kernel/kexec_crash_size interfac(Quoted from
>> arch/arm64/mm/init.c).
>> So this patch split block/section mapping to 4k page-granularity mapping for
>> crashkernel mem.
> 
> Why? I don't see why the mapping granularity is relevant at all if we
> always leave the whole thing mapped.
> 
> Will

I have find the commit 06a7f711246b081afc21fff859f1003f1f2a0fbc adding 
/sys/kernel/kexec_crash_size for changing crashkernel mem size.

"Implement shrinking the reserved memory for crash kernel, if it is more 
than enough."

Maybe we could use block/section mapping for crashkernle mem, and split 
a part of crashkernel mem block/section mapping when shringking(by 
writing to /sys/kernel/kexec_crash_size(handled by crash_shrink_memory, 
crash_free_reserved_phys_range)).
(Maybe there is no need to split all crashkernle mem block/section 
mapping at boot time).

Thanks.
