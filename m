Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1E463BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbhK3Qdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhK3Qdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:33:38 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED60C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:30:18 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z18so26852747iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR3RsxVyijnbsxzY0RlOxZ6lexSIMl0xHsJznnIZU9w=;
        b=kg14S4Ke3a8IL1ItjkBUscIDA4qbPKaK/UEhTqHPB2JR4ct2DwzXUPOCA4ljZm+OWm
         iRo+QGfRu9MwQxnzys2mXB+pKMeHvT91pfr4vnfKeIGMhtiB+3IyedrkZpvAC6dQ1BNF
         OiSciKSd4w1srV3Nt1Ya19crUiOyS2hxY4/EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR3RsxVyijnbsxzY0RlOxZ6lexSIMl0xHsJznnIZU9w=;
        b=zKBHdBF5jIzL7T96Tjfv+/Md94Ma30XyeVkSmD15ke9TLifggNGoPasnjQw505xKwo
         +nBvVVLWj1R2gVRzuAAAKJKU+7L+dMqGTH527Gj4GDUS+XteFJzmQvX0mB/iruSYOdG6
         aWlTA4I3IT0yRnHyd26mZExI6xF4KwOLqbmkey0RnTSsdBaV5p2dow9iwxBiPAXjSeZp
         L0k9sqzf5E0LuUca4sh3RNM23YeQQiMvWGwh2NOcoNtsmjUk+TWw6kFYZtAA7BrmGYpS
         8E/B+JxFPWBjMk3Fr/QmDmDkPiNsenhinfuhSxrO0yeCCdaVA9WP0evlCcxWSEnCsSiH
         M7eg==
X-Gm-Message-State: AOAM531fabfsJg+iJNy2WSCHlGvCqaXU0DYjNCuGeD3yZS2xVG7DMhRa
        9FRU4VRnrmiBZ94n45Qc/eNV32CHksQWUw==
X-Google-Smtp-Source: ABdhPJyXlAhKpJlQdjBUGvgfX7mfYuz94jiwXFjtHtrQ/6GzDLhFLUaqxq8h4sfkEn+lhFE3GSlZyw==
X-Received: by 2002:a05:6602:2f15:: with SMTP id q21mr365794iow.113.1638289817691;
        Tue, 30 Nov 2021 08:30:17 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id m7sm11925372ilu.58.2021.11.30.08.30.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:30:17 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id v23so26813793iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:30:17 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr392999ioa.128.1638289816639;
 Tue, 30 Nov 2021 08:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
In-Reply-To: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Nov 2021 08:30:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
Message-ID: <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 15, 2021 at 5:03 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> While testing RT_GROUP_SCHED, I found that my system would go bonkers
> if my test RT tasks ever got throttled (even if my test RT tasks were
> set to only get a tiny slice of CPU time). Specifically I found that
> whenever my test RT tasks were throttled that all other RT tasks in
> the system were being starved (!!). Several important RT tasks in the
> kernel were suddenly getting almost no timeslices and my system became
> unusable.
>
> After some experimentation, I determined that this behavior only
> happened when I gave my test RT tasks a high priority. If I gave my
> test RT tasks a low priority then they were throttled as expected and
> nothing was starved.
>
> I managed to come up with a test case that hopefully anyone can run to
> demonstrate the problem. The test case uses shell commands and python
> but certainly you could reproduce in other ways:
>
> echo "Allow 20 ms more of RT at system and top cgroup"
> old_rt=$(cat /proc/sys/kernel/sched_rt_runtime_us)
> echo $((old_rt + 20000)) > /proc/sys/kernel/sched_rt_runtime_us
> old_rt=$(cat /sys/fs/cgroup/cpu/cpu.rt_runtime_us)
> echo $((old_rt + 20000)) > /sys/fs/cgroup/cpu/cpu.rt_runtime_us
>
> echo "Give 10 ms each to spinny and printy groups"
> mkdir /sys/fs/cgroup/cpu/spinny
> echo 10000 > /sys/fs/cgroup/cpu/spinny/cpu.rt_runtime_us
> mkdir /sys/fs/cgroup/cpu/printy
> echo 10000 > /sys/fs/cgroup/cpu/printy/cpu.rt_runtime_us
>
> echo "Fork off a printy thing to be a nice RT citizen"
> echo "Prints once per second. Priority only 1."
> python -c "import time;
> last_time = time.time()
> while True:
>   time.sleep(1)
>   now_time = time.time()
>   print('Time fies %f' % (now_time - last_time))
>   last_time = now_time" &
> pid=$!
> echo "Give python a few seconds to get started"
> sleep 3
> echo $pid >> /sys/fs/cgroup/cpu/printy/tasks
> chrt -p -f 1 $pid
>
> echo "Sleep to observe that everything is peachy"
> sleep 3
>
> echo "Fork off a bunch of evil spinny things"
> echo "Chews CPU time. Priority 99."
> for i in $(seq 13); do
>   python -c "while True: pass"&
>   pid=$!
>   echo $pid >> /sys/fs/cgroup/cpu/spinny/tasks
>   chrt -p -f 99 $pid
> done
>
> echo "Huh? Almost no more prints?"
>
> I believe that the problem is an "if" test that's been in
> push_rt_task() forever where we will just reschedule the current task
> if it's higher priority than the next one. If I just remove that
> special case then everything works for me. I tried making it
> conditional on just `!rq->rt.rt_throttled` but for whatever reason
> that wasn't enough. The `if` test looks like an unlikely special case
> optimization and it seems like things ought to be fine without it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I know less than zero about the scheduler (so if I told you something,
> it's better than 50% chance the the opposite is true!). Here I'm
> asserting that we totally don't need this special case and the system
> will be fine without it, but I actually don't have any data to back
> that up. If nothing else, hopefully my test case in the commit message
> would let someone else reproduce and see what I'm talking about and
> can come up with a better fix.
>
>  kernel/sched/rt.c | 10 ----------
>  1 file changed, 10 deletions(-)

I know this isn't crazy urgent and I'm happy to sit and twiddle my
thumbs a bit longer if everyone is still sleepy from tryptophan, but
I'm curious if anyone had a chance to look at this. Can anyone confirm
that my script reproduces for them on something other than my system?
Does my patch seem sane?

Thanks!

-Doug
