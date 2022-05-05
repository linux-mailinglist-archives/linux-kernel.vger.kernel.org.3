Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD451C582
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382195AbiEERBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382189AbiEERAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2D5A17E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769818; x=1683305818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeksS6bnKFmwHzFH4xpgce6NWCYiDTaFYm7w7oziyGI=;
  b=ke9ytB17P8mLwzwrPyiZlqPgKeIT2sWOvfEf8Ffs1TGbw5ojjwCmbMBJ
   AQddAse2d3HSxOhxHn1LcRZalmoptGizBF35TRJjhKuUskBtR11dgYc5h
   I0HSxoCsnBwhV3naZzM9HKFiBsjzv5z/1Qi6975jZj8m2pmoaLwL74Reu
   1ocCt4LfolhaTS257vINvboqHICeREtmDtqEYTr4xyLFLyjb6ty8UBZ3v
   k0QpxaN3euaWLkuR+Me9dalwHu+vjxcACyAxROMAphcqxJJEvX0lRNlTm
   cDAjht7qn17B+TLFUyDWKLQLHSN1MHT4qANYVeVPpKADZiNwG5Q4X9X/d
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717830"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032795"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 06/23] libperf evlist: Remove ->idx() per_cpu parameter
Date:   Thu,  5 May 2022 19:56:22 +0300
Message-Id: <20220505165639.361733-7-adrian.hunter@intel.com>
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

Remove ->idx() per_cpu parameter because it isn't needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                  | 4 ++--
 tools/lib/perf/include/internal/evlist.h | 2 +-
 tools/perf/util/evlist.c                 | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index a09315538a30..6d0fa7b2f417 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -517,7 +517,7 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output_overwrite = -1;
 
 		if (ops->idx)
-			ops->idx(evlist, mp, thread, false);
+			ops->idx(evlist, mp, thread);
 
 		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
@@ -544,7 +544,7 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output_overwrite = -1;
 
 		if (ops->idx)
-			ops->idx(evlist, mp, cpu, true);
+			ops->idx(evlist, mp, cpu);
 
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index e3e64f37db7b..0d5c830431a7 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -38,7 +38,7 @@ struct perf_evlist {
 };
 
 typedef void
-(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int, bool);
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 typedef int
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f1309b39afe4..09a1d3400fd9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -748,10 +748,11 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 static void
 perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
 			 struct perf_mmap_param *_mp,
-			 int idx, bool per_cpu)
+			 int idx)
 {
 	struct evlist *evlist = container_of(_evlist, struct evlist, core);
 	struct mmap_params *mp = container_of(_mp, struct mmap_params, core);
+	bool per_cpu = !perf_cpu_map__empty(_evlist->user_requested_cpus);
 
 	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, idx, per_cpu);
 }
-- 
2.25.1

