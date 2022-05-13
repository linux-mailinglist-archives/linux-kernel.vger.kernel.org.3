Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F05265CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381841AbiEMPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381225AbiEMPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:16:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46358E74;
        Fri, 13 May 2022 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652454964; x=1683990964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwPKNv7wzL/0rUqY/ySsyGakmxNjz3VMfdoNwADaX60=;
  b=IBCDMPNAYPXEUBzNxFmAarfy0b2UHJcq5gNyplvJoW9dXU2KgXzOxMxm
   vIEzAHR1izgjGEf5gEVyoX7pWFWNA+Ze4euIMwPCNPUSiW80iK5P2QuyI
   CTsQDnzQlk6LFBHmFQZpZdiWcPVPSu9xonGEPCCzvQNhLBSVHR3SfxmUg
   PdE6zKHGOabhL3jNaLw89eLu4sKyUML304yvXlBTNG+dsN+ZfCQKJrCVF
   gAkusxg+5F36oR778FswfPTTfeqrUsaFA2Fb9RlBycJIRGwCpiAqwClmh
   fV5OnfD6/EWwodv4UN08oi3f05MnjoGd6e9nnZECry3Slrsn/N9q1su4h
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="330924529"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="330924529"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698518062"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 08:16:02 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf parse-events: Move slots event for the hybrid platform too
Date:   Fri, 13 May 2022 08:15:54 -0700
Message-Id: <20220513151554.1054452-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513151554.1054452-1-kan.liang@linux.intel.com>
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

The commit 94dbfd6781a0 ("perf parse-events: Architecture specific
leader override") introduced a feature to reorder the slots event to
fulfill the restriction of the perf metrics topdown group. But the
feature doesn't work on the hybrid machine.

$perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1

 Performance counter stats for 'system wide':

     <not counted>      cpu_core/instructions/
     <not counted>      cpu_core/slots/
   <not supported>      cpu_core/topdown-retiring/

       1.002871801 seconds time elapsed

A hybrid platform has a different PMU name for the core PMUs, while
current perf hard code the PMU name "cpu".

Introduce a new function to check whether the system supports the perf
metrics feature. The result is cached for the future usage.

For X86, the core PMU name always has "cpu" prefix.

With the patch,

$perf stat -e "{cpu_core/instructions/,cpu_core/slots/,cpu_core/topdown-retiring/}" -a sleep 1

 Performance counter stats for 'system wide':

        76,337,010      cpu_core/slots/
        10,416,809      cpu_core/instructions/
        11,692,372      cpu_core/topdown-retiring/

       1.002805453 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c  |  5 +++--
 tools/perf/arch/x86/util/topdown.c | 18 ++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  7 +++++++
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/topdown.h

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 75564a7df15b..68f681ad54c1 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -3,6 +3,7 @@
 #include "util/pmu.h"
 #include "util/evlist.h"
 #include "util/parse-events.h"
+#include "topdown.h"
 
 #define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
 #define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
@@ -25,12 +26,12 @@ struct evsel *arch_evlist__leader(struct list_head *list)
 
 	first = list_first_entry(list, struct evsel, core.node);
 
-	if (!pmu_have_event("cpu", "slots"))
+	if (!topdown_sys_has_perf_metrics())
 		return first;
 
 	/* If there is a slots event and a topdown event then the slots event comes first. */
 	__evlist__for_each_entry(list, evsel) {
-		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
+		if (evsel->pmu_name && !strncmp(evsel->pmu_name, "cpu", 3) && evsel->name) {
 			if (strcasestr(evsel->name, "slots")) {
 				slots = evsel;
 				if (slots == first)
diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index 2f3d96aa92a5..95b9fdef59ab 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -3,6 +3,24 @@
 #include "api/fs/fs.h"
 #include "util/pmu.h"
 #include "util/topdown.h"
+#include "topdown.h"
+
+bool topdown_sys_has_perf_metrics(void)
+{
+	static bool has_perf_metrics;
+	static bool cached;
+	struct perf_pmu *pmu;
+
+	if (cached)
+		return has_perf_metrics;
+
+	pmu = perf_pmu__find_by_type(PERF_TYPE_RAW);
+	if (pmu && pmu_have_event(pmu->name, "slots"))
+		has_perf_metrics = true;
+
+	cached = true;
+	return has_perf_metrics;
+}
 
 /*
  * Check whether we can use a group for top down.
diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
new file mode 100644
index 000000000000..46bf9273e572
--- /dev/null
+++ b/tools/perf/arch/x86/util/topdown.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOPDOWN_H
+#define _TOPDOWN_H 1
+
+bool topdown_sys_has_perf_metrics(void);
+
+#endif
-- 
2.35.1

