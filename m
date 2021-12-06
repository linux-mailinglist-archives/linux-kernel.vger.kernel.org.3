Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB2469415
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhLFKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:48:10 -0500
Received: from foss.arm.com ([217.140.110.172]:53770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhLFKsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:48:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F5A11FB;
        Mon,  6 Dec 2021 02:44:39 -0800 (PST)
Received: from [10.57.34.109] (unknown [10.57.34.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921103F73D;
        Mon,  6 Dec 2021 02:44:37 -0800 (PST)
Subject: Re: [PATCH] perf stat: Fix per socket shadow aggregation
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>
Cc:     eranian@google.com
References: <20211204023409.969668-1-irogers@google.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <52237d2a-2be2-cb93-e29d-ac6eea82a2f9@arm.com>
Date:   Mon, 6 Dec 2021 10:44:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211204023409.969668-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2021 02:34, Ian Rogers wrote:
> An uncore device may have a CPU mask that specifies one CPU per socket:
> $ cat /sys/devices/uncore_imc_0/cpumask
> 0,18
> The perf_stat_config aggr_map will map a CPU to the socket and other
> aggregation values for it. Fix an error where the index into CPU mask
> was being used as the index into the aggr_map. For the cpumask above the
> indexes 0 and 1 are passed to aggr_map rather than the CPUs 0 and 18.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 588601000f3f..7cfad5cfec38 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -516,7 +516,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  static void aggr_update_shadow(struct perf_stat_config *config,
>  			       struct evlist *evlist)
>  {
> -	int cpu, s;
> +	int idx, cpu, s;
>  	struct aggr_cpu_id s2, id;
>  	u64 val;
>  	struct evsel *counter;
> @@ -525,11 +525,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
>  		id = config->aggr_map->map[s];
>  		evlist__for_each_entry(evlist, counter) {
>  			val = 0;
> -			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
> +			for (idx = 0; idx < evsel__nr_cpus(counter); idx++) {
> +				cpu = perf_cpu_map__cpu(evsel__cpus(counter), idx);
>  				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);

Hi Ian,

This same pattern of looping over the CPUs and calling aggr_get_id() is used a couple of
other times. For example in aggr_cb() and first_shadow_cpu(). Do you think these also
need updating?

Or could we fix it in the aggr_get_id() functions so that they expect an index instead
of CPU ID and do the conversion themselves? The callbacks do say "idx" rather than "cpu"
so maybe there is still come confusion.

For example: 

	perf_stat__get_die_cached(struct perf_stat_config *config,
					struct perf_cpu_map *map, int idx)

>  				if (!cpu_map__compare_aggr_cpu_id(s2, id))
>  					continue;
> -				val += perf_counts(counter->counts, cpu, 0)->val;
> +				val += perf_counts(counter->counts, idx, 0)->val;
>  			}
>  			perf_stat__update_shadow_stats(counter, val,
>  					first_shadow_cpu(config, counter, id),
> 
