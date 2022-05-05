Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1651C966
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352237AbiEETry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiEETrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:47:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309351591;
        Thu,  5 May 2022 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651779841; x=1683315841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1tZDI2BmnNsfncpfUFvMhYgdDZVYfF1pMiersQPZT2c=;
  b=EMyYHBB7EI4oOw79unV/wDMtUTxtBq0MbpF9kkjJen/LDT8yK7+qCSnC
   yxsDvwSXLgRomIAyKuyuPj9tFZspgT1eb7ymJQ5IRrdBniPFdgEpqRBcw
   J/P1+jw/9qb1gWx2ML2bYnBHz5li9rkIHmXSFpAJzTJn21hjc8PsWgEVG
   gn8UWgIvUZt/tfBc2I4D3vyQEWCgZR7KMSr2Q7DWK39VmTCCyv6uvLz/D
   EEs1yVvtiFwLd0/PbF4V6rLWoLWeSbMR9I4sbJ/eJTtv4JQbX1UI2oUGL
   NBu5yXpRwEkwWLJINLc9CbWUUFBYmsfp4QOqS3IFjVOiysn+ndEtaUM+i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="265825419"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="265825419"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 12:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537502503"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 05 May 2022 12:44:00 -0700
Received: from [10.252.209.228] (kliang2-MOBL.ccr.corp.intel.com [10.252.209.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D2B7D5806C8;
        Thu,  5 May 2022 12:43:57 -0700 (PDT)
Message-ID: <83417b72-4872-072a-2328-a88d2bb90858@linux.intel.com>
Date:   Thu, 5 May 2022 15:43:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20220505043846.3165303-1-irogers@google.com>
 <87b89e2c-da5c-52c3-40dc-448e874cb5d8@linux.intel.com>
 <CAP-5=fVHhWu1uJHnTfFYWvM02_F-bFBZaaOYo8zPRiA=ODRxGQ@mail.gmail.com>
 <12c03e85-cb48-d264-5f04-e9bf9faaf739@linux.intel.com>
 <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW9Cp3ShO=tTQddDWXz+nrSip99HrNW7Wv5_Qsy1UT7bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2022 2:31 PM, Ian Rogers wrote:
>>> So I think fixing all of these should be a follow up. I am working to
>>> get access to an Alderlake system, could we land this first?
>>>
>> I think we can use pmu_name to replace the "cpu" to fix the issue for
>> the hybrid platform. For a hybrid platform, the pmu_name is either
>> cpu_atom or cpu_core.
>>
>> Besides, the topdown events may have a PMU prefix, e.g.,
>> cpu_core/topdown-be-bound/. The strcasecmp may not work well for this case.
>>
>> How about the below patch?
>> If it's OK for you, could you please merge it into your V2 patch set?
>> I can do the test on a ADL system.
>>
>> diff --git a/tools/perf/arch/x86/util/evsel.c
>> b/tools/perf/arch/x86/util/evsel.c
>> index 40b171de2086..551ae2bab70e 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -33,11 +33,12 @@ void arch_evsel__fixup_new_cycles(struct
>> perf_event_attr *attr)
>>
>>    bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>    {
>> -       if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
>> -           !pmu_have_event("cpu", "slots"))
>> +       const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
>> +
>> +       if (!pmu_have_event(pmu_name, "slots"))
>>                  return false;
> Hmm. The idea with this test is to see if the architecture supports
> topdown events before going further. There's a similar test in all the
> arch_evlist functions. I think with cpu_core this needs to become:
>

The case is a little bit different here. For the arch_evlist functions, 
the input is the evlist, not the specific evsel. So we have to check all 
the possible PMU names which are "cpu" and "cpu_core". Then we decide 
whether going further.

The input of the evsel__must_be_in_group() is the evsel. The PMU name is 
stored in the evsel->pmu_name. I don't think we need to check all the 
possible PMU names. Using evsel->pmu_name should be good enough.

> if (!pmu_have_event("cpu", "slots") && !pmu_have_event("cpu_core", "slots") )
> 
> But we should add a helper function for this. It is odd to have this
> change supporting Alderlake but the existing evlist work not. Perhaps
> we should just wait until Zhengjun's patches land.

Yes, a helper function is good for the arch_evlist functions. But I 
don't think this patch needs the helper function. Zhengjun's patches are 
to fix the other topdown issues on ADL. There is no dependency between 
this patch and zhengjun's patches.

Thanks,
Kan
