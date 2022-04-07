Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881564F76A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbiDGHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiDGHBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:01:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29A11C35;
        Wed,  6 Apr 2022 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649314758; x=1680850758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCawgySWnFdoXUs5uE6g8ZajUMb+k+3xwGiC2XSj38s=;
  b=m9+VPjzvryMR7JvJIlYfzxhykYMPzp5gdsJhucnsk/e0i3QrdWoO8R4i
   8GlAyZNJ9b8a85D16CzNqbTVR27nKo6HoLd0mY2tWWbtb6g5mCnRR6Uhb
   Ee1EwSf3qOwsdikzTmNt19rgdVZ1xyicIVH+ox4MSNrYecH0x2BUkaPSd
   HXFZaQorrKs6eVDY4lyH15fEW03K3L7LfrySdcOUDJ95dXL4wbl8o1R8j
   06aOmDa6T3P9IMWrylV7OtsEbi/sLyl9xG1y6YIP40QMsiLNqky43cJCw
   lnkL2oq3LgLYcrlFadfyMchoJCyrJPdpYCVgJzRqaBMr4Pn9yFObKlm2X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243380386"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="243380386"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:59:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="549893029"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.40.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 23:59:13 -0700
Message-ID: <ce2c3c4f-3751-312a-5fa6-0f98330067fe@intel.com>
Date:   Thu, 7 Apr 2022 09:59:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v2] perf test tsc: Fix error message report when not
 supported.
Content-Language: en-US
To:     Chengdong Li <brytonlee01@gmail.com>, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
References: <20220406100609.65239-1-chengdongli@tencent.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220406100609.65239-1-chengdongli@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 13.06, Chengdong Li wrote:
> By default `perf test tsc` does not return the error message
> when child process detected kernel does not support. Instead, child
> process print error message to stderr, unfortunately the stderr is
> redirected to /dev/null when verbose <= 0.
> 
> This patch did three things:
> - returns TEST_SKIP to parent process instead of TEST_OK when
>   perf_read_tsc_conversion() is not supported.
> - add a new subtest of testing if TSC is supported on current
>   architecture by moving exist code to a separate function.
> - extended test suite definition to contain above two subtests.
> 
> Changes since v1 (thanks for the feedback from Adrian Hunter):
> - rebase commit to current source.
> 
> Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> ---
>  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index d12d0ad81801..fc7c380af5a0 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -47,6 +47,17 @@
>  	}					\
>  }
>  
> +static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
> +				  int subtest __maybe_unused)
> +{
> +	if (!TSC_IS_SUPPORTED) {
> +		pr_debug("Test not supported on this architecture");

Message better ending with "\n" I think

> +		return TEST_SKIP;
> +	}
> +
> +	return TEST_OK;
> +}
> +
>  /**
>   * test__perf_time_to_tsc - test converting perf time to TSC.
>   *
> @@ -70,7 +81,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	struct perf_cpu_map *cpus = NULL;
>  	struct evlist *evlist = NULL;
>  	struct evsel *evsel = NULL;
> -	int err = -1, ret, i;
> +	int err = TEST_FAIL, ret, i;
>  	const char *comm1, *comm2;
>  	struct perf_tsc_conversion tc;
>  	struct perf_event_mmap_page *pc;
> @@ -79,10 +90,6 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	u64 test_time, comm1_time = 0, comm2_time = 0;
>  	struct mmap *md;
>  
> -	if (!TSC_IS_SUPPORTED) {
> -		pr_debug("Test not supported on this architecture");
> -		return TEST_SKIP;
> -	}
>  
>  	threads = thread_map__new(-1, getpid(), UINT_MAX);
>  	CHECK_NOT_NULL__(threads);
> @@ -124,8 +131,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	ret = perf_read_tsc_conversion(pc, &tc);
>  	if (ret) {
>  		if (ret == -EOPNOTSUPP) {
> -			fprintf(stderr, " (not supported)");
> -			return 0;
> +			pr_debug("perf_read_tsc_conversion is not supported in current kernel");
> +			err = TEST_SKIP;
>  		}
>  		goto out_err;
>  	}
> @@ -191,7 +198,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	    test_tsc >= comm2_tsc)
>  		goto out_err;
>  
> -	err = 0;
> +	err = TEST_OK;
>  
>  out_err:
>  	evlist__delete(evlist);
> @@ -200,4 +207,15 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  	return err;
>  }
>  
> -DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
> +static struct test_case time_to_tsc_tests[] = {
> +	TEST_CASE_REASON("TSC support", tsc_is_supported,
> +			 "This architecture does not support"),

The 2nd test case runs anyway, so I am not sure another
test case is needed?

> +	TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
> +			 "perf_read_tsc_conversion is not supported"),
> +	{ .name = NULL, }
> +};
> +
> +struct test_suite suite__perf_time_to_tsc = {
> +	.desc = "Convert perf time to TSC",
> +	.test_cases = time_to_tsc_tests,
> +};

