Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F458AAE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiHEMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiHEMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:31:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3F32BB17;
        Fri,  5 Aug 2022 05:31:28 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LzlGP50Crz67gPH;
        Fri,  5 Aug 2022 20:27:09 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 14:31:25 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 13:31:24 +0100
Message-ID: <463cffea-51d9-98ad-86ac-d064faac05b9@huawei.com>
Date:   Fri, 5 Aug 2022 13:31:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 10/17] perf pmu-events: Hide pmu_events_map
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
 <20220804221816.1802790-11-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-11-irogers@google.com>
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
> Move usage of the table to pmu-events.c so it may be hidden. By
> abstracting the table the implementation can later be changed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/empty-pmu-events.c |  81 ++++++++-
>   tools/perf/pmu-events/jevents.py         |  81 ++++++++-
>   tools/perf/pmu-events/pmu-events.h       |  29 +--
>   tools/perf/tests/pmu-events.c            | 218 +++++++++++------------
>   tools/perf/util/metricgroup.c            |  15 +-
>   tools/perf/util/pmu.c                    |  34 +---
>   tools/perf/util/pmu.h                    |   2 +-
>   7 files changed, 280 insertions(+), 180 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index 216ea0482c37..8ef75aff996c 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -6,6 +6,8 @@
>    * The test cpu/soc is provided for testing.
>    */
>   #include "pmu-events/pmu-events.h"
> +#include "util/header.h"
> +#include "util/pmu.h"
>   #include <string.h>
>   #include <stddef.h>
>   
> @@ -110,7 +112,26 @@ static const struct pmu_event pme_test_soc_cpu[] = {
>   	},
>   };
>   
> -const struct pmu_events_map pmu_events_map[] = {
> +
> +/*
> + * Map a CPU to its table of PMU events. The CPU is identified by the
> + * cpuid field, which is an arch-specific identifier for the CPU.
> + * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
> + * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
> + *
> + * The  cpuid can contain any character other than the comma.
> + */
> +struct pmu_events_map {
> +	const char *arch;
> +	const char *cpuid;
> +	const struct pmu_event *table;
> +};
> +
> +/*
> + * Global table mapping each known CPU for the architecture to its
> + * table of PMU events.
> + */
> +static const struct pmu_events_map pmu_events_map[] = {
>   	{
>   		.arch = "testarch",
>   		.cpuid = "testcpu",
> @@ -162,6 +183,62 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
>   	},
>   };
>   
> +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
> +{
> +	const struct pmu_event *table = NULL;
> +	char *cpuid = perf_pmu__getcpuid(pmu);
> +	int i;
> +
> +	/* on some platforms which uses cpus map, cpuid can be NULL for
> +	 * PMUs other than CORE PMUs.
> +	 */
> +	if (!cpuid)
> +		return NULL;
> +
> +	i = 0;
> +	for (;;) {
> +		const struct pmu_events_map *map = &pmu_events_map[i++];
> +
> +		if (!map->table)
> +			break;
> +
> +		if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +			table = map->table;
> +			break;
> +		}
> +	}
> +	free(cpuid);
> +	return table;
> +}
> +
> +const struct pmu_event *find_core_events_table(const char *arch, const char *cpuid)
> +{
> +	for (const struct pmu_events_map *tables = &pmu_events_map[0];
> +	     tables->table;
> +	     tables++) {
> +		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
> +			return tables->table;
> +	}
> +	return NULL;
> +}
> +
> +int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
> +{
> +	for (const struct pmu_events_map *tables = &pmu_events_map[0];
> +	     tables->table;
> +	     tables++) {
> +		for (const struct pmu_event *pe = &tables->table[0];
> +		     pe->name || pe->metric_group || pe->metric_name;
> +		     pe++) {
> +			int ret = fn(pe, &tables->table[0], data);
> +
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
>   const struct pmu_event *find_sys_events_table(const char *name)
>   {
>   	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
> @@ -181,7 +258,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
>   		for (const struct pmu_event *pe = &tables->table[0];
>   		     pe->name || pe->metric_group || pe->metric_name;
>   		     pe++) {
> -			int ret = fn(pe, data);
> +			int ret = fn(pe, &tables->table[0], data);
>   
>   			if (ret)
>   				return ret;
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index dd21bc9eeeed..e976c5e8e80b 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -333,7 +333,27 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>   
>   def print_mapping_table(archs: Sequence[str]) -> None:
>     """Read the mapfile and generate the struct from cpuid string to event table."""
> -  _args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
> +  _args.output_file.write("""
> +/*
> + * Map a CPU to its table of PMU events. The CPU is identified by the
> + * cpuid field, which is an arch-specific identifier for the CPU.
> + * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
> + * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
> + *
> + * The  cpuid can contain any character other than the comma.
> + */
> +struct pmu_events_map {
> +        const char *arch;
> +        const char *cpuid;
> +        const struct pmu_event *table;
> +};
> +
> +/*
> + * Global table mapping each known CPU for the architecture to its
> + * table of PMU events.
> + */
> +const struct pmu_events_map pmu_events_map[] = {
> +""")
>     for arch in archs:
>       if arch == 'test':
>         _args.output_file.write("""{
> @@ -389,6 +409,61 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
>   \t},
>   };
>   
> +const struct pmu_event *perf_pmu__find_table(struct perf_pmu *pmu)
> +{
> +        const struct pmu_event *table = NULL;
> +        char *cpuid = perf_pmu__getcpuid(pmu);

This seems an identical implementation to that in empty-pmu-events.c - 
can we reduce this duplication? Maybe a seperate common c file which can 
be linked in

The indentation seems different also - this version seems to use whitespaces

> +        int i;
> +
> +        /* on some platforms which uses cpus map, cpuid can be NULL for
> +         * PMUs other than CORE PMUs.
> +         */
> +        if (!cpuid)
> +                return NULL;
> +
> +        i = 0;
> +        for (;;) {
> +                const struct pmu_events_map *map = &pmu_events_map[i++];
> +                if (!map->table)
> +                        break;
> +
> +                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +                        table = map->table;
> +                        break;
> +                }
> +        }
> +        free(cpuid);
> +        return table;
> +}
