Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8051E43C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357160AbiEGFNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEGFNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:13:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221955523C;
        Fri,  6 May 2022 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651900192; x=1683436192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKSANTzukEI7R7dzgXuB++9ikagSeXw2WkoC9SVCIcs=;
  b=DxoxXMdnK4qYdmZthKfMGo6P/LxtVh6xxcPjX1CENOCgUbD4bMCDr8K0
   0D9u/S5s94FCR+CjtP3llI7Zr8bJ0Tl3XQz3PPLNkfbipmVgNU1LYiqrv
   MMHCBQXMhKrhE44UPfKsV0SVqH807J9YpFoD8+zNEAubWun9setbRR6zJ
   mrMXDeoMqZyrFSrzTdlyRoKqTzJCnTudh/JLo3SqxDhqcbIpAG0bSCJHA
   NSiu6UmuqWisuziQd6ctiesE08WiprFQiIl5x+xSY+7JmeMXJDlxzQX2k
   2hxRGQYeqYBhkVRlpXEoQ/nzpGn9dQ1BA8SJgQMiZ0ZS/DqsmfZSNEMyP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268277560"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="268277560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 22:09:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="564185139"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.152]) ([10.255.31.152])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 22:09:49 -0700
Message-ID: <4bc567a1-e7ce-92eb-06e9-3cee91a6699f@linux.intel.com>
Date:   Sat, 7 May 2022 13:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] perf stat: Merge event counts from all hybrid PMUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
References: <20220422065635.767648-1-zhengjun.xing@linux.intel.com>
 <20220422065635.767648-2-zhengjun.xing@linux.intel.com>
 <CAP-5=fWaU4d90zkqqokp-sCau5DNX_VNVb-Yz3vdqEdkkRYegw@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fWaU4d90zkqqokp-sCau5DNX_VNVb-Yz3vdqEdkkRYegw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2022 12:03 PM, Ian Rogers wrote:
> On Thu, Apr 21, 2022 at 11:57 PM <zhengjun.xing@linux.intel.com> wrote:
>>
>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>
>> For hybrid events, by default stat aggregates and reports the event counts
>> per pmu.
>>
>>    # ./perf stat -e cycles -a  sleep 1
>>
>>     Performance counter stats for 'system wide':
>>
>>        14,066,877,268      cpu_core/cycles/
>>         6,814,443,147      cpu_atom/cycles/
>>
>>           1.002760625 seconds time elapsed
>>
>> Sometimes, it's also useful to aggregate event counts from all PMUs.
>> Create a new option '--hybrid-merge' to enable that behavior and report
>> the counts without PMUs.
>>
>>    # ./perf stat -e cycles -a --hybrid-merge  sleep 1
>>
>>     Performance counter stats for 'system wide':
>>
>>        20,732,982,512      cycles
>>
>>           1.002776793 seconds time elapsed
>>
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> This feels related to aggregation, but aggregation is for a single
> evsel on a single PMU. What happens if you have both instructions and
> cycles with --hybrid-merge? Normally we aggregate all counts for each
> CPU into a the two evsels and then compute a metric:
> ```
# ./perf stat -e instructions,cycles  -a /bin/true

  Performance counter stats for 'system wide':

          2,416,092      cpu_core/instructions/
            305,840      cpu_atom/instructions/
          2,645,138      cpu_core/cycles/
            789,631      cpu_atom/cycles/

        0.002345159 seconds time elapsed

# ./perf stat -e instructions,cycles  -a --hybrid-merge /bin/true

  Performance counter stats for 'system wide':

          2,702,612      instructions
          3,607,773      cycles

        0.002475749 seconds time elapsed

Currently, no metrics showed for the hybrid systems.

> $ perf stat -e instructions,cycles /bin/true
> 
>   Performance counter stats for '/bin/true':
> 
>           1,830,554      instructions              #    1.17  insn per
> cycle
>           1,561,415      cycles
> ```
> This kind of aggregation behavior may be needed more widely for metrics.
> 
> Thanks,
> Ian
> 
>> ---
>>   tools/perf/Documentation/perf-stat.txt | 10 ++++++++++
>>   tools/perf/builtin-stat.c              |  2 ++
>>   tools/perf/util/stat-display.c         | 17 +++++++++++++++--
>>   tools/perf/util/stat.h                 |  1 +
>>   4 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index c06c341e72b9..8d1cde00b8d6 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -454,6 +454,16 @@ Multiple events are created from a single event specification when:
>>   2. Aliases, which are listed immediately after the Kernel PMU events
>>      by perf list, are used.
>>
>> +--hybrid-merge::
>> +Merge the hybrid event counts from all PMUs.
>> +
>> +For hybrid events, by default, the stat aggregates and reports the event
>> +counts per PMU. But sometimes, it's also useful to aggregate event counts
>> +from all PMUs. This option enables that behavior and reports the counts
>> +without PMUs.
>> +
>> +For non-hybrid events, it should be no effect.
>> +
>>   --smi-cost::
>>   Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index a96f106dc93a..ea88ac5bed2d 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1235,6 +1235,8 @@ static struct option stat_options[] = {
>>          OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
>>                      "disable CPU count aggregation", AGGR_NONE),
>>          OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
>> +       OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
>> +                   "Merge identical named hybrid events"),
>>          OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
>>                     "print counts with custom separator"),
>>          OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 46b3dd134656..d9629a83aa78 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -612,6 +612,19 @@ static bool hybrid_uniquify(struct evsel *evsel)
>>          return perf_pmu__has_hybrid() && !is_uncore(evsel);
>>   }
>>
>> +static bool hybrid_merge(struct evsel *counter, struct perf_stat_config *config,
>> +                        bool check)
>> +{
>> +       if (hybrid_uniquify(counter)) {
>> +               if (check)
>> +                       return config && config->hybrid_merge;
>> +               else
>> +                       return config && !config->hybrid_merge;
>> +       }
>> +
>> +       return false;
>> +}
>> +
>>   static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>>                              void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
>>                                         bool first),
>> @@ -620,9 +633,9 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>>          if (counter->merged_stat)
>>                  return false;
>>          cb(config, counter, data, true);
>> -       if (config->no_merge || hybrid_uniquify(counter))
>> +       if (config->no_merge || hybrid_merge(counter, config, false))
>>                  uniquify_event_name(counter, config);
>> -       else if (counter->auto_merge_stats)
>> +       else if (counter->auto_merge_stats || hybrid_merge(counter, config, true))
>>                  collect_all_aliases(config, counter, cb, data);
>>          return true;
>>   }
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index 335d19cc3063..91d989dfeca4 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -122,6 +122,7 @@ struct perf_stat_config {
>>          bool                     ru_display;
>>          bool                     big_num;
>>          bool                     no_merge;
>> +       bool                     hybrid_merge;
>>          bool                     walltime_run_table;
>>          bool                     all_kernel;
>>          bool                     all_user;
>> --
>> 2.25.1
>>

-- 
Zhengjun Xing
