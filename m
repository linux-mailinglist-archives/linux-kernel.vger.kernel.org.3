Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECF578647
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiGRP0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiGRP0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:26:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09729817
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:26:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so17591498wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BBVisBKsOuFCaWJW8FqdMGsV9Mygag9vrni2gyPgdU=;
        b=CUyuRNfL6dcWl8MLZeFSVk8tNPeTGHtXtUStezWSKnMCMQCNstnVXqZYu5JxnTR7XJ
         MgEdWQe6GIYxOm9d0jUxEMbXZT4QzlhuDtqLAQnNlmOC+xKs4Xob9FYC+fBNTcHUxnsy
         HHcRYuBLWUxSZtpxe60S0/VvOUxudhJXeHOT4xNfRz4zbnJzfaaBMegZLqUlfoJ/sbDP
         1dlE6XpeeUeaBRCQsaPU1W4T0Nyu7pYANTvJe4gR6Ua3pjAm9Kxk5U+W3v4VP7m+g6em
         pKl61h4thU0W5+v4LUaPCmtWfiTGO1Hssft8jq+dHhj2k/2FhkyImBMazQ2s7EkJw5th
         rTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BBVisBKsOuFCaWJW8FqdMGsV9Mygag9vrni2gyPgdU=;
        b=ujEo4W+ZF3oT2PIgLiUCSYxXdN7GK1PnEpzqUvuvfy5KPTlG2PjpuYoBMRRg61t1ML
         gBmH1t+JDs6q9cme2FE5Q0s951VyBLofVnX1mP1b937+ec/4iU0jEUwASRHd+/sdYO7D
         v3jwDmbCOuwnMeS+OR/jDy0fLgOBynSEd8nqkRqTR+Hbfl16SMhmsaBoZ5krEajFelVg
         OvXymXYOYxesfUfi4P1Qh5S7QFrgC25SlImtB6l9u5iJAtW38tT4CKuagWIUAnZNdB/T
         K3yPIRu1KKQWMq/u/iw6bKKHc9myiuTHmx5N5BKXcv60wCX74OK+RARvs71qsVXsRcYQ
         pSbQ==
X-Gm-Message-State: AJIora+yV9vlF5Oin4kSnNDRqPCUI7l1bOT9GpEFPVuDSgC6qBLOmBzR
        xusYa/662wuatNgRTj+ffZEs6GWqXyS4Gsf8EvAW/Q==
X-Google-Smtp-Source: AGRyM1tfqA8v+n1Iv8tYAEsEUB8q11/C1gFI8FcWWbqI2+1eCRD0k/mPREZSFCgipbsHK41VXaxBHzuGqizqDY8qyP0=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id
 bj4-20020a0560001e0400b0021d7ec3fe5amr23615636wrb.116.1658157985222; Mon, 18
 Jul 2022 08:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-2-kaleshsingh@google.com> <YtVXokYGdlq1maQu@shell.armlinux.org.uk>
In-Reply-To: <YtVXokYGdlq1maQu@shell.armlinux.org.uk>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 08:26:14 -0700
Message-ID: <CAC_TJvfZG6CQOdSKeiNfVQhmL2TyeEuFbo9qo9yT20Qh49d3ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/18] arm64: stacktrace: Add shared header for common
 stack unwinding code
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        tabba@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
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

On Mon, Jul 18, 2022 at 5:52 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi,
>
> Can you please explain why you are targetting my @oracle.com email
> address with this patch set?
>
> This causes me problems as I use Outlook's Web interface for that
> which doesn't appear to cope with the threading, and most certainly
> is only capable of top-reply only which is against Linux kernel email
> standards.

Hi Russell,

Sorry I wasn't aware of it (I got your oracle email from
get_maintainer script). Going forward I'll use the one you responded
from instead.

Thanks,
Kalesh

>
> Thanks.
>
> On Thu, Jul 14, 2022 at 11:10:10PM -0700, Kalesh Singh wrote:
> > In order to reuse the arm64 stack unwinding logic for the nVHE
> > hypervisor stack, move the common code to a shared header
> > (arch/arm64/include/asm/stacktrace/common.h).
> >
> > The nVHE hypervisor cannot safely link against kernel code, so we
> > make use of the shared header to avoid duplicated logic later in
> > this series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace.h        |  35 +------
> >  arch/arm64/include/asm/stacktrace/common.h | 105 +++++++++++++++++++++
> >  arch/arm64/kernel/stacktrace.c             |  57 -----------
> >  3 files changed, 106 insertions(+), 91 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/stacktrace/common.h
> >
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> > index aec9315bf156..79f455b37c84 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -8,52 +8,19 @@
> >  #include <linux/percpu.h>
> >  #include <linux/sched.h>
> >  #include <linux/sched/task_stack.h>
> > -#include <linux/types.h>
> >  #include <linux/llist.h>
> >
> >  #include <asm/memory.h>
> >  #include <asm/ptrace.h>
> >  #include <asm/sdei.h>
> >
> > -enum stack_type {
> > -     STACK_TYPE_UNKNOWN,
> > -     STACK_TYPE_TASK,
> > -     STACK_TYPE_IRQ,
> > -     STACK_TYPE_OVERFLOW,
> > -     STACK_TYPE_SDEI_NORMAL,
> > -     STACK_TYPE_SDEI_CRITICAL,
> > -     __NR_STACK_TYPES
> > -};
> > -
> > -struct stack_info {
> > -     unsigned long low;
> > -     unsigned long high;
> > -     enum stack_type type;
> > -};
> > +#include <asm/stacktrace/common.h>
> >
> >  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
> >                          const char *loglvl);
> >
> >  DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
> >
> > -static inline bool on_stack(unsigned long sp, unsigned long size,
> > -                         unsigned long low, unsigned long high,
> > -                         enum stack_type type, struct stack_info *info)
> > -{
> > -     if (!low)
> > -             return false;
> > -
> > -     if (sp < low || sp + size < sp || sp + size > high)
> > -             return false;
> > -
> > -     if (info) {
> > -             info->low = low;
> > -             info->high = high;
> > -             info->type = type;
> > -     }
> > -     return true;
> > -}
> > -
> >  static inline bool on_irq_stack(unsigned long sp, unsigned long size,
> >                               struct stack_info *info)
> >  {
> > diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> > new file mode 100644
> > index 000000000000..64ae4f6b06fe
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/stacktrace/common.h
> > @@ -0,0 +1,105 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Common arm64 stack unwinder code.
> > + *
> > + * Copyright (C) 2012 ARM Ltd.
> > + */
> > +#ifndef __ASM_STACKTRACE_COMMON_H
> > +#define __ASM_STACKTRACE_COMMON_H
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/bitops.h>
> > +#include <linux/types.h>
> > +
> > +enum stack_type {
> > +     STACK_TYPE_UNKNOWN,
> > +     STACK_TYPE_TASK,
> > +     STACK_TYPE_IRQ,
> > +     STACK_TYPE_OVERFLOW,
> > +     STACK_TYPE_SDEI_NORMAL,
> > +     STACK_TYPE_SDEI_CRITICAL,
> > +     __NR_STACK_TYPES
> > +};
> > +
> > +struct stack_info {
> > +     unsigned long low;
> > +     unsigned long high;
> > +     enum stack_type type;
> > +};
> > +
> > +/*
> > + * A snapshot of a frame record or fp/lr register values, along with some
> > + * accounting information necessary for robust unwinding.
> > + *
> > + * @fp:          The fp value in the frame record (or the real fp)
> > + * @pc:          The lr value in the frame record (or the real lr)
> > + *
> > + * @stacks_done: Stacks which have been entirely unwound, for which it is no
> > + *               longer valid to unwind to.
> > + *
> > + * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> > + *               of 0. This is used to ensure that within a stack, each
> > + *               subsequent frame record is at an increasing address.
> > + * @prev_type:   The type of stack this frame record was on, or a synthetic
> > + *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> > + *               transition from one stack to another.
> > + *
> > + * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> > + *               associated with the most recently encountered replacement lr
> > + *               value.
> > + *
> > + * @task:        The task being unwound.
> > + */
> > +struct unwind_state {
> > +     unsigned long fp;
> > +     unsigned long pc;
> > +     DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> > +     unsigned long prev_fp;
> > +     enum stack_type prev_type;
> > +#ifdef CONFIG_KRETPROBES
> > +     struct llist_node *kr_cur;
> > +#endif
> > +     struct task_struct *task;
> > +};
> > +
> > +static inline bool on_stack(unsigned long sp, unsigned long size,
> > +                         unsigned long low, unsigned long high,
> > +                         enum stack_type type, struct stack_info *info)
> > +{
> > +     if (!low)
> > +             return false;
> > +
> > +     if (sp < low || sp + size < sp || sp + size > high)
> > +             return false;
> > +
> > +     if (info) {
> > +             info->low = low;
> > +             info->high = high;
> > +             info->type = type;
> > +     }
> > +     return true;
> > +}
> > +
> > +static inline void unwind_init_common(struct unwind_state *state,
> > +                                   struct task_struct *task)
> > +{
> > +     state->task = task;
> > +#ifdef CONFIG_KRETPROBES
> > +     state->kr_cur = NULL;
> > +#endif
> > +
> > +     /*
> > +      * Prime the first unwind.
> > +      *
> > +      * In unwind_next() we'll check that the FP points to a valid stack,
> > +      * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> > +      * treated as a transition to whichever stack that happens to be. The
> > +      * prev_fp value won't be used, but we set it to 0 such that it is
> > +      * definitely not an accessible stack address.
> > +      */
> > +     bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> > +     state->prev_fp = 0;
> > +     state->prev_type = STACK_TYPE_UNKNOWN;
> > +}
> > +
> > +#endif       /* __ASM_STACKTRACE_COMMON_H */
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index fcaa151b81f1..94a5dd2ab8fd 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -18,63 +18,6 @@
> >  #include <asm/stack_pointer.h>
> >  #include <asm/stacktrace.h>
> >
> > -/*
> > - * A snapshot of a frame record or fp/lr register values, along with some
> > - * accounting information necessary for robust unwinding.
> > - *
> > - * @fp:          The fp value in the frame record (or the real fp)
> > - * @pc:          The lr value in the frame record (or the real lr)
> > - *
> > - * @stacks_done: Stacks which have been entirely unwound, for which it is no
> > - *               longer valid to unwind to.
> > - *
> > - * @prev_fp:     The fp that pointed to this frame record, or a synthetic value
> > - *               of 0. This is used to ensure that within a stack, each
> > - *               subsequent frame record is at an increasing address.
> > - * @prev_type:   The type of stack this frame record was on, or a synthetic
> > - *               value of STACK_TYPE_UNKNOWN. This is used to detect a
> > - *               transition from one stack to another.
> > - *
> > - * @kr_cur:      When KRETPROBES is selected, holds the kretprobe instance
> > - *               associated with the most recently encountered replacement lr
> > - *               value.
> > - *
> > - * @task:        The task being unwound.
> > - */
> > -struct unwind_state {
> > -     unsigned long fp;
> > -     unsigned long pc;
> > -     DECLARE_BITMAP(stacks_done, __NR_STACK_TYPES);
> > -     unsigned long prev_fp;
> > -     enum stack_type prev_type;
> > -#ifdef CONFIG_KRETPROBES
> > -     struct llist_node *kr_cur;
> > -#endif
> > -     struct task_struct *task;
> > -};
> > -
> > -static void unwind_init_common(struct unwind_state *state,
> > -                            struct task_struct *task)
> > -{
> > -     state->task = task;
> > -#ifdef CONFIG_KRETPROBES
> > -     state->kr_cur = NULL;
> > -#endif
> > -
> > -     /*
> > -      * Prime the first unwind.
> > -      *
> > -      * In unwind_next() we'll check that the FP points to a valid stack,
> > -      * which can't be STACK_TYPE_UNKNOWN, and the first unwind will be
> > -      * treated as a transition to whichever stack that happens to be. The
> > -      * prev_fp value won't be used, but we set it to 0 such that it is
> > -      * definitely not an accessible stack address.
> > -      */
> > -     bitmap_zero(state->stacks_done, __NR_STACK_TYPES);
> > -     state->prev_fp = 0;
> > -     state->prev_type = STACK_TYPE_UNKNOWN;
> > -}
> > -
> >  /*
> >   * Start an unwind from a pt_regs.
> >   *
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
