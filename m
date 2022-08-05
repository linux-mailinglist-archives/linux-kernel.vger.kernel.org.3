Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDB58AB22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiHEM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240808AbiHEM4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:56:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F024BE5;
        Fri,  5 Aug 2022 05:56:05 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lzlrq6RZ6z689n7;
        Fri,  5 Aug 2022 20:53:31 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 14:56:02 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 13:56:01 +0100
Message-ID: <93448cc1-7b21-3b04-92d2-65d61ba140fe@huawei.com>
Date:   Fri, 5 Aug 2022 13:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 13/17] perf pmu-events: Don't assume pmu_event is an
 array
To:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        "James Clark" <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-14-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-14-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 23:18, Ian Rogers wrote:
> Current code assumes that a struct pmu_event can be iterated over
> forward until a NULL pmu_event is encountered. This makes it difficult
> to refactor pmu_event. Add a loop function taking a callback function
> that's passed the struct pmu_event. This way the pmu_event is only
> needed for one element and not an entire array.
> 
> Switch existing code iterating over the pmu_event arrays to use the new
> loop function pmu_events_table_for_each_event.


I find it hard to follow the change from the description. The title is 
"Don't assume pmu_event is an array", but that is rightly what 
pmu_events_table_for_each_event() does.

If I check - for exmaple - pmu_add_cpu_aliases_map(), you just switch it 
over to using pmu_events_table_for_each_event(), which seems resonable. 
So it just seems here that we're refactoring the code, and not changing 
the nature of how we handle pmu_events *.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/empty-pmu-events.c |  34 +++--
>   tools/perf/pmu-events/jevents.py         |  34 +++--
>   tools/perf/pmu-events/pmu-events.h       |   3 +
>   tools/perf/tests/pmu-events.c            | 136 +++++++++--------
>   tools/perf/util/metricgroup.c            | 181 ++++++++++++++++-------
>   tools/perf/util/pmu.c                    |  65 ++++----
>   tools/perf/util/s390-sample-raw.c        |  42 ++++--
>   7 files changed, 313 insertions(+), 182 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index 028f44efe48d..bee1967baa2b 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -247,6 +247,20 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
>   	},
>   };
>   
> +int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
> +				    void *data)
> +{
> +	for (const struct pmu_event *pe = &table[0];
> +	     pe->name || pe->metric_group || pe->metric_name;
> +	     pe++) {
> +		int ret = fn(pe, table, data);
> +
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
>   const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
>   {
>   	const struct pmu_event *table = NULL;
> @@ -291,14 +305,10 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
>   	for (const struct pmu_events_map *tables = &pmu_events_map[0];
>   	     tables->table;
>   	     tables++) {
> -		for (const struct pmu_event *pe = &tables->table[0];
> -		     pe->name || pe->metric_group || pe->metric_name;
> -		     pe++) {
> -			int ret = fn(pe, &tables->table[0], data);
> +		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
>   
> -			if (ret)
> -				return ret;
> -		}
> +		if (ret)
> +			return ret;
>   	}
>   	return 0;
>   }
> @@ -319,14 +329,10 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
>   	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
>   	     tables->name;
>   	     tables++) {
> -		for (const struct pmu_event *pe = &tables->table[0];
> -		     pe->name || pe->metric_group || pe->metric_name;
> -		     pe++) {
> -			int ret = fn(pe, &tables->table[0], data);
> +		int ret = pmu_events_table_for_each_event(tables->table, fn, data);
>   
> -			if (ret)
> -				return ret;
> -		}
> +		if (ret)
> +			return ret;
>   	}
>   	return 0;
>   }
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index e976c5e8e80b..365c960202b0 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -409,6 +409,20 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
>   \t},
>   };
>   
> +int pmu_events_table_for_each_event(const struct pmu_event *table, pmu_event_iter_fn fn,
> +                                    void *data)

Again we seem to be just duplicating what is in empty-pmu-events.c - can 
we avoid this? another idea (apart from linking in other c files) is for 
empty-pmu-events.c to be generated from jevents.py (like how it was done 
for jevents.c)
