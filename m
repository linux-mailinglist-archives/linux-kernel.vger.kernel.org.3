Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553450B44F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446195AbiDVJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381631AbiDVJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:48:11 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 02:45:14 PDT
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42153731
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:45:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="58751382"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="58751382"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:06 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7A44CCA260;
        Fri, 22 Apr 2022 18:44:05 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 95504E6771;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 502B840487FBC;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 6/7] libperf test: Add test_stat_overflow()
Date:   Fri, 22 Apr 2022 18:38:32 +0900
Message-Id: <20220422093833.340873-7-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added overflow test using refresh and period.

Confirmation
 - That the overflow occurs the number of times specified by
   perf_evse__refresh()
 - That the period can be updated by perf_evsel__period()

Committer testing:

  $ sudo make tests -C ./tools/lib/perf V=1
  make: Entering directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=libperf
  make -C /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/api/ O= libapi.a
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fd obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./fs obj=libapi
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=. obj=tests
  make -f /home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/build/Makefile.build dir=./tests obj=tests
  running static:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...

  <SNIP>

          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3, POLL_IN = 2, POLL_UP = 1, other signal event = 0
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evsel.c | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 89be89afb24d..4de5d5554836 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <stdarg.h>
 #include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
 #include <linux/perf_event.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
@@ -8,6 +13,15 @@
 #include <internal/tests.h>
 #include "tests.h"
 
+#define WAIT_COUNT 10000000UL
+static struct signal_counts {
+	int in;
+	int hup;
+	int others;
+	int overflow;
+} sig_count;
+static struct perf_evsel *s_evsel;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -189,6 +203,98 @@ static int test_stat_user_read(int event)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	switch (info->si_code) {
+	case POLL_IN:
+		sig_count.in++;
+		break;
+	case POLL_HUP:
+		sig_count.hup++;
+		break;
+	default:
+		sig_count.others++;
+	}
+
+	sig_count.overflow++;
+}
+
+static int test_stat_overflow(int owner)
+{
+	static struct sigaction sig;
+	u64 period = 1000000;
+	int overflow_limit = 3;
+
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type           = PERF_TYPE_SOFTWARE,
+		.config         = PERF_COUNT_SW_TASK_CLOCK,
+		.sample_type    = PERF_SAMPLE_PERIOD,
+		.sample_period  = period,
+		.disabled       = 1,
+	};
+	struct perf_event_attr *tmp_attr;
+	int err = 0, i;
+
+	LIBPERF_OPTS(perf_evsel_open_opts, opts,
+		     .open_flags = PERF_FLAG_FD_CLOEXEC,
+		     .flags	 = (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal	 = SIGRTMIN + 1,
+		     .owner_type = owner,
+		     .sig	 = &sig);
+
+	/* setup signal handler */
+	memset(&sig, 0, sizeof(struct sigaction));
+	sig.sa_sigaction = (void *)sig_handler;
+	sig.sa_flags = SA_SIGINFO;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	s_evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", s_evsel);
+
+	err = perf_evsel__open_opts(s_evsel, NULL, threads, &opts);
+	__T("failed to open evsel", err == 0);
+
+	for (i = 0; i < 2; i++) {
+		volatile unsigned int wait_count = WAIT_COUNT;
+
+		sig_count.in = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+		sig_count.overflow = 0;
+
+		period = period << i;
+		err = perf_evsel__period(s_evsel, period);
+		__T("failed to period evsel", err == 0);
+
+		tmp_attr = perf_evsel__attr(s_evsel);
+		__T_VERBOSE("\tperiod = %llu\n", tmp_attr->sample_period);
+
+		err = perf_evsel__refresh(s_evsel, overflow_limit);
+		__T("failed to refresh evsel", err == 0);
+
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("\toverflow limit = %d, overflow count = %d, ",
+			    overflow_limit, sig_count.overflow);
+		__T_VERBOSE("POLL_IN = %d, POLL_HUP = %d, other signal event = %d\n",
+			    sig_count.in, sig_count.hup, sig_count.others);
+
+		__T("failed to overflow count", overflow_limit == sig_count.overflow);
+	}
+
+	perf_evsel__close(s_evsel);
+	perf_evsel__delete(s_evsel);
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evsel(int argc, char **argv)
 {
 	__T_START;
@@ -200,6 +306,8 @@ int test_evsel(int argc, char **argv)
 	test_stat_thread_enable();
 	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
 	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
+	test_stat_overflow(F_OWNER_PID);
+	test_stat_overflow(F_OWNER_TID);
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.25.1

