Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E650BCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442143AbiDVQ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiDVQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22345E177
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644677; x=1682180677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JeksS6bnKFmwHzFH4xpgce6NWCYiDTaFYm7w7oziyGI=;
  b=JAG8OLS7uCA1w+eS3sBzY3y0zX+mhb9szyCrMZ8oOWcQOWB32GXdxurI
   43exNpZzJ3M5axfiN63NktlZcLBjurqKOuVR6m4yC20bhQ+RysIX1aN8C
   zhoCvhd06th0yDLcbmmCKe6joLiCY/dX6OA6g+xLTDBv3/VV2V1WQfKXV
   YszzAJu/Bw8lFisDafTUPPx21L1/BY0vmed4MdhlR1mzy+G4GuwU9SoWm
   O1RUTQIgVl3+CtrgnKP5z0u3cIQ3gWXjxhg/4U76/01jpNCqmJU/PwJs+
   EgLS1DH8FezuK/cmGkGqt00Vue4t5sjYjNJIqIQPCxT+rwz+XfXginSkd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885870"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885870"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978711"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 06/21] libperf evlist: Remove ->idx() per_cpu parameter
Date:   Fri, 22 Apr 2022 19:23:47 +0300
Message-Id: <20220422162402.147958-7-adrian.hunter@intel.com>
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

