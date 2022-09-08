Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D427B5B260C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiIHSoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIHSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:44:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57CB2DAF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6ACA7B821A0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:44:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B4EC433D6;
        Thu,  8 Sep 2022 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662662639;
        bh=/x/hyBW1wy1KUuwAUYQjJ+O8pXvMyPhg0wGOHKqslxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egsbTuHLWcdLFqrwYD9AnMT+X42TWqqvxD9WzZ/UQk60YNIKo1ZkH/GNIj8/j9jEH
         2042gnsfwhSnRIPt79wsnXiUzGwgT26mj6qaaTC+oaV1nXiVUlta9GuSGkMJ+VYTR+
         yqcN2+nKVwlyPXkeSrkaomRe/pSQsbNOUP2b76Wmr6ZwdFMd4G0reffN3S0HGf0Scv
         83UETD16dg7F3EJpSFjg2tW322+a6zSh/XHq0X+vZjf4PwJGgrfMZL65pg5/K6Vo97
         JfSHpxzQc5i5A0hkZ6mxN7HBQZgPv8fzYJ5TjnXK9Us5w4CqKeOH8ztKyrKPmscQOC
         qLxBvVgn5/vHA==
From:   SeongJae Park <sj@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon: introduce struct damos_access_pattern
Date:   Thu,  8 Sep 2022 18:43:56 +0000
Message-Id: <20220908184356.103133-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908032611.4072174-1-yajun.deng@linux.dev>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

On Thu, 8 Sep 2022 11:26:11 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> The damon_new_scheme() has too many parameters, we can introduce struct
> damos_access_pattern to simplify it.
> 
> In additon, we couldn't use bpf trace kprobe that more than 5 parameters.
> 
> v2:
>  - make the name of structure more sense.

Let's not put the change log here, but three lines after, after the marker line
('---')[1].

Also, providing the lore link to the previous version, e.g.,
https://lore.kernel.org/damon/20220907092626.3013765-1-yajun.deng@linux.dev/
for this case, in the change log would be a good practice.

[1] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---

>  include/linux/damon.h | 38 +++++++++++++++++++----------------
>  mm/damon/core.c       | 31 ++++++++++++++---------------
>  mm/damon/dbgfs.c      | 22 +++++++++++----------
>  mm/damon/lru_sort.c   | 46 ++++++++++++++++++++++++++-----------------
>  mm/damon/reclaim.c    | 23 +++++++++++++---------
>  mm/damon/sysfs.c      | 16 ++++++++++-----
>  6 files changed, 101 insertions(+), 75 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 7b1f4a488230..7ddfb4551a13 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -216,13 +216,27 @@ struct damos_stat {
>  };
>  
>  /**
> - * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
> + * struct damos_access_pattern - Specify the access pattern of target regions.
>   * @min_sz_region:	Minimum size of target regions.
>   * @max_sz_region:	Maximum size of target regions.
>   * @min_nr_accesses:	Minimum ``->nr_accesses`` of target regions.
>   * @max_nr_accesses:	Maximum ``->nr_accesses`` of target regions.
>   * @min_age_region:	Minimum age of target regions.
>   * @max_age_region:	Maximum age of target regions.
> + */
> +

Unnecessary new line.  Let's remove it.

> +struct damos_access_pattern {
> +	unsigned long min_sz_region;
> +	unsigned long max_sz_region;
> +	unsigned int min_nr_accesses;
> +	unsigned int max_nr_accesses;
> +	unsigned int min_age_region;
> +	unsigned int max_age_region;
> +};
> +
> +/**
> + * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
> + * @pattern:		Access pattern of target regions.
>   * @action:		&damo_action to be applied to the target regions.
>   * @quota:		Control the aggressiveness of this scheme.
>   * @wmarks:		Watermarks for automated (in)activation of this scheme.
> @@ -230,10 +244,8 @@ struct damos_stat {
>   * @list:		List head for siblings.
>   *
>   * For each aggregation interval, DAMON finds regions which fit in the
> - * condition (&min_sz_region, &max_sz_region, &min_nr_accesses,
> - * &max_nr_accesses, &min_age_region, &max_age_region) and applies &action to
> - * those.  To avoid consuming too much CPU time or IO resources for the
> - * &action, &quota is used.
> + * &pattern and applies &action to those. To avoid consuming too much
> + * CPU time or IO resources for the &action, &quota is used.
>   *
>   * To do the work only when needed, schemes can be activated for specific
>   * system situations using &wmarks.  If all schemes that registered to the
> @@ -248,12 +260,7 @@ struct damos_stat {
>   * &action is applied.
>   */
>  struct damos {
> -	unsigned long min_sz_region;
> -	unsigned long max_sz_region;
> -	unsigned int min_nr_accesses;
> -	unsigned int max_nr_accesses;
> -	unsigned int min_age_region;
> -	unsigned int max_age_region;
> +	struct damos_access_pattern pattern;
>  	enum damos_action action;
>  	struct damos_quota quota;
>  	struct damos_watermarks wmarks;
> @@ -501,12 +508,9 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t);
>  int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  		unsigned int nr_ranges);
>  
> -struct damos *damon_new_scheme(
> -		unsigned long min_sz_region, unsigned long max_sz_region,
> -		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
> -		unsigned int min_age_region, unsigned int max_age_region,
> -		enum damos_action action, struct damos_quota *quota,
> -		struct damos_watermarks *wmarks);
> +struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
> +			enum damos_action action, struct damos_quota *quota,
> +			struct damos_watermarks *wmarks);
>  void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
>  void damon_destroy_scheme(struct damos *s);
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9964b9d00768..57450a0160ab 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -230,24 +230,21 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  	return 0;
>  }
>  
> -struct damos *damon_new_scheme(
> -		unsigned long min_sz_region, unsigned long max_sz_region,
> -		unsigned int min_nr_accesses, unsigned int max_nr_accesses,
> -		unsigned int min_age_region, unsigned int max_age_region,
> -		enum damos_action action, struct damos_quota *quota,
> -		struct damos_watermarks *wmarks)
> +struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
> +			enum damos_action action, struct damos_quota *quota,
> +			struct damos_watermarks *wmarks)
>  {
>  	struct damos *scheme;
>  
>  	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
>  	if (!scheme)
>  		return NULL;
> -	scheme->min_sz_region = min_sz_region;
> -	scheme->max_sz_region = max_sz_region;
> -	scheme->min_nr_accesses = min_nr_accesses;
> -	scheme->max_nr_accesses = max_nr_accesses;
> -	scheme->min_age_region = min_age_region;
> -	scheme->max_age_region = max_age_region;
> +	scheme->pattern.min_sz_region = pattern->min_sz_region;
> +	scheme->pattern.max_sz_region = pattern->max_sz_region;
> +	scheme->pattern.min_nr_accesses = pattern->min_nr_accesses;
> +	scheme->pattern.max_nr_accesses = pattern->max_nr_accesses;
> +	scheme->pattern.min_age_region = pattern->min_age_region;
> +	scheme->pattern.max_age_region = pattern->max_age_region;
>  	scheme->action = action;
>  	scheme->stat = (struct damos_stat){};
>  	INIT_LIST_HEAD(&scheme->list);
> @@ -666,10 +663,12 @@ static bool __damos_valid_target(struct damon_region *r, struct damos *s)
>  	unsigned long sz;
>  
>  	sz = r->ar.end - r->ar.start;
> -	return s->min_sz_region <= sz && sz <= s->max_sz_region &&
> -		s->min_nr_accesses <= r->nr_accesses &&
> -		r->nr_accesses <= s->max_nr_accesses &&
> -		s->min_age_region <= r->age && r->age <= s->max_age_region;
> +	return s->pattern.min_sz_region <= sz &&
> +		sz <= s->pattern.max_sz_region &&
> +		s->pattern.min_nr_accesses <= r->nr_accesses &&
> +		r->nr_accesses <= s->pattern.max_nr_accesses &&
> +		s->pattern.min_age_region <= r->age &&
> +		r->age <= s->pattern.max_age_region;
>  }
>  
>  static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 652a94deafe3..5624e1805bb3 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -131,9 +131,9 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
>  	damon_for_each_scheme(s, c) {
>  		rc = scnprintf(&buf[written], len - written,
>  				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %d %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
> -				s->min_sz_region, s->max_sz_region,
> -				s->min_nr_accesses, s->max_nr_accesses,
> -				s->min_age_region, s->max_age_region,
> +				s->pattern.min_sz_region, s->pattern.max_sz_region,
> +				s->pattern.min_nr_accesses, s->pattern.max_nr_accesses,
> +				s->pattern.min_age_region, s->pattern.max_age_region,

Sorry, I prefer 80 columns rule:
https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

>  				damos_action_to_dbgfs_scheme_action(s->action),
>  				s->quota.ms, s->quota.sz,
>  				s->quota.reset_interval,
> @@ -221,8 +221,6 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  	struct damos *scheme, **schemes;
>  	const int max_nr_schemes = 256;
>  	int pos = 0, parsed, ret;
> -	unsigned long min_sz, max_sz;
> -	unsigned int min_nr_a, max_nr_a, min_age, max_age;
>  	unsigned int action_input;
>  	enum damos_action action;
>  
> @@ -233,13 +231,16 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  
>  	*nr_schemes = 0;
>  	while (pos < len && *nr_schemes < max_nr_schemes) {
> +		struct damos_access_pattern pattern = {};
>  		struct damos_quota quota = {};
>  		struct damos_watermarks wmarks;
>  
>  		ret = sscanf(&str[pos],
>  				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
> -				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
> -				&min_age, &max_age, &action_input, &quota.ms,
> +				&pattern.min_sz_region, &pattern.max_sz_region,
> +				&pattern.min_nr_accesses, &pattern.max_nr_accesses,
> +				&pattern.min_age_region, &pattern.max_age_region,

80 columns, again.

> +				&action_input, &quota.ms,
>  				&quota.sz, &quota.reset_interval,
>  				&quota.weight_sz, &quota.weight_nr_accesses,
>  				&quota.weight_age, &wmarks.metric,
> @@ -251,7 +252,9 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  		if ((int)action < 0)
>  			goto fail;
>  
> -		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
> +		if (pattern.min_sz_region > pattern.max_sz_region ||
> +		    pattern.min_nr_accesses > pattern.max_nr_accesses ||
> +		    pattern.min_age_region > pattern.max_age_region)
>  			goto fail;
>  
>  		if (wmarks.high < wmarks.mid || wmarks.high < wmarks.low ||
> @@ -259,8 +262,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>  			goto fail;
>  
>  		pos += parsed;
> -		scheme = damon_new_scheme(min_sz, max_sz, min_nr_a, max_nr_a,
> -				min_age, max_age, action, &quota, &wmarks);
> +		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
>  		if (!scheme)
>  			goto fail;
>  
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 9de6f00a71c5..59f6115e59de 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -293,6 +293,17 @@ static bool get_monitoring_region(unsigned long *start, unsigned long *end)
>  /* Create a DAMON-based operation scheme for hot memory regions */
>  static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  {
> +	struct damos_access_pattern pattern = {
> +		/* Find regions having PAGE_SIZE or larger size */
> +		.min_sz_region = PAGE_SIZE,
> +		.max_sz_region = ULONG_MAX,
> +		/* and accessed for more than the threshold */
> +		.min_nr_accesses = hot_thres,
> +		.max_nr_accesses = UINT_MAX,
> +		/* no matter its age*/

Let's add one space before closing the comment.

> +		.min_age_region = 0,
> +		.max_age_region = UINT_MAX,
> +	};
>  	struct damos_watermarks wmarks = {
>  		.metric = DAMOS_WMARK_FREE_MEM_RATE,
>  		.interval = wmarks_interval,
> @@ -313,26 +324,31 @@ static struct damos *damon_lru_sort_new_hot_scheme(unsigned int hot_thres)
>  		.weight_nr_accesses = 1,
>  		.weight_age = 0,
>  	};
> -	struct damos *scheme = damon_new_scheme(
> -			/* Find regions having PAGE_SIZE or larger size */
> -			PAGE_SIZE, ULONG_MAX,
> -			/* and accessed for more than the threshold */
> -			hot_thres, UINT_MAX,
> -			/* no matter its age */
> -			0, UINT_MAX,
> +
> +	return damon_new_scheme(
> +			&pattern,
>  			/* prioritize those on LRU lists, as soon as found */
>  			DAMOS_LRU_PRIO,
>  			/* under the quota. */
>  			&quota,
>  			/* (De)activate this according to the watermarks. */
>  			&wmarks);
> -
> -	return scheme;
>  }
>  
>  /* Create a DAMON-based operation scheme for cold memory regions */
>  static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>  {
> +	struct damos_access_pattern pattern = {
> +		/* Find regions having PAGE_SIZE or larger size */
> +		.min_sz_region = PAGE_SIZE,
> +		.max_sz_region = ULONG_MAX,
> +		/* and not accessed at all */
> +		.min_nr_accesses = 0,
> +		.max_nr_accesses = 0,
> +		/* for min_age or more micro-seconds*/

One space before closing the comment.

> +		.min_age_region = cold_thres,
> +		.max_age_region = UINT_MAX,
> +	};
>  	struct damos_watermarks wmarks = {
>  		.metric = DAMOS_WMARK_FREE_MEM_RATE,
>  		.interval = wmarks_interval,
> @@ -354,21 +370,15 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
>  		.weight_nr_accesses = 0,
>  		.weight_age = 1,
>  	};
> -	struct damos *scheme = damon_new_scheme(
> -			/* Find regions having PAGE_SIZE or larger size */
> -			PAGE_SIZE, ULONG_MAX,
> -			/* and not accessed at all */
> -			0, 0,
> -			/* for cold_thres or more micro-seconds, and */
> -			cold_thres, UINT_MAX,
> +
> +	return damon_new_scheme(
> +			&pattern,
>  			/* mark those as not accessed, as soon as found */
>  			DAMOS_LRU_DEPRIO,
>  			/* under the quota. */
>  			&quota,
>  			/* (De)activate this according to the watermarks. */
>  			&wmarks);
> -
> -	return scheme;
>  }
>  
>  static int damon_lru_sort_apply_parameters(void)
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index a7faf51b4bd4..3d78dcca1701 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -264,6 +264,17 @@ static bool get_monitoring_region(unsigned long *start, unsigned long *end)
>  
>  static struct damos *damon_reclaim_new_scheme(void)
>  {
> +	struct damos_access_pattern pattern = {
> +		/* Find regions having PAGE_SIZE or larger size */
> +		.min_sz_region = PAGE_SIZE,
> +		.max_sz_region = ULONG_MAX,
> +		/* and not accessed at all */
> +		.min_nr_accesses = 0,
> +		.max_nr_accesses = 0,
> +		/* for min_age or more micro-seconds*/

One space before closing the comment.

> +		.min_age_region = min_age / aggr_interval,
> +		.max_age_region = UINT_MAX,
> +	};
>  	struct damos_watermarks wmarks = {
>  		.metric = DAMOS_WMARK_FREE_MEM_RATE,
>  		.interval = wmarks_interval,
> @@ -284,21 +295,15 @@ static struct damos *damon_reclaim_new_scheme(void)
>  		.weight_nr_accesses = 0,
>  		.weight_age = 1
>  	};
> -	struct damos *scheme = damon_new_scheme(
> -			/* Find regions having PAGE_SIZE or larger size */
> -			PAGE_SIZE, ULONG_MAX,
> -			/* and not accessed at all */
> -			0, 0,
> -			/* for min_age or more micro-seconds, and */
> -			min_age / aggr_interval, UINT_MAX,
> +
> +	return damon_new_scheme(
> +			&pattern,
>  			/* page out those, as soon as found */
>  			DAMOS_PAGEOUT,
>  			/* under the quota. */
>  			&quota,
>  			/* (De)activate this according to the watermarks. */
>  			&wmarks);
> -
> -	return scheme;
>  }
>  
>  static int damon_reclaim_apply_parameters(void)
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index fe6c6870cf86..012b5e9476bc 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2259,11 +2259,20 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
>  static struct damos *damon_sysfs_mk_scheme(
>  		struct damon_sysfs_scheme *sysfs_scheme)
>  {
> -	struct damon_sysfs_access_pattern *pattern =
> +	struct damon_sysfs_access_pattern *access_pattern =
>  		sysfs_scheme->access_pattern;
>  	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
>  	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
>  	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
> +
> +	struct damos_access_pattern pattern = {
> +		.min_sz_region = access_pattern->sz->min,
> +		.max_sz_region = access_pattern->sz->max,
> +		.min_nr_accesses = access_pattern->nr_accesses->min,
> +		.max_nr_accesses = access_pattern->nr_accesses->max,
> +		.min_age_region = access_pattern->age->min,
> +		.max_age_region = access_pattern->age->max,
> +	};
>  	struct damos_quota quota = {
>  		.ms = sysfs_quotas->ms,
>  		.sz = sysfs_quotas->sz,
> @@ -2280,10 +2289,7 @@ static struct damos *damon_sysfs_mk_scheme(
>  		.low = sysfs_wmarks->low,
>  	};
>  
> -	return damon_new_scheme(pattern->sz->min, pattern->sz->max,
> -			pattern->nr_accesses->min, pattern->nr_accesses->max,
> -			pattern->age->min, pattern->age->max,
> -			sysfs_scheme->action, &quota, &wmarks);
> +	return damon_new_scheme(&pattern, sysfs_scheme->action, &quota, &wmarks);

80 columns?

>  }
>  
>  static int damon_sysfs_set_schemes(struct damon_ctx *ctx,
> -- 
> 2.25.1


Thanks,
SJ
