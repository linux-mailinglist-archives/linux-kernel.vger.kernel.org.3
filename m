Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040B512A95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiD1Ecj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiD1Ech (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:32:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E825B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651120164; x=1682656164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RGMadu+1Xkb2tt1NiDlTW3bS0dGKre4RRVHQdcuUPEU=;
  b=gUwAAnAq3mWYmzY1bLN6/6DZ8WRaTDJ1TwuPZZyl6i5B4SPOJVHm155F
   GOg04RKDHeXOekZ24gz2n7KeGYuyZcljsHYcpCSdi5PAh4REe9g46VAQk
   z2PHsgixUMzlD2nOi1aavfmcZlgPy5eniZ+IQ4vpZRQ7j83FlmrA0fgYO
   0cMDUx8Acmaf0gfYbVh9GqpBngGyIC7YtvSOIQelwm2I2MP6Iv36LsXsE
   KJk8YroR2iNJ/Es1QD9SBIe5NTzibKGjeat0Bq+6wn1BL962ZSc4tP8/s
   T7jVsTPZ8Wpstzmdb4jhlqk/z3zbe8PaG1ieJNtSipZm/PKOT7GB192jE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="266315700"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="266315700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:29:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="581029867"
Received: from arayamur-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.153])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:29:22 -0700
Message-ID: <876a4ae9-3081-8f11-1ee7-470030edb2a1@intel.com>
Date:   Thu, 28 Apr 2022 07:29:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 05/21] perf auxtrace: Do not mix up mmap idx
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-6-adrian.hunter@intel.com>
 <CAM9d7cg8Awh9oXdCL4-GQT_R5FpgTz6DYFCfd=9g1YFQ463xSQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cg8Awh9oXdCL4-GQT_R5FpgTz6DYFCfd=9g1YFQ463xSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/22 00:54, Namhyung Kim wrote:
> On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> The idx is with respect to evlist not evsel. That hasn't mattered because
>> they are the same at present. Prepare for that not being the case, which it
>> won't be when sideband tracking events are allowed on all CPUs even when
>> auxtrace is limited to selected CPUs.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/auxtrace.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 10936a38031f..2d015b0be549 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -640,8 +640,14 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>>  {
>>         bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
>>
>> -       if (per_cpu_mmaps)
>> -               return perf_evsel__enable_cpu(&evsel->core, idx);
>> +       if (per_cpu_mmaps) {
>> +               struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
>> +               int cpu = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
> 
> While it can be thought of as an index from the function name,
> it'd be nice if we could be explicit like cpu_map_idx.

Ok

> 
> Thanks,
> Namhyung
> 
>> +
>> +               if (cpu == -1)
>> +                       return -EINVAL;
>> +               return perf_evsel__enable_cpu(&evsel->core, cpu);
>> +       }
>>
>>         return perf_evsel__enable_thread(&evsel->core, idx);
>>  }
>> --
>> 2.25.1
>>

