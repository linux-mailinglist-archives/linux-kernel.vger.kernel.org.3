Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5CE51C589
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382340AbiEERBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382342AbiEERBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A95C87A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769852; x=1683305852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UpgVFgUE2PaQffkjiMSXUxg1tvHVUR9x+gRJXm4AnpQ=;
  b=JP2QFuVxzmAkHtofeknsSQITcDRfAg8ED57KeALUf32nMFYFCCOjT8nK
   zSuAiqjjEq/SyjUafexfNIV8igYDl6h/fgmnRFnxkBH1eCCD0L09zABgZ
   VrOtkxi9DFefUSCkITTgx66EbK6o78xrldMIREKnzwjvo2PLR7Pw4WzIk
   CZSMZ7A2ts5lRedC3z+fIKKo1kI/8VodW87jj/4Ok9sYa7yp3ZBs362g6
   ihnBL0i5Av/K7PwWKQBvrlo6BWx34Y6AFborkRfm2xqR8XvZtNeoCsva+
   fGB2dtWD6qo52UdCgdEAgExEdo/YiR8OI7q+mO5LkcZhQpVTtr9sP033G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718038"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032859"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 11/23] perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
Date:   Thu,  5 May 2022 19:56:27 +0300
Message-Id: <20220505165639.361733-12-adrian.hunter@intel.com>
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

