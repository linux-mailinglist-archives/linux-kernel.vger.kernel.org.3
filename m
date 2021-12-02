Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67477466999
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376522AbhLBSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhLBSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:09:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD38C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:05:53 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x6so473645iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk83fnSxzHOPdAkprWUyhZQa92XvjA/myRzlxZLGEcE=;
        b=N5ByAzHYtKYY5OuliT1MZojwV3yPuNYTpuv2IN6GWpKoVJsV4Ot6TqYJrES5gCJZ78
         kDRAYTYPBipY0nE5RhQ7ojhmVne2NJgfrU2qALPm+QJsNN7yc+RNViqZz9NobTPK3xfR
         8+8Ynh7TvSkusEiyDlfo43MexWP5Paot+c3E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk83fnSxzHOPdAkprWUyhZQa92XvjA/myRzlxZLGEcE=;
        b=ZQrarEngsjFUzK0QlJSOCwvr3vVVHeJfeoX2ZZvjLF9E2/hVJ4wKHeuLiujAgDg+ND
         IIajvrOtq1V6sOwJ3apCqzMtiPGWe7voNf9h+gp63IfJgR8GR4s6Tar3WOHO1Qx5eQcG
         mU1pawQrKM5tq2EUc6bLUEStuBVDVfYc/HIU65Hr4KmecyaIxSjEh/M5gR077vPsXrEQ
         rjj2dZBC+bpiR+qN0bK8KIuHHZP765T0o1jN4JCDNcAm7KpnpTdGN28sIz01mSwLAxjU
         Y2/iJq70ciROrOHkoCogVsfqGgEd2dcJxWK7f8Oep6nnAZykX+56wcYNU/mwQ8vvRI39
         PIpQ==
X-Gm-Message-State: AOAM5309lMYayB31TqnKGw+lHDlKYv5cwqwvEFl6O98RDiZ+fzBhpSoi
        qemcvDWpO0+RDXP9ASom8ZMaaAYdURFU5A==
X-Google-Smtp-Source: ABdhPJxW6XA7J8baHMM+NBqoIqVAwp3MMZMPf2+4mZVwNk0NckI/SU2Hh7CfkIpkmd0vNoTqu4WGVA==
X-Received: by 2002:a05:6638:238b:: with SMTP id q11mr20258639jat.43.1638468352416;
        Thu, 02 Dec 2021 10:05:52 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id k13sm258540ilq.38.2021.12.02.10.05.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 10:05:51 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id c3so534655iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:05:51 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr16090358ioa.128.1638468350919;
 Thu, 02 Dec 2021 10:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid>
 <CAD=FV=UZNxt7y6bTipyvYFGMJhgp6nRozNt=iEaOYP6yc4OFpg@mail.gmail.com>
 <CAJWu+ora8F0eurnYkSXRqcT4mB8k8wy9CyKj1EGk52vEVEkT3A@mail.gmail.com> <20211202111127.gew4lqquvtn3lkbc@e107158-lin.cambridge.arm.com>
In-Reply-To: <20211202111127.gew4lqquvtn3lkbc@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Dec 2021 10:05:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V8aB7_6tEq9SbW+vNC5Y7G+8JMsWXo6+zdtF3tmJ97EQ@mail.gmail.com>
Message-ID: <CAD=FV=V8aB7_6tEq9SbW+vNC5Y7G+8JMsWXo6+zdtF3tmJ97EQ@mail.gmail.com>
Subject: Re: [PATCH] sched/rt: Don't reschedule a throttled task even if it's
 higher priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 2, 2021 at 3:11 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Joel, Doug
>
> On 11/30/21 18:36, Joel Fernandes wrote:
> > On Tue, Nov 30, 2021 at 11:30 AM Doug Anderson <dianders@chromium.org> wrote:
> > > I know this isn't crazy urgent and I'm happy to sit and twiddle my
> > > thumbs a bit longer if everyone is still sleepy from tryptophan, but
> > > I'm curious if anyone had a chance to look at this. Can anyone confirm
> > > that my script reproduces for them on something other than my system?
> >
> > Maybe +Qais Yousef can also chime in. Just to add, I think Doug's
>
> I could try :-)
>
> /me tries to find the original posting

Oops! I thought I had duplicated enough of the content in this patch.
Should have included a reference. It's:

https://lore.kernel.org/r/CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com/


> > issue is that under RT group scheduling, he expects *other* well
> > behaved RT tasks to not be throttled while the tasks that are
> > misbehaving to be *gracefully* throttled. Gracefully being- it is
> > probably WAI that they are exceeding their runtime and so *should
> > naturally* be bandwidth-limited similar to deadline. I am not sure if
> > the design of RT throttling considers throttling as an anomaly or
> > something that's expected to happen. If it is expected to happen, then
> > I see Doug's point that the mechanism shouldn't affect other RT tasks.
>
> I don't know much about RT group throttling, but I am under the impression it
> is to give other sched classes a breather, not other lower priority RT tasks.
> RT still relies on admins knowing what they're doing when creating RT tasks and
> manage their priorities.

So I guess this is where my fundamental disagreement is. I would say
that one point of the throttling is to prevent an errant RT task (one
that's going crazy) from taking the system down with it. It seems a
bit strange to me that we'd want to protect the normal tasks (which
should, in general, be less urgent than _all_ the RT tasks) but not
lower priority RT tasks. In my case the lower priority RT tasks are
actually important enough that blocking them _does_ take the system
down.


> What I think is happening in your case is that you're spawning 13 busyloops at
> priority 99, assuming you're on a chromebook which probably has at best 8 CPUs,
> you're basically killing the machine and there's nothing the scheduler can do
> about it. You get what you asked for :-)

Well, I asked it to only let those 13 busyloops get 10 ms to run per 1
second at most (and then put them on ice). ...so in my mind I _didn't_
get what I asked for. ;-)


> If you spawn nr_cpus_id - 1 busyloops, the lower priority tasks should find
> 1 cpu to get their work done, and I don' expect a hang then. And the RT
> throttling should allow CFS to make some progress every now and then on the
> other CPUs. So you might end up in a slow system, but not hanging one
> hopefully.
>
> Note that Peter fixed the kernel so that it produces known RT priorities (as
> opposed to developers setting random values in the past):
>
>   * sched_set_fifo_low() ==> not really RT but needs to be above cfs. Runs at
>     priority 1.
>   * sched_set_fifo() ==> sets priority MAX_RT_PRIO/2 ==> 50
>
> So most system RT tasks fall into the 2nd category, which is reasonably high
> priority. And RT scheduling assumes if you set something higher than that,
> then it's your responsibility to make sure they don't starve :-)
>
> Yep, it's easy to shoot yourself in the foot with RT, that's why it's
> privileged op ;-)

For sure getting RT scheduling wrong will shoot you in the foot, but I
don't think what I did was wrong.

From my understanding of the throttling, one big goal (maybe not the
only goal, but a big one) is to make sure that if a process goes
haywire (presumably trying to take 100% of the CPU) that the system
doesn't die and corrective action can be taken on the errant process.
I think I have shown that this goal is really only achieved if the
errant process is lower priority than all the other RT tasks in the
system. That doesn't seem like a reasonable limitation...

I would also say that with Peter's fix above the problem is perhaps
_more_ urgent? You just said that there's a whole bunch of kernel
tasks that are now created with the lowest RT priority. From your
description above this means "not really RT but needs to be above
cfs". If a sysadmin uses RT_GROUP_SCHED and a priority other than the
lowest priority then it's pretty much guaranteed that if the process
goes haywire that it will take down all of these important kernel
tasks. That can't be right, can it?

Maybe the answer is simply that RT_GROUP_SCHED and RT priority are
incompatible? I could submit a patch that forces all RT tasks to have
the same effective priority if RT_GROUP_SCHED is defined. :-/


> > > Does my patch seem sane?
> >
> > To be honest, I don't understand that bit enough :(
>
> Nope. The patch breaks RT priority scheduling. You basically allow a lower
> priority task to run before a higher priority one. Another code path will
> probably detect that and tries to correct it later, but still this is not
> right.

OK, I'll take your word for it. I'm still hoping someone can tell me a
better way to fix this?


-Doug
