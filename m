Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057CA4B2390
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbiBKKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:42:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiBKKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:42:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518AD44;
        Fri, 11 Feb 2022 02:42:06 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jw9Bj5QMdzbkGg;
        Fri, 11 Feb 2022 18:41:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 18:42:04 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 18:42:03 +0800
Subject: Re: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
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
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-4-thunder.leizhen@huawei.com>
 <YgY6yvX7PEeZpdTr@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6ac0c60c-78bc-9789-9f5c-659fb5fa3e9a@huawei.com>
Date:   Fri, 11 Feb 2022 18:41:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YgY6yvX7PEeZpdTr@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2022/2/11 18:30, Baoquan He wrote:
> On 01/24/22 at 04:47pm, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
> ......
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 6c653a2c7cff052..a5d43feac0d7d96 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
>>  #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
>>  
>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>> +{
>> +	unsigned long long low_base;
>> +
>> +	/* passed with crashkernel=0,low ? */
>> +	if (!low_size)
>> +		return 0;
>> +
>> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
>> +	if (!low_base) {
>> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
>> +		low_base, low_base + low_size, low_size >> 20);
>> +
>> +	crashk_low_res.start = low_base;
>> +	crashk_low_res.end   = low_base + low_size - 1;
>> +	insert_resource(&iomem_resource, &crashk_low_res);
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * reserve_crashkernel() - reserves memory for crash kernel
>>   *
>> @@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>  static void __init reserve_crashkernel(void)
>>  {
>>  	unsigned long long crash_base, crash_size;
>> +	unsigned long long crash_low_size = SZ_256M;
>>  	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>  	int ret;
>> +	bool fixed_base;
>> +	char *cmdline = boot_command_line;
>>  
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +	/* crashkernel=X[@offset] */
>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>  				&crash_size, &crash_base);
>> -	/* no crashkernel= or invalid value specified */
>> -	if (ret || !crash_size)
>> -		return;
>> +	if (ret || !crash_size) {
>> +		unsigned long long low_size;
>>  
>> +		/* crashkernel=X,high */
>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/* crashkernel=X,low */
>> +		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
>> +		if (!ret)
>> +			crash_low_size = low_size;
> 
> Here, the error case is not checked and handled. But it still gets
> expeced result which is the default SZ_256M. Is this designed on
> purpose?

Yes, we can specify only "crashkernel=X,high".

This is mentioned in Documentation/admin-guide/kernel-parameters.txt

        crashkernel=size[KMG],low
                        [KNL, X86-64] range under 4G. When crashkernel=X,high
                        is passed, kernel could allocate physical memory region
                        above 4G, that cause second kernel crash on system
                        that require some amount of low memory, e.g. swiotlb
                        requires at least 64M+32K low memory, also enough extra
                        low memory is needed to make sure DMA buffers for 32-bit
                        devices won't run out. Kernel would try to allocate at     <---------
                        least 256M below 4G automatically.                         <---------

> 
>> +
>> +		crash_max = CRASH_ADDR_HIGH_MAX;
>> +	}
>> +
>> +	fixed_base = !!crash_base;
>>  	crash_size = PAGE_ALIGN(crash_size);
>>  
>>  	/* User specifies base address explicitly. */
>>  	if (crash_base)
>>  		crash_max = crash_base + crash_size;
>>  
>> +retry:
>>  	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>  					       crash_base, crash_max);
>>  	if (!crash_base) {
>> +		/*
>> +		 * Attempt to fully allocate low memory failed, fall back
>> +		 * to high memory, the minimum required low memory will be
>> +		 * reserved later.
>> +		 */
>> +		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>> +			crash_max = CRASH_ADDR_HIGH_MAX;
>> +			goto retry;
>> +		}
>> +
>>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>  			crash_size);
>>  		return;
>>  	}
>>  
>> +	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>> +	}
>> +
>>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>  		crash_base, crash_base + crash_size, crash_size >> 20);
>>  
>> @@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
>>  	 * map. Inform kmemleak so that it won't try to access it.
>>  	 */
>>  	kmemleak_ignore_phys(crash_base);
>> +	if (crashk_low_res.end)
>> +		kmemleak_ignore_phys(crashk_low_res.start);
>> +
>>  	crashk_res.start = crash_base;
>>  	crashk_res.end = crash_base + crash_size - 1;
>>  	insert_resource(&iomem_resource, &crashk_res);
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
