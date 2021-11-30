Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461E0462D12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhK3Gva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:51:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31927 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbhK3Gv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:51:29 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3CTZ4vjgzcbkR;
        Tue, 30 Nov 2021 14:48:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:48:08 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:48:07 +0800
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210818073336.59678-1-liuqi115@huawei.com>
 <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local>
 <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
 <20211127212302.f71345c34e5a62e5e779adb2@kernel.org>
 <4998f219-eb47-a07c-b3ed-c2ae46a77230@huawei.com>
 <20211129140040.87c5f423a72c95c90602c2c6@kernel.org>
 <3f8c1754-b677-971c-2e04-a04678206424@huawei.com>
 <20211129233514.e59d953a7d90d9f4f3d6a097@kernel.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <9fdb2ad3-539f-fb4d-7a96-c737fec967f7@huawei.com>
Date:   Tue, 30 Nov 2021 14:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211129233514.e59d953a7d90d9f4f3d6a097@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/29 22:35, Masami Hiramatsu wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> I meet a problem when I use SYM_CODE_START(optprobe_template) to replace
>>>>>> optprobe_template_entry.
>>>>>>
>>>>>> If SYM_CODE_START is used, all optprobe will share one trampoline space.
>>>>>> Under this circumstances, if user register two optprobes, trampoline
>>>>>> will be overwritten by the newer one, and this will cause kernel panic
>>>>>> when the old optprobe is trigger.
>>>>> Hm, this is curious, because the template should be copied to the
>>>>> trampoline buffer for each optprobe and be modified.
>>>>>
>>>>>> Using optprobe_template_entry will not have this problem, as each
>>>>>> optprobe has its own trampoline space (alloced in get_opinsn_slot()).
>>>>> Yes, it is designed to do so.
>>>>>
>>>>> Thank you,
>>>>>
>>>> Hi Masami,
>>>>
>>>> Thanks for your reply. But I also met a problem when using
>>>> get_opinsn_slot() to alloc trampoline buffer.
>>>>
>>>> As module_alloc(like x86) is used to alloc buffer, trampoline is in
>>>> module space, so if origin insn is in kernel space, the range between
>>>> origin insn and trampoline is out of 128M.
>>>>
>>>> As module PLT cannot used here, I have no idea to achieve long jump in
>>>> this situation. Do you have any good idea?
>> Hi Masami,
>>
>> Thanks so much for your reply.
>>
>>> One possible solution is to use pre-allocated trampoline space in
>>> the text area, as same as ppc64 does.
>>> (See arch/powerpc/kernel/optprobes_head.S, it embeds a space at "optinsn_slot")
>>>
>> I find something interesting in arch/powerpc/kernel/optprobes.c, it use
>> "optinsn_slot" as a public buffer, and use a static "insn_page_in_use"
>> to make sure there is only one optprobe in kernel.
>>
>> If we use this solution , users could only register one optprobe each
>> time. This will also be a limitation for users, what's your opinion
>> about this?
> No, that is just a memory area for pooling trampoline buffer. So optprobe
> can allocate the buffer from that area. Please see kernel/kprobes.c:344.
> optprobe allocates "insn_slot" from kprobe_optinsn_slots, which uses
> alloc_optinsn_page() to allocate the pool of slots.
> 
> Thank you,
> 

Hi,

Thanks for your reply, I test alloc_optinsn_page() and it does work well 
to alloc the pool of slots.

But when I tried to use module PLT, something seems wrong here.
Arm64 Module PLT in mod->arch.ftrace_trampolines is set in 
module_finalize, after that, mod->arch.ftrace_trampolines seems to be a 
read-only memory. But in arch_optimize_kprobes() we need to modify the 
destination of PLT (as each optprobe has its own trampoline buffer), if 
so, we cannot get rid of the 128M branch limit :(

Thanks,
Qi
