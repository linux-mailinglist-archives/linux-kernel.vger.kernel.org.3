Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7739E586DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiHAP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiHAP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86718B00
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06EB6091B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20095C43140
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659367732;
        bh=IvLjinAcR92q5qqTTt/D9wTHmp/vQPJ0xw+Rd3m2/e8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fedvmcAGx/q0LoZ9LVRORKKkuCumYS5YwJHhTWi2AKWuhij7Cn1ZHkmhqBKe/vMhU
         Vnq+Uxmd0xlyCAYvafHFAEwFyu3CNkmt5Lf0zu8DZPXBPw/iy0VwGrMcQJhvxZvMHa
         neOh91A0019U41oxSdYe2I1p/M6QW58ZQdoOWCTAZCXuCLo0QVUnXsAtlIq4l5olNz
         GqquyKtNTrLBD+BJLnUsT5SQdk3981eXlR/oga23u7BPUhkd7ZaOmr9o0BrA+JO8bX
         Cyp0U2gD5jVdYHxrTzAAzO0+JivUIS2fRss+9smfb4mNN44SokxSKwkrLutSn5Hhtv
         RAjn6sg2YRgCw==
Received: by mail-vs1-f45.google.com with SMTP id 125so11621024vsx.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:28:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo3qRRYi6/svM9PgQ6a0nS/vjVw5P66yM+0OehIuiN96W0bCsreV
        x9AvM4sbTVCTlrQxpZppOnYMBAWe3hcZwxk5RlI=
X-Google-Smtp-Source: AA6agR4/IwVp39rNpUDpwrpfW406nnWwKLvW32OshTAw1Y0y31vUvzrEY/miTRtRFJNApeafolt8HdT7GfO+uzv7Iq8=
X-Received: by 2002:a67:d487:0:b0:385:1a6b:6f33 with SMTP id
 g7-20020a67d487000000b003851a6b6f33mr1857321vsj.59.1659367730980; Mon, 01 Aug
 2022 08:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220801121726.9681-1-zhangqing@loongson.cn> <20220801121726.9681-2-zhangqing@loongson.cn>
In-Reply-To: <20220801121726.9681-2-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 1 Aug 2022 23:28:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4aaE7f9Qd5tPZ3daRBe8Fsd4BX5zUVXjUpiTtfT73ukg@mail.gmail.com>
Message-ID: <CAAhV-H4aaE7f9Qd5tPZ3daRBe8Fsd4BX5zUVXjUpiTtfT73ukg@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Add guess unwinder support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

On Mon, Aug 1, 2022 at 8:17 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Name "guess unwinder" comes from x86, It scans the stack and reports
> every kernel text address it finds.
>
> Three stages when we do unwind,
>   (1)unwind_start(), the prapare of unwinding, fill unwind_state.
>   (2)unwind_done(), judge whether the unwind process is finished or not.
>   (3)unwind_next_frame(), unwind the next frame.
>
> Make the dump_stack process go through unwind process.
> Add get_stack_info() to get stack info. At present we have irq stack and
> task stack. Maybe add another type in future. The next_sp means the key
> info between this type stack and next type stack.
>
> Dividing unwinder helps to add new unwinders in the future.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig.debug            |  9 ++++
>  arch/loongarch/include/asm/stacktrace.h | 17 +++++++
>  arch/loongarch/include/asm/unwind.h     | 37 ++++++++++++++
>  arch/loongarch/kernel/Makefile          |  2 +
>  arch/loongarch/kernel/process.c         | 61 +++++++++++++++++++++++
>  arch/loongarch/kernel/traps.c           | 22 ++++-----
>  arch/loongarch/kernel/unwind_guess.c    | 65 +++++++++++++++++++++++++
>  7 files changed, 202 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/unwind.h
>  create mode 100644 arch/loongarch/kernel/unwind_guess.c
>
> diff --git a/arch/loongarch/Kconfig.debug b/arch/loongarch/Kconfig.debug
> index e69de29bb2d1..68634d4fa27b 100644
> --- a/arch/loongarch/Kconfig.debug
> +++ b/arch/loongarch/Kconfig.debug
> @@ -0,0 +1,9 @@
> +config UNWINDER_GUESS
> +       bool "Guess unwinder"
> +       help
> +         This option enables the "guess" unwinder for unwinding kernel stack
> +         traces.  It scans the stack and reports every kernel text address it
> +         finds.  Some of the addresses it reports may be incorrect.
> +
> +         While this option often produces false positives, it can still be
> +         useful in many cases.
> diff --git a/arch/loongarch/include/asm/stacktrace.h b/arch/loongarch/include/asm/stacktrace.h
> index 6b5c2a7aa706..49cb89213aeb 100644
> --- a/arch/loongarch/include/asm/stacktrace.h
> +++ b/arch/loongarch/include/asm/stacktrace.h
> @@ -10,6 +10,23 @@
>  #include <asm/loongarch.h>
>  #include <linux/stringify.h>
>
> +enum stack_type {
> +       STACK_TYPE_UNKNOWN,
> +       STACK_TYPE_TASK,
> +       STACK_TYPE_IRQ,
> +};
> +
> +struct stack_info {
> +       enum stack_type type;
> +       unsigned long begin, end, next_sp;
> +};
> +
> +bool in_task_stack(unsigned long stack, struct task_struct *task,
> +                       struct stack_info *info);
> +bool in_irq_stack(unsigned long stack, struct stack_info *info);
> +int get_stack_info(unsigned long stack, struct task_struct *task,
> +                       struct stack_info *info);
> +
>  #define STR_LONG_L    __stringify(LONG_L)
>  #define STR_LONG_S    __stringify(LONG_S)
>  #define STR_LONGSIZE  __stringify(LONGSIZE)
> diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
> new file mode 100644
> index 000000000000..243330b39d0d
> --- /dev/null
> +++ b/arch/loongarch/include/asm/unwind.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Most of this ideas comes from x86.
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_UNWIND_H
> +#define _ASM_UNWIND_H
> +
> +#include <linux/sched.h>
> +
> +#include <asm/stacktrace.h>
> +
> +struct unwind_state {
> +       struct stack_info stack_info;
> +       struct task_struct *task;
> +       unsigned long sp, pc;
> +       bool first;
> +       bool error;
> +};
> +
> +void unwind_start(struct unwind_state *state, struct task_struct *task,
> +                     struct pt_regs *regs);
> +bool unwind_next_frame(struct unwind_state *state);
> +unsigned long unwind_get_return_address(struct unwind_state *state);
> +
> +static inline bool unwind_done(struct unwind_state *state)
> +{
> +       return state->stack_info.type == STACK_TYPE_UNKNOWN;
> +}
> +
> +static inline bool unwind_error(struct unwind_state *state)
> +{
> +       return state->error;
> +}
> +
> +#endif /* _ASM_UNWIND_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 940de9173542..c5fa4adb23b6 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -22,4 +22,6 @@ obj-$(CONFIG_SMP)             += smp.o
>
>  obj-$(CONFIG_NUMA)             += numa.o
>
> +obj-$(CONFIG_UNWINDER_GUESS)   += unwind_guess.o
> +
>  CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index bfa0dfe8b7d7..709b7a1664f8 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -44,6 +44,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/processor.h>
>  #include <asm/reg.h>
> +#include <asm/unwind.h>
>  #include <asm/vdso.h>
>
>  /*
> @@ -183,6 +184,66 @@ unsigned long __get_wchan(struct task_struct *task)
>         return 0;
>  }
>
> +bool in_task_stack(unsigned long stack, struct task_struct *task,
> +                       struct stack_info *info)
> +{
> +       unsigned long begin = (unsigned long)task_stack_page(task);
> +       unsigned long end = begin + THREAD_SIZE - 32;
> +
> +       if (stack < begin || stack >= end)
> +               return false;
> +
> +       info->type = STACK_TYPE_TASK;
> +       info->begin = begin;
> +       info->end = end;
> +       info->next_sp = 0;
> +
> +       return true;
> +}
> +
> +bool in_irq_stack(unsigned long stack, struct stack_info *info)
> +{
> +       unsigned long nextsp;
> +       unsigned long begin = (unsigned long)this_cpu_read(irq_stack);
> +       unsigned long end = begin + IRQ_STACK_START;
> +
> +       if (stack < begin || stack >= end)
> +               return false;
> +
> +       nextsp = *(unsigned long *)end;
> +       if (nextsp & (SZREG - 1))
> +               return false;
> +
> +       info->type = STACK_TYPE_IRQ;
> +       info->begin = begin;
> +       info->end = end;
> +       info->next_sp = nextsp;
> +
> +       return true;
> +}
> +
> +int get_stack_info(unsigned long stack, struct task_struct *task,
> +                  struct stack_info *info)
> +{
> +       task = task ? : current;
> +
> +       if (!stack || stack & (SZREG - 1))
> +               goto unknown;
> +
> +       if (in_task_stack(stack, task, info))
> +               return 0;
> +
> +       if (task != current)
> +               goto unknown;
> +
> +       if (in_irq_stack(stack, info))
> +               return 0;
> +
> +unknown:
> +       info->type = STACK_TYPE_UNKNOWN;
> +       return -EINVAL;
> +}
> +
>  unsigned long stack_top(void)
>  {
>         unsigned long top = TASK_SIZE & PAGE_MASK;
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1bf58c65e2bf..ef2c3aeb1dab 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -43,6 +43,7 @@
>  #include <asm/stacktrace.h>
>  #include <asm/tlb.h>
>  #include <asm/types.h>
> +#include <asm/unwind.h>
>
>  #include "access-helper.h"
>
> @@ -64,19 +65,18 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
>                            const char *loglvl, bool user)
>  {
>         unsigned long addr;
> -       unsigned long *sp = (unsigned long *)(regs->regs[3] & ~3);
> +       struct unwind_state state;
> +       struct pt_regs *pregs = (struct pt_regs *)regs;
> +
> +       if (!task)
> +               task = current;
> +
> +       unwind_start(&state, task, pregs);
>
>         printk("%sCall Trace:", loglvl);
> -#ifdef CONFIG_KALLSYMS
> -       printk("%s\n", loglvl);
> -#endif
They should be after unwind_start()? If not, moving unwind_start() to
the for-loop seems better.

> -       while (!kstack_end(sp)) {
> -               if (__get_addr(&addr, sp++, user)) {
> -                       printk("%s (Bad stack address)", loglvl);
> -                       break;
> -               }
> -               if (__kernel_text_address(addr))
> -                       print_ip_sym(loglvl, addr);
> +       for (; !unwind_done(&state); unwind_next_frame(&state)) {
> +               addr = unwind_get_return_address(&state);
> +               print_ip_sym(loglvl, addr);
>         }
>         printk("%s\n", loglvl);
>  }
> diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
> new file mode 100644
> index 000000000000..7eeb3e1a989d
> --- /dev/null
> +++ b/arch/loongarch/kernel/unwind_guess.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/kernel.h>
> +
> +#include <asm/unwind.h>
> +
> +unsigned long unwind_get_return_address(struct unwind_state *state)
> +{
> +       if (unwind_done(state))
> +               return 0;
> +       else if (state->first)
> +               return state->pc;
> +
> +       return *(unsigned long *)(state->sp);
> +}
> +EXPORT_SYMBOL_GPL(unwind_get_return_address);
> +
> +bool unwind_next_frame(struct unwind_state *state)
> +{
> +       struct stack_info *info = &state->stack_info;
> +       unsigned long addr;
> +
> +       if (unwind_done(state))
> +               return false;
> +
> +       if (state->first)
> +               state->first = false;
> +
> +       do {
> +               for (state->sp += sizeof(unsigned long);
> +                    state->sp < info->end;
> +                    state->sp += sizeof(unsigned long)) {
> +                       addr = *(unsigned long *)(state->sp);
> +
> +                       if (__kernel_text_address(addr))
> +                               return true;
> +               }
> +
> +               state->sp = info->next_sp;
> +
> +       } while (!get_stack_info(state->sp, state->task, info));
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(unwind_next_frame);
Move this function after unwind_start() seems more natural.

Huacai

> +
> +void unwind_start(struct unwind_state *state, struct task_struct *task,
> +                   struct pt_regs *regs)
> +{
> +       memset(state, 0, sizeof(*state));
> +
> +       state->task = task;
> +
> +       state->sp = regs->regs[3];
> +       state->pc = regs->csr_era;
> +       state->first = true;
> +
> +       get_stack_info(state->sp, state->task, &state->stack_info);
> +
> +       if (!unwind_done(state) && !__kernel_text_address(state->pc))
> +               unwind_next_frame(state);
> +}
> +EXPORT_SYMBOL_GPL(unwind_start);
> --
> 2.20.1
>
