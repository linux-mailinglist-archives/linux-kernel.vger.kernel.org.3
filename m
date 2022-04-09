Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BBA4FA66E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiDIJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:26:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB6338
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:24:28 -0700 (PDT)
Received: from kwepemi100006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kb8lz6ZmhzgY8S;
        Sat,  9 Apr 2022 17:22:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100006.china.huawei.com (7.221.188.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 17:24:26 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 17:24:25 +0800
Message-ID: <d8c70b95-2515-089e-59ee-694a4ab734c3@huawei.com>
Date:   Sat, 9 Apr 2022 17:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 7/7] arm64: add pagecache reading to machine
 check safe
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, <james.morse@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <james.morse@arm.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-8-tongtiangen@huawei.com>
 <Yk15Fex1+fg6ZQrX@FVFF77S0Q05N>
 <afd5285b-9d8b-3c58-111e-095d1e5b74f8@huawei.com>
 <debf5db0-d4b8-5fdd-f798-b7b41e316342@arm.com>
 <d7ef4e03-343e-f7e3-2890-a45b87ac8203@huawei.com>
 <efed49aa-5a07-cd97-e58f-eec1b5840b9c@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <efed49aa-5a07-cd97-e58f-eec1b5840b9c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/8 19:11, Robin Murphy 写道:
> On 2022-04-08 03:43, Tong Tiangen wrote:
>>
>>
>> 在 2022/4/7 23:53, Robin Murphy 写道:
>>> On 2022-04-07 15:56, Tong Tiangen wrote:
>>>>
>>>>
>>>> 在 2022/4/6 19:27, Mark Rutland 写道:
>>>>> On Wed, Apr 06, 2022 at 09:13:11AM +0000, Tong Tiangen wrote:
>>>>>> When user process reading file, the data is cached in pagecache and
>>>>>> the data belongs to the user process, When machine check error is
>>>>>> encountered during pagecache reading, killing the user process and
>>>>>> isolate the user page with hardware memory errors is a more 
>>>>>> reasonable
>>>>>> choice than kernel panic.
>>>>>>
>>>>>> The __arch_copy_mc_to_user() in copy_to_user_mc.S is largely borrows
>>>>>> from __arch_copy_to_user() in copy_to_user.S and the main difference
>>>>>> is __arch_copy_mc_to_user() add the extable entry to support machine
>>>>>> check safe.
>>>>>
>>>>> As with prior patches, *why* is the distinction necessary?
>>>>>
>>>>> This patch adds a bunch of conditional logic, but *structurally* it 
>>>>> doesn't
>>>>> alter the handling to be substantially different for the MC and 
>>>>> non-MC cases.
>>>>>
>>>>> This seems like pointless duplication that just makes it harder to 
>>>>> maintain
>>>>> this code.
>>>>>
>>>>> Thanks,
>>>>> Mark.
>>>>
>>>> Agreed, The implementation here looks a little ugly and harder to 
>>>> maintain.
>>>>
>>>> The purpose of my doing this is not all copy_to_user can be recovered.
>>>>
>>>> A memory error is consumed when reading pagecache using copy_to_user.
>>>> I think in this scenario, only the process is affected because it 
>>>> can't read
>>>> pagecache data correctly. Just kill the process and don't need the 
>>>> whole
>>>> kernel panic.
>>>>
>>>> So I need two different copy_to_user implementation, one is existing 
>>>> __arch_copy_to_user,
>>>> this function will panic when consuming memory errors. The other one 
>>>> is this new helper
>>>> __arch_copy_mc_to_user, this interface is used when reading 
>>>> pagecache. It can recover from
>>>> consume memory error.
>>>
>>> OK, but do we really need two almost-identical implementations of 
>>> every function where the only difference is how the exception table 
>>> entries are annotated? Could the exception handler itself just figure 
>>> out who owns the page where the fault occurred and decide what action 
>>> to take as appropriate?
>>>
>>> Robin.
>>>
>>
>> Thank you, Robin.
>>
>> I added this call path in this patchset: do_sea() -> 
>> fixup_exception(), the purpose is to provide a chance for sea fault to 
>> fixup (refer patch 3/7).
>>
>> If fixup successful, panic can be avoided. Otherwise, panic can be 
>> eliminated according to the original logic.
>>
>> fixup_exception() will set regs->pc and jump to regs->pc when the 
>> context recovery of an exception occurs.
>>
>> If mc-safe-fixup added to  __arch_copy_to_user(),  in *non pagecache 
>> reading* scenario encount memory error when call __arch_copy_to_user() 
>> , do_sea() -> fixup_exception() will not return fail and will miss the 
>> panic logic in do_sea().
>>
>> So I add new helper __arch_copy_mc_to_user()  and add mc-safe-fixup to 
>> this helper, which can be used in the required scenarios. At present, 
>> there is only one pagecache reading scenario, other scenarios need to 
>> be developed.
>>
>> This is my current confusion. Of course, I will think about the 
>> solution to  solve the duplicate code problem.
> 
> Right, but if the point is that faults in pagecahe pages are special, 
> surely __do_kernel_fault() could ultimately figure out from the address 
> whether that's the case or not?
> 
> In general, if the principle is that whether a fault is recoverable or 
> not depends on what was being accessed, then to me it seems 
> fundamentally more robust to base that decision on details of the fault 
> that actually occurred, rather than what the caller thought it was 
> supposed to be doing at the time.
> 
> Thanks,
> Robin.
> .
According to Mark's suggestion, all uaccess can be recovered, including 
copy_to_user(), so there is no need to add new helper 
__arch_mc_copy_to_user()。

Thanks,
Tong.

