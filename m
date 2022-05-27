Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB6535C87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349908AbiE0JCP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 May 2022 05:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbiE0JAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:00:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD256C570
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:56:16 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L8dt45DhwzjWxw;
        Fri, 27 May 2022 16:55:08 +0800 (CST)
Received: from kwepemi500016.china.huawei.com (7.221.188.220) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:56:11 +0800
Received: from kwepemi500016.china.huawei.com ([7.221.188.220]) by
 kwepemi500016.china.huawei.com ([7.221.188.220]) with mapi id 15.01.2375.024;
 Fri, 27 May 2022 16:56:11 +0800
From:   "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH v2] arm64: Expand the static memblock memory table
Thread-Topic: [PATCH v2] arm64: Expand the static memblock memory table
Thread-Index: AQHYaePxMXVmORJiq0CmXcJ5Ica/dg==
Date:   Fri, 27 May 2022 08:56:11 +0000
Message-ID: <5d9390e36e6148e49284af3a7233accb@huawei.com>
References: <20220517114309.10228-1-zhouguanghui1@huawei.com>
 <de0788c0-a5a8-cf5b-5f20-eb9e99cd62ca@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.157]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

在 2022/5/18 12:40, Anshuman Khandual 写道:
> Hi Zhou,
> 
> A small nit.
> 
> This changes generic memblock to accommodate arm64 specific scenario.
> Keeping the subject line as 'mm/memblock: ...' might be better.
> 

I will add memblock to the subject line.

> On 5/17/22 17:13, Zhou Guanghui wrote:
>> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
>> saves the corresponding area (for example, 2 MB). When the system
>> restarts next time, these areas are isolated and not reported or
>> reported as EFI_UNUSABLE_MEMORY. Both of them lead to an increase
> 
> Which cases dont get reported rather than as EFI_UNUSABLE_MEMORY ? Is
> this supported on arm64 platform via mainline kernel ?
> 

The BIOS determines how to report the memory area that cannot be used to 
the kernel. Do not report the memory area to the kernel or inform the 
kernel that the memory area is unusable.

>> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to
>> a larger number of memblocks.
>>
>> For example, if the EFI_UNUSABLE_MEMORY type is reported:
>> ...
>> memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
>> memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>> memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
>> memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>> memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
>> memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
>> memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
>> memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
>> memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>> memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
>> memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>> memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
>> memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
>> memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
> 
> Got it.
> 
>> ...
>>
>> If the size of the init memblock regions is exceeded before the
>> array size can be resized, the excess memory will be lost.
> 
> Could you please elaborate more on why additional memblock regions can
> not be accommodated via memblock array resizing ?
> 

As described in the memblock_double_array function: We don't allow 
resizing until we know about the reserved regions of memory that aren' 
not suitable for allocation.

>>
>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>> ---
>>   arch/arm64/include/asm/memory.h |  9 +++++++++
>>   mm/memblock.c                   | 14 +++++++++-----
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 0af70d9abede..eda61c0389c4 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -364,6 +364,15 @@ void dump_mem_limit(void);
>>   # define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>>   #endif
>>   
>> +/*
>> + * memory regions which marked with flag MEMBLOCK_NOMAP may divide a continuous
>> + * memory block into multiple parts. As a result, the number of memory regions
>> + * is large.
>> + */
>> +#ifdef CONFIG_EFI
> 
> Could not memblock regions tagged with MEMBLOCK_NOMAP flag not present
> on non-EFI systems ? Just wondering, are there not some other scenarios
> which will also require expanded static memblock array.

Systems using devicetree can also have "no-map" memory. However, in this 
case, the expanded static memblock array is required only when a large 
number of such no-map reserved memories are manually added. I don't know 
if any users will do that.

Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml

As to whether other scenarios also require expanded static memblock 
arrays, I really don't know.

> 
>> +#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
>> +#endif
>> +
>>   #include <asm-generic/memory_model.h>
>>   
>>   #endif /* __ASM_MEMORY_H */
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index e4f03a6e8e56..7c63571a69d7 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -29,6 +29,10 @@
>>   # define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>   #endif
>>   
>> +#ifndef INIT_MEMBLOCK_MEMORY_REGIONS
>> +#define INIT_MEMBLOCK_MEMORY_REGIONS		INIT_MEMBLOCK_REGIONS
>> +#endif
> 
> Why create an additional macro INIT_MEMBLOCK_MEMORY_REGIONS ? Why cannot
> INIT_MEMBLOCK_REGIONS be defined in the platform directly like the other
> macro INIT_MEMBLOCK_RESERVED_REGIONS ?
> 

The number of reserved memblocks does not need to be increased.

>> +
>>   /**
>>    * DOC: memblock overview
>>    *
>> @@ -55,9 +59,9 @@
>>    * the allocator metadata. The "memory" and "reserved" types are nicely
>>    * wrapped with struct memblock. This structure is statically
>>    * initialized at build time. The region arrays are initially sized to
>> - * %INIT_MEMBLOCK_REGIONS for "memory" and %INIT_MEMBLOCK_RESERVED_REGIONS
>> - * for "reserved". The region array for "physmem" is initially sized to
>> - * %INIT_PHYSMEM_REGIONS.
>> + * %INIT_MEMBLOCK_MEMORY_REGIONS for "memory" and
>> + * %INIT_MEMBLOCK_RESERVED_REGIONS for "reserved". The region array
>> + * for "physmem" is initially sized to %INIT_PHYSMEM_REGIONS.
>>    * The memblock_allow_resize() enables automatic resizing of the region
>>    * arrays during addition of new regions. This feature should be used
>>    * with care so that memory allocated for the region array will not
>> @@ -102,7 +106,7 @@ unsigned long min_low_pfn;
>>   unsigned long max_pfn;
>>   unsigned long long max_possible_pfn;
>>   
>> -static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>> +static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_MEMORY_REGIONS] __initdata_memblock;
>>   static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
>>   #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>   static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS];
>> @@ -111,7 +115,7 @@ static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS
>>   struct memblock memblock __initdata_memblock = {
>>   	.memory.regions		= memblock_memory_init_regions,
>>   	.memory.cnt		= 1,	/* empty dummy entry */
>> -	.memory.max		= INIT_MEMBLOCK_REGIONS,
>> +	.memory.max		= INIT_MEMBLOCK_MEMORY_REGIONS,
>>   	.memory.name		= "memory",
>>   
>>   	.reserved.regions	= memblock_reserved_init_regions,
> 
> - Anshuman
> 

Thanks, Anshuman
