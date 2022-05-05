Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E4851C590
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382224AbiEERCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382419AbiEERBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E345D5E5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769884; x=1683305884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcLcZH0f8wvIteGm3XQMLmh65rIcxVwcMWsduub+0WA=;
  b=PW+2YDCSth0wNs5Zyc+XVsx7esCCsxlrDhu476GadCKgixWZhs+fmL+w
   ACfcpAcVOPJ5zM74hgt81XICMbhb9FQ3w690jp6gSbk90nvx4L3aPRNN5
   D/pDF8YP62B8eSo18rno3ddiVS4YGMJhTghdGDZYoUtT0/qez5hUGv0jU
   +px2lCCMQlQ+omNy2mvZIzqZL1hMOLQMTYn0whQK1IJpwmlQVbFQKCpGK
   XrVB5zPKEIJS2qjq5FpP8TR7kYJUPNMLSEeRTwKKBgLpKggoukv2kNtPR
   jDEqG2hCsqi7CncN+ILW428Cl5pjRYQTSDT/jMQtS2tWtBeyn0nmv4hI3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718292"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032968"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 17/23] perf tools: Allow all_cpus to be a superset of user_requested_cpus
Date:   Thu,  5 May 2022 19:56:33 +0300
Message-Id: <20220505165639.361733-18-adrian.hunter@intel.com>
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
index ad04da81c367..048b546f9444 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -294,7 +294,7 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 {
-	int nr_cpus = perf_cpu_map__nr(evlist->user_requested_cpus);
+	int nr_cpus = perf_cpu_map__nr(evlist->all_cpus);
 	int nr_threads = perf_thread_map__nr(evlist->threads);
 	int nfds = 0;
 	struct perf_evsel *evsel;
@@ -426,7 +426,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	       int idx, struct perf_mmap_param *mp, int cpu_idx,
 	       int thread, int *_output, int *_output_overwrite)
 {
-	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->user_requested_cpus, cpu_idx);
+	struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->all_cpus, cpu_idx);
 	struct perf_evsel *evsel;
 	int revent;
 
@@ -536,7 +536,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	     struct perf_mmap_param *mp)
 {
 	int nr_threads = perf_thread_map__nr(evlist->threads);
-	int nr_cpus    = perf_cpu_map__nr(evlist->user_requested_cpus);
+	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
 	int cpu, thread;
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
@@ -561,8 +561,8 @@ static int perf_evlist__nr_mmaps(struct perf_evlist *evlist)
 {
 	int nr_mmaps;
 
-	nr_mmaps = perf_cpu_map__nr(evlist->user_requested_cpus);
-	if (perf_cpu_map__empty(evlist->user_requested_cpus))
+	nr_mmaps = perf_cpu_map__nr(evlist->all_cpus);
+	if (perf_cpu_map__empty(evlist->all_cpus))
 		nr_mmaps = perf_thread_map__nr(evlist->threads);
 
 	return nr_mmaps;
@@ -573,7 +573,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_mmap_param *mp)
 {
 	struct perf_evsel *evsel;
-	const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
+	const struct perf_cpu_map *cpus = evlist->all_cpus;
 
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 83d2f2b5dcda..7173671abe8a 100644
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
 		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
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
@@ -3667,12 +3673,12 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
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

