Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D750B44A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446183AbiDVJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446166AbiDVJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:02 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA853B5D;
        Fri, 22 Apr 2022 02:44:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="70646198"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="70646198"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:07 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 06E2DC68B8;
        Fri, 22 Apr 2022 18:44:05 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A32EE6747;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id C9C7F40483741;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 4/7] libperf: Add perf_evsel__has_fd() functions
Date:   Fri, 22 Apr 2022 18:38:30 +0900
Message-Id: <20220422093833.340873-5-nakamura.shun@fujitsu.com>
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

  perf_evsel__has_fd

to check for perf events with the file descriptor specified in the
argument.
This function can be used in signal handlers to check overflow.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/evsel.c                   | 18 ++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 tools/lib/perf/libperf.map               |  1 +
 4 files changed, 21 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index ec93b1c75ebe..bc7881348c76 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -161,6 +161,7 @@ SYNOPSIS
   int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
   int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+  bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index a289f6c44d7c..446934c0e5e5 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -556,3 +556,21 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	return err;
 }
+
+bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd)
+{
+	int cpu_map_idx;
+	int thread;
+	int *evsel_fd;
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); ++cpu_map_idx) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+			evsel_fd = FD(evsel, cpu_map_idx, thread);
+
+			if (fd == *evsel_fd)
+				return true;
+		}
+	}
+
+	return false;
+}
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 50662babfe97..19a7993d9021 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -69,5 +69,6 @@ LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
 				      struct perf_cpu_map *cpus,
 				      struct perf_thread_map *threads,
 				      struct perf_evsel_open_opts *opts);
+LIBPERF_API bool perf_evsel__has_fd(struct perf_evsel *evsel, int fd);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index eeeb3075e092..b2ace16bbc32 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -34,6 +34,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
+		perf_evsel__has_fd;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
-- 
2.25.1

