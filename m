Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED190524446
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiELEdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347020AbiELEd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:33:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F42173E8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652330006; x=1683866006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+2V5uKNQxb0pwoOXe1pIKVDMfyElxOAjv/Z78Am4WeY=;
  b=N1nIUC97FrPud2vlGzGr1jpf9cVfLjVRoxfW3IZyPrl1BeZOohDtt1cg
   5wB5JBJmA+hxs85G4mQQB+kpD32ue3nP/ANLftFPaDe8fmPeyrJjdwVu/
   i6fovcf8w0/mEPm40pFY5baMVO250BOOptUt5lMbkoAKP9n2RKSXaBH1e
   9TwQU3SXtFSQAjciQfSf27QLn04TAZPLJ+q3TtisZJvqp6zR2g036hjd0
   cj71rEW7THmLElaMZftdknd7Nnz64vtFWUYBi/HnI94d2+rrd7vo8M6dm
   jDaN6go5x6M0o9LslYwaGFj0Q45JxTy4MzNFESA7jHy/A8yaplCxHal6m
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295132716"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295132716"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 21:33:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594478965"
Received: from ppwalsh-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.215])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 21:33:08 -0700
Message-ID: <531bca30-c458-c0f6-61e0-08d64bdb1b3d@intel.com>
Date:   Thu, 12 May 2022 07:33:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH V3 13/23] perf evlist: Add evlist__add_dummy_on_all_cpus()
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-14-adrian.hunter@intel.com>
 <1bce56f9-2e4c-6cff-c668-d62cab038591@intel.com>
 <CAM9d7cgTpZ1KFLMG5DT63twJZUgoxQ6zhUeMkSya0x4O6U9TMg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cgTpZ1KFLMG5DT63twJZUgoxQ6zhUeMkSya0x4O6U9TMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/22 01:50, Namhyung Kim wrote:
> On Wed, May 11, 2022 at 12:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add evlist__add_dummy_on_all_cpus() to enable creating a system-wide dummy
>> event that sets up the system-wide maps before map propagation.
>>
>> For convenience, add evlist__add_aux_dummy() so that the logic can be used
>> whether or not the event needs to be system-wide.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>> Changes in V3: Amended comment about all CPUs.
>>
>>  tools/perf/util/evlist.c | 45 ++++++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/evlist.h |  5 +++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index 78c47cbafbc2..2b2900434bba 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -264,6 +264,51 @@ int evlist__add_dummy(struct evlist *evlist)
>>         return 0;
>>  }
>>
>> +static void evlist__add_on_all_cpus(struct evlist *evlist, struct evsel *evsel)
>> +{
>> +       evsel->core.system_wide = true;
>> +
>> +       /*
>> +        * All CPUs.
>> +        *
>> +        * Note perf_event_open() does not accept CPUs that are not online, so
>> +        * in fact this CPU list will include only all online CPUs.
>> +        */
>> +       perf_cpu_map__put(evsel->core.own_cpus);
>> +       evsel->core.own_cpus = perf_cpu_map__new(NULL);
>> +       perf_cpu_map__put(evsel->core.cpus);
>> +       evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
> 
> Maybe I'm missing something.. Wouldn't it be overwritten
> by the user requested cpus during map propagation in
> evlist__add()?

Yes.  That gets changed in patch 22 "perf tools: Allow system-wide
events to keep their own CPUs"

> 
> Thanks,
> Namhyung
> 
> 
>> +
>> +       /* No threads */
>> +       perf_thread_map__put(evsel->core.threads);
>> +       evsel->core.threads = perf_thread_map__new_dummy();
>> +
>> +       evlist__add(evlist, evsel);
>> +}
>> +
>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>> +{
>> +       struct evsel *evsel = evlist__dummy_event(evlist);
>> +
>> +       if (!evsel)
>> +               return NULL;
>> +
>> +       evsel->core.attr.exclude_kernel = 1;
>> +       evsel->core.attr.exclude_guest = 1;
>> +       evsel->core.attr.exclude_hv = 1;
>> +       evsel->core.attr.freq = 0;
>> +       evsel->core.attr.sample_period = 1;
>> +       evsel->no_aux_samples = true;
>> +       evsel->name = strdup("dummy:u");
>> +
>> +       if (system_wide)
>> +               evlist__add_on_all_cpus(evlist, evsel);
>> +       else
>> +               evlist__add(evlist, evsel);
>> +
>> +       return evsel;
>> +}
>> +
>>  static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
>>  {
>>         struct evsel *evsel, *n;
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index 4062f5aebfc1..1bde9ccf4e7d 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -114,6 +114,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist);
>>  struct evsel *arch_evlist__leader(struct list_head *list);
>>
>>  int evlist__add_dummy(struct evlist *evlist);
>> +struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
>> +static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
>> +{
>> +       return evlist__add_aux_dummy(evlist, true);
>> +}
>>
>>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
>>                          evsel__sb_cb_t cb, void *data);
>> --
>> 2.25.1
>>

