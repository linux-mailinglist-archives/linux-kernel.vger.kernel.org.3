Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4F648D00F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiAMBRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:17:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16706 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAMBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:17:42 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZ5zv0ktWzZfB8;
        Thu, 13 Jan 2022 09:14:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:17:40 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:17:39 +0800
Subject: Re: [PATCH v19 11/13] arm64: kdump: reimplement crashkernel=X
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
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
        John Donnelly <John.p.donnelly@oracle.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-12-thunder.leizhen@huawei.com>
 <e48ac849-cc3d-3c0b-e159-7408af61eece@oracle.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6bcea8a4-c244-bb0c-ff55-92cbe463b4cc@huawei.com>
Date:   Thu, 13 Jan 2022 09:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e48ac849-cc3d-3c0b-e159-7408af61eece@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/12 22:45, Dave Kleikamp wrote:
> On 12/28/21 7:26AM, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> There are following issues in arm64 kdump:
>> 1. We use crashkernel=X to reserve crashkernel below 4G, which
>> will fail when there is no enough low memory.
>> 2. If reserving crashkernel above 4G, in this case, crash dump
>> kernel will boot failure because there is no low memory available
>> for allocation.
>>
>> To solve these issues, change the behavior of crashkernel=X and
>> introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
>> in DMA zone, and fall back to high allocation if it fails.
>> We can also use "crashkernel=X,high" to select a region above DMA zone,
>> which also tries to allocate at least 256M in DMA zone automatically.
>> "crashkernel=Y,low" can be used to allocate specified size low memory.
>>
>> Another minor change, there may be two regions reserved for crash
>> dump kernel, in order to distinct from the high region and make no
>> effect to the use of existing kexec-tools, rename the low region as
>> "Crash kernel (low)".
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   arch/arm64/kernel/machine_kexec.c      |  5 +++-
>>   arch/arm64/kernel/machine_kexec_file.c | 12 ++++++--
>>   arch/arm64/kernel/setup.c              | 13 +++++++-
>>   arch/arm64/mm/init.c                   | 41 ++++++++++----------------
>>   4 files changed, 42 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
>> index 6fb31c117ebe08c..6665bf31f6b6a19 100644
>> --- a/arch/arm64/kernel/machine_kexec.c
>> +++ b/arch/arm64/kernel/machine_kexec.c
>> @@ -327,7 +327,10 @@ bool crash_is_nosave(unsigned long pfn)
>>         /* in reserved memory? */
>>       addr = __pfn_to_phys(pfn);
>> -    if ((addr < crashk_res.start) || (crashk_res.end < addr))
>> +    if (((addr < crashk_res.start) || (crashk_res.end < addr)) && !crashk_low_res.end)
>> +        return false;
>> +
>> +    if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
>>           return false;
>>         if (!kexec_crash_image)
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
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index be5f85b0a24de69..4bb2e55366be64d 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -248,7 +248,18 @@ static void __init request_standard_resources(void)
>>               kernel_data.end <= res->end)
>>               request_resource(res, &kernel_data);
>>   #ifdef CONFIG_KEXEC_CORE
>> -        /* Userspace will find "Crash kernel" region in /proc/iomem. */
>> +        /*
>> +         * Userspace will find "Crash kernel" or "Crash kernel (low)"
>> +         * region in /proc/iomem.
>> +         * In order to distinct from the high region and make no effect
>> +         * to the use of existing kexec-tools, rename the low region as
>> +         * "Crash kernel (low)".
>> +         */
>> +        if (crashk_low_res.end && crashk_low_res.start >= res->start &&
>> +                crashk_low_res.end <= res->end) {
>> +            crashk_low_res.name = "Crash kernel (low)";
>> +            request_resource(res, &crashk_low_res);
>> +        }
>>           if (crashk_res.end && crashk_res.start >= res->start &&
>>               crashk_res.end <= res->end)
>>               request_resource(res, &crashk_res);
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index be4595dc7459115..91b8038a1529068 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -74,41 +74,32 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>    */
>>   static void __init reserve_crashkernel(void)
>>   {
>> -    unsigned long long crash_base, crash_size;
>> -    unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>> +    unsigned long long crash_size, crash_base, total_mem, low_size;
> 
> low_size needs to be initialized to -1.
> 
> If parse_crashkernel() succeeds, then an uninitialized low_size will be passed to reserve_crashkernel_mem().

Right, thanks, I noticed that too. I'm waiting for v5.17-rc1 to release v20.

In addition, I found that the current implementation on x86 was problematic in case
"crashkernel=4G crashkernel=512M,low". According to the document, "crashkernel=512M,low"
should not take effect at this case. But reserve_crashkernel_low() didn't do that well.

> 
>> +    bool high = false;
>>       int ret;
>>   -    ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> -                &crash_size, &crash_base);
>> -    /* no crashkernel= or invalid value specified */
>> -    if (ret || !crash_size)
>> -        return;
>> -
>> -    crash_size = PAGE_ALIGN(crash_size);
>> -
>> -    /* User specifies base address explicitly. */
>> -    if (crash_base)
>> -        crash_max = crash_base + crash_size;
>> +    total_mem = memblock_phys_mem_size();
>>   -    /* Current arm64 boot protocol requires 2MB alignment */
>> -    crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>> -                           crash_base, crash_max);
>> -    if (!crash_base) {
>> -        pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> -            crash_size);
>> -        return;
>> +    ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>> +    if (ret != 0 || crash_size <= 0) {
>> +        /* crashkernel=X,high and possible crashkernel=Y,low */
>> +        ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
>> +        if (ret)
>> +            return;
>> +        high = true;
>>       }
>>   -    pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>> -        crash_base, crash_base + crash_size, crash_size >> 20);
>> +    ret = reserve_crashkernel_mem(total_mem, crash_size, crash_base, low_size, high);
>> +    if (ret)
>> +        return;
>>         /*
>>        * The crashkernel memory will be removed from the kernel linear
>>        * map. Inform kmemleak so that it won't try to access it.
>>        */
>> -    kmemleak_ignore_phys(crash_base);
>> -    crashk_res.start = crash_base;
>> -    crashk_res.end = crash_base + crash_size - 1;
>> +    kmemleak_ignore_phys(crashk_res.start);
>> +    if (crashk_low_res.end)
>> +        kmemleak_ignore_phys(crashk_low_res.start);
>>   }
>>   #else
>>   static void __init reserve_crashkernel(void)
> 
> .
> 

-- 
Regards,
  Zhen Lei
