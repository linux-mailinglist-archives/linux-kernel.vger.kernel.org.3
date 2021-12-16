Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B224772A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhLPNFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbhLPNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:05:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:05:44 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639659942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gyXtx8lEPXesBkD1UtIPzCEvJTY7LppYRBflO8e+Gs=;
        b=Eb1r5CsvHxD65dsjmOQ7chQ1HKW1NKG8CaTmVmpoj2o63splbAAgD6Sl4P5uWNO04pUfQP
        Nu3Qtv4Ya2WQfEq4EbutSSqG1XbiDCzArfuVKT3rq3VtOpf3MVUCWYJmZ+yi7GHdH0UMn/
        eSEova/dQlRgZwgJO2RjssE4UvCtFh36B9Jgs1dJYElipzWdX2QNkVjxTqfCl7cekuxhqE
        Am8o4I6ibrLxZsEsAMp5qDIdLrYqCTnN8l4XWQPAxidCxErXrRdj6baXO+qbqmioPQbVkU
        hiHuyqPFWZT0BsKEiYb8TPij0bQPIJkjt3rz0nksffu38J1NROx22C7xWTqYwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639659942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gyXtx8lEPXesBkD1UtIPzCEvJTY7LppYRBflO8e+Gs=;
        b=U2nS3Tiwbg3EWnEExNzwMx5VntF0IaEkxixX3StiV+4OHxezgh+F/RQNf6fawlBf+rDgIt
        5H7nqdEaLXUjFiBA==
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
Subject: Re: [PATCH v4 4/7] uaccess-buffer: add CONFIG_GENERIC_ENTRY support
In-Reply-To: <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
References: <20211209221545.2333249-1-pcc@google.com>
 <20211209221545.2333249-5-pcc@google.com> <87a6h7webt.ffs@tglx>
 <CAMn1gO4Qcp+t+UhUg4X6KCGbx7_Sm+w8t1_zugPMweuKSZrv7w@mail.gmail.com>
Date:   Thu, 16 Dec 2021 14:05:41 +0100
Message-ID: <87a6h0lmxm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On Wed, Dec 15 2021 at 17:25, Peter Collingbourne wrote:
> On Sat, Dec 11, 2021 at 3:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> This restores the signal blocked mask _after_ exit_to_user_mode_loop()
>> has completed, recalculates pending signals and goes out to user space
>> with eventually pending signals.
>>
>> How is this supposed to be even remotely correct?
>
> Please see this paragraph from the documentation:
>
> When entering the kernel with a non-zero uaccess descriptor
> address for a reason other than a syscall (for example, when
> IPI'd due to an incoming asynchronous signal), any signals other
> than ``SIGKILL`` and ``SIGSTOP`` are masked as if by calling
> ``sigprocmask(SIG_SETMASK, set, NULL)`` where ``set`` has been
> initialized with ``sigfillset(set)``. This is to prevent incoming
> signals from interfering with uaccess logging.
>
> I believe that we will also go out to userspace with pending signals
> when one of the signals that came in was a masked (via sigprocmask)
> asynchronous signal, so this is an expected state.

Believe is not part of a technical analysis, believe belongs into the
realm of religion.

It's a fundamental difference whether the program masks signals itself
or the kernel decides to do that just because.

Pending signals, which are not masked by the process, have to be
delivered _before_ returning to user space.

    That's the expected behaviour. Period.

Instrumentation which changes the semantics of the observed code is
broken by definition.

>> So what is this pre/post exit loop code about? Handle something which
>> cannot happen in the first place?
>
> The pre/post_exit_loop() functions are checking UACCESS_BUFFER_ENTRY,
> which is set when prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR) has been
> used to set the uaccess descriptor address address to a non-zero
> value. It is a different flag from UACCESS_BUFFER_EXIT. It is
> certainly possible for the ENTRY flag to be set in your 2) above,
> since that flag is not normally modified while inside the kernel.

Let me try again. The logger is only active when:

    1) PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR has set an address, which
       sets UACCESS_BUFFER_ENTRY

    2) The task enters the kernel via syscall and the syscall entry
       observes UACCESS_BUFFER_ENTRY and sets UACCESS_BUFFER_EXIT

because the log functions only log when UACCESS_BUFFER_EXIT is set.

UACCESS_BUFFER_EXIT is cleared in the syscall exit path _before_ the
exit to usermode loop is reached, which means signal delivery is _NOT_
logged at all.

A non-syscall entry from user space - interrupt, exception, NMI - will
_NOT_ set UACCESS_BUFFER_EXIT because it takes a different entry
path. So when that non-syscall entry returns and delivers a signal then
there is no logging.

When the task has entered the kernel via a syscall and the kernel gets
interrupted and that interruption raises a signal, then there is no
signal delivery. The interrupt returns to kernel mode, which obviously
does not go through exit_to_user_mode(). The raised signal is delivered
when the task returns from the syscall to user mode, but that won't be
logged because UACCESS_BUFFER_EXIT is already cleared before the exit to
user mode loop is reached.

See?

>> then we have a very differrent understanding of what documentation
>> should provide.
>
> This was intended as interface documentation, so it doesn't go into
> too many details. It could certainly be improved though by referencing
> the user documentation, as I mentioned above.

Explanations which are required to make the code understandable have to
be in the code/kernel-doc comments and not in some disjunct place. This
disjunct documentation is guaranteed to be out of date within no time.

Thanks,

        tglx
