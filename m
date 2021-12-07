Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091C46BE10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhLGOty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhLGOtx (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F3C061574;
        Tue,  7 Dec 2021 06:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2320B817EC;
        Tue,  7 Dec 2021 14:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFE3C341C1;
        Tue,  7 Dec 2021 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638888380;
        bh=pfArM1v5io2RBwvYl7LkFtO30J/30U4dBAaivmhs8MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFNrh2QyRskrXqJa/AobAHcRhXVD3LtpLbbwTdsMWzpZLc4iMWN86sdMhKtjUXW1d
         cUHxU9xFaAquoXTE44qZQhedX1QZJ0Pq9boDu2QwH7RRb5vRGczRT7Xzu41gISw2Iv
         3m46BJwoz9fwDEsUJ8Is97ZXeyXhN6nP3+JxrYGS+BepOM2zbCOZ3xB7bnYmwm6Doq
         7XK7A5zVMV2dIK551wyebkN353sIDa08wjXKr41so2DNsZz4n72x6sOEnN4ezfJVPr
         JEu/rXubnkl5n5a0Eqk8tTtQ8pX5/gNdECuNbE0GaHMwq0B1DTDaUTttqfj6G73SSi
         0t4GTp6RiBqvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45D05406C1; Tue,  7 Dec 2021 11:46:17 -0300 (-03)
Date:   Tue, 7 Dec 2021 11:46:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Support --cputype option for hybrid events
Message-ID: <Ya9zufZb+1zRl+Cj@kernel.org>
References: <20210909062215.10278-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909062215.10278-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 09, 2021 at 02:22:15PM +0800, Jin Yao escreveu:
> In previous patch, we have supported the syntax which enables
> the event on a specified pmu, such as:

Fell thru the cracks :-\

Thanks, applied.

- Arnaldo

 
> cpu_core/<event>/
> cpu_atom/<event>/
> 
> While this syntax is not very easy for applying on a set of
> events or applying on a group. In following example, we have to
> explicitly assign the pmu prefix.
> 
>   # ./perf stat -e '{cpu_core/cycles/,cpu_core/instructions/}' -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>            1,158,545      cpu_core/cycles/
>            1,003,113      cpu_core/instructions/
> 
>          1.002428712 seconds time elapsed
> 
> A much easier way is:
> 
>   # ./perf stat --cputype core -e '{cycles,instructions}' -- sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>            1,101,071      cpu_core/cycles/
>              939,892      cpu_core/instructions/
> 
>          1.002363142 seconds time elapsed
> 
> For this example, the '--cputype' enables the events from specified
> pmu (cpu_core).
> 
> If '--cputype' conflicts with pmu prefix, '--cputype' is ignored.
> 
>   # ./perf stat --cputype core -e cycles,cpu_atom/instructions/ -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>           21,003,407      cpu_core/cycles/
>              367,886      cpu_atom/instructions/
> 
>          1.002203520 seconds time elapsed
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt |  4 ++++
>  tools/perf/builtin-stat.c              | 24 ++++++++++++++++++++++++
>  tools/perf/util/evlist.h               |  1 +
>  tools/perf/util/parse-events-hybrid.c  |  9 ++++++---
>  4 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 4c9310be6acc..33da737161a6 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -493,6 +493,10 @@ This option can be enabled in perf config by setting the variable
>  
>  $ perf config stat.no-csv-summary=true
>  
> +--cputype::
> +Only enable events on applying cpu with this type for hybrid platform
> +(e.g. core or atom)"
> +
>  EXAMPLES
>  --------
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index f6e87b7be5fa..752e2bf1029f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1168,6 +1168,26 @@ static int parse_stat_cgroups(const struct option *opt,
>  	return parse_cgroups(opt, str, unset);
>  }
>  
> +static int parse_hybrid_type(const struct option *opt,
> +			     const char *str,
> +			     int unset __maybe_unused)
> +{
> +	struct evlist *evlist = *(struct evlist **)opt->value;
> +
> +	if (!list_empty(&evlist->core.entries)) {
> +		fprintf(stderr, "Must define cputype before events/metrics\n");
> +		return -1;
> +	}
> +
> +	evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
> +	if (!evlist->hybrid_pmu_name) {
> +		fprintf(stderr, "--cputype %s is not supported!\n", str);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct option stat_options[] = {
>  	OPT_BOOLEAN('T', "transaction", &transaction_run,
>  		    "hardware transaction statistics"),
> @@ -1282,6 +1302,10 @@ static struct option stat_options[] = {
>  		       "don't print 'summary' for CSV summary output"),
>  	OPT_BOOLEAN(0, "quiet", &stat_config.quiet,
>  			"don't print output (useful with record)"),
> +	OPT_CALLBACK(0, "cputype", &evsel_list, "hybrid cpu type",
> +		     "Only enable events on applying cpu with this type "
> +		     "for hybrid platform (e.g. core or atom)",
> +		     parse_hybrid_type),
>  #ifdef HAVE_LIBPFM
>  	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>  		"libpfm4 event selector. use 'perf list' to list available events",
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 97bfb8d0be4f..7af5b247e319 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -64,6 +64,7 @@ struct evlist {
>  	struct evsel *selected;
>  	struct events_stats stats;
>  	struct perf_env	*env;
> +	const char *hybrid_pmu_name;
>  	void (*trace_event_sample_raw)(struct evlist *evlist,
>  				       union perf_event *event,
>  				       struct perf_sample *sample);
> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
> index 10160ab126f9..3875a8d086e4 100644
> --- a/tools/perf/util/parse-events-hybrid.c
> +++ b/tools/perf/util/parse-events-hybrid.c
> @@ -62,10 +62,13 @@ static int create_event_hybrid(__u32 config_type, int *idx,
>  static int pmu_cmp(struct parse_events_state *parse_state,
>  		   struct perf_pmu *pmu)
>  {
> -	if (!parse_state->hybrid_pmu_name)
> -		return 0;
> +	if (parse_state->evlist && parse_state->evlist->hybrid_pmu_name)
> +		return strcmp(parse_state->evlist->hybrid_pmu_name, pmu->name);
> +
> +	if (parse_state->hybrid_pmu_name)
> +		return strcmp(parse_state->hybrid_pmu_name, pmu->name);
>  
> -	return strcmp(parse_state->hybrid_pmu_name, pmu->name);
> +	return 0;
>  }
>  
>  static int add_hw_hybrid(struct parse_events_state *parse_state,
> -- 
> 2.17.1

-- 

- Arnaldo
