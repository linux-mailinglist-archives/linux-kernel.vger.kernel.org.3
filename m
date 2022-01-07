Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910DA487789
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiAGMUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:20:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49838 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiAGMUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:20:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 523ABB825E8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 12:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65BEC36AE0;
        Fri,  7 Jan 2022 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641558049;
        bh=MmbxWvy0GrQ2hGg5skln5erXJS6IzOGs4o2Xr0SyRTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=daMo0MGa83aamuWa10Zhpe0ncfTWRCA6cuc9YOSrxI4KO50RSC+DUBSXdUQVd0AZE
         FMzOFSbrhW/wgET3MS+06ikjCF9lpYVqT8ukpsz7K5NxOeIvoKrJW3YmN83Ku3Ewk5
         govzv5wBA9QsxNqScRHADmj9pg4z2ePg7E61U5WT8gHG0q8so4hAd2MVVZ1hiZKtfS
         9wxIN3+CT/LeZ3VXyoqB5CdRjdBZBkQRHOKjUj5ZMgtSKQKvqk5JBoGmM4uEJP+QVQ
         uPy+gxmAWlUXQf7D2IQy2LbyO6zzv/t588OdvQzVLPbLZ4aZ0Yuk107fwVG7GZxeWx
         DylutD7xn/+1A==
Date:   Fri, 7 Jan 2022 21:20:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianhua Liu <jianhua.ljh@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Subject: Re: [PATCH v2 2/2] arm64: kprobes: add support for
 KPROBES_ON_FTRACE
Message-Id: <20220107212046.13e55368664b31c2b41b7e94@kernel.org>
In-Reply-To: <CAAgTQPXi_cmi27upcLHgen3PotOtcu64oAxjYp559g6fYgkCvQ@mail.gmail.com>
References: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
        <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com>
        <20211217164019.7d5d9848f350fef4f709c62f@kernel.org>
        <CAAgTQPXi_cmi27upcLHgen3PotOtcu64oAxjYp559g6fYgkCvQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 01:34:16 +0800
Jianhua Liu <jianhua.ljh@gmail.com> wrote:

> On Fri, Dec 17, 2021 at 3:40 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > On Tue,  2 Nov 2021 21:11:46 +0800
> > Janet Liu <jianhua.ljh@gmail.com> wrote:
> >
> > > From: Janet Liu <janet.liu@unisoc.com>
> > >
> > > This patch allow kprobes on ftrace call sites. This optimization
> > > avoids use of a trap with regular kprobes.
> > >
> > > This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> > > "patchable-function-entry" options which is only implemented with newer
> > > toolchains.
> > >
> > > Signed-off-by: Janet Liu <janet.liu@unisoc.com>
> > > ---
> > >  arch/arm64/Kconfig                 |  1 +
> > >  arch/arm64/kernel/probes/Makefile  |  1 +
> > >  arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++
> > >  4 files changed, 102 insertions(+)
> > >  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 339130712093..f59005608976 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -200,6 +200,7 @@ config ARM64
> > >       select HAVE_SYSCALL_TRACEPOINTS
> > >       select HAVE_KPROBES
> > >       select HAVE_OPTPROBES
> > > +     select HAVE_KPROBES_ON_FTRACE
> > >       select HAVE_KRETPROBES
> > >       select HAVE_GENERIC_VDSO
> > >       select IOMMU_DMA if IOMMU_SUPPORT
> > > diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> > > index c77c92ac95fd..d9b204f4795a 100644
> > > --- a/arch/arm64/kernel/probes/Makefile
> > > +++ b/arch/arm64/kernel/probes/Makefile
> > > @@ -3,5 +3,6 @@ obj-$(CONFIG_KPROBES)         += kprobes.o decode-insn.o      \
> > >                                  kprobes_trampoline.o         \
> > >                                  simulate-insn.o
> > >  obj-$(CONFIG_OPTPROBES)      += opt.o opt_head.o
> > > +obj-$(CONFIG_KPROBES_ON_FTRACE) += ftrace.o
> > >  obj-$(CONFIG_UPROBES)                += uprobes.o decode-insn.o      \
> > >                                  simulate-insn.o
> > > diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> > > new file mode 100644
> > > index 000000000000..46ea92eb552f
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/probes/ftrace.c
> > > @@ -0,0 +1,73 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +//
> > > +// Dynamic Ftrace based Kprobes Optimization
> > > +//
> > > +// Copyright (C) 2021, Unisoc Inc.
> > > +// Author: Janet Liu <janet.liu@unisoc.com>
> > > +#include <linux/kprobes.h>
> > > +#include <linux/ptrace.h>
> > > +#include <linux/hardirq.h>
> > > +#include <linux/preempt.h>
> > > +#include <linux/ftrace.h>
> > > +
> > > +
> > > +/* Ftrace callback handler for kprobes*/
> > > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > +                        struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > +{
> > > +     struct kprobe *p;
> > > +     struct kprobe_ctlblk *kcb;
> > > +     struct pt_regs *regs = ftrace_get_regs(fregs);
> > > +     int bit;
> > > +
> > > +     bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > > +     if (bit < 0)
> > > +             return;
> > > +
> > > +     preempt_disable_notrace();
> >
> > This already has been done in ftrace side.
> 
> Hi Masami,
> 
> Got it by reading code, will fix this.
> 
> >
> > > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > > +     if (unlikely(!p) || kprobe_disabled(p))
> > > +             goto end;
> > > +
> > > +     kcb = get_kprobe_ctlblk();
> > > +     if (kprobe_running()) {
> > > +             kprobes_inc_nmissed_count(p);
> > > +     } else {
> > > +             unsigned long orig_ip = instruction_pointer(regs);
> > > +
> > > +             instruction_pointer_set(regs, ip);
> >
> > The 'ip' is the address of the 'bl' instruction, which must be
> > p->addr + AARCH64_INSN_SIZE * 2. But this is a bit strange.
> >
> > On aarch64, if the user probe callback is called from breakpoint handler,
> > regs->pc == kp->addr. But in this case, it is not the same.
> >
> > So, what about this?
> >
> >  instruction_pointer_set(regs, ip - AARCH64_INSN_SIZE);
> >
> 
> I got what you said.
> 
> But p->addr is changed when KPROBES_ON_FTRACE enable.
> I implemented kprobe_lookup_name for arm64 to do the change in this patch.

Hmm, that is no good, because printk("%pS\n", p->addr) does not show
what the user set by p->symbol_name. This may confuse user.
Moreover, if user doesn't set symbol_name but addr directly (this
happens when you use 'perf probe' command, which will pass the address
from '_text', not the function entry.

> because kernel/kprobe.c:check_ftrace_location check,
> if p->addr != ftrace_addr, don't kprobe on ftrace entry.
> so p->addr is equal to ftrace addr(the second nop), is equal to 'ip'.
> here should be instruction_pointer_set(regs, ip);

Hmm, OK. this is a special case for the arm64 (and maybe other
architectures except for x86). Let's fix the check_ftrace_location().
We already know that 2 instructions at the beginning of function will
be used for ftrace on arm64. Thus arm64 version of check_ftrace_location()
will check the given address + 1 is ftrace location or not.

> 
> > > +
> > > +             __this_cpu_write(current_kprobe, p);
> > > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > +                     /*
> > > +                      *Emulate singlestep (and also recover regs->pc)
> > > +                      *as if there is a nop
> > > +                      */
> > > +                     instruction_pointer_set(regs,
> > > +                                     (unsigned long)p->addr + MCOUNT_INSN_SIZE);
> >
> > And then, this will be
> >
> >                         instruction_pointer_set(regs,
> >                                         (unsigned long)p->addr + AARCH64_INSN_SIZE * 2);
> >
> > So basically, kprobes on ftrace will skips 2 NOP instructions (the compiler installed
> > 2 nops) and call post handler. This means we have a virtual big NOP instruction there.
> >
> Ditto, skip two nop instructions should
> instruction_pointer_set(regs,
>                         (unsigned long)p->addr + AARCH64_INSN_SIZE);
> 
> 
> > > +                     if (unlikely(p->post_handler)) {
> > > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > > +                             p->post_handler(p, regs, 0);
> > > +                     }
> > > +                     instruction_pointer_set(regs, orig_ip);
> > > +             }
> > > +
> > > +             /*
> > > +              * If pre_handler returns !0,it changes regs->pc. We have to
> > > +              * skip emulating post_handler.
> > > +              */
> > > +             __this_cpu_write(current_kprobe, NULL);
> > > +     }
> > > +end:
> > > +     preempt_enable_notrace();
> > > +     ftrace_test_recursion_unlock(bit);
> > > +}
> > > +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> > > +
> > > +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> > > +{
> > > +     p->ainsn.api.insn = NULL;
> > > +     p->ainsn.api.restore = 0;
> > > +     return 0;
> > > +}
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index 6dbcc89f6662..3d371d3e4dfa 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -417,6 +417,33 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> > >       return 0;
> > >  }
> > >
> > > +kprobe_opcode_t __kprobes *kprobe_lookup_name(const char *name, unsigned int offset)
> > > +{
> > > +     kprobe_opcode_t *addr;
> > > +
> > > +     addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> > > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > > +     if (addr && !offset) {
> > > +             unsigned long faddr;
> > > +
> > > +             faddr = ftrace_location_range((unsigned long)addr,
> > > +                                           (unsigned long)addr + 8);
> >
> > this '8' must be (AARCH64_INSN_SIZE * 2). And here you may need to add
> > a comment why search the 2 instructions. (it is because arm64 uses
> > -fpatchable-function-entry=2.)
> >
> Got it , will fix it.
> > > +             if (faddr)
> > > +                     addr = (kprobe_opcode_t *)faddr;
> > > +     }
> This change the p->addr to ftrace_addr.

Ah, OK. Please forgot above. What we have to do is to change the
check_ftrace_location(), not this conversion.

Thank you,

> 
> > > +#endif
> > > +     return addr;
> > > +}
> > > +
> > > +bool __kprobes arch_kprobe_on_func_entry(unsigned long offset)
> > > +{
> > > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > > +     return offset <= 8;
> >
> > Ditto.
> Got it, will add comment.
> 
> Thanks
> 
> Jianhua
> >
> > > +#else
> > > +     return !offset;
> > > +#endif
> > > +}
> > > +
> > >  int __init arch_init_kprobes(void)
> > >  {
> > >       register_kernel_break_hook(&kprobes_break_hook);
> > > --
> > > 2.25.1
> > >
> >
> > Thank you,
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
