Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992044E6D63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358281AbiCYEpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358265AbiCYEpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:45:04 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F19673EE;
        Thu, 24 Mar 2022 21:43:21 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="55449197"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="55449197"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:19 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 74EB3DB9FB;
        Fri, 25 Mar 2022 13:43:18 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 88F9AC9296;
        Fri, 25 Mar 2022 13:43:17 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 51D91403F02E4;
        Fri, 25 Mar 2022 13:43:17 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 3/7] libperf: Add perf_evsel__{refresh, period}() functions
Date:   Fri, 25 Mar 2022 13:38:25 +0900
Message-Id: <20220325043829.224045-4-nakamura.shun@fujitsu.com>
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

  perf_evsel__refresh()
  perf_evsel__refresh_cpu()
  perf_evsel__period()
  perf_evsel__period_cpu()

to set the over flow limit and period.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  5 ++
 tools/lib/perf/evsel.c                   | 68 +++++++++++++++++++++---
 tools/lib/perf/include/perf/evsel.h      |  5 ++
 tools/lib/perf/libperf.map               |  4 ++
 4 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 32c5051c24eb..ae55e62fc4ce 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -146,6 +146,11 @@ SYNOPSIS
   int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+  int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+  int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh,
+                              int cpu_map_idx);
+  int perf_evsel__period(struct perf_evsel *evsel, int period);
+  int perf_evsel__period_cpu(struct perf_evsel *evsel, int period, int cpu_map_idx);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 6640a333e6d9..b17842581dea 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -330,7 +330,7 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 }
 
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
-				 int ioc,  void *arg,
+				 int ioc, unsigned long arg,
 				 int cpu_map_idx)
 {
 	int thread;
@@ -353,7 +353,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
 }
 
 int perf_evsel__enable(struct perf_evsel *evsel)
@@ -362,13 +362,13 @@ int perf_evsel__enable(struct perf_evsel *evsel)
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
@@ -377,7 +377,63 @@ int perf_evsel__disable(struct perf_evsel *evsel)
 	int err = 0;
 
 	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
-		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
+		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i);
+	return err;
+}
+
+int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh, int cpu_map_idx)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, cpu_map_idx);
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
+int perf_evsel__period_cpu(struct perf_evsel *evsel, __u64 period, int cpu_map_idx)
+{
+	struct perf_event_attr *attr;
+	int err = 0;
+
+	attr = perf_evsel__attr(evsel);
+	if (!attr)
+		return -EINVAL;
+
+	err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
+				    (unsigned long)&period, cpu_map_idx);
+	if (err)
+		return err;
+
+	attr->sample_period = period;
+
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
 
@@ -388,7 +444,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
 		err = perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter, i);
+				     (unsigned long)filter, i);
 	return err;
 }
 
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 2a9516b42d15..360ced734add 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -38,6 +38,11 @@ LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__refresh(struct perf_evsel *evsel, int refresh);
+LIBPERF_API int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh,
+					int cpu_map_idx);
+LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
+LIBPERF_API int perf_evsel__period_cpu(struct perf_evsel *evsel, __u64 period, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 6fa0d651576b..ab0f44e9bb57 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -29,6 +29,10 @@ LIBPERF_0.0.1 {
 		perf_evsel__munmap;
 		perf_evsel__mmap_base;
 		perf_evsel__read;
+		perf_evsel__refresh;
+		perf_evsel__refresh_cpu;
+		perf_evsel__period;
+		perf_evsel__period_cpu;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
-- 
2.25.1

