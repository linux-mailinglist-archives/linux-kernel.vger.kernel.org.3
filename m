Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7F4873EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbiAGINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:13:05 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31145 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiAGINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:13:04 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JVbW4654hzbbc8;
        Fri,  7 Jan 2022 16:10:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:13:01 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:13:00 +0800
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
Message-ID: <7e7c8d93-e745-2bfd-b93d-aecb3b70bf33@huawei.com>
Date:   Fri, 7 Jan 2022 16:13:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5d8aed79-b20f-2575-3c3f-8945d8cbac3f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/25 9:53, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/24 14:36, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/12/24 1:26, Borislav Petkov wrote:
>>> On Wed, Dec 22, 2021 at 09:08:05PM +0800, Zhen Lei wrote:
>>>> From: Chen Zhou <chenzhou10@huawei.com>
>>>>
>>>> We will make the functions reserve_crashkernel() as generic, the
>>>> xen_pv_domain() check in reserve_crashkernel() is relevant only to
>>>> x86,
>>>
>>> Why is that so? Is Xen-PV x86-only?
>>>
>>>> the same as insert_resource() in reserve_crashkernel[_low]().
>>>
>>> Why?
>>>
>>> Looking at
>>>
>>>   0212f9159694 ("x86: Add Crash kernel low reservation")
>>>
>>> it *surprisingly* explains why that resources thing is being added:
>>>
>>>     We need to add another range in /proc/iomem like "Crash kernel low",
>>>     so kexec-tools could find that info and append to kdump kernel
>>>     command line.
>>>
>>> Then,
>>>
>>>   157752d84f5d ("kexec: use Crash kernel for Crash kernel low")
>>>
>>> renamed it because, as it states, kexec-tools was taught to handle
>>> multiple resources of the same name.
>>>
>>> So why does kexec-tools on arm *not* need those iomem resources? How
>>> does it parse the ranges there? Questions over questions...

Hi Borislav:
  The reason why insert_resource() cannot be used in reserve_crashkernel[_low]()
on arm64 is clear. The parent resource node of crashk[_low]_res is added by
request_resource() in request_standard_resources(), so that it will be conflicted.
All request_resource() in request_standard_resources() should be changed to
insert_resource(), to make insert_resource() can be used in reserve_crashkernel[_low]().

  I found commit e25e6e7593ca ("kdump, x86: Process multiple Crash kernel in /proc/iomem")
in kexec-tools. I'm trying to port it to arm64, or make it generic.

  Thanks.

> 
> It's a good question worth figuring out. I'm going to dig into this.
> I admire your rigorous style and sharp vision.
> 


-- 
Regards,
  Zhen Lei
