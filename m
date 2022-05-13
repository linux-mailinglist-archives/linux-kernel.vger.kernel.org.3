Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296215266F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382387AbiEMQYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382381AbiEMQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:24:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EA496A3;
        Fri, 13 May 2022 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652459056; x=1683995056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cHmGMJ4nv/hth6ED6M+mIJSsfvkBnrX8Me5M1EcWKqQ=;
  b=DF9lJ3JB72IzcVvI1TWt6mqu6X8fGMDpq2Kj4MVzxIemaOWLAMth7f0A
   Y5EpEEJe0VYcZ4zxmd1FPnl/rvAgKW29EH6vOVMhqEEgY0orsbkKf0OeG
   mXRM/REtoVIXsZ0f97y0+B9/3DbOrj59DoaGhsqO3j9XGd/M7Z0sPe67i
   XEXC202qfV8RllM1ZO15Hbd8dYFPH70G94S5MutSayuGK6lUm/2WXeSMe
   xZ75lMtCx6/1dYHRTxnFMfHl6mzjYasWSqb1SeMuEHs8d3r2ttlKQ/LZB
   BSE1IEsjnWyjUI7nSlz4Z7PIOzytvGkp/8L654rA7K1ME/AZ6FXsTicaV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333377279"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="333377279"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 09:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="637340106"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2022 09:24:15 -0700
Received: from [10.252.212.211] (kliang2-MOBL.ccr.corp.intel.com [10.252.212.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 102925807E7;
        Fri, 13 May 2022 09:24:13 -0700 (PDT)
Message-ID: <018aaf83-fb2a-2b74-7fc1-412f90cccb1b@linux.intel.com>
Date:   Fri, 13 May 2022 12:24:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] perf evsel: Fixes topdown events in a weak group for
 the hybrid platform
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
 <20220513151554.1054452-2-kan.liang@linux.intel.com>
 <CAP-5=fUO+ag5_HWeYn+_Q4vMtFGSux7sdEEbWm1xFp_HZKfJ1g@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fUO+ag5_HWeYn+_Q4vMtFGSux7sdEEbWm1xFp_HZKfJ1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2022 11:39 AM, Ian Rogers wrote:
> On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The patch ("perf evlist: Keep topdown counters in weak group") fixes the
>> perf metrics topdown event issue when the topdown events are in a weak
>> group on a non-hybrid platform. However, it doesn't work for the hybrid
>> platform.
>>
>> $./perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
>> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
>> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
>> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
>> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
>> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
>> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>         751,765,068      cpu_core/slots/                                               (84.07%)
>>     <not supported>      cpu_core/topdown-bad-spec/
>>     <not supported>      cpu_core/topdown-be-bound/
>>     <not supported>      cpu_core/topdown-fe-bound/
>>     <not supported>      cpu_core/topdown-retiring/
>>          12,398,197      cpu_core/branch-instructions/                                     (84.07%)
>>           1,054,218      cpu_core/branch-misses/                                       (84.24%)
>>         539,764,637      cpu_core/bus-cycles/                                          (84.64%)
>>              14,683      cpu_core/cache-misses/                                        (84.87%)
>>           7,277,809      cpu_core/cache-references/                                     (77.30%)
>>         222,299,439      cpu_core/cpu-cycles/                                          (77.28%)
>>          63,661,714      cpu_core/instructions/                                        (84.85%)
>>                   0      cpu_core/mem-loads/                                           (77.29%)
>>          12,271,725      cpu_core/mem-stores/                                          (77.30%)
>>         542,241,102      cpu_core/ref-cycles/                                          (84.85%)
>>               8,854      cpu_core/cache-misses/                                        (76.71%)
>>           7,179,013      cpu_core/cache-references/                                     (76.31%)
>>
>>         1.003245250 seconds time elapsed
>>
>> A hybrid platform has a different PMU name for the core PMUs, while
>> the current perf hard code the PMU name "cpu".
>>
>> The evsel->pmu_name can be used to replace the "cpu" to fix the issue.
>> For a hybrid platform, the pmu_name must be non-NULL. Because there are
>> at least two core PMUs. The PMU has to be specified.
>> For a non-hybrid platform, the pmu_name may be NULL. Because there is
>> only one core PMU, "cpu". For a NULL pmu_name, we can safely assume that
>> it is a "cpu" PMU.
>>
>> With the patch,
>>
>> $perf stat -e '{cpu_core/slots/,cpu_core/topdown-bad-spec/,
>> cpu_core/topdown-be-bound/,cpu_core/topdown-fe-bound/,
>> cpu_core/topdown-retiring/,cpu_core/branch-instructions/,
>> cpu_core/branch-misses/,cpu_core/bus-cycles/,cpu_core/cache-misses/,
>> cpu_core/cache-references/,cpu_core/cpu-cycles/,cpu_core/instructions/,
>> cpu_core/mem-loads/,cpu_core/mem-stores/,cpu_core/ref-cycles/,
>> cpu_core/cache-misses/,cpu_core/cache-references/}:W' -a sleep 1
>>
>>   Performance counter stats for 'system wide':
>>
>>         766,620,266      cpu_core/slots/                                               (84.06%)
>>          73,172,129      cpu_core/topdown-bad-spec/ #      9.5% bad speculation         (84.06%)
>>         193,443,341      cpu_core/topdown-be-bound/ #     25.0% backend bound           (84.06%)
>>         403,940,929      cpu_core/topdown-fe-bound/ #     52.3% frontend bound          (84.06%)
>>         102,070,237      cpu_core/topdown-retiring/ #     13.2% retiring                (84.06%)
>>          12,364,429      cpu_core/branch-instructions/                                     (84.03%)
>>           1,080,124      cpu_core/branch-misses/                                       (84.24%)
>>         564,120,383      cpu_core/bus-cycles/                                          (84.65%)
>>              36,979      cpu_core/cache-misses/                                        (84.86%)
>>           7,298,094      cpu_core/cache-references/                                     (77.30%)
>>         227,174,372      cpu_core/cpu-cycles/                                          (77.31%)
>>          63,886,523      cpu_core/instructions/                                        (84.87%)
>>                   0      cpu_core/mem-loads/                                           (77.31%)
>>          12,208,782      cpu_core/mem-stores/                                          (77.31%)
>>         566,409,738      cpu_core/ref-cycles/                                          (84.87%)
>>              23,118      cpu_core/cache-misses/                                        (76.71%)
>>           7,212,602      cpu_core/cache-references/                                     (76.29%)
>>
>>         1.003228667 seconds time elapsed
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   tools/perf/arch/x86/util/evsel.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>> index 00cb4466b4ca..24510bcb4bf4 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -33,8 +33,9 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>>
>>   bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>   {
>> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
>> -           !pmu_have_event("cpu", "slots"))
>> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>> +
>> +       if (!pmu_have_event(pmu_name, "slots"))
> 
> Playing devil's advocate, if I have a PMU for my network accelerator
> and it has an event called "slots" then this test will also be true.
>

IIRC, the pmu_have_event should only check the event which is exposed by 
the kernel. It's very unlikely that another PMU expose the exact same name.

If you still worry about it, I think we can check the PMU type 
PERF_TYPE_RAW here, which is reserved for the core PMU. Others cannot 
use it.

It looks like arch_evsel__must_be_in_group() is the only user for the 
evsel__sys_has_perf_metrics() for now, so I make it static.

The other pmu_have_event("cpu", "slots") is in evlist.c. 
topdown_sys_has_perf_metrics() in patch 4 should be used to replace it.
I think Zhengjun will post patches for the changes for the evlist.c


diff --git a/tools/perf/arch/x86/util/evsel.c 
b/tools/perf/arch/x86/util/evsel.c
index 24510bcb4bf4..a4714174e30f 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -31,11 +31,20 @@ void arch_evsel__fixup_new_cycles(struct 
perf_event_attr *attr)
         free(env.cpuid);
  }

-bool arch_evsel__must_be_in_group(const struct evsel *evsel)
+static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
  {
         const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";

-       if (!pmu_have_event(pmu_name, "slots"))
+       if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
+           pmu_have_event(pmu_name, "slots"))
+               return true;
+
+       return false;
+}
+
+bool arch_evsel__must_be_in_group(const struct evsel *evsel)
+{
+       if (!evsel__sys_has_perf_metrics(evsel))
                 return false;

         return evsel->name &&

Thanks,
Kan

> The property that is being tested here is "does this CPU have topdown
> events" and so allowing any PMU removes the "does this CPU" part of
> the equation. I think ideally we'd have an arch functions something
> like:
> 
> bool arch_pmu__has_intel_topdown_events(void)
> {
>    static bool has_topdown_events = pmu_have_event("cpu", "slots") ||
> pmu_have_event("cpu_core", "slots");
> 
>    return has_topdown_events;
> }
> 
> bool arch_pmu__supports_intel_topdown_events(const char *pmu_name)
> {
>    if (!pmu_name)
>      return false;
>    return arch_pmu__has_intel_topdown_events() && (!strncmp(pmu_name,
> "cpu") || !strncmp(pmu_name, "cpu_core"));
> }
> 
> bool arch_evsel__is_intel_topdown_event(struct evsel *evsel)
> {
>    if (!arch_pmu__supports_intel_topdown_events(evsel->pmu))
>      return false;
> 
>    return strcasestr(evsel->name, "slots") || strcasestr(evsel->name, "topdown");
> }
> 
> This then gives us:
> 
> bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> {
>    return  arch_evsel__is_intel_topdown_event(evsel);
> }
> 
> These functions can then be reused for the arch_evlist topdown code,
> etc. What I don't see in these functions is use of any hybrid
> abstraction and so it isn't clear to me how with hybrid something like
> this would be plumbed in.
> 
> Thanks,
> Ian
> 
>>                  return false;
>>
>>          return evsel->name &&
>> --
>> 2.35.1
>>
