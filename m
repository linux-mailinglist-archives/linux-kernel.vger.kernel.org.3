Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE1512A58
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbiD1ESn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiD1ESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:18:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286632717D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651119324; x=1682655324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O+bvz73Thr3BRGWFwnbhdAGr49gk4ZUaKCJ1+bb0VfU=;
  b=IYbkfQAU8mb89UYqNVOVDS3GgHkEmR03tnBpD9/XvQG9xzsJX4FqokK0
   IlxwQPPAU2s6WF/71xScRKooYD6QsvNegpLbZ7nOuM2hUs8/bq712BafL
   aDGjPD5GEw1n/YMUAqixqAGyQA5r2e29Yix6lQBv28cscI4GMRmgLArhh
   Xch8HdlKbIO4Z4IIXoXAJBJG0x7KxE3iWHR8b5WizaMQABbbznd3Fv6sA
   QyRR1Kl19a8LdJsGqjWBzpHrQ2/8zobUkG1nS8azwWZu1zlig9LBJaUCw
   SOvnj9bVg/+y4rlAroL+aG2HdH4P25jPxhWKfYRzDKBNFV/R9JK9YB+Ak
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329098354"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="329098354"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:15:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="581025442"
Received: from arayamur-mobl.amr.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.153])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 21:15:21 -0700
Message-ID: <7a8447da-9a3f-da37-93de-dacab5b79211@intel.com>
Date:   Thu, 28 Apr 2022 07:15:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC 02/21] libperf evsel: Add perf_evsel__enable_thread()
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-3-adrian.hunter@intel.com>
 <CAM9d7cgbxC_vF2A2JtnOV-we7kO1qB9W5g_X4-zAEyR=vF6AcA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cgbxC_vF2A2JtnOV-we7kO1qB9W5g_X4-zAEyR=vF6AcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/22 00:48, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Fri, Apr 22, 2022 at 9:24 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
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
>> index 20ae9f5f8b30..2a1f07f877be 100644
>> --- a/tools/lib/perf/evsel.c
>> +++ b/tools/lib/perf/evsel.c
>> @@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>>         return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
>>  }
>>
>> +int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
>> +{
>> +       int err = 0;
>> +       int i;
>> +
>> +       for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
>> +               err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i, thread);
> 
> You might want to break the loop when it fails.

Thanks for looking at this.  It should break because of " && !err".

> 
> Thanks,
> Namhyung
> 
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

