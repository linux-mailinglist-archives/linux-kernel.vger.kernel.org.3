Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7048E4C427D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiBYKhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiBYKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:37:19 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 02:36:31 PST
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE0D1706B;
        Fri, 25 Feb 2022 02:36:31 -0800 (PST)
IronPort-SDR: ZG0eaNRQY9wW3i5IvIav1d/iCpl9u9sfW+DHk3LK7dvewajofUNyfmsrQXzobHmKXBemvQ2/zs
 c3IDjSZsQv35SI9SPnzAZrNOlQVTwJVw1vJJvunmMaQWQ8iY5jKtMWQTYNIfQlw1d0Io6ig3WY
 yydeWBdJcRirQvXPg3jUGt4X4q4xoec6oZ0ud6f3Ubjzs2RABXSP6S8DKpCmGMXNuaxLQGLkM2
 fTx4uLGCIQWgA9kvaxp5fmmewOP05BsqSOWWaAlFBv0WlDCQbIygJqtbpXAJdrX2orLI6LQRiM
 DYSgC7JuMiYy0opmTaP0sWwo
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="52058638"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="52058638"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:24 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DF8FBCA240;
        Fri, 25 Feb 2022 19:35:23 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id ED662D99E7;
        Fri, 25 Feb 2022 19:35:22 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id D5E0D40124EF0;
        Fri, 25 Feb 2022 19:35:22 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 7/7] libperf test: Add test_detect_overflow_event()
Date:   Fri, 25 Feb 2022 19:31:14 +0900
Message-Id: <20220225103114.144239-8-nakamura.shun@fujitsu.com>
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

Add a test to detect overflowed events.

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
 tools/lib/perf/tests/test-evlist.c | 119 +++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index fafc6b0f8687..c0f0109c8b51 100644
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
+} sig_count = { 0, 0 };
+static struct perf_evlist *s_evlist;
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -570,6 +579,115 @@ static int test_stat_multiplexing(void)
 	return 0;
 }
 
+static void sig_handler(int signo, siginfo_t *info, void *uc)
+{
+	int err;
+	int idx = 0;
+	struct perf_evsel *evsel;
+
+	switch (info->si_code) {
+	case POLL_HUP:
+		perf_evlist__for_each_evsel(s_evlist, evsel) {
+			err = perf_evsel__check_fd(evsel, info->si_fd);
+			if (!err) {
+				overflow_flag = (1U << idx);
+				sig_count.hup++;
+				break;
+			}
+			idx++;
+		}
+		break;
+	default:
+		perf_evlist__for_each_evsel(s_evlist, evsel) {
+			err = perf_evsel__check_fd(evsel, info->si_fd);
+			if (!err) {
+				overflow_flag = (1U << idx);
+				sig_count.others++;
+				break;
+			}
+			idx++;
+		}
+	}
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
+		.sample_type    = PERF_SAMPLE_PERIOD,
+		.sample_period  = 100000,
+		.disabled       = 1,
+	};
+	int err, i, event_num = 4;
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
+	s_evlist = perf_evlist__new();
+	__T("failed to create evlist", s_evlist);
+
+	for (i = 0; i < event_num; i++) {
+		evsel = perf_evsel__new(&attr);
+		__T("failed to create evsel", evsel);
+
+		err = perf_evsel__set_close_on_exec(evsel);
+		__T("failed to set PERF_FLAG_FD_CLOEXEC flag to evsel", err == 0);
+
+		perf_evlist__add(s_evlist, evsel);
+	}
+
+	perf_evlist__set_maps(s_evlist, NULL, threads);
+
+	err = perf_evlist__open(s_evlist);
+	__T("failed to open evlist", err == 0);
+
+	i = 0;
+	perf_evlist__for_each_evsel(s_evlist, evsel) {
+		err = perf_evsel__set_signal(evsel, F_OWNER_PID, SIGIO, &sig);
+		__T("failed to set signal", err == 0);
+
+		err = perf_evsel__refresh(evsel, 1);
+		__T("failed to refresh evsel", err == 0);
+
+		wait_count = WAIT_COUNT;
+		while (wait_count--)
+			;
+
+		__T_VERBOSE("Event %2d -- overflow flag = %#x, ",
+			    i, overflow_flag);
+		__T_VERBOSE("POLL_UP = %d, other signal event = %d\n",
+			    sig_count.hup, sig_count.others);
+
+		__T("unexpected event overflow detected", overflow_flag && (1U << i));
+		__T("unexpected signal event detected",
+		    sig_count.hup == 1 && sig_count.others == 0);
+
+		overflow_flag = 0;
+		sig_count.hup = 0;
+		sig_count.others = 0;
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
@@ -582,6 +700,7 @@ int test_evlist(int argc, char **argv)
 	test_mmap_thread();
 	test_mmap_cpus();
 	test_stat_multiplexing();
+	test_stat_overflow_event();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.31.1

