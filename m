Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEC4B49A7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiBNKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:08:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344919AbiBNKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:03:22 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AA41993
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:48:48 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id be32so2925753ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCvPx0LAxErtAf0GfhIq/50YVwjpT8qlAVAFyOV4q5s=;
        b=PuHccwHrNCiz2jePG34br/PP18S87pJiYXywXU7SsUeJBQuaPUbIjyWANZz9nO3eNW
         lj+45LSzwLr++WGj2aYqhMrjuDN/K7W8H4yLF9F51yxXNUP7va4DPwa5UpGhWJZ65KqD
         CYgNUvJ9GtlD6EfUNaXhWe20EuwFsuBn4Gia7BRmMsLw6coSlbRz72F1mgVpGnumM1Q1
         039A467iGxr80lnu8Ws+Iq5b/QrZ/3t8iJuVRLEGse7zuTwYsWh0G+cQBnqGyfNbbLtu
         ISeZFmNmbAmbDuQ6Ub7s7XUOvlwtxWDjS79ZHPh3A6jwxkMX7u6aycX2ZCMrHmlrp9xi
         Dgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCvPx0LAxErtAf0GfhIq/50YVwjpT8qlAVAFyOV4q5s=;
        b=y0C/1ebgOtnxX4MHizcsIYAQKxlzsJvtke9T7i9Wk5obI78X58yxbL/tFoHL2mv4FG
         PEQUEvTtmFe+OlBEVfg8EirCw5qSJN7Pp5ZKxFumRn/eQHRZrhlYL76bJ34NrnVfNOfa
         r0goW2FgDV8fgN9QQfK4qwmLNJaO/6d+beLGVvx2bZSIHukPO6+RdfWCOl1190oVJXsQ
         SdXgp4ux3bj9t+eODwtUqFjugJalDG8MMbDOPG+ih6LB8ODEYu1W9uMGbxYR2lH7jL9t
         8M0RzpFc3CBAuyTVCwFHhHbkI20nppXY73a/QzD7xxn12uqG1KovaSAQT/gHRsjE4YuL
         Zg0Q==
X-Gm-Message-State: AOAM530tjMsuVXFQ5veN/hVKgRpmi8Gf8ZGUbJO5wAVFcSWN1yajiC4c
        yaqz4J92SAcR+VBvoRCBhGiAdFpZ0hRlir4MaKzxVA==
X-Google-Smtp-Source: ABdhPJzX3OhpOueMcJbOUslFH2RYWrTN41tcipLwbbYwoUBHn5mj5b9f9tzLu3SKULBfblWk+DSx69phQsKm54cF8vk=
X-Received: by 2002:a05:651c:a0b:: with SMTP id k11mr8709410ljq.266.1644832126546;
 Mon, 14 Feb 2022 01:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20220208094334.16379-1-mgorman@techsingularity.net> <20220208094334.16379-2-mgorman@techsingularity.net>
In-Reply-To: <20220208094334.16379-2-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Feb 2022 10:48:35 +0100
Message-ID: <CAKfTPtB1CEdAFggK2OVzOkK6zTBV-eR8PgRRL5wCa1=Esv30Tg@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Improve consistency of allowed NUMA
 balance calculations
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, 8 Feb 2022 at 10:43, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> There are inconsistencies when determining if a NUMA imbalance is allowed
> that should be corrected.
>
> o allow_numa_imbalance changes types and is not always examining
>   the destination group so both the type should be corrected as
>   well as the naming.
> o find_idlest_group uses the sched_domain's weight instead of the
>   group weight which is different to find_busiest_group
> o find_busiest_group uses the source group instead of the destination
>   which is different to task_numa_find_cpu
> o Both find_idlest_group and find_busiest_group should account
>   for the number of running tasks if a move was allowed to be
>   consistent with task_numa_find_cpu
>
> Fixes: 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA nodes")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..4592ccf82c34 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9003,9 +9003,10 @@ static bool update_pick_idlest(struct sched_group *idlest,
>   * This is an approximation as the number of running tasks may not be
>   * related to the number of busy CPUs due to sched_setaffinity.
>   */
> -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +static inline bool
> +allow_numa_imbalance(unsigned int running, unsigned int weight)
>  {
> -       return (dst_running < (dst_weight >> 2));
> +       return (running < (weight >> 2));
>  }
>
>  /*
> @@ -9139,12 +9140,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                                 return idlest;
>  #endif
>                         /*
> -                        * Otherwise, keep the task on this node to stay close
> -                        * its wakeup source and improve locality. If there is
> -                        * a real need of migration, periodic load balance will
> -                        * take care of it.
> +                        * Otherwise, keep the task close to the wakeup source
> +                        * and improve locality if the number of running tasks
> +                        * would remain below threshold where an imbalance is
> +                        * allowed. If there is a real need of migration,
> +                        * periodic load balance will take care of it.
>                          */
> -                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
>                                 return NULL;
>                 }
>
> @@ -9350,7 +9352,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 /* Consider allowing a small imbalance between NUMA groups */
>                 if (env->sd->flags & SD_NUMA) {
>                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                               busiest->sum_nr_running, busiest->group_weight);
> +                               local->sum_nr_running + 1, local->group_weight);
>                 }
>
>                 return;
> --
> 2.31.1
>
