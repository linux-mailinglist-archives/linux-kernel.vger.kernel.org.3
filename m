Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E450B4E6D64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358270AbiCYEpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiCYEpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:45:03 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DAE6006B;
        Thu, 24 Mar 2022 21:43:20 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="46962355"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="46962355"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:16 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 91002CD6C0;
        Fri, 25 Mar 2022 13:43:17 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A8927D975A;
        Fri, 25 Mar 2022 13:43:16 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 659F2403F02E4;
        Fri, 25 Mar 2022 13:43:16 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 2/7] libperf: Move 'open_flags' from tools/perf to evsel::open_flags
Date:   Fri, 25 Mar 2022 13:38:24 +0900
Message-Id: <20220325043829.224045-3-nakamura.shun@fujitsu.com>
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

Move evsel::open_flags to perf_evsel::open_flags, so we can move
the open_flags interface to libperf.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/evsel.c                  |  3 ++-
 tools/lib/perf/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 16 +++++++++-------
 tools/perf/util/evsel.h                 |  1 -
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 210ea7c06ce8..6640a333e6d9 100644
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
2.25.1

