Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D656D4750C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhLOCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:10:50 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29192 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhLOCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:10:49 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JDJZB3BGzz8vkc;
        Wed, 15 Dec 2021 10:08:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 10:10:47 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 10:10:46 +0800
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
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
 <YbjvXl51hc6GZa71@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <07e41d65-bc3a-49c4-c041-752f1765f37a@huawei.com>
Date:   Wed, 15 Dec 2021 10:10:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YbjvXl51hc6GZa71@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/15 3:24, Catalin Marinas wrote:
> On Tue, Dec 14, 2021 at 08:07:58PM +0100, Borislav Petkov wrote:
>> On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
>>> From: Chen Zhou <chenzhou10@huawei.com>
>>>
>>> The lower bounds of crash kernel reservation and crash kernel low
>>> reservation are different, use the consistent value CRASH_ALIGN.
>>
>> A big WHY is missing here to explain why the lower bound of the
>> allocation range needs to be 16M and why was 0 wrong?
> 
> I asked the same here:
> 
> https://lore.kernel.org/r/20210224143547.GB28965@arm.com
> 
> IIRC Baoquan said that there is a 1MB reserved for x86 anyway in the
> lower part, so that's equivalent in practice to starting from
> CRASH_ALIGN.
> 
> Anyway, I agree the commit log should describe this.

OK, I will add the description.

> 
