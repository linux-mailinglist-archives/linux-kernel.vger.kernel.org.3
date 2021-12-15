Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFD475196
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbhLOEIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:08:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32922 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhLOEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:08:06 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDMCk1p1Zzcbl4;
        Wed, 15 Dec 2021 12:07:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 12:08:03 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 12:08:03 +0800
Message-ID: <8aa4e5a7-12c4-2c46-374b-761279761738@huawei.com>
Date:   Wed, 15 Dec 2021 12:08:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v4] arm64: Enable KCSAN
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Joey Gouly <joey.gouly@arm.com>
References: <20211211131734.126874-1-wangkefeng.wang@huawei.com>
 <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YbjhUaEP4Sqk7qRP@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/15 2:24, Mark Rutland wrote:
> On Sat, Dec 11, 2021 at 09:17:34PM +0800, Kefeng Wang wrote:
>> This patch enables KCSAN for arm64, with updates to build rules
>> to not use KCSAN for several incompatible compilation units.
>>
>> Recent GCC version(at least GCC10) made outline-atomics as the
>> default option(unlike Clang), which will cause linker errors
>> for kernel/kcsan/core.o. Disables the out-of-line atomics by
>> no-outline-atomics to fix the linker errors.
>>
>> Meanwhile, as Mark said[1], some latent issues are needed to be
>> fixed which isn't just a KCSAN problem, we make the KCSAN depends
>> on EXPERT for now.
>>
>> Tested selftest and kcsan_test(built with GCC11 and Clang 13),
>> and all passed.
>>
>> [1] https://lkml.kernel.org/r/YadiUPpJ0gADbiHQ@FVFF77S0Q05N
>> Acked-by: Marco Elver <elver@google.com> # kernel/kcsan
>> Tested-by: Joey Gouly <joey.gouly@arm.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>
>> Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3 by Kefeng.
>> Tested with gcc 11 and clang 14.0 (built from git) on qemu and FVP by Joey.
> Hi,
>
> Sorry for the silence on v3; I got a little busy elsewhere and wasn't able to
> test that, but I have given this v4 a fairly intensive test with KCSAN combined
> with other config options I use when fuzzing.
>
> I eyeballed the output from a bunch of compilers (noted below), and there's
> still a fair amount of potentially-unsound instrumentation, but I'm happy with
> that so long as we have the EXPERT dependency. I agree we can fix those
> (latent) issues with follow-up work.
>
> I have one minor comment below about adding a comment, but aside from that,
> this looks good and I didn't encounter any unexpected issues while testing, so:
>
>    Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>    Tested-by: Mark Rutland <mark.rutland@arm.com>
Many thanks for your , Mark.
>> v4:
>> - drop Clang version as commit 8cdd23c23c3d ("arm64: Restrict ARM64_BTI_KERNEL
>>    to clang 12.0.0 and newer"), suggested by Nathan Chancellor
>> v3:
>> - add EXPERT and CLANG_VERSION depends suggested by Mark Rutland
>> v2:
>> - tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
>>    suggested by Marco Elver
>>
>>   arch/arm64/Kconfig               | 1 +
>>   arch/arm64/kernel/vdso/Makefile  | 1 +
>>   arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
>>   kernel/kcsan/Makefile            | 1 +
>>   4 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4ff73299f8a9..2cc9dea55e00 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -150,6 +150,7 @@ config ARM64
>>   	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>>   	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
>>   	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
>> +	select HAVE_ARCH_KCSAN if EXPERT
> It might be worth adding:
>
> 	/* Some instrumentation may be unsound */
>
> ... immediately above this to clarify why we added the EXPERT dependency here.
>
> Other than that trivial comment, this looks good to me!
>
> For future reference, below is an info dump about how I've tested this, and
> which latent issues KCSAN reported during testing. Feel free to ignore for now.
> :)

Our tester wants  this feature to test our kernel, this is  a good start 
on ARM64,

more people could be getting involved to enhance it, We could fix the KCSAN

Warning one by one :)

>
> ... the summary of which is below:
>
> * BUG: KCSAN: data-race in capable / cgroup_freezer_migrate_task
> * BUG: KCSAN: data-race in console_unlock / vprintk_emit
> * BUG: KCSAN: data-race in __d_add / __d_add
> * BUG: KCSAN: data-race in __do_sys_prctl / do_task_stat
> * BUG: KCSAN: data-race in do_task_stat / sigprocmask
> * BUG: KCSAN: data-race in ep_modify / ep_poll_callback
> * BUG: KCSAN: data-race in _find_next_bit+0x60/0x194
> * BUG: KCSAN: data-race in folio_mark_accessed / workingset_activation
> * BUG: KCSAN: data-race in ktime_get / timekeeping_advance
> * BUG: KCSAN: data-race in more_used_split+0x38/0x60
> * BUG: KCSAN: data-race in mutex_spin_on_owner+0xcc/0x150
> * BUG: KCSAN: data-race in rwsem_spin_on_owner+0xa8/0x13c
> * BUG: KCSAN: data-race in start_dir_add+0x34/0xd4
> * BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_idle_stop_tick
> * BUG: KCSAN: data-race in timekeeping_delta_to_ns+0x34/0x94
> * BUG: KCSAN: data-race in virtqueue_get_buf_ctx+0xe8/0x458
> * BUG: KCSAN: data-race in virtqueue_get_buf_ctx_split+0x68/0x2dc
> * BUG: KCSAN: data-race in vprintk_emit+0x320/0x494
>
> By far the most commonly reported races were in "{mutex,rwsem}_spin_on_owner",
> followed by "timekeeping_delta_to_ns" followed by "virtqueue_get_buf_ctx*". So
> those look like the ones to focus on in the near term.
>
> When using GCC I would very often see reports I didn't see with LLVM, for
> "vprintk_emit" and "ktime_get / timekeeping_advance". I don't know if that's
> down to something getting optimized away or something getting instrumented
> differently.
>
