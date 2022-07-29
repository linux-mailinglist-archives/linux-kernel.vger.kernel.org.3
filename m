Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFAA585206
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiG2PDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiG2PDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:03:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F81582F;
        Fri, 29 Jul 2022 08:03:41 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LvVyj4VRjz67PfY;
        Fri, 29 Jul 2022 22:58:53 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 29 Jul 2022 17:03:38 +0200
Received: from [10.195.35.4] (10.195.35.4) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 16:03:37 +0100
Message-ID: <d8356ddc-56e7-7324-5330-ff2bd54bcba4@huawei.com>
Date:   Fri, 29 Jul 2022 16:03:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 00/17] Compress the pmu_event tables
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
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
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
> jevents.py creates a number of large arrays from the json events. The
> arrays contain pointers to strings that need relocating. The
> relocations have file size, run time and memory costs. These changes
> refactor the pmu_events API so that the storage of the pmu_event
> struct isn't exposed. The format is then changed to an offset within a
> combined big string, with adjacent pmu_event struct variables being
> next to each other in the string separated by \0 - meaning only the
> first variable of the struct needs its offset recording.
> 
> Some related fixes are contained with the patches. The architecture
> jevents.py creates tables for can now be set by the JEVENTS_ARCH make
> variable, with a new 'all' that generates the events and metrics for
> all architectures.

Hi Ian,

I am going through this series currently.

But I just wanted to mention my idea again on how to compress the 
tables. Maybe you thought that there was no value in my idea or didn't 
get it, but I'll mention it again just in case...

Background:
There is much duplication in events between cores. And currently we have 
something like this:

pmu-events/pmu-events.c:
struct pmu_event core0[] {
{
	.name = event0,
	.event = "event=0x0",
},
{
	.name = event1,
	.event = "event=0x1",
},
{
	.name = event2,
	.event = "event=0x2",
	.desc = "event2 common desc",
},
...
};

struct pmu_event core1[] {
{
	.name = event0,
	.event = "event=0x0",
},
{
	.name = event1,
	.event = "event=0x1",
},
{
	.name = event2,
	.event = "event=0x2",
	.desc = "event2 desc for core1",
},
...
};


struct pmu_evenets_map map[] = {
{
	.cpuid = "0000",
	.table = core0,
},
{
	.cpuid = "0001",
	.table = core1,
},
...
};

If you check broadwell and broadwellde frontent.json you will notice 
that they are identical, which is an extreme example of duplication.

Proposal for change:
Make each event in the per-core pmu event table point to common event. 
Each common event is unique, and each event per-core will point to a 
common event. So if 2x cores have same event but small difference, then 
there would be still 2x common events.

pmu-events/pmu-events.c:
struct pmu_event common_events[] {
{
	.name = event0,
	.event = "event=0x0",
},
{
	.name = event1,
	.event = "event=0x1",
},
{
	.name = event2,
	.event = "event=0x2",
	.desc = "event2 common desc",
},
{
	.name = event2,
	.event = "event=0x2",
	.desc = "event2 desc for core1",
},
...
};

struct pmu_event_ptr {
	struct pmu_event *pmu_event;
}

struct pmu_event_ptr core0[] {
{
	.pmu_event = &common_events[0],
},
{
	.pmu_event = &common_events[1],
},
{
	.pmu_event = &common_events[2],
},
...
};

struct pmu_event_ptr core0[] {
{
	.pmu_event = &common_events[0],
},
{
	.pmu_event = &common_events[1],
},
{
	.pmu_event = &common_events[3],
},
...
};

struct pmu_evenets_map map[] = {
{
	.cpuid = "0000",
	.table = core0,
},
{
	.cpuid = "0001",
	.table = core1,
},
...
};

For x86, first step in JSON parsing would be to go through the JSON 
files and compile a list of unique events. Then second step is to 
process each per-core JSON to create the pmu events table, using the 
common events. Using a per common event hash would make the lookup quicker.

I'm not sure what you think. From figures below you seem to be saving 
~20% at best - I would guess (with a capital G) that my method could 
save a lot more.

This implementation would require core pmu.c to be changed, but there is 
ways that this could be done without needing to change core pmu.c

Thanks,
John

> 
> An example of the improvement to the file size on x86 is:
> no jevents - the same 19,788,464bytes
> x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
> all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
> default build options plus NO_LIBBFD=1.
> 
> I originally suggested fixing this problem in:
> https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/
> 
> v3. Fix an ARM build issue with a missed weak symbol. Perform some
>      pytype clean up.
> v2. Split the substring folding optimization to its own patch and
>      comment tweaks as suggested by Namhyung Kim
>      <namhyung@kernel.org>. Recompute the file size savings with the
>      latest json events and metrics.
> 
> Ian Rogers (17):
>    perf jevents: Clean up pytype warnings
>    perf jevents: Simplify generation of C-string
>    perf jevents: Add JEVENTS_ARCH make option
>    perf jevent: Add an 'all' architecture argument
>    perf jevents: Remove the type/version variables
>    perf jevents: Provide path to json file on error
>    perf jevents: Sort json files entries
>    perf pmu-events: Hide pmu_sys_event_tables
>    perf pmu-events: Avoid passing pmu_events_map
>    perf pmu-events: Hide pmu_events_map
>    perf test: Use full metric resolution
>    perf pmu-events: Move test events/metrics to json
>    perf pmu-events: Don't assume pmu_event is an array
>    perf pmu-events: Hide the pmu_events
>    perf metrics: Copy entire pmu_event in find metric
>    perf jevents: Compress the pmu_events_table
>    perf jevents: Fold strings optimization
> 
>   tools/perf/arch/arm64/util/pmu.c              |   4 +-
>   tools/perf/pmu-events/Build                   |   6 +-
>   .../arch/test/test_soc/cpu/metrics.json       |  64 +++
>   tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
>   tools/perf/pmu-events/jevents.py              | 495 ++++++++++++++----
>   tools/perf/pmu-events/pmu-events.h            |  40 +-
>   tools/perf/tests/expand-cgroup.c              |  25 +-
>   tools/perf/tests/parse-metric.c               |  77 +--
>   tools/perf/tests/pmu-events.c                 | 466 +++++++----------
>   tools/perf/util/metricgroup.c                 | 275 ++++++----
>   tools/perf/util/metricgroup.h                 |   5 +-
>   tools/perf/util/pmu.c                         | 139 ++---
>   tools/perf/util/pmu.h                         |   8 +-
>   tools/perf/util/s390-sample-raw.c             |  50 +-
>   14 files changed, 1140 insertions(+), 718 deletions(-)
>   create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
> 

