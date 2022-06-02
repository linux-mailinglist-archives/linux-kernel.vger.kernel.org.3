Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1153BBA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiFBPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiFBPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:35:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FC38A1;
        Thu,  2 Jun 2022 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654184135; x=1685720135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q72Kp6kH+XrCzkAj5EGf5w7xS0pzITO4JKHcGtdywh8=;
  b=b+ZPLiNonSVqcKiWDHAKhcMYihEn2f3H3dQNfncbL3wg4TeyacQ63p4k
   FuMZs8gO1N2jUCZ9QLRGULC8GQ81jHt/VqHwTtBgjHFJVJxsmkDD97ydQ
   SgKjSNBynyo9yTV9RtmODuYwqw3Jxvyc31Wmm5AXGLRTXWoffIkcp1cLq
   co215E5K86x/R1BrM8csTHln6hmUsZ31D57YJD8X9BDFdH5S9MdEHOOYr
   HgoZSTkiqdkgRlp6Gq8NfpaVOfJxfeC7W6wJvYXY/TJ3BE9ZTfXAE+lsT
   LIXcEE6KvCLzynr5i6GPrRwdGpUrs8beslG9dvIRE/+tsbs2dgTNOHtRO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="274788483"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="274788483"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="563359712"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2022 08:35:31 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH] perf record: Support sample-read topdown metric group for hybrid platforms
Date:   Thu,  2 Jun 2022 23:36:03 +0800
Message-Id: <20220602153603.1884710-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

With the hardware TopDown metrics feature, the sample-read feature should
be supported for a TopDown group, e.g., sample a non-topdown event and read
a Topdown metric group. But the current perf record code errors are out.

For a TopDown metric group,the slots event must be the leader of the group,
but the leader slots event doesn't support sampling. To support sample-read
the TopDown metric group, uses the 2nd event of the group as the "leader"
for the purposes of sampling.

Only the platform with the TopDown metric feature supports sample-read the
topdown group. In commit acb65150a47c ("perf record: Support sample-read
topdown metric group"), it adds arch_topdown_sample_read() to indicate
whether the TopDown group supports sample-read, it should only work on the
non-hybrid systems, this patch extends the support for hybrid platforms.

Before:

 # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_core/topdown-retiring/).
/bin/dmesg | grep -i perf may provide additional information.

After:

 # ./perf record -e "{cpu_core/slots/,cpu_core/cycles/,cpu_core/topdown-retiring/}:S" -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.238 MB perf.data (369 samples) ]

Fixes: acb65150a47c ("perf record: Support sample-read topdown metric group")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evsel.c   |  3 ++-
 tools/perf/arch/x86/util/evsel.h   |  7 +++++++
 tools/perf/arch/x86/util/topdown.c | 21 ++++-----------------
 3 files changed, 13 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/evsel.h

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index ff4561b7b600..3501399cef35 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -5,6 +5,7 @@
 #include "util/env.h"
 #include "util/pmu.h"
 #include "linux/string.h"
+#include "evsel.h"
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
@@ -32,7 +33,7 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
 }
 
 /* Check whether the evsel's PMU supports the perf metrics */
-static bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
+bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
 	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
 
diff --git a/tools/perf/arch/x86/util/evsel.h b/tools/perf/arch/x86/util/evsel.h
new file mode 100644
index 000000000000..19ad1691374d
--- /dev/null
+++ b/tools/perf/arch/x86/util/evsel.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVSEL_H
+#define _EVSEL_H 1
+
+bool evsel__sys_has_perf_metrics(const struct evsel *evsel);
+
+#endif
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index f4d5422e9960..f81a7cfe4d63 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -4,6 +4,7 @@
 #include "util/pmu.h"
 #include "util/topdown.h"
 #include "topdown.h"
+#include "evsel.h"
 
 /* Check whether there is a PMU which supports the perf metrics. */
 bool topdown_sys_has_perf_metrics(void)
@@ -55,33 +56,19 @@ void arch_topdown_group_warn(void)
 
 #define TOPDOWN_SLOTS		0x0400
 
-static bool is_topdown_slots_event(struct evsel *counter)
-{
-	if (!counter->pmu_name)
-		return false;
-
-	if (strcmp(counter->pmu_name, "cpu"))
-		return false;
-
-	if (counter->core.attr.config == TOPDOWN_SLOTS)
-		return true;
-
-	return false;
-}
-
 /*
  * Check whether a topdown group supports sample-read.
  *
- * Only Topdown metic supports sample-read. The slots
+ * Only Topdown metric supports sample-read. The slots
  * event must be the leader of the topdown group.
  */
 
 bool arch_topdown_sample_read(struct evsel *leader)
 {
-	if (!pmu_have_event("cpu", "slots"))
+	if (!evsel__sys_has_perf_metrics(leader))
 		return false;
 
-	if (is_topdown_slots_event(leader))
+	if (leader->core.attr.config == TOPDOWN_SLOTS)
 		return true;
 
 	return false;
-- 
2.25.1

