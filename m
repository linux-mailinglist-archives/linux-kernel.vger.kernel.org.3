Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6248E513027
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiD1JuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348113AbiD1Jgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:36:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C895486;
        Thu, 28 Apr 2022 02:33:37 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kpr4l4pn6zfb5X;
        Thu, 28 Apr 2022 17:32:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:33:35 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:33:34 +0800
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com> <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com> <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com> <YmlphvZVMsGfFksp@arm.com>
 <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv> <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
Date:   Thu, 28 Apr 2022 17:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/28 11:52, Baoquan He wrote:
> On 04/28/22 at 11:40am, Baoquan He wrote:
>> Hi Catalin, Zhen Lei,
>>
>> On 04/27/22 at 05:04pm, Catalin Marinas wrote:
>>> On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
>>>> On 2022/4/27 20:32, Catalin Marinas wrote:
>>>>> I think one could always pass a default command line like:
>>>>>
>>>>> 	crashkernel=1G,high crashkernel=128M,low
>>>>>
>>>>> without much knowledge of the SoC memory layout.
>>>>
>>>> Yes, that's what the end result is. The user specify crashkernel=128M,low
>>>> and the implementation ensure the 128M low memory is allocated from DMA zone.
>>>> We use arm64_dma_phys_limit as the upper limit for crash low memory.
>>>>
>>>> +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
>>>> +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>>> +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>>>                                                crash_base, crash_max);
>>>>
>>>>> Another option is to only introduce crashkernel=Y,low and, when that is
>>>>> passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
>>>>> 'high' option at all:
>>>>>
>>>>> 	crashkernel=1G				- all within ZONE_DMA
>>>>> 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
>>>>> 						  1G above ZONE_DMA
>>>>>
>>>>> If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
>>>>> the 'low' option.
>>>>
>>>> I think although the code is hard to make generic, the interface is better to
>>>> be relatively uniform. A user might have to maintain both x86 and arm64, and
>>>> so on. It's not a good thing that the difference is too big.
>>>
>>> There will be some difference as the 4G limit doesn't always hold for
>>> arm64 (though it's true in most cases). Anyway, we can probably simplify
>>> things a bit while following the documented behaviour:
>>>
>>> 	crashkernel=Y		- current behaviour within ZONE_DMA
>>> 	crashkernel=Y,high	- allocate from above ZONE_DMA
>>> 	crashkernel=Y,low	- allocate within ZONE_DMA
>>>
>>> There is no fallback from crashkernel=Y.
>>>
>>> The question is whether we still want a default low allocation if
>>> crashkernel=Y,low is missing but 'high' is present. If we add this, I
>>> think we'd be consistent with kernel-parameters.txt for the 'low'
>>> description. A default 'low' is probably not that bad but I'm tempted to
>>> always mandate both 'high' and 'low'.
>>
>> Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
>> about this version. And I have the same concerns about them which comes
>> from below points:
>> 1) we may need to take best effort to keep ,high, ,low behaviour
>> consistent on all ARCHes. Otherwise user/admin may be confused when they
>> deploy/configure kdump on different machines of different ARCHes in the
>> same LAB. I think we should try to avoid the confusion.

Yes, but for someone who is configuring crashkernel= for the first time, he
needs to read doc to understand how to configure it. The doc can show the
recommended default value of 'low' size.

After commit 94fb93341822 ("x86/crash: Allocate enough low memory when crashkernel=high"),
the default 'low' size doesn't make much sense anymore. The default size of swiotlb_size()
is 64M, far less than 256M. And if user specify "swiotlb=", he can also adjust crashkernel=Y,low.


+                * -swiotlb size: user-specified with swiotlb= or default.
-               low_size = swiotlb_size_or_default() + (8UL<<20);
+               low_size = max(swiotlb_size_or_default() + (8UL<<20), 256UL<<20);

That means all ARCHs can explicit configure crashkernel=256M,low, instead of
omitting it. This may be another way to avoid confusion. It's not hard for
programmer-turned-user/admin. However, this requires us to forgo backward
compatibility with the default size of 'low'.


>> 2) Fallback behaviour is important to our distros. The reason is we will
>> provide default value with crashkernel=xxxM along kernel of distros. In
>> this case, we hope the reservation will succeed by all means. The ,high
>> and ,low is an option if customer likes to take with expertise.

OK, I got it.

>>
>> After going through arm64 memory init code, I got below summary about
>> arm64_dma_phys_limit which is the first zone's upper limit. I think we
>> can make use of it to facilitate to simplify code.
>> ================================================================================
>>                         DMA                      DMA32                    NORMAL
>> 1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
>> 2)Normal machine        0~4G                     0                        (above 4G)
>> 3)Special machine       (above 4G)~MAX
>> 4)No DMA|DMA32                                                            (above 4G)~MAX

arm64_memblock_init()
	reserve_crashkernel()        ---------------   0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
paging_init()                                       |
	map_mem()                                   |
unflatten_device_tree or ACPI                       |  ----  //Raspberry Pi4 get dma zone base on dtb or ACPI
bootmem_init();                                     |      |
	zone_sizes_init()                           |      |
		of_dma_get_max_cpu_address          |  ----|
		//Update arm64_dma_phys_limit       |  ----|
	reserve_crashkernel()        <--------------  //Because we need arm64_dma_phys_limit to be updated above
request_standard_resources()

>>
>> -------------------------------------------
>>                       arm64_dma_phys_limit
>> 1)Raspberry Pi4         1G                     
>> 2)Normal machine        4G                     
>> 3)Special machine       MAX
>> 4)No DMA|DMA32          MAX
>>
>> Note: 3)Special machine means the machine's starting physical address is above 4G.
>> WHile 4)No DMA|DMA32 means kernel w/o CONFIG_ZONE_DMA|DMA32, and has
>> IOMMU hardware supporting.
>> ===================================================================================
>>
>> I made a draft patch based on this patchset, please feel free to check and
>> see if it's OK, or anything missing or wrongly understood. I removed
>> reserve_crashkernel_high() and only keep reserve_crashkernel() and
>> reserve_crashkernel_low() as the v21 did.
> 
> Sorry, forgot attaching the draft patch.
> 
> By the way, we can also have a simple version with basic ,high, ,low
> support, no fallback. We can add fallback and other optimization later.
> This can be plan B.

Yes, That's what Catalin suggested also.

Hi, Baoquan He:
  Without optimization, the whole Patch 3-4 and 6-7 can be dropped.

Process after abstraction:
	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
		reserve_crashkernel()
		//block mapping
	} else {
		//page mapping
		reserve_crashkernel()
	}

------------ Simplified real-world process ---------
arm64_memblock_init()
	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
		reserve_crashkernel()
paging_init()
	map_mem()
		if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
			//block mapping
		else
			//page mapping
unflatten_device_tree or ACPI
bootmem_init();
	zone_sizes_init()
		of_dma_get_max_cpu_address
		//Update arm64_dma_phys_limit
	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
		reserve_crashkernel()


> 
> 

-- 
Regards,
  Zhen Lei
