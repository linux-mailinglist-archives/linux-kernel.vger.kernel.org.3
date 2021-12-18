Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278C447980D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhLRBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D835C061574;
        Fri, 17 Dec 2021 17:47:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A11796239C;
        Sat, 18 Dec 2021 01:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC5C36AE1;
        Sat, 18 Dec 2021 01:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639792057;
        bh=ORujhWxEoPslKZOGaQLU33yoJ4Y4CfjDP2Bc1taEGbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6JKP9p/g4lXpIjr2E30rG4uiBt72qorlUnNV+mxTEa/ZPSWbAxu+BsCLA+yziNNn
         oWt5zFQpIaWf856tGyGvm2nO6ljrZfj+8hX4xhZPOGZoTqkFpCnESuOu9EFSDmrPDX
         f2HJABSYLOgasUBhn9H07Bi70XvnZfYzOMzqFhqVxG+9/G1WP5i/VYoGg9ud05k5yR
         pSnq3MjKvq1PUAZOnTn0T6EoLQnUGYuiRZl+bqBYQDDjuAzpoa8e3ky8OV66tDAJzs
         4mpSO7GJHNuW77Ba3EB8btJM1WUJf0c+7bTTdN+fo64UHhe4zoy1qOeh5k+Ra6SKKf
         bl1YmXWwD0kxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 48EB740B92; Fri, 17 Dec 2021 22:47:35 -0300 (-03)
Date:   Fri, 17 Dec 2021 22:47:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Message-ID: <Yb09t/AAFexaGE+j@kernel.org>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 16, 2021 at 11:53:37PM +0800, John Garry escreveu:
> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> changed the list for uncore PMUs, such that duplicate aliases are now
> listed per PMU (which they should not be), like:
> 
> ./perf list
> ...
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> ...
> 
> Notice how the events are listed twice.

Hi Jin,

	Can I have your acked-by/tested-by?

- Arnaldo
 
> The named commit changed how we remove duplicate events, in that events
> for different PMUs are not treated as duplicates. I suppose this is to
> handle how "Each hybrid pmu event has been assigned with a pmu name".
> 
> Fix uncore PMU alias list by also checking if events with PMU name are not
> cpu PMUs.
> 
> Fixes: 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> It would be helpful if someone with some of these hybrid CPU systems could
> test this change, thanks!
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6ae58406f4fc..392f6a36418b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1659,6 +1659,24 @@ bool is_pmu_core(const char *name)
>  	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
>  }
>  
> +static bool pmu_alias_is_duplicate(struct sevent *alias_a,
> +				   struct sevent *alias_b)
> +{
> +	/* Different names -> never duplicates */
> +	if (strcmp(alias_a->name, alias_b->name))
> +		return false;
> +	if (!alias_a->pmu)
> +		return true;
> +	if (!alias_b->pmu)
> +		return true;
> +	if (!strcmp(alias_a->pmu, alias_b->pmu))
> +		return true;
> +	/* uncore PMUs */
> +	if (!alias_a->is_cpu && !alias_b->is_cpu)
> +		return true;
> +	return false;
> +}
> +
>  void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>  			bool long_desc, bool details_flag, bool deprecated,
>  			const char *pmu_name)
> @@ -1744,12 +1762,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>  	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>  	for (j = 0; j < len; j++) {
>  		/* Skip duplicates */
> -		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
> -			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
> -			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
> -				continue;
> -			}
> -		}
> +		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> +			continue;
>  
>  		if (name_only) {
>  			printf("%s ", aliases[j].name);
> -- 
> 2.26.2

-- 

- Arnaldo
