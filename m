Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6464813DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhL2ON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:13:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15990 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhL2ON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:13:26 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JPCwF5HSczVhMD;
        Wed, 29 Dec 2021 22:10:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 22:13:24 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 22:13:22 +0800
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
To:     Dave Young <dyoung@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com> <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com> <Ycw0V1CmBPCPqexn@zn.tnic>
 <Ycw6s6DwZuHjckXL@dhcp-128-65.nay.redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <050a33f3-7a87-62ce-00bb-92b5d30915d1@huawei.com>
Date:   Wed, 29 Dec 2021 22:13:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ycw6s6DwZuHjckXL@dhcp-128-65.nay.redhat.com>
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



On 2021/12/29 18:38, Dave Young wrote:
> On 12/29/21 at 11:11am, Borislav Petkov wrote:
>> On Wed, Dec 29, 2021 at 03:45:12PM +0800, Dave Young wrote:
>>> BTW, I would suggest to wait for reviewers to response (eg. one week at
>>> least, or more due to the holidays) before updating another version
>>>
>>> Do not worry to miss the 5.17.  I would say take it easy if it will
>>> miss then let's just leave with it and continue to work on the future
>>> improvements.  I think one reason this issue takes too long time is that it was
>>> discussed some time but no followup and later people need to warm up
>>> again.  Just keep it warm and continue to engage in the improvements, do
>>> not hurry for the specific mainline release.
>>
>> Can you tell this to *all* patch submitters please?
> 
> I appreciate you further explanation below to describe the situation.  I do not
> see how can I tell this to *all* submitters,  but I am and I will try to do this
> as far as I can.  Maintainers and patch submitters, it would help for both
> parties show sympathy with each other, some soft reminders will help
> people to understand each other, especially for new comers.
> 
>>
>> I can't count the times where people simply hurry to send the new
>> revision just to get it in the next kernel, and make silly mistakes
>> while doing so. Or not think things straight and misdesign it all.
>>
>> And what this causes is the opposite of what they wanna achieve - pissed
>> maintainers and ignored threads.

I just hope the first 4 patches can be merged into v5.17. It seems to me
that it is quite clear. Although the goal of the final stage is to modify
function parse_crashkernel() according to the current opinion. But that's not a
lightweight change after all. The final parse_crashkernel() change may take
one version or two. In this process, it maybe OK to do a part of cleanup first.

It's like someone who wants to buy a luxury car to commute to work six months
later. He buys a cheap used car and sells it six months later. It sounds right
to me, don't you think?

>>
>> And they all *know* that the next kernel is around the corner. So why
>> the hell does it even matter when?

Because all programmers should have confidence in the code they write. I have
a new idea, and I'm free these days, so I updated v19. I can't rely on people
telling me to take a step forward, then take a step forward. Otherwise, stand
still.

>>
>> What most submitters fail to realize is, the moment your code hits
>> upstream, it becomes the maintainers' problem and submitters can relax.

Sorry, I'll make sure all the comments are collected and then send the next
edition.

>>
>> But maintainers get to deal with this code forever. So after a while
>> maintainers learn that they either accept ready code and it all just
>> works or they make the mistake to take half-baked crap in and then they
>> themselves get to clean it up and fix it.
>>
>> So maintainers learn quickly to push back.
>>
>> But it is annoying and it would help immensely if submitters would
>> consider this and stop hurrying the code in but try to do a *good* job
>> first, design-wise and code-wise by thinking hard about what they're
>> trying to do.
>>
>> Yeah, things could be a lot simpler and easier - it only takes a little
>> bit of effort...
>>
>> -- 
>> Regards/Gruss,
>>     Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
>>
> 
> Thanks
> Dave
> 
> .
> 

-- 
Regards,
  Zhen Lei
