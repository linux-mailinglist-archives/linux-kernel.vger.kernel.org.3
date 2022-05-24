Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D553248D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiEXH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiEXHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355579AE4A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378925; x=1684914925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amqXpsC6nONorK7DFhJU6kqIYiAx/ku+iIY9HiEwERw=;
  b=c+a2uKrQU5jM2ag4GjY2/9VWcupd7LE895okFIpw4T/HYetX1wpbI2cI
   aaHdpvvxPnIAH0aMDE6YEsDWKuETKn6AU1t6ibAgeNfUMVV0a5o/JhDoy
   jmISvK5ap30VPXKiLO4oSg/Zc1Zbo91tLhkNc/B1Di/Whb8Mc8jsVpGKD
   O3MVKV/ROJ1XYha5q+5Lyz1gYvM5RGd9ePxmWwom6meigxZlyK5w5Jhz+
   wVzelbnoG1KcnRlv9+4mzbFMIAyEbxTrT8zCN9yPD0gT7fufYKJjVds5J
   Q3hYWsTljEmzcgxE7NY1sj4wc0ZyaUXa2NVM/P81Vi9I0UePyASJX5UqP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455481"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072416"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:22 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 09/15] perf tools: Allow all_cpus to be a superset of user_requested_cpus
Date:   Tue, 24 May 2022 10:54:30 +0300
Message-Id: <20220524075436.29144-10-adrian.hunter@intel.com>
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

To support collection of system-wide events with user requested CPUs,
all_cpus must be a superset of user_requested_cpus.

In order to support all_cpus to be a superset of user_requested_cpus,
all_cpus must be used instead of user_requested_cpus when dealing with CPUs
of all events instead of CPUs of requested events.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

