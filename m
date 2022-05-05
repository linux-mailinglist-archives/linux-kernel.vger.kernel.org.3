Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58D51C851
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383625AbiEESt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384764AbiEESsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:48:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB56F14035
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:41:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3AAA106F;
        Thu,  5 May 2022 11:41:52 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370603FA31;
        Thu,  5 May 2022 11:41:51 -0700 (PDT)
Message-ID: <cd29f36a-9063-dae6-4526-85494c221bd2@arm.com>
Date:   Thu, 5 May 2022 20:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        vdonnefort@gmail.com
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
 <20220429141148.181816-7-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220429141148.181816-7-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ vdonnefort@gmail.com
- vincent.donnefort@arm.com

On 29/04/2022 16:11, Vincent Donnefort wrote:

[...]

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

> -static long
> -compute_energy(struct task_struct *p, int dst_cpu, struct cpumask *cpus,
> -	       struct perf_domain *pd)
> +static inline void eenv_task_busy_time(struct energy_env *eenv,
> +				       struct task_struct *p, int prev_cpu)
>  {
> -	unsigned long max_util = 0, sum_util = 0, cpu_cap;
> +	unsigned long max_cap = arch_scale_cpu_capacity(prev_cpu);
> +	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
> +
> +	if (unlikely(irq >= max_cap)) {
> +		eenv->task_busy_time = max_cap;
> +		return;
> +	}
> +
> +	eenv->task_busy_time =
> +		scale_irq_capacity(task_util_est(p), irq, max_cap);

Nit-pick:

Maybe a little bit lighter:

 static inline void eenv_task_busy_time(struct energy_env *eenv,
                                       struct task_struct *p, int prev_cpu)
 {
-       unsigned long max_cap = arch_scale_cpu_capacity(prev_cpu);
+       unsigned long busy_time, max_cap = arch_scale_cpu_capacity(prev_cpu);
        unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
 
-       if (unlikely(irq >= max_cap)) {
-               eenv->task_busy_time = max_cap;
-               return;
-       }
+       if (unlikely(irq >= max_cap))
+               busy_time = max_cap;
+       else
+               busy_time = scale_irq_capacity(task_util_est(p), irq, max_cap);
 
-       eenv->task_busy_time =
-               scale_irq_capacity(task_util_est(p), irq, max_cap);
+       eenv->task_busy_time = busy_time;
 }

[...]

> +static inline unsigned long
> +compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> +	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
> +{
> +	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> +	unsigned long busy_time = eenv->pd_busy_time;
> +
> +	if (dst_cpu >= 0)
> +		busy_time = min(eenv->pd_cap,
> +				eenv->pd_busy_time + eenv->task_busy_time);

Nit-pick:

        if (dst_cpu >= 0)
-               busy_time = min(eenv->pd_cap,
-                               eenv->pd_busy_time + eenv->task_busy_time);
+               busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);

[..]

> @@ -6905,12 +6976,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			continue;
>  
>  		/* Compute the 'base' energy of the pd, without @p */
> -		base_energy_pd = compute_energy(p, -1, cpus, pd);
> +		eenv_pd_busy_time(&eenv, cpus, p);

Nit-pick:

Move comment /* Compute the 'base' energy of the pd, without @p */ here
since eenv->pd_busy_time is also used to calculate prev_delta and cur_delta. 


> +		base_energy_pd = compute_energy(&eenv, pd, cpus, p, -1);>  		base_energy += base_energy_pd;

[...]
