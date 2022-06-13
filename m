Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE1547F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiFMGFC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jun 2022 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiFMGEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:04:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4276C1D308
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:03:45 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM1DC6jqXz1K9Nw;
        Mon, 13 Jun 2022 14:01:47 +0800 (CST)
Received: from kwepemi500016.china.huawei.com (7.221.188.220) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 14:03:42 +0800
Received: from kwepemi500016.china.huawei.com ([7.221.188.220]) by
 kwepemi500016.china.huawei.com ([7.221.188.220]) with mapi id 15.01.2375.024;
 Mon, 13 Jun 2022 14:03:42 +0800
From:   Zhouguanghui <zhouguanghui1@huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH v3] memblock,arm64: Expand the static memblock memory
 table
Thread-Topic: [PATCH v3] memblock,arm64: Expand the static memblock memory
 table
Thread-Index: AQHYcatwg17tpfOKIU2lxCQfbCJwZA==
Date:   Mon, 13 Jun 2022 06:03:42 +0000
Message-ID: <b8135d70ea10408da115e78fa35f48cf@huawei.com>
References: <20220527091832.63489-1-zhouguanghui1@huawei.com>
 <c5ca2c49-94a3-d835-2627-48488296e7fc@arm.com>
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

在 2022/6/7 14:43, Anshuman Khandual 写道:
> Hello Zhou,
> 
> On 5/27/22 14:48, Zhou Guanghui wrote:
>> In a system using HBM, a multi-bit ECC error occurs, and the BIOS
>> will mark the corresponding area (for example, 2 MB) as unusable.
>> When the system restarts next time, these areas are not reported
>> or reported as EFI_UNUSABLE_MEMORY. Both cases lead to an increase
>> in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads to a
>> larger number of memblocks.
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
>> ...
> 
> Although this patch did not mention about a real world system requiring
> this support, as been reported on the thread, Ampere Altra does seem to
> get benefited. Regardless, it's always better to describe platform test
> scenarios in more detail.
> 

I encountered this scenario on Huawei Ascend ARM64 SoC.

>>
>> The EFI memory map is parsed to construct the memblock arrays before
>> the memblock arrays can be resized. As the result, memory regions
>> beyond INIT_MEMBLOCK_REGIONS are lost.
>>
>> Allow overriding memblock.memory array size with architecture defined
>> INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
>> INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.
> 
> Right, but first this needs to mention that INIT_MEMBLOCK_MEMORY_REGIONS
> (new macro) is being added to replace INIT_MEMBLOCK_REGIONS, representing
> max memory regions in the memblock. Platform override comes afterwards.
> 

Add a paragraph before the description,like this?

Add a new macro INIT_MEMBLOCK_MEMORY_REGTIONS to replace 
INIT_MEMBLOCK_REGTIONS to define the size of the static memblock.memory 
array.

>>
>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
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
> 
> As mentioned in the previous version's thread,
> 
> This comment needs be more specific about this increased static array size, being
> applicable ONLY for MEMBLOCK_NOMAP regions on EFI system with EFI_UNUSABLE_MEMORY
> tagging/flag support.
> 

EFI_UNUSABLE_MEMORY is only one type of the MEMBLOCK_NOMAP region, as 
shown in the is_usable_memory function. However, However, I currently 
have too many memblocks due to this flag.

>> +#ifdef CONFIG_EFI
>> +#define INIT_MEMBLOCK_MEMORY_REGIONS	1024
> 
> Although 1024 seems adequate as compared to 128 memory regions in the memblock to
> handle such error scenarios, but a co-relation with INIT_MEMBLOCK_REGIONS would
> be preferred similar to when INIT_MEMBLOCK_RESERVED_REGIONS gets overridden. This
> avoid a precedence when random numbers could get assigned in other archs later on.
> 
> $git grep INIT_MEMBLOCK_RESERVED_REGIONS arch/
> arch/arm64/include/asm/memory.h:# define INIT_MEMBLOCK_RESERVED_REGIONS (INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
> arch/loongarch/include/asm/sparsemem.h:#define INIT_MEMBLOCK_RESERVED_REGIONS   (INIT_MEMBLOCK_REGIONS + NR_CPUS)
> 
> Something like
> 
> #define INIT_MEMBLOCK_MEMORY_REGIONS	(INIT_MEMBLOCK_REGIONS * 8)
> 

I don't think this is necessary because INIT_MEMBLOCK_REGIONS is not 
configurable. The newly added INIT_MEMBLOCK_MEMORY_REGIONS macro is 
customized for each platform.

> 
> - Anshuman
> 

Thanks!

