Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D188576343
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiGON7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiGON7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:59:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F371D0E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:04 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w81so6224568oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvY29V/GM0mH1NqPcwS/Tuc0R9fYJIruV6sTb6TXI7Q=;
        b=TQgLEenxazdws7SAjjHTqasunR2EnCav01e3+lfRmImyX7Zc86iZpGxN3bx0wKUnp1
         QOeThI79bl1YWoFSH8X87Thc9NYgF2i/BbtuDAexxa0jepJ/VUYg5vmAdiSlm50EJZ9R
         +9zne5LBxOxEdxi2tgJ4p72cbEUhuiqmLyKz4zeTTm46gi5kywSEMsi0wniUFgmkX3oh
         n25rRcB/vgjjNNH2jDOnUIbT7vAJGfpgbJnQqE16ZWlZzJgPfKZC91lhhNqxGobbUnFC
         greNyvFlAviZffzNpY2wxPSPOwsbxoOGjkMc++yBEIa9jD7BINdr4g+2XPLmUvEXXxGd
         3E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvY29V/GM0mH1NqPcwS/Tuc0R9fYJIruV6sTb6TXI7Q=;
        b=70GYpfE73GGVxlamWwxVkpZB6t/avh4mMpVIq3rJWTmiuIwSOyL4wPvicDmYAHVr0X
         dLpTUethDzFVT8TxRMHMt2fLHOXx3pNZrK1DGkPJvlvV4SCMpgmIEumz8E2yzbQDSh2a
         U0obGr2NHpqUh58+/t+w0PzLia5KSf7x1tv3weQzk/EAkXc0c+HQHSoJChFpneT2FBdW
         5YxEEfARm90AgAphBeOWjU/6kviEk/0Xj9RwQyRgjo45GJAD7YaMbIcX5UxsmlVx3wl0
         ZdWqJjQH9YUGfEb3BhfME7txGSlp8r+oPz5QMmyMB6iqQxj6EknD0KL6WN0JdJW6bDHR
         DZCA==
X-Gm-Message-State: AJIora+qQ1vnhhMAkA3jGjFDtwJwp7j8XKrDfLoxtrYbDN3Ji12ZBHxz
        QwTfhH3qNIK/cggNOVNALY/cqIe7LhHXXqghAk9ZRw==
X-Google-Smtp-Source: AGRyM1vxgZjKkuDI5/wzHx61/ekf3zJdK1KuYe2+bO8Nmwp5DWyBuh0+xl9Yf7quQUx7gopiDiGvDXqpKG8WcMJK8es=
X-Received: by 2002:a05:6808:1182:b0:32d:a9d3:4e0 with SMTP id
 j2-20020a056808118200b0032da9d304e0mr9681619oil.146.1657893543854; Fri, 15
 Jul 2022 06:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-2-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-2-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:58:27 +0100
Message-ID: <CA+EHjTypfypdE=bf5iH87UpQU+feozd486DAXk02Q9PAMqk0BA@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Fri, Jul 15, 2022 at 7:10 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> In order to reuse the arm64 stack unwinding logic for the nVHE
> hypervisor stack, move the common code to a shared header
> (arch/arm64/include/asm/stacktrace/common.h).
>
> The nVHE hypervisor cannot safely link against kernel code, so we
> make use of the shared header to avoid duplicated logic later in
> this series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


>  arch/arm64/include/asm/stacktrace.h        |  35 +------
>  arch/arm64/include/asm/stacktrace/common.h | 105 +++++++++++++++++++++
>  arch/arm64/kernel/stacktrace.c             |  57 -----------
>  3 files changed, 106 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
>
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index aec9315bf156..79f455b37c84 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -8,52 +8,19 @@
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
> -#include <linux/types.h>
>  #include <linux/llist.h>
>
>  #include <asm/memory.h>
>  #include <asm/ptrace.h>
>  #include <asm/sdei.h>
>
> -enum stack_type {
> -       STACK_TYPE_UNKNOWN,
> -       STACK_TYPE_TASK,
> -       STACK_TYPE_IRQ,
> -       STACK_TYPE_OVERFLOW,
> -       STACK_TYPE_SDEI_NORMAL,
> -       STACK_TYPE_SDEI_CRITICAL,
> -       __NR_STACK_TYPES
> -};
> -
> -struct stack_info {
> -       unsigned long low;
> -       unsigned long high;
> -       enum stack_type type;
> -};
> +#include <asm/stacktrace/common.h>
>
>  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>                            const char *loglvl);
>
>  DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
>
> -static inline bool on_stack(unsigned long sp, unsigned long size,
> -                           unsigned long low, unsigned long high,
> -                           enum stack_type type, struct stack_info *info)
> -{
> -       if (!low)
> -               return false;
> -
> -       if (sp < low || sp + size < sp || sp + size > high)
> -               return false;
> -
> -       if (info) {
> -               info->low = low;
> -               info->high = high;
> -               info->type = type;
> -       }
> -       return true;
> -}
> -
>  static inline bool on_irq_stack(unsigned long sp, unsigned long size,
>                                 struct stack_info *info)
>  {
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> new file mode 100644
> index 000000000000..64ae4f6b06fe
> --- /dev/null
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -0,0 +1,105 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Common arm64 stack unwinder code.
> + *
> + * Copyright (C) 2012 ARM Ltd.
> + */
> +#ifndef __ASM_STACKTRACE_COMMON_H
> +#define __ASM_STACKTRACE_COMMON_H
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +
> +enum stack_type {
> +       STACK_TYPE_UNKNOWN,
> +       STACK_TYPE_TASK,
> +       STACK_TYPE_IRQ,
> +       STACK_TYPE_OVERFLOW,
> +       STACK_TYPE_SDEI_NORMAL,
> +       STACK_TYPE_SDEI_CRITICAL,
> +       __NR_STACK_TYPES
> +};
> +
> +struct stack_info {
> +       unsigned long low;
> +       unsigned long high;
> +       enum stack_type type;
> +};
> +
> +/*
> + * A snapshot of a frame record or fp/lr register values, along with some
> + * accounting information necessary for robust unwinding.
> + *
> + * @fp:          The fp value in the frame record (or the real fp)
> + * @pc:          The lr value in the frame record (or the real lr)
> + *
> + * @stacks_done: Stacks which have been entirely unwound, for which it is no
> + *               longer valid to unwind to.
> + *
> + * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> + *               of 0. This is used to ensure that within a stack, each
> + *               subsequent frame record is at an increasing address.
> + * @prev_type:   The type of stack this frame record was on, or a synthetic
> + *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> + *               transition from one stack to another.
> + *
> + * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> + *               associated with the most recently encountered replacement lr
> + *               value.
> + *
> + * @task:        The task being unwound.
> + */
> +struct unwind_state {
> +       unsigned long fp;
> +       unsigned long pc;
> +       DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> +       unsigned long prev_fp;
> +       enum stack_type prev_type;
> +#ifdef CONFIG_KRETPROBES
> +       struct llist_node *kr_cur;
> +#endif
> +       struct task_struct *task;
> +};
> +
> +static inline bool on_stack(unsigned long sp, unsigned long size,
> +                           unsigned long low, unsigned long high,
> +                           enum stack_type type, struct stack_info *info)
> +{
> +       if (!low)
> +               return false;
> +
> +       if (sp < low || sp + size < sp || sp + size > high)
> +               return false;
> +
> +       if (info) {
> +               info->low = low;
> +               info->high = high;
> +               info->type = type;
> +       }
> +       return true;
> +}
> +
> +static inline void unwind_init_common(struct unwind_state *state,
> +                                     struct task_struct *task)
> +{
> +       state->task = task;
> +#ifdef CONFIG_KRETPROBES
> +       state->kr_cur = NULL;
> +#endif
> +
> +       /*
> +        * Prime the first unwind.
> +        *
> +        * In unwind_next() we'll check that the FP points to a valid stack,
> +        * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> +        * treated as a transition to whichever stack that happens to be. The
> +        * prev_fp value won't be used, but we set it to 0 such that it is
> +        * definitely not an accessible stack address.
> +        */
> +       bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> +       state->prev_fp = 0;
> +       state->prev_type = STACK_TYPE_UNKNOWN;
> +}
> +
> +#endif /* __ASM_STACKTRACE_COMMON_H */
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index fcaa151b81f1..94a5dd2ab8fd 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -18,63 +18,6 @@
>  #include <asm/stack_pointer.h>
>  #include <asm/stacktrace.h>
>
> -/*
> - * A snapshot of a frame record or fp/lr register values, along with some
> - * accounting information necessary for robust unwinding.
> - *
> - * @fp:          The fp value in the frame record (or the real fp)
> - * @pc:          The lr value in the frame record (or the real lr)
> - *
> - * @stacks_done: Stacks which have been entirely unwound, for which it is no
> - *               longer valid to unwind to.
> - *
> - * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> - *               of 0. This is used to ensure that within a stack, each
> - *               subsequent frame record is at an increasing address.
> - * @prev_type:   The type of stack this frame record was on, or a synthetic
> - *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> - *               transition from one stack to another.
> - *
> - * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> - *               associated with the most recently encountered replacement lr
> - *               value.
> - *
> - * @task:        The task being unwound.
> - */
> -struct unwind_state {
> -       unsigned long fp;
> -       unsigned long pc;
> -       DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> -       unsigned long prev_fp;
> -       enum stack_type prev_type;
> -#ifdef CONFIG_KRETPROBES
> -       struct llist_node *kr_cur;
> -#endif
> -       struct task_struct *task;
> -};
> -
> -static void unwind_init_common(struct unwind_state *state,
> -                              struct task_struct *task)
> -{
> -       state->task = task;
> -#ifdef CONFIG_KRETPROBES
> -       state->kr_cur = NULL;
> -#endif
> -
> -       /*
> -        * Prime the first unwind.
> -        *
> -        * In unwind_next() we'll check that the FP points to a valid stack,
> -        * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> -        * treated as a transition to whichever stack that happens to be. The
> -        * prev_fp value won't be used, but we set it to 0 such that it is
> -        * definitely not an accessible stack address.
> -        */
> -       bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> -       state->prev_fp = 0;
> -       state->prev_type = STACK_TYPE_UNKNOWN;
> -}
> -
>  /*
>   * Start an unwind from a pt_regs.
>   *
> --
> 2.37.0.170.g444d1eabd0-goog
>
