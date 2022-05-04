Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A151A00E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiEDM6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiEDM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:58:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404A366AE;
        Wed,  4 May 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651668874; x=1683204874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bQ57GLyAXmlEPnkviPyQ4B4ZK2mKn3I6U9V+wT1S18I=;
  b=h4P3ZnVYROlQqldqLLmiWgyL83UAE1dhV9fl4IssSqeCGRWuoBX0vviU
   symRqfYE1dRz8VOFi5c6/fpNQviQ9ZVhVjh2vm9/kXz5F3NLEvGnXe/zv
   pD3HZY8S9tbbuBP6/Ze7oGBQT/yaFkwyN0qUL6QZtEJYliEhQDS8J0RM6
   GFRLFsJIOd5yIlhAcBm9Au4h4d9KkvTH/YyQyWJCqdQno7OeCzOFSWo4k
   FojcdtkS44xzR3kJedlqIzaAAJaCYzpJzl9hOxaprqr9wYgWa9Oaq7OG2
   jK41VSdTbgxZusJTfZpVOYkrblvI4g5/P+BpiI8ZmPznvI1ulgmCARVtc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="354193849"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="354193849"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:54:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="584721396"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 05:54:22 -0700
Message-ID: <1e13c738-3460-ef7f-8b4b-5169e16b0b06@intel.com>
Date:   Wed, 4 May 2022 15:54:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20220503041757.2365696-1-irogers@google.com>
 <20220503041757.2365696-5-irogers@google.com>
 <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
 <CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/05/22 17:03, Ian Rogers wrote:
> On Tue, May 3, 2022 at 12:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 3/05/22 07:17, Ian Rogers wrote:
>>> perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
>>> respect that.
>>
>> As I wrote before, I am not keen on this because it prevents -1, as a
>> valid 3rd parameter to perf_event_open(), from being represented
>> in merged evsel cpu maps.
>>
>> Why do you want this?
> 
> Thanks Adrian, could you give me a test case (command line) where the
> differing dummy and empty behavior matters?

perf record --per-thread -e intel_pt// uname

With patchset "perf intel-pt: Better support for perf record --cpu"
the above will have (assuming 8-CPUs):
	user_requested_cpus = {-1}
	intel_pt evsel->cpus = {-1}
	text_poke dummy evsel->cpus = {0-7}
which when merged would result in:
	before this patch: all_cpus = {-1-7}
	after this patch:  all_cpus = {0-7}

The absence of -1 will mean that the intel_pt event does not get
mmapped.

>                                             Normally cpus/own_cpus are
> set to null during parsing. They may get replaced with
> user_requested_cpus:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n44
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n45
> (should it be on line 45 that !empty is expected?)
> 
> During merge the null/empty all_cpus drops this value, which doesn't
> matter as the behavior with empty is the same as dummy:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evsel.c?h=perf/core#n119
> 
> What's concerning me is the definition of empty:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
> ```
> return map ? map->map[0].cpu == -1 : true;
> ```
> If the first entry can be -1 and there can be other CPUs merged after
> then that cpu map will be empty by the definition above. Perhaps it
> should be:
> ```
> return map ? (map->nr == 1 && map->map[0].cpu == -1) : true;
> ```
> but it seems you prefer:
> ```
> return (map == NULL) ? true : false;
> ```
> 
> You'd asked what the behavior with a dummy is and clearly it is
> somewhat muddy. That is what this patch and unit test is trying to
> clean up.
> 
> Thanks,
> Ian
> 
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/lib/perf/cpumap.c   |  4 ++--
>>>  tools/perf/tests/cpumap.c | 10 +++++++++-
>>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
>>> index 384d5e076ee4..9c83675788c2 100644
>>> --- a/tools/lib/perf/cpumap.c
>>> +++ b/tools/lib/perf/cpumap.c
>>> @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
>>>  /** Is 'b' a subset of 'a'. */
>>>  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
>>>  {
>>> -     if (a == b || !b)
>>> +     if (a == b || perf_cpu_map__empty(b))
>>>               return true;
>>> -     if (!a || b->nr > a->nr)
>>> +     if (perf_cpu_map__empty(a) || b->nr > a->nr)
>>>               return false;
>>>
>>>       for (int i = 0, j = 0; i < a->nr; i++) {
>>> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
>>> index f94929ebb54b..d52b58395385 100644
>>> --- a/tools/perf/tests/cpumap.c
>>> +++ b/tools/perf/tests/cpumap.c
>>> @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
>>>       struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
>>>       struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
>>>       struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
>>> +     struct perf_cpu_map *d = perf_cpu_map__dummy_new();
>>> +     struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
>>>       char buf[100];
>>>
>>>       TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
>>>       cpu_map__snprint(c, buf, sizeof(buf));
>>>       TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
>>> -     perf_cpu_map__put(b);
>>> +
>>> +     TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
>>> +     cpu_map__snprint(e, buf, sizeof(buf));
>>> +     TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
>>> +
>>>       perf_cpu_map__put(c);
>>> +     perf_cpu_map__put(d);
>>> +     perf_cpu_map__put(e);
>>>       return 0;
>>>  }
>>>
>>

