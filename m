Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4147D304
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhLVN1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhLVN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:27:07 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B148C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:27:07 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k21so5492475lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQ7tMr63fuQFUw3nrl6Qd3JZBshTnNEv8YMFOgrEsos=;
        b=qIYA4eF4X7C6ahm+zNKO8xR/Eld1OmsjejauC7ihxOrR4uvOsbNxzuNoJm2RoWEP8r
         ki4V7fl4FvMAUVu3nw6xuno3FjRsk1GZ17+zNF9OBfMcq7iAclemRnPV+z/s7L93Wyp5
         03rVbXuDkUwWwbMmK1HJ/903ii9QaNyUTMOAe8al5eMIflyMdlneWtkLTGd1XrZ1Hfy7
         5d7VB8Hx5lu3UcgA7hdd8SbwSU7RHtT3fOScq510pQqanwzdcF4miJZlhqvBm7kYVwqD
         d/oNuzMzRBeVqsO87F9q7ibAxFG8jbDujWFqNx6QXUCuR1CXiNA+ECftjU2j1ukapbsL
         Yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQ7tMr63fuQFUw3nrl6Qd3JZBshTnNEv8YMFOgrEsos=;
        b=oXEnrH+7qu78rBR5UgJykEToZnZGZ1pZ1uI482WTm9jSIou/n4HKbagLK2P68ImaIl
         JplT+8o3eeVt7La07jhN1F7F4ngTzxGDEzjcv//Ou4oLAc3qBULjdUR1zEvOIrXSXDxC
         pFcGxf118Y/L9ZdanxIcHcDDHq6XVA1dGc6+4kqeI9O4+cNrMozmFrdPn8u/rEwHwweV
         ytTh7BQ2oXN/5z4v0oFVYeQXtys38/5JGuageVF7o7prYygmgwm4DRQOtgSZ43thWpuC
         JYrYdc0N3xDQ43fMPAz3MGKsLBQ6X19U7go/1vug+w4H7AcIT10w52Sy0l5HrWels5yA
         JCRA==
X-Gm-Message-State: AOAM532od46+ycF9+7B5zMq2U1IKMoKZ7GZ7hN39NxWdL6M5+GeatkeO
        enlJSfkuqeY1J+44KkaTzrv9XYVNY1/SOPNofMz7Xg==
X-Google-Smtp-Source: ABdhPJwEaW8uEVQq1KEusioKQHGYN11sW5AcdBoXkaUIAImoaF6MeLSpXs1Isc5cVAonEWhKN4WAEHBlRSH7q/MgDLE=
X-Received: by 2002:ac2:596d:: with SMTP id h13mr2438170lfp.18.1640179625239;
 Wed, 22 Dec 2021 05:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20211215041149.73171-1-yangyicong@hisilicon.com> <20211215041149.73171-3-yangyicong@hisilicon.com>
In-Reply-To: <20211215041149.73171-3-yangyicong@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Dec 2021 14:26:53 +0100
Message-ID: <CAKfTPtDVJ1t9dp133A2eouPBRZM8Cgcsf1G+PMAWyFAVwtsyUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        prime.zeng@huawei.com, jonathan.cameron@huawei.com,
        ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxarm@huawei.com, 21cnbao@gmail.com, song.bao.hua@hisilicon.com,
        guodong.xu@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 05:11, Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
> For platforms having clusters like Kunpeng920, CPUs within the same
> cluster have lower latency when synchronizing and accessing shared
> resources like cache. Thus, this patch tries to find an idle cpu
> within the cluster of the target CPU before scanning the whole LLC
> to gain lower latency.
>
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so this
> patch doesn't consider SMT for this moment.
>
> Testing has been done on Kunpeng920 by pinning tasks to one numa
> and two numa. Each numa has 8 clusters and each cluster has 4 CPUs.
>
> With this patch, We noticed enhancement on tbench within one
> numa or cross two numa.
>
> On numa 0:
>                            5.16-rc1                patched
> Hmean     1        329.17 (   0.00%)      384.84 *  16.91%*
> Hmean     2        654.09 (   0.00%)      768.77 *  17.53%*
> Hmean     4       1321.41 (   0.00%)     1538.10 *  16.40%*
> Hmean     8       2650.43 (   0.00%)     3048.86 *  15.03%*
> Hmean     16      5322.37 (   0.00%)     5975.20 *  12.27%*
> Hmean     32     10002.11 (   0.00%)    10085.57 *   0.83%*
> Hmean     64      7910.39 (   0.00%)     7936.37 *   0.33%*
> Hmean     128     6745.25 (   0.00%)     6811.28 *   0.98%*
>
> On numa 0-1:
>                            5.16-rc1                patched
> Hmean     1        326.61 (   0.00%)      385.36 *  17.99%*
> Hmean     2        650.62 (   0.00%)      770.57 *  18.44%*
> Hmean     4       1318.05 (   0.00%)     1534.83 *  16.45%*
> Hmean     8       2621.50 (   0.00%)     3030.10 *  15.59%*
> Hmean     16      5252.17 (   0.00%)     6023.08 *  14.68%*
> Hmean     32      9829.30 (   0.00%)     9856.33 *   0.28%*
> Hmean     64     12452.66 (   0.00%)    17338.48 *  39.24%*
> Hmean     128    14181.24 (   0.00%)    15025.24 *   5.95%*
> Hmean     256    12239.07 (   0.00%)    13080.16 *   6.87%*
> Hmean     512    14297.00 (   0.00%)    15063.76 *   5.36%*
>
> This will also help to improve the MySQL. With MySQL server
> running on numa 0 and client running on numa 1, both QPS and
> latency is imporved on read-write case:
>                       5.16-rc1              patched
> QPS-24threads        195327.48    202081.28(+3.46%)
> QPS-32threads         242039.4     247059.5(+2.07%)
> QPS-64threads        243024.52    254274.47(+4.63%)
> avg-lat-24threads         2.46         2.37(+3.66%)
> avg-lat-36threads         2.64         2.59(+1.89%)
> avg-lat-64threads         5.27         5.03(+4.55%)
>
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  kernel/sched/fair.c | 46 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6d9435..8a5795c78af8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6230,12 +6230,46 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>
>  #endif /* CONFIG_SCHED_SMT */
>
> +#ifdef CONFIG_SCHED_CLUSTER
> +/*
> + * Scan the cluster domain for idle CPUs and clear cluster cpumask after scanning
> + */
> +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> +{
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +       struct sched_domain *sd = rcu_dereference(per_cpu(sd_cluster, target));
> +       int cpu, idle_cpu;
> +
> +       /* TODO: Support SMT case while a machine with both cluster and SMT born */
> +       if (!sched_smt_active() && sd) {
> +               for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> +                       idle_cpu = __select_idle_cpu(cpu, p);
> +                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                               return idle_cpu;
> +               }
> +
> +               /* Don't ping-pong tasks in and out cluster frequently */
> +               if (cpus_share_cluster(target, prev_cpu))
> +                       return target;
> +
> +               cpumask_andnot(cpus, cpus, sched_domain_span(sd));
> +       }
> +
> +       return -1;
> +}
> +#else
> +static inline int scan_cluster(struct task_struct *p, int prev_cpu, int target)
> +{
> +       return -1;
> +}
> +#endif
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int prev_cpu, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> @@ -6250,6 +6284,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> +       idle_cpu = scan_cluster(p, prev_cpu, target);

Why don't you do the above before calling select_idle_cpu() like for smt ?

> +       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +               return idle_cpu;
> +
>         if (sched_feat(SIS_PROP) && !has_idle_core) {
>                 u64 avg_cost, avg_idle, span_avg;
>                 unsigned long now = jiffies;
> @@ -6384,7 +6422,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         /*
>          * If the previous CPU is cache affine and idle, don't be stupid:
>          */
> -       if (prev != target && cpus_share_cache(prev, target) &&
> +       if (prev != target && cpus_share_cluster(prev, target) &&

This is misleading because cpus_share_cluster is meaningless for most of system

Then, you don't care at all of the llc if there is a cluster domain ?


>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>             asym_fits_capacity(task_util, prev))
>                 return prev;
> @@ -6408,7 +6446,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         p->recent_used_cpu = prev;
>         if (recent_used_cpu != prev &&
>             recent_used_cpu != target &&
> -           cpus_share_cache(recent_used_cpu, target) &&
> +           cpus_share_cluster(recent_used_cpu, target) &&
>             (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>             cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
>             asym_fits_capacity(task_util, recent_used_cpu)) {
> @@ -6449,7 +6487,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>                 }
>         }
>
> -       i = select_idle_cpu(p, sd, has_idle_core, target);
> +       i = select_idle_cpu(p, sd, has_idle_core, prev, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> --
> 2.33.0
>
