Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E8586640
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiHAIUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiHAIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:20:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 866B62FFF1;
        Mon,  1 Aug 2022 01:20:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3921515;
        Mon,  1 Aug 2022 01:20:42 -0700 (PDT)
Received: from [10.57.41.53] (unknown [10.57.41.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 773AE3F67D;
        Mon,  1 Aug 2022 01:20:39 -0700 (PDT)
Message-ID: <e3e123db-5321-c96e-1753-27059c729640@arm.com>
Date:   Mon, 1 Aug 2022 09:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Herrera_Arcila?= <adrian.herrera@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, leo.yan@linaro.org, songliubraving@fb.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220729161244.10522-2-adrian.herrera@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> The described --delay behaviour is to delay the enablement of events, but
> not the execution of the command, if one is passed, which is incorrectly
> the current behaviour.
> 
> This patch decouples the enablement from the delay, and enables events
> before or after launching the workload dependent on the options passed
> by the user. This code structure is inspired by that in perf-record, and
> tries to be consistent with it.
> 
> Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> ---
>  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 24 deletions(-)

Looks good to me. Fixes the counter delay issue and the code is pretty
similar to perf record now. Although I would wait for Leo's or Song's
comment as well because they were involved.

Reviewed-by: James Clark <james.clark@arm.com>

> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 318ffd119dad..f98c823b16dd 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -559,7 +559,7 @@ static bool handle_interval(unsigned int interval, int *times)
>  	return false;
>  }
>  
> -static int enable_counters(void)
> +static int enable_bpf_counters(void)
>  {
>  	struct evsel *evsel;
>  	int err;
> @@ -572,28 +572,6 @@ static int enable_counters(void)
>  		if (err)
>  			return err;
>  	}
> -
> -	if (stat_config.initial_delay < 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		return 0;
> -	}
> -
> -	if (stat_config.initial_delay > 0) {
> -		pr_info(EVLIST_DISABLED_MSG);
> -		usleep(stat_config.initial_delay * USEC_PER_MSEC);
> -	}
> -
> -	/*
> -	 * We need to enable counters only if:
> -	 * - we don't have tracee (attaching to task or cpu)
> -	 * - we have initial delay configured
> -	 */
> -	if (!target__none(&target) || stat_config.initial_delay) {
> -		if (!all_counters_use_bpf)
> -			evlist__enable(evsel_list);
> -		if (stat_config.initial_delay > 0)
> -			pr_info(EVLIST_ENABLED_MSG);
> -	}
>  	return 0;
>  }
>  
> @@ -966,10 +944,24 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			return err;
>  	}
>  
> -	err = enable_counters();
> +	err = enable_bpf_counters();
>  	if (err)
>  		return -1;
>  
> +	/*
> +	 * Enable events manually here if perf-stat is run:
> +	 * 1. with a target (any of --all-cpus, --cpu, --pid or --tid)
> +	 * 2. without measurement delay (no --delay)
> +	 * 3. without all events associated to BPF
> +	 *
> +	 * This is because if run with a target, events are not enabled
> +	 * on exec if a workload is passed, and because there is no delay
> +	 * we ensure to enable them before the workload starts
> +	 */
> +	if (!target__none(&target) && !stat_config.initial_delay &&
> +	    !all_counters_use_bpf)
> +		evlist__enable(evsel_list);
> +
>  	/* Exec the command, if any */
>  	if (forks)
>  		evlist__start_workload(evsel_list);
> @@ -977,6 +969,22 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	t0 = rdclock();
>  	clock_gettime(CLOCK_MONOTONIC, &ref_time);
>  
> +	/*
> +	 * If a measurement delay was specified, start it, and if positive,
> +	 * enable events manually after. We respect the delay even if all
> +	 * events are associated to BPF
> +	 */
> +	if (stat_config.initial_delay) {
> +		/* At this point, events are guaranteed disabled */
> +		pr_info(EVLIST_DISABLED_MSG);
> +		if (stat_config.initial_delay > 0) {
> +			usleep(stat_config.initial_delay * USEC_PER_MSEC);
> +			if (!all_counters_use_bpf)
> +				evlist__enable(evsel_list);
> +			pr_info(EVLIST_ENABLED_MSG);
> +		}
> +	}
> +
>  	if (forks) {
>  		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
>  			status = dispatch_events(forks, timeout, interval, &times);
