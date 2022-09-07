Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40975B0201
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGKku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIGKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:40:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F39533377
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:40:43 -0700 (PDT)
Received: from [192.168.137.220] (unknown [171.223.99.244])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOIidRhjDZ8TAA--.15177S3;
        Wed, 07 Sep 2022 18:40:35 +0800 (CST)
Message-ID: <09c35d21-67dc-bbe5-532a-a41797bfe0fc@loongson.cn>
Date:   Wed, 7 Sep 2022 18:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 10/10] LoongArch/ftrace: Fix unwind state when option
 func_stack_trace
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jeff Xie <xiehuan09@gmail.com>
References: <20220907100626.32657-1-zhangqing@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <20220907100626.32657-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxYOIidRhjDZ8TAA--.15177S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw17Xw17tF18GFW8GrW3Jrb_yoWrWw17pF
        95CF95WF4FgryI9rnrXr1Uur95Cr9ayr12gF9rJ34rCFnFqF1fXrn0k3s8Zan5J3ykGF1x
        XFnYkrya9w4UtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
        ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/7 18:06, Qing Zhang wrote:

> Ftrace plays like function head exception, prologue analysis will stop soon
> because PC is at entry.
>
>     90000000004c5a54 <callee>:
>     90000000004c5a54:	03400000  andi   $zero, $zero, 0x0   ==>move  t0, ra
>     90000000004c5a58:	03400000  andi   $zero, $zero, 0x0   ==>bl callsite
> ==>90000000004c5a5c:	02fcc063  addi.d $sp, $sp, -208(0xf30)
>     ...
>
> When encountering ftrace_call, save trace function ra at PT_ERA, save parent ra
> at PT_R1, At this time, pc is the position after the two nops of callee. There is
> no conventional prologue operation between this position and the function entry,
> so we need to resetthe first flag to make the caller continue to unwind.
>
> testing method:
>    echo path_openat > ./set_ftrace_filter
>    echo 1 > ./options/func_stack_trace
>    echo function > ./current_tracer
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   arch/loongarch/include/asm/unwind.h     |  2 +-
>   arch/loongarch/kernel/unwind_prologue.c | 33 +++++++++++++++++++++----
>   2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> index f66b07c3e6a1..f2b52b9ea93d 100644
> --- a/arch/loongarch/include/asm/unwind.h
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -20,7 +20,7 @@ struct unwind_state {
>   	char type; /* UNWINDER_XXX */
>   	struct stack_info stack_info;
>   	struct task_struct *task;
> -	bool first, error;
> +	bool first, error, is_ftrace;
>   	int graph_idx;
>   	unsigned long sp, pc, ra;
>   };
> diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
> index 03f8b31a90cc..0bb19d3ae8ba 100644
> --- a/arch/loongarch/kernel/unwind_prologue.c
> +++ b/arch/loongarch/kernel/unwind_prologue.c
> @@ -14,9 +14,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
>   
>   	if (unwind_done(state))
>   		return 0;
> -	else if (state->type)
> -		return state->pc;
> -	else if (state->first)
> +	else if (state->type || state->first)
>   		return state->pc;
>   
>   	return *(unsigned long *)(state->sp);
> @@ -42,16 +40,39 @@ static bool unwind_by_guess(struct unwind_state *state)
>   	return false;
>   }
>   
> +static void unwind_state_fixup(struct unwind_state *state)
> +{
> +	static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
> +
> +	if (state->pc == ftrace_case)
> +		state->is_ftrace = true;
> +}
> +
>   static bool unwind_by_prologue(struct unwind_state *state)
>   {
>   	struct stack_info *info = &state->stack_info;
>   	union loongarch_instruction *ip, *ip_end;
>   	unsigned long frame_size = 0, frame_ra = -1;
>   	unsigned long size, offset, pc = state->pc;
> +	struct pt_regs *regs;
>   
>   	if (state->sp >= info->end || state->sp < info->begin)
>   		return false;
>   
> +	if (state->is_ftrace) {
> +		/*
> +		 * As we meet ftrace_regs_entry, reset first flag like first doing
> +		 * tracing, Prologue analysis will stop soon because PC is at entry.
> +		 */
> +		regs = (struct pt_regs *)state->sp;
> +		state->pc = regs->csr_era;
> +		state->ra = regs->regs[1];
> +		state->sp = regs->regs[3];
> +		state->first = true;
> +		state->is_ftrace = false;
> +		return true;
> +	}
> +
>   	if (!kallsyms_lookup_size_offset(pc, &size, &offset))
>   		return false;
>   
> @@ -97,7 +118,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
>   
>   	state->pc = *(unsigned long *)(state->sp + frame_ra);
>   	state->sp = state->sp + frame_size;
> -	return !!__kernel_text_address(state->pc);
> +	goto out;
>   
>   first:
>   	state->first = false;
> @@ -106,7 +127,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
>   
>   	state->pc = state->ra;
>   
> -	return !!__kernel_text_address(state->ra);
> +out:
> +	unwind_state_fixup(state);
> +	return !!__kernel_text_address(state->pc);
>   }
>   
>   void unwind_start(struct unwind_state *state, struct task_struct *task,

Hi, Qing

Additional 'Reported-by: Jeff Xie <xiehuan09@gmail.com>' is welcome.

For this patch, Tested-by: Jinyang He <hejinyang@loongson.cn>.


Thanks,

Jinyang

