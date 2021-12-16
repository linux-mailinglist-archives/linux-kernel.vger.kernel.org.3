Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA7476847
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhLPCq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:46:28 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16819 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhLPCq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:46:27 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDxLX0hnKz91Px;
        Thu, 16 Dec 2021 10:45:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:46:25 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:46:24 +0800
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
To:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com> <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
Date:   Thu, 16 Dec 2021 10:46:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211216011040.GG3023@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/16 9:10, Baoquan He wrote:
> On 12/15/21 at 02:28pm, Borislav Petkov wrote:
>> On Fri, Dec 10, 2021 at 02:55:26PM +0800, Zhen Lei wrote:
>>> @@ -518,7 +519,7 @@ static void __init reserve_crashkernel(void)
>>>  		}
>>>  	}
>>>  
>>> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
>>> +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
>>>  		memblock_phys_free(crash_base, crash_size);
>>>  		return;
>>>  	}
>>
>> That's not a equivalent transformation on X86_32.

The original value (1ULL << 32) is inaccurate, and it enlarged the CRASH_ADDR_LOW
upper limit. This is because when the memory is allocated from the low end,
the address cannot exceed CRASH_ADDR_LOW_MAX, see "if (!high)" branch. If
the memory is allocated from the high end, 'crash_base' is greater than or
equal to (1ULL << 32), and naturally, it is greater than CRASH_ADDR_LOW_MAX.

I think I should update the description, thanks.

                if (!high)
                        crash_base = memblock_phys_alloc_range(crash_size,
                                                CRASH_ALIGN, CRASH_ALIGN,
                                                CRASH_ADDR_LOW_MAX);
                if (!crash_base)
                        crash_base = memblock_phys_alloc_range(crash_size,
                                                CRASH_ALIGN, CRASH_ALIGN,
                                                CRASH_ADDR_HIGH_MAX);

> 
> reserve_crashkernel_low() always return 0 on x86_32, so the not equivalent
> transformation for x86_32 doesn't matter, I think.
> 
> .
> 
