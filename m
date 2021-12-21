Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414247C121
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbhLUODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:03:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:50587 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhLUODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640095403; x=1671631403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ew0G8WM+VTpwrJE101MQQ+KB69Q+us1//I+VQV9XUtY=;
  b=Ew0MXoC6gbPq7izMH/M3cktA3xiR6L2wHiWxmluOvQNro6emS4sLtqxe
   FAJYCu3tvOwJuHjW2DicdS8jpRUO8qZD/N7YYxWwT0SwYR7QaaQ2zcayw
   y29hhejQPiB4OsH4u4gxnJcUuPv3z1MqH9RqfikKYB8bFqh8CKQwCaFDs
   SHm06aud9GR4LDpweV8TStUzwz1e1ZWB9DiqgS1pvc1ZDA4rBtQBEgFG9
   W6El2KepS17G7RWJE56Jyev3buz2tt9lNxTj6OAHtdmnaKm2tjCfCC0Hc
   idrAofDoI9VHa8cBJPG6LYco4244uDi6ZZ9+nfjGOf+XPq746l+hZlc1+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240621163"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240621163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:03:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684669415"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.20.192]) ([10.209.20.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:03:22 -0800
Message-ID: <12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com>
Date:   Tue, 21 Dec 2021 06:03:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Content-Language: en-US
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Will Deacon <will@kernel.org>,
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
 <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
 <5a2e29c1-2c7e-1b55-9192-62060309aeca@arm.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <5a2e29c1-2c7e-1b55-9192-62060309aeca@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/2021 9:21 AM, Andrew Kilroy wrote:
>
> On 15/12/2021 10:52, John Garry wrote:
>> Hi Andrew,
>>
>>>>   const struct pmu_event *metricgroup__find_metric(const char *metric,
>>>>                                                   const struct 
>>>> pmu_events_map *map);
>>>>   int metricgroup__parse_groups_test(struct evlist *evlist,
>>>> diff --git a/tools/perf/util/topdown.c b/tools/perf/util/topdown.c
>>>> index 1081b20f9891..57c0c5f2c6bd 100644
>>>> --- a/tools/perf/util/topdown.c
>>>> +++ b/tools/perf/util/topdown.c
>>>> @@ -56,3 +56,9 @@ __weak bool arch_topdown_sample_read(struct evsel 
>>>> *leader __maybe_unused)
>>>>   {
>>>>          return false;
>>>>   }
>>>> +
>>>> +__weak bool arch_topdown_use_json_metrics(void)
>>>> +{
>>
>> AFAICS, only x86 supports topdown today and that is because they have 
>> special kernel topdown events exposed for the kernel CPU PMU driver. 
>> So other architectures - not only arm - would need rely on 
>> metricgroups for topdown support. So let's make this generic for all 
>> archs.
>>
>>> I like this extension! I've ranted in the past about weak symbols
>>> breaking with archives due to lazy loading [1]. In this case
>>> tools/perf/arch/arm64/util/topdown.c has no other symbols within it
>>> and so the weak symbol has an extra chance of being linked
>>> incorrectly. We could add a new command line of --topdown-json to
>>> avoid this, but there seems little difference in doing this over just
>>> doing '-M TopDownL1'.
>>
>>
>>> Is it possible to use the json metric approach
>>> for when the CPU version fails?
>>
>> I think that's a good idea.
>>
>
>
> While looking into using the json metrics approach as a fallback to 
> the original, I noticed  there are two json metricgroups 'TopdownL1' 
> and 'TopDownL1' (note the case difference) on x86. Not sure if the 
> case difference is intentional.
>
> On skylake, 'TopdownL1' contains the four json metrics Retiring, 
> Bad_Speculation, Frontend_Bound, and Backend_Bound.  'TopDownL1' has 
> 'SLOTS', 'CoreIPC', 'CoreIPC_SMT', 'Instructions'.  I think its a 
> similar situation on other x86 chips.


There's also SMT metrics.


We don't want to include CoreIPC etc. by default because it would cause 
multiplexing in common situations.

>
> The search for those metrics by metricgroup name is case insensitive, 
> so it's picking up all 8 metrics when using the lookup string 
> 'TopDownL1'.  So the extra 'SLOTS', 'CoreIPC', 'CoreIPC_SMT', 
> 'Instructions' metrics would be printed as well.
>
> Not sure what the significance of the case difference might be.
>
> Should we use a different string than 'TopDownL1' as the metric group 
> name to search for?


We should probably fix the case (or just make the match case insensitive)

Can we just keep x86 at using the kernel metrics? On Skylake and earlier 
it needs different formulas and other options depending whether SMT is 
on or off, so it's not straight forward to express it as json directly.


-Andi

