Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8157D7ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiGVBKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVBKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:10:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E96BC96
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:10:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a23so3006138lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWSe/3Wg5HU41pw8QqMPhsHwcXm2qhOY66ZTHYbNu+0=;
        b=bn+fczcnWRS9i97cppV6oXbUTES/uabFmlU+7GqMtUNwlbentLgp+V+n2SpzDW0iC3
         7h6TFwORk4EUjzWEqWpvsZmSalwJYUWgBUjcAemND3LTVz4+VnyQ4vSgbg0EdK+nr6QJ
         raINv0z2zlZzU3Y07GH2dQtFnCJP7DeDooXkS5Ivo+mAb5Sa4fjsApS8SAfsjT6raANp
         TWAdYUb9csaA0ONOymalp7lS44NvIn9MVN7J0zLQyRXzx7zn7uWBEyCO4lWmUHe9PwwK
         FLuC/pS98NQJSoQBa2GvmzrA7ANoBB9EG5qUIacNuUVSJx90UUliN6/1sWbdJcdassQn
         nZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWSe/3Wg5HU41pw8QqMPhsHwcXm2qhOY66ZTHYbNu+0=;
        b=zNN0Z2QsFTDDQlzSVNTv2Bu1KtpaghsnUzCmiZgwhbLpwlwOW3ysoGVo/QFYZoeY33
         bnLVtMAqtmLkswZq2iQoajVuVsQNKGj4f1p353/C6WdJt4zq3svqhFngAEXxld0wAU1p
         7ua1u/61mYie9nGGZkFd1AOTBAdcwOoVNRtGBLR/FjR3oJhGNUgRRWqzqpUy7G1Yp13v
         rXtBsXuYrU8nuzC3lphmEahMueJbG899wdrSqCvOi6HFojUVLBd44ZV+/lE8OA5RtEu1
         h9WMqGtyLSxwcG4rEcIvAg+LFBlkBzRlXEZQNGmH+1z++AGoUZVOgk9UJZHMJL8TVWKE
         D85w==
X-Gm-Message-State: AJIora8oHwtfk4SKlJaI0NuKZZekYAjwJAGe+jtihuzoyXCO1r96fDxX
        W7n+26DJXlK7VXgJ80LCgwvrKZyN3nAgeX3ZY2c=
X-Google-Smtp-Source: AGRyM1ut4mOuyPwXtvRjuM3LMDJF64wouiuhDA+dmFwJX8s0GtskUvYRmVUh6LgKup1ZVZkDPVDf6hXy0J/Bv/1PfuI=
X-Received: by 2002:a05:6512:12d5:b0:48a:1cd7:127a with SMTP id
 p21-20020a05651212d500b0048a1cd7127amr379274lfg.577.1658452210232; Thu, 21
 Jul 2022 18:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-8-qais.yousef@arm.com>
 <CAB8ipk9=EEfArTTQ_w10+Df0WqMinFvjbmfFEBLg1zUYcHkOPw@mail.gmail.com> <20220721142447.emsv6q3y4ch3bphi@wubuntu>
In-Reply-To: <20220721142447.emsv6q3y4ch3bphi@wubuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Fri, 22 Jul 2022 09:09:59 +0800
Message-ID: <CAB8ipk_-t_iMicZ2+u=H16XiHtnpccPLse=+UQN9pv7d78sU+A@mail.gmail.com>
Subject: Re: [PATCH 7/7] sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s
 early exit condition
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:24 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 07/20/22 15:39, Xuewen Yan wrote:
> > Hi Qais
> >
> > On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > If the utilization of the woken up task is 0, we skip the energy
> > > calculation because it has no impact.
> > >
> > > But if the task is boosted (uclamp_min != 0) will have an impact on task
> > > placement and frequency selection. Only skip if the util is truly
> > > 0 after applying uclamp values.
> > >
> > > Change uclamp_task_cpu() signature to avoid unnecessary additional calls
> > > to uclamp_eff_get(). feec() is the only user now.
> > >
> > > Fixes: 732cd75b8c920 ("sched/fair: Select an energy-efficient CPU on task wake-up")
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 499ef7a7288c..a112ca45864c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4057,14 +4057,16 @@ static inline unsigned long task_util_est(struct task_struct *p)
> > >  }
> > >
> > >  #ifdef CONFIG_UCLAMP_TASK
> > > -static inline unsigned long uclamp_task_util(struct task_struct *p)
> > > +static inline unsigned long uclamp_task_util(struct task_struct *p,
> > > +                                            unsigned long uclamp_min,
> > > +                                            unsigned long uclamp_max)
> > >  {
> > > -       return clamp(task_util_est(p),
> > > -                    uclamp_eff_value(p, UCLAMP_MIN),
> > > -                    uclamp_eff_value(p, UCLAMP_MAX));
> > > +       return clamp(task_util_est(p), uclamp_min, uclamp_max);
> > >  }
> > >  #else
> > > -static inline unsigned long uclamp_task_util(struct task_struct *p)
> > > +static inline unsigned long uclamp_task_util(struct task_struct *p,
> > > +                                            unsigned long uclamp_min,
> > > +                                            unsigned long uclamp_max)
> > >  {
> > >         return task_util_est(p);
> > >  }
> > > @@ -6913,7 +6915,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > >         target = prev_cpu;
> > >
> > >         sync_entity_load_avg(&p->se);
> > > -       if (!task_util_est(p))
> > > +       if (!uclamp_task_util(p, p_util_min, p_util_max))
> >
> > Is it not enough to just replace the task_util_est with the
> > uclamp_task_util? If change the definition of uclamp_task_util,
> > that means it have to get task's uclamp first if user want to call the
> > function, may increase the code complex farther more?
>
> Calling uclamp_eff_value() all the time is not cheap actually.
>
> We can easily add two versions when we need to:
>
>         __uclamp_task_util(p, uclamp_min, uclamp_max);
>
>         uclamp_task_util(p) {
>                 uclamp_min = uclamp_eff_value();
>                 uclamp_max = uclamp_eff_value();
>                 return __uclamp_eff_value(p, uclamp_min, uclamp_max);
>         }
>
> When we need to. Since we have a single user now, there's no need to do this
> now and if we ever get more users it'd be easy to refactor then?

Sounds good!

Thanks!

>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> > >                 goto unlock;
> > >
> > >         for (; pd; pd = pd->next) {
> > > --
> > > 2.25.1
> > >
> >
> > BR
> > ---
> > xuewen.yan
