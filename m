Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC4C48D03B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiAMBnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:43:37 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16707 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiAMBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:43:35 -0500
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZ6Ym18hCzZfBq;
        Thu, 13 Jan 2022 09:39:56 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:43:33 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 09:43:32 +0800
Subject: Re: [PATCH v5] arm64: kprobe: Enable OPTPROBE for arm64
To:     Jianhua Liu <jianhua.ljh@gmail.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <20211207124002.59877-1-liuqi115@huawei.com>
 <20211213183851.GD12405@willie-the-truck>
 <20211214092657.5b9c26b4e3852602eced4fda@kernel.org>
 <CAAgTQPUKqFn9_ENKbfJkFjT3v9L2NiFAY2xvULEj_6wguqWYNg@mail.gmail.com>
 <f4552c3e-8f1a-bef1-9396-39aa2405b486@huawei.com>
 <CAAgTQPWAK==cYPKeYNGE7nPGh0Y7Py4TcUoMPz76h15YNBNsLQ@mail.gmail.com>
 <CAAgTQPWomoiGdVJxwYBmXOj7RegHM4TSa2+yKVTQFhBFg8PtLg@mail.gmail.com>
 <20220104113559.7dd1ff2cb575f62e0b01fb47@kernel.org>
 <dbcbc161-228d-ee78-e1f0-b59ad9b0a36f@huawei.com>
 <CAAgTQPUEgSf-E_GOUNY_=4Piiy0K_-5U_YVbnoMAZ94Q3ducOg@mail.gmail.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <dad6f2e1-732f-4456-a77c-ea937082c87f@huawei.com>
Date:   Thu, 13 Jan 2022 09:43:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAgTQPUEgSf-E_GOUNY_=4Piiy0K_-5U_YVbnoMAZ94Q3ducOg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/12 20:21, Jianhua Liu wrote:
> On Wed, Jan 12, 2022 at 9:31 AM liuqi (BA) <liuqi115@huawei.com> wrote:
>>
>>
>>
>> On 2022/1/4 10:35, Masami Hiramatsu wrote:
>>> Hi Jianhua,
>>>
>>> On Mon, 3 Jan 2022 17:03:33 +0800
>>> Jianhua Liu <jianhua.ljh@gmail.com> wrote:
>>>
>>>> Hi Qi,
>>>> I have tested your patch on UNISOC s9863a.
>>>> Test case "kprobe_example & kretprobe_example" is OK.
>>>>
>>>> Two point:
>>>> 1. backtrace is not perfect.
>>>>      optprobe_common does not saved frame pointer,
>>>>      backtrace lacks two calls.
>>>> such as for dup_mm: lack copy_process-->dup_mm
>>>> dup_mm backtrace from your patch:
>>>> [  832.387066] CPU: 0 PID: 296 Comm: sh Not tainted 5.16.0-rc5+ #8
>>>> [  832.387078] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
>>>> [  832.387083] Call trace:
>>>> [  832.387086]  dump_backtrace+0x0/0x1e0
>>>> [  832.387103]  show_stack+0x24/0x30
>>>> [  832.387112]  dump_stack_lvl+0x68/0x84
>>>> [  832.387123]  dump_stack+0x18/0x34
>>>> [  832.387131]  handler_pre+0x40/0x50 [kprobe_example]
>>>> [  832.387143]  opt_pre_handler+0x84/0xc0
>>>> [  832.387154]  optprobe_optimized_callback+0xec/0x164
>>>> [  832.387164]  optprobe_common+0x70/0xc4
>>>> [  832.387173]  kernel_clone+0x98/0x440
>>>> [  832.387182]  __do_sys_clone+0x54/0x80
>>>> [  832.387191]  __arm64_sys_clone+0x2c/0x40
>>>> [  832.387199]  invoke_syscall+0x50/0x120
>>>> [  832.387208]  el0_svc_common.constprop.0+0x4c/0xf4
>>>> [  832.387217]  do_el0_svc+0x30/0x9c
>>>> [  832.387225]  el0_svc+0x20/0x60
>>>> [  832.387235]  el0t_64_sync_handler+0xe8/0xf0
>>>> [  832.387242]  el0t_64_sync+0x1a0/0x1a4
>>>>
>>>>
>>>> dup_mm backtrace from other:
>>>> [  173.352294] CPU: 6 PID: 309 Comm: sh Not tainted 5.16.0-rc5+ #19
>>>> [  173.352301] Hardware name: Spreadtrum SP9863A-1H10 Board (DT)
>>>> [  173.352304] Call trace:
>>>> [  173.352307]  dump_backtrace+0x0/0x1d4
>>>> [  173.352319]  show_stack+0x18/0x24
>>>> [  173.352326]  dump_stack_lvl+0x68/0x84
>>>> [  173.352333]  dump_stack+0x18/0x34
>>>> [  173.352338]  handler_pre+0x38/0x48 [kprobe_example]
>>>> [  173.352347]  opt_pre_handler+0x74/0xb0
>>>> [  173.352354]  optimized_callback+0x108/0x130
>>>> [  173.352361]  optinsn_slot+0x258/0x1000
>>>> [  173.352366]  dup_mm+0x4/0x4b0
>>>> [  173.352373]  copy_process+0x1284/0x1360
>>>> [  173.352378]  kernel_clone+0x5c/0x3c0
>>>> [  173.352384]  __do_sys_clone+0x54/0x80
>>>> [  173.352390]  __arm64_sys_clone+0x24/0x30
>>>> [  173.352396]  invoke_syscall+0x48/0x114
>>>> [  173.352402]  el0_svc_common.constprop.0+0x44/0xec
>>>> [  173.352408]  do_el0_svc+0x24/0x90
>>>> [  173.352413]  el0_svc+0x20/0x60
>>>> [  173.352420]  el0t_64_sync_handler+0xe8/0xf0
>>>> [  173.352427]  el0t_64_sync+0x1a0/0x1a4
>>>
>>
>> Hi Masami and Jianhua,
>>
>> optprobe_common() is added to minize size of code in trampoline, but
>> each trampoline is alloced as PAGE_SIZE, so optprobe_common() seems
>> unnecessary, and will make optprobe_trampoline.S much more complicated.
>> How about drop optprobe_common() and use a maro to reduce duplicate code .
>>
> 1. each trampoline is allocated as
> (MAX_OPTINSN_SIZE*sizeof(kprobe_opcode_t)), not PAGE_SIZE
> 2. MAX_OPTINSN_SIZE should be "((unsigned long)(optprobe_template_end
> - optprobe_template_entry)),
>     your MAX_OPTINSN_SIZE  is not accurate.
> 

Hi Jianhua,

Maybe I didn't express myself exactly, I mean that we use 
alloc_optinsn_page() to alloc PAGE_SIZE for each slot, and each time we 
copy instructions from a trampoline (which size of MAX_OPTINSN_SIZE) to 
slot.

So does the size of trampoline matters a lot? I mean I'm not sure 
minimize the size of trampoline by adding optprobe_common() could save 
memory...

> 3.optprobe_template_val in different kprobe may not be aligned with 8 byte.
>     ldr instruction for this value, may use address that not aligned 8 byte.
>     "ldr x0, 1f
>     .global optprobe_template_common"

uh I misunderstood. not sure I've missed something.Does 
optprobe_template_val aligned with 8 byte or not influence optprobe? We 
just load this address to X0 and use it as a input parameter.

Thanks,
Qi
> 
> Thanks,
> Jianhua
>> Thanks,
>> Qi
>>> Is the second one with your patch?
>>>
>>>>
>>>> 2. The reserve memory "OPT_SLOT_SIZE - PAGE_SIZE"  is waste.
>>>>      kernel/kprobe.c used only one PAGE_SIZE slot memory.
>>>
>>> Good catch!
>>> Qi, can you make an array (or bit map) of usage flags and
>>> manage the reserved memory?
>>>
>>> #define OPT_INSN_PAGES (OPT_SLOT_SIZE/PAGE_SIZE)
>>> static bool insn_page_in_use[OPT_INSN_PAGES];
>>>
>>> void *alloc_optinsn_page(void)
>>> {
>>>        int i;
>>>
>>>        for (i = 0; i < OPT_INSN_PAGES; i++)
>>>                if (!insn_page_in_use[i])
>>>                        goto found;
>>>        return NULL;
>>> found:
>>>        insn_page_in_use[i] = true;
>>>        return (void *)((unsigned long)optinsn_slot + PAGE_SIZE * i);
>>> }
>>>
>>> void free_optinsn_page(void *page)
>>> {
>>>        unsigned long idx = (unsigned long)page - (unsigned long)optinsn_slot;
>>>
>>>        WARN_ONCE(idx & (PAGE_SIZE - 1));
>>>        idx >>= PAGE_SHIFT;
>>>        if (WARN_ONCE(idx >= OPT_INSN_PAGES))
>>>                return;
>>>        insn_page_in_use[idx] = false;
>>> }
>>>
>>> Thank you,
>>>
>>>
>>>
>>>
> .
> 
