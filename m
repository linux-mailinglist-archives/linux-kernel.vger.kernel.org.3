Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF97544964
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiFIKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbiFIKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:41:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202C265208;
        Thu,  9 Jun 2022 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654771285; x=1686307285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/rZ/cmVg1xRRULer/B8wH9YfqMjm5s1dbHpQmBQNiu0=;
  b=J2/fM1TJ//Zrh5vK5JO9lvzKXuzurYs6AlDWv7c9luKXwp3y4oS6ByQ0
   NadDn1p8hg6JLwn5zCZpjOGGJoUhXZhVrG2sZ34TW874hJt67kkd0vT7+
   Ck2tpy/RpIXtZLmHSnhwDaPxggSdkvxdHP3jvbT9DN2xCvWi2i/RfwtJc
   Yr3bMQryrZmkkXeVnQdIhTFAMwLID2R33VyE/cmKvDk/yqEdrFMryxFn2
   NjW0f/qumENv1D28vl+ogM+B3wMl4JreBOnqO/ZFOLXHh237vmaFXSWaX
   wHlkI0FwxXQ7wyJ31avgr4l7FsBVWSipoURYzfvoL1rGWSvVgkZuxkh9U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="302602657"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="302602657"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 03:41:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="637407833"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.28.81]) ([10.255.28.81])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 03:41:22 -0700
Message-ID: <b6a49ed6-612f-5f53-a08c-c35bae52cfe3@linux.intel.com>
Date:   Thu, 9 Jun 2022 18:41:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] perf stat: Add topdown metrics in the default perf
 stat on the hybrid machine
Content-Language: en-US
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, alexander.shishkin@intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20220607013315.1956301-1-zhengjun.xing@linux.intel.com>
 <20220607013315.1956301-6-zhengjun.xing@linux.intel.com>
 <CAM9d7ciZAZzsA=cDojZp8H5tTd-F7NC=OnTMRg3S3cdjCW0+eA@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAM9d7ciZAZzsA=cDojZp8H5tTd-F7NC=OnTMRg3S3cdjCW0+eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2022 8:09 AM, Namhyung Kim wrote:
> On Tue, Jun 7, 2022 at 1:08 AM <zhengjun.xing@linux.intel.com> wrote:
>>
>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>
>> Topdown metrics are missed in the default perf stat on the hybrid machine,
>> add Topdown metrics in default perf stat for hybrid systems.
>>
>> Currently, we support the perf metrics Topdown for the p-core PMU in the
>> perf stat default, the perf metrics Topdown support for e-core PMU will be
>> implemented later separately. Refactor the code adds two x86 specific
>> functions. Widen the size of the event name column by 7 chars, so that all
>> metrics after the "#" become aligned again.
>>
>> The perf metrics topdown feature is supported on the cpu_core of ADL. The
>> dedicated perf metrics counter and the fixed counter 3 are used for the
>> topdown events. Adding the topdown metrics doesn't trigger multiplexing.
>>
>> Before:
>>
>>   # ./perf  stat  -a true
>>
>>   Performance counter stats for 'system wide':
>>
>>               53.70 msec cpu-clock                 #   25.736 CPUs utilized
>>                  80      context-switches          #    1.490 K/sec
>>                  24      cpu-migrations            #  446.951 /sec
>>                  52      page-faults               #  968.394 /sec
>>           2,788,555      cpu_core/cycles/          #   51.931 M/sec
>>             851,129      cpu_atom/cycles/          #   15.851 M/sec
>>           2,974,030      cpu_core/instructions/    #   55.385 M/sec
>>             416,919      cpu_atom/instructions/    #    7.764 M/sec
>>             586,136      cpu_core/branches/        #   10.916 M/sec
>>              79,872      cpu_atom/branches/        #    1.487 M/sec
>>              14,220      cpu_core/branch-misses/   #  264.819 K/sec
>>               7,691      cpu_atom/branch-misses/   #  143.229 K/sec
>>
>>         0.002086438 seconds time elapsed
>>
>> After:
>>
>>   # ./perf stat  -a true
>>
>>   Performance counter stats for 'system wide':
>>
>>               61.39 msec cpu-clock                        #   24.874 CPUs utilized
>>                  76      context-switches                 #    1.238 K/sec
>>                  24      cpu-migrations                   #  390.968 /sec
>>                  52      page-faults                      #  847.097 /sec
>>           2,753,695      cpu_core/cycles/                 #   44.859 M/sec
>>             903,899      cpu_atom/cycles/                 #   14.725 M/sec
>>           2,927,529      cpu_core/instructions/           #   47.690 M/sec
>>             428,498      cpu_atom/instructions/           #    6.980 M/sec
>>             581,299      cpu_core/branches/               #    9.470 M/sec
>>              83,409      cpu_atom/branches/               #    1.359 M/sec
>>              13,641      cpu_core/branch-misses/          #  222.216 K/sec
>>               8,008      cpu_atom/branch-misses/          #  130.453 K/sec
>>          14,761,308      cpu_core/slots/                  #  240.466 M/sec
>>           3,288,625      cpu_core/topdown-retiring/       #     22.3% retiring
>>           1,323,323      cpu_core/topdown-bad-spec/       #      9.0% bad speculation
>>           5,477,470      cpu_core/topdown-fe-bound/       #     37.1% frontend bound
>>           4,679,199      cpu_core/topdown-be-bound/       #     31.7% backend bound
>>             646,194      cpu_core/topdown-heavy-ops/      #      4.4% heavy operations       #     17.9% light operations
>>           1,244,999      cpu_core/topdown-br-mispredict/  #      8.4% branch mispredict      #      0.5% machine clears
>>           3,891,800      cpu_core/topdown-fetch-lat/      #     26.4% fetch latency          #     10.7% fetch bandwidth
>>           1,879,034      cpu_core/topdown-mem-bound/      #     12.7% memory bound           #     19.0% Core bound
>>
>>         0.002467839 seconds time elapsed
>>
>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> [SNIP]
>> +const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
>> +{
>> +       const char *pmu_name = "cpu";
>> +
>> +       if (perf_pmu__has_hybrid()) {
>> +               if (!evlist->hybrid_pmu_name) {
>> +                       if (warn)
>> +                               pr_warning
>> +                                   ("WARNING: default to use cpu_core topdown events\n");
>> +                       evlist->hybrid_pmu_name =
>> +                           perf_pmu__hybrid_type_to_pmu("core");
> 
> This doesn't look good.  Please consider reducing the
> indent level like returning early as
> 
>      if (!perf_pmu__has_hybrid())
>          return "cpu";
> 
>      if (!evlist->hybrid_pmu_name) {
>          ...
> 
Thanks for the comments, I will update it in the next version.
> Thanks,
> Namhyung
> 
> 
>> +               }
>> +
>> +               pmu_name = evlist->hybrid_pmu_name;
>> +       }
>> +       return pmu_name;
>> +}

-- 
Zhengjun Xing
