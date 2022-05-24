Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42676532499
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiEXH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiEXHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB9994FD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378929; x=1684914929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BDCTe7xF9c6v8rIzCKhsjaAfG9qHgLaBeVd5M3iUjKo=;
  b=glGJFIPDAFePC/a3CGJieSMBFwM402Uazzim2dgf36oZLZIjoZGCPlzK
   p0qwHs4YXWaBEmiSJNegIFRWyPyLYiQuRkkXYRE1Yi/iCDKmEjrRYn7Pt
   1msmBdOeY0TCRilg0YzszGsfhad15lb3L/fIRUvnsv/gm7s019YX0WpVp
   0EiKGpQIYwgj0FZ89mYZgJqGoXaFKVld9DlF6EPjy+rU05siFW2L0oW3k
   WyOZJrU6QFSNiZOlNfJ7b3LcRaol/CLlOKWxtDHOJyWhsvERA93VRAtgf
   F23awwGcaElbIvTzP7DoEY23yy3stqq6VmNkEmftB1vjto64pfBdnVUMS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455499"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455499"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072426"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:27 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 11/15] libperf evlist: Check nr_mmaps is correct
Date:   Tue, 24 May 2022 10:54:32 +0300
Message-Id: <20220524075436.29144-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index eae1f6179dad..f51fdb899d19 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -23,6 +23,7 @@
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <api/fd/array.h>
+#include "internal.h"
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
@@ -428,7 +429,7 @@ static void perf_evlist__set_mmap_first(struct perf_evlist *evlist, struct perf_
 static int
 mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
-	       int thread, int *_output, int *_output_overwrite)
+	       int thread, int *_output, int *_output_overwrite, int *nr_mmaps)
 {
 	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
 	struct perf_evsel *evsel;
@@ -484,6 +485,8 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
+			*nr_mmaps += 1;
+
 			if (!idx)
 				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
@@ -518,6 +521,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
+	int nr_mmaps = 0;
 	int cpu, thread;
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -526,11 +530,14 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 
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
-- 
2.25.1

