Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A201957C7CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiGUJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGUJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:38:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF26E81486
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:38:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id va17so2237484ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAZWU33orbHeHIStde3dcIlB5xF7x69+MW7F963Xg58=;
        b=MocSGDlRWD/ILVWtOVsCglOvbDP32GRDK3+M6Oqx9T/dfeyBn9HJQeMMceUdBVRBQD
         7uDIWK0ql3c+N7HHas7imSlPwiaAfvtGXk8k56TGRF3sdO5KtEy/34cis5NjaZOj5gSa
         9auWXgQ8DWOazzskpBfBcFilxf/W2qVOSHbbJi1EQHGvGAKBpbA9pYVGhv3iZg7VxhYy
         f8+6ZFkD+AM8jWmOaZ+594p4UfP+AWJobUDfFdP1FKT76imqGVMdFKdjgJqIHv0c8/1I
         +zo0u5zeDL3+tTlYrT1CYOti2r5SAtcBsnn6ztBwgQZEwZJp8FbMe1+ELsR0SWzl5uNz
         iKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAZWU33orbHeHIStde3dcIlB5xF7x69+MW7F963Xg58=;
        b=OEuhr45KyiCRyePeSFIFjaZzDTMoCFLXJZeu5bPmTs0gMhoY/9OSnSdz7YvchCFwLq
         k9D3Q+BANF4sPwWHv0rBjiXgr1Pchu0o0XW9oWIAL0VgpzKIiMSzS70koFeO07BHtgB8
         jN0ocv63QFPaph07H5clSXrKkGat/u8ijzKOlzR0kesVhbpwY/v4/AVweyvmp57Rzm2K
         w35kUsOVCa1BTwpMIqnpsmB3vXbHix3Dbd5zl+boyc0s9cRd62syeYnUexEE1B21+L1T
         Uz5x8S+Ie5AWtAuD/1ezQP1VT44QTDMmHY4G4faeIO0sBzA6VuYd8YlVE+vFzY4Rx/wm
         XWTg==
X-Gm-Message-State: AJIora/1Ex5wXVbmmOlxyYdbfov3XxVyEr6aOdFds2cm934TOiGaW/cs
        fy9Fl8tF1xJJlJj+4EvyKITTJXOk6q5ZQbfPEoA=
X-Google-Smtp-Source: AGRyM1sZIRbdvISy7tib+rrJmOmxzgskaHrj5sBaI0v8NkrnxrhRrh9Cl0csScrxBaDkCNGWti2OlsuonEt5zZGZBUw=
X-Received: by 2002:a17:906:8a45:b0:72b:31d4:d537 with SMTP id
 gx5-20020a1709068a4500b0072b31d4d537mr40654981ejc.170.1658396296195; Thu, 21
 Jul 2022 02:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
 <20220720081150.22167-3-yangyicong@hisilicon.com> <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
In-Reply-To: <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 21 Jul 2022 21:38:04 +1200
Message-ID: <CAGsJ_4yrZnPbhBb4wd3x1h994tv6Jfri+y2xrPSJv7yF+Mj7tg@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 2/2] sched/fair: Scan cluster before scanning
 LLC in wake-up path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Guodong Xu <guodong.xu@linaro.org>, hesham.almatary@huawei.com,
        john.garry@huawei.com, Yang Shen <shenyang39@huawei.com>,
        kprateek.nayak@amd.com, Chen Yu <yu.c.chen@intel.com>,
        wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 20, 2022 at 04:11:50PM +0800, Yicong Yang wrote:
> > +     /* TODO: Support SMT system with cluster topology */
> > +     if (!sched_smt_active() && sd) {
> > +             for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
>
> So that's no SMT and no wrap iteration..
>
> Does something like this work?
>
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_s
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
> +           static_branch_unlikely(&sched_cluster_active)) {
> +               struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> +               if (sdc) {
> +                       for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> +                               if (!cpumask_test_cpu(cpu, cpus))
> +                                       continue;
> +
> +                               if (has_idle_core) {
> +                                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +                                       if ((unsigned int)i < nr_cpumask_bits)
> +                                               return i;
> +                               } else {
> +                                       if (--nr <= 0)
> +                                               return -1;
> +                                       idle_cpu = __select_idle_cpu(cpu, p);
> +                                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                                               break;

Guess here it should be "return idle_cpu", but not "break". as "break"
will make us scan more
other cpus outside the cluster if we have found idle_cpu within the cluster.

Yicong,
Please test Peter's code with the above change.


> +                               }
> +                       }
> +                       cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> +               }
> +       }
> +
>         for_each_cpu_wrap(cpu, cpus, target + 1) {
>                 if (has_idle_core) {
>                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
> @@ -6444,7 +6468,7 @@ static int select_idle_cpu(struct task_s
>                                 return i;
>
>                 } else {
> -                       if (!--nr)
> +                       if (--nr <= 0)
>                                 return -1;
>                         idle_cpu = __select_idle_cpu(cpu, p);
>                         if ((unsigned int)idle_cpu < nr_cpumask_bits)
> @@ -6543,7 +6567,7 @@ static int select_idle_sibling(struct ta
>         /*
>          * If the previous CPU is cache affine and idle, don't be stupid:
>          */
> -       if (prev != target && cpus_share_cache(prev, target) &&
> +       if (prev != target && cpus_share_lowest_cache(prev, target) &&
>             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>             asym_fits_capacity(task_util, prev))
>                 return prev;
> @@ -6569,7 +6593,7 @@ static int select_idle_sibling(struct ta
>         p->recent_used_cpu = prev;
>         if (recent_used_cpu != prev &&
>             recent_used_cpu != target &&
> -           cpus_share_cache(recent_used_cpu, target) &&
> +           cpus_share_lowest_cache(recent_used_cpu, target) &&
>             (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
>             cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
>             asym_fits_capacity(task_util, recent_used_cpu)) {
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1813,7 +1813,9 @@ DECLARE_PER_CPU(struct sched_domain __rc
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> +
>  extern struct static_key_false sched_asym_cpucapacity;
> +extern struct static_key_false sched_cluster_active;
>
>  struct sched_group_capacity {
>         atomic_t                ref;
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -670,7 +670,9 @@ DEFINE_PER_CPU(struct sched_domain_share
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> +
>  DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
> +DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
>
>  static void update_top_cache_domain(int cpu)
>  {
> @@ -2268,6 +2270,7 @@ build_sched_domains(const struct cpumask
>         struct rq *rq = NULL;
>         int i, ret = -ENOMEM;
>         bool has_asym = false;
> +       bool has_cluster = false;
>
>         if (WARN_ON(cpumask_empty(cpu_map)))
>                 goto error;
> @@ -2289,6 +2292,7 @@ build_sched_domains(const struct cpumask
>                         sd = build_sched_domain(tl, cpu_map, attr, sd, i);
>
>                         has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
> +                       has_cluster |= sd->flags & SD_CLUSTER;
>
>                         if (tl == sched_domain_topology)
>                                 *per_cpu_ptr(d.sd, i) = sd;
> @@ -2399,6 +2403,9 @@ build_sched_domains(const struct cpumask
>         if (has_asym)
>                 static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
>
> +       if (has_cluster)
> +               static_branch_inc_cpuslocked(&sched_cluster_active);
> +
>         if (rq && sched_debug_verbose) {
>                 pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
>                         cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
> @@ -2498,6 +2505,9 @@ static void detach_destroy_domains(const
>         if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, cpu)))
>                 static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
>
> +       if (rcu_access_pointer(per_cpu(sd_cluster, cpu)))
> +               static_branch_dec_cpuslocked(&sched_cluster_active);
> +
>         rcu_read_lock();
>         for_each_cpu(i, cpu_map)
>                 cpu_attach_domain(NULL, &def_root_domain, i);

Thanks
Barry
