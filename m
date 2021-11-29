Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48E4610D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbhK2JNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:13:19 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:8363 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241696AbhK2JLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:11:19 -0500
IronPort-SDR: V+PtIRCzrIKctezys5RvqLNHRI5x6V3Esn7L+mImzK6M5iabljFNmETUBW+6F1GGxwPmI3u+Lt
 vSfVuLLtg7XS4gq1amGoUpmV7195P8RRiwwztXa350Roia1G4BzR3Crdsr1og4NSHUrKMCN0Gc
 Jvqz+//T8Bj6wEQ9d4OHPtnJd5CKPJyZbR2WpbKlZEFQlbWggqCuZtK96h/tdp0dxUXJ39rZFS
 mNCZzVVtiVhaRX7Jwsy83FrCs+RDKtYS9uIh/i5I284jztSOr0sgYeCq+4Svznro2BViXuaAHz
 BHhT8bDO6n8hEOeC/NNUPcQC
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="33104173"
X-IronPort-AV: E=Sophos;i="5.87,272,1631545200"; 
   d="scan'208";a="33104173"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Nov 2021 18:07:59 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 674481FAFE5;
        Mon, 29 Nov 2021 18:07:58 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 40C3DBDB4E;
        Mon, 29 Nov 2021 18:07:57 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 17CB94004C629;
        Mon, 29 Nov 2021 18:07:57 +0900 (JST)
From:   Shunsuke <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Subject: [PATCH v4 1/3] libperf: Move perf_counts_values__scale to tools/lib/perf
Date:   Mon, 29 Nov 2021 18:06:25 +0900
Message-Id: <20211129090627.592149-2-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
References: <20211129090627.592149-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shunsuke Nakamura <nakamura.shun@fujitsu.com>

Move perf_counts_values__scale from tools/perf/util to tools/lib/perf
so that it can be used with libperf.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/evsel.c              | 19 +++++++++++++++++++
 tools/lib/perf/include/perf/evsel.h |  4 ++++
 tools/lib/perf/libperf.map          |  1 +
 tools/perf/util/evsel.c             | 19 -------------------
 tools/perf/util/evsel.h             |  3 ---
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8441e3e1aaac..782d1466df1f 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -431,3 +431,22 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
 	zfree(&evsel->id);
 	evsel->ids = 0;
 }
+
+void perf_counts_values__scale(struct perf_counts_values *count,
+			       bool scale, __s8 *pscaled)
+{
+	__s8 scaled = 0;
+
+	if (scale) {
+		if (count->run == 0) {
+			scaled = -1;
+			count->val = 0;
+		} else if (count->run < count->ena) {
+			scaled = 1;
+			count->val = (u64)((double)count->val * count->ena / count->run);
+		}
+	}
+
+	if (pscaled)
+		*pscaled = scaled;
+}
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 60eae25076d3..f401c7484bec 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -4,6 +4,8 @@
 
 #include <stdint.h>
 #include <perf/core.h>
+#include <stdbool.h>
+#include <linux/types.h>
 
 struct perf_evsel;
 struct perf_event_attr;
@@ -39,5 +41,7 @@ LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
 LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
+LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
+					   bool scale, __s8 *pscaled);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 71468606e8a7..5979bf92d98f 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -50,6 +50,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__read_init;
 		perf_mmap__read_done;
 		perf_mmap__read_event;
+		perf_counts_values__scale;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac0127be0459..656c30b988ce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1476,25 +1476,6 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 	count->run = count->run - tmp.run;
 }
 
-void perf_counts_values__scale(struct perf_counts_values *count,
-			       bool scale, s8 *pscaled)
-{
-	s8 scaled = 0;
-
-	if (scale) {
-		if (count->run == 0) {
-			scaled = -1;
-			count->val = 0;
-		} else if (count->run < count->ena) {
-			scaled = 1;
-			count->val = (u64)((double) count->val * count->ena / count->run);
-		}
-	}
-
-	if (pscaled)
-		*pscaled = scaled;
-}
-
 static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
 {
 	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 29d49a8c1e92..99aa3363def7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -195,9 +195,6 @@ static inline int evsel__nr_cpus(struct evsel *evsel)
 	return evsel__cpus(evsel)->nr;
 }
 
-void perf_counts_values__scale(struct perf_counts_values *count,
-			       bool scale, s8 *pscaled);
-
 void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 			   struct perf_counts_values *count);
 
-- 
2.25.1

