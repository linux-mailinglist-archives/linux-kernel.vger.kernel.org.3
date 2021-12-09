Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4A46F620
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhLIVsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLIVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:48:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82FDC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:44:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q72so8261643iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sg2gFrO5qvM/u0esUUFyNWyLwrUBcEzHIL828TKtnRU=;
        b=jrrJ3U6tKnspGvXwHugfumC1TvjJ4RPp9Z8HMdl1OXgXyB1sy67H7ix4sHnZQo9wtT
         F0YfAaDbdAFADe4cljTeRqRo4F+ToiGcqA+Br5Unxu7gRnN2DmaaBiPLrWmonHFHmxeo
         U0PwdiZzKVeO/7fWZXPNAarr3Esxcj5J8ntBFrExuZXOca7gQnhpY7egMQBOWCjsmLXr
         K5tXZbNZ6bcofxoei4lyDEHQyHRLALBd1EjRFW5WNzY/JosK07g2NS5mOFkAecFIxCGH
         ZytIWJHfTT0F6Lnse0DxybgoBAxWN92Tb6gK0IKd46KGIlR6n8UaZT9YtPdCuXPklqCf
         qPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sg2gFrO5qvM/u0esUUFyNWyLwrUBcEzHIL828TKtnRU=;
        b=fs2SwboJoKXTn8oPWmxzuW12B3tlOsiR1CfhK3DBcED+h8GljQJWpr/JDrl/BnP5Id
         tCMmG5VL7nsFE8wpN3xvOhZV9Rl+vlykTuj8vX+9BWaUWpqlKacaz10CKUHMFNYIKDcp
         PUiW3WOdhn8tPaxOzYyEhFOb8mxafxg/0Z5M1SSB3JjXR9zS8LDmPDno3gUsS0C9K8EB
         3vMfcPPhyeabirz9mwew6SdBM6jTpDYwHHcnTK4ean0ZkaaLuKnjpN3ldtyxAMGkDTTG
         aO6XbWoyJB/6WyTRmmdEp+a5PkzdXf6KoR2YvOKJFMhnzQG24froh18IVyGb+LLL7BVP
         +YAA==
X-Gm-Message-State: AOAM533tH+FLJg2AhLCein+WbDKnaZuZTvghnz7JvOnhr4fzkmEo6e7i
        zobV2StyT/ZaHFTwFvm7YTR58ohRgjozxjO3TMFHcA==
X-Google-Smtp-Source: ABdhPJxPrOvWA4e1oo4UC342W7zi0CMyJuUkzw4GyWf0STeXwgTGoBWN7fe7/IqVPC36bMY5YDXmhRut5bPRZsOj7JY=
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr16511190iom.71.1639086266134;
 Thu, 09 Dec 2021 13:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-6-pcc@google.com>
 <CACT4Y+Ycgo_uOWrfr33VygtDLXvwPqDwee7OseMOaK6jTZSBjQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Ycgo_uOWrfr33VygtDLXvwPqDwee7OseMOaK6jTZSBjQ@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 9 Dec 2021 13:44:13 -0800
Message-ID: <CAMn1gO4+z_z=W47FQ9js_Ej=aeYiydfjFw+rPN2wJ6k6+FkANA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: add support for uaccess logging
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 1:49 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
> >
> > arm64 does not use CONFIG_GENERIC_ENTRY, so add the support for
> > uaccess logging directly to the architecture.
> >
> > Link: https://linux-review.googlesource.com/id/I88de539fb9c4a9d27fa8cccbe201a6e4382faf89
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> >  arch/arm64/Kconfig                   | 1 +
> >  arch/arm64/include/asm/thread_info.h | 7 ++++++-
> >  arch/arm64/kernel/ptrace.c           | 7 +++++++
> >  arch/arm64/kernel/signal.c           | 5 +++++
> >  arch/arm64/kernel/syscall.c          | 1 +
> >  5 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index c4207cf9bb17..6023946abe4a 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -161,6 +161,7 @@ config ARM64
> >         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> >         select HAVE_ARCH_TRACEHOOK
> >         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> > +       select HAVE_ARCH_UACCESS_BUFFER
> >         select HAVE_ARCH_VMAP_STACK
> >         select HAVE_ARM_SMCCC
> >         select HAVE_ASM_MODVERSIONS
> > diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> > index e1317b7c4525..0461b36251ea 100644
> > --- a/arch/arm64/include/asm/thread_info.h
> > +++ b/arch/arm64/include/asm/thread_info.h
> > @@ -82,6 +82,8 @@ int arch_dup_task_struct(struct task_struct *dst,
> >  #define TIF_SVE_VL_INHERIT     24      /* Inherit SVE vl_onexec across exec */
> >  #define TIF_SSBD               25      /* Wants SSB mitigation */
> >  #define TIF_TAGGED_ADDR                26      /* Allow tagged user addresses */
> > +#define TIF_UACCESS_BUFFER_ENTRY 27     /* thread has non-zero uaccess_desc_addr_addr */
> > +#define TIF_UACCESS_BUFFER_EXIT  28     /* thread has non-zero kcur */
> >
> >  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
> >  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
> > @@ -98,6 +100,8 @@ int arch_dup_task_struct(struct task_struct *dst,
> >  #define _TIF_SVE               (1 << TIF_SVE)
> >  #define _TIF_MTE_ASYNC_FAULT   (1 << TIF_MTE_ASYNC_FAULT)
> >  #define _TIF_NOTIFY_SIGNAL     (1 << TIF_NOTIFY_SIGNAL)
> > +#define _TIF_UACCESS_BUFFER_ENTRY      (1 << TIF_UACCESS_BUFFER_ENTRY)
> > +#define _TIF_UACCESS_BUFFER_EXIT       (1 << TIF_UACCESS_BUFFER_EXIT)
> >
> >  #define _TIF_WORK_MASK         (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> >                                  _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> > @@ -106,7 +110,8 @@ int arch_dup_task_struct(struct task_struct *dst,
> >
> >  #define _TIF_SYSCALL_WORK      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> >                                  _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> > -                                _TIF_SYSCALL_EMU)
> > +                                _TIF_SYSCALL_EMU | _TIF_UACCESS_BUFFER_ENTRY | \
> > +                                _TIF_UACCESS_BUFFER_EXIT)
> >
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> >  #define INIT_SCS                                                       \
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index 88a9034fb9b5..283372eccaeb 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/regset.h>
> >  #include <linux/tracehook.h>
> >  #include <linux/elf.h>
> > +#include <linux/uaccess-buffer.h>
> >
> >  #include <asm/compat.h>
> >  #include <asm/cpufeature.h>
> > @@ -1854,6 +1855,9 @@ int syscall_trace_enter(struct pt_regs *regs)
> >         if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >                 trace_sys_enter(regs, regs->syscallno);
> >
> > +       if (flags & _TIF_UACCESS_BUFFER_ENTRY)
> > +               uaccess_buffer_syscall_entry();
> > +
> >         audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> >                             regs->regs[2], regs->regs[3]);
> >
> > @@ -1866,6 +1870,9 @@ void syscall_trace_exit(struct pt_regs *regs)
> >
> >         audit_syscall_exit(regs);
> >
> > +       if (flags & _TIF_UACCESS_BUFFER_EXIT)
> > +               uaccess_buffer_syscall_exit();
> > +
> >         if (flags & _TIF_SYSCALL_TRACEPOINT)
> >                 trace_sys_exit(regs, syscall_get_return_value(current, regs));
> >
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index 8f6372b44b65..5bbd98e5c257 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/tracehook.h>
> >  #include <linux/ratelimit.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/uaccess-buffer.h>
> >
> >  #include <asm/daifflags.h>
> >  #include <asm/debug-monitors.h>
> > @@ -919,6 +920,8 @@ static void do_signal(struct pt_regs *regs)
> >
> >  void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
> >  {
> > +       bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
> > +
> >         do {
> >                 if (thread_flags & _TIF_NEED_RESCHED) {
> >                         /* Unmask Debug and SError for the next task */
> > @@ -950,6 +953,8 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
> >                 local_daif_mask();
> >                 thread_flags = READ_ONCE(current_thread_info()->flags);
> >         } while (thread_flags & _TIF_WORK_MASK);
> > +
> > +       uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
> >  }
> >
> >  unsigned long __ro_after_init signal_minsigstksz;
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 50a0f1a38e84..d59022b594f2 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/randomize_kstack.h>
> >  #include <linux/syscalls.h>
> > +#include <linux/uaccess-buffer.h>
>
> This looks strange... Does some other header miss this include?

This was left in unintentionally. I'll remove it in v4.

Peter
