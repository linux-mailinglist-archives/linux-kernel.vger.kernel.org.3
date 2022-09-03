Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38F5ABBE2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiICAjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiICAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:39:12 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B291AA354
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:39:10 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmsjohJjGj8QAA--.55594S3;
        Sat, 03 Sep 2022 08:39:00 +0800 (CST)
Subject: Re: [PATCH v2 3/9] LoongArch/ftrace: Add dynamic function tracer
 support
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
References: <20220826073114.1515-1-zhangqing@loongson.cn>
 <20220826073114.1515-4-zhangqing@loongson.cn>
 <CAEr6+EC9vtsPmj5f+b5iqJWOGyC7D5g+mpv01_ekzA9gQjgeAg@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <374ddd54-4c04-65cc-4097-c7a145c2c029@loongson.cn>
Date:   Sat, 3 Sep 2022 08:38:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEr6+EC9vtsPmj5f+b5iqJWOGyC7D5g+mpv01_ekzA9gQjgeAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrmsjohJjGj8QAA--.55594S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Xr18ZrW3tF1xuF4fAFb_yoW5JrW8pa
        93CanFkr1UZF4jyw10gr48Ary3ArWFyry5GFs8JryrCr9rCw1Fgr12qr1rCa9rA345GryI
        va4UZw1DXrn0va7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6w1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JU3DG5UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/1 上午10:59, Jeff Xie wrote:
> On Fri, Aug 26, 2022 at 4:24 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>>
>> The compiler has inserted 2 NOPs before the regular function prologue.
>> T series registers are available and safe because of LoongArch psABI.
>>
>> At runtime, replace nop with bl to enable ftrace call and replace bl with
>> nop to disable ftrace call. The bl requires us to save the original RA value,
>> so here it saves RA at t0.
>> details are:
>>
>> | Compiled   |       Disabled         |        Enabled         |
>> +------------+------------------------+------------------------+
>> | nop        | move     t0, ra        | move     t0, ra        |
>> | nop        | nop                    | bl      ftrace_caller  |
>> | func_body  | func_body              | func_body              |
>>
>> The RA value will be recovered by ftrace_regs_entry, and restored into RA
>> before returning to the regular function prologue. When a function is not
>> being traced, the move t0, ra is not harmful.
>>
>> 1) ftrace_make_call, ftrace_make_nop (in kernel/ftrace.c)
>>     The two functions turn each recorded call site of filtered functions
>>     into a call to ftrace_caller or nops.
>>
>> 2) ftracce_update_ftrace_func (in kernel/ftrace.c)
>>     turns the nops at ftrace_call into a call to a generic entry for
>>     function tracers.
>>
>> 3) ftrace_caller (in kernel/mcount-dyn.S)
>>     The entry where each _mcount call sites calls to once they are
>>     filtered to be traced.
>>
[...]
>>
> 
> When use the option func_stack_trace for the function tracer, I found a issue:
> 
> Steps:
> 1. Enable the function tracer and the option func_stack_trace:
> 
> /sys/kernel/tracing # echo blk_update_request > ./set_ftrace_filter
> /sys/kernel/tracing # echo 1 > ./options/func_stack_trace
> /sys/kernel/tracing # echo function > ./current_tracer
> 
> 2. Let the blk_update_request() be called.
> 
>   # mount /dev/vda /tmp
> 
> 
> 3. cat ./trace
>            <idle>-0       [000] ..s1.   126.016445: blk_update_request
> <-blk_mq_end_request
>            <idle>-0       [000] ..s1.   126.017937: <stack trace>
>   => blk_mq_end_request
> 
> We can see only one stack trace.
> 
> 
> I found the default unwinder(for loongson3_defconfig) is
> CONFIG_UNWINDER_PROLOGUE, if switch it to CONFIG_UNWINDER_GUESS
> it works well:
> 
[...]
> 
> Maybe the issue happened on the CONFIG_UNWINDER_PROLOGUE,  but I
> haven't dug deep into it ;)

Hi, Jeff

Thanks a lot for your feedback!

I fixed it in v3, which was caused by the ftrace_regs_entry assembly not 
being considered by the prologue analyze method. :)

regards
-Qing

> 

