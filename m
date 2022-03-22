Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3864E3BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiCVJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiCVJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:27:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86ABA5F26D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:25:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17F0106F;
        Tue, 22 Mar 2022 02:25:51 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875863F66F;
        Tue, 22 Mar 2022 02:25:50 -0700 (PDT)
Message-ID: <b26b231e-c210-2c7c-8d60-c7e77d688191@arm.com>
Date:   Tue, 22 Mar 2022 10:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 6/7] sched/fair: Remove task_util from effective
 utilization in feec()
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com
References: <20220308181957.280354-1-vincent.donnefort@arm.com>
 <20220308181957.280354-7-vincent.donnefort@arm.com>
Content-Language: en-US
In-Reply-To: <20220308181957.280354-7-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 19:19, Vincent Donnefort wrote:

[...]

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

LGTM, just a couple of small remarks.

[...]

> @@ -6681,9 +6735,11 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;

s/cpu_rq(smp_processor_id())/this_rq()

Maybe you can clean this up with this patch?

>  	int cpu, best_energy_cpu = prev_cpu, target = -1;
> -	unsigned long cpu_cap, util, base_energy = 0;
> +	unsigned long cpu_cap, cpu_thermal_cap, util;

cpu_cap, cpu_thermal_cap and util can be defined inside the
`for (; pd; pd = pd->next)` scope below.

[...]

> @@ -6706,6 +6762,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	if (!task_util_est(p))
>  		goto unlock;
>  
> +	eenv_task_busy_time(&eenv, p, prev_cpu);
> +
>  	for (; pd; pd = pd->next) {
>  		unsigned long cur_delta, spare_cap, max_spare_cap = 0;

cpu_cap and spare_cap could be combined into one to save on local
variables. E.g. cpu_cap

@@ -6908,8 +6908,6 @@ static int find_energy_efficient_cpu(struct
task_struct *p, int prev_cpu)
                         util = cpu_util_next(cpu, p, cpu);
                        cpu_cap = capacity_of(cpu);
-                       spare_cap = cpu_cap;
-                       lsub_positive(&spare_cap, util);
                         /*
                         * Skip CPUs that cannot satisfy the capacity
request.
@@ -6922,15 +6920,14 @@ static int find_energy_efficient_cpu(struct
task_struct *p, int prev_cpu)
                        if (!fits_capacity(util, cpu_cap))
                                continue;
 +                       lsub_positive(&cpu_cap, util);
+
                        if (cpu == prev_cpu) {
                                /* Always use prev_cpu as a candidate. */
                                compute_prev_delta = true;
-                       } else if (spare_cap > max_spare_cap) {
-                               /*
-                                * Find the CPU with the maximum spare
capacity
-                                * in the performance domain.
-                                */
-                               max_spare_cap = spare_cap;
+                       } else if (cpu_cap > max_spare_cap) {
+                                /* Find CPU with max spare capacity in
PD. */
+                               max_spare_cap = cpu_cap;
                                max_spare_cap_cpu = cpu;
                        }

[...]
