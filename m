Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC9475819
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbhLOLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:46:03 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16816 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhLOLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:46:01 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDYMZ23lHz91N9;
        Wed, 15 Dec 2021 19:45:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 19:45:58 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 19:45:57 +0800
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
To:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com> <YbjrjpehprvoRXbV@zn.tnic>
 <YbjvXl51hc6GZa71@arm.com> <20211215034219.GB10336@MiWiFi-R3L-srv>
 <YbnK79c0YokJ1ahu@arm.com> <20211215111643.GF3023@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b947e66b-1a23-9095-08c1-439e6c70d191@huawei.com>
Date:   Wed, 15 Dec 2021 19:45:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211215111643.GF3023@MiWiFi-R3L-srv>
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



On 2021/12/15 19:16, Baoquan He wrote:
> On 12/15/21 at 11:01am, Catalin Marinas wrote:
>> On Wed, Dec 15, 2021 at 11:42:19AM +0800, Baoquan He wrote:
>>> On 12/14/21 at 07:24pm, Catalin Marinas wrote:
>>>> On Tue, Dec 14, 2021 at 08:07:58PM +0100, Borislav Petkov wrote:
>>>>> On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
>>>>>> From: Chen Zhou <chenzhou10@huawei.com>
>>>>>>
>>>>>> The lower bounds of crash kernel reservation and crash kernel low
>>>>>> reservation are different, use the consistent value CRASH_ALIGN.
>>>>>
>>>>> A big WHY is missing here to explain why the lower bound of the
>>>>> allocation range needs to be 16M and why was 0 wrong?
>>>>
>>>> I asked the same here:
>>>>
>>>> https://lore.kernel.org/r/20210224143547.GB28965@arm.com
>>>>
>>>> IIRC Baoquan said that there is a 1MB reserved for x86 anyway in the
>>>> lower part, so that's equivalent in practice to starting from
>>>> CRASH_ALIGN.
>>>
>>> Yeah, even for i386, there's area reserved by BIOS inside low 1M.
>>> Considering the existing alignment CRASH_ALIGN which is 16M, we
>>> definitely have no chance to get memory starting from 0. So starting
>>> from 16M can skip the useless memblock searching, and make the
>>> crashkernel low reservation consisten with crashkernel reservation on
>>> allocation code.
>>
>> That's the x86 assumption. Is it valid for other architectures once the
>> code has been made generic in patch 6? It should be ok for arm64, RAM
>> tends to start from higher up but other architectures may start using
>> this common code.
> 
> Good point. I didn't think of this from generic code side, then let's
> keep it as 0.
> 
>>
>> If you want to keep the same semantics as before, just leave it as 0.
>> It's not that the additional lower bound makes the search slower.
> 
> Agree.

OK, I will drop this patch.

> 
> .
> 
