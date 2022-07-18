Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B159C5782B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiGRMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiGRMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:49:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2765AB;
        Mon, 18 Jul 2022 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658148586; x=1689684586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i4xXjjWA7cU5rpfcYkVqiOupLI9x3moogOEYt4bfQv0=;
  b=h/OqCstAwKC1eRHpI7uW+31ZAJ57UsJRl26G9Ak15UqN0DWbuyJzM7Rj
   8/SUV2+84c3W30dLhbEsCgUMQ4raVsrz3GrGOxtHTPikRwSNWGUZxtiNX
   WFHleQ/I/XUN+go9xx0HWrMOVQsuvRGed5RclxDfsNMOVyGzwBskxxTKt
   qrk/MoykIs/zZXnDLbM3Rch+1ycfA+hLm7BtQWSzi1NivxrEWLjPZQeKj
   vhJQMK0fImT1JxnE6aLJIGguH34JZH91E+8o6CqoY2f96v7Cu5vUgvrEu
   m/27OEdMiDnV0loiKfWwvnphRatEh7BB3g53DKZytFUcF06dT10Ho5gVA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="311891631"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311891631"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="601211633"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2022 05:49:46 -0700
Received: from [10.252.209.6] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BC0FF5808A1;
        Mon, 18 Jul 2022 05:49:43 -0700 (PDT)
Message-ID: <5f86dd4d-e078-4bc6-2d51-df404179ecf6@linux.intel.com>
Date:   Mon, 18 Jul 2022 08:49:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v3 2/2] perf tsc: Add arch TSC frequency information
Content-Language: en-US
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
 <20220715223521.3389971-3-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220715223521.3389971-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-15 6:35 p.m., Ian Rogers wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The TSC frequency information is required for the event metrics with
> the literal, system_tsc_freq. For the newer Intel platform, the TSC
> frequency information can be retrieved from the CPUID leaf 0x15.
> If the TSC frequency information isn't present the /proc/cpuinfo
> approach is used.
> 
> Refactor cpuid for this use. Note, the previous stack pushing/popping
> approach was broken on x86-64 that has stack red zones that would be
> clobbered.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/cpuid.h  | 34 +++++++++++++++++++++++++++++++
>  tools/perf/arch/x86/util/header.c | 27 ++++++++++--------------
>  tools/perf/arch/x86/util/tsc.c    | 33 ++++++++++++++++++++++++++++++
>  tools/perf/util/expr.c            | 15 +++++++++++++-
>  tools/perf/util/tsc.h             |  1 +
>  5 files changed, 93 insertions(+), 17 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/cpuid.h
> 
> diff --git a/tools/perf/arch/x86/util/cpuid.h b/tools/perf/arch/x86/util/cpuid.h
> new file mode 100644
> index 000000000000..0a3ae0ace7e9
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/cpuid.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef PERF_CPUID_H
> +#define PERF_CPUID_H 1
> +
> +
> +static inline void
> +cpuid(unsigned int op, unsigned int op2, unsigned int *a, unsigned int *b,
> +	unsigned int *c, unsigned int *d)
> +{
> +	/*
> +	 * Preserve %ebx/%rbx register by either placing it in %rdi or saving it
> +	 * on the stack - x86-64 needs to avoid the stack red zone. In PIC
> +	 * compilations %ebx contains the address of the global offset
> +	 * table. %rbx is occasionally used to address stack variables in
> +	 * presence of dynamic allocas.
> +	 */
> +	asm(
> +#if defined(__x86_64__)
> +		"mov %%rbx, %%rdi\n"
> +		"cpuid\n"
> +		"xchg %%rdi, %%rbx\n"
> +#else
> +		"pushl %%ebx\n"
> +		"cpuid\n"
> +		"movl %%ebx, %%edi\n"
> +		"popl %%ebx\n"
> +#endif
> +		: "=a"(*a), "=D"(*b), "=c"(*c), "=d"(*d)
> +		: "a"(op), "2"(op2));
> +}
> +
> +void get_cpuid_0(char *vendor, unsigned int *lvl);
> +
> +#endif
> diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/header.c
> index 578c8c568ffd..a51444a77a5f 100644
> --- a/tools/perf/arch/x86/util/header.c
> +++ b/tools/perf/arch/x86/util/header.c
> @@ -9,18 +9,17 @@
>  
>  #include "../../../util/debug.h"
>  #include "../../../util/header.h"
> +#include "cpuid.h"
>  
> -static inline void
> -cpuid(unsigned int op, unsigned int *a, unsigned int *b, unsigned int *c,
> -      unsigned int *d)
> +void get_cpuid_0(char *vendor, unsigned int *lvl)
>  {
> -	__asm__ __volatile__ (".byte 0x53\n\tcpuid\n\t"
> -			      "movl %%ebx, %%esi\n\t.byte 0x5b"
> -			: "=a" (*a),
> -			"=S" (*b),
> -			"=c" (*c),
> -			"=d" (*d)
> -			: "a" (op));
> +	unsigned int b, c, d;
> +
> +	cpuid(0, 0, lvl, &b, &c, &d);
> +	strncpy(&vendor[0], (char *)(&b), 4);
> +	strncpy(&vendor[4], (char *)(&d), 4);
> +	strncpy(&vendor[8], (char *)(&c), 4);
> +	vendor[12] = '\0';
>  }
>  
>  static int
> @@ -31,14 +30,10 @@ __get_cpuid(char *buffer, size_t sz, const char *fmt)
>  	int nb;
>  	char vendor[16];
>  
> -	cpuid(0, &lvl, &b, &c, &d);
> -	strncpy(&vendor[0], (char *)(&b), 4);
> -	strncpy(&vendor[4], (char *)(&d), 4);
> -	strncpy(&vendor[8], (char *)(&c), 4);
> -	vendor[12] = '\0';
> +	get_cpuid_0(vendor, &lvl);
>  
>  	if (lvl >= 1) {
> -		cpuid(1, &a, &b, &c, &d);
> +		cpuid(1, 0, &a, &b, &c, &d);
>  
>  		family = (a >> 8) & 0xf;  /* bits 11 - 8 */
>  		model  = (a >> 4) & 0xf;  /* Bits  7 - 4 */
> diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
> index 559365f8fe52..b69144f22489 100644
> --- a/tools/perf/arch/x86/util/tsc.c
> +++ b/tools/perf/arch/x86/util/tsc.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/types.h>
> +#include <string.h>
>  
>  #include "../../../util/tsc.h"
> +#include "cpuid.h"
>  
>  u64 rdtsc(void)
>  {
> @@ -11,3 +13,34 @@ u64 rdtsc(void)
>  
>  	return low | ((u64)high) << 32;
>  }
> +
> +double arch_get_tsc_freq(void)
> +{
> +	unsigned int a, b, c, d, lvl;
> +	static bool cached;
> +	static double tsc;
> +	char vendor[16];
> +
> +	if (cached)
> +		return tsc;
> +
> +	cached = true;
> +	get_cpuid_0(vendor, &lvl);
> +	if (!strstr(vendor, "Intel"))
> +		return 0;
> +
> +	/*
> +	 * Don't support Time Stamp Counter and
> +	 * Nominal Core Crystal Clock Information Leaf.
> +	 */
> +	if (lvl < 0x15)
> +		return 0;
> +
> +	cpuid(0x15, 0, &a, &b, &c, &d);
> +	/* TSC frequency is not enumerated */
> +	if (!a || !b || !c)
> +		return 0;
> +
> +	tsc = (double)c * (double)b / (double)a;
> +	return tsc;
> +}
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 4c81533e4b43..16f10e6d5ca5 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -12,6 +12,7 @@
>  #include "expr-bison.h"
>  #include "expr-flex.h"
>  #include "smt.h"
> +#include "tsc.h"
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
> @@ -443,9 +444,19 @@ static double system_tsc_freq(void)
>  
>  	free(line);
>  	fclose(cpuinfo);
> +	if (isnan(result))
> +		pr_err("Error reading system_tsc_freq");
> +
>  	return result;
>  }
>  
> +#if !defined(__i386__) && !defined(__x86_64__)
> +double arch_get_tsc_freq(void)

Other arch_* functions are __weak functions. I think it's better to keep
it consistent. It also avoid to add a new #if defined when adding a new
arch. Is there a problem to use __weak here?

Thanks,
Kan

> +{
> +	return 0.0;
> +}
> +#endif
> +
>  double expr__get_literal(const char *literal)
>  {
>  	static struct cpu_topology *topology;
> @@ -462,7 +473,9 @@ double expr__get_literal(const char *literal)
>  	}
>  
>  	if (!strcasecmp("#system_tsc_freq", literal)) {
> -		result = system_tsc_freq();
> +		result = arch_get_tsc_freq();
> +		if (fpclassify(result) == FP_ZERO)
> +			result = system_tsc_freq();
>  		goto out;
>  	}
>  
> diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
> index 7d83a31732a7..88fd1c4c1cb8 100644
> --- a/tools/perf/util/tsc.h
> +++ b/tools/perf/util/tsc.h
> @@ -25,6 +25,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
>  u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
>  u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
>  u64 rdtsc(void);
> +double arch_get_tsc_freq(void);
>  
>  size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
>  
