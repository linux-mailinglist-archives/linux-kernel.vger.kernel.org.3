Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14847DD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbhLWCJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:09:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30096 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWCJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:09:40 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JKD844RkLz1DK6h;
        Thu, 23 Dec 2021 10:06:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 10:09:38 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 10:09:37 +0800
Subject: Re: [PATCH v18 01/17] x86/setup: Move CRASH_ALIGN and
 CRASH_ADDR_{LOW|HIGH}_MAX to asm/kexec.h
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
 <20211222130820.1754-2-thunder.leizhen@huawei.com> <YcON5Y7DKitiQhHu@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c7b8ed2f-7280-faf9-66e8-ad329dbc10f6@huawei.com>
Date:   Thu, 23 Dec 2021 10:09:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YcON5Y7DKitiQhHu@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/23 4:43, Borislav Petkov wrote:
> On Wed, Dec 22, 2021 at 09:08:04PM +0800, Zhen Lei wrote:
>> From: Chen Zhou <chenzhou10@huawei.com>
>>
>> We want to make function reserve_crashkernel[_low](), which is implemented
>   ^^
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.

My bad language habits. I've made this mistake several times.

> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.

OK, I'll check the description of the other patches.

> 
>> by X86, available to other architectures. It references macro CRASH_ALIGN
> 
> "x86"

OK

> 
>> and will be moved to public crash_core.c. But the defined values of
>> CRASH_ALIGN may be different in different architectures. So moving the
>> definition of CRASH_ALIGN to asm/kexec.h is a good choice.
>>
>> The reason for moving CRASH_ADDR_{LOW|HIGH}_MAX is the same as above.
> 
> This commit message needs to say something along the lines of:
> 
> "Move CRASH_ALIGN and ... to the arch-specific header in preparation
> of making reserve_crashkernel[_low]() generic, used by other
> architectures."

OK, I will use this one, thanks.

By the way, patch 0004-0006 were written based on your suggestion. Can you
take a moment to review it? I think I forgot to add "Suggested-by".

> 
> or so.
> 
