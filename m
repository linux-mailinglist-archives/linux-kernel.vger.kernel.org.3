Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF37B4E970B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbiC1Mxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiC1Mxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:53:30 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9E5D1B2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bn33so19041826ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FarkKMmLpVs9abc1JGwF3+6Em6/7bJylY266bKU1okM=;
        b=AgsHsK/VKvAlNZn55HY1SCwW17O18ekHg4MBnW1cyn7uxkH+D5mO+to7ExoGkE7i+r
         e0pE4J8sOV1KDmqKX/i/1aAjLmU2wtif6aXDZRbcV+kCx9sBLBYpBT3bBsr/nxYONGMw
         FYd8V2inF/c8kTj9PsubdpwnOy9JMx4NocT42vJQRRHLUvW3JciCfIXVlRLsQBFKbdnS
         U5e9GsXrE+8Sp3mwdSGYMhuxb9QQQlrq9DP4n8imgt6uv4gaO+gtKywNU3tvWtK5bXwC
         +bRXG2m56g5dMgrC6acA06aEtqjn9OIfgVc3+cvX8UqAwQyK3xdLh9NAC/TC3I1qmnd3
         PwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FarkKMmLpVs9abc1JGwF3+6Em6/7bJylY266bKU1okM=;
        b=quMlFPlkfRKXFIbEFUU3fwe8kCT+iyAjCQnjtND200hwgrndAQfjn7KTeZHco+wcGB
         FXhFGQ9BD3S6dLMkBtJnkI4VKo+LfQMC2fZYjKp91R760wqSFkRmChtDMNdHwtTF1Tw1
         wHFJ9TSEGyKyRb4LdT0Kv9GK8NrD92gMuNHGYPaIbbdib3PtSt5Mgax+qKeiKbBnw9PQ
         edSLDl1MhBNDnn1zI3Q7VDS9MOwo1sc6Z+QSu3X9D4RHzgpXC5yJlc0fgYiUTUUj0tNW
         pMtKoxyycfD1wZOd8xlPPvvp+GCBgqK38vb/WAGzUuhYcmWRWy37VyFu5/WgLSvcmiwV
         gJKw==
X-Gm-Message-State: AOAM5339sQ686W/4e8A7s56hKkDo7CZtEqHZbHdivOLf2Cmm8E5Jbm1c
        9X+Xr/OYrVsuhehE1J6bj+oEPkKrU8a4lReMTYhTIA==
X-Google-Smtp-Source: ABdhPJwOJv1Z0j/jaHQ3e7pDXB/bqvLC6hjCGxQr2O82xChNKWxBovkAUr01edZUW+5pkpNu8F7A09O/ZmkHIgl4lrk=
X-Received: by 2002:a2e:b5b9:0:b0:246:b30:64c8 with SMTP id
 f25-20020a2eb5b9000000b002460b3064c8mr19533430ljn.17.1648471901768; Mon, 28
 Mar 2022 05:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org> <bb92b4ee-293b-7e00-6e74-bd10fc088f7e@arm.com>
In-Reply-To: <bb92b4ee-293b-7e00-6e74-bd10fc088f7e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 28 Mar 2022 14:51:29 +0200
Message-ID: <CAKfTPtBWUz3zvOXx-s7_xsyPZU9WDYXz-6KpiC6hG9TVhFVXdw@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
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

On Mon, 28 Mar 2022 at 11:24, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/03/2022 17:14, Vincent Guittot wrote:
>
> [...]
>
> > @@ -4412,7 +4417,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> >               p->prio = p->normal_prio = p->static_prio;
> >               set_load_weight(p, false);
> >
> > -             p->latency_nice = DEFAULT_LATENCY_NICE;
> > +             p->latency_prio = NICE_TO_LATENCY(0);
> >               /*
> >                * We don't need the reset flag anymore after the fork. It has
> >                * fulfilled its duty:
> > @@ -4420,6 +4425,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> >               p->sched_reset_on_fork = 0;
> >       }
> >
> > +     /* Once latency_prio is set, update the latency weight */
> > +     set_latency_weight(p);
>
> I thought we only have to do this in the `sched_reset_on_fork` case?
> Like we do with set_load_weight(). Can we not rely on dup_task_struct()
> in the other case?
>
> [...]
>
> > @@ -5648,6 +5677,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >       if (!task_new)
> >               update_overutilized_status(rq);
> >
> > +     if (rq->curr == rq->idle)
> > +             check_preempt_from_idle(cfs_rq_of(&p->se), &p->se);
>
> This is done here (1) because check_preempt_wakeup() (2) is only called
> if p and rq->curr have CFS sched class?

Yes

>
>
> ttwu_do_activate()
>   activate_task()
>     enqueue_task <-- (1)
>   ttwu_do_wakeup()
>     check_preempt_curr()
>       if (p->sched_class == rq->curr->sched_class)
>         rq->curr->sched_class->check_preempt_curr() <-- (2)
>
> [...]
>
> > @@ -7008,6 +7059,10 @@ static int
> >  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> >  {
> >       s64 gran, vdiff = curr->vruntime - se->vruntime;
> > +     int latency_weight = se->latency_weight - curr->latency_weight;
> > +
> > +     latency_weight = min(latency_weight, se->latency_weight);
>
> Why the min out of latency_weight_diff(se, curr) and se->latency_weight
> here?

when there are 2  low latency tasks (weight 1024), there is no reason
to favor the the waking task so we take the diff (0 in this case)
When there are 2 high latency  tolerant task (weight -1024), we want
to make sure to not preempt current task we take the weight (-1024)
instead of the diff

>
> [...]
