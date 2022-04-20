Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DDB508D99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380739AbiDTQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380737AbiDTQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:47:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECFB4666B;
        Wed, 20 Apr 2022 09:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 756ADB81FB6;
        Wed, 20 Apr 2022 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBE9C385A1;
        Wed, 20 Apr 2022 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650473074;
        bh=y7SdXt71n1BDdaDOsWRdrF7usDyjXHRWkjywHnzgDqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcYpeSpyz+Y5b9DgPgyl3EQQrzBuMqa9nlzseC6A5isszBQ3P7vvbNroi56n3uCfn
         4l8x5tuRMQgIFg6XaWykmPEFvyF/I8Zv8Au3raRqYwL2zN4U4OjORKXUrdVYVLZr7p
         eSRPrlTzt1bOVJiwj/ItdoIC6V/YA6wU6eWoGVZJjysVE59k2zZh4oKiZORL04RA/X
         sqQW0pdn4k73AddP26D6v9EYusnGzsiqUkXpYrSxzll6FfQ0MGtwC2eZVqBOtzjaq3
         DPbx5SySMY2w5WXzskYVWGv7ShQmKiej2hL7ealfSEZ/BConwtNTd+s0LR8DP5d9/c
         FuHTkpFhC5XlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3208D400B1; Wed, 20 Apr 2022 13:44:31 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:44:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Florian Fischer <florian.fischer@muhq.space>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 3/3] perf list: print all available tool events
Message-ID: <YmA4byoEa3QBNeST@kernel.org>
References: <20220420102354.468173-1-florian.fischer@muhq.space>
 <20220420102354.468173-4-florian.fischer@muhq.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420102354.468173-4-florian.fischer@muhq.space>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 12:23:54PM +0200, Florian Fischer escreveu:
> Introduce names for the new tool events 'user_time' and 'system_time'.

Before:

  duration_time                                      [Tool event]

After:

$ perf list | grep Tool
  duration_time OR                                   [Tool event]
  user_time OR                                       [Tool event]
  system_time OR                                     [Tool event]
$ 

So now we have that extraneous "OR", can you please take a look?
Probably needs to check if there is an alias?

- Arnaldo
 
> Signed-off-by: Florian Fischer <florian.fischer@muhq.space>
> ---
>  tools/perf/util/evsel.c        | 19 ++++++++++------
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++-----
>  3 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2a1729e7aee4..d38722560e80 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -597,6 +597,17 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
>  	return r + evsel__add_modifiers(evsel, bf + r, size - r);
>  }
>  
> +const char *evsel__tool_names[PERF_TOOL_MAX] = {
> +	"duration_time",
> +	"user_time",
> +	"system_time",
> +};
> +
> +static int evsel__tool_name(enum perf_tool_event ev, char *bf, size_t size)
> +{
> +	return scnprintf(bf, size, "%s", evsel__tool_names[ev]);
> +}
> +
>  static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
>  {
>  	int r;
> @@ -723,12 +734,6 @@ static int evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
>  	return ret + evsel__add_modifiers(evsel, bf + ret, size - ret);
>  }
>  
> -static int evsel__tool_name(char *bf, size_t size)
> -{
> -	int ret = scnprintf(bf, size, "duration_time");
> -	return ret;
> -}
> -
>  const char *evsel__name(struct evsel *evsel)
>  {
>  	char bf[128];
> @@ -754,7 +759,7 @@ const char *evsel__name(struct evsel *evsel)
>  
>  	case PERF_TYPE_SOFTWARE:
>  		if (evsel->tool_event)
> -			evsel__tool_name(bf, sizeof(bf));
> +			evsel__tool_name(evsel->tool_event, bf, sizeof(bf));
>  		else
>  			evsel__sw_name(evsel, bf, sizeof(bf));
>  		break;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 7e2209b47b39..45d674812239 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -262,6 +262,7 @@ extern const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX][EVSEL__MAX_ALI
>  extern const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX][EVSEL__MAX_ALIASES];
>  extern const char *evsel__hw_names[PERF_COUNT_HW_MAX];
>  extern const char *evsel__sw_names[PERF_COUNT_SW_MAX];
> +extern const char *evsel__tool_names[PERF_TOOL_MAX];
>  extern char *evsel__bpf_counter_events;
>  bool evsel__match_bpf_counter_events(const char *name);
>  
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 064ec368a90b..c0e88d3b3e3c 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -154,6 +154,21 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>  	},
>  };
>  
> +struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
> +	[PERF_TOOL_DURATION_TIME] = {
> +		.symbol = "duration_time",
> +		.alias  = "",
> +	},
> +	[PERF_TOOL_USER_TIME] = {
> +		.symbol = "user_time",
> +		.alias  = "",
> +	},
> +	[PERF_TOOL_SYSTEM_TIME] = {
> +		.symbol = "system_time",
> +		.alias  = "",
> +	},
> +};
> +
>  #define __PERF_EVENT_FIELD(config, name) \
>  	((config & PERF_EVENT_##name##_MASK) >> PERF_EVENT_##name##_SHIFT)
>  
> @@ -3058,21 +3073,34 @@ int print_hwcache_events(const char *event_glob, bool name_only)
>  	return evt_num;
>  }
>  
> -static void print_tool_event(const char *name, const char *event_glob,
> +static void print_tool_event(const struct event_symbol *syms, const char *event_glob,
>  			     bool name_only)
>  {
> -	if (event_glob && !strglobmatch(name, event_glob))
> +	if (syms->symbol == NULL)
> +		return;
> +
> +	if (event_glob && !(strglobmatch(syms->symbol, event_glob) ||
> +	      (syms->alias && strglobmatch(syms->alias, event_glob))))
>  		return;
> +
>  	if (name_only)
> -		printf("%s ", name);
> -	else
> +		printf("%s ", syms->symbol);
> +	else {
> +		char name[MAX_NAME_LEN];
> +		if (syms->alias)
> +			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
> +		else
> +			strlcpy(name, syms->symbol, MAX_NAME_LEN);
>  		printf("  %-50s [%s]\n", name, "Tool event");
> -
> +	}
>  }
>  
>  void print_tool_events(const char *event_glob, bool name_only)
>  {
> -	print_tool_event("duration_time", event_glob, name_only);
> +	// Start at 1 because the first enum entry symbols no tool event
> +	for (int i = 1; i < PERF_TOOL_MAX; ++i) {
> +		print_tool_event(event_symbols_tool + i, event_glob, name_only);
> +	}
>  	if (pager_in_use())
>  		printf("\n");
>  }
> -- 
> 2.36.0

-- 

- Arnaldo
