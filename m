Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F82F5736CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiGMND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiGMNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:03:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB15AB6A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657717397; x=1689253397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4HQiX0uLMNVJCvA73YSc8YzJHNYg+9u1Y1cadFpsldA=;
  b=NGySF+d2AAt8gCLAp7mz8ClLNKDPE91800UYeQwaJ6R1Z6jl4j9uwsAP
   GoqYJJRDn0Mg0vxhmowcOSRwxyebxl9j2NsLj+gUYkwvUY400HbHoUNF9
   x2YMVYiHQJ8cjO5yR5n4HDF1S+8epgKhc0awuqspmo3TKdOibnb8gntSG
   YFpvlTN/1UMYwUG6H6Fr2xAWw3nabcUAT9zUMXxUWrr32vikbsPeRHVRE
   ZPQKza9csCIux+jRAp3c8qS9nyS8NlocNabvsk4VFdECO+o01NdcuVB0b
   r+iXJzMUsaTDy3ApeRXsETELDWXzD2cyzckDxTbJQkg+K2Qs/wpUjoypZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286338897"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286338897"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 06:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="685149893"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2022 06:03:08 -0700
Received: from [10.252.208.247] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id A12C9580298;
        Wed, 13 Jul 2022 06:03:07 -0700 (PDT)
Message-ID: <cd39e02e-f1b0-e6df-df30-953847af7783@linux.intel.com>
Date:   Wed, 13 Jul 2022 09:03:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH 1/2] perf tests: Stop Convert perf time to TSC test
 opening events twice
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
References: <20220713123459.24145-1-adrian.hunter@intel.com>
 <20220713123459.24145-2-adrian.hunter@intel.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220713123459.24145-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-13 8:34 a.m., Adrian Hunter wrote:
> Do not call evlist__open() twice.
> 
> Fixes: 5bb017d4b97a ("perf test: Fix error message for test case 71 on s390, where it is not supported")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>> ---
>  tools/perf/tests/perf-time-to-tsc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index 4ad0dfbc8b21..8d6d60173693 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -123,11 +123,14 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  		evsel->core.attr.enable_on_exec = 0;
>  	}
>  
> -	if (evlist__open(evlist) == -ENOENT) {
> -		err = TEST_SKIP;
> +	ret = evlist__open(evlist);
> +	if (ret < 0) {
> +		if (ret == -ENOENT)
> +			err = TEST_SKIP;
> +		else
> +			pr_debug("evlist__open() failed\n");

The error message for the evlist__open is slightly different with the
old one, "evlist__open(evlist) failed!". Not sure if anyone care about it.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  		goto out_err;
>  	}
> -	CHECK__(evlist__open(evlist));
>  
>  	CHECK__(evlist__mmap(evlist, UINT_MAX));
>  
