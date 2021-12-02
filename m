Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3C465B67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbhLBAy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344495AbhLBAyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:54:20 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F294C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:50:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id m5so27237623ilh.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mBMYwDZiAdy7QnDYFJT+k3ktGGLYXD9VTxLNV9oaVE=;
        b=Xxgqfb7gN9PWmrbbPjklr/Ci9dYXJL5BIVovzHIi3tJXf3uBtkV7w9Wzx6xuwjtAzW
         GotvuTc4zNpvJufrlsNvywYdbq0lwZ0ap5LXQ2yt92eScT9iOZ4H3XJttlfcHzJ1ymqG
         6YXG1rq85KVc8bfl9Y/+ixYDOKxCuVskwHc+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mBMYwDZiAdy7QnDYFJT+k3ktGGLYXD9VTxLNV9oaVE=;
        b=xaeV1pMdRFWVeeO98xA4L59N+zFJh5cN7HCd9Q3amTtQBud8sJjqr0ehlLIsN7x1KT
         qyZZ7roue9NxCBQ1SsJ3lhmlAt+YRCCTZvk3peqInNlCVX/EeIb1vSWoBqhIAlF0u80M
         1o7KzEvNCMZbh8T6FnkWK0XL+NU9Xem815ZRb7vTWC9Od5I7RoopVQFzNwKyIZPsL1tT
         Xf1WKJtQ79vSAVssm6DGnnVH8bbR0XVggrpyFEH57khVzuAz7yDJPm9jNVi9SyFSttT2
         fTN0QqAwWi6DT0fyOJbQUXDYpIryVwES6/W4fUyWJGKVr4t/3V9R/Or4v9A/QbynhoQ9
         ORLQ==
X-Gm-Message-State: AOAM531TRaxDadm35+B3AvYywaboKOhdeWHuBzDU8d5T7Xu8yWtCl+sk
        aPMN2RlpNVEP5dQoBUOjxHLLeNtGfIv+vg==
X-Google-Smtp-Source: ABdhPJxqvkg1YqC3tPlwAa0twGAS1IF3aJ73m+Wt6DiVvlxqdS8gtGbsF2oX/7Za7FIkMC5tjtkFYQ==
X-Received: by 2002:a05:6e02:17ca:: with SMTP id z10mr12946859ilu.98.1638406257806;
        Wed, 01 Dec 2021 16:50:57 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id o22sm1252751iow.52.2021.12.01.16.50.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 16:50:57 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id x6so33074051iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 16:50:56 -0800 (PST)
X-Received: by 2002:a05:6638:252:: with SMTP id w18mr15945781jaq.54.1638406256289;
 Wed, 01 Dec 2021 16:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <20211201113052.2025-1-hdanton@sina.com>
In-Reply-To: <20211201113052.2025-1-hdanton@sina.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Dec 2021 16:50:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VL_xrQu3Bvb9GFcfSaOpTF_x5dWPhZe60SWC3TinaLqA@mail.gmail.com>
Message-ID: <CAD=FV=VL_xrQu3Bvb9GFcfSaOpTF_x5dWPhZe60SWC3TinaLqA@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 1, 2021 at 3:31 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 15 Nov 2021 17:02:45 -0800 Douglas Anderson wrote:
> > While testing RT_GROUP_SCHED, I found that my system would go bonkers
> > if my test RT tasks ever got throttled (even if my test RT tasks were
> > set to only get a tiny slice of CPU time). Specifically I found that
> > whenever my test RT tasks were throttled that all other RT tasks in
> > the system were being starved (!!). Several important RT tasks in the
> > kernel were suddenly getting almost no timeslices and my system became
> > unusable.
> >
> > After some experimentation, I determined that this behavior only
> > happened when I gave my test RT tasks a high priority. If I gave my
> > test RT tasks a low priority then they were throttled as expected and
> > nothing was starved.
> >
> > I managed to come up with a test case that hopefully anyone can run to
> > demonstrate the problem. The test case uses shell commands and python
> > but certainly you could reproduce in other ways:
> >
> > echo "Allow 20 ms more of RT at system and top cgroup"
> > old_rt=$(cat /proc/sys/kernel/sched_rt_runtime_us)
> > echo $((old_rt + 20000)) > /proc/sys/kernel/sched_rt_runtime_us
> > old_rt=$(cat /sys/fs/cgroup/cpu/cpu.rt_runtime_us)
> > echo $((old_rt + 20000)) > /sys/fs/cgroup/cpu/cpu.rt_runtime_us
> >
> > echo "Give 10 ms each to spinny and printy groups"
> > mkdir /sys/fs/cgroup/cpu/spinny
> > echo 10000 > /sys/fs/cgroup/cpu/spinny/cpu.rt_runtime_us
> > mkdir /sys/fs/cgroup/cpu/printy
> > echo 10000 > /sys/fs/cgroup/cpu/printy/cpu.rt_runtime_us
> >
> > echo "Fork off a printy thing to be a nice RT citizen"
> > echo "Prints once per second. Priority only 1."
> > python -c "import time;
> > last_time = time.time()
> > while True:
> >   time.sleep(1)
> >   now_time = time.time()
> >   print('Time fies %f' % (now_time - last_time))
> >   last_time = now_time" &
> > pid=$!
> > echo "Give python a few seconds to get started"
> > sleep 3
> > echo $pid >> /sys/fs/cgroup/cpu/printy/tasks
> > chrt -p -f 1 $pid
> >
> > echo "Sleep to observe that everything is peachy"
> > sleep 3
> >
> > echo "Fork off a bunch of evil spinny things"
> > echo "Chews CPU time. Priority 99."
> > for i in $(seq 13); do
> >   python -c "while True: pass"&
> >   pid=$!
> >   echo $pid >> /sys/fs/cgroup/cpu/spinny/tasks
> >   chrt -p -f 99 $pid
> > done
> >
> > echo "Huh? Almost no more prints?"
> >
> > I believe that the problem is an "if" test that's been in
> > push_rt_task() forever where we will just reschedule the current task
> > if it's higher priority than the next one. If I just remove that
> > special case then everything works for me. I tried making it
> > conditional on just `!rq->rt.rt_throttled` but for whatever reason
> > that wasn't enough. The `if` test looks like an unlikely special case
> > optimization and it seems like things ought to be fine without it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I know less than zero about the scheduler (so if I told you something,
> > it's better than 50% chance the the opposite is true!). Here I'm
> > asserting that we totally don't need this special case and the system
> > will be fine without it, but I actually don't have any data to back
> > that up. If nothing else, hopefully my test case in the commit message
> > would let someone else reproduce and see what I'm talking about and
> > can come up with a better fix.
>
> Can you try to tune the knob down to somewhere like 1ms?
>
> Hillf
>
> /*
>  * period over which we measure -rt task CPU usage in us.
>  * default: 1s
>  */
> unsigned int sysctl_sched_rt_period = 1000000;

I could give it a shot, but that's a pretty big behavior change and
the Documentation (sched-rt-group.rst) warns me away from such a
thing. The default of 1 second seems crazy conservative, but tweaking
it all the way down to 1 ms seems a bit aggressive. It also feels like
this would only be working around the problem, not necessarily solving
it at the core?

-Doug
