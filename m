Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35550BCE2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445263AbiDVQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387885AbiDVQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7A5E15B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644686; x=1682180686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vt1k0LQ7FZrACCG80zbmslw1bj5E6h5aWaZBqnwMCLU=;
  b=KTqeMHwLwQyY0RmIsyrXB+I6EazsUC1oy5pj637Wz6bOygG0dISN20wQ
   7k8i0uxPVN03ut5RXdqjZs2yI824iMYnmieWUjexEr/8TXVDAxiAd0A9g
   DoE0BV7fL3aHo+CyHWvc3qeQYjmHyjIuzWGgdkW3TxsSqjzpJJNLn5D+F
   RQmXv99ANyRUzG5aWScWkCLntKp5eq16qg8uQ46V2bLAo/xnp4aZhmVnh
   e/9MHJrH58L/hait/JDBzRODrdzU+le6BFJdn3FIQ0TDWQIqsR1CE5l4T
   L7sGus2H8S6/lJkbntghbGiV750rifggjb/hJVDKfPnIN761FCpGb56pn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885925"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978784"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:31 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 10/21] perf auxctrace: Add mmap_needed to auxtrace_mmap_params
Date:   Fri, 22 Apr 2022 19:23:51 +0300
Message-Id: <20220422162402.147958-11-adrian.hunter@intel.com>
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

Add mmap_needed to auxtrace_mmap_params.

Currently an auxtrace mmap is always attempted even if the event is not an
auxtrace event. That works because, when AUX area tracing, there is always
an auxtrace event first for every mmap. Prepare for that not being the
case, which it won't be when sideband tracking events are allowed on
all CPUs even when auxtrace is limited to selected CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++--
 tools/perf/util/auxtrace.h |  7 +++++--
 tools/perf/util/evlist.c   |  5 +++--
 tools/perf/util/mmap.c     |  1 +
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2d015b0be549..9f01ce405971 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -125,7 +125,7 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 	mm->tid = mp->tid;
 	mm->cpu = mp->cpu.cpu;
 
-	if (!mp->len) {
+	if (!mp->len || !mp->mmap_needed) {
 		mm->base = NULL;
 		return 0;
 	}
@@ -168,9 +168,15 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 }
 
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu)
 {
+	mp->mmap_needed = evsel->needs_auxtrace_mmap;
+
+	if (!mp->mmap_needed)
+		return;
+
 	mp->idx = idx;
 
 	if (per_cpu) {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index dc38b6f57232..4e715e2d9291 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -353,6 +353,7 @@ struct auxtrace_mmap_params {
 	int		prot;
 	int		idx;
 	pid_t		tid;
+	bool		mmap_needed;
 	struct perf_cpu	cpu;
 };
 
@@ -490,7 +491,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
@@ -863,7 +865,8 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				unsigned int auxtrace_pages,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
-				   struct evlist *evlist, int idx,
+				   struct evlist *evlist,
+				   struct evsel *evsel, int idx,
 				   bool per_cpu);
 
 #define ITRACE_HELP ""
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7ae56b062f44..996bdc203616 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -747,15 +747,16 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
 static void
 perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
-			 struct perf_evsel *_evsel __maybe_unused,
+			 struct perf_evsel *_evsel,
 			 struct perf_mmap_param *_mp,
 			 int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
 	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
 	bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
+	struct evsel *evsel = container_of(_evsel, struct evsel, core);
 
-	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
 }
 
 static struct perf_mmap*
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 50502b4a7ca4..de59c4da852b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -62,6 +62,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
 
 void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
 					  struct evlist *evlist __maybe_unused,
+					  struct evsel *evsel __maybe_unused,
 					  int idx __maybe_unused,
 					  bool per_cpu __maybe_unused)
 {
-- 
2.25.1

