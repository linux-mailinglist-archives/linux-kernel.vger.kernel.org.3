Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8E750BCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358264AbiDVQ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381177AbiDVQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877538B6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644702; x=1682180702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kh5GrxX7BtQNX/p26r5XNPIn2pP8qTcb4tHRBFpRyNw=;
  b=GZE1IKkflgHp7evaKz9rXJb4TmXFq2XoRlK4CweeJYeFZvpjAf9Oc3XE
   u4Y21LEphwdhG5Q2O2iPuL0m3d2/2CkZPo/5gh1/tW3kVe/ryroq+XXqA
   qKzVfjhDRxC+SGrknlb9cqylLXImKJEIMk9vX77DOQfqb+hQSB321tV3J
   HhRLpIXjd9+XhUeGTsw8ekFt0S7Z7DjLWttkaTjKq8xhFFITrnJCe8Nx1
   vhwjiJY+xG+5S9FPylaG0HyrwRQZA9OfKPWnyn98i6UfkQZM93Peqt/6T
   W1znKi9S9r3Qb6FWjQyx5NeycHXAXkhaI4Okc7fPeLki2LB6YZABArIrU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886074"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979224"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 19/21] perf stat: Add requires_cpu flag for uncore
Date:   Fri, 22 Apr 2022 19:24:00 +0300
Message-Id: <20220422162402.147958-20-adrian.hunter@intel.com>
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

Uncore events require a CPU i.e. it cannot be -1.

The evsel system_wide flag is intended for events that should be on every
CPU, which does not make sense for uncore events because uncore events do
not map one-to-one with CPUs.

These 2 requirements are not exactly the same, so introduce a new flag
'requires_cpu' the uncore case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                 | 4 +++-
 tools/lib/perf/include/internal/evsel.h | 1 +
 tools/perf/builtin-stat.c               | 5 +----
 tools/perf/util/evsel.c                 | 1 +
 tools/perf/util/parse-events.c          | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 37dfa9d936a7..9fbcca3fc836 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -42,7 +42,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	if (!evsel->own_cpus || evlist->has_user_cpus) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
-	} else if (!evsel->system_wide && perf_cpu_map__empty(evlist->user_requested_cpus)) {
+	} else if (!evsel->system_wide &&
+		   !evsel->requires_cpu &&
+		   perf_cpu_map__empty(evlist->user_requested_cpus)) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index cfc9ebd7968e..77fbb8b97e5c 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -50,6 +50,7 @@ struct perf_evsel {
 	/* parse modifier helper */
 	int			 nr_members;
 	bool			 system_wide;
+	bool			 requires_cpu;
 	int			 idx;
 };
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a96f106dc93a..8972ae546cfe 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -364,9 +364,6 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu_
 	if (!counter->supported)
 		return -ENOENT;
 
-	if (counter->core.system_wide)
-		nthreads = 1;
-
 	for (thread = 0; thread < nthreads; thread++) {
 		struct perf_counts_values *count;
 
@@ -2224,7 +2221,7 @@ static void setup_system_wide(int forks)
 		struct evsel *counter;
 
 		evlist__for_each_entry(evsel_list, counter) {
-			if (!counter->core.system_wide &&
+			if (!counter->core.requires_cpu &&
 			    strcmp(counter->name, "duration_time")) {
 				return;
 			}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2a1729e7aee4..81bbddb6fbc0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -382,6 +382,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.threads = perf_thread_map__get(orig->core.threads);
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
+	evsel->core.requires_cpu = orig->core.requires_cpu;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dd84fed698a3..783359017548 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -350,7 +350,7 @@ __add_event(struct list_head *list, int *idx,
 	(*idx)++;
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
-	evsel->core.system_wide = pmu ? pmu->is_uncore : false;
+	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
 	if (name)
-- 
2.25.1

