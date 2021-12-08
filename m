Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5451446CBC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbhLHD4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLHD4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:56:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 19:52:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v138so2836610ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 19:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=umpRlktGkOVFbofs51VGC4CFwcng10yX+JW3c5BV1Hk=;
        b=jpFEjCRdSrDaSzSrH7Rez1woFV5GWAD3paWjHO6dz0Nw8ONt8aBwJ21HPgoZj8b1I5
         4b37uEndtqdqC1TDpFpr9hmwuj9+jnjFdmzkPYSN/qCzsTF4zkrWHnrIDOpokIZghzxg
         I/b1t4RTJ0EBXgPpmjbyN+bCuvI+HMtda/KSpvYtqDPUWqHBv5Bd3iFIkJIJ2AwTFIsx
         rab8S4UHVkGqIswfQt1Lk4JGHVkbgEOMT/6kNdEp1NZANH27FqeU4/cYTDoHC2GDYMcF
         dKbccw9Sjz4J16+Gvv0pD1Fdhz9II5hfG4lIS3Z4ye+im9F/MsFEL+ZpFq32M7dlFgCo
         aXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=umpRlktGkOVFbofs51VGC4CFwcng10yX+JW3c5BV1Hk=;
        b=4ByN4fGZRR0mj1bE5ywYy2drwNgjUFbxzzRzkR56OfLGkFRBK+hOQWEPC+l32LJjF6
         dFqaK944qn7XGeBUEXo+NfPkZUvHMQUOtMvlJfkpWW5nqHL3wcBkQfLO5IC1LsY6gIFp
         TglTxs/XnTDCaLvIrx2mnYhkCkJTXdbtcQR+hvu3A7Clgoazzy35/1MDd3oyItKXP7Ck
         FI8OrVdMk6PKiKNpUOf0tPeY4PUpLGNgunvj+50at9fqLBYUPOvEznWH522sLScv+JDx
         HVxuVO7f3CFQPP1gsRdWG37LdIpkHv8iVLwJ8iOlDGQAM0EneTG++YkZngTUMRvp/uPw
         FCew==
X-Gm-Message-State: AOAM533tzRcQEzXk1Lrrj5YAYA+5Dd7W6LNUlL7P4kCsR+erJSdOIwMC
        sB6u9ABh/WEkNasmNT76lwsIFj67KMR43eZQJ7n4Kg==
X-Google-Smtp-Source: ABdhPJwGeXpaABH4cYONQSqOq//lAxiSsn8Ob1eyEKE/26eA9mlmpgzG4+bBNpj9wYggD9N2D1bttCajytRN5HTMbx4=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr52378267ybi.186.1638935549395;
 Tue, 07 Dec 2021 19:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com> <20211123051658.3195589-3-pcc@google.com>
 <CACT4Y+aoiT+z+3CMBNmO0SwXBXpfDCsHY7pPLf54S8V=c-a8ag@mail.gmail.com> <CAG_fn=VN001yOZ_kN3rOENKYvEioRkc0J0ZZYtLKKshK4X2yfg@mail.gmail.com>
In-Reply-To: <CAG_fn=VN001yOZ_kN3rOENKYvEioRkc0J0ZZYtLKKshK4X2yfg@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 7 Dec 2021 19:52:17 -0800
Message-ID: <CAMn1gO5B5Q3hfN6kugv2wmdFGNhJb75iRX1zmCkw3wnueN1dtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] uaccess-buffer: add core code
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Colin Ian King <colin.king@canonical.com>,
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
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:20 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Nov 23, 2021 at 10:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > .On Tue, 23 Nov 2021 at 06:17, Peter Collingbourne <pcc@google.com> wrote:
> > >
> > > Add the core code to support uaccess logging. Subsequent patches will
> > > hook this up to the arch-specific kernel entry and exit code for
> > > certain architectures.
> >
> > I don't see where we block signals when a user writes to the addr. I
> > expected to see some get_user from the addr somewhere in the signal
> > handling code. What am I missing?

This happens in the uaccess_buffer_{pre,post}_exit_loop() hooks. These
hooks go around the part of the kernel exit code that deals with
(among other things) signal handling.

> >
> > > Link: https://linux-review.googlesource.com/id/I6581765646501a5631b281d670903945ebadc57d
> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > ---
> > > v2:
> > > - New interface that avoids multiple syscalls per real syscall and
> > >   is arch-generic
> > > - Avoid logging uaccesses done by BPF programs
> > > - Add documentation
> > > - Split up into multiple patches
> > > - Various code moves, renames etc as requested by Marco
> > >
> > >  arch/Kconfig                             |   5 +
> > >  fs/exec.c                                |   2 +
> > >  include/linux/instrumented.h             |   5 +-
> > >  include/linux/sched.h                    |   4 +
> > >  include/linux/uaccess-buffer-log-hooks.h |  59 +++++++++++
> > >  include/linux/uaccess-buffer.h           |  79 ++++++++++++++
> > >  include/uapi/linux/prctl.h               |   3 +
> > >  include/uapi/linux/uaccess-buffer.h      |  25 +++++
> > >  kernel/Makefile                          |   1 +
> > >  kernel/bpf/helpers.c                     |   6 +-
> > >  kernel/fork.c                            |   3 +
> > >  kernel/signal.c                          |   4 +-
> > >  kernel/sys.c                             |   6 ++
> > >  kernel/uaccess-buffer.c                  | 125 +++++++++++++++++++++++
> > >  14 files changed, 324 insertions(+), 3 deletions(-)
> > >  create mode 100644 include/linux/uaccess-buffer-log-hooks.h
> > >  create mode 100644 include/linux/uaccess-buffer.h
> > >  create mode 100644 include/uapi/linux/uaccess-buffer.h
> > >  create mode 100644 kernel/uaccess-buffer.c
> > >
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 26b8ed11639d..6030298a7e9a 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1302,6 +1302,11 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
> > >  config DYNAMIC_SIGFRAME
> > >         bool
> > >
> > > +config HAVE_ARCH_UACCESS_BUFFER
> > > +       bool
> > > +       help
> > > +         Select if the architecture's syscall entry/exit code supports uaccess buffers.
> > > +
> > >  source "kernel/gcov/Kconfig"
> > >
> > >  source "scripts/gcc-plugins/Kconfig"
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 537d92c41105..5f30314f3ec6 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -65,6 +65,7 @@
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/io_uring.h>
> > >  #include <linux/syscall_user_dispatch.h>
> > > +#include <linux/uaccess-buffer.h>
> > >
> > >  #include <linux/uaccess.h>
> > >  #include <asm/mmu_context.h>
> > > @@ -1313,6 +1314,7 @@ int begin_new_exec(struct linux_binprm * bprm)
> > >         me->personality &= ~bprm->per_clear;
> > >
> > >         clear_syscall_work_syscall_user_dispatch(me);
> > > +       uaccess_buffer_set_descriptor_addr_addr(0);
> > >
> > >         /*
> > >          * We have to apply CLOEXEC before we change whether the process is
> > > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > > index 42faebbaa202..c96be1695614 100644
> > > --- a/include/linux/instrumented.h
> > > +++ b/include/linux/instrumented.h
> > > @@ -2,7 +2,7 @@
> > >
> > >  /*
> > >   * This header provides generic wrappers for memory access instrumentation that
> > > - * the compiler cannot emit for: KASAN, KCSAN.
> > > + * the compiler cannot emit for: KASAN, KCSAN, uaccess buffers.
> > >   */
> > >  #ifndef _LINUX_INSTRUMENTED_H
> > >  #define _LINUX_INSTRUMENTED_H
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/kasan-checks.h>
> > >  #include <linux/kcsan-checks.h>
> > >  #include <linux/types.h>
> > > +#include <linux/uaccess-buffer-log-hooks.h>
> > >
> > >  /**
> > >   * instrument_read - instrument regular read access
> > > @@ -117,6 +118,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> > >  {
> > >         kasan_check_read(from, n);
> > >         kcsan_check_read(from, n);
> > > +       uaccess_buffer_log_write(to, n);
> > >  }
> > >
> > >  /**
> > > @@ -134,6 +136,7 @@ instrument_copy_from_user(const void *to, const void __user *from, unsigned long
> > >  {
> > >         kasan_check_write(to, n);
> > >         kcsan_check_write(to, n);
> > > +       uaccess_buffer_log_read(from, n);
> > >  }
> > >
> > >  #endif /* _LINUX_INSTRUMENTED_H */
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 78c351e35fec..1f978deaa3f8 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1484,6 +1484,10 @@ struct task_struct {
> > >         struct callback_head            l1d_flush_kill;
> > >  #endif
> > >
> > > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> > > +       struct uaccess_buffer_info      uaccess_buffer;
> > > +#endif
> >
> > Shouldn't this be controlled by an additional config that a user can
> > enable/disable?
> > If I am reading this correctly, the current implementation forces
> > uaccess logging for all arches that support it. Some embed kernels may
> > not want this.

My intent is to get the overhead (for programs that don't use this
feature) low enough that we don't need to make it configurable.

My initial performance measurements showed a large overhead on a
DragonBoard 845c so I spent some time optimizing the entry/exit code
paths. The new code is in the v3 patch series and with that I see
the following, measured with [1] for invalid syscall and a similar
program for uname, which is probably the simplest syscall that does
a copy_*_user() (all measurements in ns/syscall):

                    small core                         big core
                   (Cortex-A55)                      (Cortex-A75)
             before           after             before           after
invalid  242.9 +/- 0.06  244.6 +/- 0.02     147.4 +/- 0.06  148.1 +/- 0.04
uname    601.7 +/- 0.1   607.0 +/- 0.7      283.0 +/- 0.4   285.7 +/-
0.6

So it looks like even in the worst case where the program is doing
nothing but issuing syscalls the overhead is < 1%. I would be surprised
if it was measurable in the real world.

I also measured the overhead on x86 using similar programs (under
virtualization, since I don't currently have a setup to test the
kernel on bare-metal on x86) but there was too much noise for me to
observe a difference.

[1] https://lore.kernel.org/all/CAMn1gO4MwRV8bmFJ_SeY5tsYNPn2ZP56LjAhafygjFaKuu5ouw@mail.gmail.com/

> >
> >
> > >         /*
> > >          * New fields for task_struct should be added above here, so that
> > >          * they are included in the randomized portion of task_struct.
> > > diff --git a/include/linux/uaccess-buffer-log-hooks.h b/include/linux/uaccess-buffer-log-hooks.h
> > > new file mode 100644
> > > index 000000000000..bddc84ddce32
> > > --- /dev/null
> > > +++ b/include/linux/uaccess-buffer-log-hooks.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_UACCESS_BUFFER_LOG_HOOKS_H
> > > +#define _LINUX_UACCESS_BUFFER_LOG_HOOKS_H
> > > +
> > > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> > > +
> > > +struct uaccess_buffer_info {
> > > +       /*
> > > +        * The pointer to pointer to struct uaccess_descriptor. This is the
> > > +        * value controlled by prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR).
> > > +        */
> > > +       struct uaccess_descriptor __user *__user *desc_ptr_ptr;
> > > +
> > > +       /*
> > > +        * The pointer to struct uaccess_descriptor read at syscall entry time.
> > > +        */
> > > +       struct uaccess_descriptor __user *desc_ptr;
> > > +
> > > +       /*
> > > +        * A pointer to the kernel's temporary copy of the uaccess log for the
> > > +        * current syscall. We log to a kernel buffer in order to avoid leaking
> > > +        * timing information to userspace.
> > > +        */
> > > +       struct uaccess_buffer_entry *kbegin;
> > > +
> > > +       /*
> > > +        * The position of the next uaccess buffer entry for the current
> > > +        * syscall.
> > > +        */
> > > +       struct uaccess_buffer_entry *kcur;
> > > +
> > > +       /*
> > > +        * A pointer to the end of the kernel's uaccess log.
> > > +        */
> > > +       struct uaccess_buffer_entry *kend;
> > > +
> > > +       /*
> > > +        * The pointer to the userspace uaccess log, as read from the
> > > +        * struct uaccess_descriptor.
> > > +        */
> > > +       struct uaccess_buffer_entry __user *ubegin;
> > > +};
> > > +
> > > +void uaccess_buffer_log_read(const void __user *from, unsigned long n);
> > > +void uaccess_buffer_log_write(void __user *to, unsigned long n);
> > > +
> > > +#else
> > > +
> > > +static inline void uaccess_buffer_log_read(const void __user *from,
> > > +                                          unsigned long n)
> > > +{
> > > +}
> > > +static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
> > > +{
> > > +}
> > > +
> > > +#endif
> > > +
> > > +#endif  /* _LINUX_UACCESS_BUFFER_LOG_HOOKS_H */
> > > diff --git a/include/linux/uaccess-buffer.h b/include/linux/uaccess-buffer.h
> > > new file mode 100644
> > > index 000000000000..14261368d3a9
> > > --- /dev/null
> > > +++ b/include/linux/uaccess-buffer.h
> > > @@ -0,0 +1,79 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_UACCESS_BUFFER_H
> > > +#define _LINUX_UACCESS_BUFFER_H
> > > +
> > > +#include <linux/sched.h>
> > > +#include <uapi/linux/uaccess-buffer.h>
> > > +
> > > +#include <asm-generic/errno-base.h>
> > > +
> > > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> > > +
> > > +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> > > +{
> > > +       return tsk->uaccess_buffer.desc_ptr_ptr;
> > > +}
> > > +
> > > +void __uaccess_buffer_syscall_entry(void);
> > > +static inline void uaccess_buffer_syscall_entry(void)
> > > +{
> > > +       if (uaccess_buffer_maybe_blocked(current))
> > > +               __uaccess_buffer_syscall_entry();
> > > +}
> > > +
> > > +void __uaccess_buffer_syscall_exit(void);
> > > +static inline void uaccess_buffer_syscall_exit(void)
> > > +{
> > > +       if (uaccess_buffer_maybe_blocked(current))
> > > +               __uaccess_buffer_syscall_exit();
> > > +}
> > > +
> > > +bool __uaccess_buffer_pre_exit_loop(void);
> > > +static inline bool uaccess_buffer_pre_exit_loop(void)
> > > +{
> > > +       if (!uaccess_buffer_maybe_blocked(current))
> > > +               return false;
> > > +       return __uaccess_buffer_pre_exit_loop();
> > > +}
> > > +
> > > +void __uaccess_buffer_post_exit_loop(void);
> > > +static inline void uaccess_buffer_post_exit_loop(bool pending)
> > > +{
> > > +       if (pending)
> > > +               __uaccess_buffer_post_exit_loop();
> > > +}
> > > +
> > > +void uaccess_buffer_cancel_log(struct task_struct *tsk);
> > > +int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr);
> > > +
> > > +#else
> > > +
> > > +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> > > +{
> > > +       return false;
> > > +}
> > > +
> > > +static inline void uaccess_buffer_syscall_entry(void)
> > > +{
> > > +}
> > > +static inline void uaccess_buffer_syscall_exit(void)
> > > +{
> > > +}
> > > +static inline bool uaccess_buffer_pre_exit_loop(void)
> > > +{
> > > +       return false;
> > > +}
> > > +static inline void uaccess_buffer_post_exit_loop(bool pending)
> > > +{
> > > +}
> > > +static inline void uaccess_buffer_cancel_log(struct task_struct *tsk)
> > > +{
> > > +}
> > > +
> > > +static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> > > +{
> > > +       return -EINVAL;
> > > +}
> > > +#endif
> > > +
> > > +#endif  /* _LINUX_UACCESS_BUFFER_H */
> > > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > > index bb73e9a0b24f..74b37469c7b3 100644
> > > --- a/include/uapi/linux/prctl.h
> > > +++ b/include/uapi/linux/prctl.h
> > > @@ -272,4 +272,7 @@ struct prctl_mm_map {
> > >  # define PR_SCHED_CORE_SCOPE_THREAD_GROUP      1
> > >  # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP     2
> > >
> > > +/* Configure uaccess logging feature */
> > > +#define PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR    63
> > > +
> > >  #endif /* _LINUX_PRCTL_H */
> > > diff --git a/include/uapi/linux/uaccess-buffer.h b/include/uapi/linux/uaccess-buffer.h
> > > new file mode 100644
> > > index 000000000000..619b17dc25c4
> > > --- /dev/null
> > > +++ b/include/uapi/linux/uaccess-buffer.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _UAPI_LINUX_UACCESS_BUFFER_H
> > > +#define _UAPI_LINUX_UACCESS_BUFFER_H
> > > +
> > > +/* Location of the uaccess log. */
> > > +struct uaccess_descriptor {
> > > +       /* Address of the uaccess_buffer_entry array. */
> > > +       __u64 addr;
> > > +       /* Size of the uaccess_buffer_entry array in number of elements. */
> > > +       __u64 size;
> > > +};
> > > +
> > > +/* Format of the entries in the uaccess log. */
> > > +struct uaccess_buffer_entry {
> > > +       /* Address being accessed. */
> > > +       __u64 addr;
> > > +       /* Number of bytes that were accessed. */
> > > +       __u64 size;
> > > +       /* UACCESS_BUFFER_* flags. */
> > > +       __u64 flags;
> > > +};
> > > +
> > > +#define UACCESS_BUFFER_FLAG_WRITE      1 /* access was a write */
> > > +
> > > +#endif /* _UAPI_LINUX_UACCESS_BUFFER_H */
> > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > index 186c49582f45..d4d9be5146c3 100644
> > > --- a/kernel/Makefile
> > > +++ b/kernel/Makefile
> > > @@ -114,6 +114,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
> > >  obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
> > >  obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
> > >  obj-$(CONFIG_CFI_CLANG) += cfi.o
> > > +obj-$(CONFIG_HAVE_ARCH_UACCESS_BUFFER) += uaccess-buffer.o
> > >
> > >  obj-$(CONFIG_PERF_EVENTS) += events/
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 649f07623df6..167b50177066 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -637,7 +637,11 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
> > >  BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
> > >            const void __user *, user_ptr)
> > >  {
> > > -       int ret = copy_from_user(dst, user_ptr, size);
> > > +       /*
> > > +        * Avoid copy_from_user() here as it may leak information about the BPF
> > > +        * program to userspace via the uaccess buffer.
> > > +        */
> > > +       int ret = raw_copy_from_user(dst, user_ptr, size);
> >
> > Here I am more concerned about KASAN/KMSAN checks.
> > What exactly is the attack vector here? Are these accesses secret?
>
> If there are concerns about leaking information in this particular
> case, any other call to copy_from_user() added in the future will be
> prone to the same issues.
> So if uaccess logging is meant for production use, it should be
> possible to lock the feature down from unwanted users.

This comment was probably poorly worded. This isn't really about
exposing "secret" accesses. It's more that the accesses carried out
by the BPF program are not necessarily in response to the syscall,
nor may they be compliant with the rules that we've set for uaccess
logging. For example they could be using the same trick of reading
PAGE_SIZE bytes that mount() is doing.

If we hit one of these issues in the kernel itself, we may consider
that a bug that we can fix. But we don't necessarily have control
over what BPF programs are doing. We may want to allow BPF programs to
opt into uaccess logging, but I reckon that should be done separately.

I've changed the wording of the comment accordingly.

> > Can't the same info be obtained using userfaultfd/unmapping memory?
> >
> > raw_copy_from_user also skips access_ok, is it ok?

Okay, I've introduced a copy_from_user_nolog() function that disables
uaccess logging and used it here as well as in mount().

> >
> >
> > >         if (unlikely(ret)) {
> > >                 memset(dst, 0, size);
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 3244cc56b697..c7abe7e7c7cd 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -96,6 +96,7 @@
> > >  #include <linux/scs.h>
> > >  #include <linux/io_uring.h>
> > >  #include <linux/bpf.h>
> > > +#include <linux/uaccess-buffer.h>
> > >
> > >  #include <asm/pgalloc.h>
> > >  #include <linux/uaccess.h>
> > > @@ -890,6 +891,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> > >         if (memcg_charge_kernel_stack(tsk))
> > >                 goto free_stack;
> > >
> > > +       uaccess_buffer_cancel_log(tsk);
> >
> > Why do we need this?
> > tsk is a newly allocated task_struct. If I am not mistaken, it's not
> > zero initialized, so are we kfree'ing garbage?
> > But we may need to do something with tasks after arch_dup_task_struct.

Right, the intent was to call this on orig.

Without something like this I think we'll call the syscall exit handler
twice, which would lead to a double free if we're not careful. That
aside, in order to avoid the complexities resulting from e.g. clone3()
with CLONE_VM set, it seems best not to report anything from this
syscall.

I guess I never hit a problem with this in practice because
1) Android uses CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
2) my prototype patch on the userspace side never sets up a uaccess
   descriptor for clone() (because it doesn't go via the usual syscall
   wrappers that I instrumented).

> >
> > >         stack_vm_area = task_stack_vm_area(tsk);
> > >
> > >         err = arch_dup_task_struct(tsk, orig);
> > > diff --git a/kernel/signal.c b/kernel/signal.c
> > > index a629b11bf3e0..69bf21518bd0 100644
> > > --- a/kernel/signal.c
> > > +++ b/kernel/signal.c
> > > @@ -45,6 +45,7 @@
> > >  #include <linux/posix-timers.h>
> > >  #include <linux/cgroup.h>
> > >  #include <linux/audit.h>
> > > +#include <linux/uaccess-buffer.h>
> > >
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/signal.h>
> > > @@ -1031,7 +1032,8 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
> > >         if (sig_fatal(p, sig) &&
> > >             !(signal->flags & SIGNAL_GROUP_EXIT) &&
> > >             !sigismember(&t->real_blocked, sig) &&
> > > -           (sig == SIGKILL || !p->ptrace)) {
> > > +           (sig == SIGKILL ||
> > > +            !(p->ptrace || uaccess_buffer_maybe_blocked(p)))) {
> >
> > Why do we need this change?

This code is, as best I can tell, an optimization to handle the
case where a process is sent an asynchronous signal without a signal
handler. In this case, the process's tasks are killed immediately by
starting a group exit and waking them up. This avoids a round trip
through one of the process's tasks, but it doesn't match the documented
behavior in the case where the uaccess descriptor address is non-zero
-- in this case, we need to behave as if most signals are blocked. I
guess it doesn't really matter in the end because no signal handler
would be invoked anyway, but it doesn't seem like we should change
the blocking behavior just because of this optimization. So if a task
has a uaccess descriptor address address, we just send the signal to
a specific thread and let it handle blocking if necessary.

I guess an alternative solution would be to have the sending thread
do a cross-process read of the uaccess descriptor address, but that
seems like more trouble than it's worth.

> >
> > >                 /*
> > >                  * This signal will be fatal to the whole group.
> > >                  */
> > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > index 8fdac0d90504..c71a9a9c0f68 100644
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -42,6 +42,7 @@
> > >  #include <linux/version.h>
> > >  #include <linux/ctype.h>
> > >  #include <linux/syscall_user_dispatch.h>
> > > +#include <linux/uaccess-buffer.h>
> > >
> > >  #include <linux/compat.h>
> > >  #include <linux/syscalls.h>
> > > @@ -2530,6 +2531,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > >                 error = sched_core_share_pid(arg2, arg3, arg4, arg5);
> > >                 break;
> > >  #endif
> > > +       case PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR:
> > > +               if (arg3 || arg4 || arg5)
> > > +                       return -EINVAL;
> > > +               error = uaccess_buffer_set_descriptor_addr_addr(arg2);
> > > +               break;
> > >         default:
> > >                 error = -EINVAL;
> > >                 break;
> > > diff --git a/kernel/uaccess-buffer.c b/kernel/uaccess-buffer.c
> > > new file mode 100644
> > > index 000000000000..e1c6d6ab9af8
> > > --- /dev/null
> > > +++ b/kernel/uaccess-buffer.c
> > > @@ -0,0 +1,125 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Support for uaccess logging via uaccess buffers.
> > > + *
> > > + * Copyright (C) 2021, Google LLC.
> > > + */
> > > +
> > > +#include <linux/compat.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/prctl.h>
> > > +#include <linux/ptrace.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/signal.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/uaccess-buffer.h>
> > > +
> > > +static void uaccess_buffer_log(unsigned long addr, unsigned long size,
> > > +                             unsigned long flags)
> > > +{
> > > +       struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> > > +       struct uaccess_buffer_entry *entry = buf->kcur;
> > > +
> > > +       if (!entry || unlikely(uaccess_kernel()))
> > > +               return;
> > > +       entry->addr = addr;
> > > +       entry->size = size;
> > > +       entry->flags = flags;
> > > +
> > > +       ++buf->kcur;
> > > +       if (buf->kcur == buf->kend)
> > > +               buf->kcur = 0;
> >
> > = NULL;

Done.

> > > +}
> > > +
> > > +void uaccess_buffer_log_read(const void __user *from, unsigned long n)
> > > +{
> > > +       uaccess_buffer_log((unsigned long)from, n, 0);
> > > +}
> > > +EXPORT_SYMBOL(uaccess_buffer_log_read);
> > > +
> > > +void uaccess_buffer_log_write(void __user *to, unsigned long n)
> > > +{
> > > +       uaccess_buffer_log((unsigned long)to, n, UACCESS_BUFFER_FLAG_WRITE);
> > > +}
> > > +EXPORT_SYMBOL(uaccess_buffer_log_write);
> > > +
> > > +int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> > > +{
> > > +       current->uaccess_buffer.desc_ptr_ptr =
> > > +               (struct uaccess_descriptor __user * __user *)addr;
> > > +       uaccess_buffer_cancel_log(current);
> >
> > Is this necessary? It looks more reasonable and useful to not call
> > cancel. In most cases the user won't setup it twice/change. But if the
> > user anyhow asked to trace the prctl, why not trace it?

No particularly good reason. I previously guarded all the uaccess
buffer hooks using the desc_ptr_ptr field, so we could end up not
following the syscall exit code path if someone set this to 0. This
prctl doesn't do any uaccesses, so I guess it doesn't really matter
in the end. But we can relatively easily arrange for the syscall exit
code to check kcur instead, and since we need to check that anyway,
I guess it makes the code slightly more efficient.

> >
> > > +       return 0;
> > > +}
> > > +
> > > +bool __uaccess_buffer_pre_exit_loop(void)
> > > +{
> > > +       struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> > > +       struct uaccess_descriptor __user *desc_ptr;
> > > +       sigset_t tmp_mask;
> > > +
> > > +       if (get_user(desc_ptr, buf->desc_ptr_ptr) || !desc_ptr)
> > > +               return false;
> > > +
> > > +       current->real_blocked = current->blocked;
> > > +       sigfillset(&tmp_mask);
> > > +       set_current_blocked(&tmp_mask);
> > > +       return true;
> > > +}
> > > +
> > > +void __uaccess_buffer_post_exit_loop(void)
> > > +{
> > > +       spin_lock_irq(&current->sighand->siglock);
> > > +       current->blocked = current->real_blocked;
> > > +       recalc_sigpending();
> > > +       spin_unlock_irq(&current->sighand->siglock);
> > > +}
> > > +
> > ;> +void uaccess_buffer_cancel_log(struct task_struct *tsk)
> > > +{
> > > +       struct uaccess_buffer_info *buf = &tsk->uaccess_buffer;
> > > +
> > > +       if (buf->kcur) {
> >
> > uaccess_buffer_log sets kcur to NULL on overflow and we call this
> > function from a middle of fork, it looks strange that kfree'ing
> > something depends on the previous buffer overflow. Should we check
> > kbegin here?

It's worse than this because we lose our place in the kernel-allocated
buffer when we set kcur to NULL (well, I guess we can recover by
noticing that kbegin != NULL and kcur == NULL, but that adds a bit more
complexity). I'm not sure why I wrote it this way, I think it was just
a remnant of when I had the buffers copied to userspace directly. Now
I leave kcur pointing at the end of the buffer if we overflow.

> > > +               buf->kcur = 0;
> >
> > = NULL
> > I would also set kend to NULL to not leave a dangling pointer.

Yes, and kbegin when we get around to destroying this (now in
uaccess_buffer_free).

> >
> > > +               kfree(buf->kbegin);
> > > +       }
> > > +}
> > > +
> > > +void __uaccess_buffer_syscall_entry(void)
> > > +{
> > > +       struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> > > +       struct uaccess_descriptor desc;
> > > +
> > > +       if (get_user(buf->desc_ptr, buf->desc_ptr_ptr) || !buf->desc_ptr ||
> > > +           put_user(0, buf->desc_ptr_ptr) ||
> > > +           copy_from_user(&desc, buf->desc_ptr, sizeof(desc)))
> > > +               return;
> > > +
> > > +       if (desc.size > 1024)
> > > +               desc.size = 1024;
> > > +
> > > +       buf->kbegin = kmalloc_array(
> > > +               desc.size, sizeof(struct uaccess_buffer_entry), GFP_KERNEL);
> >
> > Is not handling error intentional here?
> > Maybe it's better to check the error just to make the code more
> > explicit (and maybe prevent some future bugs).

Done.

> > Actually an interesting attack vector. If you can make this kmalloc
> > fail, you can prevent sanitizers from detecting any of the bad
> > accesses :)
> >
> > Does it make sense to flag the error somewhere in the desc?... or I am
> > thinking if we should pre-allocate the buffer, if we start tracing a
> > task, we will trace lots of syscalls, so avoiding kmalloc/kfree per
> > syscall can make sense. What do you think?

Makes sense. Now I preserve kbegin and kend between syscalls
(reallocing as necessary) and only free it together with the
task_struct.

> > > +       buf->kcur = buf->kbegin;
> > > +       buf->kend = buf->kbegin + desc.size;
> > > +       buf->ubegin = (struct uaccess_buffer_entry __user *)desc.addr;
> > > +}
> > > +
> > > +void __uaccess_buffer_syscall_exit(void)
> > > +{
> > > +       struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> > > +       u64 num_entries = buf->kcur - buf->kbegin;
> > > +       struct uaccess_descriptor desc;
> > > +
> > > +       if (!buf->kcur)
> >
> > uaccess_buffer_log sets kcur to NULL on overflow. I think we need to
> > check kbegin here.

Fixed by changing the overflow behavior per above.

> >
> >
> > > +               return;
> > > +
> > > +       desc.addr = (u64)(buf->ubegin + num_entries);
> > > +       desc.size = buf->kend - buf->kcur;
> >
> > Is the user expected to use size in any of reasonable scenarios?
> > We cap size at 1024 at entry, so the size can be truncated here.
> >
> > > +       buf->kcur = 0;
> >
> > = NULL

Done.

> >
> > > +       if (copy_to_user(buf->ubegin, buf->kbegin,
> > > +                        num_entries * sizeof(struct uaccess_buffer_entry)) == 0)
> > > +               (void)copy_to_user(buf->desc_ptr, &desc, sizeof(desc));
> > > +
> > > +       kfree(buf->kbegin);
> >
> > What if we enter exit/exit_group with logging enabled, won't we leak the buffer?

Right. Fixed by adding a hook to task_struct destruction.

Peter
