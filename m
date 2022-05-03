Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30BD517CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiECEzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiECEzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:55:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3233EAB0;
        Mon,  2 May 2022 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651553521; x=1683089521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JhLlnE22AX4SPpYs1fnyNeGyJkKqqNt7Ru8jbYm+1kc=;
  b=ImZpeyAqq7llDYnWC+eG44dgFgfbgNzDJoUgapCDUKzdyv6VO5Uwwk3X
   D2enElZc8CBCJDhtRXQoSb6mGiszeJbFvGSuwnA8JVJk2S7e0JfuTLZut
   5OeWtnn39O9E8nFAsj6br/G7qM+qtbW+CCmcSsLkXKxNP2W5kY3xJNm1y
   VBOUlBJ7N/wMp2SftLTDzLk2hpVdXZiiuNOiSq4Pg2EAeg9ItiG4AaRi6
   ZZdWsZn7C5cv3u3XXEuhOp+GqbSb6y0mi5UUIOjyELhGYaJ7wNWE8QhMk
   grZI3hh6hrp3gv1QPoFJPLNqd0IGbeuMxTYqDBeXMay0X+WBsZspN19r7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267274436"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267274436"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 21:52:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="584043550"
Received: from albertmo-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 21:51:53 -0700
Message-ID: <5e8cd38c-1384-ed7e-3f92-f7e5f7c1578b@intel.com>
Date:   Tue, 3 May 2022 07:51:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v4 4/6] perf cpumap: Handle dummy maps as empty in subset
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
References: <20220430062324.1565215-1-irogers@google.com>
 <20220430062324.1565215-5-irogers@google.com>
 <b0551170-f559-4801-1cb4-3653b9685474@intel.com>
 <CAP-5=fWwDEW=Vhw1B9i3JN9wr1FJ_+dfaWXjJ7vXeKWfZNaz0g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWwDEW=Vhw1B9i3JN9wr1FJ_+dfaWXjJ7vXeKWfZNaz0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/05/22 20:04, Ian Rogers wrote:
> On Mon, May 2, 2022 at 9:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 30/04/22 09:23, Ian Rogers wrote:
>>> perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
>>> respect that.
>>
>> I think this might be the opposite of what I am trying to do, which is
>> enable all_cpus to represent all the "cpu" values (3rd parameter of
>> perf_event_open()) to iterate over including -1 so that per-thread and
>> per-cpu events can be mixed.
> 
> Wouldn't you iterate over the cpus of the evsel?

When mmapping perf events, it is necessary to iterate all (user_requested)
cpus / threads in order to conveniently set-output events on the same
cpu / thread.

>                                                  I'm not sure using
> all_cpus in that way makes sense

It does if you want to mix per-cpu and per-thread (cpu == -1) events.
As I wrote previously, the cpus is then seen as a list of values for
parameter 3 of perf_event_open(), and therefore includes -1.

>                                   it also violates the definition of
> empty.

That can be renamed, since it is typically being used to mean
per-thread (i.e. per-task context)

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

