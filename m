Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA3545A18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiFJCbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbiFJCbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:31:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234DFC4E8C;
        Thu,  9 Jun 2022 19:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654828268; x=1686364268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vLMhMIrAaMCFp73bqb/mdQxK8x05/T7Fuhv3E0BO7uY=;
  b=chIpHJ1fo/Zvo0ZTEYwEitmLyj1L88y7L6aZlvJmBDujjh5Ddl9GaqwV
   DA34eJL2rtuqdFsrelCFqLSKYH1x+PVv+ncqHP4C0VnAaF+whHvC04XzD
   mPf2+mOthnA6wGDVHry+73d0Qc/JkS1tpV1QKa4dKfNcEWJep7Ole4Q9x
   aBnG2G25a1odZfbTWIniqVYQa/lEZKMqlm9gYz/L+C1WdbgY+ad0VZImq
   q0CfaBso84jKH2ZQWye2kksngBRma9AbJbJfyymkxapxZB50xqpdU/vOw
   eUH9UlsVsuFQnAQaImgtJg6kLCBT38qMj7H1o30eKXsUM3g/SnsYhYZXu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339242820"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="339242820"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:31:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="649581664"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.168.129]) ([10.249.168.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:31:04 -0700
Message-ID: <ed308d14-86f2-833e-d7ec-bae5ebe6fe85@linux.intel.com>
Date:   Fri, 10 Jun 2022 10:31:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Add default hybrid events for
 perf stat
Content-Language: en-US
To:     Namhyung Kim <namhyung@gmail.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
 <20220609145314.2064632-5-zhengjun.xing@linux.intel.com>
 <8358dc65-88d8-1550-96bd-9e66477c4bd5@linux.intel.com>
 <CAM9d7ch9MR6H3soO17+F9M0hMRYX9b6Tf2oKmKTd60SHxycXLA@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAM9d7ch9MR6H3soO17+F9M0hMRYX9b6Tf2oKmKTd60SHxycXLA@mail.gmail.com>
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



On 6/10/2022 5:54 AM, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jun 9, 2022 at 9:01 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 6/9/2022 10:53 AM, zhengjun.xing@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> Provide a new solution to replace the reverted commit ac2dc29edd21
>>> ("perf stat: Add default hybrid events").
>>>
>>> For the default software attrs, nothing is changed.
>>> For the default hardware attrs, create a new evsel for each hybrid pmu.
>>>
>>> With the new solution, adding a new default attr will not require the
>>> special support for the hybrid platform anymore.
>>>
>>> Also, the "--detailed" is supported on the hybrid platform
>>>
>>> With the patch,
>>>
>>> ./perf stat -a -ddd sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>          32,231.06 msec cpu-clock                 #   32.056 CPUs utilized
>>>                529      context-switches          #   16.413 /sec
>>>                 32      cpu-migrations            #    0.993 /sec
>>>                 69      page-faults               #    2.141 /sec
>>>        176,754,151      cpu_core/cycles/          #    5.484 M/sec          (41.65%)
>>>        161,695,280      cpu_atom/cycles/          #    5.017 M/sec          (49.92%)
>>>         48,595,992      cpu_core/instructions/    #    1.508 M/sec          (49.98%)
>>>         32,363,337      cpu_atom/instructions/    #    1.004 M/sec          (58.26%)
>>>         10,088,639      cpu_core/branches/        #  313.010 K/sec          (58.31%)
>>>          6,390,582      cpu_atom/branches/        #  198.274 K/sec          (58.26%)
>>>            846,201      cpu_core/branch-misses/   #   26.254 K/sec          (66.65%)
>>>            676,477      cpu_atom/branch-misses/   #   20.988 K/sec          (58.27%)
>>>         14,290,070      cpu_core/L1-dcache-loads/ #  443.363 K/sec          (66.66%)
>>>          9,983,532      cpu_atom/L1-dcache-loads/ #  309.749 K/sec          (58.27%)
>>>            740,725      cpu_core/L1-dcache-load-misses/ #   22.982 K/sec    (66.66%)
>>>    <not supported>      cpu_atom/L1-dcache-load-misses/
>>>            480,441      cpu_core/LLC-loads/       #   14.906 K/sec          (66.67%)
>>>            326,570      cpu_atom/LLC-loads/       #   10.132 K/sec          (58.27%)
>>>                329      cpu_core/LLC-load-misses/ #   10.208 /sec           (66.68%)
>>>                  0      cpu_atom/LLC-load-misses/ #    0.000 /sec           (58.32%)
>>>    <not supported>      cpu_core/L1-icache-loads/
>>>         21,982,491      cpu_atom/L1-icache-loads/ #  682.028 K/sec          (58.43%)
>>>          4,493,189      cpu_core/L1-icache-load-misses/ #  139.406 K/sec    (33.34%)
>>>          4,711,404      cpu_atom/L1-icache-load-misses/ #  146.176 K/sec    (50.08%)
>>>         13,713,090      cpu_core/dTLB-loads/      #  425.462 K/sec          (33.34%)
>>>          9,384,727      cpu_atom/dTLB-loads/      #  291.170 K/sec          (50.08%)
>>>            157,387      cpu_core/dTLB-load-misses/ #    4.883 K/sec         (33.33%)
>>>            108,328      cpu_atom/dTLB-load-misses/ #    3.361 K/sec         (50.08%)
>>>    <not supported>      cpu_core/iTLB-loads/
>>>    <not supported>      cpu_atom/iTLB-loads/
>>>             37,655      cpu_core/iTLB-load-misses/ #    1.168 K/sec         (33.32%)
>>>             61,661      cpu_atom/iTLB-load-misses/ #    1.913 K/sec         (50.03%)
>>>    <not supported>      cpu_core/L1-dcache-prefetches/
>>>    <not supported>      cpu_atom/L1-dcache-prefetches/
>>>    <not supported>      cpu_core/L1-dcache-prefetch-misses/
>>>    <not supported>      cpu_atom/L1-dcache-prefetch-misses/
>>>
>>>          1.005466919 seconds time elapsed
>>>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>> ---
>>> Change log:
>>>     v2:
>>>       * The index of all new evsel will be updated when adding to the evlist,
>>>         just set 0 idx for the new evsel.
>>>
>>>    tools/perf/arch/x86/util/evlist.c | 52 ++++++++++++++++++++++++++++++-
>>>    tools/perf/util/evlist.c          |  2 +-
>>>    tools/perf/util/evlist.h          |  2 ++
>>>    3 files changed, 54 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>>> index 777bdf182a58..fd3500fd4b69 100644
>>> --- a/tools/perf/arch/x86/util/evlist.c
>>> +++ b/tools/perf/arch/x86/util/evlist.c
>>> @@ -4,16 +4,66 @@
>>>    #include "util/evlist.h"
>>>    #include "util/parse-events.h"
>>>    #include "topdown.h"
>>> +#include "util/event.h"
>>> +#include "util/pmu-hybrid.h"
>>>
>>>    #define TOPDOWN_L1_EVENTS   "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
>>>    #define TOPDOWN_L2_EVENTS   "{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
>>>
>>> +static int ___evlist__add_default_attrs(struct evlist *evlist,
>>> +                                     struct perf_event_attr *attrs,
>>> +                                     size_t nr_attrs)
>>> +{
>>> +     struct perf_cpu_map *cpus;
>>> +     struct evsel *evsel, *n;
>>> +     struct perf_pmu *pmu;
>>> +     LIST_HEAD(head);
>>> +     size_t i = 0;
>>> +
>>> +     for (i = 0; i < nr_attrs; i++)
>>> +             event_attr_init(attrs + i);
>>> +
>>> +     if (!perf_pmu__has_hybrid())
>>> +             return evlist__add_attrs(evlist, attrs, nr_attrs);
>>> +
>>> +     for (i = 0; i < nr_attrs; i++) {
>>> +             if (attrs[i].type == PERF_TYPE_SOFTWARE) {
>>> +                     evsel = evsel__new_idx(attrs + i, evlist->core.nr_entries);
>>
>> Although the idx will be updated later, the value doesn't matter.
>> I think it should be better to use 0, rather than
>> evlist->core.nr_entries. Because it's a new evsel and hasn't been added
>> into the evlist yet.
> 
> You can just use evsel__new() which does the same.
> 
Yes, evsel__new() can work for it, I will update it in the next version, 
thanks.
> Thanks,
> Namhyung

-- 
Zhengjun Xing
