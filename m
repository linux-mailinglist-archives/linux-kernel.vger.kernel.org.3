Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97C46F692
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLIWR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhLIWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:17:57 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D8C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:14:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id x10so8369312ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l66WH6Emw7qflgcgTMneIiQdKI6jbeh15CxWfhJjHY=;
        b=F0iwFnlT1NceQ6dupL2LzlgnZtOwSRmWRGzj5EouOfvlVoPEynafC8KoQ2fCksr8eq
         RDz8id9Cdb9o4EaUAXqIrDUqnSMMSTL/VRgXANGwq/98c2vZAMFsM2i1tx20rz4JvE/F
         wEsHXL9cAPfjSFOJUXYCF09q6BKaXnhsHQc4V7ejO8n5k8SHLvz2IYUOHF4GBuqwTi04
         3yVUQKb2xS5qNIH/reLKewPlD0cKT8Sb/+2Yf8emkidBhZsE/gAcf3MJnmtLSvST2Ys3
         J3H3rOJby7wb9Y9nJRTXgGveN8SRW/4WNq/+tfsE+2OjfyecEOLTq4hWGVFlbMHxcFRu
         a5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l66WH6Emw7qflgcgTMneIiQdKI6jbeh15CxWfhJjHY=;
        b=LuaxnqhMWUfUUv1ayk3RVvRd1GPs74h7/tbAw5YovvcLb63+ejIypUXIQOdeHgZe2k
         EtVvG3jYGP7sTARVj4h0GjGZvhSr4FmjG9oEBM69nwROkOUA8dyjxY7WAoBuSYpxvsae
         9qXmZbeA/YoDTWdJI8Jl/mhEsQteVlOjTVMWD/+HkU9GUTyyj9wX9eZXZRRoDYV1QkLp
         plmyAeieyGi3Qxhz9fC7YywhTVZvOc0g3zwk7cEk9/lQCW+CBMZUukVoqeRKiD/uzhcn
         O+BrZO9kUlPAJFSsc9hAh6HxLCOMmcYxxf6BA8RPg7tRvdqebq8cofGGURLhSHDl8wX7
         2ovg==
X-Gm-Message-State: AOAM531z7OpXNp6kvdL22xdTA8mhzfXewrQvw9La+nyD2Q9agxz3mu/0
        CdXT2vOQQ4rJ+1rSZFtHTF1L4R8ERQvwgdIWKJaTLQ==
X-Google-Smtp-Source: ABdhPJwijfpsvtI+5YmUK3B++TIL4gmGFiBBsxLsp+kgWA2bnrxjnnCaSbcd2ctudVUC3HQH3qgrmyFJB8ezbZ/KOKY=
X-Received: by 2002:a05:6638:300a:: with SMTP id r10mr12601602jak.91.1639088061347;
 Thu, 09 Dec 2021 14:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-3-pcc@google.com>
 <YbDhUHoE67Uh6hj1@elver.google.com>
In-Reply-To: <YbDhUHoE67Uh6hj1@elver.google.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 9 Dec 2021 14:14:10 -0800
Message-ID: <CAMn1gO5W1kydUdmFFFChdWBsz8r_V1fSJ2N9ckDhS4w9qxkKCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] uaccess-buffer: add core code
To:     Marco Elver <elver@google.com>
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
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 8:46 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, Dec 07, 2021 at 08:48PM -0800, Peter Collingbourne wrote:
> > Add the core code to support uaccess logging. Subsequent patches will
> > hook this up to the arch-specific kernel entry and exit code for
> > certain architectures.
> >
> > Link: https://linux-review.googlesource.com/id/I6581765646501a5631b281d670903945ebadc57d
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > ---
> > v3:
> > - performance optimizations for entry/exit code
> > - don't use kcur == NULL to mean overflow
> > - fix potential double free in clone()
> > - don't allocate a new kernel-side uaccess buffer for each syscall
> > - fix uaccess buffer leak on exit
> > - fix some sparse warnings
> >
> > v2:
> > - New interface that avoids multiple syscalls per real syscall and
> >   is arch-generic
> > - Avoid logging uaccesses done by BPF programs
> > - Add documentation
> > - Split up into multiple patches
> > - Various code moves, renames etc as requested by Marco
> >
> >  fs/exec.c                            |   3 +
> >  include/linux/instrumented-uaccess.h |   6 +-
> >  include/linux/sched.h                |   5 ++
> >  include/linux/uaccess-buffer-info.h  |  46 ++++++++++
> >  include/linux/uaccess-buffer.h       | 112 +++++++++++++++++++++++
> >  include/uapi/linux/prctl.h           |   3 +
> >  include/uapi/linux/uaccess-buffer.h  |  27 ++++++
> >  kernel/Makefile                      |   1 +
> >  kernel/bpf/helpers.c                 |   7 +-
> >  kernel/fork.c                        |   4 +
> >  kernel/signal.c                      |   4 +-
> >  kernel/sys.c                         |   6 ++
> >  kernel/uaccess-buffer.c              | 129 +++++++++++++++++++++++++++
> >  13 files changed, 350 insertions(+), 3 deletions(-)
> >  create mode 100644 include/linux/uaccess-buffer-info.h
> >  create mode 100644 include/linux/uaccess-buffer.h
> >  create mode 100644 include/uapi/linux/uaccess-buffer.h
> >  create mode 100644 kernel/uaccess-buffer.c
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 537d92c41105..c9975e790f30 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -65,6 +65,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/io_uring.h>
> >  #include <linux/syscall_user_dispatch.h>
> > +#include <linux/uaccess-buffer.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/mmu_context.h>
> > @@ -1313,6 +1314,8 @@ int begin_new_exec(struct linux_binprm * bprm)
> >       me->personality &= ~bprm->per_clear;
> >
> >       clear_syscall_work_syscall_user_dispatch(me);
> > +     uaccess_buffer_set_descriptor_addr_addr(0);
> > +     uaccess_buffer_free(current);
> >
> >       /*
> >        * We have to apply CLOEXEC before we change whether the process is
> > diff --git a/include/linux/instrumented-uaccess.h b/include/linux/instrumented-uaccess.h
> > index ece549088e50..b967f4436d15 100644
> > --- a/include/linux/instrumented-uaccess.h
> > +++ b/include/linux/instrumented-uaccess.h
> > @@ -2,7 +2,8 @@
> >
> >  /*
> >   * This header provides generic wrappers for memory access instrumentation for
> > - * uaccess routines that the compiler cannot emit for: KASAN, KCSAN.
> > + * uaccess routines that the compiler cannot emit for: KASAN, KCSAN,
> > + * uaccess buffers.
> >   */
> >  #ifndef _LINUX_INSTRUMENTED_UACCESS_H
> >  #define _LINUX_INSTRUMENTED_UACCESS_H
> > @@ -11,6 +12,7 @@
> >  #include <linux/kasan-checks.h>
> >  #include <linux/kcsan-checks.h>
> >  #include <linux/types.h>
> > +#include <linux/uaccess-buffer.h>
> >
> >  /**
> >   * instrument_copy_to_user - instrument reads of copy_to_user
> > @@ -27,6 +29,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
> >  {
> >       kasan_check_read(from, n);
> >       kcsan_check_read(from, n);
> > +     uaccess_buffer_log_write(to, n);
> >  }
> >
> >  /**
> > @@ -44,6 +47,7 @@ instrument_copy_from_user(const void *to, const void __user *from, unsigned long
> >  {
> >       kasan_check_write(to, n);
> >       kcsan_check_write(to, n);
> > +     uaccess_buffer_log_read(from, n);
> >  }
> >
> >  #endif /* _LINUX_INSTRUMENTED_UACCESS_H */
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 78c351e35fec..7c5278d7b57d 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -34,6 +34,7 @@
> >  #include <linux/rseq.h>
> >  #include <linux/seqlock.h>
> >  #include <linux/kcsan.h>
> > +#include <linux/uaccess-buffer-info.h>
> >  #include <asm/kmap_size.h>
> >
> >  /* task_struct member predeclarations (sorted alphabetically): */
> > @@ -1484,6 +1485,10 @@ struct task_struct {
> >       struct callback_head            l1d_flush_kill;
> >  #endif
> >
> > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> > +     struct uaccess_buffer_info      uaccess_buffer;
> > +#endif
> > +
> >       /*
> >        * New fields for task_struct should be added above here, so that
> >        * they are included in the randomized portion of task_struct.
> > diff --git a/include/linux/uaccess-buffer-info.h b/include/linux/uaccess-buffer-info.h
> > new file mode 100644
> > index 000000000000..15e2d8f7c074
> > --- /dev/null
> > +++ b/include/linux/uaccess-buffer-info.h
> > @@ -0,0 +1,46 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_UACCESS_BUFFER_INFO_H
> > +#define _LINUX_UACCESS_BUFFER_INFO_H
> > +
> > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
> > +
> > +struct uaccess_buffer_info {
> > +     /*
> > +      * The pointer to pointer to struct uaccess_descriptor. This is the
> > +      * value controlled by prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR).
> > +      */
> > +     struct uaccess_descriptor __user *__user *desc_ptr_ptr;
> > +
> > +     /*
> > +      * The pointer to struct uaccess_descriptor read at syscall entry time.
> > +      */
> > +     struct uaccess_descriptor __user *desc_ptr;
> > +
> > +     /*
> > +      * A pointer to the kernel's temporary copy of the uaccess log for the
> > +      * current syscall. We log to a kernel buffer in order to avoid leaking
> > +      * timing information to userspace.
> > +      */
> > +     struct uaccess_buffer_entry *kbegin;
> > +
> > +     /*
> > +      * The position of the next uaccess buffer entry for the current
> > +      * syscall, or NULL if we are not logging the current syscall.
> > +      */
> > +     struct uaccess_buffer_entry *kcur;
> > +
> > +     /*
> > +      * A pointer to the end of the kernel's uaccess log.
> > +      */
> > +     struct uaccess_buffer_entry *kend;
> > +
> > +     /*
> > +      * The pointer to the userspace uaccess log, as read from the
> > +      * struct uaccess_descriptor.
> > +      */
> > +     struct uaccess_buffer_entry __user *ubegin;
> > +};
> > +
> > +#endif
> > +
> > +#endif  /* _LINUX_UACCESS_BUFFER_INFO_H */
> > diff --git a/include/linux/uaccess-buffer.h b/include/linux/uaccess-buffer.h
> > new file mode 100644
> > index 000000000000..f2f46db274f3
> > --- /dev/null
> > +++ b/include/linux/uaccess-buffer.h
> > @@ -0,0 +1,112 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_UACCESS_BUFFER_H
> > +#define _LINUX_UACCESS_BUFFER_H
> > +
> > +#include <linux/sched.h>
> > +#include <uapi/linux/uaccess-buffer.h>
> > +
> > +#include <asm-generic/errno-base.h>
> > +
> > +#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
>
> Kernel-doc comments for each of the below would be useful (if __ prefixed
> functions are implementation details, they can be left as-is).

Done.

> > +
> > +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> > +{
> > +     return test_task_syscall_work(tsk, UACCESS_BUFFER_ENTRY);
> > +}
> > +
> > +void __uaccess_buffer_syscall_entry(void);
> > +static inline void uaccess_buffer_syscall_entry(void)
> > +{
> > +     __uaccess_buffer_syscall_entry();
> > +}
> > +
> > +void __uaccess_buffer_syscall_exit(void);
> > +static inline void uaccess_buffer_syscall_exit(void)
> > +{
> > +     __uaccess_buffer_syscall_exit();
> > +}
> > +
> > +bool __uaccess_buffer_pre_exit_loop(void);
> > +static inline bool uaccess_buffer_pre_exit_loop(void)
> > +{
> > +     if (!test_syscall_work(UACCESS_BUFFER_ENTRY))
> > +             return false;
> > +     return __uaccess_buffer_pre_exit_loop();
> > +}
> > +
> > +void __uaccess_buffer_post_exit_loop(void);
> > +static inline void uaccess_buffer_post_exit_loop(bool pending)
> > +{
> > +     if (pending)
> > +             __uaccess_buffer_post_exit_loop();
> > +}
> > +
> > +static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> > +{
> > +     current->uaccess_buffer.desc_ptr_ptr =
> > +             (struct uaccess_descriptor __user * __user *)addr;
> > +     if (addr)
> > +             set_syscall_work(UACCESS_BUFFER_ENTRY);
> > +     else
> > +             clear_syscall_work(UACCESS_BUFFER_ENTRY);
> > +     return 0;
> > +}
> > +
> > +size_t copy_from_user_nolog(void *to, const void __user *from, size_t len);
>
> copy_from_user() has unsigned long for @len and also return type. I'd
> make them match.

Done.

> > +
> > +void uaccess_buffer_free(struct task_struct *tsk);
> > +
> > +void __uaccess_buffer_log_read(const void __user *from, unsigned long n);
> > +static inline void uaccess_buffer_log_read(const void __user *from, unsigned long n)
> > +{
> > +     if (unlikely(test_syscall_work(UACCESS_BUFFER_EXIT)))
> > +             __uaccess_buffer_log_read(from, n);
> > +}
> > +
> > +void __uaccess_buffer_log_write(void __user *to, unsigned long n);
> > +static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
> > +{
> > +     if (unlikely(test_syscall_work(UACCESS_BUFFER_EXIT)))
> > +             __uaccess_buffer_log_write(to, n);
> > +}
> > +
> > +#else
> > +
> > +static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
> > +{
> > +     return false;
> > +}
> > +static inline void uaccess_buffer_syscall_entry(void)
> > +{
> > +}
> > +static inline void uaccess_buffer_syscall_exit(void)
> > +{
> > +}
> > +static inline bool uaccess_buffer_pre_exit_loop(void)
> > +{
> > +     return false;
> > +}
> > +static inline void uaccess_buffer_post_exit_loop(bool pending)
> > +{
> > +}
> > +static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
> > +{
> > +     return -EINVAL;
> > +}
> > +static inline void uaccess_buffer_free(struct task_struct *tsk)
> > +{
> > +}
> > +
> > +#define copy_from_user_nolog(to, from, len) copy_from_user(to, from, len)
>
> "#define copy_from_user_nolog copy_from_user" ?

Done.

Peter
