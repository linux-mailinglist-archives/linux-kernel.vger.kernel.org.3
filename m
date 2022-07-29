Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA60584B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbiG2Fjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiG2Fje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:39:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5D027D7AF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:39:32 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxQ9CPcuNiiCpBAA--.27529S3;
        Fri, 29 Jul 2022 13:39:27 +0800 (CST)
Subject: Re: [PATCH 2/3] LoongArch: Add prologue unwinder support
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220728140519.5420-1-zhangqing@loongson.cn>
 <20220728140519.5420-2-zhangqing@loongson.cn>
 <ddddff68-cae3-24e7-d0b7-d08abc94baf2@loongson.cn>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <dc76df52-eb46-5039-a008-de3c9a7e3363@loongson.cn>
Date:   Fri, 29 Jul 2022 13:39:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ddddff68-cae3-24e7-d0b7-d08abc94baf2@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxQ9CPcuNiiCpBAA--.27529S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4UJr1fJr13ZFyUtF4Dtwb_yoWxXrW7pr
        1kAFZ5GrW7Grn5Jr1Utrn8ZF98Ar1kGw1DJF1kXF1UJr4UXry0gr15Wryv9F1UJr48Gr1U
        Ar15XrnruF17JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JU6mhwUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/29 上午10:14, Jinyang He wrote:
> Hi, Qing,
> 
> 
> On 07/28/2022 10:05 PM, Qing Zhang wrote:
>> It unwind the stack frame based on prologue code analyze.
>> CONFIG_KALLSYMS is needed, at least the address and length
>> of each function.
>>
>> Three stages when we do unwind,
>>    (1)unwind_start(), the prapare of unwinding, fill unwind_state.
>>    (2)unwind_done(), judge whether the unwind process is finished or not.
>>    (3)unwind_next_frame(), unwind the next frame.
>>
>> Dividing unwinder helps to add new unwinders in the future, eg:
>> unwind_frame, unwind_orc .etc
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>
>> +static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
>> +{
>> +    /* addi.d $sp, $sp, -imm */
>> +    return ip->reg2i12_format.opcode == addid_op &&
>> +        ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
>> +        ip->reg2i12_format.rd == LOONGARCH_GPR_SP &&
>> +        ip->reg2i12_format.immediate & (1 << 11);
> Checking the sign bit can be used in other place.
>> +}
>> +
>> +static inline bool is_ra_save_ins(union loongarch_instruction *ip)
>> +{
>> +    /* st.d $ra, $sp, offset */
>> +    return ip->reg2i12_format.opcode == std_op &&
>> +        ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
>> +        ip->reg2i12_format.rd == LOONGARCH_GPR_RA;
>> +}
>> +
>> +static inline bool is_branch_insn(union loongarch_instruction insn)
> Does it by using pointer parameter as above functions do.
>> +{
>> +    return insn.reg1i21_format.opcode >= beqz_op &&
>> +            insn.reg1i21_format.opcode <= bgeu_op;
>> +}
>> +
>>   u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>>   u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr 
>> rj, int imm);
>>   u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr 
>> rj, unsigned long pc, unsigned long dest);
>> diff --git a/arch/loongarch/include/asm/unwind.h 
>> b/arch/loongarch/include/asm/unwind.h
>> index 243330b39d0d..09394e536ea9 100644
>> --- a/arch/loongarch/include/asm/unwind.h
>> +++ b/arch/loongarch/include/asm/unwind.h
>> @@ -14,6 +14,10 @@
>>   struct unwind_state {
>>       struct stack_info stack_info;
>>       struct task_struct *task;
>> +#if defined(CONFIG_UNWINDER_PROLOGUE)
>> +    unsigned long ra;
>> +    bool enable;
> Annotating here is appreciating. Enable is the way of prologue analysis
> while !enable is the way of guess.
>> +#endif
>>       unsigned long sp, pc;
>>       bool first;
>>       bool error;
> [...]
>> +
>> +unsigned long unwind_get_return_address(struct unwind_state *state)
>> +{
>> +
>> +    if (unwind_done(state))
>> +        return 0;
>> +
>> +    if (state->enable)
>> +        return state->pc;
>> +    else if (state->first)
>> +        return state->pc;
> Combine conditions.
>> +
>> +    return *(unsigned long *)(state->sp);
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(unwind_get_return_address);
>> +
>> +static bool unwind_by_prologue(struct unwind_state *state)
>> +{
>> +    struct stack_info *info = &state->stack_info;
>> +    union loongarch_instruction *ip, *ip_end;
>> +    unsigned long frame_size = 0, frame_ra = -1;
>> +    unsigned long size, offset, pc = state->pc;
>> +
>> +    if (state->sp >= info->end || state->sp < info->begin)
>> +        return false;
>> +
>> +    if (!kallsyms_lookup_size_offset(pc, &size, &offset))
>> +        return false;
>> +
>> +    ip = (union loongarch_instruction *)(pc - offset);
>> +    ip_end = (union loongarch_instruction *)pc;
>> +
>> +    while (ip < ip_end) {
>> +        if (is_stack_alloc_ins(ip)) {
>> +            frame_size = (1 << 12) - ip->reg2i12_format.immediate;
> Due to there will be other place convert unsigned to signed, we have
> a chance that create a inline function in inst.h. Do it as same as
> checking the sign bit.Hi,
Jinyang

I will fix all in v2.
eg:
#define is_imm12_negative(val)  is_imm_negative(val, 12)
static inline bool is_imm_negative(unsigned long val, unsigned int bit)
{
         return val & (1UL << (bit-1));
}

static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
{
...
                 ip->reg2i12_format.rd == LOONGARCH_GPR_SP &&
                 is_imm12_negative(ip->reg2i12_format.immediate);
}

static inline bool is_ra_save_ins(union loongarch_instruction *ip)
{
...
                 !is_imm12_negative(ip->reg2i12_format.immediate);
}

Thanks,
Qing
> 
>> +            ip++;
>> +            break;
>> +        }
>> +        ip++;
>> +    }
>> +
> [...]
>> +
>> +    do {
>> +        if (state->enable) {
>> +            if (unwind_by_prologue(state))
>> +                return true;
>> +
>> +            if (info->type == STACK_TYPE_IRQ &&
>> +                info->end == state->sp) {
>> +                regs = (struct pt_regs *)info->next_sp;
>> +                pc = regs->csr_era;
>> +                if (user_mode(regs) || !__kernel_text_address(pc))
>> +                    return false;
>> +
>> +                state->pc = pc;
>> +                state->sp = regs->regs[3];
>> +                state->ra = regs->regs[1];
>> +                state->first = true;
>> +                get_stack_info(state->sp, state->task, info);
>> +
>> +                return true;
>> +            }
>> +        } else {
>> +            if (state->first)
>> +                state->first = false;
>> +
>> +            if (unwind_by_guess(state))
>> +                return true;
>> +        }
> I'd prefer separate the block of 'if...else...' into two inline
> functions, that makes codes clear.
> 
> Thanks,
> Jinyang

