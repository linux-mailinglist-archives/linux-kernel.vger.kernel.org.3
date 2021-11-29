Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211AB4612FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354480AbhK2LAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:00:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354396AbhK2K6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:58:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFA791042;
        Mon, 29 Nov 2021 02:54:56 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6693F694;
        Mon, 29 Nov 2021 02:54:55 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: Re: [PATCH v2] sched/fair: Fix per-CPU kthread and wakee stacking for asym CPU capacity
In-Reply-To: <20211125101239.3248857-1-vincent.donnefort@arm.com>
References: <20211125101239.3248857-1-vincent.donnefort@arm.com>
Date:   Mon, 29 Nov 2021 10:54:49 +0000
Message-ID: <87mtlnb5ae.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/21 10:12, Vincent Donnefort wrote:
> select_idle_sibling() has a special case for tasks woken up by a per-CPU
> kthread. For this case, the chosen CPU is the previous one. This is an
> issue for asymmetric CPU capacity systems where the wakee might not fit
> that CPU anymore. Evaluate asym_fits_capacity() for prev_cpu before using
> the exit path described above.
>
> Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

Per our discussion on v1, the asym check was intentionally omitted, the
assumption being: we'd be putting p back on its prev CPU, its utilization
cannot be bigger now than it was then so it should still pass the capacity
fitness criterion (unless we dequeued it right before crossing the next
PELT window boundary would have made it cross the tipping point...)

Uclamp goes against this, p's uclamp.min can completely change between its
dequeue and wakeup, which warrants adding the check.

I'd like to see (at least some of) the above in the changelog, but
pedantism aside:

Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6291876a9d32..b90dc6fd86ca 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>        */
>       if (is_per_cpu_kthread(current) &&
>           prev == smp_processor_id() &&
> -	    this_rq()->nr_running <= 1) {
> +	    this_rq()->nr_running <= 1 &&
> +	    asym_fits_capacity(task_util, prev)) {
>               return prev;
>       }
>
> --
> 2.25.1
