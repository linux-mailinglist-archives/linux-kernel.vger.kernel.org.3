Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05D34610F4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbhK2JUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:20:35 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100]:50387 "EHLO
        esa12.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244608AbhK2JSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:18:34 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 04:18:33 EST
IronPort-SDR: S8KD/lbdg+ll88AHZyTdrlgam7AIbg7Ucvb+SaoBYEtYwEeXenfxLuGSf39Tac0fPXU6i4s8hN
 FHFJBxHtQO/D62xu+dTBmipvVCyj9EW4BoW4WyuDzXOi0GyYgPlBA0GGZF7bX6Cjwkz6BVGI4G
 SYehIdo2Ku1+jlRCZ7826r0G8WKY724n3qDt93cZNI3J3aa+miSPXtD+irrA2bnZgg21Aq+DNH
 sdi7VgSoQ/L0dFOEJPF+psP7twg9JXmi74rFTEW604h6dvopaDAxlQwb9XUaw3WJ4tQ9zkCpSx
 vbdJe7KnmigD+w0qo4omA+f8
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="34056482"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="34056482"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Nov 2021 18:07:59 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id AA611F30DD;
        Mon, 29 Nov 2021 18:08:00 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D2D9ED9948;
        Mon, 29 Nov 2021 18:07:59 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id B1F7D4004C629;
        Mon, 29 Nov 2021 18:07:59 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v4 3/3] libperf tests: Add test_stat_multiplexing test
Date:   Mon, 29 Nov 2021 18:06:27 +0900
Message-Id: <20211129090627.592149-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
References: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
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
  Event  0 -- Raw count = 299302036, run = 288430205, enable = 486235490
           Scaled count = 504563217 (59.32%, 288430205/486235490)
  Event  1 -- Raw count = 298545418, run = 289425078, enable = 486232769
           Scaled count = 501554897 (59.52%, 289425078/486232769)
  Event  2 -- Raw count = 298838327, run = 290411278, enable = 486229222
           Scaled count = 500338444 (59.73%, 290411278/486229222)
  Event  3 -- Raw count = 299382984, run = 291406006, enable = 486225338
           Scaled count = 499535320 (59.93%, 291406006/486225338)
  Event  4 -- Raw count = 300119283, run = 292411181, enable = 486220615
           Scaled count = 499037628 (60.14%, 292411181/486220615)
  Event  5 -- Raw count = 300255891, run = 293404372, enable = 486215261
           Scaled count = 497569260 (60.34%, 293404372/486215261)
  Event  6 -- Raw count = 302390604, run = 294222082, enable = 486209147
           Scaled count = 499707828 (60.51%, 294222082/486209147)
  Event  7 -- Raw count = 303524473, run = 294214550, enable = 486202374
           Scaled count = 501587427 (60.51%, 294214550/486202374)
  Event  8 -- Raw count = 304282474, run = 294206637, enable = 486194647
           Scaled count = 502845590 (60.51%, 294206637/486194647)
  Event  9 -- Raw count = 303969062, run = 293818554, enable = 486185895
           Scaled count = 502982090 (60.43%, 293818554/486185895)
  Event 10 -- Raw count = 303784907, run = 292808731, enable = 486174252
           Scaled count = 504398893 (60.23%, 292808731/486174252)
  Event 11 -- Raw count = 304129077, run = 291818946, enable = 486164475
           Scaled count = 506672904 (60.02%, 291818946/486164475)
  Event 12 -- Raw count = 302677227, run = 290819976, enable = 486155254
           Scaled count = 505976673 (59.82%, 290819976/486155254)
  Event 13 -- Raw count = 301748186, run = 289821793, enable = 486146028
           Scaled count = 506151316 (59.62%, 289821793/486146028)
  Event 14 -- Raw count = 300216852, run = 288823624, enable = 486136825
           Scaled count = 505313468 (59.41%, 288823624/486136825)
     Expected: 501623296
     High: 506672904   Low:  299302036   Average:  502548997
     Average Error = 0.18%
  OK
  - running tests/test-evsel.c...
          loop = 65536, count = 354844
          loop = 131072, count = 693386
          loop = 262144, count = 1339140
          loop = 524288, count = 2726813
          loop = 1048576, count = 5263081
          loop = 65536, count = 472935
          loop = 131072, count = 1018641
          loop = 262144, count = 1840393
          loop = 524288, count = 3349520
          loop = 1048576, count = 6759085
  OK
  running dynamic:
  - running tests/test-cpumap.c...OK
  - running tests/test-threadmap.c...OK
  - running tests/test-evlist.c...
  Event  0 -- Raw count = 297934481, run = 297856898, enable = 501847789
           Scaled count = 501978505 (59.35%, 297856898/501847789)
  Event  1 -- Raw count = 298651420, run = 297970032, enable = 501845063
           Scaled count = 502992665 (59.37%, 297970032/501845063)
  Event  2 -- Raw count = 299731258, run = 298965119, enable = 501841526
           Scaled count = 503127563 (59.57%, 298965119/501841526)
  Event  3 -- Raw count = 300644680, run = 299960013, enable = 501837664
           Scaled count = 502983122 (59.77%, 299960013/501837664)
  Event  4 -- Raw count = 301854645, run = 300947092, enable = 501833170
           Scaled count = 503346526 (59.97%, 300947092/501833170)
  Event  5 -- Raw count = 303228020, run = 302371294, enable = 501827577
           Scaled count = 503249433 (60.25%, 302371294/501827577)
  Event  6 -- Raw count = 304162593, run = 303363734, enable = 501820925
           Scaled count = 503142388 (60.45%, 303363734/501820925)
  Event  7 -- Raw count = 304802876, run = 304254160, enable = 501814005
           Scaled count = 502719016 (60.63%, 304254160/501814005)
  Event  8 -- Raw count = 304797825, run = 304246193, enable = 501805969
           Scaled count = 502715798 (60.63%, 304246193/501805969)
  Event  9 -- Raw count = 304678040, run = 303884090, enable = 501797023
           Scaled count = 503108054 (60.56%, 303884090/501797023)
  Event 10 -- Raw count = 303209569, run = 302886553, enable = 501785047
           Scaled count = 502320180 (60.36%, 302886553/501785047)
  Event 11 -- Raw count = 301801701, run = 301456719, enable = 501775302
           Scaled count = 502349525 (60.08%, 301456719/501775302)
  Event 12 -- Raw count = 300744781, run = 300457620, enable = 501765832
           Scaled count = 502245392 (59.88%, 300457620/501765832)
  Event 13 -- Raw count = 299656316, run = 299458825, enable = 501756687
           Scaled count = 502087592 (59.68%, 299458825/501756687)
  Event 14 -- Raw count = 298616379, run = 298460087, enable = 501747345
           Scaled count = 502010090 (59.48%, 298460087/501747345)
     Expected: 501618012
     High: 503346526   Low:  297934481   Average:  502691723
     Average Error = 0.21%
  OK
  - running tests/test-evsel.c...
          loop = 65536, count = 328183
          loop = 131072, count = 681853
          loop = 262144, count = 1334936
          loop = 524288, count = 2702197
          loop = 1048576, count = 5294233
          loop = 65536, count = 486498
          loop = 131072, count = 928179
          loop = 262144, count = 1921944
          loop = 524288, count = 3687007
          loop = 1048576, count = 6721087
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

