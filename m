Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34405242D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiELCqb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 May 2022 22:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiELCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:46:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA2525E83
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:46:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KzGN84FY9z1JByM;
        Thu, 12 May 2022 10:45:12 +0800 (CST)
Received: from kwepemi500016.china.huawei.com (7.221.188.220) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 10:46:25 +0800
Received: from kwepemi500016.china.huawei.com ([7.221.188.220]) by
 kwepemi500016.china.huawei.com ([7.221.188.220]) with mapi id 15.01.2375.024;
 Thu, 12 May 2022 10:46:25 +0800
From:   "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Thread-Topic: [PATCH] memblock: config the number of init memblock regions
Thread-Index: AQHYZNPbEUxHIqQA2UaYuzIS2IDK3A==
Date:   Thu, 12 May 2022 02:46:25 +0000
Message-ID: <73da782c847b413d9b81b0c2940ab13c@huawei.com>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
 <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
 <YntRlrwJeP40q6Hg@kernel.org>
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

在 2022/5/11 14:03, Mike Rapoport 写道:
> On Tue, May 10, 2022 at 06:55:23PM -0700, Andrew Morton wrote:
>> On Wed, 11 May 2022 01:05:30 +0000 Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
>>
>>> During early boot, the number of memblocks may exceed 128(some memory
>>> areas are not reported to the kernel due to test failures. As a result,
>>> contiguous memory is divided into multiple parts for reporting). If
>>> the size of the init memblock regions is exceeded before the array size
>>> can be resized, the excess memory will be lost.
> 
> I'd like to see more details about how firmware creates that sparse memory
> map in the changelog.
> 

The scenario is as follows: In a system using HBM, a multi-bit ECC error 
occurs, and the BIOS saves the corresponding area (for example, 2 MB). 
When the system restarts next time, these areas are isolated and not 
reported or reported as EFI_UNUSABLE_MEMORY. Both of them lead to an 
increase in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads 
to a larger number of memblocks.

For example, if the EFI_UNUSABLE_MEMORY type is reported:
..
memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 
0x0000000001200000 bytes on node 7 flags: 0x0
memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 
0x0000000000200000 bytes on node 7 flags: 0x4
memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 
0x0000000000a00000 bytes on node 7 flags: 0x0
memory[0x95]    [0x0000200836800000-0x00002008369fffff], 
0x0000000000200000 bytes on node 7 flags: 0x4
memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 
0x0000000001200000 bytes on node 7 flags: 0x0
memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 
0x0000000000200000 bytes on node 7 flags: 0x4
memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 
0x0000000048200000 bytes on node 7 flags: 0x0
memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 
0x0000000350000000 bytes on node 6 flags: 0x0
memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 
0x0000000000200000 bytes on node 6 flags: 0x4
memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 
0x0000000000600000 bytes on node 6 flags: 0x0
memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 
0x0000000000200000 bytes on node 6 flags: 0x4
memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 
0x00000003ff600000 bytes on node 6 flags: 0x0
memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 
0x0000000000200000 bytes on node 6 flags: 0x4
memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 
0x000000002fe00000 bytes on node 6 flags: 0x0
..

>>>
>>> ...
>>>
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -89,6 +89,14 @@ config SPARSEMEM_VMEMMAP
>>>   	  pfn_to_page and page_to_pfn operations.  This is the most
>>>   	  efficient option when sufficient kernel resources are available.
>>>   
>>> +config MEMBLOCK_INIT_REGIONS
>>> +	int "Number of init memblock regions"
>>> +	range 128 1024
>>> +	default 128
>>> +	help
>>> +	  The number of init memblock regions which used to track "memory" and
>>> +	  "reserved" memblocks during early boot.
>>> +
>>>   config HAVE_MEMBLOCK_PHYS_MAP
>>>   	bool
>>>   
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index e4f03a6e8e56..6893d26b750e 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -22,7 +22,7 @@
>>>   
>>>   #include "internal.h"
>>>   
>>> -#define INIT_MEMBLOCK_REGIONS			128
>>> +#define INIT_MEMBLOCK_REGIONS			CONFIG_MEMBLOCK_INIT_REGIONS
>>
>> Consistent naming would be nice - MEMBLOCK_INIT versus INIT_MEMBLOCK.

I agree.

>>
>> Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
>> config option?  It appears that the overhead from this would be 60kB or
>> so.
> 
> 60k is not big, but using 1024 entries array for 2-4 memory banks on
> systems that don't report that fragmented memory map is really a waste.
> 
> We can make this per platform opt-in, like INIT_MEMBLOCK_RESERVED_REGIONS ...
> 

As I described above, is this a general scenario?

>> Or zero if CONFIG_ARCH_KEEP_MEMBLOCK and CONFIG_MEMORY_HOTPLUG
>> are cooperating.
> 
> ... or add code that will discard unused parts of memblock arrays even if
> CONFIG_ARCH_KEEP_MEMBLOCK=y.
> 

In scenarios where the memory usage is sensitive, should 
CONFIG_ARCH_KEEP_MEMBLOCK be set to n or set the number by adding config?

Andrew, Mike, thank you.
