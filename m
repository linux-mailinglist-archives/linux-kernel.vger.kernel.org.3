Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37BC5B2BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiIIBzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIIBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:55:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6A6248C9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:55:11 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MNzVZ5GGbzlVqy;
        Fri,  9 Sep 2022 09:51:18 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 09:55:09 +0800
Message-ID: <50a65f24-08b7-ab36-5e25-b6a90f90a9d8@huawei.com>
Date:   Fri, 9 Sep 2022 09:55:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] riscv/kprobe: Optimize the performance of patching
 instruction slot
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     Jisheng Zhang <jszhang@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <rostedt@goodmis.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220907023327.85630-1-liaochang1@huawei.com>
 <YxjTF2FlIJbbKq0p@xhacker> <a00328a1-47ee-3700-8cd8-1a9f4e0d7a2b@huawei.com>
 <20220908214958.c8139533dccad1ee8f927214@kernel.org>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20220908214958.c8139533dccad1ee8f927214@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/8 20:49, Masami Hiramatsu (Google) 写道:
> On Thu, 8 Sep 2022 09:43:45 +0800
> "liaochang (A)" <liaochang1@huawei.com> wrote:
> 
>> Thanks for comment.
>>
>> 在 2022/9/8 1:21, Jisheng Zhang 写道:
>>> On Wed, Sep 07, 2022 at 10:33:27AM +0800, Liao Chang wrote:
>>>> Since no race condition occurs on each instruction slot, hence it is
>>>> safe to patch instruction slot without stopping machine.
>>>
>>> hmm, IMHO there's race when arming kprobe under SMP, so stopping
>>> machine is necessary here. Maybe I misundertand something.
>>>
>>
>> It is indeed necessary to stop machine when arm kprobe under SMP,
>> but i don't think it need to stop machine when prepare instruction slot,
>> two reasons:
>>
>> 1. Instruction slot is dynamically allocated data.
>> 2. Kernel would not execute instruction slot until original instruction
>>    is replaced by breakpoint.
> 
> Ah, this is for ss (single step out of line) slot. So until
> kprobe is enabled, this should not be used from other cores.
> OK, then it should be safe.

Exactly, Masami, and i find out this optimization could be applied to some other
architectures, such as arm64 and csky, do you think it is good time to do them all.

Thanks.

> 
> 
>>>>
>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>> ---
>>>>  arch/riscv/kernel/probes/kprobes.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>>>> index e6e950b7cf32..eff7d7fab535 100644
>>>> --- a/arch/riscv/kernel/probes/kprobes.c
>>>> +++ b/arch/riscv/kernel/probes/kprobes.c
>>>> @@ -24,12 +24,14 @@ post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>>>  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>  {
>>>>  	unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>> +	const kprobe_opcode_t brk_insn = __BUG_INSN_32;
>>>> +	kprobe_opcode_t slot[MAX_INSN_SIZE];
>>>>  
>>>>  	p->ainsn.api.restore = (unsigned long)p->addr + offset;
>>>>  
>>>> -	patch_text(p->ainsn.api.insn, p->opcode);
>>>> -	patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
>>>> -		   __BUG_INSN_32);
>>>> +	memcpy(slot, &p->opcode, offset);
>>>> +	memcpy((void *)((unsigned long)slot + offset), &brk_insn, 4);
>>>> +	patch_text_nosync(p->ainsn.api.insn, slot, offset + 4);
> 
> BTW, didn't you have a macro for the size of __BUG_INSN_32?
> 
> Thank you,

I think you are saying GET_INSN_LENGTH, i will use it to caculate
the size of __BUG_INSN_32 in v2, instead of magic number '4'.

Thanks.

> 
> 
>>>>  }
>>>>  
>>>>  static void __kprobes arch_prepare_simulate(struct kprobe *p)
>>>> -- 
>>>> 2.17.1
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>> .
>>
>> -- 
>> BR,
>> Liao, Chang
> 
> 

-- 
BR,
Liao, Chang
