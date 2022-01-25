Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8FE49B513
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577111AbiAYN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576649AbiAYNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:24:27 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E28C061749
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:24:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y15so48483463lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ2oTmxqAAHBphVdqj9gFXH4hc7RUo1b+qk83WMu3Ug=;
        b=Rs6X3pq9Uu+NlJQOR6hsQyUWXuR7MVmMYVb8euWD9l0eReZe7eVMFT4SmKr8LYMjLK
         pbDaeX7U9kh02d4Yj873Ae7wMrl9nIdQjJl/DEX34ZXHeERn6/AsUnZ/BmVKZup9PzZN
         dCDXQbChhGF8JlQs1eVNb7jyhC1aXFzUhM5hKuV6lSDIWgKyAv2nscTrUgIZPEZAeq4c
         iqkMfYD7GLgnRvB6nF948fdZTPCb0u5RNMMcn8yJuZGAAvs1/tylDJpuF1FZrQ6XSNq9
         Xpm6nr100DOceis5ZP/HE0KaYzMZvczJbsmONyx1MU1UvbBHfZhtApCY4kMT3vL3uVu3
         ti2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ2oTmxqAAHBphVdqj9gFXH4hc7RUo1b+qk83WMu3Ug=;
        b=xVwelRkkPd0akxRgDqd4uMMdzPuaa8CfYeQm7a3PDNQAwm2TVEJ2hGNmdmyG73ZdvY
         FOey4YWnArXoMumcfBNeiOItV9Cw6ZJwH53gqE37j9Tey+6OVTjtYoIPFozf40oDEkSq
         4G+7zhVz5eT+qJ5wK1/faITL+xqlJ9wfny41O720Ogb10eGC2/LUjTCX4jBGs93ITZlx
         1RdqxN4fJas4B5lv/z7qlzcen7WeXpLhGvHHc/eZFXCuAKC3UO1bBM0utMu1k28acZeZ
         POtBPmM8MPTuDTlnVX1ysXorDNmpqoc3UFHpMuytzZ1gyamztwxz3f/tox+zczPwsKSO
         6agw==
X-Gm-Message-State: AOAM530sEPPkhWJvCrXY7UntH+71pQTgTzbYTrHsfZRVdYmKd6BpkAsw
        DH9ark4T1X0UY+rfE8+0JAlsR7IWlKQMoIh9YIpZfQ==
X-Google-Smtp-Source: ABdhPJzUtMZW0ncMTgVMvtsybIJ+1ZPs5OYZXpL7jVFA3VKdq/0gz2hSQYKDrlHqyDBIm+O82nf40pObaCcXifCYvR0=
X-Received: by 2002:a05:6512:3b96:: with SMTP id g22mr5088964lfv.32.1643117064573;
 Tue, 25 Jan 2022 05:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220121050233.8708-1-quic_ctheegal@quicinc.com>
 <CAKfTPtDTm5O_P504=_6Gjk2Uv0DiLS8Mu=c6km3uVO0h8BB1Lw@mail.gmail.com> <e60c7e8a-3eb4-d6b4-18c5-819089256c34@quicinc.com>
In-Reply-To: <e60c7e8a-3eb4-d6b4-18c5-819089256c34@quicinc.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Jan 2022 14:24:13 +0100
Message-ID: <CAKfTPtD7xSYNFBrDTDrOocgz6s2jHT1BaOZkRtb9N825VprMMA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Prefer small idle cores for forkees
To:     Chitti Babu Theegala <quic_ctheegal@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        joel@joelfernandes.org, linux-arm-msm@vger.kernel.org,
        quic_lingutla@quicinc.com, linux-kernel@vger.kernel.org,
        quic_rjendra@quicinc.com, Vincent.Donnefort@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 08:09, Chitti Babu Theegala
<quic_ctheegal@quicinc.com> wrote:
>
>
> On 1/21/2022 7:57 PM, Vincent Guittot wrote:
> > On Fri, 21 Jan 2022 at 06:03, Chitti Babu Theegala
> > <quic_ctheegal@quicinc.com> wrote:
> >>
> >> Newly forked threads don't have any useful utilization data yet and
> >> it's not possible to forecast their impact on energy consumption.
> >
> > It would be worth mentioning that you consider only EAS mode in the patch
> >
> >> These forkees (though very small, most times) end up waking big
> >
> > The assumption that " (though very small, most times)" is maybe true
> > for the cases that you are interested in and you monitor, but it's not
> > always true. It seems that Vincent D. raised some concerns about
> > forkee which would not be small at the end
> Agreed.
>
> >> cores from deep sleep for that very small durations.
> >>
> >> Bias all forkees to small cores to prevent waking big cores from deep
> >
> > you are testing idlest_sgs->idle_cpus so you don't bias to small cores
> > but small & idle cores but if there is no small idle core then you
> > will wake up a big core though the forkees are small most times
> >
>
> The function "find_idlest_cpu" expected to return idle cpu. So, I
> followed the same. If idle small cpu is available, then we can use it

find_idlest_cpu() returns the idlest cpu which may not be idle

> otherwise its ok to wakeup big cpu for newly forked tasks.
> I felt that using idle CPUs for new tasks will be better as that would
> give them a faster chance to run immediately.

But this goes at the opposite of your 1st goal which is to not wake up
a big core in deep idle state. Just to say that this doesn't seem that
clear when it's worth waking up a big core

>
> >> sleep to save power.
> >
> > Then why do you want to wake up a small core from deep state instead
> > of packing in one of these already running cpus? If you care about
> > power, selecting a small idle core may not always be the best choice.
> > Would it be better to select a non idle cpu with largest spare
> > capacity at the current opp ?
> >
>
> How about running find_energy_efficient_cpu() for newly forked tasks as
> well (with some default util value configured) ?

Regarding what you are trying to do, I feel that it could be better to
modify and use feec to select a cpu for newly forked task when not
overutilized. Then you can use more input to select the most efficient
cpu

>
> >>
> >> Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
> >> ---
> >> Changes in v2:
> >> 1. Enclosed the EAS check for this small core preferring logic
> >> ---
> >>   kernel/sched/fair.c | 18 +++++++++++++-----
> >>   1 file changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index c6046446c50b3..72f9ea7c98c05 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -5872,7 +5872,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
> >>   }
> >>
> >>   static struct sched_group *
> >> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> >> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
> >>
> >>   /*
> >>    * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> >> @@ -5959,7 +5959,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> >>                          continue;
> >>                  }
> >>
> >> -               group = find_idlest_group(sd, p, cpu);
> >> +               group = find_idlest_group(sd, p, cpu, sd_flag);
> >>                  if (!group) {
> >>                          sd = sd->child;
> >>                          continue;
> >> @@ -8885,7 +8885,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> >>   static bool update_pick_idlest(struct sched_group *idlest,
> >>                                 struct sg_lb_stats *idlest_sgs,
> >>                                 struct sched_group *group,
> >> -                              struct sg_lb_stats *sgs)
> >> +                              struct sg_lb_stats *sgs,
> >> +                              int sd_flag)
> >>   {
> >>          if (sgs->group_type < idlest_sgs->group_type)
> >>                  return true;
> >> @@ -8922,6 +8923,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
> >>                  if (idlest_sgs->idle_cpus > sgs->idle_cpus)
> >>                          return false;
> >>
> >> +               if (sched_energy_enabled()) {
> >
> > This is not enough, the find_energy_efficient_cpu() returns early to
> > fallback to the default performance mode when the system is
> > overutilized
> >
> >
> >> +                   /* Select smaller cpu group for newly woken up forkees */
> >> +                   if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
> >> +                       !capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
> >> +                       return false;
> >> +               }
> >> +
> >>                  /* Select group with lowest group_util */
> >>                  if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
> >>                          idlest_sgs->group_util <= sgs->group_util)
> >> @@ -8940,7 +8948,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
> >>    * Assumes p is allowed on at least one CPU in sd.
> >>    */
> >>   static struct sched_group *
> >> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag)
> >>   {
> >>          struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
> >>          struct sg_lb_stats local_sgs, tmp_sgs;
> >> @@ -8978,7 +8986,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >>
> >>                  update_sg_wakeup_stats(sd, group, sgs, p);
> >>
> >> -               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
> >> +               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs, sd_flag)) {
> >>                          idlest = group;
> >>                          idlest_sgs = *sgs;
> >>                  }
> >> --
> >> 2.17.1
> >>
