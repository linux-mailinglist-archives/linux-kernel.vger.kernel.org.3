Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA705AFB87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIGFFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiIGFFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:05:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540BA7C1FB;
        Tue,  6 Sep 2022 22:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662527135; x=1694063135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3hKO8goXwPPBPFjOJolVzOo3e+yHPR0/w089nXehW1I=;
  b=I0+tJ5eH0fHbcnrVEk4XkXfsu9ZIKm3I58yG/glLDcLygbPErXRkPjAe
   /QlQdsLkbHzqDz/QhamHV4GU4yx9wxp5UaMBbLS/J2B9R5NbcnZNLBIbN
   WRJL7d9CIHJYh9JEweEUzOuZQVl4vO9dUpaYxBSz6/JL+/rF1WVMs5XPW
   Bq7x0DfXoWKebnu8D3IbekbYDjhj4M9PHP2UtVMNeQdfVsFwG4goKkSFg
   J2oo5bjGk1UzBpqzlUghKjYgulHQM9BAeRDoovdRZd6uXanLoYFP/NwDE
   CmIANsu7D+oRHS/C10hBdOXKY2IgEB/j6D/mhxAJW4q5MjBtYmFKtt/pX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="383076154"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="383076154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:05:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="676011657"
Received: from alinassi-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:05:31 -0700
Message-ID: <4763358a-91fa-3607-dd54-749b40f977fc@intel.com>
Date:   Wed, 7 Sep 2022 08:05:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
 <YxdEQkmkZjBC6wGb@krava> <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com>
 <YxejRK2/LO7QouOZ@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YxejRK2/LO7QouOZ@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/09/22 22:45, Jiri Olsa wrote:
> On Tue, Sep 06, 2022 at 05:04:45PM +0300, Adrian Hunter wrote:
>> On 6/09/22 15:59, Jiri Olsa wrote:
>>> On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:
>>>
>>> SNIP
>>>
>>>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>>>> index e6c98a6e3908..6b1bafe267a4 100644
>>>> --- a/tools/lib/perf/evlist.c
>>>> +++ b/tools/lib/perf/evlist.c
>>>> @@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>>>>  			if (ops->idx)
>>>>  				ops->idx(evlist, evsel, mp, idx);
>>>>  
>>>> +			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
>>>>  			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
>>>>  				return -1;
>>>>  
>>>> @@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>>>>  			if (!idx)
>>>>  				perf_evlist__set_mmap_first(evlist, map, overwrite);
>>>>  		} else {
>>>> +			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
>>>>  			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
>>>>  				return -1;
>>>>  
>>>> @@ -519,6 +521,48 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int
>>>> +mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>>>> +		struct perf_mmap_param *mp)
>>>> +{
>>>> +	int nr_threads = perf_thread_map__nr(evlist->threads);
>>>> +	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
>>>> +	int cpu, thread, idx = 0;
>>>> +	int nr_mmaps = 0;
>>>> +
>>>> +	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n",
>>>> +		 __func__, nr_cpus, nr_threads);
>>>
>>> -1 as cpu value is only for 'empty' perf_cpu_map, right?
>>
>> The cpu map is a map of valid 3rd arguments to perf_event_open, so -1
>> means all CPUs which is per-thread by necessity.
>>
>>>
>>>> +
>>>> +	/* per-thread mmaps */
>>>> +	for (thread = 0; thread < nr_threads; thread++, idx++) {
>>>> +		int output = -1;
>>>> +		int output_overwrite = -1;
>>>> +
>>>> +		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
>>>> +				   &output_overwrite, &nr_mmaps))
>>>> +			goto out_unmap;
>>>> +	}
>>>> +
>>>> +	/* system-wide mmaps i.e. per-cpu */
>>>> +	for (cpu = 1; cpu < nr_cpus; cpu++, idx++) {
>>>> +		int output = -1;
>>>> +		int output_overwrite = -1;
>>>> +
>>>> +		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
>>>> +				   &output_overwrite, &nr_mmaps))
>>>> +			goto out_unmap;
>>>> +	}
>>>
>>> will this loop be executed? we are in here because all_cpus is empty, right?
>>
>> Yes it is executed.  I put back the code that was there before ae4f8ae16a07
>> ("libperf evlist: Allow mixing per-thread and per-cpu mmaps"), which uses
> 
> hm, but commit ae4f8ae16a07 does not have similar cpu loop

It was calling mmap_per_cpu() for that case.

The 2 cases: mmap_per_cpu() and mmap_per_thread() could still be
combined into a single function.

> 
>> perf_cpu_map__empty() which only checks the first entry is -1:
>>
>> bool perf_cpu_map__empty(const struct perf_cpu_map *map)
>> {
>> 	return map ? map->map[0].cpu == -1 : true;
>> }
>>
>> But there can be more CPUs in the map, so perf_cpu_map__empty()
>> returns true for the per-thread case, as desired, even if there
>> are also system-wide CPUs.
> 
> I don't see how, if I'd see -1 together with other cpu values in
> perf_cpu_map I'd think it's a bug, but I might be missing some
> auxtrace usage,

Yes, it is for system-wide collection of events that can affect
every CPU.  Currently text_poke is always system-wide - see the
Intel PT example.

> 
> I thought we use -1 just for empty cpu map, so in per-thread case
> -1 is properly passed to perf_event_open syscall

Yes, but it does not need to be limited to that case.

> 
> jirka
> 
>>
>> I guess perf_cpu_map__empty() needs renaming.
>>
>>>
>>> thanks,
>>> jirka
>>>
>>>> +
>>>> +	if (nr_mmaps != evlist->nr_mmaps)
>>>> +		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +out_unmap:
>>>> +	perf_evlist__munmap(evlist);
>>>> +	return -1;
>>>> +}
>>>
>>> SNIP
>>

