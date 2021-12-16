Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D77476765
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhLPBZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLPBZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:25:15 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE79C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 17:25:15 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r2so20793604ilb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 17:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBziqp22SXZeNuKqc2ODGxkf3VIBP0YiqlbfZw5V+yI=;
        b=kJ+W8RJNiYemAmY9QZEaPfbWkaAXz5SaC3peHy6HPvW4/MyZbScCKebEWwxsSmZTH0
         1t2PLIRsgBDC5iOe0xj67VmAjGl999hvjhimePvgB3LywmapDxI8Q83A8/Webq4SuejU
         lUmoO0ORNmwfNwW6dF+xom6/fctMRTc9UiG+EHrqrUhH69AGuKCH5oT5a5YCJEfloRDL
         yre3l7n8fccApn9KWWKGa8gKKDclIwqIeHw99nYXFfAgshqu8wz36H823QU2r6HMVTgk
         M8fepRtD92xHW9QilQY3mqjRKnNO2YFJGRe5/Qk587KKF55xsd/iFJmBERTt+z5dD7pN
         Is2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBziqp22SXZeNuKqc2ODGxkf3VIBP0YiqlbfZw5V+yI=;
        b=PRkoufLBLSY/YdBntvuurPiBYMpUmWCwBJoW6V29O0eKFjh4YOZEvdK1GY0TRdvu6W
         tzrme7CjC2duKNItE8Tkr6axiibuod6LI5V0G1IH0i35bTUbf4gfeRPIhRyXBuKc2UaZ
         iXW0xRRpopB6UZQ9N7d8APCY/SMH4i0luX87rAkuBEmcnT87rbnIFrvtbCuuX1ch9jAC
         I1CQG4NIJeCOTfnoO/xJUxSrq8uK9G/WuioKeQ4FxypbqA/Kr8dn1ADmKCaug2V+En0X
         l0hwajl9vZsOqXNNTOYsgrNiSpGmcVCNdghd4g2PCtoCgqPRkUgQ3XfcDEw9dANeswYA
         NWfw==
X-Gm-Message-State: AOAM533YehlC/kmb0pw10ZOQmOniX0ShnNXBrlqiPaHGUIP4yMMJcxPs
        T4coZJyFGowCCkKCYs88zqesG5zzp9w+4AtkZczkFg==
X-Google-Smtp-Source: ABdhPJwa9KwZMxeLNjlRfVYTBbW8HKVpuscwV8U+dMKsPMic7QyAwkinpMI3N5xcvbDyEhOcet9iACV81m4R95KRun4=
X-Received: by 2002:a05:6e02:1586:: with SMTP id m6mr8420112ilu.146.1639617914884;
 Wed, 15 Dec 2021 17:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com> <20211209221545.2333249-5-pcc@google.com>
 <87a6h7webt.ffs@tglx>
In-Reply-To: <87a6h7webt.ffs@tglx>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 15 Dec 2021 17:25:03 -0800
Message-ID: <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
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

On Sat, Dec 11, 2021 at 3:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter,
>
> On Thu, Dec 09 2021 at 14:15, Peter Collingbourne wrote:
> > @@ -197,14 +201,19 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> >  static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >  {
> >       unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +     bool uaccess_buffer_pending;
> >
> >       lockdep_assert_irqs_disabled();
> >
> >       /* Flush pending rcuog wakeup before the last need_resched() check */
> >       tick_nohz_user_enter_prepare();
> >
> > -     if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> > +     if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK)) {
> > +             bool uaccess_buffer_pending = uaccess_buffer_pre_exit_loop();
> > +
> >               ti_work = exit_to_user_mode_loop(regs, ti_work);
> > +             uaccess_buffer_post_exit_loop(uaccess_buffer_pending);
>
> What? Let me look at the these two functions, which are so full of useful
> comments:
>
> > +bool __uaccess_buffer_pre_exit_loop(void)
> > +{
> > +     struct uaccess_buffer_info *buf = &current->uaccess_buffer;
> > +     struct uaccess_descriptor __user *desc_ptr;
> > +     sigset_t tmp_mask;
> > +
> > +     if (get_user(desc_ptr, buf->desc_ptr_ptr) || !desc_ptr)
> > +             return false;
> > +
> > +     current->real_blocked = current->blocked;
> > +     sigfillset(&tmp_mask);
> > +     set_current_blocked(&tmp_mask);
>
> This prevents signal delivery in exit_to_user_mode_loop(), right?

It prevents asynchronous signal delivery, same as with
sigprocmask(SIG_SETMASK, set, NULL) with a full set.

> > +     return true;
> > +}
> > +
> > +void __uaccess_buffer_post_exit_loop(void)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&current->sighand->siglock, flags);
> > +     current->blocked = current->real_blocked;
> > +     recalc_sigpending();
>
> This restores the signal blocked mask _after_ exit_to_user_mode_loop()
> has completed, recalculates pending signals and goes out to user space
> with eventually pending signals.
>
> How is this supposed to be even remotely correct?

Please see this paragraph from the documentation:

When entering the kernel with a non-zero uaccess descriptor
address for a reason other than a syscall (for example, when
IPI'd due to an incoming asynchronous signal), any signals other
than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
initialized with ``sigfillset(set)``. This is to prevent incoming
signals from interfering with uaccess logging.

I believe that we will also go out to userspace with pending signals
when one of the signals that came in was a masked (via sigprocmask)
asynchronous signal, so this is an expected state.

> But that aside, let me look at the whole picture as I understand it from
> reverse engineering it. Yes, reverse engineering, because there are
> neither comments in the code nor any useful information in the
> changelogs of 2/7 and 4/7. Also the cover letter and the "documentation"
> are not explaining any of this and just blurb about sanitizers and how
> wonderful this all is.

The whole business with pre/post_exit_loop() is implementing the
paragraph mentioned above. I imagine that the kerneldoc comments could
be improved by referencing that paragraph.

> > @@ -70,6 +71,9 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
> >                       return ret;
> >       }
> >
> > +     if (work & SYSCALL_WORK_UACCESS_BUFFER_ENTRY)
> > +             uaccess_buffer_syscall_entry();
>
> This conditionally sets SYSCALL_WORK_UACCESS_BUFFER_EXIT.

Right.

> > @@ -247,6 +256,9 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
> >
> >       audit_syscall_exit(regs);
> >
> > +     if (work & SYSCALL_WORK_UACCESS_BUFFER_EXIT)
> > +             uaccess_buffer_syscall_exit();
>
> When returning from the syscall and SYSCALL_WORK_UACCESS_BUFFER_EXIT is
> set, then uaccess_buffer_syscall_exit() clears
> SYSCALL_WORK_UACCESS_BUFFER_EXIT, right?

Right.

> This is called _before_ exit_to_user_mode_prepare(). So why is this
> __uaccess_buffer_pre/post_exit_loop() required at all?
>
> It's not required at all. Why?
>
> Simply because there are only two ways how exit_to_user_mode_prepare()
> can be reached:
>
>   1) When returning from a syscall
>
>   2) When returning from an interrupt which hit user mode execution
>
> #1 SYSCALL_WORK_UACCESS_BUFFER_EXIT is cleared _before_
>    exit_to_user_mode_prepare() is reached as documented above.
>
> #2 SYSCALL_WORK_UACCESS_BUFFER_EXIT cannot be set because the entry
>    to the kernel does not go through syscall_trace_enter().
>
> So what is this pre/post exit loop code about? Handle something which
> cannot happen in the first place?

The pre/post_exit_loop() functions are checking UACCESS_BUFFER_ENTRY,
which is set when prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR) has been
used to set the uaccess descriptor address address to a non-zero
value. It is a different flag from UACCESS_BUFFER_EXIT. It is
certainly possible for the ENTRY flag to be set in your 2) above,
since that flag is not normally modified while inside the kernel.

> If at all this would warrant a:
>
>         if (WARN_ON_ONCE(test_syscall_work(UACCESS_BUFFER_ENTRY)))
>                 do_something_sensible();
>
> instead of adding undocumented voodoo w/o providing any rationale. Well,
> I can see why that was not provided because there is no rationale to
> begin with.
>
> Seriously, I'm all for better instrumentation and analysis, but if the
> code provided for that is incomprehensible, uncommented and
> undocumented, then the result is worse than what we have now.

Okay, as well as improving the kerneldoc I'll add some code comments
to make it clearer what's going on.

> If you think that this qualifies as documentation:
>
> > +/*
> > + * uaccess_buffer_syscall_entry - hook to be run before syscall entry
> > + */
>
> > +/*
> > + * uaccess_buffer_syscall_exit - hook to be run after syscall exit
> > + */
>
> > +/*
> > + * uaccess_buffer_pre_exit_loop - hook to be run immediately before the
> > + * pre-kernel-exit loop that handles signals, tracing etc. Returns a bool to
> > + * be passed to uaccess_buffer_post_exit_loop.
> > + */
>
> > +/*
> > + * uaccess_buffer_post_exit_loop - hook to be run immediately after the
> > + * pre-kernel-exit loop that handles signals, tracing etc.
> > + * @pending: the bool returned from uaccess_buffer_pre_exit_loop.
> > + */
>
> then we have a very differrent understanding of what documentation
> should provide.

This was intended as interface documentation, so it doesn't go into
too many details. It could certainly be improved though by referencing
the user documentation, as I mentioned above.

Peter
