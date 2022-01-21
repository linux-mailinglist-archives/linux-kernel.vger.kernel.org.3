Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9D4960B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381076AbiAUO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381022AbiAUO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:27:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B5C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:27:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bu18so34255148lfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5DdgzdEP/ycx7S7WAsdXGSwAN7y02UOf2kIHObUcYA=;
        b=LPKgykbUdMmZqHV7RTgEm5kK2QzH3vl1DLmlkKDOJwrWWkAnO5+WQyxOeLlbfEwQ5/
         DwKsIhLmPxZqM8ikqxKGMVm4YabKaFOB2p3n/XNVw2Lrr0TpvtloHzzEE5uou7uq9PoM
         YUACtYIuc651Qy0xeO256dXFf8i+RM9XPDht19GtaDobIdjSwu+vlzK9NWjc95V7CB5b
         N7N8DYi6/IS1takj9tcGGPO+0QVIAdx12gZ2Q7pYFbItodPujZDIZKuJyrexFFZuIVoM
         tgh3/kwRS0LWGZ+HYLQmG3gCqYlB+Bo+AQVQoEz+hCFheA2hBoz2TNNFgzwujwsNFNVh
         oAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5DdgzdEP/ycx7S7WAsdXGSwAN7y02UOf2kIHObUcYA=;
        b=Pmz000qJupAAaTX/yCPmw/sVKYO2AhA6Foov/vv4sF0PPdSdYKwIZ+KqYPoaP6FZoS
         zSsSI825PzYorP2kBZNDYaxqRIxujnBMDLlgrbMgJRoyaVWkBGoeASQgeLNIISM/TMZY
         3EzMkQwPH2nvnTZIslHlrDtHf1HRwyzbDNkduLQm6EzOeAGBfNCXyBwIwwLdAR6oRIVe
         iX7xHHTKUO9RoWcyxxiijuHwLLLyl/OlwAYLpX1EsuvoiCJl12lgUggzyKbXe87NoXgZ
         jF/m8iiSicF+rp0QlWYlU+Qx72kmrMDDgfFyepZ60+pIH2IYvhphP4kDxs4KTs7exga7
         7hgA==
X-Gm-Message-State: AOAM532+5DKd/hkD0ePxzRIIBD+CHhkir1Lh8b6Yr241P+JqzkEhM+ct
        Kle0CtN/ikzxTJbgvP95Rgq96eK4YMvwesBP9Njnlw==
X-Google-Smtp-Source: ABdhPJxVEP+ieUR0BpVvq/WdgN9zf6SxNJrIPp+zWW83gdFVxbH/lah8cFzuxk01LCPckNDTgaE8/7iVNj31hvDnZyU=
X-Received: by 2002:a19:f811:: with SMTP id a17mr3865291lff.18.1642775273407;
 Fri, 21 Jan 2022 06:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20220121050233.8708-1-quic_ctheegal@quicinc.com>
In-Reply-To: <20220121050233.8708-1-quic_ctheegal@quicinc.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jan 2022 15:27:42 +0100
Message-ID: <CAKfTPtDTm5O_P504=_6Gjk2Uv0DiLS8Mu=c6km3uVO0h8BB1Lw@mail.gmail.com>
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

On Fri, 21 Jan 2022 at 06:03, Chitti Babu Theegala
<quic_ctheegal@quicinc.com> wrote:
>
> Newly forked threads don't have any useful utilization data yet and
> it's not possible to forecast their impact on energy consumption.

It would be worth mentioning that you consider only EAS mode in the patch

> These forkees (though very small, most times) end up waking big

The assumption that " (though very small, most times)" is maybe true
for the cases that you are interested in and you monitor, but it's not
always true. It seems that Vincent D. raised some concerns about
forkee which would not be small at the end.

> cores from deep sleep for that very small durations.
>
> Bias all forkees to small cores to prevent waking big cores from deep

you are testing idlest_sgs->idle_cpus so you don't bias to small cores
but small & idle cores but if there is no small idle core then you
will wake up a big core though the forkees are small most times

> sleep to save power.

Then why do you want to wake up a small core from deep state instead
of packing in one of these already running cpus? If you care about
power, selecting a small idle core may not always be the best choice.
Would it be better to select a non idle cpu with largest spare
capacity at the current opp ?

>
> Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
> ---
> Changes in v2:
> 1. Enclosed the EAS check for this small core preferring logic
> ---
>  kernel/sched/fair.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c6046446c50b3..72f9ea7c98c05 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5872,7 +5872,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  }
>
>  static struct sched_group *
> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
>
>  /*
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> @@ -5959,7 +5959,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>                         continue;
>                 }
>
> -               group = find_idlest_group(sd, p, cpu);
> +               group = find_idlest_group(sd, p, cpu, sd_flag);
>                 if (!group) {
>                         sd = sd->child;
>                         continue;
> @@ -8885,7 +8885,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  static bool update_pick_idlest(struct sched_group *idlest,
>                                struct sg_lb_stats *idlest_sgs,
>                                struct sched_group *group,
> -                              struct sg_lb_stats *sgs)
> +                              struct sg_lb_stats *sgs,
> +                              int sd_flag)
>  {
>         if (sgs->group_type < idlest_sgs->group_type)
>                 return true;
> @@ -8922,6 +8923,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
>                 if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>                         return false;
>
> +               if (sched_energy_enabled()) {

This is not enough, the find_energy_efficient_cpu() returns early to
fallback to the default performance mode when the system is
overutilized


> +                   /* Select smaller cpu group for newly woken up forkees */
> +                   if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
> +                       !capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
> +                       return false;
> +               }
> +
>                 /* Select group with lowest group_util */
>                 if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
>                         idlest_sgs->group_util <= sgs->group_util)
> @@ -8940,7 +8948,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * Assumes p is allowed on at least one CPU in sd.
>   */
>  static struct sched_group *
> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag)
>  {
>         struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
>         struct sg_lb_stats local_sgs, tmp_sgs;
> @@ -8978,7 +8986,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>
>                 update_sg_wakeup_stats(sd, group, sgs, p);
>
> -               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
> +               if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs, sd_flag)) {
>                         idlest = group;
>                         idlest_sgs = *sgs;
>                 }
> --
> 2.17.1
>
