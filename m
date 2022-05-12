Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BBD524A64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352684AbiELKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352710AbiELKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:35:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF7922A2EE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652351694; x=1683887694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kK9ZVD5xj6dJfDkUG4/8cgmGAaXwH6xJEMXMyFPoP/w=;
  b=MmVSNpYAMIRZkCL0x8K+WvDW3yf6bpverSQdE0qJQrKuHG7uYm8CO+Lr
   +0KgjB31iLtg4xATBh/4RzMjvtAnDCjwYh7DyPKdqTe2etIsCS/s6Mh9Y
   9KbGa0X0mvQuLhNVAWsoermtXnhGFT+uMy7jZUAHs+16Ce5GYhR+YYhJy
   Rv78f3ucjIKRhMm1TKKbRvY3GyOmRGPYA9ILAVOi49vtiTccxbT7zYd+n
   NxPVIqarBx3AWrKpUXCBjADYXwfpzr+OzgynkyW/tzL6Mku1u4TCYj5LZ
   U/7FKc45onzD+2kz+cM9bhm1WTpG/JcXGoASGfQ1WOzYR2eV2AOpiLR/Q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356385885"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="356385885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 03:34:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594606666"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.215])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 03:34:51 -0700
Message-ID: <52f201d4-4fab-c2f4-9c4d-af887900732f@intel.com>
Date:   Thu, 12 May 2022 13:34:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V2 22/23] perf tools: Allow system-wide events to keep
 their own CPUs
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-23-adrian.hunter@intel.com>
 <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cg8JRK2oVUvmWit=F5zhLhpqP=gD6iYBAa8_O-+c=EjPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 08:27, Namhyung Kim wrote:
> On Fri, May 6, 2022 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Currently, user_requested_cpus supplants system-wide CPUs when the evlist
>> has_user_cpus. Change that so that system-wide events retain their own
>> CPUs and they are added to all_cpus.
>>
>> Acked-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/lib/perf/evlist.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>> index 1c801f8da44f..9a6801b53274 100644
>> --- a/tools/lib/perf/evlist.c
>> +++ b/tools/lib/perf/evlist.c
>> @@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>          * We already have cpus for evsel (via PMU sysfs) so
>>          * keep it, if there's no target cpu list defined.
>>          */
>> -       if (!evsel->own_cpus || evlist->has_user_cpus) {
>> -               perf_cpu_map__put(evsel->cpus);
>> -               evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>> -       } else if (!evsel->system_wide &&
>> -                  !evsel->requires_cpu &&
>> -                  perf_cpu_map__empty(evlist->user_requested_cpus)) {
>> +       if (!evsel->own_cpus ||
>> +           (!evsel->system_wide && evlist->has_user_cpus) ||
>> +           (!evsel->system_wide &&
>> +            !evsel->requires_cpu &&
>> +            perf_cpu_map__empty(evlist->user_requested_cpus))) {
> 
> This is getting hard to understand.  IIUC this propagation basically
> sets user requested cpus to evsel unless it has its own cpus, right?

I put the conditional logic altogether because that is kernel style but
it does make it practically unreadable.

If we start with the original logic:

	if (!evsel->own_cpus || evlist->has_user_cpus) {
		perf_cpu_map__put(evsel->cpus);
		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
	} else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
		perf_cpu_map__put(evsel->cpus);
		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
	} else if (evsel->cpus != evsel->own_cpus) {
		perf_cpu_map__put(evsel->cpus);
		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
	}

Then make it more readable, i.e. same functionality

	struct perf_cpu_map *cpus;

	if (!evsel->own_cpus || evlist->has_user_cpus)
		cpus = evlist->user_requested_cpus;
	else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus))
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

	if (evsel->cpus != cpus) {
		perf_cpu_map__put(evsel->cpus);
		evsel->cpus = perf_cpu_map__get(cpus);
	}

Then separate out the conditions, i.e. still same functionality

	if (!evsel->own_cpus)
		cpus = evlist->user_requested_cpus;
	else if (evlist->has_user_cpus)
		cpus = evlist->user_requested_cpus;
	else if (evsel->system_wide)
		cpus = evsel->own_cpus;
	else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

Then add the new requires_cpu flag:

	if (!evsel->own_cpus)
		cpus = evlist->user_requested_cpus;
	else if (evlist->has_user_cpus)
		cpus = evlist->user_requested_cpus;
	else if (evsel->system_wide)
		cpus = evsel->own_cpus;
-	else if (perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
+	else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

Then make system_wide keep own_cpus even if has_user_cpus:

	if (!evsel->own_cpus)
		cpus = evlist->user_requested_cpus;
+	else if (evsel->system_wide)
+		cpus = evsel->own_cpus;
	else if (evlist->has_user_cpus)
		cpus = evlist->user_requested_cpus;
-	else if (evsel->system_wide)
-		cpus = evsel->own_cpus;
	else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

Which leaves:

	if (!evsel->own_cpus)
		cpus = evlist->user_requested_cpus;
	else if (evsel->system_wide)
		cpus = evsel->own_cpus;
	else if (evlist->has_user_cpus)
		cpus = evlist->user_requested_cpus;
	else if (!evsel->requres_cpu && perf_cpu_map__empty(evlist->user_requested_cpus)) /* per-thread */
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

And putting it back together:

	if (!evsel->own_cpus ||
	    (!evsel->system_wide && evlist->has_user_cpus) ||
	    (!evsel->system_wide &&
	     !evsel->requires_cpu &&
	     perf_cpu_map__empty(evlist->user_requested_cpus))) {
		cpus = evlist->user_requested_cpus;
	else
		cpus = evsel->own_cpus;

Perhaps I shouldn't put it together?

> 
> But the hybrid pmus make this complex.  Maybe we can move the
> logic in evlist__fix_hybrid_cpus() here and simplify it like below
> 
> if (evsel->own_cpus) {
>    if (evsel->pmu->is_hybrid)
>       evsel->cpus = fixup_hybrid_cpus(evsel>own_cpus,
>                                       evlist->user_requested_cpus);  //?
>    else
>       evsel->cpus = evlist->own_cpus;  // put + get
> } else {
>    evsel->cpus = evlist->user_requested_cpus;  // put + get
> }
> 
> Then we need to make sure evsel->pmu is set properly.
> 
> What do you think?

Hybrid handling looks complicated.  I would have to spend time
better understanding it.

So, in the context of this patch set, I don't want to look at
issues with hybrid CPUs, except that there should be no change
to how they are handled.

> 
> Thanks,
> Namhyung
> 
> 
>>                 perf_cpu_map__put(evsel->cpus);
>>                 evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
>>         } else if (evsel->cpus != evsel->own_cpus) {
>> --
>> 2.25.1
>>

