Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF34E3650
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiCVB7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiCVB7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:59:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9624B1C2;
        Mon, 21 Mar 2022 18:58:13 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KMvfx3fbrz9ssl;
        Tue, 22 Mar 2022 09:54:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 09:58:12 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 09:58:10 +0800
Subject: Re: [PATCH v21 3/5] arm64: kdump: reimplement crashkernel=X
To:     John Donnelly <John.p.donnelly@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-4-thunder.leizhen@huawei.com>
 <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d2c5f465-6edc-416c-3005-ef13ff3884b0@huawei.com>
Date:   Tue, 22 Mar 2022 09:58:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cc0186d9-29a3-8eff-e38a-95fd4dd9c46f@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2022/3/21 21:29, John Donnelly wrote:
> On 2/26/22 9:07 PM, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
> 
>                         " Not enough "

OK, thanks

>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
> 
>  We can't have a "boot failure". If the requested reservation
>  can not be met,  the kdump  configuration is not setup.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
> 
> Is there going to be documentation on what values certain Arm platforms are going to use this on ?

There is no exact formula.

> 
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   arch/arm64/kernel/machine_kexec.c      |   9 ++-
>>   arch/arm64/kernel/machine_kexec_file.c |  12 ++-
>>   arch/arm64/mm/init.c                   | 106 +++++++++++++++++++++++--
>>   3 files changed, 115 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index e16b248699d5c3c..19c2d487cb08feb 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
>>         /* in reserved memory? */
>>       addr = __pfn_to_phys(pfn);
>> -    if ((addr < crashk_res.start) || (crashk_res.end < addr))
>> -        return false;
>> +    if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
>> +        if (!crashk_low_res.end)
>> +            return false;
>> +
>> +        if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
>> +            return false;
>> +    }
>>         if (!kexec_crash_image)
>>           return true;
>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 59c648d51848886..889951291cc0f9c 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>>         /* Exclude crashkernel region */
>>       ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>> +    if (ret)
>> +        goto out;
>> +
>> +    if (crashk_low_res.end) {
>> +        ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
>> +        if (ret)
>> +            goto out;
>> +    }
>>   -    if (!ret)
>> -        ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
>> +    ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
>>   +out:
>>       kfree(cmem);
>>       return ret;
>>   }
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 90f276d46b93bc6..30ae6638ff54c47 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -65,6 +65,44 @@ EXPORT_SYMBOL(memstart_addr);
>>   phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>     #ifdef CONFIG_KEXEC_CORE
>> +/* Current arm64 boot protocol requires 2MB alignment */
>> +#define CRASH_ALIGN            SZ_2M
>> +
>> +#define CRASH_ADDR_LOW_MAX        arm64_dma_phys_limit
>> +#define CRASH_ADDR_HIGH_MAX        memblock.current_limit
>> +
>> +/*
>> + * This is an empirical value in x86_64 and taken here directly. Please
>> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
>> + * details.
>> + */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE    \
>> +    max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
>> +
>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>> +{
>> +    unsigned long long low_base;
>> +
>> +    /* passed with crashkernel=0,low ? */
>> +    if (!low_size)
>> +        return 0;
>> +
>> +    low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
>> +    if (!low_base) {
>> +        pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
>> +        low_base, low_base + low_size, low_size >> 20);
>> +
>> +    crashk_low_res.start = low_base;
>> +    crashk_low_res.end   = low_base + low_size - 1;
>> +    insert_resource(&iomem_resource, &crashk_low_res);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * reserve_crashkernel() - reserves memory for crash kernel
>>    *
>> @@ -75,30 +113,79 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>   static void __init reserve_crashkernel(void)
>>   {
>>       unsigned long long crash_base, crash_size;
>> -    unsigned long long crash_max = arm64_dma_phys_limit;
>> +    unsigned long long crash_low_size;
>> +    unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>>       int ret;
>> +    bool fixed_base, high = false;
>> +    char *cmdline = boot_command_line;
>>   -    ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +    /* crashkernel=X[@offset] */
>> +    ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>                   &crash_size, &crash_base);
>> -    /* no crashkernel= or invalid value specified */
>> -    if (ret || !crash_size)
>> -        return;
>> +    if (ret || !crash_size) {
>> +        /* crashkernel=X,high */
>> +        ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +        if (ret || !crash_size)
>> +            return;
>> +
>> +        /* crashkernel=Y,low */
>> +        ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> +        if (ret == -ENOENT)
>> +            /*
>> +             * crashkernel=Y,low is not specified explicitly, use
>> +             * default size automatically.
>> +             */
>> +            crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +        else if (ret)
>> +            /* crashkernel=Y,low is specified but Y is invalid */
>> +            return;
>> +
>> +        /* Mark crashkernel=X,high is specified */
>> +        high = true;
>> +        crash_max = CRASH_ADDR_HIGH_MAX;
>> +    }
>>   +    fixed_base = !!crash_base;
>>       crash_size = PAGE_ALIGN(crash_size);
>>         /* User specifies base address explicitly. */
>> -    if (crash_base)
>> +    if (fixed_base)
>>           crash_max = crash_base + crash_size;
>>   -    /* Current arm64 boot protocol requires 2MB alignment */
>> -    crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
>> +retry:
>> +    crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>>                              crash_base, crash_max);
>>       if (!crash_base) {
>> +        /*
>> +         * Attempt to fully allocate low memory failed, fall back
>> +         * to high memory, the minimum required low memory will be
>> +         * reserved later.
>> +         */
>> +        if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
>> +            crash_max = CRASH_ADDR_HIGH_MAX;
>> +            goto retry;
>> +        }
>> +
>>           pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>>               crash_size);
>>           return;
>>       }
>>   +    if (crash_base >= SZ_4G) {
>> +        /*
>> +         * For case crashkernel=X, low memory is not enough and fall
>> +         * back to reserve specified size of memory above 4G, try to
>> +         * allocate minimum required memory below 4G again.
>> +         */
>> +        if (!high)
>> +            crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +
>> +        if (reserve_crashkernel_low(crash_low_size)) {
>> +            memblock_phys_free(crash_base, crash_size);
>> +            return;
>> +        }
>> +    }
>> +
>>       pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>>           crash_base, crash_base + crash_size, crash_size >> 20);
>>   @@ -107,6 +194,9 @@ static void __init reserve_crashkernel(void)
>>        * map. Inform kmemleak so that it won't try to access it.
>>        */
>>       kmemleak_ignore_phys(crash_base);
>> +    if (crashk_low_res.end)
>> +        kmemleak_ignore_phys(crashk_low_res.start);
>> +
>>       crashk_res.start = crash_base;
>>       crashk_res.end = crash_base + crash_size - 1;
>>       insert_resource(&iomem_resource, &crashk_res);
> 
> .
> 

-- 
Regards,
  Zhen Lei
