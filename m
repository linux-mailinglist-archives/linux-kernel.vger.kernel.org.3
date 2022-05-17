Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6144652A40A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiEQN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347280AbiEQN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:58:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B353C71C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:58:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 00EDB1F37E;
        Tue, 17 May 2022 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652795891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5G+a9MugMNh38fuvlfEb6EKwdMwJlLHbuAXDShGNoYA=;
        b=K5Ufg3JKysAmmHPQl/5CMCFuXvX/eK6hrxjSo7eJHRJH9ula7lfsWLp0dXe5PHjtKNVPwe
        9QrTiPjgYzoVnadJvHLLUtFUIdL2JSWaFc2hMf5cMxYAl8QHn3c6nwUcER/wm8bY4VPRaW
        Ywun+jzHXvVgAvxcxxHXb/ui6kSvips=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652795891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5G+a9MugMNh38fuvlfEb6EKwdMwJlLHbuAXDShGNoYA=;
        b=rW4eglMxdND2r666K7VhWKrQkXN7aaykr3558rISZDjivqY3hjH+RL/6cip/11+bbLPTym
        wputB41cmfjZyKDg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6BF22C141;
        Tue, 17 May 2022 13:58:09 +0000 (UTC)
Date:   Tue, 17 May 2022 14:58:07 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Message-ID: <20220517135807.GS20579@suse.de>
References: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 02:24:27PM +0800, Tianchen Ding wrote:
> We notice the commit 518cd6234178 ("sched: Only queue remote wakeups
> when crossing cache boundaries") disabled queuing tasks on wakelist when
> the cpus share llc. This is because, at that time, the scheduler must
> send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
> in idle polling.
> 
> Benefits:
>   Queuing the task on idle cpu can help improving performance on waker cpu
>   and utilization on wakee cpu, and further improve locality because
>   the wakee cpu can handle its own rq. This patch helps improving rt on
>   our real java workloads where wakeup happens frequently.
> 
> Does this patch bring IPI flooding?
>   For archs with TIF_POLLING_NRFLAG (e.g., x86), there will be no
>   difference if the wakee cpu is idle polling. If the wakee cpu is idle
>   but not polling, the later check_preempt_curr() will send IPI too.
> 

That's a big if. Polling does not last very long -- somewhere between 10
and 62 microseconds for HZ=1000 or 250 microseconds for HZ=250. It may
not bring IPI flooding depending on the workload but it will increase
IPI counts.

>   For archs without TIF_POLLING_NRFLAG (e.g., arm64), the IPI is
>   unavoidable, since the later check_preempt_curr() will send IPI when
>   wakee cpu is idle.
> 
> Benchmark:
> running schbench -m 2 -t 8 on 8269CY:
> 
> without patch:
> Latency percentiles (usec)
>         50.0000th: 10
>         75.0000th: 14
>         90.0000th: 16
>         95.0000th: 16
>         *99.0000th: 17
>         99.5000th: 20
>         99.9000th: 23
>         min=0, max=28
> 
> with patch:
> Latency percentiles (usec)
>         50.0000th: 6
>         75.0000th: 8
>         90.0000th: 9
>         95.0000th: 9
>         *99.0000th: 10
>         99.5000th: 10
>         99.9000th: 14
>         min=0, max=16
> 
> We've also tested unixbench and see about 10% improvement on Pipe-based
> Context Switching, and no performance regression on other test cases.

It'll show a benefit for any heavily communicating tasks that rapidly
enters/exits idle because the wakee CPU may be still polling due to the
rapid enter/exit pattern.

> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  kernel/sched/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 51efaabac3e4..cae5011a8b1f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3820,6 +3820,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  	if (!cpu_active(cpu))
>  		return false;
>  
> +	if (cpu == smp_processor_id())
> +		return false;
> +
>  	/*
>  	 * If the CPU does not share cache, then queue the task on the
>  	 * remote rqs wakelist to avoid accessing remote data.

Is this suggesting that the running CPU should try sending an IPI to
itself?

> @@ -3827,6 +3830,12 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  	if (!cpus_share_cache(smp_processor_id(), cpu))
>  		return true;
>  
> +	/*
> +	 * If the CPU is idle, let itself do activation to improve utilization.
> +	 */
> +	if (available_idle_cpu(cpu))
> +		return true;
> +
>  	/*
>  	 * If the task is descheduling and the only running task on the
>  	 * CPU then use the wakelist to offload the task activation to

It is highly likely that the target CPU is idle given that we almost
certainly called select_idle_sibling() before reaching here.

I suspect what you are trying to do is use the wakelist regardless of
locality if the CPU is polling because polling means an IPI is avoided
but it's not what the patch does.

> @@ -3842,9 +3851,6 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
>  	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> -		if (WARN_ON_ONCE(cpu == smp_processor_id()))
> -			return false;
> -
>  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>  		__ttwu_queue_wakelist(p, cpu, wake_flags);
>  		return true;




> -- 
> 2.27.0
> 

-- 
Mel Gorman
SUSE Labs
