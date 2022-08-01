Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7C586B06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiHAMnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiHAMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:42:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A734B493;
        Mon,  1 Aug 2022 05:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D59F0CE13B6;
        Mon,  1 Aug 2022 12:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98276C433D6;
        Mon,  1 Aug 2022 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659356598;
        bh=DxjdDw3En4qFuOqWhLneEyFYNcSQm9VdlV/1jaOa144=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEFLiqHito8NFeCy4MfSdZ3niQlWcswl0Xo97Tt5+of1YzYx64Pv6IvHK1vu8VHrs
         kWXvHbwz2C13qwCRhkwed8pbuYApNKXB2HyC3NCviT5tFoLVhel6MBPd1CL4yo2ISZ
         Vmmb/Apn+scKkPGPh74k8JySvvgiSI2cHPuU+ZrD5Ocy+0oye3Ax22+ys57+kNmcDK
         qHMyCbGDFdcAPRdhHyoPWVLhXscTZRaH6lHwAN0AsRMLVKdtTs2Xec+LuyagmOILen
         cxA5O8asGzHsRaL9rgzA9Rh2rL/EzRKIvDqzRhL4C2CVeKa/05Mr+q2CkCsPjRv0C/
         MN6RXRGavShfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E4C440736; Mon,  1 Aug 2022 09:23:15 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:23:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 3/3] perf test: Add user space counter reading tests
Message-ID: <YufFs0yZvUc+9wbp@kernel.org>
References: <20220719223946.176299-1-irogers@google.com>
 <20220719223946.176299-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719223946.176299-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 19, 2022 at 03:39:46PM -0700, Ian Rogers escreveu:
> These tests are based on test_stat_user_read in
> tools/lib/perf/tests/test-evsel.c. The tests are modified to skip if
> perf_event_open fails or rdpmc isn't supported.

Thanks, tested and applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/mmap-basic.c | 127 +++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 30bbe144648a..dfb6173b2a82 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -170,14 +170,139 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>  	return err;
>  }
>  
> +static int test_stat_user_read(int event)
> +{
> +	struct perf_counts_values counts = { .val = 0 };
> +	struct perf_thread_map *threads;
> +	struct perf_evsel *evsel;
> +	struct perf_event_mmap_page *pc;
> +	struct perf_event_attr attr = {
> +		.type	= PERF_TYPE_HARDWARE,
> +		.config	= event,
> +#ifdef __aarch64__
> +		.config1 = 0x2,		/* Request user access */
> +#endif
> +	};
> +	int err, i, ret = TEST_FAIL;
> +	bool opened = false, mapped = false;
> +
> +	threads = perf_thread_map__new_dummy();
> +	TEST_ASSERT_VAL("failed to create threads", threads);
> +
> +	perf_thread_map__set_pid(threads, 0, 0);
> +
> +	evsel = perf_evsel__new(&attr);
> +	TEST_ASSERT_VAL("failed to create evsel", evsel);
> +
> +	err = perf_evsel__open(evsel, NULL, threads);
> +	if (err) {
> +		pr_err("failed to open evsel: %s\n", strerror(-err));
> +		ret = TEST_SKIP;
> +		goto out;
> +	}
> +	opened = true;
> +
> +	err = perf_evsel__mmap(evsel, 0);
> +	if (err) {
> +		pr_err("failed to mmap evsel: %s\n", strerror(-err));
> +		goto out;
> +	}
> +	mapped = true;
> +
> +	pc = perf_evsel__mmap_base(evsel, 0, 0);
> +	if (!pc) {
> +		pr_err("failed to get mmapped address\n");
> +		goto out;
> +	}
> +
> +	if (!pc->cap_user_rdpmc || !pc->index) {
> +		pr_err("userspace counter access not %s\n",
> +			!pc->cap_user_rdpmc ? "supported" : "enabled");
> +		ret = TEST_SKIP;
> +		goto out;
> +	}
> +	if (pc->pmc_width < 32) {
> +		pr_err("userspace counter width not set (%d)\n", pc->pmc_width);
> +		goto out;
> +	}
> +
> +	perf_evsel__read(evsel, 0, 0, &counts);
> +	if (counts.val == 0) {
> +		pr_err("failed to read value for evsel\n");
> +		goto out;
> +	}
> +
> +	for (i = 0; i < 5; i++) {
> +		volatile int count = 0x10000 << i;
> +		__u64 start, end, last = 0;
> +
> +		pr_debug("\tloop = %u, ", count);
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		start = counts.val;
> +
> +		while (count--) ;
> +
> +		perf_evsel__read(evsel, 0, 0, &counts);
> +		end = counts.val;
> +
> +		if ((end - start) < last) {
> +			pr_err("invalid counter data: end=%llu start=%llu last= %llu\n",
> +				end, start, last);
> +			goto out;
> +		}
> +		last = end - start;
> +		pr_debug("count = %llu\n", end - start);
> +	}
> +	ret = TEST_OK;
> +
> +out:
> +	if (mapped)
> +		perf_evsel__munmap(evsel);
> +	if (opened)
> +		perf_evsel__close(evsel);
> +	perf_evsel__delete(evsel);
> +
> +	perf_thread_map__put(threads);
> +	return ret;
> +}
> +
> +static int test__mmap_user_read_instr(struct test_suite *test __maybe_unused,
> +				      int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
> +}
> +
> +static int test__mmap_user_read_cycles(struct test_suite *test __maybe_unused,
> +				       int subtest __maybe_unused)
> +{
> +	return test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
> +}
> +
>  static struct test_case tests__basic_mmap[] = {
>  	TEST_CASE_REASON("Read samples using the mmap interface",
>  			 basic_mmap,
>  			 "permissions"),
> +	TEST_CASE_REASON("User space counter reading of instructions",
> +			 mmap_user_read_instr,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +			 "permissions"
> +#else
> +			 "unsupported"
> +#endif
> +		),
> +	TEST_CASE_REASON("User space counter reading of cycles",
> +			 mmap_user_read_cycles,
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +			 "permissions"
> +#else
> +			 "unsupported"
> +#endif
> +		),
>  	{	.name = NULL, }
>  };
>  
>  struct test_suite suite__basic_mmap = {
> -	.desc = "Read samples using the mmap interface",
> +	.desc = "mmap interface tests",
>  	.test_cases = tests__basic_mmap,
>  };
> -- 
> 2.37.0.170.g444d1eabd0-goog

-- 

- Arnaldo
