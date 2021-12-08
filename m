Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C546D052
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhLHJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLHJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:52:34 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43E6C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:49:02 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso2137688ots.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKfHlshDZdIQe2VyEOgBGrl1HW4TVTaa1Pn/w0NncUA=;
        b=kVJZB1/U2e/QgO//itS+OKd8Wk1qjuHyoekRmOZ0r7e5oymzd6LzYLcfJL1tLcRLNd
         zWhvgp6N+ohH4spmYJjxPYUo1pODZw77PPLMksRQ9lnYTlg3aqNYjF5ElxFkaGonm2He
         MeDiNHWTcJuyUK7o+DS99hjzBLw1fLp5RJw97t5kHY74DjpBL4BBkyxUuQW6kMK5W9eH
         GubK82DPAej4hhCcIb0iaCzaFMMiibjCy/alxo5jIBgkQgWAwT3PD5LNGeZlXvbiLpJ0
         7+ACGgR++X80aC6Sb8TWjdwtX+RnSLQnwP4CcF8pfFsjLDqQPdaR40/6dfIvou2orDEs
         Z5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKfHlshDZdIQe2VyEOgBGrl1HW4TVTaa1Pn/w0NncUA=;
        b=KFkuvzgT2S+5oRWN6hsCYINkaHB/8fx8SvMZV4hQo3Y+mjQANldAKsiSrcjjETT6Y1
         h5suCGq8cJ6pu6LNaT8VG1uOmC9IbzGpR97b8jG8uWg5wwUVSqBRoUCylICZ6QA6Fsaw
         0kxvGrvdVHCX0ixfXukPvBWeyWaTRAGuGFZ27/Cdlxod9QWCNGioURSutTmR5pFtepMH
         axkXk8GDzetAdYebCS7WNOafnIXht+lIsDoVM0xlHtHqtux7gghzhtgIPs4690RwDXga
         etE35seDs2kAa/HQmPfUh6Fqa6FjxqpzfOM1+dord47ejEF3757WCzjrFRplKUshM7O7
         J6KA==
X-Gm-Message-State: AOAM531XyaysLvBw3ZTwqSr2H8ROi2rIyjDVXwCH6Fk11/Lmk7kuUh8X
        NwwzCjB/b0bTYN33mOA9w95dcW4wACQfYpngV7wEYQ==
X-Google-Smtp-Source: ABdhPJxwDGf4rmGYHDeUAHHske+uuWZFUQ3FeVG0fpBWjcn9C95guHBfPx7PREpo4X10RE90YK2yGC9rRYLKtrOT7+g=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr39934308ots.319.1638956941957;
 Wed, 08 Dec 2021 01:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-6-pcc@google.com>
In-Reply-To: <20211208044808.872554-6-pcc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Dec 2021 10:48:50 +0100
Message-ID: <CACT4Y+Ycgo_uOWrfr33VygtDLXvwPqDwee7OseMOaK6jTZSBjQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: add support for uaccess logging
To:     Peter Collingbourne <pcc@google.com>
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

On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
>
> arm64 does not use CONFIG_GENERIC_ENTRY, so add the support for
> uaccess logging directly to the architecture.
>
> Link: https://linux-review.googlesource.com/id/I88de539fb9c4a9d27fa8cccbe201a6e4382faf89
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
>  arch/arm64/Kconfig                   | 1 +
>  arch/arm64/include/asm/thread_info.h | 7 ++++++-
>  arch/arm64/kernel/ptrace.c           | 7 +++++++
>  arch/arm64/kernel/signal.c           | 5 +++++
>  arch/arm64/kernel/syscall.c          | 1 +
>  5 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..6023946abe4a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -161,6 +161,7 @@ config ARM64
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +       select HAVE_ARCH_UACCESS_BUFFER
>         select HAVE_ARCH_VMAP_STACK
>         select HAVE_ARM_SMCCC
>         select HAVE_ASM_MODVERSIONS
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index e1317b7c4525..0461b36251ea 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -82,6 +82,8 @@ int arch_dup_task_struct(struct task_struct *dst,
>  #define TIF_SVE_VL_INHERIT     24      /* Inherit SVE vl_onexec across exec */
>  #define TIF_SSBD               25      /* Wants SSB mitigation */
>  #define TIF_TAGGED_ADDR                26      /* Allow tagged user addresses */
> +#define TIF_UACCESS_BUFFER_ENTRY 27     /* thread has non-zero uaccess_desc_addr_addr */
> +#define TIF_UACCESS_BUFFER_EXIT  28     /* thread has non-zero kcur */
>
>  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
> @@ -98,6 +100,8 @@ int arch_dup_task_struct(struct task_struct *dst,
>  #define _TIF_SVE               (1 << TIF_SVE)
>  #define _TIF_MTE_ASYNC_FAULT   (1 << TIF_MTE_ASYNC_FAULT)
>  #define _TIF_NOTIFY_SIGNAL     (1 << TIF_NOTIFY_SIGNAL)
> +#define _TIF_UACCESS_BUFFER_ENTRY      (1 << TIF_UACCESS_BUFFER_ENTRY)
> +#define _TIF_UACCESS_BUFFER_EXIT       (1 << TIF_UACCESS_BUFFER_EXIT)
>
>  #define _TIF_WORK_MASK         (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>                                  _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> @@ -106,7 +110,8 @@ int arch_dup_task_struct(struct task_struct *dst,
>
>  #define _TIF_SYSCALL_WORK      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>                                  _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> -                                _TIF_SYSCALL_EMU)
> +                                _TIF_SYSCALL_EMU | _TIF_UACCESS_BUFFER_ENTRY | \
> +                                _TIF_UACCESS_BUFFER_EXIT)
>
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  #define INIT_SCS                                                       \
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 88a9034fb9b5..283372eccaeb 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -29,6 +29,7 @@
>  #include <linux/regset.h>
>  #include <linux/tracehook.h>
>  #include <linux/elf.h>
> +#include <linux/uaccess-buffer.h>
>
>  #include <asm/compat.h>
>  #include <asm/cpufeature.h>
> @@ -1854,6 +1855,9 @@ int syscall_trace_enter(struct pt_regs *regs)
>         if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>                 trace_sys_enter(regs, regs->syscallno);
>
> +       if (flags & _TIF_UACCESS_BUFFER_ENTRY)
> +               uaccess_buffer_syscall_entry();
> +
>         audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
>                             regs->regs[2], regs->regs[3]);
>
> @@ -1866,6 +1870,9 @@ void syscall_trace_exit(struct pt_regs *regs)
>
>         audit_syscall_exit(regs);
>
> +       if (flags & _TIF_UACCESS_BUFFER_EXIT)
> +               uaccess_buffer_syscall_exit();
> +
>         if (flags & _TIF_SYSCALL_TRACEPOINT)
>                 trace_sys_exit(regs, syscall_get_return_value(current, regs));
>
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 8f6372b44b65..5bbd98e5c257 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -20,6 +20,7 @@
>  #include <linux/tracehook.h>
>  #include <linux/ratelimit.h>
>  #include <linux/syscalls.h>
> +#include <linux/uaccess-buffer.h>
>
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
> @@ -919,6 +920,8 @@ static void do_signal(struct pt_regs *regs)
>
>  void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>  {
> +       bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
> +
>         do {
>                 if (thread_flags & _TIF_NEED_RESCHED) {
>                         /* Unmask Debug and SError for the next task */
> @@ -950,6 +953,8 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
>                 local_daif_mask();
>                 thread_flags = READ_ONCE(current_thread_info()->flags);
>         } while (thread_flags & _TIF_WORK_MASK);
> +
> +       uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
>  }
>
>  unsigned long __ro_after_init signal_minsigstksz;
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 50a0f1a38e84..d59022b594f2 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -7,6 +7,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
> +#include <linux/uaccess-buffer.h>

This looks strange... Does some other header miss this include?

>
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
