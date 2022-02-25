Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D34C4278
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiBYKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbiBYKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:36:59 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70F21CABC7;
        Fri, 25 Feb 2022 02:36:26 -0800 (PST)
IronPort-SDR: gdPc5Vx/vHcn1NeOBHgSKjq6bJ+T3Oj9XzQjHlXElnaqVSpcAhBt/1lcxma32FsZyhAU0V8m0S
 I+ZgzJx4oZrhsvMU6F/2GtF1T4mU5mBI2MRPSOOlseIwDtjMnQ7OZJnO4BbPbQAtO0RtcPSqxm
 Wq+gh9ozTcts+GZGjn4Stntii4VIZV7lRHZ4avf2ZqHImu6mvvmFSs8bJanH6UX3V0W6/U8Pcd
 0/Y3TRFKP+HPkAEs6o1BWc9t9BhyzThcNKDTuBMRPlZpgQ6c8ZhZGEygnEtBLw5e5DePe/1qNO
 1uGYKB+ORVbnSuYnImfRIVV7
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="64248459"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="64248459"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E6DCE07E0;
        Fri, 25 Feb 2022 19:35:20 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E3C7D95E9;
        Fri, 25 Feb 2022 19:35:19 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 6833640124EEE;
        Fri, 25 Feb 2022 19:35:19 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 5/7] libperf: Add perf_evsel__check_fd() functions
Date:   Fri, 25 Feb 2022 19:31:12 +0900
Message-Id: <20220225103114.144239-6-nakamura.shun@fujitsu.com>
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

Add the following functions:

  perf_evsel__check_fd()
  perf_evsel__check_fd_cpu()

to check for perf events with the file descriptor specified in the
argument.
These functions can be used in signal handlers to detect overflow.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  2 ++
 tools/lib/perf/evsel.c                   | 27 ++++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  2 ++
 4 files changed, 33 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index d0aa57c6ca97..d3a1a9e77262 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -155,6 +155,8 @@ SYNOPSIS
                              struct sigaction *sig);
   int perf_evsel__set_signal_cpu(struct perf_evsel *evsel, int owner_type, unsigned int signal,
                                  struct sigaction *sig, int cpu_map_idx);
+  int perf_evsel__check_fd(struct perf_evsel *evsel, int sig_fd);
+  int perf_evsel__check_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx, int sig_fd);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 991ab04112b1..0c626f846980 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -542,6 +542,33 @@ int perf_evsel__set_signal(struct perf_evsel *evsel, int owner_type, unsigned in
 	return err;
 }
 
+int perf_evsel__check_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx, int sig_fd)
+{
+	int thread;
+	int *fd;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
+		fd = FD(evsel, cpu_map_idx, thread);
+		if (sig_fd <= 0 || !fd || *fd < 0)
+			return -1;
+
+		if (sig_fd == *fd)
+			return 0;
+	}
+
+	return -1;
+}
+
+int perf_evsel__check_fd(struct perf_evsel *evsel, int sig_fd)
+{
+	int i;
+	int err = 0;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd); i++)
+		err = perf_evsel__check_fd_cpu(evsel, i, sig_fd);
+	return err;
+}
+
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 15768fc91910..5d4b4912fec9 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -49,6 +49,8 @@ LIBPERF_API int perf_evsel__set_signal(struct perf_evsel *evsel, int owner_type,
 LIBPERF_API int perf_evsel__set_signal_cpu(struct perf_evsel *evsel, int owner_type,
 					   unsigned int signal, struct sigaction *sig,
 					   int cpu_map_idx);
+LIBPERF_API int perf_evsel__check_fd(struct perf_evsel *evsel, int sig_fd);
+LIBPERF_API int perf_evsel__check_fd_cpu(struct perf_evsel *evsel, int cpu_map_idx, int sig_fd);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 5e04fe2b611c..edd60bc69822 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -34,6 +34,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__period_cpu;
 		perf_evsel__set_signal;
 		perf_evsel__set_signal_cpu;
+		perf_evsel__check_fd;
+		perf_evsel__check_fd_cpu;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
-- 
2.31.1

