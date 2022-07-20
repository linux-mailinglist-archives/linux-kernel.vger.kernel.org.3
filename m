Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFC57B596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiGTLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGTLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:33:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014B54073
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:33:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so23364852edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fD8LgurJxdK+UcqKpCwMPCJ39XSKzZGGJ6W3J6d2Uw=;
        b=DcAvk0adb/ay4ZwwCp7425XzxTodiWA+VamTR89Sychuy8NOpopLBgIXn9aPExSN/+
         037GWHF9POxm1TRVG+iKhIEjv5h9u6uKtq4PDgwrDA6eaP3AOpPyDYNAf37C04PxNfrC
         WntPCWu2ZIjk7f3otZUJ+5GzVCR21NZDt8M22fS6bzJu3wUjmyPztdQ/8i8Vqxt9AmYE
         YE08/qiBp+sG9qoUMnbTBYRNebdaDp38LzzItEdGn50yYFiHi08RlqCi/GG2kR4IXqdI
         jJBD92JUxh3NVNidKQxb2SprP4o4SfqLy6GxFE8RSImA4KFmUE7aZY6pBbeDPZrfiuhe
         Vznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fD8LgurJxdK+UcqKpCwMPCJ39XSKzZGGJ6W3J6d2Uw=;
        b=4b/FVMIBNP/YEIlKczpPfKY4hza4F8iRiwIqGZBWwjMJMSsaDHatlgfTHxYjkwiaE7
         vRhSY6HipJsvmil31GMf2M8XfBPYaLtgJ1ncv2sEGnxVkmxBbNpH2cLzgG3JcO6W3KBM
         JNbw9OLaiKL0nTobtADWIUIAOL5S/KfhLYVYV0HYKz9NdagCyXDYzb94VagcBAYdBC/8
         0tcICc9T9IaMEKht1Ohg+m3ZuyEpUBkKltP4Y2ptCV1Ln5XenUVClUSqR42mppvxJsjL
         /mjHO8C1D/ShfZ7l9GuTX+3tBeWyh42QILlgkPVboLdbqzpm9ynMiVh1JqB/MGlNDLo0
         DPng==
X-Gm-Message-State: AJIora+CAG70J8DDZYGk7s7UzsuG17H+Yn2HJNYjcY3kJdDd9/b3zSEu
        fEVdyA4WyE2V1bcOD0yvT7PyTQLsYcJ1fExWkuE=
X-Google-Smtp-Source: AGRyM1vVXtjBitXZUK1MbDV7mD7SHlHTj1pC/VCVFEN1+d1+yaTKqYLj64VlsDjiJEjzlurzKtkMGV7Ypzy8CD2EcXQ=
X-Received: by 2002:a05:6402:686:b0:43b:b985:68d5 with SMTP id
 f6-20020a056402068600b0043bb98568d5mr2197118edy.129.1658316830912; Wed, 20
 Jul 2022 04:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220720081150.22167-1-yangyicong@hisilicon.com>
 <20220720081150.22167-3-yangyicong@hisilicon.com> <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
In-Reply-To: <Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 20 Jul 2022 23:33:39 +1200
Message-ID: <CAGsJ_4zyXLxPqd+WrWVF1fYan=dtacG6DqYbpFSNPGkESXbxtA@mail.gmail.com>
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

I guess it is ok. The main reason for me to disable smt from the first beginning
is that we don't really have a machine with both cluster and smt to
reach the code
for smt, aka has_idle_core=true. so I thought I was going to bring up
that branch
when I really have a machine. so, it is marked as TODO.

till now,  neither kunpeng920 nor Jacobsville is smt.

But I don't mind if it is enabled now.

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
