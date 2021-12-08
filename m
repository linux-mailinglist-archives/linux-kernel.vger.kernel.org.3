Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB746D04B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhLHJrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhLHJri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:47:38 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65EC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:44:07 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso2091681otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRFcAoxkwuVsGkhu2Dhw6maDJnr0gAII4Szav5vNN6s=;
        b=HvY+aZ9EtfTw7qvSomY+5sleArHiGqXif3xqBhf5veArOsuqVggBVJg4ysO+BtGSo0
         UkkurL5cJPDgbSf6GGbZ2rXuOc3GwXcQQJbLTTZSRouNo1HKpNekIS8VQ0/kuRb6mPmy
         ppU29Cm7Zie0oNK2loHR0glss0YYvOowBcJ2Kci3x25Gl/0k/qv/+5TkXGvGK6rQ5qCf
         Q++QolwYLIYMxJb5lw+C47jHUlMiDK8gSv8d7YlBF0RU+xUnZ7WeO4CTS9pfk0fmbn6p
         jGF+n1zpCU59bsyJh1NhT3mU0DRWSzNV9tnK0GqDOhOQqYyXdnDa2lNzhcGy036Du3az
         xfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRFcAoxkwuVsGkhu2Dhw6maDJnr0gAII4Szav5vNN6s=;
        b=vOw5OX1U59Ac+UCXEPGG9KQzmOZaApRbTUyd4mgR/ATOjMjFLpyQCyaulRMQm4+X9K
         TZqQbsX4bb/VpN4NE0Kn+/tt1R0+iyUrKM6oiYoflb3hVA8StM5AYa6zHytLTgse208W
         F9/xQiRAZ6rZ3Y8TN7jinpz6qAGr7FxFs2JcvsMGyaEa1COigx/GecWIShchjFComqCO
         VYWQxkPu38bobF93oCMK7srWapfTFQpZ1TtHQ1CHbXDoghdnaKZUOFGL1CsCKZmbCiiK
         g05OuVwJaokzDWFU5eHo82cPQNML7kJwCPQcPPwbLP4P01pNnT7yVbIeL8h2Nmxis1nH
         BhZA==
X-Gm-Message-State: AOAM533+lV2KXke2KvNQcxCxFESixHGksU995iKNKhwjg+dOxIBxoAEs
        jUR+Yw1fORJ3Dl5npZYx3gMtJd696nfbJ4iH73hpbQ==
X-Google-Smtp-Source: ABdhPJxLYdhft5vMQa4Un7FgnTJJ2BiMUnM7+VsfhKrqAIVsXJx8wvuNd5Sqc8d61O/iOjrTDQdhPhA0DTD1GdkSJQ4=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr39913840ots.319.1638956646011;
 Wed, 08 Dec 2021 01:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <20211208044808.872554-5-pcc@google.com>
In-Reply-To: <20211208044808.872554-5-pcc@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Dec 2021 10:43:54 +0100
Message-ID: <CACT4Y+ZAbpB4eqBS7zScC7QwVOdwvQSxHEKEMwxkk1=f=H8HKg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
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
> Add uaccess logging support on architectures that use
> CONFIG_GENERIC_ENTRY (currently only s390 and x86).
>
> Link: https://linux-review.googlesource.com/id/I3c5eb19a7e4a1dbe6095f6971f7826c4b0663f7d
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/Kconfig                 |  6 ++++++
>  include/linux/entry-common.h |  2 ++
>  include/linux/thread_info.h  |  4 ++++
>  kernel/entry/common.c        | 10 ++++++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index d3c4ab249e9c..c4dcab5279ac 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -31,6 +31,7 @@ config HOTPLUG_SMT
>         bool
>
>  config GENERIC_ENTRY
> +       select HAVE_ARCH_UACCESS_BUFFER
>         bool
>
>  config KPROBES
> @@ -1312,6 +1313,11 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
>  config DYNAMIC_SIGFRAME
>         bool
>
> +config HAVE_ARCH_UACCESS_BUFFER
> +       bool
> +       help
> +         Select if the architecture's syscall entry/exit code supports uaccess buffers.
> +
>  source "kernel/gcov/Kconfig"
>
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 2e2b8d6140ed..973fcd1d48a3 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -42,12 +42,14 @@
>                                  SYSCALL_WORK_SYSCALL_EMU |             \
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
>                                  SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
> +                                SYSCALL_WORK_UACCESS_BUFFER_ENTRY |    \
>                                  ARCH_SYSCALL_WORK_ENTER)
>  #define SYSCALL_WORK_EXIT      (SYSCALL_WORK_SYSCALL_TRACEPOINT |      \
>                                  SYSCALL_WORK_SYSCALL_TRACE |           \
>                                  SYSCALL_WORK_SYSCALL_AUDIT |           \
>                                  SYSCALL_WORK_SYSCALL_USER_DISPATCH |   \
>                                  SYSCALL_WORK_SYSCALL_EXIT_TRAP |       \
> +                                SYSCALL_WORK_UACCESS_BUFFER_EXIT |     \
>                                  ARCH_SYSCALL_WORK_EXIT)
>
>  /*
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index ad0c4e041030..b0f8ea86967f 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -46,6 +46,8 @@ enum syscall_work_bit {
>         SYSCALL_WORK_BIT_SYSCALL_AUDIT,
>         SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
>         SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
> +       SYSCALL_WORK_BIT_UACCESS_BUFFER_ENTRY,
> +       SYSCALL_WORK_BIT_UACCESS_BUFFER_EXIT,
>  };
>
>  #define SYSCALL_WORK_SECCOMP           BIT(SYSCALL_WORK_BIT_SECCOMP)
> @@ -55,6 +57,8 @@ enum syscall_work_bit {
>  #define SYSCALL_WORK_SYSCALL_AUDIT     BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
>  #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
>  #define SYSCALL_WORK_SYSCALL_EXIT_TRAP BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
> +#define SYSCALL_WORK_UACCESS_BUFFER_ENTRY      BIT(SYSCALL_WORK_BIT_UACCESS_BUFFER_ENTRY)
> +#define SYSCALL_WORK_UACCESS_BUFFER_EXIT       BIT(SYSCALL_WORK_BIT_UACCESS_BUFFER_EXIT)
>  #endif
>
>  #include <asm/thread_info.h>
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index d5a61d565ad5..57c4bb01a554 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -6,6 +6,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>  #include <linux/tick.h>
> +#include <linux/uaccess-buffer.h>
>
>  #include "common.h"
>
> @@ -70,6 +71,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>                         return ret;
>         }
>
> +       if (work & SYSCALL_WORK_UACCESS_BUFFER_ENTRY)
> +               uaccess_buffer_syscall_entry();
> +
>         /* Either of the above might have changed the syscall number */
>         syscall = syscall_get_nr(current, regs);
>
> @@ -197,14 +201,17 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
>         unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +       bool uaccess_buffer_pending;
>
>         lockdep_assert_irqs_disabled();
>
>         /* Flush pending rcuog wakeup before the last need_resched() check */
>         tick_nohz_user_enter_prepare();
>
> +       uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
>         if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>                 ti_work = exit_to_user_mode_loop(regs, ti_work);
> +       uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
>
>         arch_exit_to_user_mode_prepare(regs, ti_work);
>
> @@ -247,6 +254,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>
>         audit_syscall_exit(regs);
>
> +       if (work & SYSCALL_WORK_UACCESS_BUFFER_EXIT)
> +               uaccess_buffer_syscall_exit();
> +
>         if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
>                 trace_sys_exit(regs, syscall_get_return_value(current, regs));
>
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
