Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE8F4E6D62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbiCYEpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358280AbiCYEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:45:09 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA16948C;
        Thu, 24 Mar 2022 21:43:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="67833486"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="67833486"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 36C64E3E0F;
        Fri, 25 Mar 2022 13:43:20 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4041214ED7;
        Fri, 25 Mar 2022 13:43:19 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id EF5E0403FAABB;
        Fri, 25 Mar 2022 13:43:18 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 5/7] libperf: Add perf_evsel__check_overflow() functions
Date:   Fri, 25 Mar 2022 13:38:27 +0900
Message-Id: <20220325043829.224045-6-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
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

Add the following functions:

  perf_evsel__check_overflow
  perf_evsel__check_overflow_cpu

to check for perf events with the file descriptor specified in the
argument.
These functions can be used in signal handlers to check overflow.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  3 +++
 tools/lib/perf/evsel.c                   | 34 ++++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  4 +++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 700c1ce15159..4ae8d738b948 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -165,6 +165,9 @@ SYNOPSIS
                               int cpu_map_idx);
   int perf_evsel__period(struct perf_evsel *evsel, int period);
   int perf_evsel__period_cpu(struct perf_evsel *evsel, int period, int cpu_map_idx);
+  int perf_evsel__check_overflow(struct perf_evsel *evsel, int sig_fd, bool *overflow);
+  int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel, int cpu_map_idx,
+                                     int sig_fd, bool *overflow);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index db9b7274feb5..6ff3cf692df3 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -616,3 +616,37 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	return err;
 }
+
+int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel, int cpu_map_idx,
+				   int sig_fd, bool *overflow)
+{
+	int thread;
+	int *fd;
+	int err = 0;
+
+	if (!overflow)
+		return -EINVAL;
+
+	*overflow = false;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd) && !err; ++thread) {
+		fd = FD(evsel, cpu_map_idx, thread);
+		if (sig_fd <= 0 || !fd || *fd < 0)
+			err = -EINVAL;
+
+		if (sig_fd == *fd)
+			*overflow = true;
+	}
+
+	return err;
+}
+
+int perf_evsel__check_overflow(struct perf_evsel *evsel, int sig_fd, bool *overflow)
+{
+	int cpu_map_idx;
+	int err = 0;
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd) && !err; cpu_map_idx++)
+		err = perf_evsel__check_overflow_cpu(evsel, cpu_map_idx, sig_fd, overflow);
+	return err;
+}
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index ecf30bc6303f..d686cfbd88a6 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -74,5 +74,9 @@ LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
 				      struct perf_cpu_map *cpus,
 				      struct perf_thread_map *threads,
 				      struct perf_evsel_open_opts *opts);
+LIBPERF_API int perf_evsel__check_overflow(struct perf_evsel *evsel, int sig_fd,
+					   bool *overflow);
+LIBPERF_API int perf_evsel__check_overflow_cpu(struct perf_evsel *evsel,
+					       int cpu_map_idx, int sig_fd, bool *overflow);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 534614fbbb26..981eade34237 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -37,6 +37,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
+		perf_evsel__check_overflow;
+		perf_evsel__check_overflow_cpu;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
-- 
2.25.1

