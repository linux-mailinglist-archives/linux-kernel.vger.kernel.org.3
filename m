Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FE532489
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiEXH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiEXHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CC9AE6B
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378927; x=1684914927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrN8utAY6wLKGj0oln5nVnbB5mCMMTvx7m77B6kmT9w=;
  b=nU29eIu6kazOYrhMIBGaZ9mguhPWHeaRUsEOZhXrdwiTApddGNrdftT0
   +X8drhYdtsdazKQRBxOdzk/tL/HUuW+pcsRTns6iY+nFq+YR12lxlFhTT
   wosKRE3r2ged4FNLKNSx/k6BDSNh6bGesFne54gN5KZiFrxzukQguEbiQ
   nRzoBMceLFWFWi5v2Vtj0VeN5goXz8OyyDe7lhf+L6f9k3DrsOSQmG3x2
   1ArmNG3faPsMehllnPgPFCDIrwgGMS0d/xT1WmckOutKDtc0uE9/PtjOR
   VHTVwVQcXLqKEslt+nkZfHdKwd0ogjKCksPB5YpmZF+B08J3EcIRm16iU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455489"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072422"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 10/15] libperf evlist: Allow mixing per-thread and per-cpu mmaps
Date:   Tue, 24 May 2022 10:54:31 +0300
Message-Id: <20220524075436.29144-11-adrian.hunter@intel.com>
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

mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
can be iterated in any case.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ec0e4b5da874..eae1f6179dad 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -512,29 +512,6 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
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
@@ -565,9 +542,14 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
 {
 	int nr_mmaps;
 
+	/* One for each CPU */
 	nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
-	if (perf_cpu_map__empty(evlist->all_cpus))
-		nr_mmaps = perf_thread_map__nr(evlist->threads);
+	if (perf_cpu_map__empty(evlist->all_cpus)) {
+		/* Plus one for each thread */
+		nr_mmaps += perf_thread_map__nr(evlist->threads);
+		/* Minus the per-thread CPU (-1) */
+		nr_mmaps -= 1;
+	}
 
 	return nr_mmaps;
 }
@@ -577,7 +559,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->all_cpus;
 
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
@@ -596,9 +577,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	if (perf_cpu_map__empty(cpus))
-		return mmap_per_thread(evlist, ops, mp);
-
 	return mmap_per_cpu(evlist, ops, mp);
 }
 
-- 
2.25.1

