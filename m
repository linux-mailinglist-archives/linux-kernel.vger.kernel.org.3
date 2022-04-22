Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698750BCDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445313AbiDVQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387886AbiDVQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A55E154
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644687; x=1682180687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ys8Hk8eQF8BRhiZkARHIem+hTKbaKHklfvSW0EfMEQ0=;
  b=Xye53/Q/jH0Em9EEEby69n7nzQeiDcIoIDdFB1yJMtXNggtWztL3uPhI
   Iir2LCsgKub5LW1UNu2AXaeCDFLWDloQHTA6b/uIbt315Xhedmz8kH7i+
   vVOtcjDO1KTHoOLptyCfGJL8VqZ+GA00/9EjxFB2/1EAGpFZZiunatGV7
   GJ5Os2/5jypfG9PvbhCyJJrm9EWfChGOaoL+a6Z4Qw+g3K1aWfxo+VPWz
   apFdFshE8UP/rIIkdfvcelvprnExAX0y6nIauu9gMzd1Aah8f4tj00C1Q
   NMeawdErTSWqfUzHUux76GUAKUk64eyiHX31bxLxuXW2sQeJcc+/3Pkcl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885946"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885946"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978822"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 11/21] perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
Date:   Fri, 22 Apr 2022 19:23:52 +0300
Message-Id: <20220422162402.147958-12-adrian.hunter@intel.com>
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

Remove auxtrace_mmap_params__set_idx() per_cpu parameter because it isn't
needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 5 +++--
 tools/perf/util/auxtrace.h | 3 +--
 tools/perf/util/evlist.c   | 3 +--
 tools/perf/util/mmap.c     | 3 +--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9f01ce405971..246afe99a7fb 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -169,9 +169,10 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct evlist *evlist,
-				   struct evsel *evsel, int idx,
-				   bool per_cpu)
+				   struct evsel *evsel, int idx)
 {
+	bool per_cpu = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
+
 	mp->mmap_needed = evsel->needs_auxtrace_mmap;
 
 	if (!mp->mmap_needed)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 4e715e2d9291..7931c34f749a 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -492,8 +492,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct evlist *evlist,
-				   struct evsel *evsel, int idx,
-				   bool per_cpu);
+				   struct evsel *evsel, int idx);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
 				  struct mmap *map,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 996bdc203616..25eae096bdac 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -753,10 +753,9 @@ perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
 	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
-	bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
 	struct evsel *evsel = container_of(_evsel, struct evsel, core);
 
-	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx, per_cpu);
+	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx);
 }
 
 static struct perf_mmap*
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index de59c4da852b..a4dff881be39 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -63,8 +63,7 @@ void __weak auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp __maybe_u
 void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __maybe_unused,
 					  struct evlist *evlist __maybe_unused,
 					  struct evsel *evsel __maybe_unused,
-					  int idx __maybe_unused,
-					  bool per_cpu __maybe_unused)
+					  int idx __maybe_unused)
 {
 }
 
-- 
2.25.1

