Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943024FDC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357094AbiDLKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378422AbiDLKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:00:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E569D6D843
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:07:50 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t67so15173236ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mq4aiWm3Y4lyxCzbiwU9Ge/1oDBgcu9WD33KPrhUY+g=;
        b=yH2DXsZIz72uFP8NERg+F9xFDCni0QwfCp74a4A8StZu4vVpk283QASjLEFRCZoAi7
         j94bZ152bLWZ98A40lIGFM5oI+F/rTPeQtmVy8uQ7MpCqEEHijXKkX16hPGBj00ki15L
         ryN1d3+l3aXJXV2AU1maaODjH9nP24GuFuzTZRTSJ/gBh0YexvI/ADIQJZhueaT/+4qU
         E01PC//ewJ3dmD1JW/xvPFUPA5bM7DR12O9aWYyTl7EhlWz+xsTrsO7Zwol1MYYsaDJa
         VasjEeeukTLQO4sjYmRmvtBJ5fWPVrdNrS+d8/xN976WftOvqhqTvuiJTZIag1twX5Ar
         xkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq4aiWm3Y4lyxCzbiwU9Ge/1oDBgcu9WD33KPrhUY+g=;
        b=f6C/HULHlb0Oyt8upceZTR5nU+Qi9p14hrqwxjA3EpqX/KDaXqXNJAZtXrqtZ5TOR+
         mDUGdaoX6LeBQudD1ecxI2DeyHCQLgVhapY8TO4t3H9OtfoFie9InABQHb3Fvlon9VJd
         YHdjyIKyz0K8tTZpvAZ8gFcbcb5rIU09EQIH51SD45K9F+2bNDC1NGbBr3UfXlkExCCI
         +DsRKE0YR4F3spGvwlUtKWEKKr43wetcq0UShyBm1E3NwkiARNL2Vpainm5vMGJyv0j8
         w9+sfS8LTbL8EccsSdWh823beDhbjINglx01oPTEgRdxcMRNCF/5s2UMFUWcO7i7LvBy
         CKuw==
X-Gm-Message-State: AOAM530Uwse7/TTTtCwhWRa79qY+4SlWohBTYFcY/6MIOvuTLvugx7mA
        EM3A5uI5y1bJZcZEKIYQG2nqMPYMluBJ1dWnz/9Z1w==
X-Google-Smtp-Source: ABdhPJyVuuZpik+H9nBpQTECjQ6TkT/8gWFMrjo+hncDwWOSXkf1KZmGM4nuvItoSKc/LYswBX4D9yINbkiAqGMTRHY=
X-Received: by 2002:a25:1344:0:b0:633:7592:9c0f with SMTP id
 65-20020a251344000000b0063375929c0fmr26055334ybt.211.1649754470034; Tue, 12
 Apr 2022 02:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu> <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
In-Reply-To: <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Apr 2022 11:07:38 +0200
Message-ID: <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
Subject: Re: Scheduling tasks on idle cpu
To:     David Laight <David.Laight@aculab.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 at 10:39, David Laight <David.Laight@aculab.com> wrote:
>
> From: Qais Yousef
> > Sent: 12 April 2022 00:35
> >
> > On 04/11/22 08:26, David Laight wrote:
> > > From: Qais Yousef
> > > > Sent: 09 April 2022 18:09
> > > ...
> > > > RT scheduler will push/pull tasks to ensure the task will get to run ASAP if
> > > > there's another cpu at lower priority is available
> > >
> > > Does that actually happen?
> >
> > For RT tasks, yes. They should get distributed.
>
> Ok, that is something slightly different from what I'm seeing.
>
> > > I've seen the following:
> > >   34533 [017]: sys_futex(uaddr: 1049104, op: 85, val: 1, utime: 1, uaddr2: 1049100, val3: 4000001)
> > >   34533 [017]: sched_migrate_task: pid=34512 prio=120 orig_cpu=14 dest_cpu=17
> > >   34533 [017]: sched_wakeup: pid=34512 prio=120 success=1 target_cpu=017
> >
> > prio=120 is a CFS task, no?
>
> CFS = 'normal time-slice processes ? Then yes.
>
> > > and pid 34512 doesn't get scheduled until pid 34533 finally sleeps.
> > > This is in spite of there being 5 idle cpu.
> > > cpu 14 is busy running a RT thread, but migrating to cpu 17 seems wrong.
> > >
> > > This is on a RHEL7 kernel, I've not replicated it on anything recent.
> > > But I've very much like a RT thread to be able to schedule a non-RT
> > > thread to run on an idle cpu.
> >
> > Oh, you want CFS to avoid CPUs that are running RT tasks.
> >
> > We had a proposal in the past, but it wasn't good enough
> >
> >       https://lore.kernel.org/lkml/1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com/
>
> That seems to be something different.
> Related to something else I've seen where a RT process is scheduled
> on its old cpu (to get the hot cache) but the process running on
> that cpu is looping in kernel - so the RT process doesn't start.
>
> I've avoided most of the pain that caused by not using a single
> cv_broadcast() to wake up the 34 RT threads (in this config).
> (Each kernel thread seemed to wake up the next one, so the
> delays were cumulative.)
> Instead there is a separate cv for each RT thread.
> I actually want the 'herd of wildebeest' :-)
>
> > The approach in that patch modified RT to avoid CFS actually.
>
> Yes I want the CFS scheduler to pick an idle cpu in preference
> to an active RT one.

When task 34512 wakes up, scheduler checks if prev or this cpu are
idle which is not the case for you. Then, it compares the load of prev
and this_cpu and seems to select this_cpu (cpu17).

Once cpu17 selected, it will try to find an idle cpu which shares LLC
but it seems that the scheduler didn't find one and finally keeps task
34512 on this_cpu.

Note that during the next tick, a load balance will be trigger if
this_cpu still have both RT and task 34512,

>
> > Can you verify whether the RT task woke up after task 34512 was migrated to CPU
> > 17? Looking at the definition of available_idle_cpu() we should have avoided
> > that CPU if the RT task was already running. Both waking up at the same time
> > would explain what you see. Otherwise I'm not sure why it picked CPU 17.
>
> All 35 RT tasks are running when the request to schedule task 34512 is made.
> (They wake every 10ms to process UDP/RTP audio packets.)
> The RT task on cpu 17 carried on running until it ran out of work (after about 1ms).
> Task 34512 then ran on cpu 17.
>
> In this case task 34512 actually finished quite quickly.
> (It is creating and binding more UDP sockets.)
> But it looks like if it were still running on the next 10ms 'tick'
> it would be pre-empted by the RT task and be idle.
> Not ideal when I'm trying to schedule a background activity.
>
> I don't think the load-balancer will ever pick it up.
> All the process scheduling is happening far too fast.
>
> What I think might be happening is that the futex() code is requesting
> the woken up thread run on the current cpu.
> This can be advantageous in some circumstances - usually if you
> know the current thread is about to sleep.
> (I remember another scheduler doing that, but I can't remember why!
> The only sequence I can think of is a shell doing fork+exec+wait.)
> But it seems like a bad idea when a RT thread is waking a CFS one.
> (Or any case where the one being woken is lower priority.)
>
> I might have to run the 'background tasks' at low RT priority
> just to get them scheduled on idle cpu.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
