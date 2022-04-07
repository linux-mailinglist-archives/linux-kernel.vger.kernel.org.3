Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EB4F7F29
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiDGMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiDGMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:37:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD81193225;
        Thu,  7 Apr 2022 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649334906; x=1680870906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WRMFH2QsUAPJeUEDXnzJd2uSJbpbZ86SEGUkely7mPQ=;
  b=mBR2yYYaMb/JqmpTOjRMDhgBeiCZ9wHY+qKvO3uy/uAPjqEdIrpDWnyu
   VMKnFWSy/DBzlqE1n9LPsZxEq4w9JDG5n/S/HV18GzqqvvU6VAxoyQibz
   P1Yv/oFKV40MWxiO1AQva+GfbX08cScmAtxtT7VZ8skAS5zy0p8iss8zu
   PBYYjjDrz5OHJPrZjWw1t5SWqJX2fH5rvxPObCDk9eHv7Vdef22c06H2G
   xtxCCNt4udXSZ3X4kphxRa04WLou+MB6B8sQexnxsdjfn5q9Mvsf4qj4w
   eGq172zW+oknGQy0/2DEH/LFd0ql+Fj/Inen3zioDrffY4qRWoKahc3tG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10309"; a="243443856"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="243443856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="571033517"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.40.48])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 05:35:02 -0700
Message-ID: <676075ca-4d5d-7388-61ac-42a0b9f1ed50@intel.com>
Date:   Thu, 7 Apr 2022 15:34:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2] perf test tsc: Fix error message report when not
 supported.
Content-Language: en-US
To:     Bryton Lee <brytonlee01@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, ak@linux.intel.com,
        likexu@tencent.com, chengdongli@tencent.com
References: <20220406100609.65239-1-chengdongli@tencent.com>
 <ce2c3c4f-3751-312a-5fa6-0f98330067fe@intel.com>
 <CAC2pzGe0Kn9Vzyx7S5_5A338shYG-DXgY=CS38zpJYk3m3_N7A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAC2pzGe0Kn9Vzyx7S5_5A338shYG-DXgY=CS38zpJYk3m3_N7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 14.34, Bryton Lee wrote:
> On Thu, Apr 7, 2022 at 2:59 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 06/04/2022 13.06, Chengdong Li wrote:
>>> By default `perf test tsc` does not return the error message
>>> when child process detected kernel does not support. Instead, child
>>> process print error message to stderr, unfortunately the stderr is
>>> redirected to /dev/null when verbose <= 0.
>>>
>>> This patch did three things:
>>> - returns TEST_SKIP to parent process instead of TEST_OK when
>>>   perf_read_tsc_conversion() is not supported.
>>> - add a new subtest of testing if TSC is supported on current
>>>   architecture by moving exist code to a separate function.
>>> - extended test suite definition to contain above two subtests.
>>>
>>> Changes since v1 (thanks for the feedback from Adrian Hunter):
>>> - rebase commit to current source.
>>>
>>> Signed-off-by: Chengdong Li <chengdongli@tencent.com>
>>> ---
>>>  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
>>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
>>> index d12d0ad81801..fc7c380af5a0 100644
>>> --- a/tools/perf/tests/perf-time-to-tsc.c
>>> +++ b/tools/perf/tests/perf-time-to-tsc.c
>>> @@ -47,6 +47,17 @@
>>>       }                                       \
>>>  }
>>>
>>> +static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
>>> +                               int subtest __maybe_unused)
>>> +{
>>> +     if (!TSC_IS_SUPPORTED) {
>>> +             pr_debug("Test not supported on this architecture");
>>
>> Message better ending with "\n" I think
> OK, I will fix it.
>>
>>> +             return TEST_SKIP;
>>> +     }
>>> +
>>> +     return TEST_OK;
>>> +}
>>> +
>>>  /**
>>>   * test__perf_time_to_tsc - test converting perf time to TSC.
>>>   *
>>> @@ -70,7 +81,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>>>       struct perf_cpu_map *cpus = NULL;
>>>       struct evlist *evlist = NULL;
>>>       struct evsel *evsel = NULL;
>>> -     int err = -1, ret, i;
>>> +     int err = TEST_FAIL, ret, i;
>>>       const char *comm1, *comm2;
>>>       struct perf_tsc_conversion tc;
>>>       struct perf_event_mmap_page *pc;
>>> @@ -79,10 +90,6 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>>>       u64 test_time, comm1_time = 0, comm2_time = 0;
>>>       struct mmap *md;
>>>
>>> -     if (!TSC_IS_SUPPORTED) {
>>> -             pr_debug("Test not supported on this architecture");
>>> -             return TEST_SKIP;
>>> -     }
>>>
>>>       threads = thread_map__new(-1, getpid(), UINT_MAX);
>>>       CHECK_NOT_NULL__(threads);
>>> @@ -124,8 +131,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>>>       ret = perf_read_tsc_conversion(pc, &tc);
>>>       if (ret) {
>>>               if (ret == -EOPNOTSUPP) {
>>> -                     fprintf(stderr, " (not supported)");
>>> -                     return 0;
>>> +                     pr_debug("perf_read_tsc_conversion is not supported in current kernel");
>>> +                     err = TEST_SKIP;
>>>               }
>>>               goto out_err;
>>>       }
>>> @@ -191,7 +198,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>>>           test_tsc >= comm2_tsc)
>>>               goto out_err;
>>>
>>> -     err = 0;
>>> +     err = TEST_OK;
>>>
>>>  out_err:
>>>       evlist__delete(evlist);
>>> @@ -200,4 +207,15 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>>>       return err;
>>>  }
>>>
>>> -DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
>>> +static struct test_case time_to_tsc_tests[] = {
>>> +     TEST_CASE_REASON("TSC support", tsc_is_supported,
>>> +                      "This architecture does not support"),
>>
>> The 2nd test case runs anyway, so I am not sure another
>> test case is needed?
> 
> Yes. But, I think there are two reasons to add two subtests: 1).
> Original TSC support test is embedded in test__perf_time_to_tsc(), and
> returns TEST_SKIP
> if current architecture doesn't support it.  Thus there are two places
> that return TEST_SKIP in test__perf_time_to_tsc() if we don't move TSC
> support
> to another subtest. 2). Current test_suite and test_case structs don't
> support printing skip_reason if there is no subtest. To print skip
> reason we need more than 1 subtests.

Ok, can that explanation be added to the commit message

> 
>>
>>> +     TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
>>> +                      "perf_read_tsc_conversion is not supported"),
>>> +     { .name = NULL, }
>>> +};
>>> +
>>> +struct test_suite suite__perf_time_to_tsc = {
>>> +     .desc = "Convert perf time to TSC",
>>> +     .test_cases = time_to_tsc_tests,
>>> +};
>>

