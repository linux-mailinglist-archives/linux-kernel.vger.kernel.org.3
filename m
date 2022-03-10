Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380514D49B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiCJOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiCJOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:20:22 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B3BB0EBB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:19:04 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r22so7928891ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDYXikHKqFlF94KnO5rDiWtODYAnzjwHId0R70vi1jM=;
        b=dqyJ3CQOVvRG4hrP0mGB+d8swsuXFoaBzWx0AExwYejli9Gxx9KAnmt+oRQSj9/1HU
         jOplsxVpUumnnubaD1q2k0raGxbji3UYBWp7LYzabOmPNXrT63yzgaWp+xqHBeFAW2yv
         lAhqx1Hk1CNBPegCdt8T0NmID2VRRzYKWsio4knXWlWnEZmEhZAYygC3XF87SXuIO46W
         h2eeDIZTB2pgEqFURFbTBKLKMgsN2wtUyO9ZvM/Ov+VrAx0zbAF1uXUYp1GnxoKDtT84
         0yJ1ra5ezM8IszqHpy+VygDFYmcf8VP0ItTr/Sob9Xdymhmp2tjrdwAFPzxOamBW0BIO
         fwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDYXikHKqFlF94KnO5rDiWtODYAnzjwHId0R70vi1jM=;
        b=zwaTZKOygb53Cusr4P1IvSVSCkLcO5sNdsNHCYM4kQfc2oK0qS3o9iTjTsERsxpQ2E
         TwXwnx5/CeiNcHJR3mpHRlOxuwtRNPSbkIRFVGuSKMCuE7/4zbXKsq1EMvdPyocLfyg2
         QHJ0nr7iJYU4RauPlBY6U33y1ckD11SIPhjjAT19NciYq7ExFkobN3xcaEI/heiQyvn9
         qis5/ju+mvIfv6gf4+5nlyfsIc9nWwVN4syLcdc4lN2SEtGq9ESYrMfBh7YtiUYjaYxs
         hXlb+bgM/+x3IAU8aCSA3l05HMXJGWqMkM2RM0896NqdQN6b31N9/8RxRFAbL2IB+3fp
         2l9w==
X-Gm-Message-State: AOAM531bo4TqFsTmwL13iWZVwfxzplFF1FeMz1mzSnDghw5HbTLe6AAQ
        OUP+h40pR6cWMOnoPsM7EDigUirQ9sUvj5mWA1rHDg==
X-Google-Smtp-Source: ABdhPJzPTT0tqgV8rgbvufilNPyaVdH69jSBXKBfvuyIRM6JY4cwfsXhyQhEYF/GFji2VVo1rmO/1tWc4BmtI6JYt9c=
X-Received: by 2002:a05:651c:990:b0:240:752f:a224 with SMTP id
 b16-20020a05651c099000b00240752fa224mr3123201ljq.266.1646921942361; Thu, 10
 Mar 2022 06:19:02 -0800 (PST)
MIME-Version: 1.0
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Mar 2022 15:18:51 +0100
Message-ID: <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu topology
To:     Qing Wang <wangqing@vivo.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> Some architectures(e.g. ARM64), caches are implemented below:
> cluster:              ****** cluster 0 *****      ****** cluster 1 *****
> core:                 0      1      2      3      4      5      6      7
> cache(Leveln):        **cache0**   **cache1**    **cache2**   **cache3**
> sd_llc_id(current):   0      0      0      0      4      4      4      4
> sd_llc_id(should be): 0      0      2      2      4      4      6      6
>
> Caches and cpus have different topology, this causes cpus_share_cache()
> return the wrong value, which will affect the CPU load balance.

What does your current scheduler topology  look like?

For CPU 0 to 3, do you have the below ?
DIE [0     -     3] [4-7]
MC  [0] [1] [2] [3]

But you would like something like below for cpu 0-1 instead ?
DIE [0     -     3] [4-7]
CLS [0 - 1] [2 - 3]
MC  [0] [1]

with SD_SHARE_PKG_RESOURCES only set to MC level ?

>
> Cache topology should be separated with CPU topology, it can be obtained
> from "next-level-cache" in DTS preferentially.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  arch/arm64/kernel/smp.c       |  1 +
>  drivers/base/arch_topology.c  | 23 +++++++++++++++++++++++
>  include/linux/arch_topology.h |  3 +++
>  kernel/sched/topology.c       | 33 +++++++++++++++++++++++++++++++--
>  4 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 27df5c1..94cf649
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -723,6 +723,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>         unsigned int this_cpu;
>
>         init_cpu_topology();
> +       init_cpu_cache_topology();
>
>         this_cpu = smp_processor_id();
>         store_cpu_topology(this_cpu);
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 9761541..613213f
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -613,6 +613,7 @@ static int __init parse_dt_topology(void)
>   */
>  struct cpu_topology cpu_topology[NR_CPUS];
>  EXPORT_SYMBOL_GPL(cpu_topology);
> +struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVEL];

AFAICT, arch_topology.c is only used by arm/arm64 and riscv so this is
not initialized for other archs

>
>  const struct cpumask *cpu_coregroup_mask(int cpu)
>  {
> @@ -738,4 +739,26 @@ void __init init_cpu_topology(void)
>         else if (of_have_populated_dt() && parse_dt_topology())
>                 reset_cpu_topology();
>  }
> +
> +void __init init_cpu_cache_topology(void)
> +{
> +       struct device_node *node_cpu, *node_cache;
> +       int cpu, level;
> +
> +       for_each_possible_cpu(cpu) {
> +               node_cpu = of_get_cpu_node(cpu, NULL);
> +               if (!node_cpu)
> +                       continue;
> +
> +               level = 0;
> +               node_cache = node_cpu;
> +               while (level < MAX_CPU_CACHE_LEVEL) {
> +                       node_cache = of_parse_phandle(node_cache, "next-level-cache", 0);
> +                       if (!node_cache)
> +                               break;
> +                       cache_topology[cpu][level++] = node_cache;
> +               }
> +               of_node_put(node_cpu);
> +       }
> +}
>  #endif
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index cce6136b..d37f47d
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -72,6 +72,8 @@ struct cpu_topology {
>  };
>
>  #ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
> +#define MAX_CPU_CACHE_LEVEL 7
> +extern struct device_node *cache_topology[NR_CPUS][MAX_CPU_CACHE_LEVEL];
>  extern struct cpu_topology cpu_topology[NR_CPUS];
>
>  #define topology_physical_package_id(cpu)      (cpu_topology[cpu].package_id)
> @@ -82,6 +84,7 @@ extern struct cpu_topology cpu_topology[NR_CPUS];
>  #define topology_cluster_cpumask(cpu)  (&cpu_topology[cpu].cluster_sibling)
>  #define topology_llc_cpumask(cpu)      (&cpu_topology[cpu].llc_sibling)
>  void init_cpu_topology(void);
> +void init_cpu_cache_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
>  const struct cpumask *cpu_clustergroup_mask(int cpu);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a70..10850d6
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -650,6 +650,36 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
>
> +static void set_sd_llc(int cpu, struct sched_domain *sd, int *first_cpu, int *cpu_num)
> +{
> +       int cache_level, cpu_id;
> +       int first, last;
> +       int id = cpumask_first(sched_domain_span(sd));
> +       int size = cpumask_weight(sched_domain_span(sd));
> +
> +       *first_cpu = id;
> +       *cpu_num = size;
> +
> +       for (cache_level = 0; cache_level < MAX_CPU_CACHE_LEVEL; cache_level++) {
> +               if (!cache_topology[cpu][cache_level])
> +                       break;
> +
> +               first = -1;
> +               last = id;
> +               for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++) {
> +                       if (cache_topology[cpu][cache_level] == cache_topology[cpu_id][cache_level]) {
> +                               if (cpu_id >= id && cpu_id < id + size) {
> +                                       first = (first == -1)?cpu_id:first;
> +                                       last = cpu_id;
> +                               } else
> +                                       return;
> +                       }
> +               }
> +               *first_cpu = first;
> +               *cpu_num = last - first + 1;
> +       }
> +}
> +
>  static void update_top_cache_domain(int cpu)
>  {
>         struct sched_domain_shared *sds = NULL;
> @@ -659,8 +689,7 @@ static void update_top_cache_domain(int cpu)
>
>         sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>         if (sd) {
> -               id = cpumask_first(sched_domain_span(sd));
> -               size = cpumask_weight(sched_domain_span(sd));
> +               set_sd_llc(cpu, sd, &id, &size);

In scheduler, we look for the last level of SD_SHARE_PKG_RESOURCES to
find shared memory. It seems that cpu_coregroup_mask doesn't return
the correct cpumask in your case as it returns a full cluster instead
of a subset

>                 sds = sd->shared;

sds must  stay aligned with id and size so instead of modifying id and
size you should returns a cpumask that reflects your topology

>         }
>
> --
> 2.7.4
>
