Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EBF580F96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiGZJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:10:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C311146;
        Tue, 26 Jul 2022 02:10:27 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsWHW4DqlzWfMc;
        Tue, 26 Jul 2022 17:06:31 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:10:24 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:10:23 +0800
Subject: Re: [PATCH 2/5] ARM: stacktrace: Avoid duplicate saving of exception
 PC value
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
 <20220712021527.109921-3-lihuafei1@huawei.com>
 <CACRpkdY0Jo7rzXjc10dLLrHnDkoBphvNYiyF5q8iHz-8QqaEwA@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <f7654dfb-15cb-6563-4669-ad2457daa9d1@huawei.com>
Date:   Tue, 26 Jul 2022 17:10:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdY0Jo7rzXjc10dLLrHnDkoBphvNYiyF5q8iHz-8QqaEwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/7/18 17:01, Linus Walleij wrote:
> On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> Because an exception stack frame is not created in the exception entry,
>> save_trace() does special handling for the exception PC, but this is
>> only needed when CONFIG_FRAME_POINTER_UNWIND=y. When
>> CONFIG_ARM_UNWIND=y, unwind annotations have been added to the exception
>> entry and save_trace() will repeatedly save the exception PC:
>>
>>     [0x7f000090] hrtimer_hander+0x8/0x10 [hrtimer]
>>     [0x8019ec50] __hrtimer_run_queues+0x18c/0x394
>>     [0x8019f760] hrtimer_run_queues+0xbc/0xd0
>>     [0x8019def0] update_process_times+0x34/0x80
>>     [0x801ad2a4] tick_periodic+0x48/0xd0
>>     [0x801ad3dc] tick_handle_periodic+0x1c/0x7c
>>     [0x8010f2e0] twd_handler+0x30/0x40
>>     [0x80177620] handle_percpu_devid_irq+0xa0/0x23c
>>     [0x801718d0] generic_handle_domain_irq+0x24/0x34
>>     [0x80502d28] gic_handle_irq+0x74/0x88
>>     [0x8085817c] generic_handle_arch_irq+0x58/0x78
>>     [0x80100ba8] __irq_svc+0x88/0xc8
>>     [0x80108114] arch_cpu_idle+0x38/0x3c
>>     [0x80108114] arch_cpu_idle+0x38/0x3c    <==== duplicate saved exception PC
>>     [0x80861bf8] default_idle_call+0x38/0x130
>>     [0x8015d5cc] do_idle+0x150/0x214
>>     [0x8015d978] cpu_startup_entry+0x18/0x1c
>>     [0x808589c0] rest_init+0xd8/0xdc
>>     [0x80c00a44] arch_post_acpi_subsys_init+0x0/0x8
>>
>> We can move the special handling of the exception PC in save_trace() to
>> the unwind_frame() of the frame pointer unwinder.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> This is another very nice patch!
> Reviewed-by: Linus Waleij <linus.walleij@linaro.org>
> 
> Nitpick:
> 
>> +               if ((unsigned long)&regs[1] > ALIGN(frame->sp, THREAD_SIZE))
>> +                       return -EINVAL;
> 
> It'd be nice to add a comment saying what is in regs[1] at this point
> so it is easier to understand the code. Not your fault as it is just
> moved code, but if you have time please add a small comment.
> 

It is necessary to add the comment. This check is to ensure that 'regs +
sizeof(struct pt_regs)' (that is, &regs[1]) does not go beyond the
bottom of the stack, to avoid accessing data outside the task's stack,
see commit 40ff1ddb5570 ("ARM: 8948/1: Prevent OOB access in
stacktrace") for details. I will add a comment in the next version.

Thanks,
Huafei

> Yours,
> Linus Walleij
> .
> 
