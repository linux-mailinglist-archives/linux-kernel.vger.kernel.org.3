Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9C51C594
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382407AbiEERC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382264AbiEERBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD75D5F2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769885; x=1683305885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i3a0uGzif9S8cOD34QWtXLAKinkX9ebBcIsx14wAdgE=;
  b=Oh+IvKSV0HQSoPBUn15TqzqI6LRG2cXXLcFO3VOMCwyxSClFxYsn76CQ
   lICvscdAJJ25PGDbS56WZ+X+QVbbU3bkYE7nxq6KVacLLruNA2XYt096T
   UFW4FwXT5VC1WL4hZWH8qIQHdEuZjyVw+GR+5kTdRS0IHgUofzgIaYPOq
   W8/WVlTiBScMZtnvWasM8dWmpKnSnEecqGTH6R4Q5CFGwVWnG+xgxVB7s
   VQaaz4+COfwViGAbrXUgZvF66kuNmxuYNMJTH+Lrhd80NUx8r8Dd5NQG6
   J1AKD7d+0BNx9zIG4yFrhM0KVbGfJ6lHSyTTUaOgoaYddg0pfFI2Tx1rl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718308"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709033034"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 19/23] libperf evlist: Check nr_mmaps is correct
Date:   Thu,  5 May 2022 19:56:35 +0300
Message-Id: <20220505165639.361733-20-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505165639.361733-1-adrian.hunter@intel.com>
References: <20220505165639.361733-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print an error message if the predetermined number of mmaps is
incorrect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                | 11 +++++++++--
 tools/lib/perf/include/internal/mmap.h |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 0acf43946479..8a82b4b94b99 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -23,6 +23,7 @@
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <api/fd/array.h>
+#include "internal.h"
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -424,7 +425,7 @@ static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
-	       int thread, int *_output, int *_output_overwrite)
+	       int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
 {
 	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
 	struct perf_evsel *evsel;
@@ -480,6 +481,8 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
+			*nr_mmaps += 1;
+
 			if (!idx)
 				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
@@ -514,6 +517,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
+	int nr_mmaps = 0;
 	int cpu, thread;
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -522,11 +526,14 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
-					   thread, &output, &output_overwrite))
+					   thread, &output, &output_overwrite, &nr_mmaps))
 				goto out_unmap;
 		}
 	}
 
+	if (nr_mmaps != evlist->nr_mmaps)
+		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
+
 	return 0;
 
 out_unmap:
diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index 5a062af8e9d8..9b00828e70ef 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -56,4 +56,9 @@ u64 perf_mmap__read_head(struct perf_mmap *map);
 
 int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
 
+static inline bool perf_mmap__is_mmapped(struct perf_mmap *map)
+{
+	return map->base;
+}
+
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
-- 
2.25.1

