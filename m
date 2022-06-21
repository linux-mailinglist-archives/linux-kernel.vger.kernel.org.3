Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF5552C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbiFUH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347817AbiFUH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:57:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5FB245AB;
        Tue, 21 Jun 2022 00:57:15 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRzMG6ybKzcbCw;
        Tue, 21 Jun 2022 15:55:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:56:41 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:56:40 +0800
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4ad5f8c9-a411-da4e-f626-ead83d107bca@huawei.com>
Date:   Tue, 21 Jun 2022 15:56:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/21 13:33, Baoquan He wrote:
> Hi,
> 
> On 06/13/22 at 04:09pm, Zhen Lei wrote:
>> If the crashkernel has both high memory above DMA zones and low memory
>> in DMA zones, kexec always loads the content such as Image and dtb to the
>> high memory instead of the low memory. This means that only high memory
>> requires write protection based on page-level mapping. The allocation of
>> high memory does not depend on the DMA boundary. So we can reserve the
>> high memory first even if the crashkernel reservation is deferred.
>>
>> This means that the block mapping can still be performed on other kernel
>> linear address spaces, the TLB miss rate can be reduced and the system
>> performance will be improved.
> 
> Ugh, this looks a little ugly, honestly.
> 
> If that's for sure arm64 can't split large page mapping of linear
> region, this patch is one way to optimize linear mapping. Given kdump
> setting is necessary on arm64 server, the booting speed is truly
> impacted heavily.

There is also a performance impact when running.

> 
> However, I would suggest letting it as is with below reasons:
> 
> 1) The code will complicate the crashkernel reservatoin code which
> is already difficult to understand. 

Yeah, I feel it, too.

> 2) It can only optimize the two cases, first is CONFIG_ZONE_DMA|DMA32
>   disabled, the other is crashkernel=,high is specified. While both
>   two cases are corner case, most of systems have CONFIG_ZONE_DMA|DMA32
>   enabled, and most of systems have crashkernel=xM which is enough.
>   Having them optimized won't bring benefit to most of systems.

The case of CONFIG_ZONE_DMA|DMA32 disabled have been resolved by
commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for platforms with no DMA memory zones").
Currently the performance problem to be optimized is that DMA is enabled.


> 3) Besides, the crashkernel=,high can be handled earlier because 
>   arm64 alwasys have memblock.bottom_up == false currently, thus we
>   don't need worry arbout the lower limit of crashkernel,high
>   reservation for now. If memblock.bottom_up is set true in the future,
>   this patch doesn't work any more.
> 
> 
> ...
>         crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>                                                crash_base, crash_max);
> 
> So, in my opinion, we can leave the current NON_BLOCK|SECT mapping as
> is caused by crashkernel reserving, since no regression is brought.
> And meantime, turning to check if there's any way to make the contiguous
> linear mapping and later splitting work. The patch 4, 5 in this patchset
> doesn't make much sense to me, frankly speaking.

OK. As discussed earlier, I can rethink if there is a better way to patch 4-5,
and this time focus on patch 1-2. In this way, all the functions are complete,
and only optimization is left.

> 
> Thanks
> Baoquan
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/mm/init.c | 71 ++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 65 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index fb24efbc46f5ef4..ae0bae2cafe6ab0 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -141,15 +141,44 @@ static void __init reserve_crashkernel(int dma_state)
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	char *cmdline = boot_command_line;
>>  	int dma_enabled = IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
>> -	int ret;
>> +	int ret, skip_res = 0, skip_low_res = 0;
>>  	bool fixed_base;
>>  
>>  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
>>  		return;
>>  
>> -	if ((!dma_enabled && (dma_state != DMA_PHYS_LIMIT_UNKNOWN)) ||
>> -	     (dma_enabled && (dma_state != DMA_PHYS_LIMIT_KNOWN)))
>> -		return;
>> +	/*
>> +	 * In the following table:
>> +	 * X,high  means crashkernel=X,high
>> +	 * unknown means dma_state = DMA_PHYS_LIMIT_UNKNOWN
>> +	 * known   means dma_state = DMA_PHYS_LIMIT_KNOWN
>> +	 *
>> +	 * The first two columns indicate the status, and the last two
>> +	 * columns indicate the phase in which crash high or low memory
>> +	 * needs to be reserved.
>> +	 *  ---------------------------------------------------
>> +	 * | DMA enabled | X,high used |  unknown  |   known   |
>> +	 *  ---------------------------------------------------
>> +	 * |      N            N       |    low    |    NOP    |
>> +	 * |      Y            N       |    NOP    |    low    |
>> +	 * |      N            Y       |  high/low |    NOP    |
>> +	 * |      Y            Y       |    high   |    low    |
>> +	 *  ---------------------------------------------------
>> +	 *
>> +	 * But in this function, the crash high memory allocation of
>> +	 * crashkernel=Y,high and the crash low memory allocation of
>> +	 * crashkernel=X[@offset] for crashk_res are mixed at one place.
>> +	 * So the table above need to be adjusted as below:
>> +	 *  ---------------------------------------------------
>> +	 * | DMA enabled | X,high used |  unknown  |   known   |
>> +	 *  ---------------------------------------------------
>> +	 * |      N            N       |    res    |    NOP    |
>> +	 * |      Y            N       |    NOP    |    res    |
>> +	 * |      N            Y       |res/low_res|    NOP    |
>> +	 * |      Y            Y       |    res    |  low_res  |
>> +	 *  ---------------------------------------------------
>> +	 *
>> +	 */
>>  
>>  	/* crashkernel=X[@offset] */
>>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>> @@ -169,10 +198,33 @@ static void __init reserve_crashkernel(int dma_state)
>>  		else if (ret)
>>  			return;
>>  
>> +		/* See the third row of the second table above, NOP */
>> +		if (!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN))
>> +			return;
>> +
>> +		/* See the fourth row of the second table above */
>> +		if (dma_enabled) {
>> +			if (dma_state == DMA_PHYS_LIMIT_UNKNOWN)
>> +				skip_low_res = 1;
>> +			else
>> +				skip_res = 1;
>> +		}
>> +
>>  		crash_max = CRASH_ADDR_HIGH_MAX;
>>  	} else if (ret || !crash_size) {
>>  		/* The specified value is invalid */
>>  		return;
>> +	} else {
>> +		/* See the 1-2 rows of the second table above, NOP */
>> +		if ((!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN)) ||
>> +		     (dma_enabled && (dma_state == DMA_PHYS_LIMIT_UNKNOWN)))
>> +			return;
>> +	}
>> +
>> +	if (skip_res) {
>> +		crash_base = crashk_res.start;
>> +		crash_size = crashk_res.end - crashk_res.start + 1;
>> +		goto check_low;
>>  	}
>>  
>>  	fixed_base = !!crash_base;
>> @@ -202,9 +254,18 @@ static void __init reserve_crashkernel(int dma_state)
>>  		return;
>>  	}
>>  
>> +	crashk_res.start = crash_base;
>> +	crashk_res.end = crash_base + crash_size - 1;
>> +
>> +check_low:
>> +	if (skip_low_res)
>> +		return;
>> +
>>  	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
>>  	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>  		memblock_phys_free(crash_base, crash_size);
>> +		crashk_res.start = 0;
>> +		crashk_res.end = 0;
>>  		return;
>>  	}
>>  
>> @@ -219,8 +280,6 @@ static void __init reserve_crashkernel(int dma_state)
>>  	if (crashk_low_res.end)
>>  		kmemleak_ignore_phys(crashk_low_res.start);
>>  
>> -	crashk_res.start = crash_base;
>> -	crashk_res.end = crash_base + crash_size - 1;
>>  	insert_resource(&iomem_resource, &crashk_res);
>>  }
>>  
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
