Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29725AE072
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiIFHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbiIFHAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000266052A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 00:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E4061336
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD9C433B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662447648;
        bh=s8JfIrS4Py1WjGD4d2cCxKtKrLNv0TTlsW/zturNS3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cftoo4SxgrGnKPo6OIUuEWvWXn+tYqGvAiIIj9yaPXbDI21895R4qliWXvSCgtcXj
         O2V4yTqmQiLCzDvFePrUZmBEXNjgNHv3t/ISC2lD8Cpv7xdFFEGpw2GnYgoeUpaF9N
         IK/N4QFqJA+se2AYJKuHUqV4Z6kHCvCd4+7f+6QD5W/fP46eqPfUC+5S18sve9HJEY
         kBJ4rwCIeYA0PF49ib1OqhkjixoiGvgqEKlxn4xxPBlR2ggyPNtObLqaOCDVyx/hqM
         NvzBYatVHPwhC37X9wNbzVF8nxPfyKnfHuB+ofpOE8ILeXiDeNqzi6gt4LxPudTc3S
         3bSuFdjBJaMdw==
Received: by mail-ua1-f53.google.com with SMTP id z14so3992047uam.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 00:00:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo1prN+cS8JfjVf4AFlVpya/L6bczvsZq6fracCQF/8s5qzcJPFa
        xGnLrbhxQc0XT72RLEknBJxKPuElJWOsr7zg72k=
X-Google-Smtp-Source: AA6agR71zcavJhAMGOJzZcc/0x5u5DyGuC1pc8sMlEz7TxUW0ngGSpdZTqy6uOyWIhcQTYGdofBw1j/r+DIABYtyNIQ=
X-Received: by 2002:ab0:d82:0:b0:39e:db4c:c80c with SMTP id
 i2-20020ab00d82000000b0039edb4cc80cmr15051140uak.22.1662447647802; Tue, 06
 Sep 2022 00:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <1662130897-13156-1-git-send-email-hejinyang@loongson.cn>
 <CAAhV-H4vNpbHbT55z8_ub3q=Kv7eVb--7Q3pXz2te-1DVWhTWA@mail.gmail.com>
 <b3040de0-9c89-a6ff-517e-6ebec71faaf7@loongson.cn> <CAAhV-H5PA6n9a8A9unEitXEowUMEkrrHQoJXdBoOLZJ559-UDg@mail.gmail.com>
 <4b001fde-6442-525e-4d8e-0ba7a85dccc5@loongson.cn>
In-Reply-To: <4b001fde-6442-525e-4d8e-0ba7a85dccc5@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 6 Sep 2022 15:00:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6CGLTGC6KpOaN63z1WULcDiAY9ggcE8-Fe0oTW2TOa_g@mail.gmail.com>
Message-ID: <CAAhV-H6CGLTGC6KpOaN63z1WULcDiAY9ggcE8-Fe0oTW2TOa_g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Mark kernel stack padding as TOP_OF_KERNEL_STACK_PADDING
To:     Jinyang He <hejinyang@loongson.cn>, Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, Oleg Nesterov <oleg@redhat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe we can simply remove it, but I still want to ask Xuerui and
Ruoyao's advices.

Huacai

On Tue, Sep 6, 2022 at 2:06 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Hi, Huacai,
>
> On 2022/9/5 14:21, Huacai Chen wrote:
> > Hi, Jinyang,
> >
> > On Mon, Sep 5, 2022 at 1:39 PM Jinyang He <hejinyang@loongson.cn> wrote:
> >> On 2022/9/4 20:19, Huacai Chen wrote:
> >>
> >>> Hi, Jinyang,
> >>>
> >>> I don't know what scenarios this padding is used and how to use.
> >> To be frankly, I don't know its scenarios on LoongArch. It looks like
> >> the MIPS legacy. This patch only keep this padding, which can be
> >> easily modified if needed in the future. Now we can completely
> >> set it to 0 or remove it.  Actually, it can be thought of as another
> >> buffer for thread_info, while thread_info usually limit to one cache line.
> > We should make it clear how MIPS use it at least, then we can make a
> > decision whether to remove it or not, otherwise it may break
> > something.
> I think it is related to shadow parameters area of MIPS o32 Calling
> Convention.
> This happened a long time ago, starting is 24, then 4*SZREG, and now 32.
> But there are few commit-logs I can find. See links. I guess these changes
> are due to the ABI, the macro SZREG in [2] is referenced to check stack
> alignment. And pt_regs and sigframe also have padding. If we can't find
> what will be broken, then we should cancel it rather than keeping it.
> We wouldn't have these paddings if we weren't inspired by MIPS.
>
> [1] https://elixir.bootlin.com/linux/1.1.82/source/arch/mips/kernel/head.S
> [2] https://elixir.bootlin.com/linux/2.1.44/source/arch/mips/kernel/head.S
> [3] https://elixir.bootlin.com/linux/2.1.73/source/arch/mips/kernel/head.S
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit?id=484889fc85a223ef56edc31828b86751b2296b7c
> >>> And
> >>> in x86 there is only TOP_OF_KERNEL_STACK_PADDING but we need
> >>> TOP_OF_KERNEL_STACK_PADDING and _TOP_OF_KERNEL_STACK_PADDING. Two
> >>> macros are hard to maintain.
> >> How about put it into loongarch.h if we need this macro?
> > That is good because we only need one macro, but you can research
> > whether there is a better place.
>
> As asm and C code need it, how about put it in output_thread_info_defines?
>
> Thanks,
>
> Jinyang
>
> >>> On Fri, Sep 2, 2022 at 11:01 PM Jinyang He <hejinyang@loongson.cn> wrote:
> >>>> Mark the top reserved bytes of the kernel stack by a macro. It collects
> >>>> that info so that we can modify or discarded (let it be 0) this padding
> >>>> if needed. Its name is referenced from x86_64. It seems that x86_64
> >>>> think the padding as extension on top of the kernel stack in other mode
> >>>> (normally the top is only pt_regs). Although LoongArch not produce
> >>>> such an extension at present, collect them because of the uncertainty
> >>>> of the future. Note that this patch does not modify macro size. It
> >>>> requires another strict evaluation.
> >>>>
> >>>> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/processor.h  | 3 ++-
> >>>>    arch/loongarch/include/asm/ptrace.h     | 3 ++-
> >>>>    arch/loongarch/include/asm/stackframe.h | 1 +
> >>>>    arch/loongarch/kernel/head.S            | 2 +-
> >>>>    arch/loongarch/kernel/process.c         | 4 ++--
> >>>>    arch/loongarch/kernel/switch.S          | 2 +-
> >>>>    6 files changed, 9 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> >>>> index 1c4b43083..6077fd8e3 100644
> >>>> --- a/arch/loongarch/include/asm/processor.h
> >>>> +++ b/arch/loongarch/include/asm/processor.h
> >>>> @@ -193,8 +193,9 @@ static inline void flush_thread(void)
> >>>>
> >>>>    unsigned long __get_wchan(struct task_struct *p);
> >>>>
> >>>> +#define TOP_OF_KERNEL_STACK_PADDING 32
> >>>>    #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
> >>>> -                        THREAD_SIZE - 32 - sizeof(struct pt_regs))
> >>>> +                        THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING - sizeof(struct pt_regs))
> >>>>    #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
> >>>>    #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
> >>>>    #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
> >>>> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> >>>> index 17838c6b7..cdceeaa60 100644
> >>>> --- a/arch/loongarch/include/asm/ptrace.h
> >>>> +++ b/arch/loongarch/include/asm/ptrace.h
> >>>> @@ -133,7 +133,8 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
> >>>>    #define current_pt_regs()                                              \
> >>>>    ({                                                                     \
> >>>>           unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
> >>>> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;      \
> >>>> +       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 -               \
> >>>> +                          TOP_OF_KERNEL_STACK_PADDING) - 1;            \
> >>>>    })
> >>>>
> >>>>    /* Helpers for working with the user stack pointer */
> >>>> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> >>>> index 4ca953062..e9f849b29 100644
> >>>> --- a/arch/loongarch/include/asm/stackframe.h
> >>>> +++ b/arch/loongarch/include/asm/stackframe.h
> >>>> @@ -216,4 +216,5 @@
> >>>>           RESTORE_SP_AND_RET \docfi
> >>>>           .endm
> >>>>
> >>>> +#define _TOP_OF_KERNEL_STACK_PADDING 32
> >>>>    #endif /* _ASM_STACKFRAME_H */
> >>>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> >>>> index eb3f641d5..290c53847 100644
> >>>> --- a/arch/loongarch/kernel/head.S
> >>>> +++ b/arch/loongarch/kernel/head.S
> >>>> @@ -75,7 +75,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
> >>>>
> >>>>           la.pcrel        tp, init_thread_union
> >>>>           /* Set the SP after an empty pt_regs.  */
> >>>> -       PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
> >>>> +       PTR_LI          sp, (_THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING - PT_SIZE)
> >>>>           PTR_ADD         sp, sp, tp
> >>>>           set_saved_sp    sp, t0, t1
> >>>>           PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
> >>>> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> >>>> index 660492f06..b51cf7975 100644
> >>>> --- a/arch/loongarch/kernel/process.c
> >>>> +++ b/arch/loongarch/kernel/process.c
> >>>> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >>>>           unsigned long clone_flags = args->flags;
> >>>>           struct pt_regs *childregs, *regs = current_pt_regs();
> >>>>
> >>>> -       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
> >>>> +       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
> >>>>
> >>>>           /* set up new TSS. */
> >>>>           childregs = (struct pt_regs *) childksp - 1;
> >>>> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
> >>>>                           struct stack_info *info)
> >>>>    {
> >>>>           unsigned long begin = (unsigned long)task_stack_page(task);
> >>>> -       unsigned long end = begin + THREAD_SIZE - 32;
> >>>> +       unsigned long end = begin + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
> >>>>
> >>>>           if (stack < begin || stack >= end)
> >>>>                   return false;
> >>>> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> >>>> index 43ebbc399..1797aceae 100644
> >>>> --- a/arch/loongarch/kernel/switch.S
> >>>> +++ b/arch/loongarch/kernel/switch.S
> >>>> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
> >>>>           move    tp, a2
> >>>>           cpu_restore_nonscratch a1
> >>>>
> >>>> -       li.w            t0, _THREAD_SIZE - 32
> >>>> +       li.w            t0, _THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING
> >>>>           PTR_ADD         t0, t0, tp
> >>>>           set_saved_sp    t0, t1, t2
> >>>>
> >>>> --
> >>>> 2.31.1
> >>>>
>
