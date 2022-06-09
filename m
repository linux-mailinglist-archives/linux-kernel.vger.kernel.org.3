Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ED654511A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbiFIPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344617AbiFIPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:43:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB2727FCE;
        Thu,  9 Jun 2022 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789409; x=1686325409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GNkclSmywbxSCqTU5BekjFqErvWYaGFqu9/oMrRJ/ck=;
  b=fuJybSSafZDsx9ydHy92/rXlsvOiks5khQEwcjts0Wsrn5nawOEbhhC6
   ypeUydtvsAfZ7jQNsy1QXb85oU25/3g0MNOU129qki2nQwdlmhCFducUR
   R9A/Dggqqfxs1amlhepBKbRlgNouDX9KAGjxD+i9EX+XE+Op4L1gVM+RK
   z8Wz0y58pIUu0Mpa/J5zzwS3g5kOYEWvOX/7PqQlO4Z1DZHXsrUj7fI8N
   sq0AHZBiDKvNbUt28h84TiHC2kJ2auo1SmjdZtI0fcxFFCdiXxvLfwDFW
   mszxV8K9Y2sCk0PqvN9J/mm4K8jq6aU2jFeyJr9pasgbhsm2URbpR+GT9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260447612"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="260447612"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="827657591"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2022 08:43:28 -0700
Received: from [10.252.211.126] (kliang2-MOBL.ccr.corp.intel.com [10.252.211.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BF96F58094D;
        Thu,  9 Jun 2022 08:43:26 -0700 (PDT)
Message-ID: <85cd13d9-2999-e453-bc2b-12bcf5a5c2b1@linux.intel.com>
Date:   Thu, 9 Jun 2022 11:43:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 5/5] perf stat: Add topdown metrics in the default perf
 stat on the hybrid machine
Content-Language: en-US
To:     zhengjun.xing@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com
References: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
 <20220609145314.2064632-6-zhengjun.xing@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220609145314.2064632-6-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2022 10:53 AM, zhengjun.xing@linux.intel.com wrote:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> Topdown metrics are missed in the default perf stat on the hybrid machine,
> add Topdown metrics in default perf stat for hybrid systems.
> 
> Currently, we support the perf metrics Topdown for the p-core PMU in the
> perf stat default, the perf metrics Topdown support for e-core PMU will be
> implemented later separately. Refactor the code adds two x86 specific
> functions. Widen the size of the event name column by 7 chars, so that all
> metrics after the "#" become aligned again.
> 
> The perf metrics topdown feature is supported on the cpu_core of ADL. The
> dedicated perf metrics counter and the fixed counter 3 are used for the
> topdown events. Adding the topdown metrics doesn't trigger multiplexing.
> 
> Before:
> 
>   # ./perf  stat  -a true
> 
>   Performance counter stats for 'system wide':
> 
>               53.70 msec cpu-clock                 #   25.736 CPUs utilized
>                  80      context-switches          #    1.490 K/sec
>                  24      cpu-migrations            #  446.951 /sec
>                  52      page-faults               #  968.394 /sec
>           2,788,555      cpu_core/cycles/          #   51.931 M/sec
>             851,129      cpu_atom/cycles/          #   15.851 M/sec
>           2,974,030      cpu_core/instructions/    #   55.385 M/sec
>             416,919      cpu_atom/instructions/    #    7.764 M/sec
>             586,136      cpu_core/branches/        #   10.916 M/sec
>              79,872      cpu_atom/branches/        #    1.487 M/sec
>              14,220      cpu_core/branch-misses/   #  264.819 K/sec
>               7,691      cpu_atom/branch-misses/   #  143.229 K/sec
> 
>         0.002086438 seconds time elapsed
> 
> After:
> 
>   # ./perf stat  -a true
> 
>   Performance counter stats for 'system wide':
> 
>               61.39 msec cpu-clock                        #   24.874 CPUs utilized
>                  76      context-switches                 #    1.238 K/sec
>                  24      cpu-migrations                   #  390.968 /sec
>                  52      page-faults                      #  847.097 /sec
>           2,753,695      cpu_core/cycles/                 #   44.859 M/sec
>             903,899      cpu_atom/cycles/                 #   14.725 M/sec
>           2,927,529      cpu_core/instructions/           #   47.690 M/sec
>             428,498      cpu_atom/instructions/           #    6.980 M/sec
>             581,299      cpu_core/branches/               #    9.470 M/sec
>              83,409      cpu_atom/branches/               #    1.359 M/sec
>              13,641      cpu_core/branch-misses/          #  222.216 K/sec
>               8,008      cpu_atom/branch-misses/          #  130.453 K/sec
>          14,761,308      cpu_core/slots/                  #  240.466 M/sec
>           3,288,625      cpu_core/topdown-retiring/       #     22.3% retiring
>           1,323,323      cpu_core/topdown-bad-spec/       #      9.0% bad speculation
>           5,477,470      cpu_core/topdown-fe-bound/       #     37.1% frontend bound
>           4,679,199      cpu_core/topdown-be-bound/       #     31.7% backend bound
>             646,194      cpu_core/topdown-heavy-ops/      #      4.4% heavy operations       #     17.9% light operations
>           1,244,999      cpu_core/topdown-br-mispredict/  #      8.4% branch mispredict      #      0.5% machine clears
>           3,891,800      cpu_core/topdown-fetch-lat/      #     26.4% fetch latency          #     10.7% fetch bandwidth
>           1,879,034      cpu_core/topdown-mem-bound/      #     12.7% memory bound           #     19.0% Core bound
> 
>         0.002467839 seconds time elapsed
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> Change log:
>    v2:
>      * Refactor arch_get_topdown_pmu_name() as Namhyung's suggestion.
> 
>   tools/perf/arch/x86/util/evlist.c  | 13 ++------
>   tools/perf/arch/x86/util/topdown.c | 52 ++++++++++++++++++++++++++++++
>   tools/perf/arch/x86/util/topdown.h |  1 +
>   tools/perf/builtin-stat.c          | 14 ++------
>   tools/perf/util/stat-display.c     |  2 +-
>   tools/perf/util/topdown.c          |  7 ++++
>   tools/perf/util/topdown.h          |  3 +-
>   7 files changed, 67 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index fd3500fd4b69..03c955480d34 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -3,12 +3,9 @@
>   #include "util/pmu.h"
>   #include "util/evlist.h"
>   #include "util/parse-events.h"
> -#include "topdown.h"
>   #include "util/event.h"
>   #include "util/pmu-hybrid.h"
> -
> -#define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
> -#define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
> +#include "topdown.h"
>   
>   static int ___evlist__add_default_attrs(struct evlist *evlist,
>   					struct perf_event_attr *attrs,
> @@ -65,13 +62,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>   	if (nr_attrs)
>   		return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
>   
> -	if (!pmu_have_event("cpu", "slots"))
> -		return 0;
> -
> -	if (pmu_have_event("cpu", "topdown-heavy-ops"))
> -		return parse_events(evlist, TOPDOWN_L2_EVENTS, NULL);
> -	else
> -		return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
> +	return topdown_parse_events(evlist);
>   }
>   
>   struct evsel *arch_evlist__leader(struct list_head *list)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index f81a7cfe4d63..35add91f2cd2 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -3,9 +3,17 @@
>   #include "api/fs/fs.h"
>   #include "util/pmu.h"
>   #include "util/topdown.h"
> +#include "util/evlist.h"
> +#include "util/debug.h"
> +#include "util/pmu-hybrid.h"
>   #include "topdown.h"
>   #include "evsel.h"
>   
> +#define TOPDOWN_L1_EVENTS       "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
> +#define TOPDOWN_L1_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/}"
> +#define TOPDOWN_L2_EVENTS       "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
> +#define TOPDOWN_L2_EVENTS_CORE  "{slots,cpu_core/topdown-retiring/,cpu_core/topdown-bad-spec/,cpu_core/topdown-fe-bound/,cpu_core/topdown-be-bound/,cpu_core/topdown-heavy-ops/,cpu_core/topdown-br-mispredict/,cpu_core/topdown-fetch-lat/,cpu_core/topdown-mem-bound/}"
> +
>   /* Check whether there is a PMU which supports the perf metrics. */
>   bool topdown_sys_has_perf_metrics(void)
>   {
> @@ -73,3 +81,47 @@ bool arch_topdown_sample_read(struct evsel *leader)
>   
>   	return false;
>   }
> +
> +const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
> +{
> +	const char *pmu_name;
> +
> +	if (!perf_pmu__has_hybrid())
> +		return "cpu";
> +
> +	if (!evlist->hybrid_pmu_name) {
> +		if (warn)
> +			pr_warning
> +			    ("WARNING: default to use cpu_core topdown events\n");


I missed it in my last review.

Please make the pr_warning in one line.

Thanks,
Kan

> +		evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
> +	}
> +
> +	pmu_name = evlist->hybrid_pmu_name;
> +
> +	return pmu_name;
> +}
> +
> +int topdown_parse_events(struct evlist *evlist)
> +{
> +	const char *topdown_events;
> +	const char *pmu_name;
> +
> +	if (!topdown_sys_has_perf_metrics())
> +		return 0;
> +
> +	pmu_name = arch_get_topdown_pmu_name(evlist, false);
> +
> +	if (pmu_have_event(pmu_name, "topdown-heavy-ops")) {
> +		if (!strcmp(pmu_name, "cpu_core"))
> +			topdown_events = TOPDOWN_L2_EVENTS_CORE;
> +		else
> +			topdown_events = TOPDOWN_L2_EVENTS;
> +	} else {
> +		if (!strcmp(pmu_name, "cpu_core"))
> +			topdown_events = TOPDOWN_L1_EVENTS_CORE;
> +		else
> +			topdown_events = TOPDOWN_L1_EVENTS;
> +	}
> +
> +	return parse_events(evlist, topdown_events, NULL);
> +}
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> index 46bf9273e572..7eb81f042838 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -3,5 +3,6 @@
>   #define _TOPDOWN_H 1
>   
>   bool topdown_sys_has_perf_metrics(void);
> +int topdown_parse_events(struct evlist *evlist);
>   
>   #endif
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 837c3ca91af1..c6b68be78f8c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -71,6 +71,7 @@
>   #include "util/bpf_counter.h"
>   #include "util/iostat.h"
>   #include "util/pmu-hybrid.h"
> + #include "util/topdown.h"
>   #include "asm/bug.h"
>   
>   #include <linux/time64.h>
> @@ -1858,22 +1859,11 @@ static int add_default_attributes(void)
>   		unsigned int max_level = 1;
>   		char *str = NULL;
>   		bool warn = false;
> -		const char *pmu_name = "cpu";
> +		const char *pmu_name = arch_get_topdown_pmu_name(evsel_list, true);
>   
>   		if (!force_metric_only)
>   			stat_config.metric_only = true;
>   
> -		if (perf_pmu__has_hybrid()) {
> -			if (!evsel_list->hybrid_pmu_name) {
> -				pr_warning("WARNING: default to use cpu_core topdown events\n");
> -				evsel_list->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
> -			}
> -
> -			pmu_name = evsel_list->hybrid_pmu_name;
> -			if (!pmu_name)
> -				return -1;
> -		}
> -
>   		if (pmu_have_event(pmu_name, topdown_metric_L2_attrs[5])) {
>   			metric_attrs = topdown_metric_L2_attrs;
>   			max_level = 2;
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 606f09b09226..44045565c8f8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -374,7 +374,7 @@ static void abs_printout(struct perf_stat_config *config,
>   			config->csv_output ? 0 : config->unit_width,
>   			evsel->unit, config->csv_sep);
>   
> -	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
> +	fprintf(output, "%-*s", config->csv_output ? 0 : 32, evsel__name(evsel));
>   
>   	print_cgroup(config, evsel);
>   }
> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
> index a369f84ceb6a..1090841550f7 100644
> --- a/tools/perf/util/topdown.c
> +++ b/tools/perf/util/topdown.c
> @@ -65,3 +65,10 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
>   {
>   	return false;
>   }
> +
> +__weak const char *arch_get_topdown_pmu_name(struct evlist *evlist
> +					     __maybe_unused,
> +					     bool warn __maybe_unused)
> +{
> +	return "cpu";
> +}
> diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
> index 118e75281f93..f9531528c559 100644
> --- a/tools/perf/util/topdown.h
> +++ b/tools/perf/util/topdown.h
> @@ -2,11 +2,12 @@
>   #ifndef TOPDOWN_H
>   #define TOPDOWN_H 1
>   #include "evsel.h"
> +#include "evlist.h"
>   
>   bool arch_topdown_check_group(bool *warn);
>   void arch_topdown_group_warn(void);
>   bool arch_topdown_sample_read(struct evsel *leader);
> -
> +const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn);
>   int topdown_filter_events(const char **attr, char **str, bool use_group,
>   			  const char *pmu_name);
>   
