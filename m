Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3618547B1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhLTRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:17:22 -0500
Received: from foss.arm.com ([217.140.110.172]:59888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhLTRRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:17:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6ACD6E;
        Mon, 20 Dec 2021 09:17:17 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8D723F774;
        Mon, 20 Dec 2021 09:17:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, qperret@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH 1/3] sched/fair: Make cpu_overutilized() EAS dependent
In-Reply-To: <20211220114323.22811-2-vincent.donnefort@arm.com>
References: <20211220114323.22811-1-vincent.donnefort@arm.com> <20211220114323.22811-2-vincent.donnefort@arm.com>
Date:   Mon, 20 Dec 2021 17:17:09 +0000
Message-ID: <875yrj8acq.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/21 12:43, Vincent Donnefort wrote:
> On a system with Energy Aware Scheduling (EAS), tasks are placed according
> to their energy consumption estimation and load balancing is disabled to
> not break that energy biased placement. If the system becomes
> overutilized, i.e. one of the CPU has too much utilization, energy
> placement would then be disabled, in favor of Capacity-Aware Scheduling
> (CAS), including load balancing. This is the sole usage for
> rd->overutilized. Hence, there is no need to raise it for !EAS systems.
>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")

I'm not sure a Fixes: is warranted, this does not fix any misbehaviour or
performance regression (even if this might gain us a few extra IPS by not
writing 1's to rd->overutilized on SMP systems, note that this still gives
us writes of 0's).

Regardless:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..e2f6fa14e5e7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5511,7 +5511,8 @@ static inline void hrtick_update(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static inline bool cpu_overutilized(int cpu)
>  {
> -	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
> +	return sched_energy_enabled() &&
> +	       !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
>  }
>
>  static inline void update_overutilized_status(struct rq *rq)
> --
> 2.25.1
