Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23AC53B985
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiFBNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiFBNQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:16:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D30115A46
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:16:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h75so8240067ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YXu1V3VR8TUftygJEuAqMqJkg+/ZrkiXwmmBce9gb0=;
        b=HLhIT4g7i0wOca+xJNmnCRxTFKylRfa61zAiBYfvXFACPan6cB5/xMa4N90Bhv18z1
         kdnt93N6EXKTbZBb8OkApGCtwSWxgSD+0FA9KAUWhX8IcjikVNmAipar+n9u1k0D3w5L
         ua9+csXtlTufPramXxrpmjQ7KPjSqLoHzt0gKmr1oYK/dvrwUYv9b8ePk/3KBLdpT9EE
         FlVdONZYK19tNSNGSR3G7qHmrQ6nbcbrvHyfVhMSpMsEScPnfVWHp5qXk1c4HgaTloPX
         i6GgaICPbLdiMUkER1hDbjKo8FCz1SC9ZHSmfinUE1q6zKi/V0NCsGoguU07lnwUO1hq
         vaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YXu1V3VR8TUftygJEuAqMqJkg+/ZrkiXwmmBce9gb0=;
        b=MUb+XApc7AEQqmuTrV66O4vU0AVB4uBK1WO/AcUBLHOrLONUE8yTFihjaVlAQPbDJA
         yR6hUGxpZc6VUZTyvuVrPf5AtuxlCHq3/khxQvMwzKpVDKhDPgFA8hjSZiklxaUmMTxm
         OWkLu++CvyoOeonHC2EDeVtuZQoU7fhAsORI88RHjnCBsL7ZHOliVYGGS4vnnTzjpGYC
         qJZ/Owkxm8ZDxfCQCk0RIZB3GObCMKDVcaXTUZb05IbVomN6zNv7Og5jJSjdh6VPO3VR
         SOC1ikr7bEiINgiRlwzq1SaYeCODitOopwYzVEC0M5CTvZFsfMMHBWKQkb22mWUR37ir
         TnbQ==
X-Gm-Message-State: AOAM531YoG1WItOJRcHq6iPRd0FC+1NdEiDgX5XCyniSX86MIsa2qSTh
        iMGkJe6Qm4X2iiKoHEv/Ixs+DHj6fDMZ+Eu4aUIN8Q==
X-Google-Smtp-Source: ABdhPJyBtOeXWMXMPERgXnl0k+RivXQST/VnOj3vyZIhEN1AJrmvj2/HAiAr3sQKg25G+3bZEOUZqd7s3HYjEAxB8sY=
X-Received: by 2002:a25:8a0e:0:b0:65c:bdb8:735c with SMTP id
 g14-20020a258a0e000000b0065cbdb8735cmr5093872ybl.211.1654175778366; Thu, 02
 Jun 2022 06:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com> <20220523155140.2878563-6-vdonnefort@google.com>
In-Reply-To: <20220523155140.2878563-6-vdonnefort@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Jun 2022 15:16:07 +0200
Message-ID: <CAKfTPtAZOJg-04Zb1MAZueh0jwrokS-eAkMfB+avC5-fcMSkwA@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com
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

On Mon, 23 May 2022 at 17:52, Vincent Donnefort <vdonnefort@google.com> wrote:
>
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> The Perf Domain (PD) cpumask (struct em_perf_domain.cpus) stays
> invariant after Energy Model creation, i.e. it is not updated after
> CPU hotplug operations.
>
> That's why the PD mask is used in conjunction with the cpu_online_mask
> (or Sched Domain cpumask). Thereby the cpu_online_mask is fetched
> multiple times (in compute_energy()) during a run-queue selection
> for a task.
>
> cpu_online_mask may change during this time which can lead to wrong
> energy calculations.
>
> To be able to avoid this, use the select_rq_mask per-cpu cpumask to
> create a cpumask out of PD cpumask and cpu_online_mask and pass it
> through the function calls of the EAS run-queue selection path.
>
> The PD cpumask for max_spare_cap_cpu/compute_prev_delta selection
> (find_energy_efficient_cpu()) is now ANDed not only with the SD mask
> but also with the cpu_online_mask. This is fine since this cpumask
> has to be in syc with the one used for energy computation
> (compute_energy()).
> An exclusive cpuset setup with at least one asymmetric CPU capacity
> island (hence the additional AND with the SD cpumask) is the obvious
> exception here.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d7bba2f1da2..57074f27c0d2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6700,14 +6700,14 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>   * task.
>   */
>  static long
> -compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> +compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
> +              struct perf_domain *pd)
>  {
> -       struct cpumask *pd_mask = perf_domain_span(pd);
>         unsigned long max_util = 0, sum_util = 0, cpu_cap;
>         int cpu;
>
> -       cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> -       cpu_cap -= arch_scale_thermal_pressure(cpumask_first(pd_mask));
> +       cpu_cap = arch_scale_cpu_capacity(cpumask_first(cpus));
> +       cpu_cap -= arch_scale_thermal_pressure(cpumask_first(cpus));
>
>         /*
>          * The capacity state of CPUs of the current rd can be driven by CPUs
> @@ -6718,7 +6718,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>          * If an entire pd is outside of the current rd, it will not appear in
>          * its pd list and will not be accounted by compute_energy().
>          */
> -       for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> +       for_each_cpu(cpu, cpus) {
>                 unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
>                 unsigned long cpu_util, util_running = util_freq;
>                 struct task_struct *tsk = NULL;
> @@ -6805,6 +6805,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>   */
>  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>         unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>         struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
>         int cpu, best_energy_cpu = prev_cpu, target = -1;
> @@ -6839,7 +6840,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 unsigned long base_energy_pd;
>                 int max_spare_cap_cpu = -1;
>
> -               for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> +               cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> +
> +               for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
>                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                                 continue;
>
> @@ -6876,12 +6879,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         continue;
>
>                 /* Compute the 'base' energy of the pd, without @p */
> -               base_energy_pd = compute_energy(p, -1, pd);
> +               base_energy_pd = compute_energy(p, -1, cpus, pd);
>                 base_energy += base_energy_pd;
>
>                 /* Evaluate the energy impact of using prev_cpu. */
>                 if (compute_prev_delta) {
> -                       prev_delta = compute_energy(p, prev_cpu, pd);
> +                       prev_delta = compute_energy(p, prev_cpu, cpus, pd);
>                         if (prev_delta < base_energy_pd)
>                                 goto unlock;
>                         prev_delta -= base_energy_pd;
> @@ -6890,7 +6893,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
>                 if (max_spare_cap_cpu >= 0) {
> -                       cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
> +                       cur_delta = compute_energy(p, max_spare_cap_cpu, cpus,
> +                                                  pd);
>                         if (cur_delta < base_energy_pd)
>                                 goto unlock;
>                         cur_delta -= base_energy_pd;
> --
> 2.36.1.124.g0e6072fb45-goog
>
