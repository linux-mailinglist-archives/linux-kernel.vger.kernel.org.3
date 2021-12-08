Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13B46D3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbhLHMyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:54:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4232 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhLHMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:54:19 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8H3W3mtnz67nPb;
        Wed,  8 Dec 2021 20:46:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 13:50:45 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 12:50:43 +0000
Subject: Re: [PATCH 02/22] perf stat: Add aggr creators that are passed a cpu.
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Vineet Singh" <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <eranian@google.com>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-3-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b3a5622d-ad63-5112-607e-8a79c7c52ef7@huawei.com>
Date:   Wed, 8 Dec 2021 12:50:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211208024607.1784932-3-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 02:45, Ian Rogers wrote:
> The cpu_map and index can get confused. Add variants of the cpu_map__get
> routines that are passed a cpu. Make the existing cpu_map__get routines
> use the new functions with a view to remove them when no longer used.
> 
> Signed-off-by: Ian Rogers<irogers@google.com>
> ---
>   tools/perf/util/cpumap.c | 79 +++++++++++++++++++++++-----------------
>   tools/perf/util/cpumap.h |  6 ++-
>   2 files changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 87d3eca9b872..49fba2c53822 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -128,21 +128,23 @@ int cpu_map__get_socket_id(int cpu)
>   	return ret ?: value;
>   }
>   
> -struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> -					void *data __maybe_unused)
> +struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
>   {
> -	int cpu;
>   	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
>   
> -	if (idx > map->nr)
> -		return id;
> -
> -	cpu = map->map[idx];
> -
>   	id.socket = cpu_map__get_socket_id(cpu);
>   	return id;
>   }
>   
> +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,

This is code added in this patch - so is "idx" a cpu map index? that's 
what the commit message implies.

regardless of this - you add code here and then remove it later in the 
series. Can you arrange the series such that any code added in the 
series is not removed (later in that series)? That's a general practice 
we adhere to.

Thanks,
John
