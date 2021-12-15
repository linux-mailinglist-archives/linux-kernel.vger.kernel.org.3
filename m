Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1447519F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 05:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbhLOE1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhLOE1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:27:39 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE61C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 20:27:38 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m12so5892516ild.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 20:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4O0/z72l4SmI0v8cTXk5jdO5A5BuzCbC3hEwH7Dhi1g=;
        b=qMn8mpIhUOHgKcxmZMlZkFuDJ0aMr2Y+R8yfGMUKpPui+0kcbfXon1yqlSCK4/xO91
         6mAAG/TgSGKdQ/snETAKek4gKOWbK7c9nS5Mq5JTGiUt59YMJLupo8TpwllPzqnf+1QO
         tLdDD/uDRojhCFdXeDBGSPkGfzlU9YasCAt+f9z+vVGjE9Xo3uGGKMU+sjrH5o0xeUmk
         rIJZgM8Ya+4ZhF4nvKzYHXYbRn+PCt50Rh/DbQgIW++f+dlsnPA5RGLEXPk4V3Y52fLu
         Aof7/188wNj2JNCR6VWKajHvu9VwYfBnsbH7jiHoXvCSYKB4qK2Og8hf/n8j1qqrjKnA
         sFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4O0/z72l4SmI0v8cTXk5jdO5A5BuzCbC3hEwH7Dhi1g=;
        b=Aigqp8hOrh2XURBostll+tAKye2Pj7t9yGEIACcaE6JPGYmxWcLXj+arKyfzEaTs8C
         y4tD16nWq1lhaZYnxzC+3YF7tZME9yPc4c0pvHeD60UUkwyD3KvG+yQ+9HdieyC1msfz
         G08lDsoKvZm3i0czii63MEb3kFS/DUw+FrsX7a2pInAmhPZ97z+sUjrg3Ztq2YNoGLQ1
         M6s0bpxH6HR9+HxYJ25Y8I9PocM5qn0yUyA7H1A84359aZgMqFyqCLTuwAu4hqLvPSFA
         Kjxk9OiC6Qzm4chZF4X1dxhZCmJfw92tshisJ6sxYeedaSHD58ZvrqSW64YyxcWF1Mjw
         bmoQ==
X-Gm-Message-State: AOAM530wnAbGlvHmCQjqWX5o13TJ1rcaFsPJNfsoJqYOY4OfsqZyuOLf
        WFULE+hX8EUOpUtieB/kS7dDayM26Wr1/hkhlw3Kow==
X-Google-Smtp-Source: ABdhPJwv+PAAgZ1hF+IKYs6qksQuNHbKf2c5yG9FXYD1Mv1eHVqwrOQwFTShv1glGmezkQefjdkcHjG6Z2qMSn0vZFA=
X-Received: by 2002:a05:6e02:1586:: with SMTP id m6mr5885191ilu.146.1639542457722;
 Tue, 14 Dec 2021 20:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com> <fce9898e392f42a0830892a1735deb3e@AcuMS.aculab.com>
 <CAMn1gO5mBHR3-Wd2CyxQ8PYt8apTiWNOtFwKY4duwXvGwkZFWA@mail.gmail.com>
 <d160399eb8e6476496e0ae3fc61c0897@AcuMS.aculab.com> <CAMn1gO6bNXz8c4JcG25N91mRALvx1Bex+s-vdj_f6hJ1itwHNQ@mail.gmail.com>
In-Reply-To: <CAMn1gO6bNXz8c4JcG25N91mRALvx1Bex+s-vdj_f6hJ1itwHNQ@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 14 Dec 2021 20:27:26 -0800
Message-ID: <CAMn1gO7fwiFak1Da0Ox9h4KBhoWhTLnF7ZxWF0DTuB+c3FoUYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] kernel: introduce uaccess logging
To:     David Laight <David.Laight@aculab.com>
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
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:47 PM Peter Collingbourne <pcc@google.com> wrote:
>
> On Mon, Dec 13, 2021 at 3:07 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Peter Collingbourne
> > > Sent: 13 December 2021 19:49
> > >
> > > On Sat, Dec 11, 2021 at 9:23 AM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > From: Peter Collingbourne
> > > > > Sent: 09 December 2021 22:16
> > > > >
> > > > > This patch series introduces a kernel feature known as uaccess
> > > > > logging, which allows userspace programs to be made aware of the
> > > > > address and size of uaccesses performed by the kernel during
> > > > > the servicing of a syscall. More details on the motivation
> > > > > for and interface to this feature are available in the file
> > > > > Documentation/admin-guide/uaccess-logging.rst added by the final
> > > > > patch in the series.
> > > >
> > > > How does this work when get_user() and put_user() are used to
> > > > do optimised copies?
> > > >
> > > > While adding checks to copy_to/from_user() is going to have
> > > > a measurable performance impact - even if nothing is done,
> > > > adding them to get/put_user() (and friends) is going to
> > > > make some hot paths really slow.
> > > >
> > > > So maybe you could add it so KASAN test kernels, but you can't
> > > > sensibly enable it on a production kernel.
> > > >
> > > > Now, it might be that you could semi-sensibly log 'data' transfers.
> > > > But have you actually looked at all the transfers that happen
> > > > for something like sendmsg().
> > > > The 'user copy hardening' code already has a significant impact
> > > > on that code (in many places).
> > >
> > > Hi David,
> > >
> > > Yes, I realised after I sent out my patch (and while writing test
> > > cases for it) that it didn't cover get_user()/put_user(). I have a
> > > patch under development that will add this coverage. I used it to run
> > > my invalid syscall and uname benchmarks and the results were basically
> > > the same as without the coverage.
> > >
> > > Are you aware of any benchmarks that cover sendmsg()? I can try to
> > > look at writing my own if not. I was also planning to write a
> > > benchmark that uses getresuid() as this was the simplest syscall that
> > > I could find that does multiple put_user() calls.
> >
> > Also look at sys_poll() I think that uses __put/get_user().
> >
> > I think you'll find some of the socket option code also uses get_user().
> >
> > There is also the compat code for import_iovec().
> > IIRC that is actually faster than the non-compat version at the moment.
> >
> > I did some benchmarking of writev("/dev/null", iov, 10);
> > The cost of reading in the iovec is significant in that case.
> > Maybe I ought to find time to sort out my patches.
> >
> > For sendmsg() using __copy_from_user() to avoid the user-copy
> > hardening checks also makes a measurable difference when sending UDP
> > through raw sockets - which we do a lot of.
> >
> > I think you'd need to instrument user_access_begin() and also be able
> > to merge trace entries (for multiple get_user() calls).
> >
> > You really don't have to look far to find places where copy_to/from_user()
> > is optimised to multiple get/put_user() or __get/put_user() (or are they
> > the 'nofault' variants?)
> > Those are all hot paths - at least for some workloads.
> > So adding anything there isn't likely to be accepted for production kernels.
>
> Okay, but let's see what the benchmarks say first.
>
> I added calls to uaccess_buffer_log_{read,write}() to
> __{get,put}_user() in arch/arm64/include/asm/uaccess.h and wrote a
> variant of my usual test program that does getresuid() in a loop and
> measured an overhead of 5.9% on the small cores and 2.5% on the big
> cores. The overhead appears to come from two sources:
> 1) The calling convention for the call to
> __uaccess_buffer_log_read/write() transforms some leaf functions into
> non-leaf functions, and as a result we end up spilling more registers.
> 2) We need to reload the flags from the task_struct every time to
> determine the feature enabled state.
> I think it should be possible to reduce the cost down to one
> instruction (a conditional branch) per get/put_user() call, at least
> on arm64, by using a different calling convention for the call and
> maintaining the feature enabled state in one of the currently-ignored
> bits 60-63 of a reserved register (x18).
>
> I have the patch below which reduces the overhead with my test program
> to 2.3% small 1.5% big (not fully functional yet because the rest of
> the code never actually flips that bit in x18). For syscalls like
> sendmsg() and poll() I would expect the overall overhead to be lower
> because of other required work done by these syscalls (glancing
> through their implementations this appears to be the case). But I'll
> benchmark it of course. The preserve_most attribute is Clang-only but
> I think it should be possible to use inline asm to get the same effect
> with GCC. We currently only reserve x18 with CONFIG_SHADOW_CALL_STACK
> enabled but I was unable to measure an overhead for getresuid() when
> reserving x18 unconditionally.

I developed benchmarks for sendmsg() and poll() and, as I expected,
the performance overhead of my patch was in the noise, except that I
measured 1.0% overhead for poll(), but only on the little cores. So it
looks like getresuid() still represents the worst case. I'm not sure
it's worth spending time developing additional benchmarks because I
would expect them to show similar results.

By the way, is there any interest in maintaining my syscall latency
benchmarks in tree? They have been invaluable for measuring the
performance impact of my kernel changes. The benchmarks that I
developed are written in arm64 assembly to avoid measurement error due
to overheads introduced by the libc syscall wrappers (i.e. they make
my benchmark results look as bad as possible, by spending as little
time in userspace as possible). I looked around in the tree and found
"perf bench syscall" but that uses the libc wrappers.

Peter
