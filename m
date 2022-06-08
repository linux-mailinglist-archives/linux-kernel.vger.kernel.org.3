Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A79543F52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiFHWoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiFHWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:44:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA124F959
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:44:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n8-20020a170902d2c800b001663868e2c2so10616541plc.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oQIyu4cKVU7oWo40WjhPnpMJD4dvWtcQq5pq7XDuQOU=;
        b=ARir2B30o4f11vJ7UT3Kl+yHxYDlXXGc5vmkBlGwJYi3MnGrxeVWYVR6mhh3V7qKEj
         TOVYfBeN/c+RxvuqAk7goUoTwGZ/VywDY6s5rg3U8OynlZGsRKbf2nj60Xri4JKL/LtJ
         iAxsoWVW//HuBtv1W1aEk5DqrkoX1iFZ4HhF7W16LSnqqUFr5S6pLmbDgRN+REy/MLOm
         m4ukBRPjgPWOaOPoEmdf8Q8IYFM4rQgWu7WRPAgBhZYS6XMb0c0joi1eAXM12sFG5vdZ
         vmZb0tYlbsYprxgd0dWqGSYgxhsVq22EHGPHSkeb9Tu7FZNMVcmHq5FvyKM+Ywia9Z82
         4hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oQIyu4cKVU7oWo40WjhPnpMJD4dvWtcQq5pq7XDuQOU=;
        b=sKseW81IsrIsiqbvMxsdPjaNhXL5IZu6/j75OB9NK1EP1Ll9lCij2WnqXAh0OLZ+uy
         aivDlA5HGse1ThAP4mdlh13L5bEJ21hMcSlPYb5KAWYBeYZBDPw5aYo4fYN0r3Vp7l59
         diW1JrbCIyaV40eJl/i6ZrMl8n09k/f/OINBuKHjLlcnUM5zeKzmADGcwi7L26eWd+Ib
         Z8MC02ExpZ/JAViH0JfqugsDX9PS00Tlm4g4BZfbNhLnsJHlK68JknOeEquW9bwx2aJI
         xUsch+deRXTO/FZA5KaiPy0dZ2N4dwTjqnDF0yJTk6F4BX/+Te4k4qOIihqD9UDFYbeh
         ZldQ==
X-Gm-Message-State: AOAM531CTudpb/rCxnPvmEbbBEnnTW+IIhIy2FKVNcHJrayODi/GbsSU
        pxf7M3kkY/7qea6rPw172gjDxSsl+nZq
X-Google-Smtp-Source: ABdhPJzRXDhD76XhB04n4Hh4hY55zSkHem5rzfZtiBOp2wtOwQjlRss8XJvcJmyGmYGXa98ts3iv1HWm43bH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2386:b0:51c:3ca7:b185 with SMTP
 id f6-20020a056a00238600b0051c3ca7b185mr10563849pfc.8.1654728255109; Wed, 08
 Jun 2022 15:44:15 -0700 (PDT)
Date:   Wed,  8 Jun 2022 15:43:52 -0700
In-Reply-To: <20220608224353.1176079-1-irogers@google.com>
Message-Id: <20220608224353.1176079-4-irogers@google.com>
Mime-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 3/4] perf test: Remove x86 rdpmc test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test has been superseded by test_stat_user_read in:
tools/lib/perf/tests/test-evsel.c
The updated test doesn't divide-by-0 when running time of a counter is
0. It also supports ARM64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 3 files changed, 185 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 28d793390198..70b5bcbc15df 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -2,7 +2,6 @@ perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
-perf-y += rdpmc.o
 perf-y += sample-parsing.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 64fb73d14d2f..04018b8aa85b 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -3,7 +3,6 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-DEFINE_SUITE("x86 rdpmc", rdpmc);
 #ifdef HAVE_AUXTRACE_SUPPORT
 DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
 DEFINE_SUITE("Intel PT packet decoder", intel_pt_pkt_decoder);
@@ -14,7 +13,6 @@ DEFINE_SUITE("x86 bp modify", bp_modify);
 DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 
 struct test_suite *arch_tests[] = {
-	&suite__rdpmc,
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
diff --git a/tools/perf/arch/x86/tests/rdpmc.c b/tools/perf/arch/x86/tests/rdpmc.c
deleted file mode 100644
index 498413ad9c97..000000000000
--- a/tools/perf/arch/x86/tests/rdpmc.c
+++ /dev/null
@@ -1,182 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <errno.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include "perf-sys.h"
-#include "debug.h"
-#include "tests/tests.h"
-#include "cloexec.h"
-#include "event.h"
-#include <internal/lib.h> // page_size
-#include "arch-tests.h"
-
-static u64 rdpmc(unsigned int counter)
-{
-	unsigned int low, high;
-
-	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 rdtsc(void)
-{
-	unsigned int low, high;
-
-	asm volatile("rdtsc" : "=a" (low), "=d" (high));
-
-	return low | ((u64)high) << 32;
-}
-
-static u64 mmap_read_self(void *addr)
-{
-	struct perf_event_mmap_page *pc = addr;
-	u32 seq, idx, time_mult = 0, time_shift = 0;
-	u64 count, cyc = 0, time_offset = 0, enabled, running, delta;
-
-	do {
-		seq = pc->lock;
-		barrier();
-
-		enabled = pc->time_enabled;
-		running = pc->time_running;
-
-		if (enabled != running) {
-			cyc = rdtsc();
-			time_mult = pc->time_mult;
-			time_shift = pc->time_shift;
-			time_offset = pc->time_offset;
-		}
-
-		idx = pc->index;
-		count = pc->offset;
-		if (idx)
-			count += rdpmc(idx - 1);
-
-		barrier();
-	} while (pc->lock != seq);
-
-	if (enabled != running) {
-		u64 quot, rem;
-
-		quot = (cyc >> time_shift);
-		rem = cyc & (((u64)1 << time_shift) - 1);
-		delta = time_offset + quot * time_mult +
-			((rem * time_mult) >> time_shift);
-
-		enabled += delta;
-		if (idx)
-			running += delta;
-
-		quot = count / running;
-		rem = count % running;
-		count = quot * enabled + (rem * enabled) / running;
-	}
-
-	return count;
-}
-
-/*
- * If the RDPMC instruction faults then signal this back to the test parent task:
- */
-static void segfault_handler(int sig __maybe_unused,
-			     siginfo_t *info __maybe_unused,
-			     void *uc __maybe_unused)
-{
-	exit(-1);
-}
-
-static int __test__rdpmc(void)
-{
-	volatile int tmp = 0;
-	u64 i, loops = 1000;
-	int n;
-	int fd;
-	void *addr;
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_HARDWARE,
-		.config = PERF_COUNT_HW_INSTRUCTIONS,
-		.exclude_kernel = 1,
-	};
-	u64 delta_sum = 0;
-        struct sigaction sa;
-	char sbuf[STRERR_BUFSIZE];
-
-	sigfillset(&sa.sa_mask);
-	sa.sa_sigaction = segfault_handler;
-	sa.sa_flags = 0;
-	sigaction(SIGSEGV, &sa, NULL);
-
-	fd = sys_perf_event_open(&attr, 0, -1, -1,
-				 perf_event_open_cloexec_flag());
-	if (fd < 0) {
-		pr_err("Error: sys_perf_event_open() syscall returned "
-		       "with %d (%s)\n", fd,
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
-	}
-
-	addr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (addr == (void *)(-1)) {
-		pr_err("Error: mmap() syscall returned with (%s)\n",
-		       str_error_r(errno, sbuf, sizeof(sbuf)));
-		goto out_close;
-	}
-
-	for (n = 0; n < 6; n++) {
-		u64 stamp, now, delta;
-
-		stamp = mmap_read_self(addr);
-
-		for (i = 0; i < loops; i++)
-			tmp++;
-
-		now = mmap_read_self(addr);
-		loops *= 10;
-
-		delta = now - stamp;
-		pr_debug("%14d: %14Lu\n", n, (long long)delta);
-
-		delta_sum += delta;
-	}
-
-	munmap(addr, page_size);
-	pr_debug("   ");
-out_close:
-	close(fd);
-
-	if (!delta_sum)
-		return -1;
-
-	return 0;
-}
-
-int test__rdpmc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	int status = 0;
-	int wret = 0;
-	int ret;
-	int pid;
-
-	pid = fork();
-	if (pid < 0)
-		return -1;
-
-	if (!pid) {
-		ret = __test__rdpmc();
-
-		exit(ret);
-	}
-
-	wret = waitpid(pid, &status, 0);
-	if (wret < 0 || status)
-		return -1;
-
-	return 0;
-}
-- 
2.36.1.255.ge46751e96f-goog

