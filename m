Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADA0519C71
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbiEDKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiEDKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:00:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83926AFB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651658198; x=1683194198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HVgWLd9KHhixvotLGTOAB/90RvXHZYwfdJRQ9AXq3Mo=;
  b=RmXE1bGRqfVVsT3zb5az7XopxZ1kZ/mFvG4ymRP+2sOCkpdUJ4Ykak0w
   N//PG4J1QozKJGBlCqVB6F+ipScGLzkpqmn0/kfPJI5eZbXS69mggzlTQ
   unMuVAW68Z+k7JhzaxtFY7KLjEXKxBUwmz3pxUW+yZme1+B774zXw1m+F
   6rt/LKFofZKRMbZJPzcrbc/J3xhRmDsNBc9gMXR7uArfXOkG7L00nj2Dj
   dC40WGQf7XcmghooBpRBY/BgcLYTBnano0Z0yPkQRhkJnfWtrsS9uHYnc
   LSpzR3e2CjQ2aqquFhlPgl+DNJOotpz11usvpsBaiQt9FMfA2Q8+/j1Y4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="330704993"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="330704993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:56:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="584655996"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:56:36 -0700
Message-ID: <c6bf8be1-1416-499b-7695-6b46e41b788c@intel.com>
Date:   Wed, 4 May 2022 12:56:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH RFC 18/21] libperf evlist: Allow mixing per-thread and
 per-cpu mmaps
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
 <20220422162402.147958-19-adrian.hunter@intel.com>
 <CAM9d7chPX314n6c_V+3c0HF1OKNSL3zS-s3L78oH39Ds7cSpEg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7chPX314n6c_V+3c0HF1OKNSL3zS-s3L78oH39Ds7cSpEg@mail.gmail.com>
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

On 3/05/22 23:29, Namhyung Kim wrote:
> On Fri, Apr 22, 2022 at 9:25 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
>> can be iterated in any case.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
> [...]
>> @@ -561,9 +538,12 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
>>  {
>>         int nr_mmaps;
>>
>> +       /* One for each CPU */
>>         nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
>> -       if (perf_cpu_map__empty(evlist->all_cpus))
>> -               nr_mmaps = perf_thread_map__nr(evlist->threads);
>> +       /* One for each thread */
>> +       nr_mmaps += perf_thread_map__nr(evlist->threads);
>> +       /* Minus the dummy CPU or dummy thread */
>> +       nr_mmaps -= 1;
> 
> I'm not sure it'd work for per-task events with default-per-cpu mode.

Thanks for noticing that. It ends up being too high which doesn't fail
immediately.  I need to add a check that nr_mmaps matches the number
of mmaps actually made.

> 
> Thanks,
> Namhyung
> 
>>
>>         return nr_mmaps;
>>  }

