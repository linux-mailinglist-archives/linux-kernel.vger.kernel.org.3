Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9D467328
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379164AbhLCITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbhLCISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:18:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BEC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:15:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so8100934edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPDVT/ANQEKJBsaPTPgsAUSD0Px0KN9AdsRG46TxiI4=;
        b=KLH8XGUAEUCr87ho50MNrhymIlU9gY+NTy6iBDaSByHPuObCxoq9bn/LlbnaYScPdQ
         Sd+SYfLJnZ441krcu6NSNZID9izvdG1ozDnu0zMoYgLCXSVmLlD0T9wchTzcNxUWYZ+6
         hUqH5kt/Wq/Pz0iWlWZezKtba5G7ff5qQtbyqv8gHpznyDFMkPdOW2ghAWXGBJabCnLF
         tIF8eXXTH+1Rxx/TskKW227bUHxQ9QR5YumbyIhNvTOSS76dMD9SPuxo289XRV6aIbbo
         DtSA2GR5ckpGvR/7GskkFX5C4vFahMGd3S8oMfchpKyAWcblF14d7tsusYHeTWhS3DdF
         45+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPDVT/ANQEKJBsaPTPgsAUSD0Px0KN9AdsRG46TxiI4=;
        b=vursdHwJrzUeZe7Yvu0hiaToE2l74kpDvOluBL5IVm5qQpnnG0cQwqb4XXExgq8xwi
         5xOR9L8AYnFTN7ummhe5qQY0uU5KuRBw0YjnBxlix/ztJy3QB7FSoxz2DVQdIehHTZkK
         bD2jW3VRqv2uRxVMFmqU17F5bEqn/RWiZ0TEinmYhw6cGG/dFDKXA65fggw0k2nYhCij
         numcDv7EwBUyGfa237IermJT7jjQ3eyoub4F3Fw4IOTyjNw2BefQ6c9xyYyMRDVDUspt
         f+UXnk/PUHY7uj48T7/Zge5Z5r/57Z45XGihl/c8MGFoIub7fTSSkYMM2jUgGVe2l397
         1Cnw==
X-Gm-Message-State: AOAM530vj3Oz+QzbVlgIMStexXiBhfm7dSGZjaVovpVplkzszpF3xsvu
        fJVTQsTuoPsjAZtD2V4stuWXCBaT962bNSneFns=
X-Google-Smtp-Source: ABdhPJxD9QMvB3/Ga2MLH8vvuz8kIFeUNs/M1YtqCS0djnwewYcBpwaAMFhNTUrNiOQtBYeRAVlG3r3U19qC3RaQKJY=
X-Received: by 2002:a05:6402:254b:: with SMTP id l11mr24866549edb.225.1638519327525;
 Fri, 03 Dec 2021 00:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20211201151844.20488-1-mgorman@techsingularity.net> <20211201151844.20488-3-mgorman@techsingularity.net>
In-Reply-To: <20211201151844.20488-3-mgorman@techsingularity.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 3 Dec 2021 21:15:15 +1300
Message-ID: <CAGsJ_4xuYH8d18r9f5vUGYjNxtZ31FZrNZepEh8QCZbLW+3a6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:27 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
>
> Zen* has multiple LLCs per node with local memory channels and due to
> the allowed imbalance, it's far harder to tune some workloads to run
> optimally than it is on hardware that has 1 LLC per node. This patch
> adjusts the imbalance on multi-LLC machines to allow an imbalance up to
> the point where LLCs should be balanced between nodes.
>
> On a Zen3 machine running STREAM parallelised with OMP to have on instance
> per LLC the results and without binding, the results are
>
>                             5.16.0-rc1             5.16.0-rc1
>                                vanilla     sched-numaimb-v3r1
> MB/sec copy-16    166712.18 (   0.00%)   587662.60 ( 252.50%)
> MB/sec scale-16   140109.66 (   0.00%)   393528.14 ( 180.87%)
> MB/sec add-16     160791.18 (   0.00%)   618622.00 ( 284.74%)
> MB/sec triad-16   160043.84 (   0.00%)   589188.40 ( 268.14%)
>
> STREAM can use directives to force the spread if the OpenMP is new
> enough but that doesn't help if an application uses threads and
> it's not known in advance how many threads will be created.
>
> Coremark is a CPU and cache intensive benchmark parallelised with
> threads. When running with 1 thread per instance, the vanilla kernel
> allows threads to contend on cache. With the patch;
>
>                                5.16.0-rc1             5.16.0-rc1
>                                   vanilla     sched-numaimb-v3r1
> Min       Score-16   367816.09 (   0.00%)   403429.15 (   9.68%)
> Hmean     Score-16   389627.78 (   0.00%)   451015.49 *  15.76%*
> Max       Score-16   416178.96 (   0.00%)   480012.00 (  15.34%)
> Stddev    Score-16    17361.82 (   0.00%)    32378.08 ( -86.49%)
> CoeffVar  Score-16        4.45 (   0.00%)        7.14 ( -60.57%)
>
> It can also make a big difference for semi-realistic workloads
> like specjbb which can execute arbitrary numbers of threads without
> advance knowledge of how they should be placed
>
>                                5.16.0-rc1             5.16.0-rc1
>                                   vanilla     sched-numaimb-v3r1
> Hmean     tput-1      73743.05 (   0.00%)    70258.27 *  -4.73%*
> Hmean     tput-8     563036.51 (   0.00%)   591187.39 (   5.00%)
> Hmean     tput-16   1016590.61 (   0.00%)  1032311.78 (   1.55%)
> Hmean     tput-24   1418558.41 (   0.00%)  1424005.80 (   0.38%)
> Hmean     tput-32   1608794.22 (   0.00%)  1907855.80 *  18.59%*
> Hmean     tput-40   1761338.13 (   0.00%)  2108162.23 *  19.69%*
> Hmean     tput-48   2290646.54 (   0.00%)  2214383.47 (  -3.33%)
> Hmean     tput-56   2463345.12 (   0.00%)  2780216.58 *  12.86%*
> Hmean     tput-64   2650213.53 (   0.00%)  2598196.66 (  -1.96%)
> Hmean     tput-72   2497253.28 (   0.00%)  2998882.47 *  20.09%*
> Hmean     tput-80   2820786.72 (   0.00%)  2951655.27 (   4.64%)
> Hmean     tput-88   2813541.68 (   0.00%)  3045450.86 *   8.24%*
> Hmean     tput-96   2604158.67 (   0.00%)  3035311.91 *  16.56%*
> Hmean     tput-104  2713810.62 (   0.00%)  2984270.04 (   9.97%)
> Hmean     tput-112  2558425.37 (   0.00%)  2894737.46 *  13.15%*
> Hmean     tput-120  2611434.93 (   0.00%)  2781661.01 (   6.52%)
> Hmean     tput-128  2706103.22 (   0.00%)  2811447.85 (   3.89%)
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 26 +++++++++++++++-----------
>  kernel/sched/topology.c        | 20 ++++++++++++++++++++
>  3 files changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index c07bfa2d80f2..54f5207154d3 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -93,6 +93,7 @@ struct sched_domain {
>         unsigned int busy_factor;       /* less balancing by factor if busy */
>         unsigned int imbalance_pct;     /* No balance until over watermark */
>         unsigned int cache_nice_tries;  /* Leave cache hot tasks for # tries */
> +       unsigned int imb_numa_nr;       /* Nr imbalanced tasks allowed between nodes */
>
>         int nohz_idle;                  /* NOHZ IDLE status */
>         int flags;                      /* See SD_* */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0a969affca76..64f211879e43 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1489,6 +1489,7 @@ struct task_numa_env {
>
>         int src_cpu, src_nid;
>         int dst_cpu, dst_nid;
> +       int imb_numa_nr;
>
>         struct numa_stats src_stats, dst_stats;
>
> @@ -1885,7 +1886,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>                 dst_running = env->dst_stats.nr_running + 1;
>                 imbalance = max(0, dst_running - src_running);
>                 imbalance = adjust_numa_imbalance(imbalance, dst_running,
> -                                                       env->dst_stats.weight);
> +                                                 env->imb_numa_nr);
>
>                 /* Use idle CPU if there is no imbalance */
>                 if (!imbalance) {
> @@ -1950,8 +1951,10 @@ static int task_numa_migrate(struct task_struct *p)
>          */
>         rcu_read_lock();
>         sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
> -       if (sd)
> +       if (sd) {
>                 env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
> +               env.imb_numa_nr = sd->imb_numa_nr;
> +       }
>         rcu_read_unlock();
>
>         /*
> @@ -9046,13 +9049,14 @@ static bool update_pick_idlest(struct sched_group *idlest,
>  }
>
>  /*
> - * Allow a NUMA imbalance if busy CPUs is less than 25% of the domain.
> - * This is an approximation as the number of running tasks may not be
> - * related to the number of busy CPUs due to sched_setaffinity.
> + * Allow a NUMA imbalance if busy CPUs is less than the allowed
> + * imbalance. This is an approximation as the number of running
> + * tasks may not be related to the number of busy CPUs due to
> + * sched_setaffinity.
>   */
> -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
>  {
> -       return (dst_running < (dst_weight >> 2));
> +       return dst_running < imb_numa_nr;
>  }
>
>  /*
> @@ -9191,7 +9195,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>                          * a real need of migration, periodic load balance will
>                          * take care of it.
>                          */
> -                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +                       if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->imb_numa_nr))
>                                 return NULL;
>                 }
>
> @@ -9283,9 +9287,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  #define NUMA_IMBALANCE_MIN 2
>
>  static inline long adjust_numa_imbalance(int imbalance,
> -                               int dst_running, int dst_weight)
> +                               int dst_running, int imb_numa_nr)
>  {
> -       if (!allow_numa_imbalance(dst_running, dst_weight))
> +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
>                 return imbalance;
>
>         /*
> @@ -9397,7 +9401,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>                 /* Consider allowing a small imbalance between NUMA groups */
>                 if (env->sd->flags & SD_NUMA) {
>                         env->imbalance = adjust_numa_imbalance(env->imbalance,
> -                               busiest->sum_nr_running, env->sd->span_weight);
> +                               busiest->sum_nr_running, env->sd->imb_numa_nr);
>                 }
>
>                 return;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..fee2930745ab 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2242,6 +2242,26 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>                 }
>         }
>
> +       /* Calculate allowed NUMA imbalance */
> +       for_each_cpu(i, cpu_map) {
> +               int imb_numa_nr = 0;
> +
> +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +                       struct sched_domain *child = sd->child;
> +
> +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +                               int nr_groups;
> +
> +                               nr_groups = sd->span_weight / child->span_weight;
> +                               imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> +                                               (nr_groups * num_online_nodes()));

Hi Mel, you used to have 25% * numa_weight if node has only one LLC.
for a system with 4 numa,  In case sd has 2 nodes, child is 1 numa node,
then  nr_groups=2, num_online_nodes()=4,  imb_numa_nr will be
child->span_weight/2/2/4?

Does this patch change the behaviour for machines whose numa equals LLC?

> +                       }
> +
> +                       sd->imb_numa_nr = imb_numa_nr;
> +               }
> +       }
> +
>         /* Calculate CPU capacity for physical packages and nodes */
>         for (i = nr_cpumask_bits-1; i >= 0; i--) {
>                 if (!cpumask_test_cpu(i, cpu_map))
> --
> 2.31.1
>

Thanks
Barry
