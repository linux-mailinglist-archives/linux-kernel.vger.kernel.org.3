Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302056846E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiGFJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiGFJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:57:06 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7CBF5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:57:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c89653790so83403837b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kzOAZxXGrZ92EtqDf56/i8bg3HlN5eTE7iOFv/QQzRE=;
        b=Aik45yCQrQ8B/PCpFjTG3eD5L4KUNX5dg2uVYv1bDBr2fU5ZB5Qe6ALIujR6JuAgLm
         b1db1NG54aiJtO8zwZjuYR/qwVJWD4uIleZv9xFLg5CR6NrrWNFU9qN+AnoSz8BN6RJH
         GS9DAq/3ZgMBxv6TG7ZgfXABYe9d9c5kPsgsBdZXZhAIFyjbP3oqn/Q973hQPbLSH9ha
         tR45MlFLDxjbSyIuU8re8+23HCHWvirYIkeuJvFt3SxpiMEnSqIn76maQrrZ538umkv7
         BHSy2SZg1BnvQ0i0b9fUeadeDJbhLQY+PfvXcqDZik0qNEkhQOT3+1vMIebz76DkeqpL
         J4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kzOAZxXGrZ92EtqDf56/i8bg3HlN5eTE7iOFv/QQzRE=;
        b=tS0aHWYyMH7pxkDo81+KAS6e7z614nMdoe8mLcH9NnefewKO3dcidmrvlw1KWA3ISt
         NGgA9N4myKH+zOS3s4zhaS/EL9DYR2z5avKfZWAqea6t8EGg789cHWHc7zjtdRP37Nrh
         cvIlxlrDCjM11FSf+8OPqTxHnmZbJKw+GtV3ujYK8K++gZhLLeLrwZPzyBDqDAyLgu08
         3w5oQNF+veMNr9n2SyM4iLhxSVURn7KW1cQ0aqjiD2QtO9bhPlm+gHsO/SC4OjCWpDF+
         rgE0H9Jn0+eIM0vmLTyZF55EJmB/Sz/yCmlfESgVlgX32GN77+FitRHGbOj5u9HNkJsO
         N9pg==
X-Gm-Message-State: AJIora+2uNp9IpLExjVZfPfePC3BL7d+dpwaBogx63qBbMZsZokyydl2
        TM/APzmc5OEVpf2td3j/SY/vVV7cUkwBmLfxKKEEcA==
X-Google-Smtp-Source: AGRyM1uF8BRmW1/sMSiKU0L43271ObN79weCBxUPYcZ+kdCNs4j/6M1OdS5g3bjnp5G7c1wnonhYzkQxw9+XXiT0dEE=
X-Received: by 2002:a81:53d6:0:b0:31c:c750:14f9 with SMTP id
 h205-20020a8153d6000000b0031cc75014f9mr8393514ywb.248.1657101423419; Wed, 06
 Jul 2022 02:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220706083330.27944-1-huangbing775@126.com>
In-Reply-To: <20220706083330.27944-1-huangbing775@126.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jul 2022 11:56:52 +0200
Message-ID: <CAKfTPtBRSFzDTt3OKosoEJNVoD0qnughRi9ywzCHLL9sURUxSw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Make per-cpu cpumasks static
To:     Bing Huang <huangbing775@126.com>
Cc:     rostedt@goodmis.org, dietmar.eggemann@arm.com, brauner@kernel.org,
        bristot@redhat.com, bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org
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

On Wed, 6 Jul 2022 at 10:36, Bing Huang <huangbing775@126.com> wrote:
>
> From: Bing Huang <huangbing@kylinos.cn>
>
> load_balance_mask and select_idle_mask are only used in fair.c. Make

You have to rebase on tip/sched/core as select_idle_mask has been
renamed select_rq_mask

> them static and move their allocation into init_sched_fair_class().
>
> Replace kzalloc_node() with zalloc_cpumask_var_node() to get rid of the
> CONFIG_CPUMASK_OFFSTACK #ifdef and to align with per-cpu cpumask
> allocation for RT (local_cpu_mask in init_sched_rt_class()) and DL
> class (local_cpu_mask_dl in init_sched_dl_class()).
>
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Beside the rebase and renaming

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>
>  v1->v2:
>    move load_balance_mask and select_idle_mask allocation from
>    sched_init() to init_sched_fair_class()
>  v2->v3:
>    fixup by Dietmar Eggemann <dietmar.eggemann@arm.com>
>  v3->v4:
>    change the patch title and commit message
>
>  kernel/sched/core.c | 11 -----------
>  kernel/sched/fair.c | 13 +++++++++++--
>  2 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0bf6fe9ecd..2feff25fd905 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9530,9 +9530,6 @@ LIST_HEAD(task_groups);
>  static struct kmem_cache *task_group_cache __read_mostly;
>  #endif
>
> -DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> -
>  void __init sched_init(void)
>  {
>         unsigned long ptr = 0;
> @@ -9576,14 +9573,6 @@ void __init sched_init(void)
>
>  #endif /* CONFIG_RT_GROUP_SCHED */
>         }
> -#ifdef CONFIG_CPUMASK_OFFSTACK
> -       for_each_possible_cpu(i) {
> -               per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> -                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -               per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> -                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -       }
> -#endif /* CONFIG_CPUMASK_OFFSTACK */
>
>         init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..61ae0853721e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5843,8 +5843,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  #ifdef CONFIG_SMP
>
>  /* Working cpumask for: load_balance, load_balance_newidle. */
> -DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> +static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> +static DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>
>  #ifdef CONFIG_NO_HZ_COMMON
>
> @@ -11841,6 +11841,15 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
>  __init void init_sched_fair_class(void)
>  {
>  #ifdef CONFIG_SMP
> +       int i;
> +
> +       for_each_possible_cpu(i) {
> +               zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i),
> +                                       GFP_KERNEL, cpu_to_node(i));
> +               zalloc_cpumask_var_node(&per_cpu(select_idle_mask, i),
> +                                       GFP_KERNEL, cpu_to_node(i));
> +       }
> +
>         open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
>
>  #ifdef CONFIG_NO_HZ_COMMON
> --
> 2.25.1
>
