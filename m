Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6808051D223
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389489AbiEFHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbiEFHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:22:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C722E080
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651821552; x=1683357552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q5d9HH/sQp+F8Knzv+tCoRI8RdzEpU46UiEcz+bJbD8=;
  b=CRjWT6z8ZjvOyQNKDSrS2X7/bv8nNwKddU4cRSIqEuDwvBeqEWvJTWVB
   JlLNvQhbboDJ0cN1eBGeTWd4PScecROcu9fgAbbLCtzbqrl+ga73br8Bx
   pJwFMxuPqAaKU2SHgwNzG1yk3aAv1UkpzR2ZjJ52zucmOAMbB4KlcR5jr
   GJBcWn1EKLL/bXQq9iCndm9zuyhvLXmfOWu6RXzyoswKRs6BOJ0bgYsRR
   Nh6lzLwHT+ZOHSX/7jH/z8TWVIs9JETOLC/jfstNEl8I2f9Gm+AuvaTOe
   U6vy99GTfKh0XBh/IqrKzENA24sG9dHl851caVioh+90qa0Y0HbN8Z4F5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267980838"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267980838"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:19:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="563681480"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.62.152])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 00:18:59 -0700
Message-ID: <a771766d-4303-4abb-48dc-4ed4f4a4c70f@intel.com>
Date:   Fri, 6 May 2022 10:18:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V1 02/23] libperf evsel: Add perf_evsel__enable_thread()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
References: <20220505165639.361733-1-adrian.hunter@intel.com>
 <20220505165639.361733-3-adrian.hunter@intel.com>
 <CAP-5=fWyYQbgs99-wm7frfaHQXUFO6b-Lur=BEy48beEsYnehQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWyYQbgs99-wm7frfaHQXUFO6b-Lur=BEy48beEsYnehQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/05/22 01:48, Ian Rogers wrote:
> On Thu, May 5, 2022 at 9:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add perf_evsel__enable_thread() as a counterpart to
>> perf_evsel__enable_cpu(), to enable all events for a thread.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/lib/perf/evsel.c              | 10 ++++++++++
>>  tools/lib/perf/include/perf/evsel.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
>> index 20ae9f5f8b30..dcc928dd25f8 100644
>> --- a/tools/lib/perf/evsel.c
>> +++ b/tools/lib/perf/evsel.c
>> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>>  }
>>
>> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
>> +{
>> +       int err = 0;
>> +       int idx;
>> +
>> +       for (idx = 0; idx < xyarray__max_x(evsel->fd) && !err; idx++)
>> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
> 
> For perf_cpu_map code like this has been replaced with
> perf_cpu_map__for_each_cpu, it would be nice here to use a
> perf_thread_map__for_each_thread. I understand we don't have that at
> the moment. It would be easier to find places to add this if there is
> a call to perf_thread_map__nr. Adding an assert of:
> 
> assert(perf_thread_map__nr(evsel->thread_map) == xyarray__max_x(evsel->fd));

Threads go in the y direction.

I'll change it to use perf_cpu_map__for_each_cpu

> 
> Would help, or we could add the loop.
> 
> Thanks,
> Ian
> 
>> +       return err;
>> +}
>> +
>>  int perf_evsel__enable(struct perf_evsel *evsel)
>>  {
>>         int i;
>> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
>> index 2a9516b42d15..699c0ed97d34 100644
>> --- a/tools/lib/perf/include/perf/evsel.h
>> +++ b/tools/lib/perf/include/perf/evsel.h
>> @@ -36,6 +36,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int
>>                                  struct perf_counts_values *count);
>>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
>>  LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>> +LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
>>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>> --
>> 2.25.1
>>

