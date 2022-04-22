Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D125B50B453
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446201AbiDVJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446223AbiDVJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:48:11 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BACDFBB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:45:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="58751383"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="58751383"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:06 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E8F6BD5027;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D4BD6E6743;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 8D0D240487FBD;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 3/7] libperf: Add support for overflow handling of sampling events
Date:   Fri, 22 Apr 2022 18:38:29 +0900
Message-Id: <20220422093833.340873-4-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the fields of the opts structure to set up overflow handling
for sampling events. Also, add processing to set signal handlers in
perf_evsel__open_opts.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  6 +-
 tools/lib/perf/Makefile                  |  1 +
 tools/lib/perf/evsel.c                   | 79 ++++++++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h      |  6 +-
 tools/lib/perf/tests/test-evlist.c       |  1 -
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 6ca91ca94e01..ec93b1c75ebe 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -137,8 +137,12 @@ SYNOPSIS
           size_t sz;
 
           unsigned long open_flags;       /* perf_event_open flags */
+          int flags;                      /* fcntl flags */
+          unsigned int signal;
+          int owner_type;
+          struct sigaction *sig;
   };
-  #define perf_evsel_open_opts__last_field open_flags
+  #define perf_evsel_open_opts__last_field sig
 
   #define LIBPERF_OPTS(TYPE, NAME, ...)
 
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 21df023a2103..4c8fae193cf5 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -75,6 +75,7 @@ override CFLAGS += -Werror -Wall
 override CFLAGS += -fPIC
 override CFLAGS += $(INCLUDES)
 override CFLAGS += -fvisibility=hidden
+override CFLAGS += -D_GNU_SOURCE
 
 all:
 
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 00c0cea43b52..a289f6c44d7c 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -460,6 +460,79 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
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
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int perf_evsel__set_signal_handler(struct perf_evsel *evsel,
+					  struct perf_evsel_open_opts *opts)
+{
+	unsigned int flags;
+	unsigned int signal;
+	struct f_owner_ex owner;
+	struct sigaction *sig;
+	int cpu_map_idx;
+	int err = 0;
+
+	flags = OPTS_GET(opts, flags, (O_RDWR | O_NONBLOCK | O_ASYNC));
+	signal = OPTS_GET(opts, signal, SIGIO);
+	owner.type = OPTS_GET(opts, owner_type, F_OWNER_PID);
+	sig = OPTS_GET(opts, sig, NULL);
+
+	if (flags == 0 && signal == 0 && !owner.type == 0 && sig == 0)
+		return err;
+
+	err = sigaction(signal, sig, NULL);
+	if (err)
+		return err;
+
+	switch (owner.type) {
+	case F_OWNER_PID:
+		owner.pid = getpid();
+		break;
+	case F_OWNER_TID:
+		owner.pid = syscall(SYS_gettid);
+		break;
+	case F_OWNER_PGRP:
+	default:
+		return -1;
+	}
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); cpu_map_idx++) {
+		err = perf_evsel__run_fcntl(evsel, F_SETFL, flags, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX,
+					    (unsigned long)&owner, cpu_map_idx);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
 int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 			  struct perf_thread_map *threads,
 			  struct perf_evsel_open_opts *opts)
@@ -474,6 +547,12 @@ int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 	evsel->open_flags = OPTS_GET(opts, open_flags, 0);
 
 	err = perf_evsel__open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	err = perf_evsel__set_signal_handler(evsel, opts);
+	if (err)
+		return err;
 
 	return err;
 }
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 1140df4d2578..50662babfe97 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -29,8 +29,12 @@ struct perf_evsel_open_opts {
 	size_t sz;
 
 	unsigned long open_flags;	/* perf_event_open flags */
+	int flags;			/* fcntl flags */
+	unsigned int signal;
+	int owner_type;
+	struct sigaction *sig;
 };
-#define perf_evsel_open_opts__last_field open_flags
+#define perf_evsel_open_opts__last_field sig
 
 #define LIBPERF_OPTS(TYPE, NAME, ...)			\
 	struct TYPE NAME = ({				\
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index ed616fc19b4f..d8f9493cd4d1 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
 #include <inttypes.h>
 #include <sched.h>
 #include <stdio.h>
-- 
2.25.1

