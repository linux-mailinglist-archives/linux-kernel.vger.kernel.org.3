Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1044DC028
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCQHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:31:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA8E1C16E5;
        Thu, 17 Mar 2022 00:30:08 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KJzGJ6mJxz9sfZ;
        Thu, 17 Mar 2022 15:26:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:30:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:30:04 +0800
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
To:     Baoquan He <bhe@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <YjHUAi0xrUy+qk/L@MiWiFi-R3L-srv>
 <7d7a3e70-6a46-b722-ef48-7206a47185dd@huawei.com>
 <YjKeuFGtjI7944uy@MiWiFi-R3L-srv>
 <05a96786-cfe8-029f-f29a-60fb94129f91@huawei.com>
 <YjKvUz+dKRkyxUAd@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <eb26c623-6c7b-c3ba-acc8-654023ddd82b@huawei.com>
Date:   Thu, 17 Mar 2022 15:30:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YjKvUz+dKRkyxUAd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/17 11:47, Baoquan He wrote:
> On 03/17/22 at 11:19am, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2022/3/17 10:36, Baoquan He wrote:
>>> On 03/16/22 at 09:11pm, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2022/3/16 20:11, Baoquan He wrote:
>>>>> On 02/27/22 at 11:07am, Zhen Lei wrote:
>>> ...... 
>>>
>>>>> Hi leizhen,
>>>>>
>>>>> I made change on reserve_crashkenrel(), inline comment may be slow.
>>>>> Please check and consider if they can be taken.
>>>>
>>>> That's great. Thank you very much.
>>>>
>>>>>
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index 30ae6638ff54..f96351da1e3e 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -109,38 +109,43 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>>>>>   * This function reserves memory area given in "crashkernel=" kernel command
>>>>>   * line parameter. The memory reserved is used by dump capture kernel when
>>>>>   * primary kernel is crashing.
>>>>> + *
>>>>> + * NOTE: Reservation of crashkernel,low is special since its existence
>>>>> + * is not independent, need rely on the existence of crashkernel,high.
>>>>> + * Hence there are different cases for crashkernel,low reservation:
>>>
>>> Considering to update the 3rd line as below:
>>>
>>>  * NOTE: Reservation of crashkernel,low is special since its existence
>>>  * is not independent, need rely on the existence of crashkernel,high.
>>>  * Here, four cases of crashkernel,low reservation are summarized: 
>>
>> OK. How about change "crashkernel,low" to "crashkernel low memory"?
>> "crashkernel=Y,low", "crashkernel=,low" and "crashkernel,low" are very similar,
>> may dazzle the reader.
> 
> Fine by me. 'crashkernel low memory' is formal, just make sentence a
> little longer. Please take what you think fitter.

OK, I will send v22 after v5.18-rc1.

> 
>>
>>>
>>>>> + * 1) crashkernel=Y,low is specified explicitly, crashkernel,low takes Y;
>>>>> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
>>>>> + *    take the default crashkernel,low value;
>>>>> + * 3) crashkernel=X is specified, while fallback to get a memory region
>>>>> + *    in high memory, take the default crashkernel,low value;
>>>>> + * 4) crashkernel='invalid value',low is specified, failed the whole
>>>>> + *    crashkernel reservation and bail out.
>>>>>   */
>>>>>  static void __init reserve_crashkernel(void)
>>>>>  {
>>>>>  	unsigned long long crash_base, crash_size;
>>>>>  	unsigned long long crash_low_size;
>>>>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>>>> -	int ret;
>>>>>  	bool fixed_base, high = false;
>>>>>  	char *cmdline = boot_command_line;
>>>>> +	int ret;
>>>>>  
>>>>>  	/* crashkernel=X[@offset] */
>>>>>  	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>>>  				&crash_size, &crash_base);
>>>>>  	if (ret || !crash_size) {
>>>>> -		/* crashkernel=X,high */
>>>>>  		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>>>>>  		if (ret || !crash_size)
>>>>>  			return;
>>>>>  
>>>>> -		/* crashkernel=Y,low */
>>>>>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>>>>>  		if (ret == -ENOENT)
>>>>> -			/*
>>>>> -			 * crashkernel=Y,low is not specified explicitly, use
>>>>> -			 * default size automatically.
>>>>> -			 */
>>>>> +			/* case #2 of crashkernel,low reservation */
>>>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>  		else if (ret)
>>>>> -			/* crashkernel=Y,low is specified but Y is invalid */
>>>>> +			/* case #4 of crashkernel,low reservation */
>>>>>  			return;
>>>>>  
>>>>> -		/* Mark crashkernel=X,high is specified */
>>>>>  		high = true;
>>>>>  		crash_max = CRASH_ADDR_HIGH_MAX;
>>>>>  	}
>>>>> @@ -148,7 +153,6 @@ static void __init reserve_crashkernel(void)
>>>>>  	fixed_base = !!crash_base;
>>>>>  	crash_size = PAGE_ALIGN(crash_size);
>>>>>  
>>>>> -	/* User specifies base address explicitly. */
>>>>>  	if (fixed_base)
>>>>>  		crash_max = crash_base + crash_size;
>>>>>  
>>>>> @@ -172,11 +176,7 @@ static void __init reserve_crashkernel(void)
>>>>>  	}
>>>>>  
>>>>>  	if (crash_base >= SZ_4G) {
>>>>> -		/*
>>>>> -		 * For case crashkernel=X, low memory is not enough and fall
>>>>> -		 * back to reserve specified size of memory above 4G, try to
>>>>> -		 * allocate minimum required memory below 4G again.
>>>>> -		 */
>>>>> +		/* case #3 of crashkernel,low reservation */
>>>>>  		if (!high)
>>>>>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>  
>>>>>
>>>>>>  
>>>>>> -	/* Current arm64 boot protocol requires 2MB alignment */
>>>>>> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>>>>>> +retry:
>>>>>> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>>>>>  					       crash_base, crash_max);
>>>>>>  	if (!crash_base) {
>>>>>> +		/*
>>>>>> +		 * Attempt to fully allocate low memory failed, fall back
>>>>>> +		 * to high memory, the minimum required low memory will be
>>>>>> +		 * reserved later.
>>>>>> +		 */
>>>>>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>>>>>> +			crash_max = CRASH_ADDR_HIGH_MAX;
>>>>>> +			goto retry;
>>>>>> +		}
>>>>>> +
>>>>>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>>>>>  			crash_size);
>>>>>>  		return;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (crash_base >= SZ_4G) {
>>>>>> +		/*
>>>>>> +		 * For case crashkernel=X, low memory is not enough and fall
>>>>>> +		 * back to reserve specified size of memory above 4G, try to
>>>>>> +		 * allocate minimum required memory below 4G again.
>>>>>> +		 */
>>>>>> +		if (!high)
>>>>>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>>>>> +
>>>>>> +		if (reserve_crashkernel_low(crash_low_size)) {
>>>>>> +			memblock_phys_free(crash_base, crash_size);
>>>>>> +			return;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>>>>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>>>>>  
>>>>>> @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
>>>>>>  	 * map. Inform kmemleak so that it won't try to access it.
>>>>>>  	 */
>>>>>>  	kmemleak_ignore_phys(crash_base);
>>>>>> +	if (crashk_low_res.end)
>>>>>> +		kmemleak_ignore_phys(crashk_low_res.start);
>>>>>> +
>>>>>>  	crashk_res.start = crash_base;
>>>>>>  	crashk_res.end = crash_base + crash_size - 1;
>>>>>>  	insert_resource(&iomem_resource, &crashk_res);
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>> -- 
>>>> Regards,
>>>>   Zhen Lei
>>>>
>>>
>>> .
>>>
>>
>> -- 
>> Regards,
>>   Zhen Lei
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
