Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFC580FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiGZJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGZJM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:12:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461EA2E9C6;
        Tue, 26 Jul 2022 02:12:55 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsWMY0W42z1M8PF;
        Tue, 26 Jul 2022 17:10:01 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:12:40 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 17:12:39 +0800
Subject: Re: [PATCH 3/5] ARM: stacktrace: Allow stack trace saving for
 non-current tasks
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
 <20220712021527.109921-4-lihuafei1@huawei.com>
 <CACRpkdYvOjfmf=Z3pGfD-UPxfTc9PXtOyw2x+ptYiSy=gmGnpQ@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <1288c73b-cf29-707d-47cb-4e2737300a29@huawei.com>
Date:   Tue, 26 Jul 2022 17:12:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYvOjfmf=Z3pGfD-UPxfTc9PXtOyw2x+ptYiSy=gmGnpQ@mail.gmail.com>
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



On 2022/7/18 17:07, Linus Walleij wrote:
> On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:
> 
>> The current ARM implementation of save_stack_trace_tsk() does not allow
>> saving stack trace for non-current tasks, which may limit the scenarios
>> in which stack_trace_save_tsk() can be used. Like other architectures,
>> or like ARM's unwind_backtrace(), we can leave it up to the caller to
>> ensure that the task that needs to be unwound is not running.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> That sounds good, but:
> 
>>         if (tsk != current) {
>> -#ifdef CONFIG_SMP
>> -               /*
>> -                * What guarantees do we have here that 'tsk' is not
>> -                * running on another CPU?  For now, ignore it as we
>> -                * can't guarantee we won't explode.
>> -                */
>> -               return;
>> -#else
>> +               /* task blocked in __switch_to */
> 
> The commit text is not consistent with the comment you are removing.
> 
> The commit is talking about "non-current" tasks which is one thing,
> but the code is avoiding any tasks under SMP because they may be
> running on another CPU. So you need to update the commit
> message to say something like "non-current or running on another CPU".
> 
> If this condition will be checked at call sites in following patches,
> then mention
> that in the commit as well, so we know the end result is that we do
> not break it,

The generic code stack_trace_save_tsk() does not have this check, and by
'caller' I mean the caller of stack_trace_save_tsk(), expecting the
'caller' to ensure that the task is not running. So in effect this check
has been dropped and there is no more guarantee. Sorry for not
clarifying the change here.

But can we assume that the user should know that the stacktrace is
unreliable for a task that is running on another CPU? If not, I should
remove this patch and keep the check.

Thanks,
Huafei
> 
> I think Russell want to check this commit as well,
> 
> Yours,
> Linus Walleij
> .
> 
