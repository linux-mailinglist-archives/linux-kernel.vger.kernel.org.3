Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFF5781F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiGRMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiGRMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:15:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7018252B5;
        Mon, 18 Jul 2022 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658146493; x=1689682493;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2a9djxvYHwMzKSUq5xazfVjyavQ+n220/gOWPtn17QY=;
  b=kxPywq749wz2MdfSXFQPMR+BWVnWLZXg/T9CYWFuyf/w5SS6hp/FmiaZ
   seOENarwhXbiEhmhmazlnCMsUfoLbnddKk7M78oWb9pwLUTFX+t+N23yU
   fWM1cou/nMjYTzlGDyzwj2bvgHhRgbI3ZekTKJNi2hBwZFfnKPrVH6ktG
   8PFD4u8opoGsH6MrZnMBzhfW4oNOR/IIujKQBYRRAneVuKH/y6+FqBNU9
   9o8TNR/GIvWvanuY9w1DeZfWj7Mrv9l8VV+13AiFk8QwhMs0aL+Uc/Qw3
   gELPhqJNsiHPQopI9dyVqj0Xq8F/cpEzByG8uab9pZ/igSHeAGqmj/l5w
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286222221"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="286222221"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="547464900"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 05:14:52 -0700
Received: from [10.252.209.6] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 75C665807C9;
        Mon, 18 Jul 2022 05:14:50 -0700 (PDT)
Message-ID: <2abcf8c7-610d-a58f-47cb-cd5c2c1c15de@linux.intel.com>
Date:   Mon, 18 Jul 2022 08:14:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 1/2] perf metrics: Add literal for system TSC frequency
To:     Ian Rogers <irogers@google.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220715223521.3389971-1-irogers@google.com>
 <20220715223521.3389971-2-irogers@google.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220715223521.3389971-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Ian for working on the issue and coordinate the patches.

On 2022-07-15 6:35 p.m., Ian Rogers wrote:
> Such a literal is useful to calculate things like the average frequency
> [1]. The TSC frequency isn't exposed by sysfs although some experimental
> drivers look to add it [2]. This change computes the value using the
> frequency in /proc/cpuinfo which is accruate 

%s/accruate/accurate/

> at least on Intel processors.

I googled the cpuinfo of other Archs, e.g., arm and s390. It looks like
only Intel display the TSC frequency in the "model name".

So it may be better to move it to X86 specific code, arch/x86/util/tsc.c

> 
> [1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
> [2] https://github.com/trailofbits/tsc_freq_khz
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 15 +++++++++++++
>  tools/perf/util/expr.c  | 49 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 5c0032fe93ae..45afe4f24859 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "util/debug.h"
>  #include "util/expr.h"
> +#include "util/header.h"
>  #include "util/smt.h"
>  #include "tests.h"
> +#include <math.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <linux/zalloc.h>
> @@ -69,6 +71,11 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	double val, num_cpus, num_cores, num_dies, num_packages;
>  	int ret;
>  	struct expr_parse_ctx *ctx;
> +	bool is_intel = false;
> +	char buf[128];
> +
> +	if (!get_cpuid(buf, sizeof(buf)))
> +		is_intel = strstr(buf, "Intel") != NULL;
>  
>  	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
>  
> @@ -175,6 +182,14 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	if (num_dies) // Some platforms do not have CPU die support, for example s390
>  		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
>  
> +	if (is_intel) {
> +		double system_tsc_freq;
> +
> +		TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&system_tsc_freq, ctx,
> +								"#system_tsc_freq") == 0);


I think we should use arch_get_tsc_freq() to replace here.
This belong to a separate patch.


Thanks,
Kan
> +		TEST_ASSERT_VAL("!isnan(#system_tsc_freq)", !isnan(system_tsc_freq));
> +	}
> +
>  	/*
>  	 * Source count returns the number of events aggregating in a leader
>  	 * event including the leader. Check parsing yields an id.
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 675f318ce7c1..4c81533e4b43 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -402,6 +402,50 @@ double expr_id_data__source_count(const struct expr_id_data *data)
>  	return data->val.source_count;
>  }
>  
> +/*
> + * Derive the TSC frequency in Hz from the /proc/cpuinfo, for example:
> + * ...
> + * model name      : Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
> + * ...
> + * will return 3000000000.
> + */
> +static double system_tsc_freq(void)
> +{
> +	static double result;
> +	static bool computed;
> +	FILE *cpuinfo;
> +	char *line = NULL;
> +	size_t len = 0;
> +
> +	if (computed)
> +		return result;
> +
> +	computed = true;
> +	result = NAN;
> +	cpuinfo = fopen("/proc/cpuinfo", "r");
> +	if (!cpuinfo) {
> +		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
> +		return NAN;
> +	}
> +	while (getline(&line, &len, cpuinfo) > 0) {
> +		if (!strncmp(line, "model name", 10)) {
> +			char *pos = strstr(line + 11, " @ ");
> +
> +			if (pos && sscanf(pos, " @ %lfGHz", &result) == 1) {
> +				result *= 1000000000;
> +				goto out;
> +			}
> +		}
> +	}
> +out:
> +	if (isnan(result))
> +		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
> +
> +	free(line);
> +	fclose(cpuinfo);
> +	return result;
> +}
> +
>  double expr__get_literal(const char *literal)
>  {
>  	static struct cpu_topology *topology;
> @@ -417,6 +461,11 @@ double expr__get_literal(const char *literal)
>  		goto out;
>  	}
>  
> +	if (!strcasecmp("#system_tsc_freq", literal)) {
> +		result = system_tsc_freq();
> +		goto out;
> +	}
> +
>  	/*
>  	 * Assume that topology strings are consistent, such as CPUs "0-1"
>  	 * wouldn't be listed as "0,1", and so after deduplication the number of
