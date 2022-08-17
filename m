Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02C596C42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiHQJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiHQJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:48:41 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3543C176
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:48:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-33387bf0c4aso112285077b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=+BNYYjGJx0SlgNYFMQjknoSTEOIuTDtZUE+QEQGwYdg=;
        b=v9pb2BFSLXfL6tQHhSOeiMDjQ6IZvq6jYanz8JBhRCvEcBxL7VsYqlJSF609u0ffxm
         16yV3NKILjEWzPCiKMdrdHhIcYLRsA9pHQtXqBtGmFLeKpqquzTKnbsfS94pqZxWLn2o
         jyv5SpP6+o78r4lmYyqoZ4jl6cl2L15gWnpGrZ2G+C5bujft3A1sHY8+PPm28jM/tPfy
         /xXsyHzQt0zbyHCGE4epbfBVNLhzAkITgDI6167BMSqsNhjceJzUQBJRTdEw2Nk/7ZLT
         9IkLI24LQfIwtIAZFnH4b50b/uJzD+ykRENHvJjIyAPEe8ydEEyBxT3xB+raUfbmXF7x
         djAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=+BNYYjGJx0SlgNYFMQjknoSTEOIuTDtZUE+QEQGwYdg=;
        b=LV4rvmm3MiCrwtex4iAVcl+qi23PrHfrYLXO1iCP3J/0KADchbKtzUwmIwN1gG6yZB
         JHDyUZuFfXWyrVk+CwpCsOQxdpCz8uBNnQPhG0pOSQt0HmGuBsuACkEAMUao38nRG2Vb
         JSKA7EyvIcfqsjZY9++a+CoGe/oDSU/UH80wnN4m86YnP3BMojPxSz3wDA0gNx8IXSYB
         Fn2y+CPVUDBJObZCqXnL51tDfCfZhycCjgZSGimOjB0WReM+KD4RagA+ktY2EL4aQRIY
         O6I78ldif4UvwkX34WwqdfhIDotB5VWJuiPdef3+RXGC/oTQkrbW4hAk7po0mMeHEdlB
         yb4Q==
X-Gm-Message-State: ACgBeo2udFIEY0SHwMN4gwVT1iRbaQNaQtclHsUikifjmFM9cNpZNK5U
        BWOiTimzt6sS7Zu3j6G/llJrQ0OQMUutfKYKKxbiOg==
X-Google-Smtp-Source: AA6agR6oR0oiELSKuQsMpQGnJDtAE4OVkpOg7KiU5w+F6LC7MnRJu9a9neXVMoB4RRVaApKhq6vtad1KXp4ckaUwEKA=
X-Received: by 2002:a81:e0a:0:b0:31e:2180:2b39 with SMTP id
 10-20020a810e0a000000b0031e21802b39mr20215680ywo.319.1660729719263; Wed, 17
 Aug 2022 02:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-3-qais.yousef@arm.com>
 <CAKfTPtAxK=NGbpQkiW8-tx3kEwp-M7LAr1Rq_kdWDdsSq7Hd9A@mail.gmail.com>
 <20220712104843.frbtkgkiftaovcon@wubuntu> <20220721142949.fqmabrjwylkuoltw@wubuntu>
 <20220722081913.GA6045@vingu-book> <20220727160501.m4omtncl5nvqoh3p@wubuntu>
In-Reply-To: <20220727160501.m4omtncl5nvqoh3p@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Aug 2022 11:48:28 +0200
Message-ID: <CAKfTPtAxm06k2j3NH77EeOBTaoa3mGYguqf51Mno=XzLZR1meQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 18:05, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> On 07/22/22 10:19, Vincent Guittot wrote:
> > Le jeudi 21 juil. 2022 =C3=AF=C2=BF=C2=BD 15:29:49 (+0100), Qais Yousef=
 a =C3=AF=C2=BF=C2=BDcrit :
> > > On 07/12/22 11:48, Qais Yousef wrote:
> > > > On 07/11/22 15:09, Vincent Guittot wrote:
> > > > > On Wed, 29 Jun 2022 at 21:48, Qais Yousef <qais.yousef@arm.com> w=
rote:
> > > >
> >
> > [...]
> >
> > > > > > @@ -9108,7 +9125,7 @@ static inline void update_sg_wakeup_stats=
(struct sched_domain *sd,
> > > > > >
> > > > > >         /* Check if task fits in the group */
> > > > > >         if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > > > > > -           !task_fits_capacity(p, group->sgc->max_capacity)) {
> > > > > > +           !task_fits_cpu(p, group->sgc->max_capacity_cpu)) {
> > > > >
> > > > > All the changes and added complexity above for this line. Can't y=
ou
> > > > > find another way ?
> > > >
> > > > You're right, I might have got carried away trying to keep the logi=
c the same.
> > > >
> > > > Can we use group->asym_prefer_cpu or pick a cpu from group->sgc->cp=
umask
> > > > instead?
> > > >
> > > > I'll dig more into it anyway and try to come up with simpler altern=
ative.
> > >
> > > Actually we can't.
> > >
> > > I can keep the current {max,min}_capacity field and just add the new
> > > {max,min}_capacity_cpu and use them where needed. Should address your=
 concerns
> > > this way? That was actually the first version of the code, but then i=
t seemed
> > > redundant to keep both {max,min}_capacity and {max,min}_capacity_cpu.
> > >
> > > OR
> > >
> > > I can add a new function to search for max spare capacity cpu in the =
group.
> > >
> > > Preference?
> > >
> >
> > Isn't the below enough and much simpler ?
>
> Thanks for that!
>
> >
> > [PATCH] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> >
> > So that the new uclamp rules in regard to migration margin and capacity
> > pressure are taken into account correctly.
> > ---
> >  kernel/sched/fair.c  | 25 +++++++++++++++----------
> >  kernel/sched/sched.h |  9 +++++++++
> >  2 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5eecae32a0f6..3e0c7cc490be 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4317,10 +4317,12 @@ static inline int util_fits_cpu(unsigned long u=
til,
> >       return fits;
> >  }
> >
> > -static inline int task_fits_capacity(struct task_struct *p,
> > -                                  unsigned long capacity)
> > +static inline int task_fits_cpu(struct task_struct *p, int cpu)
> >  {
> > -     return fits_capacity(uclamp_task_util(p), capacity);
> > +     unsigned long uclamp_min =3D uclamp_eff_value(p, UCLAMP_MIN);
> > +     unsigned long uclamp_max =3D uclamp_eff_value(p, UCLAMP_MAX);
> > +     unsigned long util =3D task_util_est(p);
> > +     return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
> >  }
> >
> >  static inline void update_misfit_status(struct task_struct *p, struct =
rq *rq)
> > @@ -4333,7 +4335,7 @@ static inline void update_misfit_status(struct ta=
sk_struct *p, struct rq *rq)
> >               return;
> >       }
> >
> > -     if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
> > +     if (task_fits_cpu(p, cpu_of(rq))) {
> >               rq->misfit_task_load =3D 0;
> >               return;
> >       }
> > @@ -8104,7 +8106,7 @@ static int detach_tasks(struct lb_env *env)
> >
> >               case migrate_misfit:
> >                       /* This is not a misfit task */
> > -                     if (task_fits_capacity(p, capacity_of(env->src_cp=
u)))
> > +                     if (task_fits_cpu(p, env->src_cpu))
> >                               goto next;
> >
> >                       env->imbalance =3D 0;
> > @@ -9085,6 +9087,10 @@ static inline void update_sg_wakeup_stats(struct=
 sched_domain *sd,
> >
> >       memset(sgs, 0, sizeof(*sgs));
> >
> > +     /* Assume that task can't fit any CPU of the group */
> > +     if (sd->flags & SD_ASYM_CPUCAPACITY)
> > +             sgs->group_misfit_task_load =3D 0;
>
> Should this be
>
>         sgs->group_misfit_task_load =3D 1
>
> to indicate it doesn't fit?

Yes

>
> > +
> >       for_each_cpu(i, sched_group_span(group)) {
> >               struct rq *rq =3D cpu_rq(i);
> >               unsigned int local;
> > @@ -9104,12 +9110,11 @@ static inline void update_sg_wakeup_stats(struc=
t sched_domain *sd,
> >               if (!nr_running && idle_cpu_without(i, p))
> >                       sgs->idle_cpus++;
> >
> > -     }
> > +             /* Check if task fits in the CPU */
> > +             if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > +                 task_fits_cpu(p, i))
> > +                     sgs->group_misfit_task_load =3D 0;
>
> So we clear the flag if there's any cpu that fits, I think that should wo=
rk,
> yes and much better too. I got tunneled visioned and didn't take a step b=
ack to
> look at the big picture. Thanks for the suggestion :-)
>
> I think we can make it more efficient by checking if
> sgs->group_misfit_task_load is set
>
>                 /* Check if task fits in the CPU */
>                 if (sd->flags & SD_ASYM_CPUCAPACITY &&
>                     sgs->group_misfit_task_load &&
>                     task_fits_cpu(p, i))
>                         sgs->group_misfit_task_load =3D 0;
>
> which will avoid calling task_fits_cpu() repeatedly if we got a hit alrea=
dy.

yes, looks better

>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> > -     /* Check if task fits in the group */
> > -     if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > -         !task_fits_capacity(p, group->sgc->max_capacity)) {
> > -             sgs->group_misfit_task_load =3D 1;
> >       }
> >
> >       sgs->group_capacity =3D group->sgc->capacity;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 02c970501295..3292ad2db4ac 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2988,6 +2988,15 @@ static inline bool uclamp_is_used(void)
> >       return static_branch_likely(&sched_uclamp_used);
> >  }
> >  #else /* CONFIG_UCLAMP_TASK */
> > +static inline unsigned long uclamp_eff_value(struct task_struct *p,
> > +                                          enum uclamp_id clamp_id)
> > +{
> > +     if (clamp_id =3D=3D UCLAMP_MIN)
> > +             return 0;
> > +
> > +     return SCHED_CAPACITY_SCALE;
> > +}
> > +
> >  static inline
> >  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> >                                 struct task_struct *p)
> > --
> > 2.17.1
> >
> > >
> > > Thanks!
> > >
> > > --
> > > Qais Yousef
