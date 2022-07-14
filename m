Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2408C575059
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiGNOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiGNOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:08:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B504828713
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:08:00 -0700 (PDT)
Received: from [10.90.50.23] (unknown [10.90.50.23])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf+M4I9BiWmUeAA--.63010S3;
        Thu, 14 Jul 2022 22:07:53 +0800 (CST)
Message-ID: <6896bb4c-5224-678f-e73c-fe95be41d196@loongson.cn>
Date:   Thu, 14 Jul 2022 22:07:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] LoongArch: Fix missing fcsr in ptrace's fpr_set
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        Xu Li <lixu@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
References: <20220714062550.4934-1-huqi@loongson.cn>
 <CAAhV-H6NWYG1ChLRyK-EAGAmhDvP-x+z9BgBo3a=GAbQ-2bKig@mail.gmail.com>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <CAAhV-H6NWYG1ChLRyK-EAGAmhDvP-x+z9BgBo3a=GAbQ-2bKig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxf+M4I9BiWmUeAA--.63010S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyxXrWDGryxZw17Wry8Xwb_yoW8Zw1kpr
        ZxA3ZxGF48JrWrur9FqFnYvr1DXwnFgFyS9393t3WrArnFvws8JryDtF42vFWIy34rGayx
        ZrnF9FsayFnFq3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        j8GYLUUUUU=
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAHCV3QvP1aPwABsn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/14 21:12, Huacai Chen wrote:
> Hi,
>
> On Thu, Jul 14, 2022 at 2:26 PM Qi Hu <huqi@loongson.cn> wrote:
>> In file ptrace.c, function fpr_set does not copy fcsr data from ubuf
>> to kbuf. That's the reason why fcsr cannot be modified by ptrace.
>>
>> This patch fixs this problem and allows users using ptrace to modify
>> the fcsr.
>>
>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>> Signed-off-by: Xu Li <lixu@loongson.cn>
>> ---
>>   arch/loongarch/kernel/ptrace.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
>> index e6ab87948e1d..dc2b82ea894c 100644
>> --- a/arch/loongarch/kernel/ptrace.c
>> +++ b/arch/loongarch/kernel/ptrace.c
>> @@ -193,7 +193,7 @@ static int fpr_set(struct task_struct *target,
>>                     const void *kbuf, const void __user *ubuf)
>>   {
>>          const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
>> -       const int fcc_end = fcc_start + sizeof(u64);
>> +       const int fcsr_start = fcc_start + sizeof(u64);
>>          int err;
>>
>>          BUG_ON(count % sizeof(elf_fpreg_t));
>> @@ -209,10 +209,12 @@ static int fpr_set(struct task_struct *target,
>>          if (err)
>>                  return err;
>>
>> -       if (count > 0)
>> -               err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> -                                         &target->thread.fpu.fcc,
>> -                                         fcc_start, fcc_end);
>> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                 &target->thread.fpu.fcc, fcc_start,
>> +                                 fcc_start + sizeof(u64));
>> +       err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                 &target->thread.fpu.fcsr, fcsr_start,
>> +                                 fcsr_start + sizeof(u32));
> You shouldn't remove (count > 0) here, because  the above
> user_regset_copyin() will modify count inside, and so "count == 0" is
> possible.
>
> Huacai

Yes, the "count" should be considered. But the "count" is checked at the 
beginning of the "user_regset_copyin()".

So "count > 0" is useless, i think.

Also like riscv, "count" is not checked in "riscv_fpr_set()".

>>          return err;
>>   }
>> --
>> 2.37.0
>>

