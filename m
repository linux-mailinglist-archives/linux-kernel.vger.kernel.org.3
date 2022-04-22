Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89950B44C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446177AbiDVJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445893AbiDVJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:01 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D853B54;
        Fri, 22 Apr 2022 02:44:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="70825376"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="70825376"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:05 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 65790ED4C0;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 430FED947E;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 046B940487FBB;
        Fri, 22 Apr 2022 18:44:02 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 1/7] libperf: Move 'open_flags' from tools/perf to evsel::open_flags
Date:   Fri, 22 Apr 2022 18:38:27 +0900
Message-Id: <20220422093833.340873-2-nakamura.shun@fujitsu.com>
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

Move evsel::open_flags to perf_evsel::open_flags, so we can move
the open_flags interface to libperf.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/include/internal/evsel.h |  2 ++
 tools/perf/util/evsel.c                 | 16 +++++++++-------
 tools/perf/util/evsel.h                 |  1 -
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index 2a1729e7aee4..92f7a76ca9d5 100644
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

