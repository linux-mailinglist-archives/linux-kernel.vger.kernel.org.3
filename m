Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B251FDE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiEINUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiEINUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291A20B54F;
        Mon,  9 May 2022 06:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57CE2B8124C;
        Mon,  9 May 2022 13:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3816C385A8;
        Mon,  9 May 2022 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652102198;
        bh=P03P3iBuMQwdqJ10cdmFhzHRNAACOez3A/7gSDDSilU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyR5MTpOgAqHAODnrDxnr1lv+DH9KAlEdcEQOo/sWC7VopWzufMbj+vt/btxIsIPA
         Zl4Y1NEyjZhu1y/oI1FyqUO04V89yoC+MjCtfIM9KWx0n7kNigtiW5I1hJ22ui8UjM
         yMAE3qNLYrzhr6IfCxLvmvc6NkAtruFFa9HeC+tAf97M9dvfe+pYCadgG8Hgo2RPFt
         M2Ge5M2d6aTQ8WinlTis/RBgDU/BpMm/shoMqevh7lg4HyfmG/nyGEz5k9XNr4mFi+
         82ZzOM1WW9RGc2Ruc1DS+6zKVAmJbWpnhVhWz9uwXiSi1ABbhe07yNxC6qxHuaj8Xs
         YkUC43OCfu5jw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7E7D5400B1; Mon,  9 May 2022 10:16:35 -0300 (-03)
Date:   Mon, 9 May 2022 10:16:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/5] perf evsel: Add tool event helpers
Message-ID: <YnkUM32sISfq1fad@kernel.org>
References: <20220507053410.3798748-1-irogers@google.com>
 <20220507053410.3798748-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507053410.3798748-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 06, 2022 at 10:34:08PM -0700, Ian Rogers escreveu:
> Convert to and from a string. Fix evsel__tool_name as array is off-by-1.
> Support more than just duration_time as a metric-id.

Good catch, I added this:

Fixes: 75eafc970bd9d36d ("perf list: Print all available tool events")

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 41 +++++++++++++++++++++++++++++++----------
>  tools/perf/util/evsel.h | 11 +++++++++++
>  2 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index cdeace24d9be..5fd7924f8eb3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -59,6 +59,33 @@ struct perf_missing_features perf_missing_features;
>  
>  static clockid_t clockid;
>  
> +static const char *const perf_tool_event__tool_names[PERF_TOOL_MAX] = {
> +	NULL,
> +	"duration_time",
> +	"user_time",
> +	"system_time",
> +};
> +
> +const char *perf_tool_event__to_str(enum perf_tool_event ev)
> +{
> +	if (ev > PERF_TOOL_NONE && ev < PERF_TOOL_MAX)
> +		return perf_tool_event__tool_names[ev];
> +
> +	return NULL;
> +}
> +
> +enum perf_tool_event perf_tool_event__from_str(const char *str)
> +{
> +	int i;
> +
> +	perf_tool_event__for_each_event(i) {
> +		if (!strcmp(str, perf_tool_event__tool_names[i]))
> +			return i;
> +	}
> +	return PERF_TOOL_NONE;
> +}
> +
> +
>  static int evsel__no_extra_init(struct evsel *evsel __maybe_unused)
>  {
>  	return 0;
> @@ -597,15 +624,9 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
>  	return r + evsel__add_modifiers(evsel, bf + r, size - r);
>  }
>  
> -static const char *const evsel__tool_names[PERF_TOOL_MAX] = {
> -	"duration_time",
> -	"user_time",
> -	"system_time",
> -};
> -
>  static int evsel__tool_name(enum perf_tool_event ev, char *bf, size_t size)
>  {
> -	return scnprintf(bf, size, "%s", evsel__tool_names[ev]);
> +	return scnprintf(bf, size, "%s", perf_tool_event__to_str(ev));
>  }
>  
>  static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
> @@ -758,7 +779,7 @@ const char *evsel__name(struct evsel *evsel)
>  		break;
>  
>  	case PERF_TYPE_SOFTWARE:
> -		if (evsel->tool_event)
> +		if (evsel__is_tool(evsel))
>  			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
>  		else
>  			evsel__sw_name(evsel, bf, sizeof(bf));
> @@ -791,8 +812,8 @@ const char *evsel__metric_id(const struct evsel *evsel)
>  	if (evsel->metric_id)
>  		return evsel->metric_id;
>  
> -	if (evsel->core.attr.type == PERF_TYPE_SOFTWARE && evsel->tool_event)
> -		return "duration_time";
> +	if (evsel__is_tool(evsel))
> +		return perf_tool_event__to_str(evsel->tool_event);
>  
>  	return "unknown";
>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a017781cdd47..d4b04537ce6d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -36,6 +36,12 @@ enum perf_tool_event {
>  	PERF_TOOL_MAX,
>  };
>  
> +const char *perf_tool_event__to_str(enum perf_tool_event ev);
> +enum perf_tool_event perf_tool_event__from_str(const char *str);
> +
> +#define perf_tool_event__for_each_event(ev)		\
> +	for ((ev) = PERF_TOOL_DURATION_TIME; (ev) < PERF_TOOL_MAX; ev++)
> +
>  /** struct evsel - event selector
>   *
>   * @evlist - evlist this evsel is in, if it is in one.
> @@ -269,6 +275,11 @@ int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size
>  const char *evsel__name(struct evsel *evsel);
>  const char *evsel__metric_id(const struct evsel *evsel);
>  
> +static inline bool evsel__is_tool(const struct evsel *evsel)
> +{
> +	return evsel->tool_event != PERF_TOOL_NONE;
> +}
> +
>  const char *evsel__group_name(struct evsel *evsel);
>  int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
>  
> -- 
> 2.36.0.512.ge40c2bad7a-goog

-- 

- Arnaldo
