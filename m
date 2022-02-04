Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3544A9823
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbiBDLD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiBDLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:03:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 03:03:24 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o64so5171842pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77J/9cAT8G0P2QjFVSqgddwHhlme/qdGmG1Npq3KbOA=;
        b=e3C0xbHqa+aqQV1a3DsrHp8/5RAJVBFGxIWO3i9omSxdtv3TVxNxiCEuKqqlj3cokG
         68xTSmvnRmHEX17OFTfUYByXv0dOIIFPBv9aDcIxi9ajYmL/nETzMVh5BoU9R8MeHrOK
         1EaqzQ/vj1hBN/gTSNA9QggbZ8fjdUB9Uq88E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77J/9cAT8G0P2QjFVSqgddwHhlme/qdGmG1Npq3KbOA=;
        b=76F/2d2DWM2lr7u2qhgRfvf+yYOZOQqznRVk0Q7+WFiuSheIwVOX1RRBy5BSxu455D
         sAPO1BeWFvS7b1/V4m0a3p7Z5t9xpuuNSM4yETSKKlLEdljHqsdLWDWcFCamkITwJpYM
         5tp99EV78pzTLdzGJo3pIBFaNS0LshlhqwSiOhS3D6GESSS4qcy3PC/GgZ2ec17LcO1n
         /J8uGouw57jcwe+2oFPQhVrqgLaCYB+MjN4yuFNT4VyiZDUeNzJH6fMq8Hy6G1tbpUy+
         D0ozAjY/JpRB6oR4q771UXqt8MsD5scT8ITMnQm0sTTEmGxIsaeCtqNgHDmms8TsDfDn
         KUaw==
X-Gm-Message-State: AOAM5323MnP0598KZU8sQfg544YXfZHHOzJWCWG9BzdWuilM1p49kERc
        srGAOJ2ev8CCAe15YqXg7YMfEUZ9umFmIbbk
X-Google-Smtp-Source: ABdhPJwJ2lTvQRgIPBiUT+p08XthZ0vM4moEekfuVEtjYx7Nnj+xo6Sd8dB2tWgbriB/QkIhOgSstg==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19mr2458946plo.69.1643972603170;
        Fri, 04 Feb 2022 03:03:23 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id q12sm2427939pfk.199.2022.02.04.03.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Feb 2022 03:03:22 -0800 (PST)
Date:   Fri, 4 Feb 2022 20:03:18 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Rebase DAMON_RECALIM watermarks for NUMA nodes
Message-ID: <20220204110318.GA9391@swarm08>
References: <20220204064059.6244-1-tome01@ajou.ac.kr>
 <20220204090642.2425-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204090642.2425-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:06:42AM +0000, SeongJae Park wrote:
> Hello Jonghyeon, thank you for this patch!

Hi, SeeongJae! Thank you for your review.

> 
> On Fri, 4 Feb 2022 15:40:59 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> 
> > Current DAMON_RECALIM is not compatible the NUMA memory system. To proactively
> > reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up before
> > kswapd does reclaim memory. However, the current watermark for proactive
> > reclamation is based on entire system free memory. So, though the one memory
> > node is fully used, kdamond is not waked up.
> 
> Good point!
> 
> > 
> > This patch allows kdamond thread to select watermark options for monitoring
> > specific node or whole system free memory.
> 
> Why only specific NUMA node or whole system, instead of each NUMA node?  Are
> you running DARC for only specific NUMA node?  If that's the case, I think
> implementing your own DAMON-based policy in user space might be a better
> choice.  For example, you could implement and use a user-space daemon that
> monitors free memory ratio of each NUMA node and adjusts the watermarks.
> 

I have tested DAMON_RECLAIM for each NUMA node by using a module. But, I felt
that the goal of DAMON_RECLAIM is dealing with the entire system memory or
specific monitoring regions by using module parameters. So, I hoped to add more
options for DAMON_RECLAIM on the NUMA system.

Another thing I considered is the problem of correlation between NUMA node range
and monitoring start/end addresses, such as "What if we monitor target that
spans multiple nodes?".
In that case, I guess we have to decide the policy for watermarks.

> Hope I'm not making you get me wrong.  You found the important limitation of
> DAMON_RECLAIM, thank you!  I really hope DAMON_RECLAIM to evolve to handle the
> case.  I'm just saying this patch looks like specialized for your special case,
> and there could be a better approach for that.
> 

If you agree that each NUMA node is able to have its own DAMON_RECLAIM daemon
threads, I will add that codes in the next patch.


Thanks for your comments,
Jonghyeon

> 
> Thanks,
> SJ
> 
> > 
> > Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> > ---
> >  include/linux/damon.h |  4 +++-
> >  mm/damon/core.c       | 15 +++++++++++----
> >  mm/damon/dbgfs.c      |  3 ++-
> >  mm/damon/reclaim.c    | 12 +++++++++++-
> >  4 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 114cfb96d37a..3846b985bcb9 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -220,6 +220,7 @@ struct damos_stat {
> >   * @wmarks:		Watermarks for automated (in)activation of this scheme.
> >   * @stat:		Statistics of this scheme.
> >   * @list:		List head for siblings.
> > + * @node:		NUMA node of target regions.
> >   *
> >   * For each aggregation interval, DAMON finds regions which fit in the
> >   * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
> > @@ -251,6 +252,7 @@ struct damos {
> >  	struct damos_watermarks wmarks;
> >  	struct damos_stat stat;
> >  	struct list_head list;
> > +	int node;
> >  };
> >  
> >  struct damon_ctx;
> > @@ -477,7 +479,7 @@ struct damos *damon_new_scheme(
> >  		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
> >  		unsigned int min_age_region, unsigned int max_age_region,
> >  		enum damos_action action, struct damos_quota *quota,
> > -		struct damos_watermarks *wmarks);
> > +		struct damos_watermarks *wmarks, int node);
> >  void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
> >  void damon_destroy_scheme(struct damos *s);
> >  
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 07449d46d3d3..dfa87cda0266 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -87,7 +87,7 @@ struct damos *damon_new_scheme(
> >  		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
> >  		unsigned int min_age_region, unsigned int max_age_region,
> >  		enum damos_action action, struct damos_quota *quota,
> > -		struct damos_watermarks *wmarks)
> > +		struct damos_watermarks *wmarks, int node)
> >  {
> >  	struct damos *scheme;
> >  
> > @@ -125,6 +125,8 @@ struct damos *damon_new_scheme(
> >  	scheme->wmarks.low = wmarks->low;
> >  	scheme->wmarks.activated = true;
> >  
> > +	scheme->node = node;
> > +
> >  	return scheme;
> >  }
> >  
> > @@ -936,13 +938,18 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
> >  	return true;
> >  }
> >  
> > -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> > +static unsigned long damos_wmark_metric_value(struct damos *scheme)
> >  {
> >  	struct sysinfo i;
> > +	enum damos_wmark_metric metric = scheme->wmarks.metric;
> > +	int target_node = scheme->node;
> >  
> >  	switch (metric) {
> >  	case DAMOS_WMARK_FREE_MEM_RATE:
> > -		si_meminfo(&i);
> > +		if (target_node == NUMA_NO_NODE)
> > +			si_meminfo(&i);
> > +		else
> > +			si_meminfo_node(&i, target_node);
> >  		return i.freeram * 1000 / i.totalram;
> >  	default:
> >  		break;
> > @@ -961,7 +968,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
> >  	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
> >  		return 0;
> >  
> > -	metric = damos_wmark_metric_value(scheme->wmarks.metric);
> > +	metric = damos_wmark_metric_value(scheme);
> >  	/* higher than high watermark or lower than low watermark */
> >  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
> >  		if (scheme->wmarks.activated)
> > diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> > index 78ff645433c6..3f61cbde7ec4 100644
> > --- a/mm/damon/dbgfs.c
> > +++ b/mm/damon/dbgfs.c
> > @@ -224,7 +224,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
> >  
> >  		pos += parsed;
> >  		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
> > -				min_age, max_age, action, &quota, &wmarks);
> > +				min_age, max_age, action, &quota, &wmarks,
> > +				NUMA_NO_NODE);
> >  		if (!scheme)
> >  			goto fail;
> >  
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index d85e0898f905..ad80f14d164f 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -189,6 +189,14 @@ module_param(monitor_region_start, ulong, 0600);
> >  static unsigned long monitor_region_end __read_mostly;
> >  module_param(monitor_region_end, ulong, 0600);
> >  
> > +/*
> > + * NUMA node of target to monitor
> > + *
> > + * If node is NUMA_NO_NODE, watermark is based on system entire memory.
> > + */
> > +static int node __read_mostly = NUMA_NO_NODE;
> > +module_param(node, int, 0600);
> > +
> >  /*
> >   * PID of the DAMON thread
> >   *
> > @@ -298,7 +306,9 @@ static struct damos *damon_reclaim_new_scheme(void)
> >  			/* under the quota. */
> >  			&quota,
> >  			/* (De)activate this according to the watermarks. */
> > -			&wmarks);
> > +			&wmarks,
> > +			/* Watermarks is based on this NUMA node */
> > +			node);
> >  
> >  	return scheme;
> >  }
> > -- 
> > 2.17.1
> > 
