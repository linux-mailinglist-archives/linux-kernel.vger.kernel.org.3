Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3864C0D13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238586AbiBWHMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiBWHMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:12:36 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E240901
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:12:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p23so19140484pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqjGZ/5W/XYO2JJ2XhrqBDMuWS6fGYhvkcJEoT2fMbk=;
        b=CllzQiwYsAdSNPcFt1Pad0hkFRTslh0zMytNphmUJZb9GEwvXeMq+5wVzCB/xd+S+D
         FjqnFt/RFOOJpTQEYDQa3du2dgFHR65DUExMZfW9L/akwd4argovefe7gwutf8LdHR5F
         E0Gz+bOHrB2RgpiHKHDrsmc5gMq41B9raEU2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqjGZ/5W/XYO2JJ2XhrqBDMuWS6fGYhvkcJEoT2fMbk=;
        b=ypReDa3tV1L2VEvuFd0En86fj0gghceBFQJii8yWkF+gFBvy5WqOHpijJm1gsjOQdX
         0pCywXkDKNOz2ND6gDhfzsnoK9fHvbYlC2NYqMOPbQHI3Tv35lM53RMqkB1G7l3BE80v
         lQtnhlKdwJ+Jw+NMus8V1s5tErpFlJBIGb5+FesminbGrfmKHdgeXQpR0qMRIEHVGRUu
         f6rYkTlW6MWqh0/793+BQVGKEeKrE4WhwYPDMzx7rb+/I8uoiNvCj6cGvDaHsoUPb8Ru
         YIwxUwevNoCEa6l4gCvlkdCOsR+k/1BWrClwIvT5cN2HApoqwJvep0yITT4cYSbs1bC3
         j8CA==
X-Gm-Message-State: AOAM533TvLxzArvttjeW2xlLYAuD0g3Cow1NpdPp4vQlDZrcnoHlWD5s
        8+mkgSBwkTy7fNe4QlLJz6DTDA==
X-Google-Smtp-Source: ABdhPJx9Rf43lu3qsDET5Vb2a1lO8fQWLSaF1u8rWt17NnfgWyQ97ya3zEFpOPptYFjoLRdjwsJdvg==
X-Received: by 2002:a05:6a00:24ca:b0:4e1:cb76:32da with SMTP id d10-20020a056a0024ca00b004e1cb7632damr27421577pfv.81.1645600327859;
        Tue, 22 Feb 2022 23:12:07 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id pj14sm1725610pjb.43.2022.02.22.23.12.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Feb 2022 23:12:07 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:12:01 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] mm/damon/reclaim: Add per NUMA node proactive
 reclamation by DAMON_RECLAIM.
Message-ID: <20220223071201.GC6270@swarm08>
References: <20220218102611.31895-4-tome01@ajou.ac.kr>
 <20220222095338.8013-1-sj@kernel.org>
 <20220223051127.GA3588@swarm08>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223051127.GA3588@swarm08>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:11:27PM +0900, Jonghyeon Kim wrote:
> On Tue, Feb 22, 2022 at 09:53:38AM +0000, SeongJae Park wrote:
> > On Fri, 18 Feb 2022 19:26:11 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> > 
> > > To add DAMON_RECLAIM worker threads(kdamond) that do proactive
> > > reclamation per NUMA node, each node must have its own context.
> > > 'per_node' is added to enable it.
> > > 
> > > If 'per_node' is true, kdamonds as online NUMA node will be waked up and
> > > start monitoring to proactively reclaim memory. If 'per_node' is false,
> > > only one kdamond thread will start monitoring for all system memory.
> > > 
> > > Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> > > ---
> > >  mm/damon/reclaim.c | 147 ++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 104 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > > index b53d9c22fad1..85e8f97dd599 100644
> > > --- a/mm/damon/reclaim.c
> > > +++ b/mm/damon/reclaim.c
> > > @@ -177,13 +177,27 @@ static unsigned long monitor_region_end __read_mostly;
> > >  module_param(monitor_region_end, ulong, 0600);
> > >  
> > >  /*
> > > - * PID of the DAMON thread
> > > + * Enable monitoring memory regions per NUMA node.
> > >   *
> > > - * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
> > > + * By default, watermarks consist of based on total system memory.
> > > + */
> > > +static bool per_node __read_mostly;
> > > +module_param(per_node, bool, 0600);
> > > +
> > > +/*
> > > + * Number of currently running DAMON worker threads
> > > + */
> > > +static unsigned long nr_kdamond __read_mostly;
> > > +module_param(nr_kdamond, ulong, 0400);
> > 
> > I'd prefer to call this nr_kdamond*s*
> > 
> 
> I see.
> 
> > > +
> > > +/*
> > > + * First PID of the DAMON threads
> > > + *
> > > + * If DAMON_RECLAIM is enabled, this becomes the first PID of the worker threads.
> > >   * Else, -1.
> > >   */
> > > -static int kdamond_pid __read_mostly = -1;
> > > -module_param(kdamond_pid, int, 0400);
> > > +static int kdamond_start_pid __read_mostly = -1;
> > > +module_param(kdamond_start_pid, int, 0400);
> > 
> > This change could break old users.  Let's keep the name as is and clarify the
> > fact that it's for only the first kdamond in the document.
> 
> Got it, I will keep that name and update the DAMON document.
> 
> > 
> > As long as DAMON_RECLAIM works in the exclusive manner, users will still be
> > able to know all pids of kdamonds for DAMON_RECLAIM, as nr_kdamonds is also
> > provided. 
> 
> I will find some kind of way to show all pids of kdamonds.
> 
> > 
> > >  
> > >  /*
> > >   * Number of memory regions that tried to be reclaimed.
> > > @@ -215,8 +229,8 @@ module_param(bytes_reclaimed_regions, ulong, 0400);
> > >  static unsigned long nr_quota_exceeds __read_mostly;
> > >  module_param(nr_quota_exceeds, ulong, 0400);
> > >  
> > > -static struct damon_ctx *ctx;
> > > -static struct damon_target *target;
> > > +static struct damon_ctx *ctxs[MAX_NUMNODES];
> > > +static struct damon_target *targets[MAX_NUMNODES];
> > >  
> > >  struct damon_reclaim_ram_walk_arg {
> > >  	unsigned long start;
> > > @@ -251,7 +265,7 @@ static bool get_monitoring_region(unsigned long *start, unsigned long *end)
> > >  	return true;
> > >  }
> > >  
> > > -static struct damos *damon_reclaim_new_scheme(void)
> > > +static struct damos *damon_reclaim_new_scheme(int node)
> > >  {
> > >  	struct damos_watermarks wmarks = {
> > >  		.metric = DAMOS_WMARK_FREE_MEM_RATE,
> > > @@ -259,6 +273,7 @@ static struct damos *damon_reclaim_new_scheme(void)
> > >  		.high = wmarks_high,
> > >  		.mid = wmarks_mid,
> > >  		.low = wmarks_low,
> > > +		.node = node,
> > >  	};
> > >  	struct damos_quota quota = {
> > >  		/*
> > > @@ -290,56 +305,99 @@ static struct damos *damon_reclaim_new_scheme(void)
> > >  	return scheme;
> > >  }
> > >  
> > > -static int damon_reclaim_turn(bool on)
> > > +static int damon_reclaim_start(int nid)
> > >  {
> > >  	struct damon_region *region;
> > >  	struct damos *scheme;
> > >  	int err;
> > > +	unsigned long start, end;
> > >  
> > > -	if (!on) {
> > > -		err = damon_stop(&ctx, 1);
> > > -		if (!err)
> > > -			kdamond_pid = -1;
> > > -		return err;
> > > -	}
> > > -
> > > -	err = damon_set_attrs(ctx, sample_interval, aggr_interval, 0,
> > > +	err = damon_set_attrs(ctxs[nid], sample_interval, aggr_interval, 0,
> > >  			min_nr_regions, max_nr_regions);
> > >  	if (err)
> > >  		return err;
> > >  
> > > -	if (monitor_region_start > monitor_region_end)
> > > -		return -EINVAL;
> > > -	if (!monitor_region_start && !monitor_region_end &&
> > > -			!get_monitoring_region(&monitor_region_start,
> > > -				&monitor_region_end))
> > > -		return -EINVAL;
> > > +	if (per_node) {
> > > +		monitor_region_start = monitor_region_end = 0;
> > > +
> > > +		start = PFN_PHYS(node_start_pfn(nid));
> > > +		end = PFN_PHYS(node_start_pfn(nid) + node_present_pages(nid) - 1);
> > > +		if (end <= start)
> > > +			return -EINVAL;
> > > +	} else {
> > > +		if (!monitor_region_start && !monitor_region_end &&
> > > +				!get_monitoring_region(&monitor_region_start,
> > > +					&monitor_region_end))
> > > +			return -EINVAL;
> > > +		start = monitor_region_start;
> > > +		end = monitor_region_end;
> > > +	}
> > > +
> > >  	/* DAMON will free this on its own when finish monitoring */
> > > -	region = damon_new_region(monitor_region_start, monitor_region_end);
> > > +	region = damon_new_region(start, end);
> > >  	if (!region)
> > >  		return -ENOMEM;
> > > -	damon_add_region(region, target);
> > > +	damon_add_region(region, targets[nid]);
> > >  
> > >  	/* Will be freed by 'damon_set_schemes()' below */
> > > -	scheme = damon_reclaim_new_scheme();
> > > +	scheme = damon_reclaim_new_scheme(nid);
> > >  	if (!scheme) {
> > >  		err = -ENOMEM;
> > >  		goto free_region_out;
> > >  	}
> > > -	err = damon_set_schemes(ctx, &scheme, 1);
> > > +
> > > +	err = damon_set_schemes(ctxs[nid], &scheme, 1);
> > >  	if (err)
> > >  		goto free_scheme_out;
> > >  
> > > -	err = damon_start(&ctx, 1);
> > > +	err = damon_start_one(ctxs[nid]);
> > 
> > This could surprise users assuming DAMON_RECLAIM would work in exclusive manner
> > as it was.
> 
> Yes, I will drop this function following the next version.
> 
> > 
> > >  	if (!err) {
> > > -		kdamond_pid = ctx->kdamond->pid;
> > > +		if (kdamond_start_pid == -1)
> > > +			kdamond_start_pid = ctxs[nid]->kdamond->pid;
> > > +		nr_kdamond++;
> > >  		return 0;
> > >  	}
> > >  
> > >  free_scheme_out:
> > >  	damon_destroy_scheme(scheme);
> > >  free_region_out:
> > > -	damon_destroy_region(region, target);
> > > +	damon_destroy_region(region, targets[nid]);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int damon_reclaim_start_all(void)
> > > +{
> > > +	int nid, err;
> > > +
> > > +	if (!per_node)
> > > +		return damon_reclaim_start(0);
> > > +
> > > +	for_each_online_node(nid) {
> > > +		err = damon_reclaim_start(nid);
> > > +		if (err)
> > > +			break;
> > 
> > I'd prefer making contexts first and starting them at once in the exclusive
> > manner using damon_start().
> > 
> 
> Agree.
> 
> > > +	}
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static int damon_reclaim_turn(bool on)
> > > +{
> > > +	int err;
> > > +
> > > +	if (!on) {
> > > +		err = damon_stop(ctxs, nr_kdamond);
> > > +		if (!err) {
> > > +			kdamond_start_pid = -1;
> > > +			nr_kdamond = 0;
> > > +			monitor_region_start = 0;
> > > +			monitor_region_end = 0;
> > > +		}
> > > +		return err;
> > > +	}
> > > +
> > > +	err = damon_reclaim_start_all();
> > >  	return err;
> > >  }
> > >  
> > > @@ -380,21 +438,24 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
> > >  
> > >  static int __init damon_reclaim_init(void)
> > >  {
> > > -	ctx = damon_new_ctx();
> > > -	if (!ctx)
> > > -		return -ENOMEM;
> > > -
> > > -	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
> > > -		return -EINVAL;
> > > -
> > > -	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
> > > -
> > > -	target = damon_new_target();
> > > -	if (!target) {
> > > -		damon_destroy_ctx(ctx);
> > > -		return -ENOMEM;
> > > +	int nid;
> > > +
> > > +	for_each_node(nid) {
> > > +		ctxs[nid] = damon_new_ctx();
> > > +		if (!ctxs[nid])
> > > +			return -ENOMEM;
> > > +
> > > +		if (damon_select_ops(ctxs[nid], DAMON_OPS_PADDR))
> > > +			return -EINVAL;
> > > +		ctxs[nid]->callback.after_aggregation = damon_reclaim_after_aggregation;
> > > +
> > > +		targets[nid] = damon_new_target();
> > > +		if (!targets[nid]) {
> > > +			damon_destroy_ctx(ctxs[nid]);
> > 
> > Shouldn't we also destroy previously allocated contexts?
> 
> Yes, I think so. I will fix.
> 
> > 
> > > +			return -ENOMEM;
> > > +		}
> > > +		damon_add_target(ctxs[nid], targets[nid]);
> > >  	}
> > > -	damon_add_target(ctx, target);
> > >  
> > >  	schedule_delayed_work(&damon_reclaim_timer, 0);
> > >  	return 0;
> > > -- 
> > > 2.17.1
> > 
> > 
> > Thanks,
> > SJ
> 
> 
> Thanks for the comments!
> Jonghyeon
