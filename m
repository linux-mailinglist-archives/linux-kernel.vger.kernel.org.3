Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D524868B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiAFRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiAFRe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:34:29 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F7C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:34:28 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id r15so5720955uao.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0laZ74wUIghIpO5Dyzu0jeMZa+nQlHTvOE9+q9E46g=;
        b=lAKKOXyUXSSHJvWfq0Jm9SDxl3Pk/VJh/paddV907+8ir02mVAJN8iV5D8MnyaqzcK
         zuDSRLsgMYp0oTERaKpE36kxjtOlce+XBhvITqrHGqHXOueu9USkplmejBMXVTNI3q5T
         u/7/H3R2zglNRS2sFusA3/fIxwuzX2ToqQwNeR5az8MS+BaFtB1ghNdV+eYUPAsAaOp9
         0HRpjCpyVsXAkmuDmfAMfaWYUZd2J07n9J65puIhNduT0yhXET5skPXeUAP9BmwHoFP9
         pdnLDOF9noxllMIRSi9IAX4lCFDsDGQC53u50zRPngZNqcMDedYaohOisn5DsGuXBPV9
         SCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0laZ74wUIghIpO5Dyzu0jeMZa+nQlHTvOE9+q9E46g=;
        b=OnGCBCBfTCdSA8ryP/kI2vGf+O9EjiY2mHRlLymHa+9y3KG4jpRtUAkhP8lfppjYrs
         tsk/mun/w4TjLsUfW5A9EJDZ/MHm54IbmYhMoTCjJXzVec9JHLEWy14vwJL7YKTlRMQi
         gqMoX+kgtjU26ekjl73BsJiYvirvmZspkk/ablcByzPYTL86Z/drDBs1j8sU27omQr1p
         qRmU2oxWfxxbEkbKo4f/XedZaL+TCdE9XwJ54QPvSAjhZxUFDS9qxRbpOlSFO78DXBmR
         PAQwZYKDQkzI0CchVlIcjco1g8tpLHuFrpnHhhTAdxFOl33CdKvfxfarEpJkQqJaZvLw
         LroA==
X-Gm-Message-State: AOAM530alL588RWWAP1fOwKHkypbWoUXaHcMU7PYjHlClaYdH/RVju82
        Cw5+umtwHGjXb8PwJjy/9ApJgq5zlLY/Z3NeW8XrDal7/Zu3YQ==
X-Google-Smtp-Source: ABdhPJzHe+G7N6/Mcc3ORZTNNUervPhPoAEh/CAtde9g2FU8QogcnIWRhdCiU7h6ZY+0L9d1Dx52EGV5WWiDxytzkyg=
X-Received: by 2002:ab0:376c:: with SMTP id o12mr6994680uat.2.1641490467892;
 Thu, 06 Jan 2022 09:34:27 -0800 (PST)
MIME-Version: 1.0
References: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
 <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com> <20211217164019.7d5d9848f350fef4f709c62f@kernel.org>
In-Reply-To: <20211217164019.7d5d9848f350fef4f709c62f@kernel.org>
From:   Jianhua Liu <jianhua.ljh@gmail.com>
Date:   Fri, 7 Jan 2022 01:34:16 +0800
Message-ID: <CAAgTQPXi_cmi27upcLHgen3PotOtcu64oAxjYp559g6fYgkCvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: kprobes: add support for KPROBES_ON_FTRACE
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 3:40 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> On Tue,  2 Nov 2021 21:11:46 +0800
> Janet Liu <jianhua.ljh@gmail.com> wrote:
>
> > From: Janet Liu <janet.liu@unisoc.com>
> >
> > This patch allow kprobes on ftrace call sites. This optimization
> > avoids use of a trap with regular kprobes.
> >
> > This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> > "patchable-function-entry" options which is only implemented with newer
> > toolchains.
> >
> > Signed-off-by: Janet Liu <janet.liu@unisoc.com>
> > ---
> >  arch/arm64/Kconfig                 |  1 +
> >  arch/arm64/kernel/probes/Makefile  |  1 +
> >  arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++
> >  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++
> >  4 files changed, 102 insertions(+)
> >  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 339130712093..f59005608976 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -200,6 +200,7 @@ config ARM64
> >       select HAVE_SYSCALL_TRACEPOINTS
> >       select HAVE_KPROBES
> >       select HAVE_OPTPROBES
> > +     select HAVE_KPROBES_ON_FTRACE
> >       select HAVE_KRETPROBES
> >       select HAVE_GENERIC_VDSO
> >       select IOMMU_DMA if IOMMU_SUPPORT
> > diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> > index c77c92ac95fd..d9b204f4795a 100644
> > --- a/arch/arm64/kernel/probes/Makefile
> > +++ b/arch/arm64/kernel/probes/Makefile
> > @@ -3,5 +3,6 @@ obj-$(CONFIG_KPROBES)         += kprobes.o decode-insn.o      \
> >                                  kprobes_trampoline.o         \
> >                                  simulate-insn.o
> >  obj-$(CONFIG_OPTPROBES)      += opt.o opt_head.o
> > +obj-$(CONFIG_KPROBES_ON_FTRACE) += ftrace.o
> >  obj-$(CONFIG_UPROBES)                += uprobes.o decode-insn.o      \
> >                                  simulate-insn.o
> > diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> > new file mode 100644
> > index 000000000000..46ea92eb552f
> > --- /dev/null
> > +++ b/arch/arm64/kernel/probes/ftrace.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Dynamic Ftrace based Kprobes Optimization
> > +//
> > +// Copyright (C) 2021, Unisoc Inc.
> > +// Author: Janet Liu <janet.liu@unisoc.com>
> > +#include <linux/kprobes.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/hardirq.h>
> > +#include <linux/preempt.h>
> > +#include <linux/ftrace.h>
> > +
> > +
> > +/* Ftrace callback handler for kprobes*/
> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > +                        struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > +{
> > +     struct kprobe *p;
> > +     struct kprobe_ctlblk *kcb;
> > +     struct pt_regs *regs = ftrace_get_regs(fregs);
> > +     int bit;
> > +
> > +     bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > +     if (bit < 0)
> > +             return;
> > +
> > +     preempt_disable_notrace();
>
> This already has been done in ftrace side.

Hi Masami,

Got it by reading code, will fix this.

>
> > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > +     if (unlikely(!p) || kprobe_disabled(p))
> > +             goto end;
> > +
> > +     kcb = get_kprobe_ctlblk();
> > +     if (kprobe_running()) {
> > +             kprobes_inc_nmissed_count(p);
> > +     } else {
> > +             unsigned long orig_ip = instruction_pointer(regs);
> > +
> > +             instruction_pointer_set(regs, ip);
>
> The 'ip' is the address of the 'bl' instruction, which must be
> p->addr + AARCH64_INSN_SIZE * 2. But this is a bit strange.
>
> On aarch64, if the user probe callback is called from breakpoint handler,
> regs->pc == kp->addr. But in this case, it is not the same.
>
> So, what about this?
>
>  instruction_pointer_set(regs, ip - AARCH64_INSN_SIZE);
>

I got what you said.

But p->addr is changed when KPROBES_ON_FTRACE enable.
I implemented kprobe_lookup_name for arm64 to do the change in this patch.
because kernel/kprobe.c:check_ftrace_location check,
if p->addr != ftrace_addr, don't kprobe on ftrace entry.
so p->addr is equal to ftrace addr(the second nop), is equal to 'ip'.
here should be instruction_pointer_set(regs, ip);

> > +
> > +             __this_cpu_write(current_kprobe, p);
> > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > +                     /*
> > +                      *Emulate singlestep (and also recover regs->pc)
> > +                      *as if there is a nop
> > +                      */
> > +                     instruction_pointer_set(regs,
> > +                                     (unsigned long)p->addr + MCOUNT_INSN_SIZE);
>
> And then, this will be
>
>                         instruction_pointer_set(regs,
>                                         (unsigned long)p->addr + AARCH64_INSN_SIZE * 2);
>
> So basically, kprobes on ftrace will skips 2 NOP instructions (the compiler installed
> 2 nops) and call post handler. This means we have a virtual big NOP instruction there.
>
Ditto, skip two nop instructions should
instruction_pointer_set(regs,
                        (unsigned long)p->addr + AARCH64_INSN_SIZE);


> > +                     if (unlikely(p->post_handler)) {
> > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > +                             p->post_handler(p, regs, 0);
> > +                     }
> > +                     instruction_pointer_set(regs, orig_ip);
> > +             }
> > +
> > +             /*
> > +              * If pre_handler returns !0,it changes regs->pc. We have to
> > +              * skip emulating post_handler.
> > +              */
> > +             __this_cpu_write(current_kprobe, NULL);
> > +     }
> > +end:
> > +     preempt_enable_notrace();
> > +     ftrace_test_recursion_unlock(bit);
> > +}
> > +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> > +
> > +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> > +{
> > +     p->ainsn.api.insn = NULL;
> > +     p->ainsn.api.restore = 0;
> > +     return 0;
> > +}
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index 6dbcc89f6662..3d371d3e4dfa 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -417,6 +417,33 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> >       return 0;
> >  }
> >
> > +kprobe_opcode_t __kprobes *kprobe_lookup_name(const char *name, unsigned int offset)
> > +{
> > +     kprobe_opcode_t *addr;
> > +
> > +     addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +     if (addr && !offset) {
> > +             unsigned long faddr;
> > +
> > +             faddr = ftrace_location_range((unsigned long)addr,
> > +                                           (unsigned long)addr + 8);
>
> this '8' must be (AARCH64_INSN_SIZE * 2). And here you may need to add
> a comment why search the 2 instructions. (it is because arm64 uses
> -fpatchable-function-entry=2.)
>
Got it , will fix it.
> > +             if (faddr)
> > +                     addr = (kprobe_opcode_t *)faddr;
> > +     }
This change the p->addr to ftrace_addr.

> > +#endif
> > +     return addr;
> > +}
> > +
> > +bool __kprobes arch_kprobe_on_func_entry(unsigned long offset)
> > +{
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +     return offset <= 8;
>
> Ditto.
Got it, will add comment.

Thanks

Jianhua
>
> > +#else
> > +     return !offset;
> > +#endif
> > +}
> > +
> >  int __init arch_init_kprobes(void)
> >  {
> >       register_kernel_break_hook(&kprobes_break_hook);
> > --
> > 2.25.1
> >
>
> Thank you,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
