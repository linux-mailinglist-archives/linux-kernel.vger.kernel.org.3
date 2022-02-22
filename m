Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070874BF52C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiBVJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiBVJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:54:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5BD21C7;
        Tue, 22 Feb 2022 01:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B1BA6153A;
        Tue, 22 Feb 2022 09:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F46C340E8;
        Tue, 22 Feb 2022 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645523621;
        bh=F4YU5btSyWnbJ1dSTHeJjSTPrCZ85OKd1X5G0fzR6UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=jXRN15ym8EMAYoqCQdCujee0++8yAd4QN00cMVrL39SLDFnrsJ2/nlNx7bvx28bhv
         aDwHv7E1A1bBTBa/peVDpiqknVVDYQ+fmNXBNfmeykiYnjt0OS15KuSGR1t5iMZJrx
         O7Q7u5W2p52W0sMA+GgkhEZWR7n5a73lL7xU2N1YMgS938GjYOq5x6TV6fi2klaR0v
         plXhnblddYwxEoT+gGxBmi1rZ0GL8Xz9nbWApUALAvliUX8IMy6o7nY86kCKVDI3An
         zrp1vWONoiero9ZyUFpRuMM/TF1ES6Fb+lrPbp4GD3R9lPCx4j15Ga3oRAWe3R7tQ2
         WoEUfcQAwSFpQ==
From:   SeongJae Park <sj@kernel.org>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     akpm@linux-foundation.org, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] mm/damon/reclaim: Add per NUMA node proactive reclamation by DAMON_RECLAIM.
Date:   Tue, 22 Feb 2022 09:53:38 +0000
Message-Id: <20220222095338.8013-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-4-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 19:26:11 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> To add DAMON_RECLAIM worker threads(kdamond) that do proactive
> reclamation per NUMA node, each node must have its own context.
> 'per_node' is added to enable it.
> 
> If 'per_node' is true, kdamonds as online NUMA node will be waked up and
> start monitoring to proactively reclaim memory. If 'per_node' is false,
> only one kdamond thread will start monitoring for all system memory.
> 
> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> ---
>  mm/damon/reclaim.c | 147 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 104 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index b53d9c22fad1..85e8f97dd599 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -177,13 +177,27 @@ static unsigned long monitor_region_end __read_mostly;
>  module_param(monitor_region_end, ulong, 0600);
>  
>  /*
> - * PID of the DAMON thread
> + * Enable monitoring memory regions per NUMA node.
>   *
> - * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
> + * By default, watermarks consist of based on total system memory.
> + */
> +static bool per_node __read_mostly;
> +module_param(per_node, bool, 0600);
> +
> +/*
> + * Number of currently running DAMON worker threads
> + */
> +static unsigned long nr_kdamond __read_mostly;
> +module_param(nr_kdamond, ulong, 0400);

I'd prefer to call this nr_kdamond*s*

> +
> +/*
> + * First PID of the DAMON threads
> + *
> + * If DAMON_RECLAIM is enabled, this becomes the first PID of the worker threads.
>   * Else, -1.
>   */
> -static int kdamond_pid __read_mostly = -1;
> -module_param(kdamond_pid, int, 0400);
> +static int kdamond_start_pid __read_mostly = -1;
> +module_param(kdamond_start_pid, int, 0400);

This change could break old users.  Let's keep the name as is and clarify the
fact that it's for only the first kdamond in the document.

As long as DAMON_RECLAIM works in the exclusive manner, users will still be
able to know all pids of kdamonds for DAMON_RECLAIM, as nr_kdamonds is also
provided. 

>  
>  /*
>   * Number of memory regions that tried to be reclaimed.
> @@ -215,8 +229,8 @@ module_param(bytes_reclaimed_regions, ulong, 0400);
>  static unsigned long nr_quota_exceeds __read_mostly;
>  module_param(nr_quota_exceeds, ulong, 0400);
>  
> -static struct damon_ctx *ctx;
> -static struct damon_target *target;
> +static struct damon_ctx *ctxs[MAX_NUMNODES];
> +static struct damon_target *targets[MAX_NUMNODES];
>  
>  struct damon_reclaim_ram_walk_arg {
>  	unsigned long start;
> @@ -251,7 +265,7 @@ static bool get_monitoring_region(unsigned long *start, unsigned long *end)
>  	return true;
>  }
>  
> -static struct damos *damon_reclaim_new_scheme(void)
> +static struct damos *damon_reclaim_new_scheme(int node)
>  {
>  	struct damos_watermarks wmarks = {
>  		.metric = DAMOS_WMARK_FREE_MEM_RATE,
> @@ -259,6 +273,7 @@ static struct damos *damon_reclaim_new_scheme(void)
>  		.high = wmarks_high,
>  		.mid = wmarks_mid,
>  		.low = wmarks_low,
> +		.node = node,
>  	};
>  	struct damos_quota quota = {
>  		/*
> @@ -290,56 +305,99 @@ static struct damos *damon_reclaim_new_scheme(void)
>  	return scheme;
>  }
>  
> -static int damon_reclaim_turn(bool on)
> +static int damon_reclaim_start(int nid)
>  {
>  	struct damon_region *region;
>  	struct damos *scheme;
>  	int err;
> +	unsigned long start, end;
>  
> -	if (!on) {
> -		err = damon_stop(&ctx, 1);
> -		if (!err)
> -			kdamond_pid = -1;
> -		return err;
> -	}
> -
> -	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
> +	err = damon_set_attrs(ctxs[nid], sample_interval, aggr_interval, 0,
>  			min_nr_regions, max_nr_regions);
>  	if (err)
>  		return err;
>  
> -	if (monitor_region_start > monitor_region_end)
> -		return -EINVAL;
> -	if (!monitor_region_start && !monitor_region_end &&
> -			!get_monitoring_region(&monitor_region_start,
> -				&monitor_region_end))
> -		return -EINVAL;
> +	if (per_node) {
> +		monitor_region_start = monitor_region_end = 0;
> +
> +		start = PFN_PHYS(node_start_pfn(nid));
> +		end = PFN_PHYS(node_start_pfn(nid) + node_present_pages(nid) - 1);
> +		if (end <= start)
> +			return -EINVAL;
> +	} else {
> +		if (!monitor_region_start && !monitor_region_end &&
> +				!get_monitoring_region(&monitor_region_start,
> +					&monitor_region_end))
> +			return -EINVAL;
> +		start = monitor_region_start;
> +		end = monitor_region_end;
> +	}
> +
>  	/* DAMON will free this on its own when finish monitoring */
> -	region = damon_new_region(monitor_region_start, monitor_region_end);
> +	region = damon_new_region(start, end);
>  	if (!region)
>  		return -ENOMEM;
> -	damon_add_region(region, target);
> +	damon_add_region(region, targets[nid]);
>  
>  	/* Will be freed by 'damon_set_schemes()' below */
> -	scheme = damon_reclaim_new_scheme();
> +	scheme = damon_reclaim_new_scheme(nid);
>  	if (!scheme) {
>  		err = -ENOMEM;
>  		goto free_region_out;
>  	}
> -	err = damon_set_schemes(ctx, &scheme, 1);
> +
> +	err = damon_set_schemes(ctxs[nid], &scheme, 1);
>  	if (err)
>  		goto free_scheme_out;
>  
> -	err = damon_start(&ctx, 1);
> +	err = damon_start_one(ctxs[nid]);

This could surprise users assuming DAMON_RECLAIM would work in exclusive manner
as it was.

>  	if (!err) {
> -		kdamond_pid = ctx->kdamond->pid;
> +		if (kdamond_start_pid == -1)
> +			kdamond_start_pid = ctxs[nid]->kdamond->pid;
> +		nr_kdamond++;
>  		return 0;
>  	}
>  
>  free_scheme_out:
>  	damon_destroy_scheme(scheme);
>  free_region_out:
> -	damon_destroy_region(region, target);
> +	damon_destroy_region(region, targets[nid]);
> +
> +	return err;
> +}
> +
> +static int damon_reclaim_start_all(void)
> +{
> +	int nid, err;
> +
> +	if (!per_node)
> +		return damon_reclaim_start(0);
> +
> +	for_each_online_node(nid) {
> +		err = damon_reclaim_start(nid);
> +		if (err)
> +			break;

I'd prefer making contexts first and starting them at once in the exclusive
manner using damon_start().

> +	}
> +
> +	return err;
> +}
> +
> +static int damon_reclaim_turn(bool on)
> +{
> +	int err;
> +
> +	if (!on) {
> +		err = damon_stop(ctxs, nr_kdamond);
> +		if (!err) {
> +			kdamond_start_pid = -1;
> +			nr_kdamond = 0;
> +			monitor_region_start = 0;
> +			monitor_region_end = 0;
> +		}
> +		return err;
> +	}
> +
> +	err = damon_reclaim_start_all();
>  	return err;
>  }
>  
> @@ -380,21 +438,24 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
>  
>  static int __init damon_reclaim_init(void)
>  {
> -	ctx = damon_new_ctx();
> -	if (!ctx)
> -		return -ENOMEM;
> -
> -	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> -		return -EINVAL;
> -
> -	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
> -
> -	target = damon_new_target();
> -	if (!target) {
> -		damon_destroy_ctx(ctx);
> -		return -ENOMEM;
> +	int nid;
> +
> +	for_each_node(nid) {
> +		ctxs[nid] = damon_new_ctx();
> +		if (!ctxs[nid])
> +			return -ENOMEM;
> +
> +		if (damon_select_ops(ctxs[nid], DAMON_OPS_PADDR))
> +			return -EINVAL;
> +		ctxs[nid]->callback.after_aggregation = damon_reclaim_after_aggregation;
> +
> +		targets[nid] = damon_new_target();
> +		if (!targets[nid]) {
> +			damon_destroy_ctx(ctxs[nid]);

Shouldn't we also destroy previously allocated contexts?

> +			return -ENOMEM;
> +		}
> +		damon_add_target(ctxs[nid], targets[nid]);
>  	}
> -	damon_add_target(ctx, target);
>  
>  	schedule_delayed_work(&damon_reclaim_timer, 0);
>  	return 0;
> -- 
> 2.17.1


Thanks,
SJ
