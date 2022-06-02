Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F653B966
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiFBNH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiFBNHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:07:25 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E984E13C1EE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 06:07:22 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ff7b90e635so50711467b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0KWrs2nsUCJnNPYZ0GE1uKitoBIYJg8ZM0Zfwo7R1U=;
        b=HLKAzfL9ql/xGCixBfzCZ0vg5zPh0sd31KkqEIHOnAGwV5guBgMI0xiJLlaaY/YGMz
         3vnOFQJdMZtTLhEe/7qiNhlAcKWJHJzQEiawtF9S6JYSPaowt7nnrosjrbEy4ki6w5yt
         OSnBS/hFX5bucfV0WClqHpLf3ghOeaJMYJ+2+b1uift9O+YPBI/+bP0/iHZTiFsK4CJY
         ij+QLUx73CfQ1Tq+Co1fIC0C6N7pIrMbB8uxyE1tTnSQGmVBMlGxLfuq4DU+M4+bgSCc
         KlIiVGrQs6tRP9RfhvWP/LiDrSl8yRwtlyI4VhCDJvHti6mTuIycwg4TVaZ/Jny/ajbX
         L2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0KWrs2nsUCJnNPYZ0GE1uKitoBIYJg8ZM0Zfwo7R1U=;
        b=vDHX/DSyqJIG9t4y+Xvoba1c2UBnXvB7916EbwwR05CYnQNeXwclRJ1tcjuQFa0HYq
         Fdd60L1fr1U9PxU+UhlAoGJQK1xH94mkSeQAIlhSTz3RhKdB/erI/EfR2I/gGptg16V0
         CEmOccevZqc4kxpePjINvHMquOytGi3d9D+94Bwnf5M742dVZxvwz8aH0p1MvQMnzM0q
         6JUI5FeOgBFv6XpTGvXeVfysc6QWyZYXpQfZklHrhVgej8GbiFMA888Lgj/+VA4kFnUr
         B2JkFb40o2AGzWazJyejlmJXU7cU764/Td1Ai2EqZHDSyumyYaobcT8Sh7hYhTKDjxmM
         nEIg==
X-Gm-Message-State: AOAM531R3Yuc3WX342vdZtlW9ZY5uM+e3Th6BVZuhZPMQJ2a1PAtu9ou
        ZflgVyS6/9FvKerR1nz7xbr+Vz0teUBdmfIfOisiKQ==
X-Google-Smtp-Source: ABdhPJxBsmOW09QDhNaZzDF2pQpinoQkRt9xg0w7RzfBUu39qAcLifKpmQBWRV9IqPDFMpbNEgKlTO2azbUdRXtlTnc=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr5442108ywf.86.1654175242124; Thu, 02 Jun
 2022 06:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com> <20220523155140.2878563-5-vdonnefort@google.com>
In-Reply-To: <20220523155140.2878563-5-vdonnefort@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Jun 2022 15:07:10 +0200
Message-ID: <CAKfTPtAR2u-mopV=hTL8od+=ht=i0QFEAcqBEeAckXHFHpdhMA@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] sched/fair: Rename select_idle_mask to select_rq_mask
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
> Decouple the name of the per-cpu cpumask select_idle_mask from its usage
> in select_idle_[cpu/capacity]() of the CFS run-queue selection
> (select_task_rq_fair()).
>
> This is to support the reuse of this cpumask in the Energy Aware
> Scheduling (EAS) path (find_energy_efficient_cpu()) of the CFS run-queue
> selection.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c531976ee960..68f5eb8a1de7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9502,7 +9502,7 @@ static struct kmem_cache *task_group_cache __read_mostly;
>  #endif
>
>  DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> +DECLARE_PER_CPU(cpumask_var_t, select_rq_mask);
>
>  void __init sched_init(void)
>  {
> @@ -9551,7 +9551,7 @@ void __init sched_init(void)
>         for_each_possible_cpu(i) {
>                 per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -               per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> +               per_cpu(select_rq_mask, i) = (cpumask_var_t)kzalloc_node(
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>         }
>  #endif /* CONFIG_CPUMASK_OFFSTACK */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 73a9dc522b73..2d7bba2f1da2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5897,7 +5897,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>
>  /* Working cpumask for: load_balance, load_balance_newidle. */
>  DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> +DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
>
>  #ifdef CONFIG_NO_HZ_COMMON
>
> @@ -6387,7 +6387,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>   */
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
> -       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
>         struct rq *this_rq = this_rq();
>         int this = smp_processor_id();
> @@ -6473,7 +6473,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>         int cpu, best_cpu = -1;
>         struct cpumask *cpus;
>
> -       cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +       cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
>         task_util = uclamp_task_util(p);
> --
> 2.36.1.124.g0e6072fb45-goog
>
