Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672564F901E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiDHIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiDHIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:01:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B79296885;
        Fri,  8 Apr 2022 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649404730; x=1680940730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EsIQwB623pK7LxQsrjuDZNk2FugTNnwaePVfitkTM8o=;
  b=FWh2EXf8Fte5nHoLu4GAEzKo53KuutBEFxf2oS0oNj7A0g6me6NiJcaY
   zxnFT87UQSn1NzXvCwNOgr1IS2FXSw00Jfh+aUCBBGzKs4kzto3W4lmlm
   jE4UJONLH7cQEkP721o9L2NgPwhtqjEi040y0IbMUaZzMHBnrnihn/jYL
   NWhRYIMIidVAlQvBpWHDQrHi5LQ7IzXFRIWvKcz1cBGbqqciOWdMITWVF
   WkB+lnEh7BGfClOM92WAStQP0utMdlGQELdtUlz8eAGk9iE27pdk+sMvk
   cbNB8C7p3fM9y3Fe0rY5huYlH+n6rbXGGgEAdeb1gP5vWUGxJ9nDI35xY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261532712"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261532712"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:58:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="550415742"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.40.214])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 00:58:41 -0700
Message-ID: <c4ce0947-e21f-d3b1-96b8-f2778a2e35e6@intel.com>
Date:   Fri, 8 Apr 2022 10:58:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3] perf test tsc: Fix error message report when not
 supported.
Content-Language: en-US
To:     Chengdong Li <brytonlee01@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     ak@linux.intel.com, likexu@tencent.com, chengdongli@tencent.com
References: <676075ca-4d5d-7388-61ac-42a0b9f1ed50@intel.com>
 <20220408021428.18009-1-chengdongli@tencent.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220408021428.18009-1-chengdongli@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 5.14, Chengdong Li wrote:
> By default `perf test tsc` does not return the error message
> when the child process detected kernel does not support. Instead,
> the child process print error message to stderr, unfortunately
> the stderr is redirected to /dev/null when verbose <= 0.
> 
> This patch did three things:
> - returns TEST_SKIP to the parent process instead of TEST_OK when
>   perf_read_tsc_conversion() is not supported.
> - add a new subtest of testing if TSC is supported on current
>   architecture by moving exist code to a separate function.
>   It avoids two places in test__perf_time_to_tsc() that return
>   TEST_SKIP by doing this.
> - extended test suite definition to contain above two subtests.
>   Current test_suite and test_case structs do not support printing
>   skip reason when the number of subtest less than 1. To print skip
>   reason, it is necessary to extend current test suite definition.
> 
> Changes since v2:
> - refine error message format.
> - refine commit log message according to Adrian's review comments.
> 
> Changes since v1 (thanks for the feedback from Adrian Hunter):
> - rebase commit to current source.
> 
> Signed-off-by: Chengdong Li <chengdongli@tencent.com>

It is better to try to consistently use the same email address
for the same person for git logs, unless you have a sensible
reason not to.

So in this case it looks like you should use the same email
address for the "From:" and "Signed-off-by:".  Note you can
optionally put the "From:" line before the commit message e.g.

From: Chengdong Li <chengdongli@tencent.com>

By default `perf test tsc` does not return the error message
...


Otherwise you can add:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index d12d0ad81801..cc6df49a65a1 100644
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
> +		pr_debug("Test not supported on this architecture\n");
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
> +			pr_debug("perf_read_tsc_conversion is not supported in current kernel\n");
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
> +	TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
> +			 "perf_read_tsc_conversion is not supported"),
> +	{ .name = NULL, }
> +};
> +
> +struct test_suite suite__perf_time_to_tsc = {
> +	.desc = "Convert perf time to TSC",
> +	.test_cases = time_to_tsc_tests,
> +};

