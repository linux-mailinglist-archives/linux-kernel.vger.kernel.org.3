Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D447EC2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbhLXGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:37:05 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33909 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLXGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:37:04 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JKy5J6T09zcbZg;
        Fri, 24 Dec 2021 14:36:36 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 14:37:01 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 24 Dec 2021 14:37:00 +0800
Subject: Re: [PATCH v18 02/17] x86/setup: Move xen_pv_domain() check and
 insert_resource() to setup_arch()
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d6226aa2-f1f2-24cc-c9d2-9762bd615686@huawei.com>
Date:   Fri, 24 Dec 2021 14:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YcSxLodOnxXHx0sV@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/24 1:26, Borislav Petkov wrote:
> On Wed, Dec 22, 2021 at 09:08:05PM +0800, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> We will make the functions reserve_crashkernel() as generic, the
>> xen_pv_domain() check in reserve_crashkernel() is relevant only to
>> x86,
> 
> Why is that so? Is Xen-PV x86-only?
> 
>> the same as insert_resource() in reserve_crashkernel[_low]().
> 
> Why?
> 
> Looking at
> 
>   0212f9159694 ("x86: Add Crash kernel low reservation")
> 
> it *surprisingly* explains why that resources thing is being added:
> 
>     We need to add another range in /proc/iomem like "Crash kernel low",
>     so kexec-tools could find that info and append to kdump kernel
>     command line.
> 
> Then,
> 
>   157752d84f5d ("kexec: use Crash kernel for Crash kernel low")
> 
> renamed it because, as it states, kexec-tools was taught to handle
> multiple resources of the same name.
> 
> So why does kexec-tools on arm *not* need those iomem resources? How
> does it parse the ranges there? Questions over questions...

https://lkml.org/lkml/2019/4/4/1758

Chen Zhou has explained before, see below. I'll analyze why x86 and arm64 need
to process iomem resources at different times.

 < This very reminds what x86 does. Any chance some of the code can be reused
 < rather than duplicated?
As i said in the comment, i transport reserve_crashkernel_low() from x86_64. There are minor
differences. In arm64, we don't need to do insert_resource(), we do request_resource()
in request_standard_resources() later.

> 
> So last time I told you to sit down and take your time with this cleanup.
>>From reading this here, it doesn't look like it. Rather, it looks like
> hastily done in a hurry and hurrying stuff doesn't help you one bit - it
> actually makes it worse.
> 
> Your commit messages need to explain *why* a change is being done and
> why is that ok. This one doesn't.

OK, I'll do this in follow-up patches.

> 
>> @@ -1120,7 +1109,17 @@ void __init setup_arch(char **cmdline_p)
>>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>>  	 * won't consume hotpluggable memory.
>>  	 */
>> -	reserve_crashkernel();
>> +#ifdef CONFIG_KEXEC_CORE
>> +	if (xen_pv_domain())
>> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> 
> This is wrong - the check is currently being done inside
> reserve_crashkernel(), *after* it has parsed a crashkernel= cmdline
> correctly - and not before.
> 
> Your change would print on Xen PV, regardless of whether it has received
> crashkernel= on the cmdline or not.

Yes, you're right. There are changes in code logic, but the print doesn't
seem to cause any misunderstanding.

> 
> This is exactly why I say that making those functions generic and shared
> might not be such a good idea, after all, because then you'd have to
> sprinkle around arch-specific stuff.

Yes, I'm thinking about that too. Perhaps they are not suitable for full
code sharing, but it looks like there's some code that can be shared.
For example, the function parse_crashkernel_in_order() that I extracted
based on your suggestion, it could also be parse_crashkernel_high_low().
Or the function reserve_crashkernel_low().

There are two ways to reserve memory above 4G:
1. Use crashkernel=X,high, with or without crashkernel=X,low
2. Use crashkernel=X,[offset], but try low memory first. If failed, then
   try high memory, and retry at least 256M low memory.

I plan to only implement 2 in the next version so that there can be fewer
changes. Then implement 1 after 2 is applied.

> 
> One of the ways how to address this particular case here would be:
> 
> 1. Add a x86-specific wrapper around parse_crashkernel() which does
> all the parsing. When that wrapper finishes, you should have parsed
> everything that has crashkernel= on the cmdline.
> 
> 2. At the end of that wrapper, you do arch-specific checks and setup
> like the xen_pv_domain() one.
> 
> 3. Now, you do reserve_crashkernel(), if those checks pass.
> 
> The question is, whether the flow on arm64 can do the same. Probably but
> it needs careful auditing.
> 
