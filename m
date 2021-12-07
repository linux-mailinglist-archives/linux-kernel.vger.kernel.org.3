Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC92246B5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhLGI2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:52 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253]:44566 "EHLO
        esa8.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232641AbhLGI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:46 -0500
IronPort-SDR: sC5J9djW4XUpjl0es6ITA0OwxJ1qbmUEUOOLtomqnmxdzBHcsAnJtD7gNHR8hrm0eUzfD1+2jb
 5ichOCvbr4lqlJbA+hBRvSFs4hHOFfu/LK9foMXB+bSSRWTRh1cewbNqpDubewC6pPQTkUdgxG
 XZcF6U6mUI2EIZ2X/JHKXY/l7cew6rWiNyr+WwLUG1qPeilCEg2rirjvSqUJlRgQ+w6mr1lY/L
 KEQIHBpPU8CkAwiGO962tNIR5sKW7bZPOQQnOYzfKkFYZkhQnJ2AX8rdesGjlapFfEg3+RXsMw
 Yzf0EABnoI0LIH0x4z//cQZ+
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="43417981"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="43417981"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Dec 2021 17:25:12 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 75065122D1E;
        Tue,  7 Dec 2021 17:25:12 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A35121C16C;
        Tue,  7 Dec 2021 17:25:11 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 930D640061D47;
        Tue,  7 Dec 2021 17:25:11 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v5 3/3] libperf tests: Add test_stat_multiplexing test
Date:   Tue,  7 Dec 2021 17:22:45 +0900
Message-Id: <20211207082245.604654-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
References: <20211207082245.604654-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Adds a test for a counter obtained using read() system call during
multiplexing.

Committer testing:

  $ sudo make tests -C ./tools/lib/perf V=1
    make[1]: Entering directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'
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
    Event  0 -- Raw count = 297991478, run = 289848838, enable = 487833990
             Scaled count = 501538569 (59.42%, 289848838/487833990)
    Event  1 -- Raw count = 298202297, run = 289842833, enable = 487828457
             Scaled count = 501898097 (59.41%, 289842833/487828457)
    Event  2 -- Raw count = 298838708, run = 290229672, enable = 487824119
             Scaled count = 502294367 (59.49%, 290229672/487824119)
    Event  3 -- Raw count = 299636384, run = 291223455, enable = 487819672
             Scaled count = 501911916 (59.70%, 291223455/487819672)
    Event  4 -- Raw count = 301039452, run = 292217461, enable = 487814690
             Scaled count = 502541725 (59.90%, 292217461/487814690)
    Event  5 -- Raw count = 301835436, run = 293210150, enable = 487808943
             Scaled count = 502158690 (60.11%, 293210150/487808943)
    Event  6 -- Raw count = 304060357, run = 294621959, enable = 487802339
             Scaled count = 503429390 (60.40%, 294621959/487802339)
    Event  7 -- Raw count = 305283685, run = 295613727, enable = 487794884
             Scaled count = 503751369 (60.60%, 295613727/487794884)
    Event  8 -- Raw count = 305475229, run = 296220779, enable = 487786737
             Scaled count = 503026039 (60.73%, 296220779/487786737)
    Event  9 -- Raw count = 305141917, run = 295602628, enable = 487777537
             Scaled count = 503518435 (60.60%, 295602628/487777537)
    Event 10 -- Raw count = 303495328, run = 294604639, enable = 487765440
             Scaled count = 502485407 (60.40%, 294604639/487765440)
    Event 11 -- Raw count = 302667296, run = 293605945, enable = 487755909
             Scaled count = 502809171 (60.20%, 293605945/487755909)
    Event 12 -- Raw count = 301051839, run = 292174676, enable = 487746418
             Scaled count = 502565650 (59.90%, 292174676/487746418)
    Event 13 -- Raw count = 299861567, run = 291175260, enable = 487737096
             Scaled count = 502287213 (59.70%, 291175260/487737096)
    Event 14 -- Raw count = 299075896, run = 290177159, enable = 487727626
             Scaled count = 502684557 (59.50%, 290177159/487727626)
       Expected: 501627347
       High: 503751369   Low:  297991478   Average:  502593373
       Average Error = 0.19%
    OK
    - running tests/test-evsel.c...
            loop = 65536, count = 328182
            loop = 131072, count = 660212
            loop = 262144, count = 1344434
            loop = 524288, count = 2665921
            loop = 1048576, count = 5292260
            loop = 65536, count = 525695
            loop = 131072, count = 1039025
            loop = 262144, count = 2022367
            loop = 524288, count = 3807896
            loop = 1048576, count = 7026126
    OK
    running dynamic:
    - running tests/test-cpumap.c...OK
    - running tests/test-threadmap.c...OK
    - running tests/test-evlist.c...
    Event  0 -- Raw count = 301261995, run = 297151831, enable = 496168657
             Scaled count = 503031594 (59.89%, 297151831/496168657)
    Event  1 -- Raw count = 301949118, run = 298145404, enable = 496165648
             Scaled count = 502495687 (60.09%, 298145404/496165648)
    Event  2 -- Raw count = 301996384, run = 298170976, enable = 496162496
             Scaled count = 502528051 (60.10%, 298170976/496162496)
    Event  3 -- Raw count = 302266025, run = 298167975, enable = 496158896
             Scaled count = 502978152 (60.10%, 298167975/496158896)
    Event  4 -- Raw count = 302326299, run = 298162895, enable = 496154322
             Scaled count = 503082383 (60.09%, 298162895/496154322)
    Event  5 -- Raw count = 301984135, run = 298160272, enable = 496149190
             Scaled count = 502512232 (60.09%, 298160272/496149190)
    Event  6 -- Raw count = 302227412, run = 298150911, enable = 496142936
             Scaled count = 502926504 (60.09%, 298150911/496142936)
    Event  7 -- Raw count = 302124492, run = 298154219, enable = 496135963
             Scaled count = 502742595 (60.10%, 298154219/496135963)
    Event  8 -- Raw count = 302044822, run = 298146667, enable = 496128143
             Scaled count = 502614830 (60.09%, 298146667/496128143)
    Event  9 -- Raw count = 301592560, run = 298031312, enable = 496119275
             Scaled count = 502047523 (60.07%, 298031312/496119275)
    Event 10 -- Raw count = 300695500, run = 297033588, enable = 496108098
             Scaled count = 502224255 (59.87%, 297033588/496108098)
    Event 11 -- Raw count = 300948104, run = 296983965, enable = 496098673
             Scaled count = 502720593 (59.86%, 296983965/496098673)
    Event 12 -- Raw count = 300864958, run = 296983483, enable = 496089228
             Scaled count = 502572948 (59.86%, 296983483/496089228)
    Event 13 -- Raw count = 301117898, run = 296973717, enable = 496079647
             Scaled count = 503002292 (59.86%, 296973717/496079647)
    Event 14 -- Raw count = 301224163, run = 296977949, enable = 496070093
             Scaled count = 503162942 (59.87%, 296977949/496070093)
       Expected: 501650928
       High: 503162942   Low:  301261995   Average:  502709505
       Average Error = 0.21%
    OK
    - running tests/test-evsel.c...
            loop = 65536, count = 328183
            loop = 131072, count = 740142
            loop = 262144, count = 1339999
            loop = 524288, count = 2696817
            loop = 1048576, count = 5294518
            loop = 65536, count = 517941
            loop = 131072, count = 871035
            loop = 262144, count = 1835805
            loop = 524288, count = 3391920
            loop = 1048576, count = 6891764
    OK
    make[1]: Leaving directory '/home/nakamura/build_work/build_kernel/linux-kernel/linux/tools/lib/perf'

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/tests/test-evlist.c | 157 +++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index ce91a582f0e4..064edd0e995c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -21,6 +21,9 @@
 #include "tests.h"
 #include <internal/evsel.h>
 
+#define EVENT_NUM 15
+#define WAIT_COUNT 100000000UL
+
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
 {
@@ -413,6 +416,159 @@ static int test_mmap_cpus(void)
 	return 0;
 }
 
+static double display_error(long long average,
+			    long long high,
+			    long long low,
+			    long long expected)
+{
+	double error;
+
+	error = (((double)average - expected) / expected) * 100.0;
+
+	__T_VERBOSE("   Expected: %lld\n", expected);
+	__T_VERBOSE("   High: %lld   Low:  %lld   Average:  %lld\n",
+		    high, low, average);
+
+	__T_VERBOSE("   Average Error = %.2f%%\n", error);
+
+	return error;
+}
+
+static int test_stat_multiplexing(void)
+{
+	struct perf_counts_values expected_counts = { .val = 0 };
+	struct perf_counts_values counts[EVENT_NUM] = {{ .val = 0 },};
+	struct perf_thread_map *threads;
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.type	     = PERF_TYPE_HARDWARE,
+		.config	     = PERF_COUNT_HW_INSTRUCTIONS,
+		.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+			       PERF_FORMAT_TOTAL_TIME_RUNNING,
+		.disabled    = 1,
+	};
+	int err, i, nonzero = 0;
+	unsigned long count;
+	long long max = 0, min = 0, avg = 0;
+	double error = 0.0;
+	__s8 scaled = 0;
+
+	/* read for non-multiplexing event count */
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	err = perf_evsel__enable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	/* wait loop */
+	count = WAIT_COUNT;
+	while (count--)
+		;
+
+	perf_evsel__read(evsel, 0, 0, &expected_counts);
+	__T("failed to read value for evsel", expected_counts.val != 0);
+	__T("failed to read non-multiplexing event count",
+	    expected_counts.ena == expected_counts.run);
+
+	err = perf_evsel__disable(evsel);
+	__T("failed to enable evsel", err == 0);
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+
+	/* read for multiplexing event count */
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	for (i = 0; i < EVENT_NUM; i++) {
+		evsel = perf_evsel__new(&attr);
+		__T("failed to create evsel", evsel);
+
+		perf_evlist__add(evlist, evsel);
+	}
+	perf_evlist__set_maps(evlist, NULL, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evsel", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	/* wait loop */
+	count = WAIT_COUNT;
+	while (count--)
+		;
+
+	i = 0;
+	perf_evlist__for_each_evsel(evlist, evsel) {
+		perf_evsel__read(evsel, 0, 0, &counts[i]);
+		__T("failed to read value for evsel", counts[i].val != 0);
+		i++;
+	}
+
+	perf_evlist__disable(evlist);
+
+	min = counts[0].val;
+	for (i = 0; i < EVENT_NUM; i++) {
+		__T_VERBOSE("Event %2d -- Raw count = %lu, run = %lu, enable = %lu\n",
+			    i, counts[i].val, counts[i].run, counts[i].ena);
+
+		perf_counts_values__scale(&counts[i], true, &scaled);
+		if (scaled == 1) {
+			__T_VERBOSE("\t Scaled count = %lu (%.2lf%%, %lu/%lu)\n",
+				    counts[i].val,
+				    (double)counts[i].run / (double)counts[i].ena * 100.0,
+				    counts[i].run, counts[i].ena);
+		} else if (scaled == -1) {
+			__T_VERBOSE("\t Not Runnnig\n");
+		} else {
+			__T_VERBOSE("\t Not Scaling\n");
+		}
+
+		if (counts[i].val > max)
+			max = counts[i].val;
+
+		if (counts[i].val < min)
+			min = counts[i].val;
+
+		avg += counts[i].val;
+
+		if (counts[i].val != 0)
+			nonzero++;
+	}
+
+	if (nonzero != 0)
+		avg = avg / nonzero;
+	else
+		avg = 0;
+
+	error = display_error(avg, max, min, expected_counts.val);
+
+	__T("Error out of range!", ((error <= 1.0) && (error >= -1.0)));
+
+	perf_evlist__close(evlist);
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
 int test_evlist(int argc, char **argv)
 {
 	__T_START;
@@ -424,6 +580,7 @@ int test_evlist(int argc, char **argv)
 	test_stat_thread_enable();
 	test_mmap_thread();
 	test_mmap_cpus();
+	test_stat_multiplexing();
 
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
-- 
2.25.1

