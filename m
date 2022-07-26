Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B6580EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiGZIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237981AbiGZIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:10:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A52BB1DF;
        Tue, 26 Jul 2022 01:10:33 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LsTzZ6Nv9zjWxv;
        Tue, 26 Jul 2022 16:07:38 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 16:10:27 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 16:10:25 +0800
Subject: Re: [PATCH 1/5] ARM: stacktrace: Skip frame pointer boundary check
 for call_with_stack()
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>,
        <ardb@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <nick.hawkins@hpe.com>, <john@phrozen.org>,
        <mhiramat@kernel.org>, <ast@kernel.org>, <linyujun809@huawei.com>,
        <ndesaulniers@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Li Huafei <lihuafei1@huawei.com>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-2-lihuafei1@huawei.com>
 <CACRpkdaXDGHLwqXQsEedRt=CLRUe1hei1vJDGAQ+D4U0OPcv8Q@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <ab843b1e-9a4f-7b2c-a9bb-670797f7da34@huawei.com>
Date:   Tue, 26 Jul 2022 16:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaXDGHLwqXQsEedRt=CLRUe1hei1vJDGAQ+D4U0OPcv8Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Hi Linus, sorry for the late reply.

On 2022/7/18 16:57, Linus Walleij wrote:
> On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:
>
>> When using the frame pointer unwinder, it was found that the stack trace
>> output of stack_trace_save() is incomplete if the stack contains
>> call_with_stack():
>>
>>   [0x7f00002c] dump_stack_task+0x2c/0x90 [hrtimer]
>>   [0x7f0000a0] hrtimer_hander+0x10/0x18 [hrtimer]
>>   [0x801a67f0] __hrtimer_run_queues+0x1b0/0x3b4
>>   [0x801a7350] hrtimer_run_queues+0xc4/0xd8
>>   [0x801a597c] update_process_times+0x3c/0x88
>>   [0x801b5a98] tick_periodic+0x50/0xd8
>>   [0x801b5bf4] tick_handle_periodic+0x24/0x84
>>   [0x8010ffc4] twd_handler+0x38/0x48
>>   [0x8017d220] handle_percpu_devid_irq+0xa8/0x244
>>   [0x80176e9c] generic_handle_domain_irq+0x2c/0x3c
>>   [0x8052e3a8] gic_handle_irq+0x7c/0x90
>>   [0x808ab15c] generic_handle_arch_irq+0x60/0x80
>>   [0x8051191c] call_with_stack+0x1c/0x20
>>
>> For the frame pointer unwinder, unwind_frame() checks stackframe::fp by
>> stackframe::sp. Since call_with_stack() switches the SP from one stack
>> to another, stackframe::fp and stackframe: :sp will point to different
>> stacks, so we can no longer check stackframe::fp by stackframe::sp. Skip
>> checking stackframe::fp at this point to avoid this problem.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Very nice catch! Took me some time to realize what was
> going on here.

Yeah, it took me some time to discover the cause of the problem too.

>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

>
> Nitpick below:
>
>> +       /*
>> +        * call_with_stack() is the only place we allow SP to jump from one
>> +        * stack to another, with FP and SP pointing to different stacks,
>> +        * skipping the FP boundary check at this point.
>> +        */
>> +       if (pc >= (unsigned long)&call_with_stack &&
>> +                       pc < (unsigned long)&call_with_stack_end)
>> +               return 0;
> Can we create a local helper macro to do this, if it needs to happen
> some other time?

Hopefully this won't come up again.:(

Maybe it would be better to define a macro when this happens?


Thanks,

Huafei

>
> #define ARM_PC_IN_FUNCTION(pc, func) (pc >=. ...)
>
> Yours,
> Linus Walleij
> .
