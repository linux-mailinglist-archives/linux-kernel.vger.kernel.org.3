Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00551D7A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391882AbiEFMbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391943AbiEFMa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B269722
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840008; x=1683376008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5EgKsh2WB5MvpPw966XbtfHj+hrbISkveSnva9Ln2I=;
  b=MU3nC/bw8+SSwBM+Scx6zwP8ypvDdl6Ej5yFdtWiToZsinuD6AVzeTx5
   zsb6lzz83211RIEcCd3Tz1OfeqvBp+SeyNHcB9FOdPHcVSs8S8dHreqq+
   yFGnq2A58ZeYYBpB//e5cwneGdItJF0X7G+srNYO2KgbCcRNDoP1zRLoi
   I+jvyvpGg/N7nyYBDzWC3o+GNqLsCZzPGCTq/etqzrBxLOml5fAiWG44p
   16RDKoR4LiV461x3TGlQcNRHnX2+vGBJqxI3MDUXGe72C60alAQB8Mxns
   Qw430ZrOYoPafSWBOQPRkm0lolBURa9tXtCdPLHbxSWJ0ujkcrGYjFVaK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045854"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709441048"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 17/23] perf tools: Allow all_cpus to be a superset of user_requested_cpus
Date:   Fri,  6 May 2022 15:25:55 +0300
Message-Id: <20220506122601.367589-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support collection of system-wide events with user requested CPUs,
all_cpus must be a superset of user_requested_cpus.

In order to support all_cpus to be a superset of user_requested_cpus,
all_cpus must be used instead of user_requested_cpus when dealing with CPUs
of all events instead of CPUs of requested events.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c     | 12 ++++++------
 tools/perf/builtin-record.c | 18 ++++++++++++------
 tools/perf/util/auxtrace.c  |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index ed66f2e38464..ec0e4b5da874 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -298,7 +298,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 {
-	int nr_cpus = perf_cpu_map__nr(evlist->user_requested_cpus);
+	int nr_cpus = perf_cpu_map__nr(evlist->all_cpus);
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nfds = 0;
 	struct perf_evsel *evsel;
@@ -430,7 +430,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
-	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->user_requested_cpus, cpu_idx);
+	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
 	struct perf_evsel *evsel;
 	int revent;
 
@@ -540,7 +540,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	     struct perf_mmap_param *mp)
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
-	int nr_cpus    = perf_cpu_map__nr(evlist->user_requested_cpus);
+	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
 	int cpu, thread;
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -565,8 +565,8 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
 {
 	int nr_mmaps;
 
-	nr_mmaps = perf_cpu_map__nr(evlist->user_requested_cpus);
-	if (perf_cpu_map__empty(evlist->user_requested_cpus))
+	nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
+	if (perf_cpu_map__empty(evlist->all_cpus))
 		nr_mmaps = perf_thread_map__nr(evlist->threads);
 
 	return nr_mmaps;
@@ -577,7 +577,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
+	const struct perf_cpu_map *cpus = evlist->all_cpus;
 
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c8a79f3a8dff..cf9a7ce429df 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -967,14 +967,20 @@ static void record__thread_data_close_pipes(struct record_thread *thread_data)
 	}
 }
 
+static bool evlist__per_thread(struct evlist *evlist)
+{
+	return cpu_map__is_dummy(evlist->core.user_requested_cpus);
+}
+
 static int record__thread_data_init_maps(struct record_thread *thread_data, struct evlist *evlist)
 {
 	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
 	struct mmap *mmap = evlist->mmap;
 	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
-	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
+	struct perf_cpu_map *cpus = evlist->core.all_cpus;
+	bool per_thread = evlist__per_thread(evlist);
 
-	if (cpu_map__is_dummy(cpus))
+	if (per_thread)
 		thread_data->nr_mmaps = nr_mmaps;
 	else
 		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
@@ -995,7 +1001,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
 
 	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
-		if (cpu_map__is_dummy(cpus) ||
+		if (per_thread ||
 		    test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
@@ -1870,7 +1876,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->core.user_requested_cpus,
+	err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->core.all_cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize cpu map.\n");
@@ -3668,12 +3674,12 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
 static int record__init_thread_masks(struct record *rec)
 {
 	int ret = 0;
-	struct perf_cpu_map *cpus = rec->evlist->core.user_requested_cpus;
+	struct perf_cpu_map *cpus = rec->evlist->core.all_cpus;
 
 	if (!record__threads_enabled(rec))
 		return record__init_thread_default_masks(rec, cpus);
 
-	if (cpu_map__is_dummy(cpus)) {
+	if (evlist__per_thread(rec->evlist)) {
 		pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ac4e4660932d..511dd3caa1bc 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -181,7 +181,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 	mp->idx = idx;
 
 	if (per_cpu) {
-		mp->cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, idx);
+		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
 		if (evlist->core.threads)
 			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
 		else
-- 
2.25.1

