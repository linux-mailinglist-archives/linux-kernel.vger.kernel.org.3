Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518451B5AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiEECRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEECRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:17:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5AF473A8;
        Wed,  4 May 2022 19:13:34 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ktxxj04q0zGpXB;
        Thu,  5 May 2022 10:10:49 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:13:32 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 10:13:31 +0800
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
References: <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com> <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com> <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com> <YnGmCwaWkvCrJoU2@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2b48d210-855b-fbf1-e2b9-3ed0b42bcd22@huawei.com>
Date:   Thu, 5 May 2022 10:13:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YnGmCwaWkvCrJoU2@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/4 6:00, Catalin Marinas wrote:
> On Fri, Apr 29, 2022 at 04:25:37PM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/4/29 16:02, Leizhen (ThunderTown) wrote:
>>> On 2022/4/29 11:24, Baoquan He wrote:
>>>> On 04/28/22 at 05:33pm, Leizhen (ThunderTown) wrote:
>>>>> On 2022/4/28 11:52, Baoquan He wrote:
>>>>>> On 04/28/22 at 11:40am, Baoquan He wrote:
>>>>>>> On 04/27/22 at 05:04pm, Catalin Marinas wrote:
>>>>>>>> There will be some difference as the 4G limit doesn't always hold for
>>>>>>>> arm64 (though it's true in most cases). Anyway, we can probably simplify
>>>>>>>> things a bit while following the documented behaviour:
>>>>>>>>
>>>>>>>> 	crashkernel=Y		- current behaviour within ZONE_DMA
>>>>>>>> 	crashkernel=Y,high	- allocate from above ZONE_DMA
>>>>>>>> 	crashkernel=Y,low	- allocate within ZONE_DMA
> [...]
>>>>>>> Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
>>>>>>> about this version. And I have the same concerns about them which comes
>>>>>>> from below points:
>>>>>>> 1) we may need to take best effort to keep ,high, ,low behaviour
>>>>>>> consistent on all ARCHes. Otherwise user/admin may be confused when they
>>>>>>> deploy/configure kdump on different machines of different ARCHes in the
>>>>>>> same LAB. I think we should try to avoid the confusion.
> 
> I guess by all arches you mean just x86 here. Since the code is not
> generic, all arches do their own stuff.
> 
>>> OK, I plan to remove optimization, fallback and default low size, to follow the
>>> suggestion of Catalin first. But there's one minor point of contention.
>>>
>>> 1)    Both "crashkernel=X,high" and "crashkernel=X,low" must be present.
>>> 2)    Both "crashkernel=X,high" and "crashkernel=X,low" are present.
>>>    or
>>>       Allow "crashkernel=X,high" to be present alone. Unlike x86, the default low size is zero.
>>>
>>> I prefer 2), how about you?
> 
> (2) works for me as well. We keep these simple as "expert" options and

Okay, so I'll follow 2) to update the code.

> allow crashkernel= to fall back to 'high' if not sufficient memory in
> ZONE_DMA. That would be a slight change from the current behaviour but,
> as Zhen Lei said, with the old tools it's just moving the error around,
> the crashkernel wouldn't be available in either case.
> 
>>>>>>> 2) Fallback behaviour is important to our distros. The reason is we will
>>>>>>> provide default value with crashkernel=xxxM along kernel of distros. In
>>>>>>> this case, we hope the reservation will succeed by all means. The ,high
>>>>>>> and ,low is an option if customer likes to take with expertise.
> 
> OK, that's good feedback.
> 
> So, to recap, IIUC you are fine with:
> 
> 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> 				  above with a default in ZONE_DMA (like
> 				  x86, 256M or swiotlb size)
> 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
> 'crashkernel' overrides the high and low while the latter two can be
> passed independently.
> 
>>>>>>> After going through arm64 memory init code, I got below summary about
>>>>>>> arm64_dma_phys_limit which is the first zone's upper limit. I think we
>>>>>>> can make use of it to facilitate to simplify code.
>>>>>>> ================================================================================
>>>>>>>                         DMA                      DMA32                    NORMAL
>>>>>>> 1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
>>>>>>> 2)Normal machine        0~4G                     0                        (above 4G)
>>>>>>> 3)Special machine       (above 4G)~MAX
>>>>>>> 4)No DMA|DMA32                                                            (above 4G)~MAX
>>>>>
>>>>> arm64_memblock_init()
>>>>> 	reserve_crashkernel()        ---------------   0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
>>>> We don't need different code for this place of reservation as you are
>>>> doing in this patchset, since arm64_dma_phys_limit is initialized as 
>>>> below. In fact, in arm64_memblock_init(), we have made memblock ready,
>>>> we can initialize arm64_dma_phys_limit as memblock_end_of_DRAM(). And if
>>>> memblock_start_of_DRAM() is bigger than 4G, we possibly can call
>>>> reserve_crashkernel() here too.
>>>
>>> Yes. Maybe all the devices in this environment are 64-bit. One way I
>>> know of allowing 32-bit devices to access high memory without SMMU
>>> is: Set a fixed value for the upper 32 bits. In this case, the DMA
>>> zone should be [phys_start, phys_start + 4G).
> 
> We decided that this case doesn't really exists for arm64 platforms (no
> need for special ZONE_DMA).
> 
>> I just read the message of commit 791ab8b2e3 ("arm64: Ignore any DMA
>> offsets in the max_zone_phys() calculation")
>>
>>     Currently, the kernel assumes that if RAM starts above 32-bit (or
>>     zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
>>     such constrained devices have a hardwired DMA offset. In practice, we
>>     haven't noticed any such hardware so let's assume that we can expand
>>     ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
>>     ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
>>     zone_bits.
> 
> I think the above log is slightly confusing. If the DRAM starts above
> 4G, ZONE_DMA goes to the end of DRAM. If the DRAM starts below 4G but
> above the zone_bits for ZONE_DMA as specified in DT/ACPI, it pushes
> ZONE_DMA to 4G. I don't remember why we did this last part, maybe in
> case we get incorrect firmware tables, otherwise we could have extended
> ZONE_DMA to end of DRAM.
> 
> Zhen Lei, if we agreed on the crashkernel behaviour, could you please
> post a series that does the above parsing allocation? Ignore the
> optimisations, we can look at them afterwards.

OK, I've changed the code before the festival, and I'll test it today.

> 
> Thanks.
> 

-- 
Regards,
  Zhen Lei
