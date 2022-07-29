Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC63584D63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiG2IaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiG2I37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:29:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E295A8A9;
        Fri, 29 Jul 2022 01:29:57 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LvLFP1j6vz67XvQ;
        Fri, 29 Jul 2022 16:26:01 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 10:29:54 +0200
Received: from [10.195.35.4] (10.195.35.4) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 09:29:53 +0100
Message-ID: <393770c6-8469-a5b5-5106-a98420bb6e00@huawei.com>
Date:   Fri, 29 Jul 2022 09:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 05/17] perf jevents: Remove the type/version variables
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
References: <20220729074351.138260-1-irogers@google.com>
 <20220729074351.138260-6-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220729074351.138260-6-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.35.4]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2022 08:43, Ian Rogers wrote:
> pmu_events_map has a type variable that is always initialized to "core"
> and a version variable that is never read. Remove these from the API as
> it is straightforward to add them back when necessary.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: John Garry <john.garry@huawei.com>

Please note the questions, below.

> ---
>   tools/perf/pmu-events/empty-pmu-events.c | 6 ++----
>   tools/perf/pmu-events/jevents.py         | 6 ------
>   tools/perf/pmu-events/pmu-events.h       | 2 --
>   tools/perf/tests/expand-cgroup.c         | 2 --
>   tools/perf/tests/parse-metric.c          | 2 --
>   5 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index 77e655c6f116..4182a986f505 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -110,15 +110,13 @@ static const struct pmu_event pme_test_soc_cpu[] = {
>   
>   const struct pmu_events_map pmu_events_map[] = {
>   	{
> +		.arch = "testarch",

Is this really supposed to be part of this patch?

>   		.cpuid = "testcpu",
> -		.version = "v1",
> -		.type = "core",
>   		.table = pme_test_soc_cpu,
>   	},
>   	{
> +		.arch = 0,

Same as above

>   		.cpuid = 0,
> -		.version = 0,
> -		.type = 0,
>   		.table = 0,
>   	},
>   };
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index e6e6c42c3f8a..98d18d5c3830 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -312,8 +312,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
>         _args.output_file.write("""{
>   \t.arch = "testarch",
>   \t.cpuid = "testcpu",
> -\t.version = "v1",
> -\t.type = "core",
>   \t.table = pme_test_soc_cpu,
>   },
>   """)
> @@ -329,8 +327,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
>               _args.output_file.write(f"""{{
>   \t.arch = "{arch}",
>   \t.cpuid = "{cpuid}",
> -\t.version = "{row[1]}",
> -\t.type = "{row[3]}",
>   \t.table = {tblname}
>   }},
>   """)
> @@ -339,8 +335,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
>     _args.output_file.write("""{
>   \t.arch = 0,
>   \t.cpuid = 0,
> -\t.version = 0,
> -\t.type = 0,
>   \t.table = 0,
>   }
>   };
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index 7a360792635f..a491b117c8ac 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -40,8 +40,6 @@ struct pmu_event {
>   struct pmu_events_map {
>   	const char *arch;
>   	const char *cpuid;
> -	const char *version;
> -	const char *type;		/* core, uncore etc */
>   	const struct pmu_event *table;
>   };
>   
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> index dfefe5b60eb2..dc4038f997d7 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -197,8 +197,6 @@ static int expand_metric_events(void)
>   	};
>   	const struct pmu_events_map ev_map = {
>   		.cpuid		= "test",
> -		.version	= "1",
> -		.type		= "core",
>   		.table		= pme_test,
>   	};
>   
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 07b6f4ec024f..1b811a26f4ee 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -81,8 +81,6 @@ static struct pmu_event pme_test[] = {
>   
>   static const struct pmu_events_map map = {
>   	.cpuid		= "test",
> -	.version	= "1",
> -	.type		= "core",
>   	.table		= pme_test,
>   };
>   

