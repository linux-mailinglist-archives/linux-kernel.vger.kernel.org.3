Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A224463A64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbhK3Pp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbhK3Pph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:45:37 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:42:17 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p8so28445154ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrERzcuCrxtLZTcbKN8avYqKjR8tbdUKn4Cb74q01M4=;
        b=MZua7H2uF4UG5Jve7ZuPf8BSEgCbsdVrVY1e7Pi+gqQYDCQ6RJmylLp8XhAQp81VuA
         Es5mJFMg+SbEEk1d54ZhvTtx2HLBaCuRxcdE8ZLQUF4U5f65eacXucyrucz8U2vUf1oa
         vP9EnmCyNSvhZYv25dw5NuluClmj9jSHtpP8lXh+5HB16xo0HDy/q5hRjalHXTmeoItN
         Yn4vzNUzA3+rb0J8zWHWh/aUC+5TAy43jSLJWkQGvTHLOHSjDiyLPVQHYRxXdSFC6j0t
         dbZCaDPwsU373AUEE0zLinKt0JqqBot8PWF3AIMiDjoGg6ADsW6xBJduIBWNQAT/Zu5M
         2Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrERzcuCrxtLZTcbKN8avYqKjR8tbdUKn4Cb74q01M4=;
        b=lGY0Bsk7DBlBevT/i6wEy8GHHatewuiONVZASFQroBQ8dnwdxKnYczrS5q80XbJgB0
         iEs4uQfzVLCQtQnk8r3r248QvrdwK0X9RUl3obSPUNliHDFoftnIrfxFcTr3K2emC4kc
         kX8Ug+ln3h6i/4UIR6oZp4lwct0jWSMinqS315NxRAH2BYScj8Zvcpii3BzHlDbQTZcN
         uNowjug6sV0C3/lBRPrNnFivgNfThqurQ7KK6CRT+WpHWEEOhAD0FSI/tShY+O99tmVn
         vyjwhWFJTGLjeTlySE4R3I3TYsouhil4w1eExG4h/AdWeDrSkehXPzxZCB0OIYOn/tb0
         0AOA==
X-Gm-Message-State: AOAM530Y0Gl7eViO0uYUE9W1tf267K7bjXsbA45aO8EyANCA+gr8i6dg
        ZyLm+fKuIINSsU2ATJRPGmgCKwdgK66r77i5ifMmfA==
X-Google-Smtp-Source: ABdhPJxgCc/HfucoGypUL3oVKe7qh7LKQtNb68rDS7w9XORgw29qdTqWjIpeysOyzi/hH1FBsR7iPOaYRMh7W0q2RVY=
X-Received: by 2002:a2e:94e:: with SMTP id 75mr15729578ljj.494.1638286935378;
 Tue, 30 Nov 2021 07:42:15 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com> <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com> <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
 <87sfvjavqk.mognet@arm.com> <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
 <87pmqmc16f.mognet@arm.com> <20211126171817.GA3798214@ubiquitous>
 <CAKfTPtCGyp8JZq1EOgEhTeD+PBV2rMnTQ=uV-ZgsaN1RVmPk0w@mail.gmail.com> <20211129164545.GA3981328@ubiquitous>
In-Reply-To: <20211129164545.GA3981328@ubiquitous>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 Nov 2021 16:42:03 +0100
Message-ID: <CAKfTPtCU3TQC06j-nUgsv-7+Vn+XyKwJFv5EwCcTDrPObGttEw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     Valentin Schneider <Valentin.Schneider@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 17:54, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > > >
> > > > > still i don't see the need of !is_idle_task(current)
> > > > >
> > > >
> > > > Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
> > > > which can lead to coscheduling when the wakeup is issued by the idle task
> > > > (or even if rq->nr_running == 0, you can have rq->ttwu_pending without
> > > > having sent an IPI due to polling). Essentially this overrides the first
> > > > check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
> > > > target).
> > > >
> > > > I couldn't prove such wakeups can happen right now, but if/when they do
> > > > (AIUI it would just take someone to add a wake_up_process() down some
> > > > smp_call_function() callback) then we'll need the above. If you're still
> > > > not convinced by now, I won't push it further.
> > >
> > > From a quick experiment, even with the asym_fits_capacity(), I can trigger
> > > the following:
> > >
> > > [    0.118855] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > > [    0.128214] select_idle_sibling: wakee=rcu_gp:3 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > > [    0.137327] select_idle_sibling: wakee=rcu_par_gp:4 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > > [    0.147221] select_idle_sibling: wakee=kworker/u16:0:7 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> > > [    0.156994] select_idle_sibling: wakee=mm_percpu_wq:8 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> >
> > Timestamp shows its booting phase and thread name above shows per cpu
> > thread. Could it happen just while creating per cpu thread at boot and
> > as a result not relevant ?
>
> I have more of those logs a bit later in the boot:
>
> [    0.484791] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.516495] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.525758] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.535078] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.547486] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
> [    0.579192] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
>
> The nr_cpus_allowed=8 suggest that none of the threads from the logs I
> shared are per-CPU. Sorry if the format is confusing, I used:
>
>   wakee=<comm>:<pid> current=<comm>:<pid>.
>
> >
> > Can you see similar things later after booting ?
>
> I tried few scenarios other than the boot time but none of them produced
> "current=swapper/X:1 in_task=1"
>
> >
> > I have tried to trigger the situation but failed to get wrong
> > sequence. All are coming from interrupt while idle.
> > After adding in_task() condition, I haven't been able to trigger the
> > warn() that I added to catch the wrong situations on SMP, Heterogenous
> > or NUMA system. Could you share more details on your setup ?
> >
>
> This is just my Hikey960 with the asym_fits_capacity() fix [1] to make sure I
> don't simply hit the other issue with asym platforms.

I ran my previous tests on dragonboard 845c which is dynamiQ and I
have tried on my hikey960 since  but without any success so far. This
is what i use:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6397,9 +6397,12 @@ static int select_idle_sibling(struct
task_struct *p, int prev, int target)
         * essentially a sync wakeup. An obvious example of this
         * pattern is IO completions.
         */
-       if (is_per_cpu_kthread(current) &&
+       if (in_task() &&
+           is_per_cpu_kthread(current) &&
            prev == smp_processor_id() &&
            this_rq()->nr_running <= 1) {
+
+               WARN(is_idle_task(current), "idle per cpu kthread: cpu
%d task: %s", prev, p->comm);
                return prev;
        }


Without in_task() condition, i've got warnings from interrupt context
but nothing else.
Note that I don't even have the asym_fits_capacity() condition

>
> Then I just added my log in the per-CPU kthread wakee stacking exit path
>
>     printk("%s: wakee=%s:%d nr_cpus_allowed=%d current=%s:%d in_task=%d\n",
>             __func__, p->comm, p->pid, p->nr_cpus_allowed, current->comm, current->pid, in_task());
>
>
> [1] https://lore.kernel.org/all/20211125101239.3248857-1-vincent.donnefort@arm.com/
>
>
> From the same logs I also see:
>
>   wakee=xfsaild/mmcblk0:4855 nr_cpus_allowed=8 current=kworker/1:1:1070 in_task=0
>
> Doesn't that look like a genuine wakeup that would escape the per-CPU kthread
> stacking exit path because of the in_task test?
