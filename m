Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A54C427B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiBYKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiBYKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:36:59 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 02:36:25 PST
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118C929DD52;
        Fri, 25 Feb 2022 02:36:25 -0800 (PST)
IronPort-SDR: DibmdeHjlOFNowuKLV0Dp7lXHcEDpQyJ4NvUNmqDBj1hIi7+CnKKzyNXNOQ+gv/KIdCclwwpjm
 53I8KDKzrCvxp2BjCwiuRuIdYTnS6ueTLAy0VB/8rPMvlh6OnypTmbAvssj6umYJqQZnNZYBtE
 f22pCyFsIWDdMbHBwfPYX/tlZos1Vw0aM5LjMOAgDNtL+g7AffPRH1TMiL9Z6kVyJ64idsEDie
 opq24uZ7h5D54yPrzxCRPWxHGLtwBfQiJp7BOQ/uAo/0Q2WAoV9eOKwQcxpYuCBevhiVYhUhbW
 v1Gl6fvHgoogVkBsHuy0pXdA
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="43953260"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="43953260"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:18 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D31A1F617A;
        Fri, 25 Feb 2022 19:35:17 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DF49CD95E7;
        Fri, 25 Feb 2022 19:35:16 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id C8B9B40124EEE;
        Fri, 25 Feb 2022 19:35:16 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 4/7] libperf: Add perf_evsel__set_signal() functions
Date:   Fri, 25 Feb 2022 19:31:11 +0900
Message-Id: <20220225103114.144239-5-nakamura.shun@fujitsu.com>
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

  perf_evsel__set_signal()
  perf_evsel__set_signal_cpu()

to set the parameters to get the overflow signal.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |   4 +
 tools/lib/perf/evsel.c                   | 105 +++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |   6 ++
 tools/lib/perf/libperf.map               |   2 +
 4 files changed, 117 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 8f523293fb9d..d0aa57c6ca97 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -151,6 +151,10 @@ SYNOPSIS
                               int cpu_map_idx);
   int perf_evsel__period(struct perf_evsel *evsel, int period);
   int perf_evsel__period_cpu(struct perf_evsel *evsel, int period, int cpu_map_idx);
+  int perf_evsel__set_signal(struct perf_evsel *evsel, int owner_type, unsigned int signal,
+                             struct sigaction *sig);
+  int perf_evsel__set_signal_cpu(struct perf_evsel *evsel, int owner_type, unsigned int signal,
+                                 struct sigaction *sig, int cpu_map_idx);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8348545874e4..991ab04112b1 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -16,6 +19,9 @@
 #include <internal/lib.h>
 #include <linux/string.h>
 #include <sys/ioctl.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <sys/types.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
 
@@ -351,6 +357,28 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 	return 0;
 }
 
+static int perf_evsel__run_fcntl(struct perf_evsel *evsel,
+				 unsigned int cmd, unsigned long arg,
+				 int cpu_map_idx)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int err;
+		int *fd = FD(evsel, cpu_map_idx, thread);
+
+		if (!fd || *fd < 0)
+			return -1;
+
+		err = fcntl(*fd, cmd, arg);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 {
 	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu_map_idx);
@@ -437,6 +465,83 @@ int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
 	return err;
 }
 
+int perf_evsel__set_signal_cpu(struct perf_evsel *evsel, int owner_type, unsigned int signal,
+			       struct sigaction *sig, int cpu_map_idx)
+{
+	int err = 0;
+	struct f_owner_ex owner;
+
+	switch (owner_type) {
+	case F_OWNER_PID:
+		owner.pid = getpid();
+		break;
+	case F_OWNER_TID:
+		owner.pid = syscall(SYS_gettid);
+		break;
+	default:
+		return -1;
+	}
+
+	err = perf_evsel__run_fcntl(evsel, F_SETFL, (O_RDWR | O_NONBLOCK | O_ASYNC), cpu_map_idx);
+	if (err)
+		return err;
+
+	err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, cpu_map_idx);
+	if (err)
+		return err;
+
+	err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX, (unsigned long)&owner, cpu_map_idx);
+	if (err)
+		return err;
+
+	err = sigaction(signal, sig, NULL);
+	if (err)
+		return err;
+
+	return err;
+}
+
+int perf_evsel__set_signal(struct perf_evsel *evsel, int owner_type, unsigned int signal,
+			   struct sigaction *sig)
+{
+	int i;
+	int err = 0;
+	struct f_owner_ex owner;
+
+	switch (owner_type) {
+	case F_OWNER_PID:
+		owner.pid = getpid();
+		break;
+	case F_OWNER_TID:
+		owner.pid = syscall(SYS_gettid);
+		break;
+	default:
+		return -1;
+	}
+
+	owner.type = owner_type;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++) {
+		err = perf_evsel__run_fcntl(evsel, F_SETFL, (O_RDWR | O_NONBLOCK | O_ASYNC), i);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, i);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX, (unsigned long)&owner, i);
+		if (err)
+			return err;
+	}
+
+	err = sigaction(signal, sig, NULL);
+	if (err)
+		return err;
+
+	return err;
+}
+
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
 	int err = 0, i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 9ec24a5f5f9f..15768fc91910 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <perf/core.h>
 #include <stdbool.h>
+#include <signal.h>
 #include <linux/types.h>
 
 struct perf_evsel;
@@ -43,6 +44,11 @@ LIBPERF_API int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh,
 					int cpu_map_idx);
 LIBPERF_API int perf_evsel__period(struct perf_evsel *evsel, __u64 period);
 LIBPERF_API int perf_evsel__period_cpu(struct perf_evsel *evsel, __u64 period, int cpu_map_idx);
+LIBPERF_API int perf_evsel__set_signal(struct perf_evsel *evsel, int owner_type,
+				       unsigned int signal, struct sigaction *sig);
+LIBPERF_API int perf_evsel__set_signal_cpu(struct perf_evsel *evsel, int owner_type,
+					   unsigned int signal, struct sigaction *sig,
+					   int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 83ecbce9cfbb..5e04fe2b611c 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -32,6 +32,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__refresh_cpu;
 		perf_evsel__period;
 		perf_evsel__period_cpu;
+		perf_evsel__set_signal;
+		perf_evsel__set_signal_cpu;
 		perf_evsel__cpus;
 		perf_evsel__threads;
 		perf_evsel__attr;
-- 
2.31.1

