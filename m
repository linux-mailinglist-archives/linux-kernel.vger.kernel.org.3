Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614515812D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbiGZMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbiGZMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:08:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50592B252;
        Tue, 26 Jul 2022 05:08:23 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsbDl1C8HzWfWq;
        Tue, 26 Jul 2022 20:04:23 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 20:08:15 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 20:08:14 +0800
Subject: Re: [PATCH 3/5] ARM: stacktrace: Allow stack trace saving for
 non-current tasks
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Linus Walleij <linus.walleij@linaro.org>, <ardb@kernel.org>,
        <will@kernel.org>, <mark.rutland@arm.com>, <broonie@kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <nick.hawkins@hpe.com>, <john@phrozen.org>, <mhiramat@kernel.org>,
        <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-4-lihuafei1@huawei.com>
 <CACRpkdYvOjfmf=Z3pGfD-UPxfTc9PXtOyw2x+ptYiSy=gmGnpQ@mail.gmail.com>
 <1288c73b-cf29-707d-47cb-4e2737300a29@huawei.com>
 <Yt+4qSeIM0WbjcJj@shell.armlinux.org.uk>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <d1605c5a-1dfb-65b6-f79f-9c92bb507d4b@huawei.com>
Date:   Tue, 26 Jul 2022 20:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <Yt+4qSeIM0WbjcJj@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/26 17:49, Russell King (Oracle) wrote:
> On Tue, Jul 26, 2022 at 05:12:39PM +0800, Li Huafei wrote:
>>
>>
>> On 2022/7/18 17:07, Linus Walleij wrote:
>>> On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:
>>>
>>>> The current ARM implementation of save_stack_trace_tsk() does not allow
>>>> saving stack trace for non-current tasks, which may limit the scenarios
>>>> in which stack_trace_save_tsk() can be used. Like other architectures,
>>>> or like ARM's unwind_backtrace(), we can leave it up to the caller to
>>>> ensure that the task that needs to be unwound is not running.
>>>>
>>>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>>>
>>> That sounds good, but:
>>>
>>>>         if (tsk != current) {
>>>> -#ifdef CONFIG_SMP
>>>> -               /*
>>>> -                * What guarantees do we have here that 'tsk' is not
>>>> -                * running on another CPU?  For now, ignore it as we
>>>> -                * can't guarantee we won't explode.
>>>> -                */
>>>> -               return;
>>>> -#else
>>>> +               /* task blocked in __switch_to */
>>>
>>> The commit text is not consistent with the comment you are removing.
>>>
>>> The commit is talking about "non-current" tasks which is one thing,
>>> but the code is avoiding any tasks under SMP because they may be
>>> running on another CPU. So you need to update the commit
>>> message to say something like "non-current or running on another CPU".
>>>
>>> If this condition will be checked at call sites in following patches,
>>> then mention
>>> that in the commit as well, so we know the end result is that we do
>>> not break it,
>>
>> The generic code stack_trace_save_tsk() does not have this check, and by
>> 'caller' I mean the caller of stack_trace_save_tsk(), expecting the
>> 'caller' to ensure that the task is not running. So in effect this check
>> has been dropped and there is no more guarantee. Sorry for not
>> clarifying the change here.
> 
> Can you prove in every case that the thread we're being asked to unwind
> is not running? I don't think you can.
> 
> There are things like proc_pid_stack() in procfs and the stack traces
> in sysrq-t which have attempted to unwind everything whether it's
> running or not.
> 
> So no, there is no guarantee that the thread is blocked in
> __switch_to().
> 

Yes, I agree.

>> But can we assume that the user should know that the stacktrace is
>> unreliable for a task that is running on another CPU? If not, I should
>> remove this patch and keep the check.
> 
> It's not about "unreliable" stack traces, it's about the unwinder
> killing the kernel.
> 
> The hint is this:
> 
>                 frame.fp = thread_saved_fp(tsk);
>                 frame.sp = thread_saved_sp(tsk);
>                 frame.lr = 0;           /* recovered from the stack */
>                 frame.pc = thread_saved_pc(tsk);
> 
> These access the context saved by the scheduler when the task is
> sleeping. When the thread is running, these saved values will be
> the state when the thread last slept. However, with the thread
> running, the stack could now contain any data what so ever, and
> could change at any moment.
> 

I get it. For example, since the data on the stack is changing,
'*(unsigned long *)fp' could access any illegal address and crash the
kernel.

> Whether the unwind-table unwinder is truely safe in such a
> situation is unknown - we try to ensure that it won't do anything
> stupid, but proving that is a hard task, and we've recently had
> issues with the unwinder even without that.
> 
> So, allowing this feels like we're opening the door to DoS attacks
> from userspace, where userspace sits there reading /proc/*/stack of
> some thread running on a different CPU waiting for the kernel to
> oops itself, possibly holding a lock, resulting in the system
> dying.
> 
> These decisions need to be made by architecture code not generic
> code, particularly where the method of unwinding is architecture
> specific and thus may have criteria defining when its safe to do so.
> 

Thank you for your comments, I'll remove the patch and keep the check.

Thanks,
Huafei
