Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FDF48FBFF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 10:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiAPJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 04:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiAPJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 04:38:38 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CE9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 01:38:38 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id m15so24992990uap.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 01:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPwvpMeX7/VRxsUsvh5ugKJtoSAD+TyzCeiSfRll9OQ=;
        b=AcV3lwBLpe1Yagub6q+UZwlJNn+dAZ8gGdzqgxPY6wxcRRJN+i3+BP7syQlA3Emg5C
         QfHH+Yzjqt7di9w2STUci/Q6WB56vjZ2qKMSrIwDRo8/tReH1rRyNaf0fXfRlzOKwNUY
         3T5p1IUi8I98RBIX/sBZ95zI5WG7eAAU+13IKRwkBx3wn3HmPq3sUhJKoOXNNxPx6aQT
         ezZ187UN0DayPmleUSScPlsUosFolEKPSSU/ZYJb06KKKJoDeEnQhj5j4M6bI/xpJYjm
         1kKm2q1vJwfTtQ5sIulxE442zJAD1v6yzDOidZVT9la0VDFTi0oc02pmohz/bidnDnDW
         HRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPwvpMeX7/VRxsUsvh5ugKJtoSAD+TyzCeiSfRll9OQ=;
        b=A3zwrYosKXcydfC7LKL8GYvEPKC/lqosHp2HDiKp7lGdkRUFNp229dBv5GhrFP6tRT
         xuGLCH+xgRrBIyZornjYw9yIkRCLd+fuLy0liaK6QG6C6zBbuXUO5sjzMOXJycpQ6iZQ
         JhIwiKqLKG8lkeXVa+5wBDaqeamFEy5ddB3vOEvd4S1QEsFGPkvNeXJwjVHidp0aZc5J
         ebJ+lcmeZcyIJYMaqN63TctMpM70s8/Jz8hxrZbzIJsHOKlBQxAKYaCDIUd1X3V2cfNo
         yYfkUA2/74EdJdpO3Du4+qP5jUAaYdD7a5aeRUcLCHqsfSodyABhMJWxKNqdE6ramFxb
         DUmw==
X-Gm-Message-State: AOAM530NtZEv6xBJm/TO8EuVM9oMOg1IxlQFlq11I+bqkfC3Ue780rW5
        bS+lv5+5RkhlLi/oN7R+SKfhLeneUatKQP7mBwAlyHYeCOMA7J/j
X-Google-Smtp-Source: ABdhPJza9Use6/MIwWAUyox/haAqkVc9Sr2Wz8jXaoF43VZWTtSzjr1f4oD/XnyosFnv2Y3cpN4X6U5HbanEnGc0CW0=
X-Received: by 2002:a05:6102:c06:: with SMTP id x6mr3253816vss.52.1642325917347;
 Sun, 16 Jan 2022 01:38:37 -0800 (PST)
MIME-Version: 1.0
References: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
 <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com> <20211217164019.7d5d9848f350fef4f709c62f@kernel.org>
 <CAAgTQPXi_cmi27upcLHgen3PotOtcu64oAxjYp559g6fYgkCvQ@mail.gmail.com> <20220107212046.13e55368664b31c2b41b7e94@kernel.org>
In-Reply-To: <20220107212046.13e55368664b31c2b41b7e94@kernel.org>
From:   Jianhua Liu <jianhua.ljh@gmail.com>
Date:   Sun, 16 Jan 2022 17:38:26 +0800
Message-ID: <CAAgTQPWs0x_Hczc6ha5Cf2sVOYhAO91g-=79abi_+DWs9v-1kA@mail.gmail.com>
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

On Fri, Jan 7, 2022 at 8:20 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Fri, 7 Jan 2022 01:34:16 +0800
> Jianhua Liu <jianhua.ljh@gmail.com> wrote:
>
> > On Fri, Dec 17, 2021 at 3:40 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue,  2 Nov 2021 21:11:46 +0800
> > > Janet Liu <jianhua.ljh@gmail.com> wrote:
> > >
> > > > From: Janet Liu <janet.liu@unisoc.com>
> > > >
> > > > This patch allow kprobes on ftrace call sites. This optimization
> > > > avoids use of a trap with regular kprobes.
> > > >
> > > > This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> > > > "patchable-function-entry" options which is only implemented with newer
> > > > toolchains.
> > > >
> > > > Signed-off-by: Janet Liu <janet.liu@unisoc.com>
> > > > ---
> > > >  arch/arm64/Kconfig                 |  1 +
> > > >  arch/arm64/kernel/probes/Makefile  |  1 +
> > > >  arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++
> > > >  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++
> > > >  4 files changed, 102 insertions(+)
> > > >  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> > > >
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 339130712093..f59005608976 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -200,6 +200,7 @@ config ARM64
> > > >       select HAVE_SYSCALL_TRACEPOINTS
> > > >       select HAVE_KPROBES
> > > >       select HAVE_OPTPROBES
> > > > +     select HAVE_KPROBES_ON_FTRACE
> > > >       select HAVE_KRETPROBES
> > > >       select HAVE_GENERIC_VDSO
> > > >       select IOMMU_DMA if IOMMU_SUPPORT
> > > > diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> > > > index c77c92ac95fd..d9b204f4795a 100644
> > > > --- a/arch/arm64/kernel/probes/Makefile
> > > > +++ b/arch/arm64/kernel/probes/Makefile
> > > > @@ -3,5 +3,6 @@ obj-$(CONFIG_KPROBES)         += kprobes.o decode-insn.o      \
> > > >                                  kprobes_trampoline.o         \
> > > >                                  simulate-insn.o
> > > >  obj-$(CONFIG_OPTPROBES)      += opt.o opt_head.o
> > > > +obj-$(CONFIG_KPROBES_ON_FTRACE) += ftrace.o
> > > >  obj-$(CONFIG_UPROBES)                += uprobes.o decode-insn.o      \
> > > >                                  simulate-insn.o
> > > > diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> > > > new file mode 100644
> > > > index 000000000000..46ea92eb552f
> > > > --- /dev/null
> > > > +++ b/arch/arm64/kernel/probes/ftrace.c
> > > > @@ -0,0 +1,73 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +//
> > > > +// Dynamic Ftrace based Kprobes Optimization
> > > > +//
> > > > +// Copyright (C) 2021, Unisoc Inc.
> > > > +// Author: Janet Liu <janet.liu@unisoc.com>
> > > > +#include <linux/kprobes.h>
> > > > +#include <linux/ptrace.h>
> > > > +#include <linux/hardirq.h>
> > > > +#include <linux/preempt.h>
> > > > +#include <linux/ftrace.h>
> > > > +
> > > > +
> > > > +/* Ftrace callback handler for kprobes*/
> > > > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > > +                        struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > +{
> > > > +     struct kprobe *p;
> > > > +     struct kprobe_ctlblk *kcb;
> > > > +     struct pt_regs *regs = ftrace_get_regs(fregs);
> > > > +     int bit;
> > > > +
> > > > +     bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > > > +     if (bit < 0)
> > > > +             return;
> > > > +
> > > > +     preempt_disable_notrace();
> > >
> > > This already has been done in ftrace side.
> >
> > Hi Masami,
> >
> > Got it by reading code, will fix this.
> >
> > >
> > > > +     p = get_kprobe((kprobe_opcode_t *)ip);
> > > > +     if (unlikely(!p) || kprobe_disabled(p))
> > > > +             goto end;
> > > > +
> > > > +     kcb = get_kprobe_ctlblk();
> > > > +     if (kprobe_running()) {
> > > > +             kprobes_inc_nmissed_count(p);
> > > > +     } else {
> > > > +             unsigned long orig_ip = instruction_pointer(regs);
> > > > +
> > > > +             instruction_pointer_set(regs, ip);
> > >
> > > The 'ip' is the address of the 'bl' instruction, which must be
> > > p->addr + AARCH64_INSN_SIZE * 2. But this is a bit strange.
> > >
> > > On aarch64, if the user probe callback is called from breakpoint handler,
> > > regs->pc == kp->addr. But in this case, it is not the same.
> > >
> > > So, what about this?
> > >
> > >  instruction_pointer_set(regs, ip - AARCH64_INSN_SIZE);
> > >
> >
> > I got what you said.
> >
> > But p->addr is changed when KPROBES_ON_FTRACE enable.
> > I implemented kprobe_lookup_name for arm64 to do the change in this patch.
>
> Hmm, that is no good, because printk("%pS\n", p->addr) does not show
> what the user set by p->symbol_name. This may confuse user.
> Moreover, if user doesn't set symbol_name but addr directly (this
> happens when you use 'perf probe' command, which will pass the address
> from '_text', not the function entry.
>

Hi Masami,

Thanks for your explanation,if user doesn't set p->addr will not
kprobe on ftrace entry.
This also confuse me.

> > because kernel/kprobe.c:check_ftrace_location check,
> > if p->addr != ftrace_addr, don't kprobe on ftrace entry.
> > so p->addr is equal to ftrace addr(the second nop), is equal to 'ip'.
> > here should be instruction_pointer_set(regs, ip);
>
> Hmm, OK. this is a special case for the arm64 (and maybe other
> architectures except for x86). Let's fix the check_ftrace_location().
> We already know that 2 instructions at the beginning of function will
> be used for ftrace on arm64. Thus arm64 version of check_ftrace_location()
> will check the given address + 1 is ftrace location or not.
>
> >
> > > > +
> > > > +             __this_cpu_write(current_kprobe, p);
> > > > +             kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > > +             if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > > +                     /*
> > > > +                      *Emulate singlestep (and also recover regs->pc)
> > > > +                      *as if there is a nop
> > > > +                      */
> > > > +                     instruction_pointer_set(regs,
> > > > +                                     (unsigned long)p->addr + MCOUNT_INSN_SIZE);
> > >
> > > And then, this will be
> > >
> > >                         instruction_pointer_set(regs,
> > >                                         (unsigned long)p->addr + AARCH64_INSN_SIZE * 2);
> > >
> > > So basically, kprobes on ftrace will skips 2 NOP instructions (the compiler installed
> > > 2 nops) and call post handler. This means we have a virtual big NOP instruction there.
> > >
> > Ditto, skip two nop instructions should
> > instruction_pointer_set(regs,
> >                         (unsigned long)p->addr + AARCH64_INSN_SIZE);
> >
> >
> > > > +                     if (unlikely(p->post_handler)) {
> > > > +                             kcb->kprobe_status = KPROBE_HIT_SSDONE;
> > > > +                             p->post_handler(p, regs, 0);
> > > > +                     }
> > > > +                     instruction_pointer_set(regs, orig_ip);
> > > > +             }
> > > > +
> > > > +             /*
> > > > +              * If pre_handler returns !0,it changes regs->pc. We have to
> > > > +              * skip emulating post_handler.
> > > > +              */
> > > > +             __this_cpu_write(current_kprobe, NULL);
> > > > +     }
> > > > +end:
> > > > +     preempt_enable_notrace();
> > > > +     ftrace_test_recursion_unlock(bit);
> > > > +}
> > > > +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> > > > +
> > > > +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> > > > +{
> > > > +     p->ainsn.api.insn = NULL;
> > > > +     p->ainsn.api.restore = 0;
> > > > +     return 0;
> > > > +}
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > > index 6dbcc89f6662..3d371d3e4dfa 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -417,6 +417,33 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> > > >       return 0;
> > > >  }
> > > >
> > > > +kprobe_opcode_t __kprobes *kprobe_lookup_name(const char *name, unsigned int offset)
> > > > +{
> > > > +     kprobe_opcode_t *addr;
> > > > +
> > > > +     addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> > > > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > > > +     if (addr && !offset) {
> > > > +             unsigned long faddr;
> > > > +
> > > > +             faddr = ftrace_location_range((unsigned long)addr,
> > > > +                                           (unsigned long)addr + 8);
> > >
> > > this '8' must be (AARCH64_INSN_SIZE * 2). And here you may need to add
> > > a comment why search the 2 instructions. (it is because arm64 uses
> > > -fpatchable-function-entry=2.)
> > >
> > Got it , will fix it.
> > > > +             if (faddr)
> > > > +                     addr = (kprobe_opcode_t *)faddr;
> > > > +     }
> > This change the p->addr to ftrace_addr.
>
> Ah, OK. Please forgot above. What we have to do is to change the
> check_ftrace_location(), not this conversion.

I don't do this conversion, and try to implement arm64 special
check_ftrace_location as following.
but register kprobe fail.

diff --git a/arch/arm64/kernel/probes/kprobes.c
b/arch/arm64/kernel/probes/kprobes.c
index d9dfa82c1f18..609f3f103a89 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
+int __kprobes check_ftrace_location(struct kprobe *p)
+{
+        unsigned long ftrace_addr;
+
+        ftrace_addr = ftrace_location_range((unsigned long)p->addr,
+                               (unsigned long)p->addr + AARCH64_INSN_SIZE * 2);
+        if (ftrace_addr) {
+#ifdef CONFIG_KPROBES_ON_FTRACE
+                /* Given address is not on the instruction boundary */
+                if ((unsigned long)p->addr > ftrace_addr)
+                        return -EILSEQ;
+               if (p->offset <= AARCH64_INSN_SIZE * 2)
+                       p->flags |= KPROBE_FLAG_FTRACE;
+#else   /* !CONFIG_KPROBES_ON_FTRACE */
+                return -EINVAL;
+#endif
+        }
+        return 0;
+}
+
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 21eccc961bba..91c95ba4eed0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1539,7 +1539,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
        return ret;
 }

-static int check_ftrace_location(struct kprobe *p)
+int __weak check_ftrace_location(struct kprobe *p)
 {
        unsigned long ftrace_addr;


__arm_kprobe_ftrace print fail info:
[   38.286515] Failed to arm kprobe-ftrace at kernel_clone+0x0/0x440 (error -22)
[   38.286606] WARNING: CPU: 3 PID: 341 at kernel/kprobes.c:1062
arm_kprobe+0x114/0x14c

__arm_kprobe_ftrace calls ftrace_set_filter_ip,
ftrace_set_filter_ip use p->addr, but failed.

Thanks
Jianhua

>
> Thank you,
>
> >
> > > > +#endif
> > > > +     return addr;
> > > > +}
> > > > +
> > > > +bool __kprobes arch_kprobe_on_func_entry(unsigned long offset)
> > > > +{
> > > > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > > > +     return offset <= 8;
> > >
> > > Ditto.
> > Got it, will add comment.
> >
> > Thanks
> >
> > Jianhua
> > >
> > > > +#else
> > > > +     return !offset;
> > > > +#endif
> > > > +}
> > > > +
> > > >  int __init arch_init_kprobes(void)
> > > >  {
> > > >       register_kernel_break_hook(&kprobes_break_hook);
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Thank you,
> > >
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
