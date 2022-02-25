Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A422B4C4270
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiBYKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiBYKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:37:09 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF161CABD2;
        Fri, 25 Feb 2022 02:36:27 -0800 (PST)
IronPort-SDR: ++KFWPclbV2kMtWtx6h5gXaoRNZ5CNWAsx9OQN6dnscnI07H2JC2xbwghZuVI6jhgPhzOJqtSw
 oB24CwXUnzk8oeQf0qhDz9gqq2AeTpDlXQy9lZyEFyO8wCTEgiw2L6jaWiy8n6FUUrQu5MO8sp
 Kh67xFDrxCSvJ+IdAJppBSvr5xzQ0idwqcpB4TqGbS/lJHgRUGWPTNYRP1hzg+38yFD/pA7NAz
 POYgStWCzk9xMfJyY5o5MG/SSXpygwcBzv23PUdJzRvS5/Vg2G+iDe7695bLjdajTmn0z7f47b
 bRe47eq0WDruQzzMDn5kxSTP
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="43953277"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="43953277"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id F356CC9165;
        Fri, 25 Feb 2022 19:35:22 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 47D15141E9;
        Fri, 25 Feb 2022 19:35:21 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 4106F40124EF0;
        Fri, 25 Feb 2022 19:35:21 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 6/7] libperf test: Add test_stat_overflow()
Date:   Fri, 25 Feb 2022 19:31:13 +0900
Message-Id: <20220225103114.144239-7-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
References: <20220225103114.144239-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Added tests using refresh and period.

Confirmation
 - That the overflow occurs the number of times specified by
   perf_evse__refresh()
 - That the period can be updated by perf_evsel__period()

Committer testing:

  $ sudo make tests -C tools/lib/perf/ V=1
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
          loop = 65536, count = 330818
          loop = 131072, count = 662958
          loop = 262144, count = 1316088
          loop = 524288, count = 2632699
          loop = 1048576, count = 5254501
          loop = 65536, count = 348709
          loop = 131072, count = 694239
          loop = 262144, count = 1370888
          loop = 524288, count = 2744824
          loop = 1048576, count = 5465047
          period = 1000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  OK
  - running tests/test-evsel.c...
          loop = 65536, count = 330819
          loop = 131072, count = 662959
          loop = 262144, count = 1323589
          loop = 524288, count = 2626809
          loop = 1048576, count = 5260090
          loop = 65536, count = 351641
          loop = 131072, count = 697661
          loop = 262144, count = 1373234
          loop = 524288, count = 2743662
          loop = 1048576, count = 5473195
          period = 1000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 1000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
          period = 2000000
          overflow limit = 3, overflow count = 3POLL_IN = 2, POLL_UP = 1, other signal event = 0
  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evsel.c | 110 ++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 89be89afb24d..9232b2f25082 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
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
@@ -8,6 +16,15 @@
 #include <internal/tests.h>
 #include "tests.h"
 
+#define WAIT_COUNT 10000000UL
+static struct signal_counts {
+	int in;
+	int hup;
+	int others;
+	int overflow;
+} sig_count = {0, 0, 0};
+static struct perf_evsel *s_evsel;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -189,6 +206,97 @@ static int test_stat_user_read(int event)
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
+static int test_stat_refresh(int owner)
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
+	int err, i;
+	unsigned int wait_count;
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
+	err = perf_evsel__set_close_on_exec(s_evsel);
+	__T("failed to set PERF_FLAG_FD_CLOEXEC flag to evsel", err == 0);
+
+	err = perf_evsel__open(s_evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	err = perf_evsel__set_signal(s_evsel, owner, SIGIO, &sig);
+	__T("failed to set signal", err == 0);
+
+	for (i = 0; i < 2; i++) {
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
+		wait_count = WAIT_COUNT;
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("\toverflow limit = %d, overflow count = %d",
+			    overflow_limit, sig_count.overflow);
+		__T_VERBOSE("POLL_IN = %d, POLL_UP = %d, other signal event = %d\n",
+			    sig_count.in, sig_count.hup, sig_count.others);
+
+		__T("failed to overflow count", overflow_limit == sig_count.overflow);
+
+		sig_count.in = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+		sig_count.overflow = 0;
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
@@ -200,6 +308,8 @@ int test_evsel(int argc, char **argv)
 	test_stat_thread_enable();
 	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
 	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);
+	test_stat_refresh(F_OWNER_PID);
+	test_stat_refresh(F_OWNER_TID);
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.31.1

