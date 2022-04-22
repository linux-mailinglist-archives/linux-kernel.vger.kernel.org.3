Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E450B451
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446207AbiDVJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446171AbiDVJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:03 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973253B54;
        Fri, 22 Apr 2022 02:44:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="70646202"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="70646202"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:07 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 306CDC68AC;
        Fri, 22 Apr 2022 18:44:05 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AEF03014A;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 1020C40487FBB;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 5/7] libperf: Add perf_evsel__{refresh, period}() functions
Date:   Fri, 22 Apr 2022 18:38:31 +0900
Message-Id: <20220422093833.340873-6-nakamura.shun@fujitsu.com>
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

Add the following functions:

  perf_evsel__refresh()
  perf_evsel__period()

to set the over flow limit and period.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 44 ++++++++++++++++++++----
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index bc7881348c76..773224a96bd3 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -162,6 +162,8 @@ SYNOPSIS
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+  int perf_evsel__period(struct perf_evsel *evsel, int period);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 446934c0e5e5..578ae0050036 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -334,7 +334,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -357,7 +357,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable(struct perf_evsel *evsel)
@@ -366,13 +366,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
 	return err;
 }
 
 int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
@@ -381,7 +381,39 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh(struct perf_evsel *evsel, int refresh)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, i);
+	return err;
+}
+
+int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
+{
+	struct perf_event_attr *attr;
+	int i;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+	if (!attr)
+		return -EINVAL;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+					    (unsigned long)&period, i);
+		if (err)
+			return err;
+	}
+
+	attr->sample_period = period;
+
 	return err;
 }
 
@@ -392,7 +424,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 19a7993d9021..2c5e52c17d28 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -60,6 +60,8 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index b2ace16bbc32..d97e208c5be8 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -31,6 +31,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__period;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
-- 
2.25.1

