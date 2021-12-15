Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9540475692
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhLOKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:38:56 -0500
Received: from foss.arm.com ([217.140.110.172]:47972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241720AbhLOKiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:38:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A8F6D;
        Wed, 15 Dec 2021 02:38:49 -0800 (PST)
Received: from [10.57.33.238] (unknown [10.57.33.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D06633F5A1;
        Wed, 15 Dec 2021 02:38:47 -0800 (PST)
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Ian Rogers <irogers@google.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <3a921db2-a673-bd4f-9e99-3821e2a0ce51@arm.com>
Date:   Wed, 15 Dec 2021 10:38:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2021 20:32, Ian Rogers wrote:
> On Tue, Dec 14, 2021 at 10:43 AM Andrew Kilroy <andrew.kilroy@arm.com> wrote:
>>
>> This patch implements the --topdown option by making use of metrics to
>> dictate what counters are obtained in order to show the various topdown
>> columns, e.g.  Frontend Bound, Backend Bound, Retiring and Bad
>> Speculation.
>>
>> The MetricGroup name is used to identify which set of metrics are to be
>> shown.  For the moment use TopDownL1 and enable for arm64
>>
>> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
>> ---
>>  tools/perf/arch/arm64/util/Build     |  1 +
>>  tools/perf/arch/arm64/util/topdown.c |  8 ++++++++
>>  tools/perf/builtin-stat.c            | 13 +++++++++++++
>>  tools/perf/util/metricgroup.c        | 12 ++++++++++++
>>  tools/perf/util/metricgroup.h        |  7 +++++++
>>  tools/perf/util/topdown.c            |  6 ++++++
>>  tools/perf/util/topdown.h            |  1 +
>>  7 files changed, 48 insertions(+)
>>  create mode 100644 tools/perf/arch/arm64/util/topdown.c
>>
>> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
>> index 9fcb4e68add9..9807aed981cd 100644
>> --- a/tools/perf/arch/arm64/util/Build
>> +++ b/tools/perf/arch/arm64/util/Build
>> @@ -4,6 +4,7 @@ perf-y += perf_regs.o
>>  perf-y += tsc.o
>>  perf-y += pmu.o
>>  perf-y += kvm-stat.o
>> +perf-y += topdown.o
>>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>> diff --git a/tools/perf/arch/arm64/util/topdown.c b/tools/perf/arch/arm64/util/topdown.c
>> new file mode 100644
>> index 000000000000..a2b1f9c01148
>> --- /dev/null
>> +++ b/tools/perf/arch/arm64/util/topdown.c
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <topdown.h>
>> +
>> +
>> +bool arch_topdown_use_json_metrics(void)
>> +{
>> +       return true;
>> +}
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index f6ca2b054c5b..08ef80ef345e 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1856,6 +1856,18 @@ static int add_default_attributes(void)
>>                 if (!force_metric_only)
>>                         stat_config.metric_only = true;
>>
>> +               if (arch_topdown_use_json_metrics()) {
>> +                       if (metricgroup__parse_groups_to_evlist(evsel_list, "TopDownL1",
>> +                                                               stat_config.metric_no_group,
>> +                                                               stat_config.metric_no_merge,
>> +                                                               &stat_config.metric_events) < 0) {
>> +                               pr_err("Could not form list of metrics for topdown\n");
>> +                               return -1;
>> +                       }
>> +
>> +                       goto end_of_topdown_setup;
>> +               }
>> +
>>                 if (pmu_have_event("cpu", topdown_metric_L2_attrs[5])) {
>>                         metric_attrs = topdown_metric_L2_attrs;
>>                         max_level = 2;
>> @@ -1919,6 +1931,7 @@ static int add_default_attributes(void)
>>                         fprintf(stderr, "System does not support topdown\n");
>>                         return -1;
>>                 }
>> +end_of_topdown_setup:
>>                 free(str);
>>         }
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 51c99cb08abf..9b0394372096 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -1535,6 +1535,18 @@ int metricgroup__parse_groups(const struct option *opt,
>>                             metric_no_merge, NULL, metric_events, map);
>>  }
>>
>> +int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
>> +                                       const char *str,
>> +                                       bool metric_no_group,
>> +                                       bool metric_no_merge,
>> +                                       struct rblist *metric_events)
>> +{
>> +       const struct pmu_events_map *map = pmu_events_map__find();
>> +
>> +       return parse_groups(perf_evlist, str, metric_no_group,
>> +                           metric_no_merge, NULL, metric_events, map);
>> +}
>> +
>>  int metricgroup__parse_groups_test(struct evlist *evlist,
>>                                    const struct pmu_events_map *map,
>>                                    const char *str,
>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>> index 2b42b778d1bf..1f143ad1d9e1 100644
>> --- a/tools/perf/util/metricgroup.h
>> +++ b/tools/perf/util/metricgroup.h
>> @@ -70,6 +70,13 @@ int metricgroup__parse_groups(const struct option *opt,
>>                               bool metric_no_group,
>>                               bool metric_no_merge,
>>                               struct rblist *metric_events);
>> +
>> +int metricgroup__parse_groups_to_evlist(struct evlist *perf_evlist,
>> +                                       const char *str,
>> +                                       bool metric_no_group,
>> +                                       bool metric_no_merge,
>> +                                       struct rblist *metric_events);
>> +
>>  const struct pmu_event *metricgroup__find_metric(const char *metric,
>>                                                  const struct pmu_events_map *map);
>>  int metricgroup__parse_groups_test(struct evlist *evlist,
>> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
>> index 1081b20f9891..57c0c5f2c6bd 100644
>> --- a/tools/perf/util/topdown.c
>> +++ b/tools/perf/util/topdown.c
>> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel *leader __maybe_unused)
>>  {
>>         return false;
>>  }
>> +
>> +__weak bool arch_topdown_use_json_metrics(void)
>> +{
> 
> I like this extension! I've ranted in the past about weak symbols
> breaking with archives due to lazy loading [1]. In this case
> tools/perf/arch/arm64/util/topdown.c has no other symbols within it
> and so the weak symbol has an extra chance of being linked
> incorrectly. We could add a new command line of --topdown-json to
> avoid this, but there seems little difference in doing this over just
> doing '-M TopDownL1'. Is it possible to use the json metric approach
> for when the CPU version fails?

If weak symbols are an issue we could define the function normally for
all known platforms. Or just do arm64 and 'other'. I think the end result is
the same. Or have only one function like this:

  bool arch_topdown_use_json_metrics(void)
  {
     #ifdef aarch64
         return true;
     #elseif ...
  }

There are quite a few ways to avoid it. I'm not sure I like the
--topdown-json argument as it would be quite fragmented from a user's
point of view, especially if it was only to work around some linking
issue.

James

> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/CAP-5=fVS2AwZ9bP4BjF9GDcZqmw5fwUZ6OGXdgMnFj3w_2OTaw@mail.gmail.com/
> 
>> +       return false;
>> +}
>> +
>> diff --git a/tools/perf/util/topdown.h b/tools/perf/util/topdown.h
>> index 2f0d0b887639..0a5275a3f078 100644
>> --- a/tools/perf/util/topdown.h
>> +++ b/tools/perf/util/topdown.h
>> @@ -6,6 +6,7 @@
>>  bool arch_topdown_check_group(bool *warn);
>>  void arch_topdown_group_warn(void);
>>  bool arch_topdown_sample_read(struct evsel *leader);
>> +bool arch_topdown_use_json_metrics(void);
>>
>>  int topdown_filter_events(const char **attr, char **str, bool use_group);
>>
>> --
>> 2.17.1
>>
