Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFB485C48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbiAEXav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:30:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55082 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbiAEXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:30:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB42C61909
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 23:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D38DC36AE9;
        Wed,  5 Jan 2022 23:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641425435;
        bh=i1wbsF49G3pCYx38wsYl8484oDSse5K0BqwhjwtGI9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mJJlUNI9tgp5TUGtv16mTMsiOaz2K8YK7z/KdUmtiXcfjZ8n8pxcMimHSDprCOxrQ
         aToWDoVwY+63wc9Rd6fL2KCMEJJtfefoBZqlXx5oZcGcUCO+ILPhLqy2G2n1wNwAW7
         IMFwlvUC62ZL3FvX7L1RFoqCYL0B2TxIQ6dcnzwax6ucDQwJtnIzDHhqczJ2/sy1tp
         5luEa7anHqal0/ZWCWynH/hhwNnYHa4bXXUjPxUqe/ir8xorMVnnqXrSAe7VVbfVtD
         fq9zt/DUGQScnMHF0nAF4fQbGgao4QD92CXuuXs6dgOPUY+JbrYgVQHKl5j3RuUzGU
         5ADM9LO0l1u6Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF41D5C2B16; Wed,  5 Jan 2022 15:30:34 -0800 (PST)
Date:   Wed, 5 Jan 2022 15:30:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 7/8] sched/isolation: Fix housekeeping_mask memory leak
Message-ID: <20220105233034.GA977207@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220104144944.1278663-1-frederic@kernel.org>
 <20220104144944.1278663-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104144944.1278663-8-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:49:43PM +0100, Frederic Weisbecker wrote:
> If "nohz_full=" or "isolcpus=nohz" are called with CONFIG_NO_HZ_FULL=n,
> housekeeping_mask doesn't get freed despite it being unused if
> housekeeping_setup() is called for the first time.
> 
> Check this scenario first to fix this, so that no useless allocation
> is performed.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Nitesh Lal <nilal@redhat.com>
> Cc: Nicolas Saenz <nsaenzju@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Christoph Lameter <cl@gentwo.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---
>  kernel/sched/isolation.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 828dacec483e..883eee9fae22 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -94,6 +94,14 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
>  	int err = 0;
>  
> +	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
> +		if (!IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> +			pr_warn("Housekeeping: nohz unsupported."
> +				" Build with CONFIG_NO_HZ_FULL\n");
> +			return 0;
> +		}
> +	}
> +
>  	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
>  	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
>  		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
> @@ -123,15 +131,8 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
>  		}
>  	}
>  
> -	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK)) {
> -		if (IS_ENABLED(CONFIG_NO_HZ_FULL)) {
> -			tick_nohz_full_setup(non_housekeeping_mask);
> -		} else {
> -			pr_warn("Housekeeping: nohz unsupported."
> -				" Build with CONFIG_NO_HZ_FULL\n");
> -			goto free_housekeeping_staging;
> -		}
> -	}
> +	if ((flags & HK_FLAG_TICK) && !(housekeeping_flags & HK_FLAG_TICK))
> +		tick_nohz_full_setup(non_housekeeping_mask);
>  
>  	housekeeping_flags |= flags;
>  	err = 1;
> -- 
> 2.25.1
> 
