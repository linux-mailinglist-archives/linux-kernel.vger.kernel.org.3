Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3450B450
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446189AbiDVJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446167AbiDVJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:02 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5976453B5F;
        Fri, 22 Apr 2022 02:44:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="58614522"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="58614522"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:06 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BF644D6478;
        Fri, 22 Apr 2022 18:44:05 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CBC60D9462;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 8B9E040483741;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 7/7] libperf test: Add test_stat_overflow_event()
Date:   Fri, 22 Apr 2022 18:38:33 +0900
Message-Id: <20220422093833.340873-8-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test to check overflowed events.

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

  Event  0 -- overflow flag = 0x1, POLL_UP = 1, other signal event = 0
  Event  1 -- overflow flag = 0x2, POLL_UP = 1, other signal event = 0
  Event  2 -- overflow flag = 0x4, POLL_UP = 1, other signal event = 0
  Event  3 -- overflow flag = 0x8, POLL_UP = 1, other signal event = 0
  OK
  - running tests/test-evsel.c...

  <SNIP>

  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...

  <SNIP>

  Event  0 -- overflow flag = 0x1, POLL_UP = 1, other signal event = 0
  Event  1 -- overflow flag = 0x2, POLL_UP = 1, other signal event = 0
  Event  2 -- overflow flag = 0x4, POLL_UP = 1, other signal event = 0
  Event  3 -- overflow flag = 0x8, POLL_UP = 1, other signal event = 0
  OK
  - running tests/test-evsel.c...

  <SNIP>

  OK
  make: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 111 +++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index d8f9493cd4d1..587364851432 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -5,6 +5,8 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
 #include <linux/perf_event.h>
 #include <linux/limits.h>
 #include <sys/types.h>
@@ -24,6 +26,13 @@
 #define EVENT_NUM 15
 #define WAIT_COUNT 100000000UL
 
+static unsigned int overflow_flag;
+static struct signal_counts {
+	int hup;
+	int others;
+} sig_count;
+static struct perf_evlist *s_evlist;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -570,6 +579,107 @@ static int test_stat_multiplexing(void)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	struct perf_evsel *evsel;
+	int i = 0;
+
+	perf_evlist__for_each_evsel(s_evlist, evsel) {
+		if (perf_evsel__has_fd(evsel, info->si_fd)) {
+			if (info->si_code == POLL_HUP)
+				sig_count.hup++;
+			else
+				sig_count.others++;
+
+			overflow_flag = (1U << i);
+			return;
+		}
+		i++;
+	}
+
+	__T_VERBOSE("Failed to get fd of overflowed event");
+}
+
+static int test_stat_overflow_event(void)
+{
+	static struct sigaction sig;
+
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_SOFTWARE,
+		.config		= PERF_COUNT_SW_CPU_CLOCK,
+		.sample_type	= PERF_SAMPLE_PERIOD,
+		.sample_period	= 100000,
+		.disabled	= 1,
+	};
+	int err, i, event_num = 4;
+
+	LIBPERF_OPTS(perf_evsel_open_opts, opts,
+		     .open_flags = PERF_FLAG_FD_CLOEXEC,
+		     .flags	 = (O_RDWR | O_NONBLOCK | O_ASYNC),
+		     .signal	 = SIGRTMIN + 1,
+		     .owner_type = F_OWNER_PID,
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
+	s_evlist = perf_evlist__new();
+	__T("failed to create evlist", s_evlist);
+
+	for (i = 0; i < event_num; i++) {
+		evsel = perf_evsel__new(&attr);
+		__T("failed to create evsel", evsel);
+
+		perf_evlist__add(s_evlist, evsel);
+	}
+
+	perf_evlist__set_maps(s_evlist, NULL, threads);
+
+	err = perf_evlist__open_opts(s_evlist, &opts);
+	__T("failed to open evlist", err == 0);
+
+	i = 0;
+	perf_evlist__for_each_evsel(s_evlist, evsel) {
+		volatile unsigned int wait_count = WAIT_COUNT;
+
+		overflow_flag = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
+
+		err = perf_evsel__refresh(evsel, 1);
+		__T("failed to refresh evsel", err == 0);
+
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("Event %2d -- overflow flag = %#x, ",
+			    i, overflow_flag);
+		__T_VERBOSE("POLL_HUP = %d, other signal event = %d\n",
+			    sig_count.hup, sig_count.others);
+
+		__T("unexpected event overflow detected", overflow_flag && (1U << i));
+		__T("unexpected signal event detected",
+		    sig_count.hup == 1 && sig_count.others == 0);
+
+		i++;
+	}
+
+	perf_evlist__close(s_evlist);
+	perf_evlist__delete(s_evlist);
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -582,6 +692,7 @@ int test_evlist(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 	test_stat_multiplexing();
+	test_stat_overflow_event();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.25.1

