Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0850BCE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387692AbiDVQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391246AbiDVQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1325210FE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644701; x=1682180701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KDhM/WmO5qwWzplHvUxX9lpSM1PSGCnUMDibz7ihk2M=;
  b=hTfuvk24ME5ZUZ28kQ7r4oy8Vm1HJDAkaBS4lB3nubPV7F+CJ/3SYbwZ
   xzXN9O8fM6RJxqqC5BPo+KBBrtoPa0av3Cu1ytbhRsV4VvjWWL++7JB93
   rzKf4bgnRyEBmbL/IcR2jKD8V1eMLz55uZiY18dzQyAC7CepIm2adXFl7
   GuP3DfFuFmu34oiCRV51bcMUfdgXgebKPcYPg5cJwjJrVdfbeu4FcwynX
   zQrt12+9RjieWhF1QXwKLBXsOwiZORLuCKzCS5r91/k9/DnuwHm2cQxYu
   maXTL+3HejPmSth5WIhw/fm41l5XvCGBLB8yNsFIxltUPWnT+De1RrVZV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886057"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979190"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:55 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 18/21] libperf evlist: Allow mixing per-thread and per-cpu mmaps
Date:   Fri, 22 Apr 2022 19:23:59 +0300
Message-Id: <20220422162402.147958-19-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422162402.147958-1-adrian.hunter@intel.com>
References: <20220422162402.147958-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
can be iterated in any case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 048b546f9444..37dfa9d936a7 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -508,29 +508,6 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	return 0;
 }
 
-static int
-mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
-		struct perf_mmap_param *mp)
-{
-	int thread;
-	int nr_threads = perf_thread_map__nr(evlist->threads);
-
-	for (thread = 0; thread < nr_threads; thread++) {
-		int output = -1;
-		int output_overwrite = -1;
-
-		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
-				   &output, &output_overwrite))
-			goto out_unmap;
-	}
-
-	return 0;
-
-out_unmap:
-	perf_evlist__munmap(evlist);
-	return -1;
-}
-
 static int
 mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	     struct perf_mmap_param *mp)
@@ -561,9 +538,12 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
 {
 	int nr_mmaps;
 
+	/* One for each CPU */
 	nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
-	if (perf_cpu_map__empty(evlist->all_cpus))
-		nr_mmaps = perf_thread_map__nr(evlist->threads);
+	/* One for each thread */
+	nr_mmaps += perf_thread_map__nr(evlist->threads);
+	/* Minus the dummy CPU or dummy thread */
+	nr_mmaps -= 1;
 
 	return nr_mmaps;
 }
@@ -573,7 +553,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->all_cpus;
 
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
@@ -592,9 +571,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, ops, mp);
-
 	return mmap_per_cpu(evlist, ops, mp);
 }
 
-- 
2.25.1

