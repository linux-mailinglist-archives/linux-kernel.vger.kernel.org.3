Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246535B122D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIHBjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHBjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:39:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 468CE1CB31
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:39:47 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmvbRxljXg8UAA--.4581S3;
        Thu, 08 Sep 2022 09:39:39 +0800 (CST)
Subject: Re: [PATCH v3 10/10] LoongArch/ftrace: Fix unwind state when option
 func_stack_trace
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jeff Xie <xiehuan09@gmail.com>
References: <20220907100626.32657-1-zhangqing@loongson.cn>
 <09c35d21-67dc-bbe5-532a-a41797bfe0fc@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <c5e470aa-f9c4-fcf4-6dbe-35558bbec752@loongson.cn>
Date:   Thu, 8 Sep 2022 09:38:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09c35d21-67dc-bbe5-532a-a41797bfe0fc@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmvbRxljXg8UAA--.4581S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW7WF13AFWkWFyxAF1UJrb_yoW7WryrpF
        95AFyrGrWrWrn3Gr17Jr1UZr98Ar1Iy3ZrKrykXa4rCFsrJr1Iqr1jvryq9F4DJrWkGr18
        Xr1rXr9I9r4UJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbNzVUUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 2022/9/7 下午6:40, Jinyang He wrote:
> On 2022/9/7 18:06, Qing Zhang wrote:
> 
>> Ftrace plays like function head exception, prologue analysis will stop 
>> soon
>> because PC is at entry.
>>
>>     90000000004c5a54 <callee>:
>>     90000000004c5a54:    03400000  andi   $zero, $zero, 0x0   ==>move  
>> t0, ra
>>     90000000004c5a58:    03400000  andi   $zero, $zero, 0x0   ==>bl 
>> callsite
>> ==>90000000004c5a5c:    02fcc063  addi.d $sp, $sp, -208(0xf30)
>>     ...
>>
>> When encountering ftrace_call, save trace function ra at PT_ERA, save 
>> parent ra
>> at PT_R1, At this time, pc is the position after the two nops of 
>> callee. There is
>> no conventional prologue operation between this position and the 
>> function entry,
>> so we need to resetthe first flag to make the caller continue to unwind.
>>
>> testing method:
>>    echo path_openat > ./set_ftrace_filter
>>    echo 1 > ./options/func_stack_trace
>>    echo function > ./current_tracer
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/unwind.h     |  2 +-
>>   arch/loongarch/kernel/unwind_prologue.c | 33 +++++++++++++++++++++----
>>   2 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/unwind.h 
>> b/arch/loongarch/include/asm/unwind.h
>> index f66b07c3e6a1..f2b52b9ea93d 100644
>> --- a/arch/loongarch/include/asm/unwind.h
>> +++ b/arch/loongarch/include/asm/unwind.h
>> @@ -20,7 +20,7 @@ struct unwind_state {
>>       char type; /* UNWINDER_XXX */
>>       struct stack_info stack_info;
>>       struct task_struct *task;
>> -    bool first, error;
>> +    bool first, error, is_ftrace;
>>       int graph_idx;
>>       unsigned long sp, pc, ra;
>>   };
>> diff --git a/arch/loongarch/kernel/unwind_prologue.c 
>> b/arch/loongarch/kernel/unwind_prologue.c
>> index 03f8b31a90cc..0bb19d3ae8ba 100644
>> --- a/arch/loongarch/kernel/unwind_prologue.c
>> +++ b/arch/loongarch/kernel/unwind_prologue.c
>> @@ -14,9 +14,7 @@ unsigned long unwind_get_return_address(struct 
>> unwind_state *state)
>>       if (unwind_done(state))
>>           return 0;
>> -    else if (state->type)
>> -        return state->pc;
>> -    else if (state->first)
>> +    else if (state->type || state->first)
>>           return state->pc;
>>       return *(unsigned long *)(state->sp);
>> @@ -42,16 +40,39 @@ static bool unwind_by_guess(struct unwind_state 
>> *state)
>>       return false;
>>   }
>> +static void unwind_state_fixup(struct unwind_state *state)
>> +{
>> +    static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
>> +
>> +    if (state->pc == ftrace_case)
>> +        state->is_ftrace = true;
>> +}
>> +
>>   static bool unwind_by_prologue(struct unwind_state *state)
>>   {
>>       struct stack_info *info = &state->stack_info;
>>       union loongarch_instruction *ip, *ip_end;
>>       unsigned long frame_size = 0, frame_ra = -1;
>>       unsigned long size, offset, pc = state->pc;
>> +    struct pt_regs *regs;
>>       if (state->sp >= info->end || state->sp < info->begin)
>>           return false;
>> +    if (state->is_ftrace) {
>> +        /*
>> +         * As we meet ftrace_regs_entry, reset first flag like first 
>> doing
>> +         * tracing, Prologue analysis will stop soon because PC is at 
>> entry.
>> +         */
>> +        regs = (struct pt_regs *)state->sp;
>> +        state->pc = regs->csr_era;
>> +        state->ra = regs->regs[1];
>> +        state->sp = regs->regs[3];
>> +        state->first = true;
>> +        state->is_ftrace = false;
>> +        return true;
>> +    }
>> +
>>       if (!kallsyms_lookup_size_offset(pc, &size, &offset))
>>           return false;
>> @@ -97,7 +118,7 @@ static bool unwind_by_prologue(struct unwind_state 
>> *state)
>>       state->pc = *(unsigned long *)(state->sp + frame_ra);
>>       state->sp = state->sp + frame_size;
>> -    return !!__kernel_text_address(state->pc);
>> +    goto out;
>>   first:
>>       state->first = false;
>> @@ -106,7 +127,9 @@ static bool unwind_by_prologue(struct unwind_state 
>> *state)
>>       state->pc = state->ra;
>> -    return !!__kernel_text_address(state->ra);
>> +out:
>> +    unwind_state_fixup(state);
>> +    return !!__kernel_text_address(state->pc);
>>   }
>>   void unwind_start(struct unwind_state *state, struct task_struct *task,
> 
> Hi, Qing
> 
> Additional 'Reported-by: Jeff Xie <xiehuan09@gmail.com>' is welcome.
> 
> For this patch, Tested-by: Jinyang He <hejinyang@loongson.cn>.
> 
ok, I will add relevant Reported and Tested tags, wait for other
people's comments on the series before this. ping Steven manually. :)

Thanks,
-Qing
> 
> Thanks,
> 
> Jinyang
> 

