Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8A5759FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiGOD3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOD3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:29:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D131274DF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 20:29:41 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LkcHK0QjNzkWkK;
        Fri, 15 Jul 2022 11:27:25 +0800 (CST)
Received: from [10.174.178.157] (10.174.178.157) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Jul 2022 11:29:38 +0800
Message-ID: <58ff7708-e659-2b21-7de6-2dad845fec2f@huawei.com>
Date:   Fri, 15 Jul 2022 11:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5] memblock,arm64: Expand the static memblock memory
 table
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <anshuman.khandual@arm.com>, <darren@os.amperecomputing.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <xuqiang36@huawei.com>
References: <20220615102742.96450-1-zhouguanghui1@huawei.com>
 <20220628110301.GA23703@willie-the-truck>
From:   Zhou Guanghui <zhouguanghui1@huawei.com>
In-Reply-To: <20220628110301.GA23703@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/28 19:03, Will Deacon wrote:
> On Wed, Jun 15, 2022 at 10:27:42AM +0000, Zhou Guanghui wrote:
>> In a system(Huawei Ascend ARM64 SoC) using HBM, a multi-bit ECC error
>> occurs, and the BIOS will mark the corresponding area (for example, 2 MB)
>> as unusable. When the system restarts next time, these areas are not
>> reported or reported as EFI_UNUSABLE_MEMORY. Both cases lead to an
>> increase in the number of memblocks, whereas EFI_UNUSABLE_MEMORY
>> leads to a larger number of memblocks.
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
>>
>> The EFI memory map is parsed to construct the memblock arrays before
>> the memblock arrays can be resized. As the result, memory regions
>> beyond INIT_MEMBLOCK_REGIONS are lost.
>>
>> Add a new macro INIT_MEMBLOCK_MEMORY_REGTIONS to replace
> 
> nit: s/REGTIONS/REGIONS/
> 
>> INIT_MEMBLOCK_REGTIONS to define the size of the static memblock.memory
>> array.
>>
>> Allow overriding memblock.memory array size with architecture defined
>> INIT_MEMBLOCK_MEMORY_REGIONS and make arm64 to set
>> INIT_MEMBLOCK_MEMORY_REGIONS to 1024 when CONFIG_EFI is enabled.
>>
>> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
>> Tested-by: Darren Hart <darren@os.amperecomputing.com>
>> ---
>>  arch/arm64/include/asm/memory.h |  9 +++++++++
>>  mm/memblock.c                   | 14 +++++++++-----
>>  2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index 0af70d9abede..ce8614fa376a 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -364,6 +364,15 @@ void dump_mem_limit(void);
>>  # define INIT_MEMBLOCK_RESERVED_REGIONS	(INIT_MEMBLOCK_REGIONS + NR_CPUS + 1)
>>  #endif
>>  
>> +/*
>> + * memory regions which marked with flag MEMBLOCK_NOMAP(for example, the memory
>> + * of the EFI_UNUSABLE_MEMORY type) may divide a continuous memory block into
>> + * multiple parts. As a result, the number of memory regions is large.
>> + */
>> +#ifdef CONFIG_EFI
>> +#define INIT_MEMBLOCK_MEMORY_REGIONS	(INIT_MEMBLOCK_REGIONS * 8)
>> +#endif
>> +
>>  #include <asm-generic/memory_model.h>
>>  
>>  #endif /* __ASM_MEMORY_H */
> 
> For the arm64 bit:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I'm assuming Andrew will pick this up, but please yell if you'd prefer it
> to go via the arm64 tree.

Andrew, do you have any suggestions for this patch?

> 
> Will
> 
