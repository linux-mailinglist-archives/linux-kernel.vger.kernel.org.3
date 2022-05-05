Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B7551C585
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382214AbiEERBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382196AbiEERBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FA5C872
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769828; x=1683305828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGweQIuzQjj1sqxKQzd0Iobp0kSixyJ9delafznfDK8=;
  b=XRVpcXojvX+PrDGXlhYj8oMiJ3LWvPimohl0d9A8E3bd7AnfvcMEH5M+
   JlBbUMDEv+WYwb+X9TF3TX8W5onzzfkvF2ROOwyeFmUWmpjaOQKKLmNZX
   Eh8BId8Kr+RoOp/BbjZMQ8+z8TLlOyOrPEwSCz0Z+by7zUKdP2o5c4fKP
   NS+iNoPm5QnqfgvyQggGTf2qEwFVk5CsPi9JrxWvLBgVZaY3WxkvAMosI
   2mM4jWY1M6Lyc/F5X93uBz7J9RUnxJ9PgU8Qk+qZi+kRsWt81BF1sVTbi
   /BYcc8BCO2w5W2t6qROio+qXgf4sKf0XjZxw6VPYQpUaXLKBcr3w8YHZ3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717885"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032823"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 08/23] libperf evlist: Add evsel as a parameter to ->idx()
Date:   Thu,  5 May 2022 19:56:24 +0300
Message-Id: <20220505165639.361733-9-adrian.hunter@intel.com>
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

Add evsel as a parameter to ->idx() in preparation for correctly
determining whether an auxtrace mmap is needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                  | 2 +-
 tools/lib/perf/include/internal/evlist.h | 3 ++-
 tools/perf/util/evlist.c                 | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 673c267f900e..ad04da81c367 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -475,7 +475,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			refcount_set(&map->refcnt, 2);
 
 			if (ops->idx)
-				ops->idx(evlist, mp, idx);
+				ops->idx(evlist, evsel, mp, idx);
 
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 0d5c830431a7..6f89aec3e608 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -38,7 +38,8 @@ struct perf_evlist {
 };
 
 typedef void
-(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_mmap_param*, int);
+(*perf_evlist_mmap__cb_idx_t)(struct perf_evlist*, struct perf_evsel*,
+			      struct perf_mmap_param*, int);
 typedef struct perf_mmap*
 (*perf_evlist_mmap__cb_get_t)(struct perf_evlist*, bool, int);
 typedef int
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 09a1d3400fd9..7ae56b062f44 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -747,6 +747,7 @@ static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
 
 static void
 perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
+			 struct perf_evsel *_evsel __maybe_unused,
 			 struct perf_mmap_param *_mp,
 			 int idx)
 {
-- 
2.25.1

