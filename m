Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743655ABAD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiFYRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiFYRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:01:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00E1582B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:01:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ay16so10732639ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zs6mVdLWta+BbG4DcGuj6Z7cHElVuJa5tXJ/0ojnqI=;
        b=MMbGvUr8JbF8zGULiMCG0NN+n39KsHqVeu1e1xyMJ51gWEf8pH3qJksL6oKwcuqjnZ
         z1wsiGDRdvMOFE0gQ2Fv3k8wYcsU0FpW8SpLkOITiCyjF42i0JWH2hCz6s0jQURzZfcD
         +e+pzUcLCnPMdTR3uYcr1IZgur97M7SQHmw8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zs6mVdLWta+BbG4DcGuj6Z7cHElVuJa5tXJ/0ojnqI=;
        b=ki86l2DdP28JhhMzbv4qQn0cRxO1bgXHXSnHXhV92BWGAeJddyx8fwqQSlMBb+77Ks
         A6y86mHFfgLWVcWt/aGLpbvsPJ94y4R1xJFg0Us2xxtHc5Q8n3r3MrUCVby5n+Lg2qjp
         pfLrXVXtz6IH/VHwU0e+5Hksxgx3HbQDI2sOvh56QM9fAFQZBcbiL+QNASXB8ocB1Taz
         IEoB4eVazoWdPk7sfMyVMNo1jzjj8QcAmXYSspW1ZjEEAjZXx2TokjE1vinT42SHON8Z
         R0sWzclGSTh4yuQPC2KJa/wIqGYOxLNxK87l8u2GMDbYztfMjA2gpV84UzvPT/5PoFjo
         38rQ==
X-Gm-Message-State: AJIora8mfgR95uT8lb1ZCwMkFjbkwv8iOjA1G6rGX1o2oIj7i3wLM1zQ
        nxeJirgeB11Tu513HrxFoc6p0LIlXOtwsADR
X-Google-Smtp-Source: AGRyM1tIgZ85fMKYBgyVDr52MTTA9ixH6b4PyoUbV5sb44eMEtG0kcr+9KFd4quuvC5xtyynCRzN/Q==
X-Received: by 2002:a17:906:ce:b0:718:bff8:58c3 with SMTP id 14-20020a17090600ce00b00718bff858c3mr4553661eji.512.1656176514484;
        Sat, 25 Jun 2022 10:01:54 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id hz11-20020a1709072ceb00b00722fc014e8csm2786384ejc.104.2022.06.25.10.01.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 10:01:52 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so4943414wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 10:01:51 -0700 (PDT)
X-Received: by 2002:a05:600c:354c:b0:39c:7e86:6ff5 with SMTP id
 i12-20020a05600c354c00b0039c7e866ff5mr9826295wmq.145.1656176511175; Sat, 25
 Jun 2022 10:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
In-Reply-To: <YraWWl+Go17uPOgR@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 10:01:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
Message-ID: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     Tejun Heo <tj@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:00 PM Tejun Heo <tj@kernel.org> wrote:
>
> So, Petr debugged a NULL deref in workqueue code to a spurious wakeup
> on a newly created kthread.

What? No. That patch can't be right for several reasons.

What we call "spurious wakeups" exist, but they are about wakeups that
happen from being on a _previous_ wait-queue, and having already been
removed from it.

They aren't "really" spurious, they are just asynchronous enough (and
thus unexpected) that you basically should never have a "sleep on
wait-queue" without then looping and re-testing the condition.

There is no _truly_ spurious wakeup. You were always woken up for a
reason, it's just that there are more reasons than the entirely
obvious ones.

For example, the reason that quoted patch cannot be right is that this
code pattern:

  while (wait_for_completion_interruptible(&worker->ready_to_start))
    ;

is not valid kernel code. EVER. There is absolutely no way that can be correct.

Either that code can take a signal, or it cannot. If it can take a
signal, it had better react to said signal. If it cannot, it must not
use an interruptble sleep - since now that loop turned into a
kernel-side busy-loop.

So NAK on this kind of crazy "I don't know what happened, so I'll just
add *more* bugs to the code" voodoo programming.

And no, we don't "fix" that by then adding a timeout.

Stop this "add random code" thing.

If you cannot be woken up before X happens, then you should:

 - don't go to sleep before X happens

 - don't add yourself to any wait-queues before X happens

 - don't expose your process to others before X happens

The solution is *not* to add some completion with random "wait for
this before waking".

I think the problem here is much more fundamental: you expect a new
thread to not wake up until you've told it to.

We do have that infrastructure in the kernel: when  you create a new
thread, you can do various setup, and the thread won't actually run
until you do "wake_up_new_task()" on it.

However, that's not how kernel_thread() (or kernel_clone()) works.
Those will call wake_up_new_task(p) for you, and as such a new kernel
thread will immediately start running.

So I think the expectations here are entirely wrong.  I think
create_worker() is fundamentally buggy, in how it does that

        /* start the newly created worker */
        ..
        wake_up_process(worker->task);

because that wake_up_process() is already much too late. The process
got woken up already, because it was created by create_kthread() ->
kernel_thread() -> kernel_clone, which does that wake_up_new_task()
and it starts running.

If you want to do thread setup *bnefore* the kernel is running, it
needs to be done before that wake_up_new_task().

That's very possible. Look at what create_io_thread() does, for
example: it never calls wake_up_new_process() at all, and leaves that
to the caller, which has done the extra setup.

Or the kernel_clone_args could have a "init" function that gets called
before doing the wake_up_new_task() is done. Or a number of other
solutions.

But no, we're not randomly adding some new completion because people
were confused and thought they were waking things up when it was
already awake from before.

                Linus
