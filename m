Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63648144C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbhL2PEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:04:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29308 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhL2PEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:04:37 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JPF6X5gPxzbjgW;
        Wed, 29 Dec 2021 23:04:04 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 23:04:33 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 23:04:32 +0800
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
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com> <YcwyZRDJUMniSaY9@zn.tnic>
 <Ycw8n2BvJzH9wJKG@dhcp-128-65.nay.redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <21736ba2-883d-1037-dbe8-299e40f7ad13@huawei.com>
Date:   Wed, 29 Dec 2021 23:04:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Ycw8n2BvJzH9wJKG@dhcp-128-65.nay.redhat.com>
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



On 2021/12/29 18:46, Dave Young wrote:
> On 12/29/21 at 11:03am, Borislav Petkov wrote:
>> On Wed, Dec 29, 2021 at 03:27:48PM +0800, Dave Young wrote:
>>> So I think you can unify the parse_crashkernel* in x86 first with just
>>> one function.  And leave the further improvements to later work. But
>>> let's see how Boris think about this.
>>
>> Well, I think this all unnecessary work. Why?
>>
>> If the goal is to support crashkernel...high,low on arm64, then you
>> should simply *copy* the functionality on arm64 and be done with it.
>>
>> Unification is done by looking at code which is duplicated across
>> architectures and which has been untouched for a while now, i.e., no
>> new or arch-specific changes are going to it so a unification can be
>> as simple as trivially switching the architectures to call a generic
>> function.
>>
>> What this does is carve out the "generic" parts and then try not to
>> break existing usage.
>>
>> Which is a total waste of energy and resources. And it is casting that
>> functionality in stone so that when x86 wants to change something there,
>> it should do it in a way not to break arm64. And I fail to see the
>> advantage of all that. Code sharing ain't it.

It's just a worry, there's uncertainty about whether it's going to be. I think
the only thing that might change is the default value of "low_size". Of course,
the alignment size and start address may also change, but most of them can be
controlled by macros.

Chen Zhou and I tried to share the code because of a suggestion. After so many
attempts, it doesn't seem to fit to make generic. Or maybe I haven't figured
out a good solution yet.


>>
>> So what it should do is simply copy the necessary code to arm64.
>> Unifications can always be done later, when the dust settles.
> 
> I think I agree with you about the better way is to doing some
> improvements so that arches can logically doing things better.  I can
> leave with the way I suggested although it is not the best.  But I think
> Leizhen needs a clear direction about how to do it. It is very clear
> now.  See how he will handle this. 

Surviving, then pursuing ideals.

I will put the patches that make arm64 support crashkernel...high,low to
the front, then the parse_crashkernel() unification patches. Even if the
second half of the patches is not ready for v5.18, the first half of the
patches is ready.

> 
>>
>> IMNSVHO.
>>
>> -- 
>> Regards/Gruss,
>>     Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
