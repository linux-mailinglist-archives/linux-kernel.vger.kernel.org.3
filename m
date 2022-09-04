Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935CF5AC441
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiIDMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIDMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:19:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C59013D71
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 05:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1740EB80D69
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B61C433D7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662293973;
        bh=WhsSZWPpgEdHQXbW0j9Y5ABuCY+3XYv3Ra8cMGsnPFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSVTfZemJKl2i9rc85dKHQBLq9KKpbSQcc9iDRNhp4TiFvc3Tl5Hy1Whhl3KhTWDF
         pDqons+hwXLLbXJa83srdzU3QAjS0Q1PbJRa9SCyu5tXmv7w5m3oKivwYMWbaUkh3u
         QnuBytof2teNrVkCkgJ5QxhTFeZf4mb4nJNx1xB23ETiuMEAdg06Stl17w5EY00mTc
         bG2UarU2X92AIrVqHW8FRMnyDqsOxNizL9jChYgG9SFxkEyGkpEimSXXUpYNqum6KS
         D7JHYBg5bZihwl8kWSznb41I9wU23ZaqSELxNsYCId+sarFYT1a06gJWtHy6c3nJlS
         zG3vv83GelW8g==
Received: by mail-vs1-f41.google.com with SMTP id b128so6483518vsc.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 05:19:33 -0700 (PDT)
X-Gm-Message-State: ACgBeo3dVkXl7QovsAtV3xtbn81LQLhdbRstHe3FgTX1Av4xMaklbXNE
        r6zkVUCX0i3LiE8zAGQI22W+1T6MhHFH8XYkXO4=
X-Google-Smtp-Source: AA6agR4wV5DfX8Q9oO6WUSTKYKXyg9mwOS5JShrLetDWdxnkW0FJlGu1GoXYJng/jMwuYpPsoqIy+BxacQUChwPqI4U=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr13360500vsu.43.1662293972598; Sun, 04
 Sep 2022 05:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <1662130897-13156-1-git-send-email-hejinyang@loongson.cn>
In-Reply-To: <1662130897-13156-1-git-send-email-hejinyang@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 4 Sep 2022 20:19:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4vNpbHbT55z8_ub3q=Kv7eVb--7Q3pXz2te-1DVWhTWA@mail.gmail.com>
Message-ID: <CAAhV-H4vNpbHbT55z8_ub3q=Kv7eVb--7Q3pXz2te-1DVWhTWA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Mark kernel stack padding as TOP_OF_KERNEL_STACK_PADDING
To:     Jinyang He <hejinyang@loongson.cn>
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

Hi, Jinyang,

I don't know what scenarios this padding is used and how to use. And
in x86 there is only TOP_OF_KERNEL_STACK_PADDING but we need
TOP_OF_KERNEL_STACK_PADDING and _TOP_OF_KERNEL_STACK_PADDING. Two
macros are hard to maintain.

Huacai

On Fri, Sep 2, 2022 at 11:01 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Mark the top reserved bytes of the kernel stack by a macro. It collects
> that info so that we can modify or discarded (let it be 0) this padding
> if needed. Its name is referenced from x86_64. It seems that x86_64
> think the padding as extension on top of the kernel stack in other mode
> (normally the top is only pt_regs). Although LoongArch not produce
> such an extension at present, collect them because of the uncertainty
> of the future. Note that this patch does not modify macro size. It
> requires another strict evaluation.
>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/loongarch/include/asm/processor.h  | 3 ++-
>  arch/loongarch/include/asm/ptrace.h     | 3 ++-
>  arch/loongarch/include/asm/stackframe.h | 1 +
>  arch/loongarch/kernel/head.S            | 2 +-
>  arch/loongarch/kernel/process.c         | 4 ++--
>  arch/loongarch/kernel/switch.S          | 2 +-
>  6 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 1c4b43083..6077fd8e3 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -193,8 +193,9 @@ static inline void flush_thread(void)
>
>  unsigned long __get_wchan(struct task_struct *p);
>
> +#define TOP_OF_KERNEL_STACK_PADDING 32
>  #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
> -                        THREAD_SIZE - 32 - sizeof(struct pt_regs))
> +                        THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING - sizeof(struct pt_regs))
>  #define task_pt_regs(tsk) ((struct pt_regs *)__KSTK_TOS(tsk))
>  #define KSTK_EIP(tsk) (task_pt_regs(tsk)->csr_era)
>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[3])
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 17838c6b7..cdceeaa60 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -133,7 +133,8 @@ static inline void die_if_kernel(const char *str, struct pt_regs *regs)
>  #define current_pt_regs()                                              \
>  ({                                                                     \
>         unsigned long sp = (unsigned long)__builtin_frame_address(0);   \
> -       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 - 32) - 1;      \
> +       (struct pt_regs *)((sp | (THREAD_SIZE - 1)) + 1 -               \
> +                          TOP_OF_KERNEL_STACK_PADDING) - 1;            \
>  })
>
>  /* Helpers for working with the user stack pointer */
> diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> index 4ca953062..e9f849b29 100644
> --- a/arch/loongarch/include/asm/stackframe.h
> +++ b/arch/loongarch/include/asm/stackframe.h
> @@ -216,4 +216,5 @@
>         RESTORE_SP_AND_RET \docfi
>         .endm
>
> +#define _TOP_OF_KERNEL_STACK_PADDING 32
>  #endif /* _ASM_STACKFRAME_H */
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index eb3f641d5..290c53847 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -75,7 +75,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>
>         la.pcrel        tp, init_thread_union
>         /* Set the SP after an empty pt_regs.  */
> -       PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
> +       PTR_LI          sp, (_THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING - PT_SIZE)
>         PTR_ADD         sp, sp, tp
>         set_saved_sp    sp, t0, t1
>         PTR_ADDI        sp, sp, -4 * SZREG      # init stack pointer
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 660492f06..b51cf7975 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -129,7 +129,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>         unsigned long clone_flags = args->flags;
>         struct pt_regs *childregs, *regs = current_pt_regs();
>
> -       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
> +       childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>
>         /* set up new TSS. */
>         childregs = (struct pt_regs *) childksp - 1;
> @@ -236,7 +236,7 @@ bool in_task_stack(unsigned long stack, struct task_struct *task,
>                         struct stack_info *info)
>  {
>         unsigned long begin = (unsigned long)task_stack_page(task);
> -       unsigned long end = begin + THREAD_SIZE - 32;
> +       unsigned long end = begin + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
>
>         if (stack < begin || stack >= end)
>                 return false;
> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> index 43ebbc399..1797aceae 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -26,7 +26,7 @@ SYM_FUNC_START(__switch_to)
>         move    tp, a2
>         cpu_restore_nonscratch a1
>
> -       li.w            t0, _THREAD_SIZE - 32
> +       li.w            t0, _THREAD_SIZE - _TOP_OF_KERNEL_STACK_PADDING
>         PTR_ADD         t0, t0, tp
>         set_saved_sp    t0, t1, t2
>
> --
> 2.31.1
>
