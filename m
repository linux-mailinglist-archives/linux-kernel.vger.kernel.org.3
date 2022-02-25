Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134114C427F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiBYKhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiBYKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:36:57 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A58424FA02;
        Fri, 25 Feb 2022 02:36:24 -0800 (PST)
IronPort-SDR: D6FgPXK2j950xBnExInaXsP24Vu1JkBjTBH2CJ++8R0BUXnD4nCMf1E3RmHVoNef1TVpfJG18I
 aKiHTtoScN2T+QcSypTdk+C6wigS9YUW+9LNYjPuHYgBH1nBWtsQSjVpyR7APaI1ps10tM2AUM
 R9N5v0tfVj6H+EsWbBuNBoATElZXx3hewbPlaP7a80axjZaXTw2QuHZ8NO1YIm2S9cQtn1Wp7A
 CI/Ij5K1CK92qzUuzgNxPiPBO3sR1YyfsAcevQTawTyYg3iesbAf9HZf163+o7r3xkB/JYR52d
 vsH5Hvt6VVQwgVX+FWazQwbI
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="64087260"
X-IronPort-AV: E=Sophos;i="5.90,136,1643641200"; 
   d="scan'208";a="64087260"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Feb 2022 19:35:17 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id DABBCCA245;
        Fri, 25 Feb 2022 19:35:15 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A105D9945;
        Fri, 25 Feb 2022 19:35:14 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 7F5BC40124EF7;
        Fri, 25 Feb 2022 19:35:09 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [RFC PATCH 2/7] libperf: Add perf_evsel__set_close_on_exec() function
Date:   Fri, 25 Feb 2022 19:31:09 +0900
Message-Id: <20220225103114.144239-3-nakamura.shun@fujitsu.com>
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

Move evsel::open_flags to perf_evsel::open_flags and add a function to
set PERF_FLAG_FD_CLOEXEC.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/evsel.c                   | 15 ++++++++++++++-
 tools/lib/perf/include/internal/evsel.h  |  2 ++
 tools/lib/perf/include/perf/evsel.h      |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/perf/util/evsel.c                  | 16 +++++++++-------
 tools/perf/util/evsel.h                  |  1 -
 7 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 32c5051c24eb..96a451cd34eb 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -149,6 +149,7 @@ SYNOPSIS
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
+  int perf_evsel__set_close_on_exec(struct perf_evsel *evsel);
 --
 
 *API to handle maps (perf ring buffers):*
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 210ea7c06ce8..d22b1468a1ad 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -26,6 +26,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 	evsel->attr = *attr;
 	evsel->idx  = idx;
 	evsel->leader = evsel;
+	evsel->open_flags = 0;
 }
 
 struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
@@ -158,7 +159,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpu, group_fd, 0);
+						 cpu, group_fd, evsel->open_flags);
 
 			if (fd < 0)
 				return -errno;
@@ -454,3 +455,15 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 	if (pscaled)
 		*pscaled = scaled;
 }
+
+int perf_evsel__set_close_on_exec(struct perf_evsel *evsel)
+{
+	int err = 0;
+
+	if (evsel)
+		evsel->open_flags |= PERF_FLAG_FD_CLOEXEC;
+	else
+		err = -1;
+
+	return err;
+}
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index cfc9ebd7968e..37a99cf261b3 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -51,6 +51,8 @@ struct perf_evsel {
 	int			 nr_members;
 	bool			 system_wide;
 	int			 idx;
+
+	unsigned long		 open_flags;
 };
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 2a9516b42d15..23b0334a4c57 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -43,5 +43,6 @@ LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
 					   bool scale, __s8 *pscaled);
+LIBPERF_API int perf_evsel__set_close_on_exec(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 93696affda2e..0f8d13f9009b 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -52,6 +52,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__read_done;
 		perf_mmap__read_event;
 		perf_counts_values__scale;
+		perf_evsel__set_close_on_exec;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 22d3267ce294..52c34552ee76 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1794,9 +1794,9 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
-	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
+	evsel->core.open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
-		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
+		evsel->core.open_flags |= PERF_FLAG_PID_CGROUP;
 
 	return 0;
 }
@@ -1814,7 +1814,7 @@ static void evsel__disable_missing_features(struct evsel *evsel)
 		evsel->core.attr.clockid = 0;
 	}
 	if (perf_missing_features.cloexec)
-		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
+		evsel->core.open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
 	if (perf_missing_features.mmap2)
 		evsel->core.attr.mmap2 = 0;
 	if (evsel->pmu && evsel->pmu->missing_features.exclude_guest)
@@ -1902,7 +1902,8 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 		perf_missing_features.clockid = true;
 		pr_debug2_peo("switching off use_clockid\n");
 		return true;
-	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
+	} else if (!perf_missing_features.cloexec &&
+		   (evsel->core.open_flags & PERF_FLAG_FD_CLOEXEC)) {
 		perf_missing_features.cloexec = true;
 		pr_debug2_peo("switching off cloexec flag\n");
 		return true;
@@ -2029,11 +2030,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			test_attr__ready();
 
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
+				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd,
+				evsel->core.open_flags);
 
 			fd = sys_perf_event_open(&evsel->core.attr, pid,
 						perf_cpu_map__cpu(cpus, idx).cpu,
-						group_fd, evsel->open_flags);
+						group_fd, evsel->core.open_flags);
 
 			FD(evsel, idx, thread) = fd;
 
@@ -2050,7 +2052,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (unlikely(test_attr__enabled)) {
 				test_attr__open(&evsel->core.attr, pid,
 						perf_cpu_map__cpu(cpus, idx),
-						fd, group_fd, evsel->open_flags);
+						fd, group_fd, evsel->core.open_flags);
 			}
 
 			pr_debug2_peo(" = %d\n", fd);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 041b42d33bf5..8a545954eec7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -152,7 +152,6 @@ struct evsel {
 		struct bperf_leader_bpf *leader_skel;
 		struct bperf_follower_bpf *follower_skel;
 	};
-	unsigned long		open_flags;
 	int			precise_ip_original;
 
 	/* for missing_features */
-- 
2.31.1

