Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073C477B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbhLPS0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:26:46 -0500
Received: from foss.arm.com ([217.140.110.172]:47048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhLPS0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:26:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016B31435;
        Thu, 16 Dec 2021 10:26:45 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D393F774;
        Thu, 16 Dec 2021 10:26:43 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Again ignore percpu threads for imbalance pulls
In-Reply-To: <20211211094808.109295-1-wuyihao@linux.alibaba.com>
References: <20211211094808.109295-1-wuyihao@linux.alibaba.com>
Date:   Thu, 16 Dec 2021 18:26:38 +0000
Message-ID: <87k0g48kyp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 17:48, Yihao Wu wrote:
> commit 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance
> pulls") was meant to fix a performance issue, when load balance tries to
> migrate pinned kernel threads at MC domain level. This was destined to
> fail.

> After it fails, it further makes wakeup balance at NUMA domain level
> messed up. The most severe case that I noticed and frequently occurs:
>     |sum_nr_running(node1) - sum_nr_running(node2)| > 100
>

Wakeup balance (aka find_idlest_cpu()) is different from periodic load
balance (aka load_balance()) and doesn't use can_migrate_task(), so the
incriminated commit shouldn't have impacted it (at least not in obvious
ways...). Do you have any more details on that issue?

> However the original bugfix failed, because it covers only case 1) below.
>   1) Created by create_kthread
>   2) Created by kernel_thread
> No kthread is assigned to task_struct in case 2 (Please refer to comments
> in free_kthread_struct) so it simply won't work.
>
> The easist way to cover both cases is to check nr_cpus_allowed, just as
> discussed in the mailing list of the v1 version of the original fix.
>
> * lmbench3.lat_proc -P 104 fork (2 NUMA, and 26 cores, 2 threads)
>

Reasoning about "proper" pcpu kthreads was simpler since they are static,
see 3a7956e25e1d ("kthread: Fix PF_KTHREAD vs to_kthread() race")

>                          w/out patch                 w/ patch
> fork+exit latency            1660 ms                  1520 ms (   8.4%)
>
> Fixes: 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance pulls")
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>  kernel/kthread.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 4a4d7092a2d8..cb05d3ff2de4 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -543,11 +543,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
>
>  bool kthread_is_per_cpu(struct task_struct *p)
>  {
> -	struct kthread *kthread = __to_kthread(p);
> -	if (!kthread)
> -		return false;
> -
> -	return test_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> +	return (p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1;
>  }

As Peter said, this is going to cause issues. If you look at
kthread_set_per_cpu(), we also store a CPU value which we expect to be
valid when kthread_is_per_cpu(), which that change is breaking.

AIUI what you want to patch is the actual usage in can_migrate_task()

>
>  /**
> --
> 2.32.0.604.gb1f3e1269
