Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCE47811D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhLQAJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhLQAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:09:50 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA30C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:09:50 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id k14so356367ils.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8WAn1lX0bzAtlg/MoAmHZkG/V5cFyo8Lv13REke/Yk=;
        b=UwkLpmTusvedNd9I4/vClSayltPBRv8C7GDXJVHEPGQmzkiH4OE2ljP6WXQj91QJKG
         VX88Ajm0E+0Pk4k4mIA87B5gFa1kBrLUHsrEP9UDAq6hOgh/+XkZk5jvvGyu2ydAiK/K
         pIA0UgNnSHC1QYocmi31un617LEz6lkeC1NL/2tfr1l7S/u3qZEKLSlWpyui5nnv/0T8
         UfISKgqrU3y0IATbyyv/U9qG1+/HTa8CwTecbGfboc7o5jtL6NH6HTacS0OTqUw5D6Bu
         NZ/Xcov0pzgtfd3EvtB7NXIQ1vWrt8PBNvH4aZdgikkHcUBJOkc4w+bHEFTOww046yLK
         CPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8WAn1lX0bzAtlg/MoAmHZkG/V5cFyo8Lv13REke/Yk=;
        b=bFrAuRdcjT7telrMBi2iMNZcgEbac/sLruLXdFdnAzgftndD9vb6umSffZe9u8DLhy
         YSbwOsgTnpAy5/duQtKeIOR4E36BuhXHPmLdea+dP9/sILprIXPLG4V14Cc0SfsuGaDy
         RGQgnYDRmE+84Z/FaFLn3M++YzBySgw6j1V9N4WRCdJQKga5FTN7nkTLpiBe3SAH5kGa
         bS9TlkIDre/nIh7bMOxPiAjVrwsAVCPUuVi177rfCG9m+UDGQrBhK4DVBv2/F30xnoEv
         YGPjb66H/yCPfUPJtXw5CoNYxLoo246MoROg+bOe4Nfp6XbV+zPfvhz85HhQx4tiyi0R
         OOKA==
X-Gm-Message-State: AOAM533MwmIzpviP8mliGTmzlVIT6+pZp/Y/mW+iUwM8/IufY/7jR4tQ
        G21d3SdJTgaUZSNjVWkxVrFqApE/SFweNd0qhisErw==
X-Google-Smtp-Source: ABdhPJzmUHIscK3U19eJwClbM94CtweNr/dnXJHh9Vn1sAhjj/j6CvNK6t82JRhL1yJGN0xsNVBQOb+ND0GQLsBR99s=
X-Received: by 2002:a05:6e02:216b:: with SMTP id s11mr267011ilv.228.1639699789077;
 Thu, 16 Dec 2021 16:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com> <20211209221545.2333249-5-pcc@google.com>
 <87a6h7webt.ffs@tglx> <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
 <87a6h0lmxm.ffs@tglx>
In-Reply-To: <87a6h0lmxm.ffs@tglx>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 16 Dec 2021 16:09:37 -0800
Message-ID: <CAMn1gO7iaaXEgAt3kQVRSN3ueY7MPt0yww40ADAmUZLOb0ZwZg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 5:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter,
>
> On Wed, Dec 15 2021 at 17:25, Peter Collingbourne wrote:
> > On Sat, Dec 11, 2021 at 3:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> This restores the signal blocked mask _after_ exit_to_user_mode_loop()
> >> has completed, recalculates pending signals and goes out to user space
> >> with eventually pending signals.
> >>
> >> How is this supposed to be even remotely correct?
> >
> > Please see this paragraph from the documentation:
> >
> > When entering the kernel with a non-zero uaccess descriptor
> > address for a reason other than a syscall (for example, when
> > IPI'd due to an incoming asynchronous signal), any signals other
> > than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
> > ``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
> > initialized with ``sigfillset(set)``. This is to prevent incoming
> > signals from interfering with uaccess logging.
> >
> > I believe that we will also go out to userspace with pending signals
> > when one of the signals that came in was a masked (via sigprocmask)
> > asynchronous signal, so this is an expected state.
>
> Believe is not part of a technical analysis, believe belongs into the
> realm of religion.
>
> It's a fundamental difference whether the program masks signals itself
> or the kernel decides to do that just because.
>
> Pending signals, which are not masked by the process, have to be
> delivered _before_ returning to user space.
>
>     That's the expected behaviour. Period.
>
> Instrumentation which changes the semantics of the observed code is
> broken by definition.

The idea is that the uaccess descriptor address would be set to a
non-zero value inside the syscall wrapper, before performing the
syscall. Since the kernel will set the uaccess descriptor address to
zero before returning from a syscall, at no point should the caller of
the syscall wrapper be executing with a non-zero uaccess descriptor
address. At worst, a signal will be delivered to a task executing a
syscall wrapper a few instructions later than it would otherwise, but
that's not really important because the determination of the exact
delivery point of an asynchronous signal is fundamentally racy anyway.

Basically, it's as if the syscall wrapper did this:

// During task startup:
uint64_t addr;
prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR, &addr, 0, 0, 0);

// Wrapper for syscall "x"
int x(...) {
  sigset_t set, old_set;
  struct uaccess_descriptor desc = { ... };

  addr = &desc;
  // The following two statements implicitly occur atomically together
with setting addr:
  sigfillset(set);
  sigprocmask(SIG_SETMASK, set, old_set);

  syscall(__NR_x ...,);
  // The following two statements implicitly occur atomically together
with the syscall:
  sigprocmask(SIG_SETMASK, old_set, NULL);
  addr = 0;

  // Now the uaccesses for syscall "x" are logged to "desc".
}

Aside from the guarantees of atomicity, this really seems no different
from the kernel providing another API for setting the signal mask.

> >> So what is this pre/post exit loop code about? Handle something which
> >> cannot happen in the first place?
> >
> > The pre/post_exit_loop() functions are checking UACCESS_BUFFER_ENTRY,
> > which is set when prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR) has been
> > used to set the uaccess descriptor address address to a non-zero
> > value. It is a different flag from UACCESS_BUFFER_EXIT. It is
> > certainly possible for the ENTRY flag to be set in your 2) above,
> > since that flag is not normally modified while inside the kernel.
>
> Let me try again. The logger is only active when:
>
>     1) PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR has set an address, which
>        sets UACCESS_BUFFER_ENTRY
>
>     2) The task enters the kernel via syscall and the syscall entry
>        observes UACCESS_BUFFER_ENTRY and sets UACCESS_BUFFER_EXIT
>
> because the log functions only log when UACCESS_BUFFER_EXIT is set.
>
> UACCESS_BUFFER_EXIT is cleared in the syscall exit path _before_ the
> exit to usermode loop is reached, which means signal delivery is _NOT_
> logged at all.

Right. It is not the intent to log uaccesses associated with signal
delivery. Only uaccesses that occur while handling the syscall itself
are logged.

> A non-syscall entry from user space - interrupt, exception, NMI - will
> _NOT_ set UACCESS_BUFFER_EXIT because it takes a different entry
> path. So when that non-syscall entry returns and delivers a signal then
> there is no logging.

Again, that's fine, there's no intent to log that.

> When the task has entered the kernel via a syscall and the kernel gets
> interrupted and that interruption raises a signal, then there is no
> signal delivery. The interrupt returns to kernel mode, which obviously
> does not go through exit_to_user_mode(). The raised signal is delivered
> when the task returns from the syscall to user mode, but that won't be
> logged because UACCESS_BUFFER_EXIT is already cleared before the exit to
> user mode loop is reached.
>
> See?

Perhaps there is a misunderstanding of the purpose of the signal
blocking with non-zero uaccess descriptor address. It isn't there
because we want to log anything about these signals. It's there
because we don't want a signal handler to be invoked between when we
arrange for the kernel to log the next syscall and when we issue the
syscall that we want to log, because that could lead to the signal
handler's syscalls being logged instead of the syscall that we intend
to log.

Consider the syscall wrapper for syscall "x" above, and imagine that
we didn't have the sigprocmask statements, and imagine that a signal
came in after storing &desc to addr but before the call to syscall.
Also imagine that the handler for that signal is unaware of uaccess
logging, so it just issues syscalls directly without touching addr.
Now the first syscall performed by the signal handler will be logged,
instead of the intended syscall "x", because the kernel will read the
uaccess descriptor intended for logging syscall "x" from addr when
entering the kernel for the signal handler's first syscall.

The kernel setting addr to 0 during the syscall is also necessary in
order for the kernel to continue processing signals normally once the
logged syscall has returned. Effectively any incoming signals are
queued until we have finished processing the logged syscall. Because
the kernel has set addr to 0, it refrains from blocking signals when
returning to userspace from the logged syscall, and therefore any
pending signals are delivered. Any syscalls that occur in any signal
handlers invoked via this signal delivery will not interfere with the
previously collected log for syscall "x", precisely because addr was
set to 0 by the kernel. If we left it up to userspace to set addr back
to 0, we would have the same problem as if we didn't have the
sigprocmask statements, but now the critical section extends until the
userspace program sets addr to 0. Furthermore, a userspace program
setting addr to 0 would not automatically cause the pending signals to
be delivered (because simply storing a value to memory from userspace
will not necessarily trigger a kernel entry), and signals could
therefore be left blocked for longer than expected (at least until the
next kernel entry).

> >> then we have a very differrent understanding of what documentation
> >> should provide.
> >
> > This was intended as interface documentation, so it doesn't go into
> > too many details. It could certainly be improved though by referencing
> > the user documentation, as I mentioned above.
>
> Explanations which are required to make the code understandable have to
> be in the code/kernel-doc comments and not in some disjunct place. This
> disjunct documentation is guaranteed to be out of date within no time.

Got it. From our discussion it's clear that the justification for the
design of the uaccess logging interface (especially the signal
handling parts) needs to be documented in the code in order to avoid
confusion.

Peter
