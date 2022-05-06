Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEF51D79A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378697AbiEFMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391850AbiEFMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E7692BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839985; x=1683375985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CILDTRDmBntiMUnnF2e5/ORuQbnA2p1TKMvnN3FSKGs=;
  b=nyAd8RmIMyLcy9h6xMYTGx156pD9Zea7ugPlh0ydp5c+bCzPJ4EZTV3h
   5A6AHVSjOqc30s9Tf3OFZW5LiktI/1cgQFOleMo4XTH4ngkw5VbIUd4QY
   upltUH0oDx8HMOORSeXPO1ht5kymFIkGvBv9/HZRGYBKeSdiA9Spx1U45
   06siRWNS7ICSvlqozqIV6kplM09XZ23V+f2zlosZfLnF0AFtdJsfO2RpY
   H3SLEZoN2QFbVeG36PvuGz2AVMQTq1FgJD+tXzalwZFDgeCY3Dp0ICFeK
   RXbK33RwaBnfQDZPuibLtSijw3wBrG9DKh4Y++2vaf7CR6ewIKHv7rIwg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045763"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045763"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440786"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/23] libperf evlist: Add evsel as a parameter to ->idx()
Date:   Fri,  6 May 2022 15:25:46 +0300
Message-Id: <20220506122601.367589-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add evsel as a parameter to ->idx() in preparation for correctly
determining whether an auxtrace mmap is needed.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c                  | 2 +-
 tools/lib/perf/include/internal/evlist.h | 3 ++-
 tools/perf/util/evlist.c                 | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 4fce417432aa..ed66f2e38464 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -479,7 +479,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
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

