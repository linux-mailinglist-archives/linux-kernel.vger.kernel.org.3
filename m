Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD3557B7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiGTN4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:56:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1375828E04
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:56:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 6so32210743ybc.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74sS3r2yrug0ScpBy8v0d33GcxnZS6cVwGMVPpd8Nkw=;
        b=lZg+sJm9mzdr/Ghn7doKdM/OikBxhtKyQ1rJBDpZ60LIslmP9FVK3MNRd/ZUGnlv2h
         eqUGjRZ3m3FSMrMJrqB6McNmspWDw60WfBMb8gYmyZjVm7FQ5pmfFERQ5+1xipL7dQRp
         C/vxNGYjhUKGFtYJbamPlV+6e5jSbtZVKNefX9DjV1y9v1twlGwavvKNE5HxtVfWgn3+
         5Tzq9OnzwNLB8q7ZflfIdt+oupkn74MlGQDDtKLIN1ZUdJcZiHR6+ro1+zAo32JpUyMg
         QBQh1A6NObCKQLwCsHE10Aj35CeAWa5bGDc/AcsiZ1tD3FwHXFowhnT5VErdoAk4KE4y
         WpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74sS3r2yrug0ScpBy8v0d33GcxnZS6cVwGMVPpd8Nkw=;
        b=eLlR335uupkHNFw1RAu0JiCVdICtpc+S+e3mg9QIQ+u7CBVYpdvMIetE0QpnOrF3yM
         xNIcSm4HPvY46DTo3/aPVch4JKRclnDZIKpxBbDq9QndWrjACDUuSlmHmW5aUhRdEIZ3
         Vkm/DdOvQjm3ZSsEu2Jh6EeFutrAl3wBXPbVV5XEa0oDYnXUFBoFwo5E/CIA1/YLKyBd
         6whauBJATe9mRsxJ1JsOeD61HLM13AWe81fVleDrxLcS9Km1m1x+lXwlfEEKGi9xUu1p
         H5xdGSlieZ1xrCOF/DJa7aHqrwnlXa3Ex89mzp/H18RvztHOfw7X6URSAm0kG11KUXTq
         rNIg==
X-Gm-Message-State: AJIora8nlSdMcYyMElvywc/HadVKQR05WbLDe0TkWYX7YLvPUIh7WqUy
        ONsA5dlT2ax5/HTuN1eZsQmO/ATklNjjXWKqBVvi+w==
X-Google-Smtp-Source: AGRyM1s4rPgL16TTnaXFzD6X8/myc/fZcVZ02EDK1/6lhhAvYDHH/E23smJuqnlQNXBsrwA7HkIkUMRwphK7euGW3bM=
X-Received: by 2002:a25:9208:0:b0:66e:b73f:cdf4 with SMTP id
 b8-20020a259208000000b0066eb73fcdf4mr36283538ybo.300.1658325410222; Wed, 20
 Jul 2022 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220720081150.22167-1-yangyicong@hisilicon.com> <20220720081150.22167-2-yangyicong@hisilicon.com>
In-Reply-To: <20220720081150.22167-2-yangyicong@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jul 2022 15:56:38 +0200
Message-ID: <CAKfTPtAJrKUXxeU3yZHmiuNPcSL9=QCERCu-xpOQKf==+EWt9g@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_lowest_cache API
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        tim.c.chen@linux.intel.com, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 at 10:14, Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> From: Barry Song <song.bao.hua@hisilicon.com>
>
> Add per-cpu cluster domain info and cpus_share_lowest_cache() API.
> This is the preparation for the optimization of select_idle_cpu()
> on platforms with cluster scheduler level.

Don't know why but your patchset ended up in my spam. Peterz
resurected it by replying to patch 2

>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  include/linux/sched/sd_flags.h |  7 +++++++
>  include/linux/sched/topology.h |  8 +++++++-
>  kernel/sched/core.c            | 12 ++++++++++++
>  kernel/sched/sched.h           |  2 ++
>  kernel/sched/topology.c        | 15 +++++++++++++++
>  5 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> index 57bde66d95f7..42ed454e8b18 100644
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -109,6 +109,13 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>   */
>  SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>
> +/*
> + * Domain members share CPU cluster (LLC tags or L2 cache)
> + *
> + * NEEDS_GROUPS: Clusters are shared between groups.
> + */
> +SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
> +
>  /*
>   * Domain members share CPU package resources (i.e. caches)
>   *
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 816df6cc444e..c0d21667ddf3 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
>  #ifdef CONFIG_SCHED_CLUSTER
>  static inline int cpu_cluster_flags(void)
>  {
> -       return SD_SHARE_PKG_RESOURCES;
> +       return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;
>  }
>  #endif
>
> @@ -179,6 +179,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>
>  bool cpus_share_cache(int this_cpu, int that_cpu);
> +bool cpus_share_lowest_cache(int this_cpu, int that_cpu);
>
>  typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
>  typedef int (*sched_domain_flags_f)(void);
> @@ -232,6 +233,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
>         return true;
>  }
>
> +static inline bool cpus_share_lowest_cache(int this_cpu, int that_cpu)
> +{
> +       return true;
> +}
> +
>  #endif /* !CONFIG_SMP */
>
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a463dbc92fcd..96109ad82694 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3802,6 +3802,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
>         return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
>  }
>
> +/*
> + * Whether CPUs are share lowest cache, which means LLC on non-cluster
> + * machines and LLC tag or L2 on machines with clusters.
> + */
> +bool cpus_share_lowest_cache(int this_cpu, int that_cpu)
> +{
> +       if (this_cpu == that_cpu)
> +               return true;
> +
> +       return per_cpu(sd_lowest_cache_id, this_cpu) == per_cpu(sd_lowest_cache_id, that_cpu);
> +}
> +
>  static inline bool ttwu_queue_cond(int cpu)
>  {
>         /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 73ae32898f25..845cd029d572 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1802,7 +1802,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_lowest_cache_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8739c2a5a54e..8ab27c0d6d1f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_lowest_cache_id);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -689,6 +691,18 @@ static void update_top_cache_domain(int cpu)
>         per_cpu(sd_llc_id, cpu) = id;
>         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>
> +       sd = lowest_flag_domain(cpu, SD_CLUSTER);
> +       if (sd)
> +               id = cpumask_first(sched_domain_span(sd));
> +       rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
> +
> +       /*
> +        * This assignment should be placed after the sd_llc_id as
> +        * we want this id equals to cluster id on cluster machines
> +        * but equals to LLC id on non-Cluster machines.
> +        */
> +       per_cpu(sd_lowest_cache_id, cpu) = id;
> +
>         sd = lowest_flag_domain(cpu, SD_NUMA);
>         rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>
> @@ -1532,6 +1546,7 @@ static struct cpumask             ***sched_domains_numa_masks;
>   */
>  #define TOPOLOGY_SD_FLAGS              \
>         (SD_SHARE_CPUCAPACITY   |       \
> +        SD_CLUSTER             |       \
>          SD_SHARE_PKG_RESOURCES |       \
>          SD_NUMA                |       \
>          SD_ASYM_PACKING)
> --
> 2.24.0
>
