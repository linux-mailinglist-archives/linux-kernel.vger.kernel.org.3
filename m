Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD35736D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiGMNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGMNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:05:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948C95A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657717523; x=1689253523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3/JrVfpmFvfLGf0fxASAn43yBmIG5r41lKNLXkTMb8A=;
  b=cK0q3aCK5z+a6bw2u4bYXoSKpRt5xaNHs6jbPlUDSBawtHrAz4d4VxV7
   HAyxaThX2/PwL0g7bM5doYjL7RT6DGb6c95dFnhwWhbqnfq5Re82TSnVV
   TWU0htkEZq5Z7jsCPQ5nJP7Ejf4WEPHt3ReoR//vTR7r9fhtAgVYroFeJ
   Ed9NZEWif4tzv3P3x701Sl8LuTPbaovIjWjQCa6E0t2hmemDzEUOjCuy8
   sXkqCDh+hur4SaTRagUIU3FFoIDceH4+N7WW7eAYe5RY/TOh1npCSOaCk
   9UWj+6VFi3CApWJwgSTUtOzZk04DPkBeJns0+P/AEUEv29MNtyI8x37c4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264991991"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264991991"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 06:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570618560"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 13 Jul 2022 06:05:23 -0700
Received: from [10.252.208.247] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 3829B580298;
        Wed, 13 Jul 2022 06:05:22 -0700 (PDT)
Message-ID: <75aaa2a8-7956-84bb-a811-f70802753e21@linux.intel.com>
Date:   Wed, 13 Jul 2022 09:05:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH 2/2] perf tests: Fix Convert perf time to TSC test for
 hybrid
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
References: <20220713123459.24145-1-adrian.hunter@intel.com>
 <20220713123459.24145-3-adrian.hunter@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220713123459.24145-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-13 8:34 a.m., Adrian Hunter wrote:
> The test does not always correctly determine the number of events for
> hybrids, nor allow for more than 1 evsel when parsing.
> 
> Fix by iterating the events actually created and getting the correct
> evsel for the events processed.
> 

Yes, we cannot always assume there are two events for hybrid.

> Fixes: d9da6f70eb23 ("perf tests: Support 'Convert perf time to TSC' test for hybrid")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/tests/perf-time-to-tsc.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index 8d6d60173693..7c7d20fc503a 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -20,8 +20,6 @@
>  #include "tsc.h"
>  #include "mmap.h"
>  #include "tests.h"
> -#include "pmu.h"
> -#include "pmu-hybrid.h"
>  
>  /*
>   * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
> @@ -106,18 +104,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  
>  	evlist__config(evlist, &opts, NULL);
>  
> -	evsel = evlist__first(evlist);
> -
> -	evsel->core.attr.comm = 1;
> -	evsel->core.attr.disabled = 1;
> -	evsel->core.attr.enable_on_exec = 0;
> -
> -	/*
> -	 * For hybrid "cycles:u", it creates two events.
> -	 * Init the second evsel here.
> -	 */
> -	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom")) {
> -		evsel = evsel__next(evsel);
> +	/* For hybrid "cycles:u", it creates two events */
> +	evlist__for_each_entry(evlist, evsel) {
>  		evsel->core.attr.comm = 1;
>  		evsel->core.attr.disabled = 1;
>  		evsel->core.attr.enable_on_exec = 0;
> @@ -170,10 +158,12 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  				goto next_event;
>  
>  			if (strcmp(event->comm.comm, comm1) == 0) {
> +				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
>  				CHECK__(evsel__parse_sample(evsel, event, &sample));
>  				comm1_time = sample.time;
>  			}
>  			if (strcmp(event->comm.comm, comm2) == 0) {
> +				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
>  				CHECK__(evsel__parse_sample(evsel, event, &sample));
>  				comm2_time = sample.time;
>  			}
