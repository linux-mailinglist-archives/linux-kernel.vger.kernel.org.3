Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A185547715F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhLPMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:08:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29135 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhLPMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:08:45 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JF9mj4jm8z1DJs8;
        Thu, 16 Dec 2021 20:05:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 20:08:42 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 20:08:41 +0800
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
To:     Borislav Petkov <bp@alien8.de>
CC:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
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
        Chen Zhou <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com> <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com> <YbseAX6X1VHUF12f@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
Date:   Thu, 16 Dec 2021 20:08:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YbseAX6X1VHUF12f@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/16 19:07, Borislav Petkov wrote:
> On Thu, Dec 16, 2021 at 10:46:12AM +0800, Leizhen (ThunderTown) wrote:
>> The original value (1ULL << 32) is inaccurate
> 
> I keep asking *why*?
> 
>> and it enlarged the CRASH_ADDR_LOW upper limit.
> 
> $ git grep -E "CRASH_ADDR_LOW\W"
> $
> 
> I have no clue what you mean here.

#ifdef CONFIG_X86_32
# define CRASH_ADDR_LOW_MAX     SZ_512M
# define CRASH_ADDR_HIGH_MAX    SZ_512M
#endif

		if (!high)
(1)                     crash_base = memblock_phys_alloc_range(crash_size,
                                                CRASH_ALIGN, CRASH_ALIGN,
                                                CRASH_ADDR_LOW_MAX);
                if (!crash_base)
(2)                     crash_base = memblock_phys_alloc_range(crash_size,
                                                CRASH_ALIGN, CRASH_ALIGN,
                                                CRASH_ADDR_HIGH_MAX);

-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low())
+(3)	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low())

If the memory of 'crash_base' is successfully allocated at (1), because the last
parameter CRASH_ADDR_LOW_MAX is the upper bound, so we can sure that
"crash_base < CRASH_ADDR_LOW_MAX". So that, reserve_crashkernel_low() will not be
invoked at (3). That's why I said (1ULL << 32) is inaccurate and enlarge the CRASH_ADDR_LOW
upper limit.

If the memory of 'crash_base' is successfully allocated at (2), you see,
CRASH_ADDR_HIGH_MAX = CRASH_ADDR_LOW_MAX = SZ_512M, the same as (1). In fact,
"crashkernel=high," may not be recommended on X86_32.

Is it possible that (CRASH_ADDR_HIGH_MAX >= 4G) and (CRASH_ADDR_LOW_MAX < 4G)?
In this case, the memory allocated at (2) maybe over 4G. But why shouldn't
CRASH_ADDR_LOW_MAX be equal to 4G at this point?


> 
>> This is because when the memory is allocated from the low end, the
>> address cannot exceed CRASH_ADDR_LOW_MAX, see "if (!high)" branch.
> 
>> If
>> the memory is allocated from the high end, 'crash_base' is greater than or
>> equal to (1ULL << 32), and naturally, it is greater than CRASH_ADDR_LOW_MAX.
>>
>> I think I should update the description, thanks.
> 
> I think you should explain why is (1ULL << 32) wrong.
> 
> It came from:
> 
>   eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")
> 
> which simply frees the high memory portion when the low reservation
> fails. And the test for that is, is crash base > 4G. So that makes
> perfect sense to me.
> 
> So your change is a NOP on 64-bit and it is a NOP on 32-bit by virtue of
> the _low() variant always returning 0 on 32-bit.
> 
