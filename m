Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F335520A88
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiEJBSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiEJBSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:18:30 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D91847C3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:14:34 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7c57ee6feso163765327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2NYOBnGr3oC2HbawPc8n2japmW7gZ/2gS/4kyYGuoc=;
        b=JbcRYkCc3dNkJImVIJeRCKnH0a6NvUueYeaeMCxC/VbHQDIFXeiIjr+Vka/KYytySi
         4VGrbeecRB92r3uSg9lmdmodmKIHyDk/f/EHKWY+1aqymATjfKiHLI4auVq+twjRiS3t
         0Fp3NS8Rg1Dc1R+PWLnyvqNKEfb+Jt14flg0AsKqlbnNJkVx6+FXojBYOSSQcr7r6V1y
         uRFJC/Jhv0SVw/J2YibBjYzaF4TOX66NsSSlr0EA2BBbvk+eUl//PDfHZNIFk4zjrQql
         k9Ux2q3vSVs963ZF65F/AJj5dyN1xAO1OSMREGpo7ug+WpXSr5dRyMmlc43WV1chQvHl
         XnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2NYOBnGr3oC2HbawPc8n2japmW7gZ/2gS/4kyYGuoc=;
        b=Xt86yi0H2moyEltYnIAw+615dafwGUNa69o8eNlrD8z8H8mFJ/IWLj3Z/Fzyxrl565
         lxY0uNF3oBDf4AQVvn5H0I/LTlUU8SkkKwBy8dyV781Wc0L1NMnxS2vOw1Sdx7Tyjt37
         682Wgut6ZYl0M567RfqIGwBFn3wZzs9raatw0ACdb4allyUO5nO3gNqyvxkAmamBgiL/
         QlghGKEKuPDeNEETYbmTxuazz1Gi4AOvnMfTmQ6qSrvPCFGjciBCYUU3L8Sj562PtPpQ
         7m7L99arMuQEht0qNWWVEgKvtdWl9MSB06im7hmghZ99f4pixHUcxIx1AZWYM1TtPJHM
         9D3A==
X-Gm-Message-State: AOAM533yl8nGA4fJ4Z2FjU4GOwzzmB92K9vOr7J8ZPpFbzTFVRqfRHDc
        Qe5ZVbXt+Di20ILy8utxZ6fny8zvFQM4wp+vPC+FmA==
X-Google-Smtp-Source: ABdhPJz7iKHIfKSmPqUxBSS1zpgdNd/jPtkOnn1arMXMwo1S/LhMZERgYbKqPV4gUn9Z2MyH46ri3/R5PmPGFP3UUhU=
X-Received: by 2002:a0d:d80e:0:b0:2f8:39d8:1e8c with SMTP id
 a14-20020a0dd80e000000b002f839d81e8cmr17144278ywe.97.1652145273523; Mon, 09
 May 2022 18:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
In-Reply-To: <20220505122331.42696-1-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 9 May 2022 18:14:22 -0700
Message-ID: <CABk29Ns3KBwLXBSwiSe7Pv2YE9iMg+A1kPpPESWG=KNJu9dz0w@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

Overall this looks good, just a couple of comments.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..79b4ff24faee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6323,7 +6323,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       struct sched_domain_shared *sds = sd->shared;
> +       int nr, nro, weight = sd->span_weight;
> +       int i, cpu, idle_cpu = -1;
>         struct rq *this_rq = this_rq();
>         int this = smp_processor_id();
>         struct sched_domain *this_sd;
> @@ -6333,7 +6335,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>         if (!this_sd)
>                 return -1;
>
> +       nro = atomic_read(&sds->nr_overloaded_cpus);
> +       if (nro == weight)
> +               goto out;

This assumes that the sd we're operating on here is the LLC domain
(true for current use). Perhaps to catch future bugs from changing
this assumption, we could WARN_ON_ONCE(nro > weight).

> +
> +       nr = min_t(int, weight, p->nr_cpus_allowed);
> +
> +       /*
> +        * It's unlikely to find an idle cpu if the system is under
> +        * heavy pressure, so skip searching to save a few cycles
> +        * and relieve cache traffic.
> +        */
> +       if (weight - nro < (nr >> 4) && !has_idle_core)
> +               return -1;

nit: nr / 16 is easier to read and the compiler will do the shifting for you.

Was < intentional vs <= ? With <= you'll be able to skip the search in
the case where both sides evaluate to 0 (can happen frequently if we
have no idle cpus, and a task with a small affinity mask).

This will also get a bit confused in the case where the task has many
cpus allowed, but almost all of them on a different LLC than the one
we're considering here. Apart from caching the per-LLC
nr_cpus_allowed, we could instead use cpumask_weight(cpus) below (and
only do this in the !has_idle_core case to reduce calls to
cpumask_weight()).

> +
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +       if (nro > 1)
> +               cpumask_andnot(cpus, cpus, sdo_mask(sds));

Just
if (nro)
?

> @@ -6392,6 +6407,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>
>                 update_avg(&this_sd->avg_scan_cost, time);
>         }
> +out:
> +       if (has_idle_core)
> +               WRITE_ONCE(sds->has_idle_cores, 0);

nit: use set_idle_cores() instead (or, if you really want to avoid the
extra sds dereference, add a __set_idle_cores(sds, val) helper you can
call directly.

> @@ -7904,6 +7922,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>                         continue;
>
>                 detach_task(p, env);
> +               update_overloaded_rq(env->src_rq);
>
>                 /*
>                  * Right now, this is only the second place where
> @@ -8047,6 +8066,9 @@ static int detach_tasks(struct lb_env *env)
>                 list_move(&p->se.group_node, tasks);
>         }
>
> +       if (detached)
> +               update_overloaded_rq(env->src_rq);
> +

Thinking about this more, I don't see an issue with moving the
update_overloaded_rq() calls to enqueue/dequeue_task, rather than here
in the attach/detach_task paths. Overloaded state only changes when we
pass the boundary of 2 runnable non-idle tasks, so thashing of the
overloaded mask is a lot less worrisome than if it were updated on the
boundary of 1 runnable task. The attach/detach_task paths run as part
of load balancing, which can be on a millisecond time scale.

Best,
Josh
