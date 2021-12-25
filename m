Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507D847F2E7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhLYKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:17:00 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16862 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhLYKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:17:00 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JLfw431BRz90Jk;
        Sat, 25 Dec 2021 18:16:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 18:16:57 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 18:16:56 +0800
Subject: Re: [PATCH v18 02/17] x86/setup: Move xen_pv_domain() check and
 insert_resource() to setup_arch()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
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
        "John Donnelly" <John.p.donnelly@oracle.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-3-thunder.leizhen@huawei.com> <YcSxLodOnxXHx0sV@zn.tnic>
 <d6226aa2-f1f2-24cc-c9d2-9762bd615686@huawei.com>
 <5d8aed79-b20f-2575-3c3f-8945d8cbac3f@huawei.com>
Message-ID: <aaa219c5-aca6-adb5-58d8-365693be249c@huawei.com>
Date:   Sat, 25 Dec 2021 18:16:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5d8aed79-b20f-2575-3c3f-8945d8cbac3f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/25 9:53, Leizhen (ThunderTown) wrote:
>>> This is exactly why I say that making those functions generic and shared
>>> might not be such a good idea, after all, because then you'd have to
>>> sprinkle around arch-specific stuff.

Hi Borislav and all:
  Merry Christmas!

  I have a new idea now. It helps us get around all the arguments and
minimizes changes to the x86 (also to arm64).
  Previously, Chen Zhou and I tried to share the entire function
reserve_crashkernel(), which led to the following series of problems:
1. reserve_crashkernel() is also defined on other architectures, so we should
   add build option ARCH_WANT_RESERVE_CRASH_KERNEL to avoid conflicts.
2. Move xen_pv_domain() check out of reserve_crashkernel().
3. Move insert_resource() out of reserve_crashkernel()

Others:
4. start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
                                                  crash_base + crash_size);
   Change SZ_1M to CRASH_ALIGN, or keep it no change.
   The current conclusion is no change. But I think adding a new macro
   CRASH_FIXED_ALIGN is also a way. 2M alignment allows page tables to
   use block mappings for most architectures.
5. if (crash_base >= (1ULL << 32) && reserve_crashkernel_low())
   Change (1ULL << 32) to CRASH_ADDR_LOW_MAX, or keep it no change.
   I reanalyzed it, and this doesn't need to be changed.

So for 1-3，why not add a new function reserve_crashkernel_mem() and rename
reserve_crashkernel_low() to reserve_crashkernel_mem_low().
On x86:
static void __init reserve_crashkernel(void)
{
	//Parse all "crashkernel=" configurations in priority order until
        //a valid combination is found. Or return upon failure.
	
	if (xen_pv_domain()) {
                pr_info("Ignoring crashkernel for a Xen PV domain\n");
                return;
        }

	//Call reserve_crashkernel_mem() to reserve crashkernel memory, it will
	//call reserve_crashkernel_mem_low() if needed.

	if (crashk_low_res.end)
		insert_resource(&iomem_resource, &crashk_low_res);
	insert_resource(&iomem_resource, &crashk_res);
}

On arm64:
static void __init reserve_crashkernel(void)
{
	//Parse all "crashkernel=" configurations in priority order until
        //a valid combination is found. Or return upon failure.
	
	//Call reserve_crashkernel_mem() to reserve crashkernel memory, it will
	//call reserve_crashkernel_mem_low() if needed.
}


1. reserve_crashkernel() is still static, so that there is no
   need to add ARCH_WANT_RESERVE_CRASH_KERNEL.
2. The xen_pv_domain() check have not been affected in any way.
   Hi Borislav:
     As you mentioned, this check may also be needed on arm64. But it may be
   better not to add it until the problem is actually triggered on arm64.
3. insert_resource() is not moved outside reserve_crashkernel() on x86.
   Hi Borislav:
     Currently, I haven't figured out why request_resource() can't be replaced
   with insert_resource() on arm64. But I have a hunch that the kexec tool may
   be involved. The cost of modification on arm64 is definitely higher than that
   on x86. Other architectures that want to use reserve_crashkernel_mem() may
   also face the same problem. So it's probably better that function
   reserve_crashkernel_mem() doesn't invoke insert_resource().

I guess you have a long Christmas holiday. So I'm going to send the next version
without waiting for your response.


>> Yes, I'm thinking about that too. Perhaps they are not suitable for full
>> code sharing, but it looks like there's some code that can be shared.
>> For example, the function parse_crashkernel_in_order() that I extracted
>> based on your suggestion, it could also be parse_crashkernel_high_low().
>> Or the function reserve_crashkernel_low().
>>
>> There are two ways to reserve memory above 4G:
>> 1. Use crashkernel=X,high, with or without crashkernel=X,low
>> 2. Use crashkernel=X,[offset], but try low memory first. If failed, then
>>    try high memory, and retry at least 256M low memory.
>>
>> I plan to only implement 2 in the next version so that there can be fewer
>> changes. Then implement 1 after 2 is applied.
> I tried it yesterday and it didn't work. I still have to deal with the
> problem of adjusting insert_resource().
> 
> How about I isolate some cleanup patches first? Strive for them to be
> merged into v5.17. This way, we can focus on the core changes in the
> next version. And I can also save some repetitive rebase workload.
> 

-- 
Regards,
  Zhen Lei
