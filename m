Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76D54C35A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiFOITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiFOITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:19:38 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2FB27FFB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:19:36 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_08VlqliXF1DAA--.5950S3;
        Wed, 15 Jun 2022 16:19:34 +0800 (CST)
Subject: Re: [RFC PATCH v2 2/2] LoongArch: No need to call RESTORE_ALL_AND_RET
 for all syscalls
To:     hev <r@hev.cc>
References: <1655275079-17651-1-git-send-email-yangtiezhu@loongson.cn>
 <1655275079-17651-3-git-send-email-yangtiezhu@loongson.cn>
 <CAHirt9g+0N6hJAf-xRrss-FRXiix4jE9=CGZC6+BDHO3dBunsg@mail.gmail.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>, Jun Yi <yijun@loongson.cn>,
        Rui Wang <wangrui@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b862fe85-97d8-000d-0d78-e749f4a29a2b@loongson.cn>
Date:   Wed, 15 Jun 2022 16:19:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHirt9g+0N6hJAf-xRrss-FRXiix4jE9=CGZC6+BDHO3dBunsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx_08VlqliXF1DAA--.5950S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW7ZF4DKw4DWrWkCr1fXrb_yoW5urW7p3
        WqyFnakF48WF1fAryaqrW7Wryay3WkWF429F42k395uwn5Z3s8XF1vvas8tr4jkw1kKrWI
        qa4rWwsIgF90qa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU4a0PUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/15/2022 02:57 PM, hev wrote:
> Hello,
>
> On Wed, Jun 15, 2022 at 2:38 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> In handle_syscall, it is unnecessary to call RESTORE_ALL_AND_RET
>> for all syscalls.
>>
>> (1) If syscall number is __NR_clone and __NR_clone3,
>>     call RESTORE_STATIC_SOME_SP_AND_RET.
>> (2) If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
>>     call RESTORE_TEMP_SOME_SP_AND_RET.
>> (3) The other syscalls call RESTORE_SOME_SP_AND_RET.
>>
>> With this patch, it can reduce many load instructions.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/include/asm/stackframe.h | 17 +++++++++++++++++
>>  arch/loongarch/kernel/entry.S           | 24 +++++++++++++++++++++++-
>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
>> index 4ca9530..52649a5f 100644
>> --- a/arch/loongarch/include/asm/stackframe.h
>> +++ b/arch/loongarch/include/asm/stackframe.h
>> @@ -216,4 +216,21 @@
>>         RESTORE_SP_AND_RET \docfi
>>         .endm
>>
>> +       .macro  RESTORE_SOME_SP_AND_RET docfi=0
>> +       RESTORE_SOME \docfi
>> +       RESTORE_SP_AND_RET \docfi
>> +       .endm
>> +
>> +       .macro  RESTORE_STATIC_SOME_SP_AND_RET docfi=0
>> +       RESTORE_STATIC \docfi
>> +       RESTORE_SOME \docfi
>> +       RESTORE_SP_AND_RET \docfi
>> +       .endm
>> +
>> +       .macro  RESTORE_TEMP_SOME_SP_AND_RET docfi=0
>> +       RESTORE_TEMP \docfi
>> +       RESTORE_SOME \docfi
>> +       RESTORE_SP_AND_RET \docfi
>> +       .endm
>> +
>>  #endif /* _ASM_STACKFRAME_H */
>> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
>> index 53ce2cb..58fe507 100644
>> --- a/arch/loongarch/kernel/entry.S
>> +++ b/arch/loongarch/kernel/entry.S
>> @@ -79,7 +79,29 @@ SYM_FUNC_START(handle_syscall)
>>         move    a0, sp
>>         bl      do_syscall
>>
>> -       RESTORE_ALL_AND_RET
>> +       /*
>> +        * Syscall number held in a7 which is stored in PT_R11.
>> +        * If syscall number is __NR_clone and __NR_clone3,
>> +        * call RESTORE_STATIC_SOME_SP_AND_RET.
>> +        * If syscall number is __NR_rt_sigreturn and __NR_rt_sigsuspend,
>> +        * call RESTORE_TEMP_SOME_SP_AND_RET.
>> +        * The other syscalls call RESTORE_SOME_SP_AND_RET.
>> +        */
>> +       cfi_ld  t3, PT_R11
>
> I think PT_R11 may be overwritten by the signal handler and the
> syscall number is now lost.
>

Thank you. Let me use TI_SYSCALL. I will send RFC v3 patch later.

arch/loongarch/include/asm/thread_info.h
struct thread_info {
	struct task_struct	*task;		/* main task structure */
	unsigned long		flags;		/* low level flags */
	unsigned long		tp_value;	/* thread pointer */
	__u32			cpu;		/* current CPU */
	int			preempt_count;	/* 0 => preemptible, <0 => BUG */
	struct pt_regs		*regs;
	unsigned long		syscall;	/* syscall number */
	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
};

>> +       li.w    t4, __NR_clone
>> +       beq     t3, t4, 3f
>> +       li.w    t4, __NR_clone3
>> +       beq     t3, t4, 3f
>> +       li.w    t4, __NR_rt_sigreturn
>> +       beq     t3, t4, 4f
>> +       li.w    t4, __NR_rt_sigsuspend
>> +       beq     t3, t4, 4f
>> +
>> +       RESTORE_SOME_SP_AND_RET
>> +3:
>> +       RESTORE_STATIC_SOME_SP_AND_RET
>> +4:
>> +       RESTORE_TEMP_SOME_SP_AND_RET
>>  SYM_FUNC_END(handle_syscall)
>>
>>  SYM_CODE_START(ret_from_fork)
>> --
>> 2.1.0
>>
>
> Best regards,
> hev
>

