Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F25A8075
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiHaOmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiHaOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:42:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F4BD2A0;
        Wed, 31 Aug 2022 07:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A038BB8217B;
        Wed, 31 Aug 2022 14:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEEAC433D6;
        Wed, 31 Aug 2022 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661956930;
        bh=oMbQGoVTKwMbnxWochLoB76e2l7bAr3cdp+gMVYp92M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nlMvwRJBCoZSqrbHhr+9nEmaktC3bh+Vg/LNGQglZ+Z9jZ5tPNsxO9qZu7LzHWNed
         ICMsZLvTh4XofSQg7MEvWzd9mQrKGSuutE4oPDqLLPnONkftqTTk2lQRviS3otGdIq
         EYO7hJqPWmExHoiTS1yKdfpTN1u85NTg7xTTNuaopCbHfX0/O+BQu8VEMjxGs4+n61
         LGjwfD5Z2sansNCa36UkjgtDJ3Fh3ygE6OTTnA8UifJU+UEVWkPg+pndK3Zq8eDx2C
         2mZN0gQVXBsTiU6SkgD7nGgls5rNRXZk8ZuFE5U5t/zn4IzJU6NwazaayeF8t9CcOS
         KSiMB3zL910qg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C2FB404A1; Wed, 31 Aug 2022 11:42:07 -0300 (-03)
Date:   Wed, 31 Aug 2022 11:42:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 6/8] perf stat: Delay metric parsing
Message-ID: <Yw9zPxVqbfkSOdbu@kernel.org>
References: <20220830164846.401143-1-irogers@google.com>
 <20220830164846.401143-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830164846.401143-7-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 30, 2022 at 09:48:44AM -0700, Ian Rogers escreveu:
> Having metric parsing as part of argument processing causes issues as
> flags like metric-no-group may be specified later. It also denies the
> opportunity to optimize the events on SMT systems where fewer events
> may be possible if we know the target is system-wide. Move metric
> parsing to after command line option parsing. Because of how stat runs
> this moves the parsing after record/report which fail to work with
> metrics currently anyway.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 48 ++++++++++++++++++++++++-----------
>  tools/perf/util/metricgroup.c |  3 +--
>  tools/perf/util/metricgroup.h |  2 +-
>  3 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7fb81a44672d..c813b1aa7d7c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -191,6 +191,7 @@ static bool			append_file;
>  static bool			interval_count;
>  static const char		*output_name;
>  static int			output_fd;
> +static char			*metrics;
>  
>  struct perf_stat {
>  	bool			 record;
> @@ -1147,14 +1148,21 @@ static int enable_metric_only(const struct option *opt __maybe_unused,
>  	return 0;
>  }
>  
> -static int parse_metric_groups(const struct option *opt,
> +static int append_metric_groups(const struct option *opt __maybe_unused,
>  			       const char *str,
>  			       int unset __maybe_unused)
>  {
> -	return metricgroup__parse_groups(opt, str,
> -					 stat_config.metric_no_group,
> -					 stat_config.metric_no_merge,
> -					 &stat_config.metric_events);
> +	if (metrics) {
> +		char *tmp;
> +
> +		if (asprintf(&tmp, "%s,%s", metrics, str) < 0)
> +			return -ENOMEM;

We check if we managed to allocate memory here, but not later at
strdup()?

> +		free(metrics);
> +		metrics = tmp;
> +	} else {
> +		metrics = strdup(str);
> +	}
> +	return 0;
>  }
>  
>  static int parse_control_option(const struct option *opt,
> @@ -1298,7 +1306,7 @@ static struct option stat_options[] = {
>  			"measure SMI cost"),
>  	OPT_CALLBACK('M', "metrics", &evsel_list, "metric/metric group list",
>  		     "monitor specified metrics or metric groups (separated by ,)",
> -		     parse_metric_groups),
> +		     append_metric_groups),
>  	OPT_BOOLEAN_FLAG(0, "all-kernel", &stat_config.all_kernel,
>  			 "Configure all used events to run in kernel space.",
>  			 PARSE_OPT_EXCLUSIVE),
> @@ -1791,11 +1799,9 @@ static int add_default_attributes(void)
>  		 * on an architecture test for such a metric name.
>  		 */
>  		if (metricgroup__has_metric("transaction")) {
> -			struct option opt = { .value = &evsel_list };
> -
> -			return metricgroup__parse_groups(&opt, "transaction",
> +			return metricgroup__parse_groups(evsel_list, "transaction",
>  							 stat_config.metric_no_group,
> -							stat_config.metric_no_merge,
> +							 stat_config.metric_no_merge,
>  							 &stat_config.metric_events);
>  		}
>  
> @@ -2260,8 +2266,6 @@ int cmd_stat(int argc, const char **argv)
>  	argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
>  					(const char **) stat_usage,
>  					PARSE_OPT_STOP_AT_NON_OPTION);
> -	perf_stat__collect_metric_expr(evsel_list);
> -	perf_stat__init_shadow_stats();
>  
>  	if (stat_config.csv_sep) {
>  		stat_config.csv_output = true;
> @@ -2428,6 +2432,23 @@ int cmd_stat(int argc, const char **argv)
>  			target.system_wide = true;
>  	}
>  
> +	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> +		target.per_thread = true;
> +
> +	/*
> +	 * Metric parsing needs to be delayed as metrics may optimize events
> +	 * knowing the target is system-wide.
> +	 */
> +	if (metrics) {
> +		metricgroup__parse_groups(evsel_list, metrics,
> +					stat_config.metric_no_group,
> +					stat_config.metric_no_merge,
> +					&stat_config.metric_events);
> +		zfree(&metrics);
> +	}
> +	perf_stat__collect_metric_expr(evsel_list);
> +	perf_stat__init_shadow_stats();
> +
>  	if (add_default_attributes())
>  		goto out;
>  
> @@ -2447,9 +2468,6 @@ int cmd_stat(int argc, const char **argv)
>  		}
>  	}
>  
> -	if ((stat_config.aggr_mode == AGGR_THREAD) && (target.system_wide))
> -		target.per_thread = true;
> -
>  	if (evlist__fix_hybrid_cpus(evsel_list, target.cpu_list)) {
>  		pr_err("failed to use cpu list %s\n", target.cpu_list);
>  		goto out;
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index b144c3e35264..9151346a16ab 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1646,13 +1646,12 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  	return ret;
>  }
>  
> -int metricgroup__parse_groups(const struct option *opt,
> +int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      const char *str,
>  			      bool metric_no_group,
>  			      bool metric_no_merge,
>  			      struct rblist *metric_events)
>  {
> -	struct evlist *perf_evlist = *(struct evlist **)opt->value;
>  	const struct pmu_events_table *table = pmu_events_table__find();
>  
>  	if (!table)
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 016b3b1a289a..af9ceadaec0f 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -64,7 +64,7 @@ struct metric_expr {
>  struct metric_event *metricgroup__lookup(struct rblist *metric_events,
>  					 struct evsel *evsel,
>  					 bool create);
> -int metricgroup__parse_groups(const struct option *opt,
> +int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      const char *str,
>  			      bool metric_no_group,
>  			      bool metric_no_merge,
> -- 
> 2.37.2.672.g94769d06f0-goog

-- 

- Arnaldo
