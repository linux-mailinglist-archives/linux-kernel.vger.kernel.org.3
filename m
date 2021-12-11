Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0F471392
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhLKLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhLKLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:12:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D2C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 03:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NWCgLvBk1kN/RV6Aqo1/UiaNQjY1Ur8dnglelLQ8WDQ=; b=phM56QXIVbabeMHx+tQC2zhfM5
        Na/NcS37ZxPH2mH5rZexEd6aq96lrYWpVI5jqCQaB1a6gbBcQ0+PsT6EkAiSrklYXVtUHkgNviMJW
        wUbxfBrA/i16+zoM23M1xkXZVak3Waef9YiejkcR8LLTe65W5i7+Qf+4pWhsIY613UwzwMscdo2wM
        f0nBZYNwTaZ1ME5HQr64ME1Zv4yVYf/OlJkleSH836sFtTsxDujQKLS0Gf4RNLvUhXGELIYf9YFvJ
        MT2k9HPEz8rQoZEcaFHl2iSkAQGhSQkUAsUA/e58K7vgygphOfUATeBoSojZKHG+FM40vCx4hIjRI
        1D0oz2BQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mw0Ib-000icP-3v; Sat, 11 Dec 2021 11:12:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33906981654; Sat, 11 Dec 2021 12:12:15 +0100 (CET)
Date:   Sat, 11 Dec 2021 12:12:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Again ignore percpu threads for imbalance
 pulls
Message-ID: <20211211111215.GW16608@worktop.programming.kicks-ass.net>
References: <20211211094808.109295-1-wuyihao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211094808.109295-1-wuyihao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 05:48:08PM +0800, Yihao Wu wrote:
> commit 2f5f4cce496e ("sched/fair: Ignore percpu threads for imbalance
> pulls") was meant to fix a performance issue, when load balance tries to
> migrate pinned kernel threads at MC domain level. This was destined to
> fail. After it fails, it further makes wakeup balance at NUMA domain level
> messed up. The most severe case that I noticed and frequently occurs:
>     |sum_nr_running(node1) - sum_nr_running(node2)| > 100
> 
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

NAK, this will break lots of things.
