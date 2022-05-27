Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F7535D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbiE0Jua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiE0Ju2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:50:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A27106376;
        Fri, 27 May 2022 02:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PLZv4aN+bw9fiReWqFHw5EhmLaGImAvmd3vz2MNI3n8=; b=h9J/+hI5vZ1dVXe/z0CJ51jtYa
        ba7bXDyl4BxzqTfuWt4NF6kLsyN1Ep/pG0/+bKcdVXDyZH41cu0zvnBaI1C5vxHyqT0cUy/LtE983
        5s79+FEHB7TL7UKCoG590pjZJgQMaFb1fkoIeB0+f0+x4GUiiTkmez1ld+tNzw24+kcGa5s9nX23S
        fqdA0cWYeMYg8MYUSDJXzn20joUJOpMNYTFaxuiN6lPhBfbD7Z7+1ZL8AsZmXVa9SrG6UZwGXlZjp
        QxPpWXbFyZCQnsuNdci+iwraNbrqXA36VQazDVtY+edGuVLYgbmKL1Gq/jlB/LqUxoO3VtF854VdP
        jPxERNkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuWb2-0029gh-9r; Fri, 27 May 2022 09:49:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E623030006D;
        Fri, 27 May 2022 11:49:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8A50207C012A; Fri, 27 May 2022 11:49:23 +0200 (CEST)
Date:   Fri, 27 May 2022 11:49:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] perf metrics: Add literal for system TSC frequency
Message-ID: <YpCeo6APNtXvrTPJ@hirez.programming.kicks-ass.net>
References: <20220527040407.4193232-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527040407.4193232-1-irogers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:04:07PM -0700, Ian Rogers wrote:
> Such a literal is useful to calculate things like the average frequency
> [1]. The TSC frequency isn't exposed by sysfs although some experimental
> drivers look to add it [2]. This change computes the value using the
> frequency in /proc/cpuinfo which is accurate at least on Intel
> processors.
> 
> v2. Adds warnings to make clear if things have changed/broken on future
>     Intel platforms. It also adds caching and an Intel specific that a
>     value is computed.
> 
> [1] https://github.com/intel/perfmon-metrics/blob/5ad9ef7056f31075e8178b9f1fb732af183b2c8d/SKX/metrics/perf/skx_metric_perf.json#L11
> [2] https://github.com/trailofbits/tsc_freq_khz

This all seems bonghits inspired... and perf actually does expose the
tsc frequency. What do you think is in perf_event_mmap_page::time_* ?

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 15 +++++++++++++
>  tools/perf/util/expr.c  | 50 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
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
> +		TEST_ASSERT_VAL("!isnan(#system_tsc_freq)", !isnan(system_tsc_freq));
> +	}
> +
>  	/*
>  	 * Source count returns the number of events aggregating in a leader
>  	 * event including the leader. Check parsing yields an id.
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 675f318ce7c1..f33aeb1e6faa 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -402,6 +402,51 @@ double expr_id_data__source_count(const struct expr_id_data *data)
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
> +
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
> @@ -417,6 +462,11 @@ double expr__get_literal(const char *literal)
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
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
