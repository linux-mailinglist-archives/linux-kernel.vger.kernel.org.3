Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB304F7482
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiDGEX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiDGEXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:23:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FE1BE0C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 21:21:54 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYp782hSWzFpVm;
        Thu,  7 Apr 2022 12:19:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 12:21:51 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 12:21:50 +0800
Message-ID: <bdf67ff6-9eb8-c2b4-2c2f-b160d4f879cd@huawei.com>
Date:   Thu, 7 Apr 2022 12:21:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 0/7]arm64: add machine check safe support
To:     Mark Rutland <mark.rutland@arm.com>
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
        <james.morse@arm.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <Yk1luUxEIP3Dxt5c@FVFF77S0Q05N>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Yk1luUxEIP3Dxt5c@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/6 18:04, Mark Rutland 写道:
> Hi,
> 
> In future, for the arm64 uaccess stuff, could you please CC me, and for the
> arm64 RAS bits (e.g. the SEA handling), could you please CC James Morse?

ok :)

> 
> On Wed, Apr 06, 2022 at 09:13:04AM +0000, Tong Tiangen wrote:
>> This patchset is based on[1].
> 
> That link below appears to be a single patch. Sending that separately makes
> this harder to review, so in future could you please send this as a combined
> series?
> 
>> With the increase of memory capacity and density, the probability of
>> memory error increases. The increasing size and density of server RAM
>> in the data center and cloud have shown increased uncorrectable memory
>> errors.
>>
>> Currently, the kernel has a mechanism to recover from hardware memory
>> errors. This patchset provides an new recovery mechanism.
>>
>> For ARM64, the hardware error handling is do_sea() which divided into
>> two cases:
>> 1. The user state consumed the memory errors, the solution is kill th
>>       user process and isolate the error page.
>> 2. The kernel state consumed the memory errors, the solution is panic.
>>
>> For kernelspace, Undifferentiated panic maybe not the optimal choice,
>> it can be handled better.
>>
>> This patchset deals with four sscenarios of hardware memory error consumed
>> in kernelspace:
>> 1. copy_from_user.
>> 2. get_user.
> 
> What about atomics to user memory? e.g. futexes, or the armv8_deprecated
> emulations?
> 
> It seems the assumption is that writing to user memory (e.g. copy_to_user() and
> put_user()) don't matter? Could you please mention why? e.g. do we never take
> an exception for writes to memory with errors?

First, explain why only pay attention to the errors that occur when 
reading memory and not when writing memory:

1. For Linux reading page, the Linux is consumer[*], the DDR controller 
is producer. if page with memory error, Linux consumes the error will 
receive an error signal than process the signal.

2. For Linux writing page, the Linux is producer, the DDR controller is 
consumer, the DDR controller will process the memory error.

3. From the perspective of Linux, here we only focus on his situation as 
a consumer. Focus on how Linux responds to errors when reading pages.

[*]For definitions of producers and consumers, refer to the documentation:
Reliability, Availability, and Serviceability (RAS) Architecture Extension

Second, explain why writing to user memory don't matter.

Don't matter means that we will not deal with it in this patchset, but 
follow the current strategy of the kernel(kernel panic). Take 
copy_from[to]_user/get[put]_user as an example:

1. In copy_to_user()/put_user(), it read the kernel page and write to 
user page, We cannot judge the importance of this kernel page that holds 
kernel data, if a memory error is encountered while reading, the normal 
operation of the system after recovery cannot be guaranteed，so the 
current processing strategy of the kernel is panic,we will not change this.

2. In copy_from_user()/get_user(), it read the user page and write to 
kernel page in user process context, this user data is only critical to 
this user process and does not affect the operation of the whole system. 
Therefore, if a memory error is encountered while reading, we can 
recover by killing this process and isolating the error user page 
without going to kernel panic, This patchset is aimed at this situation.
> 
>> 3. cow(copy on write).
>> 4. pagecache reading.
> 
> There are a bunch of other places where we'll access user memory via the linear
> map, so I assume this is just a best-effort "try not to die" rather than "never
> die" ?
> 
> Are there other places we might need/want to expand this to in future?
> 
> Thanks,
> Mark.

Yes.

The strategy is "try not to die" in some specific scene.

In both cases(cow and pagecache reading), when the page with memory 
error is read in user process context, the result is not fatal, because 
the data of the error page is only critical to the user process. Killing 
the process and isolating the error page will not affect the normal 
operation of the system.


I hope I can explain this clearly.

Great thanks to mark and I hope James can help take a look at this idea.

Thanks.
Tong.
> 
>> These four scenarios have similarities. Although the error is consumed in
>> the kernel state, but the consumed data belongs to the user state.
>>
>> The processing scheme is based on CONFIG_ARCH_HAS_COPY_MC and uses the
>> process killing plus isolate error page to replace kernel panic.
>>
>> [1]https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/
>>
>> Since V2:
>>   1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
>>     ARM64_UCE_KERNEL_RECOVERY.
>>   2.Add two new scenarios, cow and pagecache reading.
>>   3.Fix two small bug(the first two patch).
>>
>> Tong Tiangen (7):
>>    x86: fix copy_mc_to_user compile error
>>    arm64: fix page_address return value in copy_highpage
>>    arm64: add support for machine check error safe
>>    arm64: add copy_from_user to machine check safe
>>    arm64: add get_user to machine check safe
>>    arm64: add cow to machine check safe
>>    arm64: add pagecache reading to machine check safe
>>
>>   arch/arm64/Kconfig                   |  1 +
>>   arch/arm64/include/asm/asm-extable.h | 25 +++++++
>>   arch/arm64/include/asm/asm-uaccess.h | 16 +++++
>>   arch/arm64/include/asm/esr.h         |  5 ++
>>   arch/arm64/include/asm/extable.h     |  2 +-
>>   arch/arm64/include/asm/page.h        | 10 +++
>>   arch/arm64/include/asm/uaccess.h     | 17 ++++-
>>   arch/arm64/kernel/probes/kprobes.c   |  2 +-
>>   arch/arm64/lib/Makefile              |  2 +
>>   arch/arm64/lib/copy_from_user.S      | 11 ++--
>>   arch/arm64/lib/copy_page_mc.S        | 98 ++++++++++++++++++++++++++++
>>   arch/arm64/lib/copy_to_user_mc.S     | 78 ++++++++++++++++++++++
>>   arch/arm64/mm/copypage.c             | 36 ++++++++--
>>   arch/arm64/mm/extable.c              | 21 +++++-
>>   arch/arm64/mm/fault.c                | 30 ++++++++-
>>   arch/x86/include/asm/uaccess.h       |  1 +
>>   include/linux/highmem.h              |  8 +++
>>   include/linux/uaccess.h              |  8 +++
>>   include/linux/uio.h                  |  9 ++-
>>   lib/iov_iter.c                       | 85 +++++++++++++++++++-----
>>   mm/memory.c                          |  2 +-
>>   21 files changed, 432 insertions(+), 35 deletions(-)
>>   create mode 100644 arch/arm64/lib/copy_page_mc.S
>>   create mode 100644 arch/arm64/lib/copy_to_user_mc.S
>>
>> -- 
>> 2.18.0.huawei.25
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
