Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D143553C8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiFCKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFCKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:54:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6330C3A704
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:54:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF341063;
        Fri,  3 Jun 2022 03:54:43 -0700 (PDT)
Received: from [10.162.42.23] (unknown [10.162.42.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583A03F73D;
        Fri,  3 Jun 2022 03:54:40 -0700 (PDT)
Message-ID: <a5fdc430-d00b-7236-5994-f35357944160@arm.com>
Date:   Fri, 3 Jun 2022 16:24:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: Expand the static memblock memory table
Content-Language: en-US
To:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
References: <20220517114309.10228-1-zhouguanghui1@huawei.com>
 <de0788c0-a5a8-cf5b-5f20-eb9e99cd62ca@arm.com>
 <5d9390e36e6148e49284af3a7233accb@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <5d9390e36e6148e49284af3a7233accb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/22 14:26, Zhouguanghui (OS Kernel) wrote:
> Hi Anshuman,
> 
> 在 2022/5/18 12:40, Anshuman Khandual 写道:
>> Hi Zhou,
>>
>> A small nit.
>>
>> This changes generic memblock to accommodate arm64 specific scenario.
>> Keeping the subject line as 'mm/memblock: ...' might be better.
>>
> 
> I will add memblock to the subject line.
> 
>> On 5/17/22 17:13, Zhou Guanghui wrote:
>>> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
>>> saves the corresponding area (for example, 2 MB). When the system
>>> restarts next time, these areas are isolated and not reported or
>>> reported as EFI_UNUSABLE_MEMORY. Both of them lead to an increase
>>
>> Which cases dont get reported rather than as EFI_UNUSABLE_MEMORY ? Is
>> this supported on arm64 platform via mainline kernel ?
>>
> 
> The BIOS determines how to report the memory area that cannot be used to 
> the kernel. Do not report the memory area to the kernel or inform the 
> kernel that the memory area is unusable.

Right, but just curious whether there are real systems in the field with
this feature running mainline kernel ? OR this is just being future proof.

> 
>>> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to
>>> a larger number of memblocks.
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
>>
>> Got it.
>>
>>> ...
>>>
>>> If the size of the init memblock regions is exceeded before the
>>> array size can be resized, the excess memory will be lost.
>>
>> Could you please elaborate more on why additional memblock regions can
>> not be accommodated via memblock array resizing ?
>>
> 
> As described in the memblock_double_array function: We don't allow 
> resizing until we know about the reserved regions of memory that aren' 
> not suitable for allocation.
> 
>>>
>>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
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
>>> +#ifdef CONFIG_EFI
>>
>> Could not memblock regions tagged with MEMBLOCK_NOMAP flag not present
>> on non-EFI systems ? Just wondering, are there not some other scenarios
>> which will also require expanded static memblock array.
> 
> Systems using devicetree can also have "no-map" memory. However, in this 
> case, the expanded static memblock array is required only when a large 
> number of such no-map reserved memories are manually added. I don't know 
> if any users will do that.
> 
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> 
> As to whether other scenarios also require expanded static memblock 
> arrays, I really don't know.

In that case could this comment here be more specific about this increased
static array size, being applicable only for MEMBLOCK_NOMAP regions on EFI
system with EFI_UNUSABLE_MEMORY tagging support. Is there an way to narrow
this down further wrt EFI_UNUSABLE_MEMORY, rather than blanket EFI ?

+/*
+ * memory regions which marked with flag MEMBLOCK_NOMAP may divide a continuous
+ * memory block into multiple parts. As a result, the number of memory regions
+ * is large.
+ */
+#ifdef CONFIG_EFI
+#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
+#endif
+

> 
>>
>>> +#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
>>> +#endif
>>> +
>>>   #include <asm-generic/memory_model.h>
>>>   
>>>   #endif /* __ASM_MEMORY_H */
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index e4f03a6e8e56..7c63571a69d7 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -29,6 +29,10 @@
>>>   # define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>>   #endif
>>>   
>>> +#ifndef INIT_MEMBLOCK_MEMORY_REGIONS
>>> +#define INIT_MEMBLOCK_MEMORY_REGIONS		INIT_MEMBLOCK_REGIONS
>>> +#endif
>>
>> Why create an additional macro INIT_MEMBLOCK_MEMORY_REGIONS ? Why cannot
>> INIT_MEMBLOCK_REGIONS be defined in the platform directly like the other
>> macro INIT_MEMBLOCK_RESERVED_REGIONS ?
>>
> 
> The number of reserved memblocks does not need to be increased.

Got it.
