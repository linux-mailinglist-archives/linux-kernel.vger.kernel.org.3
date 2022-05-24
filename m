Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75838532486
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiEXHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiEXHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F662985AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378911; x=1684914911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tnfulP8MLCckn6uYuu2Vb8zrtRzNC5Wc8mW3rYdpUYg=;
  b=V8j69auLBanvUZSqV7FJ5TvMICS/OMyTDlZFFaT54BuMJ43ywUxuDA6f
   uWbCwVyfc+rlcesXSgCpuLbYYQMX983lmvrW70azWqbncWbIol4QouT+9
   RJLhIUnwgRHBcy5eUp0iUybtcbthSr7+KfaGRCiu7CUBr936sK5TObJYZ
   zoTPVPIZawV0Jj80LhDz1UDZQUduq9p6aA3iDUxFN7V3yRDW0XMG5m5+5
   ySWanbcvS1qjuOY0Bs9NbBXTxcuNXdpdTgSmHWvb/e/Ta+y9hefkRsc3s
   xuhTmy0FULrJLgupkxcq8KjAE4cyJIwwrgb9Psc4hvdm7Jn/nJuIZrSIE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455427"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072369"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 03/15] perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
Date:   Tue, 24 May 2022 10:54:24 +0300
Message-Id: <20220524075436.29144-4-adrian.hunter@intel.com>
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

Remove auxtrace_mmap_params__set_idx() per_cpu parameter because it isn't
needed.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 5 +++--
 tools/perf/util/auxtrace.h | 6 ++----
 tools/perf/util/evlist.c   | 3 +--
 tools/perf/util/mmap.c     | 3 +--
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b446cfa66469..ac4e4660932d 100644
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
index 695591b73ae1..cd0d25c2751c 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -496,8 +496,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct evlist *evlist,
-				   struct evsel *evsel, int idx,
-				   bool per_cpu);
+				   struct evsel *evsel, int idx);
 
 typedef int (*process_auxtrace_t)(struct perf_tool *tool,
 				  struct mmap *map,
@@ -870,8 +869,7 @@ void auxtrace_mmap_params__init(struct auxtrace_mmap_params *mp,
 				bool auxtrace_overwrite);
 void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 				   struct evlist *evlist,
-				   struct evsel *evsel, int idx,
-				   bool per_cpu);
+				   struct evsel *evsel, int idx);
 
 #define ITRACE_HELP ""
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9e0fabfb096d..157867bc337a 100644
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

