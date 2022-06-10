Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D6545A46
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbiFJCzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbiFJCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:55:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC304B1FF;
        Thu,  9 Jun 2022 19:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654829729; x=1686365729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=el40M1P1bdwXChWvgKMsKsNgusoQUe1up37ivhCVmf0=;
  b=eX96AjyC8ucetWLPM22gbQ1Q5aXknXYbA0AJseVWPN+MBFqwSjqEczfv
   lhUEKCxvcP1S1FIGNKAQFY2NvqgsyJ+hYe8tl9XQVRS2nC+yZcPQlxpvC
   xSrGf+Ec2ayn8OuDLlNHylsOdeD7+lyLteDBlyMbzKH/7jvxIxYaycHRa
   pVEYrvtwUBqXMAYmFFZm3Hku+pzWP+YE9a0o+cTs7afW0rLTIV4llNWea
   J2H36ba5hJ1UkVRCoITV5URnEWF37mWjnl0/Q9BbFmIEXfnjNqJtOJYZY
   miv/XY2DxGqwS/Dymhs2aU5T4JqSCe1ExN/f0nee120l+XDt//fvBPA58
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341557448"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="341557448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="566670421"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2022 19:55:25 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v3 4/5] perf x86 evlist: Add default hybrid events for perf stat
Date:   Fri, 10 Jun 2022 10:54:48 +0800
Message-Id: <20220610025449.2089232-5-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
References: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Provide a new solution to replace the reverted commit ac2dc29edd21
("perf stat: Add default hybrid events").

For the default software attrs, nothing is changed.
For the default hardware attrs, create a new evsel for each hybrid pmu.

With the new solution, adding a new default attr will not require the
special support for the hybrid platform anymore.

Also, the "--detailed" is supported on the hybrid platform

With the patch,

./perf stat -a -ddd sleep 1

 Performance counter stats for 'system wide':

       32,231.06 msec cpu-clock                 #   32.056 CPUs utilized
             529      context-switches          #   16.413 /sec
              32      cpu-migrations            #    0.993 /sec
              69      page-faults               #    2.141 /sec
     176,754,151      cpu_core/cycles/          #    5.484 M/sec          (41.65%)
     161,695,280      cpu_atom/cycles/          #    5.017 M/sec          (49.92%)
      48,595,992      cpu_core/instructions/    #    1.508 M/sec          (49.98%)
      32,363,337      cpu_atom/instructions/    #    1.004 M/sec          (58.26%)
      10,088,639      cpu_core/branches/        #  313.010 K/sec          (58.31%)
       6,390,582      cpu_atom/branches/        #  198.274 K/sec          (58.26%)
         846,201      cpu_core/branch-misses/   #   26.254 K/sec          (66.65%)
         676,477      cpu_atom/branch-misses/   #   20.988 K/sec          (58.27%)
      14,290,070      cpu_core/L1-dcache-loads/ #  443.363 K/sec          (66.66%)
       9,983,532      cpu_atom/L1-dcache-loads/ #  309.749 K/sec          (58.27%)
         740,725      cpu_core/L1-dcache-load-misses/ #   22.982 K/sec    (66.66%)
 <not supported>      cpu_atom/L1-dcache-load-misses/
         480,441      cpu_core/LLC-loads/       #   14.906 K/sec          (66.67%)
         326,570      cpu_atom/LLC-loads/       #   10.132 K/sec          (58.27%)
             329      cpu_core/LLC-load-misses/ #   10.208 /sec           (66.68%)
               0      cpu_atom/LLC-load-misses/ #    0.000 /sec           (58.32%)
 <not supported>      cpu_core/L1-icache-loads/
      21,982,491      cpu_atom/L1-icache-loads/ #  682.028 K/sec          (58.43%)
       4,493,189      cpu_core/L1-icache-load-misses/ #  139.406 K/sec    (33.34%)
       4,711,404      cpu_atom/L1-icache-load-misses/ #  146.176 K/sec    (50.08%)
      13,713,090      cpu_core/dTLB-loads/      #  425.462 K/sec          (33.34%)
       9,384,727      cpu_atom/dTLB-loads/      #  291.170 K/sec          (50.08%)
         157,387      cpu_core/dTLB-load-misses/ #    4.883 K/sec         (33.33%)
         108,328      cpu_atom/dTLB-load-misses/ #    3.361 K/sec         (50.08%)
 <not supported>      cpu_core/iTLB-loads/
 <not supported>      cpu_atom/iTLB-loads/
          37,655      cpu_core/iTLB-load-misses/ #    1.168 K/sec         (33.32%)
          61,661      cpu_atom/iTLB-load-misses/ #    1.913 K/sec         (50.03%)
 <not supported>      cpu_core/L1-dcache-prefetches/
 <not supported>      cpu_atom/L1-dcache-prefetches/
 <not supported>      cpu_core/L1-dcache-prefetch-misses/
 <not supported>      cpu_atom/L1-dcache-prefetch-misses/

       1.005466919 seconds time elapsed

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
Change log:
  v3:
    * Use evsel__new() in place of evsel__new_idx()
  v2:
    * The index of all new evsel will be updated when adding to the evlist,
      just set 0 idx for the new evsel.

 tools/perf/arch/x86/util/evlist.c | 52 ++++++++++++++++++++++++++++++-
 tools/perf/util/evlist.c          |  2 +-
 tools/perf/util/evlist.h          |  2 ++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 777bdf182a58..c83f8c11735f 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -4,16 +4,66 @@
 #include "util/evlist.h"
 #include "util/parse-events.h"
 #include "topdown.h"
+#include "util/event.h"
+#include "util/pmu-hybrid.h"
 
 #define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
 #define TOPDOWN_L2_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}"
 
+static int ___evlist__add_default_attrs(struct evlist *evlist,
+					struct perf_event_attr *attrs,
+					size_t nr_attrs)
+{
+	struct perf_cpu_map *cpus;
+	struct evsel *evsel, *n;
+	struct perf_pmu *pmu;
+	LIST_HEAD(head);
+	size_t i = 0;
+
+	for (i = 0; i < nr_attrs; i++)
+		event_attr_init(attrs + i);
+
+	if (!perf_pmu__has_hybrid())
+		return evlist__add_attrs(evlist, attrs, nr_attrs);
+
+	for (i = 0; i < nr_attrs; i++) {
+		if (attrs[i].type == PERF_TYPE_SOFTWARE) {
+			evsel = evsel__new(attrs + i);
+			if (evsel == NULL)
+				goto out_delete_partial_list;
+			list_add_tail(&evsel->core.node, &head);
+			continue;
+		}
+
+		perf_pmu__for_each_hybrid_pmu(pmu) {
+			evsel = evsel__new(attrs + i);
+			if (evsel == NULL)
+				goto out_delete_partial_list;
+			evsel->core.attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			cpus = perf_cpu_map__get(pmu->cpus);
+			evsel->core.cpus = cpus;
+			evsel->core.own_cpus = perf_cpu_map__get(cpus);
+			evsel->pmu_name = strdup(pmu->name);
+			list_add_tail(&evsel->core.node, &head);
+		}
+	}
+
+	evlist__splice_list_tail(evlist, &head);
+
+	return 0;
+
+out_delete_partial_list:
+	__evlist__for_each_entry_safe(&head, n, evsel)
+		evsel__delete(evsel);
+	return -1;
+}
+
 int arch_evlist__add_default_attrs(struct evlist *evlist,
 				   struct perf_event_attr *attrs,
 				   size_t nr_attrs)
 {
 	if (nr_attrs)
-		return __evlist__add_default_attrs(evlist, attrs, nr_attrs);
+		return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
 
 	if (!pmu_have_event("cpu", "slots"))
 		return 0;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index efa5f006b5c6..5ff4b9504828 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -309,7 +309,7 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 	return evsel;
 }
 
-static int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
+int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
 {
 	struct evsel *evsel, *n;
 	LIST_HEAD(head);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 129095c0fe6d..351ba2887a79 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -104,6 +104,8 @@ static inline int evlist__add_default(struct evlist *evlist)
 	return __evlist__add_default(evlist, true);
 }
 
+int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs);
+
 int __evlist__add_default_attrs(struct evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
-- 
2.25.1

