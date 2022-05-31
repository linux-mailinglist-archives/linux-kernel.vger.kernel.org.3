Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91836538C99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiEaIRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbiEaIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:17:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97FC412096
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:17:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C16323A;
        Tue, 31 May 2022 01:17:15 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38C7B3F73D;
        Tue, 31 May 2022 01:17:12 -0700 (PDT)
Message-ID: <d91ffb42-4440-7c07-6a87-3cce9fa3dcab@arm.com>
Date:   Tue, 31 May 2022 10:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v9 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-7-vdonnefort@google.com>
Content-Language: en-US
In-Reply-To: <20220523155140.2878563-7-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Vincent Donnefort <vincent.donnefort@arm.com>

On 23/05/2022 17:51, Vincent Donnefort wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

> @@ -6834,22 +6887,36 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	if (!task_util_est(p))
>  		goto unlock;
>  
> +	eenv_task_busy_time(&eenv, p, prev_cpu);
> +
>  	for (; pd; pd = pd->next) {
> -		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +		unsigned long cpu_cap, cpu_thermal_cap, util;
> +		unsigned long cur_delta, max_spare_cap = 0;
>  		bool compute_prev_delta = false;
>  		unsigned long base_energy_pd;
>  		int max_spare_cap_cpu = -1;
>  
>  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);

Internal EAS testing of this patch-set version has revealed that this
doesn't work against LTP CPU hotplug stress test. `struct cpumask *cpus`
can't be used when it is empty. This can happen in case all PD CPUs are
hotplugged out since we `and` the invariant PD cpumask with
cpu_online_mask. We need a:

+               if (cpumask_empty(cpus))
+                       continue;
+

here.

> -		for_each_cpu_and(cpu, cpus, sched_domain_span(sd)) {
> +		/* Account thermal pressure for the energy estimation */
> +		cpu = cpumask_first(cpus);
> +		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> +		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);

[...]
