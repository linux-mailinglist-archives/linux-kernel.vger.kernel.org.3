Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E41586AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiHAMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiHAMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:40:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0838A2216;
        Mon,  1 Aug 2022 05:19:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E46CB81171;
        Mon,  1 Aug 2022 12:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E30C433C1;
        Mon,  1 Aug 2022 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659356351;
        bh=/JIoU00r94QDCZUqD6rkY8cyNH+bBS6iM28uY6dkenE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rc+ynB+RKD+kOJeWfVtq1xFjW5bpKJZrq4ecv9FH/zodcDtkcQ9lf4S6Jag3FnsBd
         kKbZCqPWeJK3mEopOyfn27+72NAO3vuiEeQIz+iLQDeha30Mzw044LWAkzlPLqAYGa
         LFneXUFS6OT3H5yharDuacU/o0S7CugvzMx9kKWobhi30jAmTSRKCv0x310ILtTLkI
         gBcUh4kAtM3aqVWw7ADTCs71Dp2VTvKBT2Cx56T4m2Vu4InRZYFjZPok9pbpCZThjf
         FyFMmrn8CpZnUUIshwFRbV/scF3PYTCi0bdiEpRXWTn7njkLMzjUxijyUJDpuNNgoI
         iIjGqqs6D++qA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2202B40736; Mon,  1 Aug 2022 09:19:09 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:19:09 -0300
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
Subject: Re: [PATCH v3 2/3] perf test: Remove x86 rdpmc test
Message-ID: <YufEvRknYcalPEQ1@kernel.org>
References: <20220719223946.176299-1-irogers@google.com>
 <20220719223946.176299-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719223946.176299-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 19, 2022 at 03:39:45PM -0700, Ian Rogers escreveu:
> This test has been superseded by test_stat_user_read in:
> tools/lib/perf/tests/test-evsel.c
> The updated test doesn't divide-by-0 when running time of a counter is
> 0. It also supports ARM64.

Thanks, applied.

- Arnaldo

 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/tests/Build        |   1 -
>  tools/perf/arch/x86/tests/arch-tests.c |   2 -
>  tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
>  3 files changed, 185 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c
> 
> diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
> index 28d793390198..70b5bcbc15df 100644
> --- a/tools/perf/arch/x86/tests/Build
> +++ b/tools/perf/arch/x86/tests/Build
> @@ -2,7 +2,6 @@ perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
>  perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  
>  perf-y += arch-tests.o
> -perf-y += rdpmc.o
>  perf-y += sample-parsing.o
>  perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
>  perf-$(CONFIG_X86_64) += bp-modify.o
> diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
> index 64fb73d14d2f..04018b8aa85b 100644
> --- a/tools/perf/arch/x86/tests/arch-tests.c
> +++ b/tools/perf/arch/x86/tests/arch-tests.c
> @@ -3,7 +3,6 @@
>  #include "tests/tests.h"
>  #include "arch-tests.h"
>  
> -DEFINE_SUITE("x86 rdpmc", rdpmc);
>  #ifdef HAVE_AUXTRACE_SUPPORT
>  DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
>  DEFINE_SUITE("Intel PT packet decoder", intel_pt_pkt_decoder);
> @@ -14,7 +13,6 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
>  DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
>  
>  struct test_suite *arch_tests[] = {
> -	&suite__rdpmc,
>  #ifdef HAVE_DWARF_UNWIND_SUPPORT
>  	&suite__dwarf_unwind,
>  #endif
> diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
> deleted file mode 100644
> index 498413ad9c97..000000000000
> --- a/tools/perf/arch/x86/tests/rdpmc.c
> +++ /dev/null
> @@ -1,182 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <errno.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <signal.h>
> -#include <sys/mman.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <linux/string.h>
> -#include <linux/types.h>
> -#include "perf-sys.h"
> -#include "debug.h"
> -#include "tests/tests.h"
> -#include "cloexec.h"
> -#include "event.h"
> -#include <internal/lib.h> // page_size
> -#include "arch-tests.h"
> -
> -static u64 rdpmc(unsigned int counter)
> -{
> -	unsigned int low, high;
> -
> -	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
> -
> -	return low | ((u64)high) << 32;
> -}
> -
> -static u64 rdtsc(void)
> -{
> -	unsigned int low, high;
> -
> -	asm volatile("rdtsc" : "=a" (low), "=d" (high));
> -
> -	return low | ((u64)high) << 32;
> -}
> -
> -static u64 mmap_read_self(void *addr)
> -{
> -	struct perf_event_mmap_page *pc = addr;
> -	u32 seq, idx, time_mult = 0, time_shift = 0;
> -	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
> -
> -	do {
> -		seq = pc->lock;
> -		barrier();
> -
> -		enabled = pc->time_enabled;
> -		running = pc->time_running;
> -
> -		if (enabled != running) {
> -			cyc = rdtsc();
> -			time_mult = pc->time_mult;
> -			time_shift = pc->time_shift;
> -			time_offset = pc->time_offset;
> -		}
> -
> -		idx = pc->index;
> -		count = pc->offset;
> -		if (idx)
> -			count += rdpmc(idx - 1);
> -
> -		barrier();
> -	} while (pc->lock != seq);
> -
> -	if (enabled != running) {
> -		u64 quot, rem;
> -
> -		quot = (cyc >> time_shift);
> -		rem = cyc & (((u64)1 << time_shift) - 1);
> -		delta = time_offset + quot * time_mult +
> -			((rem * time_mult) >> time_shift);
> -
> -		enabled += delta;
> -		if (idx)
> -			running += delta;
> -
> -		quot = count / running;
> -		rem = count % running;
> -		count = quot * enabled + (rem * enabled) / running;
> -	}
> -
> -	return count;
> -}
> -
> -/*
> - * If the RDPMC instruction faults then signal this back to the test parent task:
> - */
> -static void segfault_handler(int sig __maybe_unused,
> -			     siginfo_t *info __maybe_unused,
> -			     void *uc __maybe_unused)
> -{
> -	exit(-1);
> -}
> -
> -static int __test__rdpmc(void)
> -{
> -	volatile int tmp = 0;
> -	u64 i, loops = 1000;
> -	int n;
> -	int fd;
> -	void *addr;
> -	struct perf_event_attr attr = {
> -		.type = PERF_TYPE_HARDWARE,
> -		.config = PERF_COUNT_HW_INSTRUCTIONS,
> -		.exclude_kernel = 1,
> -	};
> -	u64 delta_sum = 0;
> -        struct sigaction sa;
> -	char sbuf[STRERR_BUFSIZE];
> -
> -	sigfillset(&sa.sa_mask);
> -	sa.sa_sigaction = segfault_handler;
> -	sa.sa_flags = 0;
> -	sigaction(SIGSEGV, &sa, NULL);
> -
> -	fd = sys_perf_event_open(&attr, 0, -1, -1,
> -				 perf_event_open_cloexec_flag());
> -	if (fd < 0) {
> -		pr_err("Error: sys_perf_event_open() syscall returned "
> -		       "with %d (%s)\n", fd,
> -		       str_error_r(errno, sbuf, sizeof(sbuf)));
> -		return -1;
> -	}
> -
> -	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> -	if (addr == (void *)(-1)) {
> -		pr_err("Error: mmap() syscall returned with (%s)\n",
> -		       str_error_r(errno, sbuf, sizeof(sbuf)));
> -		goto out_close;
> -	}
> -
> -	for (n = 0; n < 6; n++) {
> -		u64 stamp, now, delta;
> -
> -		stamp = mmap_read_self(addr);
> -
> -		for (i = 0; i < loops; i++)
> -			tmp++;
> -
> -		now = mmap_read_self(addr);
> -		loops *= 10;
> -
> -		delta = now - stamp;
> -		pr_debug("%14d: %14Lu\n", n, (long long)delta);
> -
> -		delta_sum += delta;
> -	}
> -
> -	munmap(addr, page_size);
> -	pr_debug("   ");
> -out_close:
> -	close(fd);
> -
> -	if (!delta_sum)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -int test__rdpmc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
> -{
> -	int status = 0;
> -	int wret = 0;
> -	int ret;
> -	int pid;
> -
> -	pid = fork();
> -	if (pid < 0)
> -		return -1;
> -
> -	if (!pid) {
> -		ret = __test__rdpmc();
> -
> -		exit(ret);
> -	}
> -
> -	wret = waitpid(pid, &status, 0);
> -	if (wret < 0 || status)
> -		return -1;
> -
> -	return 0;
> -}
> -- 
> 2.37.0.170.g444d1eabd0-goog

-- 

- Arnaldo
