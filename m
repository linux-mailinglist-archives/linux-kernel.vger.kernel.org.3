Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D260447B1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhLTRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:17:43 -0500
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240110AbhLTRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:17:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853F2D6E;
        Mon, 20 Dec 2021 09:17:42 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F3B3F774;
        Mon, 20 Dec 2021 09:17:41 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, qperret@google.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH 3/3] sched/fair: Do not raise overutilized for idle CPUs
In-Reply-To: <20211220114323.22811-4-vincent.donnefort@arm.com>
References: <20211220114323.22811-1-vincent.donnefort@arm.com> <20211220114323.22811-4-vincent.donnefort@arm.com>
Date:   Mon, 20 Dec 2021 17:17:38 +0000
Message-ID: <8735mn8abx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/21 12:43, Vincent Donnefort wrote:
> During a migration, the lock for the previous runqueue is not taken and
> hence, the task contribution isn't directly removed from that runqueue
> utilization but instead temporarily saved, until the next PELT signals
> update where it would be accounted. There is then a window in which a
> CPU can ben idle be nonetheless overutilized.
>
> The load balancer wouldn't be able to do anything to help a sleeping CPU,
> it brings then no gain to raise overutilized there, only the risk of
> spuriously doing it.
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 51f6f55abb37..37f737c5f0b8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8641,26 +8641,28 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>
>               nr_running = rq->nr_running;
>               sgs->sum_nr_running += nr_running;
> -
> -		if (nr_running > 1)
> -			*sg_status |= SG_OVERLOAD;
> -
> -		if (cpu_overutilized(i))
> -			*sg_status |= SG_OVERUTILIZED;
> -
>  #ifdef CONFIG_NUMA_BALANCING
>               sgs->nr_numa_running += rq->nr_numa_running;
>               sgs->nr_preferred_running += rq->nr_preferred_running;
>  #endif
> +		if (nr_running > 1)
> +			*sg_status |= SG_OVERLOAD;
> +
>               /*
>                * No need to call idle_cpu() if nr_running is not 0
>                */
>               if (!nr_running && idle_cpu(i)) {
>                       sgs->idle_cpus++;
> -			/* Idle cpu can't have misfit task */
> +			/*
> +			 * Idle cpu can neither be overutilized nor have a
> +			 * misfit task.
> +			 */
>                       continue;
>               }
>
> +		if (cpu_overutilized(i))
> +			*sg_status |= SG_OVERUTILIZED;
> +
>               if (local_group)
>                       continue;
>
> --
> 2.25.1
