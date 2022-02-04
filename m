Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC84A95B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiBDJGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:06:48 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43032 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiBDJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:06:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AF0DCCE2277
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88515C004E1;
        Fri,  4 Feb 2022 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643965605;
        bh=xK6JJSiUh7mYyf5pTAXfPNH8lO+BtXRuGs80hxvbIGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=G4fTdlGslagHUmAeNRfBTxocwty4Yy8kDstVKVCj1gFJl9LnI/qEoLq40DAze+oBK
         mPhZJaOA3haSnqdsXK650kkj5IgZ6tiG7/v5L6sj3tK3L26ZjYLgZQfckJWJpO8Oqb
         2ELqBSxVo2bXSu0dGkpBYk8q7e9HhcRddr2WiHOn4Pfcw4tFcV/DDCif2whCJWRQB0
         fUd+V5rQNqW//5fgrKf7NIzhP6d+3lVABHB71zmf8f5snRAZ9zirjoIXrCwRfwFpRr
         zpumnSjz65FuVex9mKza10tP9jBF3zG2DvaYMKfIPNJmtOr8bCMuk6gtmHHcYomgLs
         7CPZM62QTF8zQ==
From:   SeongJae Park <sj@kernel.org>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Date:   Fri,  4 Feb 2022 09:06:42 +0000
Message-Id: <20220204090642.2425-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220204064059.6244-1-tome01@ajou.ac.kr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonghyeon, thank you for this patch!

On Fri, 4 Feb 2022 15:40:59 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> Current DAMON_RECALIM is not compatible the NUMA memory system. To proactively
> reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up before
> kswapd does reclaim memory. However, the current watermark for proactive
> reclamation is based on entire system free memory. So, though the one memory
> node is fully used, kdamond is not waked up.

Good point!

> 
> This patch allows kdamond thread to select watermark options for monitoring
> specific node or whole system free memory.

Why only specific NUMA node or whole system, instead of each NUMA node?  Are
you running DARC for only specific NUMA node?  If that's the case, I think
implementing your own DAMON-based policy in user space might be a better
choice.  For example, you could implement and use a user-space daemon that
monitors free memory ratio of each NUMA node and adjusts the watermarks.

Hope I'm not making you get me wrong.  You found the important limitation of
DAMON_RECLAIM, thank you!  I really hope DAMON_RECLAIM to evolve to handle the
case.  I'm just saying this patch looks like specialized for your special case,
and there could be a better approach for that.


Thanks,
SJ

> 
> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> ---
>  include/linux/damon.h |  4 +++-
>  mm/damon/core.c       | 15 +++++++++++----
>  mm/damon/dbgfs.c      |  3 ++-
>  mm/damon/reclaim.c    | 12 +++++++++++-
>  4 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 114cfb96d37a..3846b985bcb9 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -220,6 +220,7 @@ struct damos_stat {
>   * @wmarks:		Watermarks for automated (in)activation of this scheme.
>   * @stat:		Statistics of this scheme.
>   * @list:		List head for siblings.
> + * @node:		NUMA node of target regions.
>   *
>   * For each aggregation interval, DAMON finds regions which fit in the
>   * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
> @@ -251,6 +252,7 @@ struct damos {
>  	struct damos_watermarks wmarks;
>  	struct damos_stat stat;
>  	struct list_head list;
> +	int node;
>  };
>  
>  struct damon_ctx;
> @@ -477,7 +479,7 @@ struct damos *damon_new_scheme(
>  		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
>  		unsigned int min_age_region, unsigned int max_age_region,
>  		enum damos_action action, struct damos_quota *quota,
> -		struct damos_watermarks *wmarks);
> +		struct damos_watermarks *wmarks, int node);
>  void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
>  void damon_destroy_scheme(struct damos *s);
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 07449d46d3d3..dfa87cda0266 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -87,7 +87,7 @@ struct damos *damon_new_scheme(
>  		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
>  		unsigned int min_age_region, unsigned int max_age_region,
>  		enum damos_action action, struct damos_quota *quota,
> -		struct damos_watermarks *wmarks)
> +		struct damos_watermarks *wmarks, int node)
>  {
>  	struct damos *scheme;
>  
> @@ -125,6 +125,8 @@ struct damos *damon_new_scheme(
>  	scheme->wmarks.low = wmarks->low;
>  	scheme->wmarks.activated = true;
>  
> +	scheme->node = node;
> +
>  	return scheme;
>  }
>  
> @@ -936,13 +938,18 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	return true;
>  }
>  
> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +static unsigned long damos_wmark_metric_value(struct damos *scheme)
>  {
>  	struct sysinfo i;
> +	enum damos_wmark_metric metric = scheme->wmarks.metric;
> +	int target_node = scheme->node;
>  
>  	switch (metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		si_meminfo(&i);
> +		if (target_node == NUMA_NO_NODE)
> +			si_meminfo(&i);
> +		else
> +			si_meminfo_node(&i, target_node);
>  		return i.freeram * 1000 / i.totalram;
>  	default:
>  		break;
> @@ -961,7 +968,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
>  		return 0;
>  
> -	metric = damos_wmark_metric_value(scheme->wmarks.metric);
> +	metric = damos_wmark_metric_value(scheme);
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 78ff645433c6..3f61cbde7ec4 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -224,7 +224,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  
>  		pos += parsed;
>  		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
> -				min_age, max_age, action, &quota, &wmarks);
> +				min_age, max_age, action, &quota, &wmarks,
> +				NUMA_NO_NODE);
>  		if (!scheme)
>  			goto fail;
>  
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index d85e0898f905..ad80f14d164f 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -189,6 +189,14 @@ module_param(monitor_region_start, ulong, 0600);
>  static unsigned long monitor_region_end __read_mostly;
>  module_param(monitor_region_end, ulong, 0600);
>  
> +/*
> + * NUMA node of target to monitor
> + *
> + * If node is NUMA_NO_NODE, watermark is based on system entire memory.
> + */
> +static int node __read_mostly = NUMA_NO_NODE;
> +module_param(node, int, 0600);
> +
>  /*
>   * PID of the DAMON thread
>   *
> @@ -298,7 +306,9 @@ static struct damos *damon_reclaim_new_scheme(void)
>  			/* under the quota. */
>  			&quota,
>  			/* (De)activate this according to the watermarks. */
> -			&wmarks);
> +			&wmarks,
> +			/* Watermarks is based on this NUMA node */
> +			node);
>  
>  	return scheme;
>  }
> -- 
> 2.17.1
> 
