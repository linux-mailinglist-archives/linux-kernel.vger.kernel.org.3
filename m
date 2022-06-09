Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8699545110
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiFIPkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbiFIPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:40:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259F1F58A8;
        Thu,  9 Jun 2022 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789237; x=1686325237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WwfXvFmcGyVeb1ltcUjcvgZBiMYvu1xqMqLBsmyHi3A=;
  b=Bzy3W9q1RR4MHa0c0f9Ihhp1gWFrm5n8NjYv1XXzM0D+qFkJiruuTxCu
   TvX3HelioRX+1ie/XveNSioIKMKAGE8MJnGw3spd8iw7RCy+t/pPJz5sQ
   2m5Bq6j+ysp0gtET4OxDpxODV6QsBAL9rFwyJBOqC6tyDAurz5Ej2sTku
   J9Ua1ilBY39YORTx2yX+lmoN/WTpztOPYbb5qR/8GE5N5LfTQmkFfz2ds
   bnor1xVtwpCUNLRsZZOUJrHodEMN68wB39+00u3BgrOctLjJee9jZKCTS
   Yj6KfT0TM1O1yWmWUwH7PidOZB9ttpC3FNe5v76XoYrEpvi3MC57axyyQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276088014"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="276088014"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="566442514"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2022 08:40:36 -0700
Received: from [10.252.211.126] (kliang2-MOBL.ccr.corp.intel.com [10.252.211.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7C44B580B9E;
        Thu,  9 Jun 2022 08:40:34 -0700 (PDT)
Message-ID: <8358dc65-88d8-1550-96bd-9e66477c4bd5@linux.intel.com>
Date:   Thu, 9 Jun 2022 11:40:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Add default hybrid events for
 perf stat
Content-Language: en-US
To:     zhengjun.xing@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com
References: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
 <20220609145314.2064632-5-zhengjun.xing@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220609145314.2064632-5-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2022 10:53 AM, zhengjun.xing@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Provide a new solution to replace the reverted commit ac2dc29edd21
> ("perf stat: Add default hybrid events").
> 
> For the default software attrs, nothing is changed.
> For the default hardware attrs, create a new evsel for each hybrid pmu.
> 
> With the new solution, adding a new default attr will not require the
> special support for the hybrid platform anymore.
> 
> Also, the "--detailed" is supported on the hybrid platform
> 
> With the patch,
> 
> ./perf stat -a -ddd sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>         32,231.06 msec cpu-clock                 #   32.056 CPUs utilized
>               529      context-switches          #   16.413 /sec
>                32      cpu-migrations            #    0.993 /sec
>                69      page-faults               #    2.141 /sec
>       176,754,151      cpu_core/cycles/          #    5.484 M/sec          (41.65%)
>       161,695,280      cpu_atom/cycles/          #    5.017 M/sec          (49.92%)
>        48,595,992      cpu_core/instructions/    #    1.508 M/sec          (49.98%)
>        32,363,337      cpu_atom/instructions/    #    1.004 M/sec          (58.26%)
>        10,088,639      cpu_core/branches/        #  313.010 K/sec          (58.31%)
>         6,390,582      cpu_atom/branches/        #  198.274 K/sec          (58.26%)
>           846,201      cpu_core/branch-misses/   #   26.254 K/sec          (66.65%)
>           676,477      cpu_atom/branch-misses/   #   20.988 K/sec          (58.27%)
>        14,290,070      cpu_core/L1-dcache-loads/ #  443.363 K/sec          (66.66%)
>         9,983,532      cpu_atom/L1-dcache-loads/ #  309.749 K/sec          (58.27%)
>           740,725      cpu_core/L1-dcache-load-misses/ #   22.982 K/sec    (66.66%)
>   <not supported>      cpu_atom/L1-dcache-load-misses/
>           480,441      cpu_core/LLC-loads/       #   14.906 K/sec          (66.67%)
>           326,570      cpu_atom/LLC-loads/       #   10.132 K/sec          (58.27%)
>               329      cpu_core/LLC-load-misses/ #   10.208 /sec           (66.68%)
>                 0      cpu_atom/LLC-load-misses/ #    0.000 /sec           (58.32%)
>   <not supported>      cpu_core/L1-icache-loads/
>        21,982,491      cpu_atom/L1-icache-loads/ #  682.028 K/sec          (58.43%)
>         4,493,189      cpu_core/L1-icache-load-misses/ #  139.406 K/sec    (33.34%)
>         4,711,404      cpu_atom/L1-icache-load-misses/ #  146.176 K/sec    (50.08%)
>        13,713,090      cpu_core/dTLB-loads/      #  425.462 K/sec          (33.34%)
>         9,384,727      cpu_atom/dTLB-loads/      #  291.170 K/sec          (50.08%)
>           157,387      cpu_core/dTLB-load-misses/ #    4.883 K/sec         (33.33%)
>           108,328      cpu_atom/dTLB-load-misses/ #    3.361 K/sec         (50.08%)
>   <not supported>      cpu_core/iTLB-loads/
>   <not supported>      cpu_atom/iTLB-loads/
>            37,655      cpu_core/iTLB-load-misses/ #    1.168 K/sec         (33.32%)
>            61,661      cpu_atom/iTLB-load-misses/ #    1.913 K/sec         (50.03%)
>   <not supported>      cpu_core/L1-dcache-prefetches/
>   <not supported>      cpu_atom/L1-dcache-prefetches/
>   <not supported>      cpu_core/L1-dcache-prefetch-misses/
>   <not supported>      cpu_atom/L1-dcache-prefetch-misses/
> 
>         1.005466919 seconds time elapsed
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
> Change log:
>    v2:
>      * The index of all new evsel will be updated when adding to the evlist,
>        just set 0 idx for the new evsel.
> 
>   tools/perf/arch/x86/util/evlist.c | 52 ++++++++++++++++++++++++++++++-
>   tools/perf/util/evlist.c          |  2 +-
>   tools/perf/util/evlist.h          |  2 ++
>   3 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 777bdf182a58..fd3500fd4b69 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -4,16 +4,66 @@
>   #include "util/evlist.h"
>   #include "util/parse-events.h"
>   #include "topdown.h"
> +#include "util/event.h"
> +#include "util/pmu-hybrid.h"
>   
>   #define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>   #define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
>   
> +static int ___evlist__add_default_attrs(struct evlist *evlist,
> +					struct perf_event_attr *attrs,
> +					size_t nr_attrs)
> +{
> +	struct perf_cpu_map *cpus;
> +	struct evsel *evsel, *n;
> +	struct perf_pmu *pmu;
> +	LIST_HEAD(head);
> +	size_t i = 0;
> +
> +	for (i = 0; i < nr_attrs; i++)
> +		event_attr_init(attrs + i);
> +
> +	if (!perf_pmu__has_hybrid())
> +		return evlist__add_attrs(evlist, attrs, nr_attrs);
> +
> +	for (i = 0; i < nr_attrs; i++) {
> +		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
> +			evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries);

Although the idx will be updated later, the value doesn't matter.
I think it should be better to use 0, rather than 
evlist->core.nr_entries. Because it's a new evsel and hasn't been added 
into the evlist yet.

Thanks,
Kan
> +			if (evsel == NULL)
> +				goto out_delete_partial_list;
> +			list_add_tail(&evsel->core.node, &head);
> +			continue;
> +		}
> +
> +		perf_pmu__for_each_hybrid_pmu(pmu) {
> +			evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries);
> +			if (evsel == NULL)
> +				goto out_delete_partial_list;
> +			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> +			cpus = perf_cpu_map__get(pmu->cpus);
> +			evsel->core.cpus = cpus;
> +			evsel->core.own_cpus = perf_cpu_map__get(cpus);
> +			evsel->pmu_name = strdup(pmu->name);
> +			list_add_tail(&evsel->core.node, &head);
> +		}
> +	}
> +
> +	evlist__splice_list_tail(evlist, &head);
> +
> +	return 0;
> +
> +out_delete_partial_list:
> +	__evlist__for_each_entry_safe(&head, n, evsel)
> +		evsel__delete(evsel);
> +	return -1;
> +}
> +
>   int arch_evlist__add_default_attrs(struct evlist *evlist,
>   				   struct perf_event_attr *attrs,
>   				   size_t nr_attrs)
>   {
>   	if (nr_attrs)
> -		return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
> +		return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
>   
>   	if (!pmu_have_event("cpu", "slots"))
>   		return 0;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index efa5f006b5c6..5ff4b9504828 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -309,7 +309,7 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>   	return evsel;
>   }
>   
> -static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> +int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>   {
>   	struct evsel *evsel, *n;
>   	LIST_HEAD(head);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 129095c0fe6d..351ba2887a79 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -104,6 +104,8 @@ static inline int evlist__add_default(struct evlist *evlist)
>   	return __evlist__add_default(evlist, true);
>   }
>   
> +int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
> +
>   int __evlist__add_default_attrs(struct evlist *evlist,
>   				     struct perf_event_attr *attrs, size_t nr_attrs);
>   
