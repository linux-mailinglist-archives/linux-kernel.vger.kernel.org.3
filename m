Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026E448A210
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbiAJVn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbiAJVn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:43:58 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B97C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:43:57 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id h11so4256803uar.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9K72PIixJiHAjmHk2Q3TTm9gH9LPILcdrAMPhERhe0=;
        b=k4QZAIVdYqtJyioEF1k0wDYSnDpRfKKY3gpdIacAGPGpL88+ra81fFgDPfnl3ycrvq
         jicEo+kRdF12UEvlfTLkqA8MoslKjBDcowdq14MV6JPGGnBDNRXaGJTqKiYZwz7o/VWa
         55EfkZBc+Y3+J4wLv4+RfpEIpghUfF15PQqsTX0LlHz83I9XHwjsCHqUiMNSo89jKAmb
         0lhu1vsq5ROD7gsXHYAotnYgPi+Lqclh9hdYvb1baZ/XmQ0jd4sDvstutVcmwRG9n+ZJ
         abdRSxc6Zr4zVbL3ok5lDDdOZtcNI9Y/D7Q8GtcKv+UCCEUbWt22brVQgj4JUea1m+dH
         yaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9K72PIixJiHAjmHk2Q3TTm9gH9LPILcdrAMPhERhe0=;
        b=RkB7NgjMwq8IzSe45ewiLNtjPBPM9SjRctdzhvNwGETD/VCLMxn2Ipa4dD2bgMnDRA
         Ds/4jgBEVIzxwB1dzuyAQCYrUADW84TZ04DFSrcqPGwjDlGHsgVk38uJA1Rcx0ebeWJb
         ekSwChKrsG4aClx6LTwDS+jfNUoaTw1pVlyOwDGC6HOx+PDxNVqwILrQDnVY0Wd/RqjV
         WALAxVZ0OelmuzAR5681OeBeNACK1HqxWOnPVO7lnQ04UwfRqoEgM/ZBPVnRRBULO5/A
         k3znCVOUfHozix3Gf2DeUQAPqGuLAXYRGx3+P/ZipGynlN9omnMswNwFU7HWOX8qPrwT
         13Dg==
X-Gm-Message-State: AOAM532I0Pc16Ie97JY7GOVNUR9KCuA8bAFINo3y46+e4tlaPQ3FtTKq
        4ixEDMFkOqO5jx0nz7IBW+hDBlgY0V3QWdkBMSc/jg==
X-Google-Smtp-Source: ABdhPJy2UKXoq8vIjq8ziYZlRLyX+C00KWClWYIkqHJ+ejWAz+tJnnSxVWItlp3Mu16+zpjqjQaC5axAicbNuqEqZoo=
X-Received: by 2002:ab0:525:: with SMTP id 34mr800076uax.136.1641851036581;
 Mon, 10 Jan 2022 13:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com> <20211209221545.2333249-5-pcc@google.com>
 <87a6h7webt.ffs@tglx> <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
 <87a6h0lmxm.ffs@tglx> <CAMn1gO7iaaXEgAt3kQVRSN3ueY7MPt0yww40ADAmUZLOb0ZwZg@mail.gmail.com>
 <875yrncbud.ffs@tglx>
In-Reply-To: <875yrncbud.ffs@tglx>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 10 Jan 2022 13:43:45 -0800
Message-ID: <CAMn1gO7QmQZq-kXeqkCREMJnRsWzYLZphbG_B59aOhb-+O2wZQ@mail.gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter,
>
> On Thu, Dec 16 2021 at 16:09, Peter Collingbourne wrote:
> > userspace program sets addr to 0. Furthermore, a userspace program
> > setting addr to 0 would not automatically cause the pending signals to
> > be delivered (because simply storing a value to memory from userspace
> > will not necessarily trigger a kernel entry), and signals could
> > therefore be left blocked for longer than expected (at least until the
> > next kernel entry).
>
> Groan, so what you are trying to prevent is:
>
>    *ptr = addr;
>
> --> interrupt
>        signal raised
>
>     signal delivery
>
>     signal handler
>       syscall()   <- Logs this syscall
>       sigreturn;
>
>    syscall() <- Is not logged
>
> I must have missed that detail in these novel sized comments all over
> the place.
>
> Yes, I can see how that pre/post muck solves this, but TBH while it is
> admittedly a smart hack it's also a horrible hack.
>
> There are a two aspects which I really dislike:
>
>   - It's yet another ad hoc 'solution' to scratch 'my particular itch'
>
>   - It's adding a horrorshow in the syscall hotpath. We have already
>     enough gunk there. No need to add more.
>
> The problem you are trying to solve is to instrument user accesses of
> the kernel, which is special purpose tracing, right?
>
> May I ask why this is not solvable via tracepoints?
>
>   DECLARE_EVENT_CLASS(uaccess_class,....);
>   DECLARE_EVENT(uaccess_class, uaccess_read,...);
>   DECLARE_EVENT(uaccess_class, uaccess_write,...);
>
>     trace_uaccess_read(from, n);
>
>     trace_uaccess_write(to, n);
>
> Tracepoints have filters, tooling, libraries etc. Zero code except for
> the tracepoints themself. They are disabled by default with a static
> key, which means very close to 0 overhead.
>
> Aside of that such tracepoints can be used for other purposes as well
> and are therefore not bound to 'my particular itch'.
>
> There are obviously some questions to solve versus filtering, but even
> with a stupid tid based filter, it's easy enough to filter out the stuff
> you're interested in. E.g. to filter out the signal scenario above all
> you need is to enable two more tracepoints:
>
>    signal:signal_deliver
>    syscalls:sys_enter_rt_sigreturn
>
> and when analyzing the event stream you can just skip the noise between
> signal:signal_deliver and syscalls:sys_enter_rt_sigreturn trace entries.

I'm afraid that it won't always work. This is because the control flow
can leave a signal handler without going through sigreturn (e.g. when
throwing an exception through the signal handler in C++, or via
longjmp).

But aside from that, there seem to be more fundamental problems with
using tracepoints for this. Let me start by saying that the uaccess
monitoring needs to be synchronous. This is because we need to read
the sanitizer metadata (e.g. memory tags for HWASan) for the memory
accessed by the syscall at the time that the syscall takes place,
before the syscall wrapper function returns. If we read it later, the
memory accessed by the syscall may have been deallocated or
reallocated, so we may end up producing a false positive
use-after-free (if deallocated) or buffer-overflow (if reallocated)
report.

As far as I can tell, there are four main ways that a userspace
program can access tracepoint events:

1) /sys/kernel/debug/tracing/trace_pipe
2) perf_event_open()
3) BPF
4) SIGTRAP on perf events

Let me go over each of them in turn. I don't think any of them will
work, but let me know if you think I made a mistake.

1) The event monitoring via trace_pipe appears to be a mechanism that
is global to the system, so it isn't suitable for an environment where
multiple processes may have sanitizers enabled.

2) This seems to be closest to being feasible, but it looks like there
are a few issues. From reading the perf_event_open man page, the way I
imagined it could work is that we sample the events uaccess_read,
uaccess_write, signal_deliver and sys_enter_rt_sigreturn to a ring
buffer. Then in the syscall wrapper we read the buffer and filter out
the events as you proposed. We do, however, need to be careful to
avoid memory corruption with this approach -- suppose that a signal
comes in while the syscall wrapper is part way through reading the
ring buffer. The syscalls performed by the signal handler may cause
the kernel to overwrite the part of the ring buffer that the syscall
wrapper is currently reading. I think something like this may work to
avoid the overwriting:

// thread local variables:
perf_event_mmap_page *page; // initialized at thread startup
bool in_syscall = false;

long syscall(...) {
  if (in_syscall) {
    // just do the syscall without logging to avoid reentrancy issues
    raw_syscall(...);
  }
  in_syscall = true;
  old_data_head = page->data_head;
  page->data_tail = old_data_head;
  raw_syscall(...);
  new_data_head = page->data_head;
  // read events between old_data_head and new_data_head
  in_syscall = false;
}

With this scheme we end up dropping events from signal handlers in
rare cases. This may be acceptable because the whole scheme is
best-effort anyway. However, if we abnormally return from the syscall
wrapper (exception or longjmp from signal handler), we will be stuck
in the state where logging is disabled, which seems more problematic.

For this to work we will need access to the arguments to the
uaccess_read and uaccess_write events. I couldn't find anything
suitable in the man page, but it does offer this tantalizing snippet:

              PERF_SAMPLE_RAW
                     Records additional data, if applicable.  Usually
returned by tracepoint events.

Maybe the arguments can be accessed via this record? Reading through
the kernel code it looks like *something* is copied in response to
this flag being set, but it is not very clear what. A comment in the
include/uapi/linux/perf_event.h header seems to indicate, however,
that even if the arguments are accessible this way, that isn't part of
the ABI:

         *      #
         *      # The RAW record below is opaque data wrt the ABI
         *      #
         *      # That is, the ABI doesn't make any promises wrt to
         *      # the stability of its content, it may vary depending
         *      # on event, hardware, kernel version and phase of
         *      # the moon.
         *      #
         *      # In other words, PERF_SAMPLE_RAW contents are not an ABI.
         *      #
         *
         *      { u32                   size;
         *        char                  data[size];}&& PERF_SAMPLE_RAW

This would make PERF_SAMPLE_RAW unsuitable for use in sanitizers
because they are generally expected not to break with new kernel
versions.

Another issue is that we need to be able to read the id file from
tracefs in order to issue the perf_event_open() syscall, but there
isn't necessarily a guarantee that tracefs will always be available
given that we will want to use this from almost every process on the
system including init and sandboxed processes. It also looks like the
whole "events" tree of tracefs is restricted to root on at least some
Android devices. There may be other privileges issues that I haven't
run into yet.

3) Installing BPF programs requires additional privileges. As
explained below, this makes it unsuitable for use with sanitizers.

4) I explained why I don't think it will work in the cover letter of
my most recent patch series:

- Tracing would need to be synchronous in order to produce useful
  stack traces. For example this could be achieved using the new SIGTRAP
  on perf events mechanism. However, this would require logging each
  access to the stack (in the form of a sigcontext) and this is more
  likely to overflow the stack due to being much larger than a uaccess
  buffer entry as well as being unbounded, in contrast to the bounded
  buffer size passed to prctl(). An approach based on signal handlers is
  also likely to fall foul of the asynchronous signal issues mentioned
  previously, together with needing sigreturn to be handled specially
  (because it copies a sigcontext from userspace) otherwise we could
  never return from the signal handler. Furthermore, arguments to the
  trace events are not available to SIGTRAP. (This on its own wouldn't
  be insurmountable though -- we could add the arguments as fields
  to siginfo.)

> There are other fancies like BPF which can be used for filtering and
> filling a map with entries.
>
> The only downside is that system configuration restricts access and
> requires certain priviledges. But is that a real problem for the purpose
> at hand, sanitizers and validation tools?
>
> I don't think it is, but you surely can provide more information here.

I'm afraid that it is a problem. We frequently deploy sanitizers in
production-like environments, which means that processes may not only
be running as non-root but may also be sandboxed. For example, a
typical HWASan deployment on an Android device will have HWASan
enabled in almost every process, including untrusted application
processes and sandboxed processes used for parsing untrusted data (and
which are particularly security sensitive).

Furthermore, we plan to use uaccess logging with the ARM Memory
Tagging Extension, which is intended to be deployed to end-user
devices. While opening holes in the sandbox for HWASan may be possible
in some cases (though inadvisable because sanitizers are meant to be
transparent to the program as much as possible, and we don't control
every sandbox used by every Android app), we shouldn't open holes in
the sandbox on end-user devices even if we were able to get every app
with a sandbox to do so as this would increase the risk to end users
(whereas the entire goal of deploying this is to *reduce* the risk).

Peter
