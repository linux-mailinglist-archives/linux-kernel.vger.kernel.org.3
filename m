Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9602546AA87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351886AbhLFVhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350386AbhLFVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:37:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:33:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B963EB812A4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 21:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A69C341C6;
        Mon,  6 Dec 2021 21:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638826413;
        bh=tESLxjV2BoRzClEePdN9FBmdmMX2ckfln1BF8QeZEXM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ajf19KTjVUQ/Nz0StcyGwOATjcXXgcyHZcC9vAnsUCxeA//zIxYpeBcBN73IVEHWv
         KkWVJEZs7rYQeE0WXh/FnEClRWAf++jyMrF4IclVPCBaCqTpOlv7SzN03goqqItKO5
         xlqJfMWdDHrtskwNieJ6iadUcgOhYpdhTnumF/vfdJMl8fud6T49juY6HCcGJiRbBL
         1WgA3rudiIiLdBkAZuD1kCExBfLdlhDtwG6bK3B2RDwLQN2bpvByqLAQv5RZdkR3vN
         YAnbavLc+wDIjP5/U7rfPsbgp6ltwmZwHUZJ2V8clyaLR368f6wV3vTXObWSzz6c8D
         slpl5g+xxZ/JQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3BB335C1461; Mon,  6 Dec 2021 13:33:33 -0800 (PST)
Date:   Mon, 6 Dec 2021 13:33:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] sched/isolation: really align nohz_full with
 rcu_nocbs
Message-ID: <20211206213333.GH641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211206145950.10927-1-paul.gortmaker@windriver.com>
 <20211206145950.10927-2-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206145950.10927-2-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 09:59:49AM -0500, Paul Gortmaker wrote:
> At the moment it is currently possible to sneak a core into nohz_full
> that lies between nr_possible and NR_CPUS - but you won't "see" it
> because cpumask_pr_args() implicitly hides anything above nr_cpu_ids.
> 
> This becomes a problem when the nohz_full CPU set doesn't contain at
> least one other valid nohz CPU - in which case we end up with the
> tick_nohz_full_running set and no tick core specified, which trips an
> endless sequence of WARN() and renders the machine unusable.
> 
> I inadvertently opened the door for this when fixing an overly
> restrictive nohz_full conditional in the below Fixes: commit - and then
> courtesy of my optimistic ACPI reporting nr_possible of 64 (the default
> Kconfig for NR_CPUS) and the not-so helpful implict filtering done by
> cpumask_pr_args, I unfortunately did not spot it during my testing.
> 
> So here, I don't rely on what was printed anymore, but code exactly what
> our restrictions should be in order to be aligned with rcu_nocbs - which
> was the original goal.  Since the checks lie in "__init" code it is largely
> free for us to do this anyway.
> 
> Building with NOHZ_FULL and NR_CPUS=128 on an otherwise defconfig, and
> booting with "rcu_nocbs=8-127 nohz_full=96-127" on the same 16 core T5500
> Dell machine now results in the following (only relevant lines shown):
> 
>  smpboot: Allowing 64 CPUs, 48 hotplug CPUs
>  setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:64 nr_node_ids:2
>  housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.
>  housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.
>  rcu:     RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=64.
>  rcu:     Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
>  rcu:     Offload RCU callbacks from CPUs: 8-63.
> 
> One can see both new housekeeping checks are triggered in the above.
> The same invalid boot arg combination would have previously resulted in
> an infinitely scrolling mix of WARN from all cores per tick on this box.
> 
> Fixes: 915a2bc3c6b7 ("sched/isolation: Reconcile rcu_nocbs= and nohz_full=")
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  kernel/sched/isolation.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 7f06eaf12818..01abc8400d6c 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -89,6 +89,18 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  		return 0;
>  	}
>  
> +	if (!cpumask_subset(non_housekeeping_mask, cpu_possible_mask)) {
> +		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.\n");
> +		cpumask_and(non_housekeeping_mask, cpu_possible_mask,
> +			    non_housekeeping_mask);
> +	}
> +
> +	if (cpumask_empty(non_housekeeping_mask)) {
> +		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.\n");
> +		free_bootmem_cpumask_var(non_housekeeping_mask);
> +		return 0;

If Frederic applies his rcu_nocbs work to nohz_full, it may some day be
valid to specify an empty nohz_full CPU mask.  Of course, it might well
be that warning in the meantime is a good thing, but I figured that I
should call attention to the possibility.

							Thanx, Paul

> +	}
> +
>  	alloc_bootmem_cpumask_var(&tmp);
>  	if (!housekeeping_flags) {
>  		alloc_bootmem_cpumask_var(&housekeeping_mask);
> -- 
> 2.17.1
> 
