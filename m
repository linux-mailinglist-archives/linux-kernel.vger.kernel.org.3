Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E0C547F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiFMGi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiFMGi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:38:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107BE2DE2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:38:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5EFDD6E;
        Sun, 12 Jun 2022 23:38:53 -0700 (PDT)
Received: from [10.163.38.134] (unknown [10.163.38.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2683F792;
        Sun, 12 Jun 2022 23:38:50 -0700 (PDT)
Message-ID: <2a492d62-8ce0-effe-b854-d0b58762be23@arm.com>
Date:   Mon, 13 Jun 2022 12:08:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] memblock,arm64: Expand the static memblock memory
 table
Content-Language: en-US
To:     Zhouguanghui <zhouguanghui1@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
References: <20220527091832.63489-1-zhouguanghui1@huawei.com>
 <c5ca2c49-94a3-d835-2627-48488296e7fc@arm.com>
 <b8135d70ea10408da115e78fa35f48cf@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <b8135d70ea10408da115e78fa35f48cf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/22 11:33, Zhouguanghui wrote:
> 在 2022/6/7 14:43, Anshuman Khandual 写道:
>> Hello Zhou,
>>
>> On 5/27/22 14:48, Zhou Guanghui wrote:
>>> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
>>> will mark the corresponding area (for example, 2 MB) as unusable.
>>> When the system restarts next time, these areas are not reported
>>> or reported as EFI_UNUSABLE_MEMORY. Both cases lead to an increase
>>> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to a
>>> larger number of memblocks.
>>>
>>> For example, if the EFI_UNUSABLE_MEMORY type is reported:
>>> ...
>>> memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
>>> memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>>> memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
>>> memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>>> memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
>>> memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>>> memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
>>> memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
>>> memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>>> memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
>>> memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>>> memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
>>> memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>>> memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
>>> ...
>>
>> Although this patch did not mention about a real world system requiring
>> this support, as been reported on the thread, Ampere Altra does seem to
>> get benefited. Regardless, it's always better to describe platform test
>> scenarios in more detail.
>>
> 
> I encountered this scenario on Huawei Ascend ARM64 SoC.

Please do mention that in the commit message.

> 
>>>
>>> The EFI memory map is parsed to construct the memblock arrays before
>>> the memblock arrays can be resized. As the result, memory regions
>>> beyond INIT_MEMBLOCK_REGIONS are lost.
>>>
>>> Allow overriding memblock.memory array size with architecture defined
>>> INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
>>> INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.
>>
>> Right, but first this needs to mention that INIT_MEMBLOCK_MEMORY_REGIONS
>> (new macro) is being added to replace INIT_MEMBLOCK_REGIONS, representing
>> max memory regions in the memblock. Platform override comes afterwards.
>>
> 
> Add a paragraph before the description,like this?
> 
> Add a new macro INIT_MEMBLOCK_MEMORY_REGTIONS to replace 
> INIT_MEMBLOCK_REGTIONS to define the size of the static memblock.memory 
> array.

Right.

> 
>>>
>>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>   arch/arm64/include/asm/memory.h |  9 +++++++++
>>>   mm/memblock.c                   | 14 +++++++++-----
>>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>> index 0af70d9abede..eda61c0389c4 100644
>>> --- a/arch/arm64/include/asm/memory.h
>>> +++ b/arch/arm64/include/asm/memory.h
>>> @@ -364,6 +364,15 @@ void dump_mem_limit(void);
>>>   # define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>>>   #endif
>>>   
>>> +/*
>>> + * memory regions which marked with flag MEMBLOCK_NOMAP may divide a continuous
>>> + * memory block into multiple parts. As a result, the number of memory regions
>>> + * is large.
>>> + */
>>
>> As mentioned in the previous version's thread,
>>
>> This comment needs be more specific about this increased static array size, being
>> applicable ONLY for MEMBLOCK_NOMAP regions on EFI system with EFI_UNUSABLE_MEMORY
>> tagging/flag support.
>>
> 
> EFI_UNUSABLE_MEMORY is only one type of the MEMBLOCK_NOMAP region, as 
> shown in the is_usable_memory function. However, However, I currently 
> have too many memblocks due to this flag.

Okay, but adding EFI_UNUSABLE_MEMORY context in that comment will be helpful.

> 
>>> +#ifdef CONFIG_EFI
>>> +#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
>>
>> Although 1024 seems adequate as compared to 128 memory regions in the memblock to
>> handle such error scenarios, but a co-relation with INIT_MEMBLOCK_REGIONS would
>> be preferred similar to when INIT_MEMBLOCK_RESERVED_REGIONS gets overridden. This
>> avoid a precedence when random numbers could get assigned in other archs later on.
>>
>> $git grep INIT_MEMBLOCK_RESERVED_REGIONS arch/
>> arch/arm64/include/asm/memory.h:# define INIT_MEMBLOCK_RESERVED_REGIONS (INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>> arch/loongarch/include/asm/sparsemem.h:#define INIT_MEMBLOCK_RESERVED_REGIONS   (INIT_MEMBLOCK_REGIONS + NR_CPUS)
>>
>> Something like
>>
>> #define INIT_MEMBLOCK_MEMORY_REGIONS	(INIT_MEMBLOCK_REGIONS * 8)
>>
> 
> I don't think this is necessary because INIT_MEMBLOCK_REGIONS is not 
> configurable. The newly added INIT_MEMBLOCK_MEMORY_REGIONS macro is 
> customized for each platform.

Even an existing macro INIT_MEMBLOCK_RESERVED_REGIONS still depends on
INIT_MEMBLOCK_REGIONS (arm64, loongarch) ? The point being, although
INIT_MEMBLOCK_REGIONS is not configurable, it still does provide enough
base value, as compared to defining a random number in platforms which
will override INIT_MEMBLOCK_MEMORY_REGIONS. What is your concern in
making it dependent on INIT_MEMBLOCK_REGIONS ?
