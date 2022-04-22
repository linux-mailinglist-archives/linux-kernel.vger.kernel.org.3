Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523CF50BCD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387856AbiDVQ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385768AbiDVQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E35E154
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644678; x=1682180678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFxZCaU099DWCjXsHRUPf+lvv9DZP9KOIRECSKOskcM=;
  b=ULtW8UtsrCf/HBlgE9N64JIbwQ8d90h2WGx5Z7/f78ZSDd3LgEh5bYI8
   nQHsSnoO7gb7aZZQ4eSohd2styvRftvlGjdUP/ql5Pp7vHr7l2ADzUP24
   CyJLKTdhyQBw6KxjszNWTncXZp6hd2vdz1TKEE6m5/ozCniyLudMjR7Za
   DstZszr2mDrBlCNdQegffmH46LMW17T3mXw+VcN9SPnDAVjNShk91Dn/T
   siHNuzohLD2wmjMHzMKoLmO300OizlHwn89BczE4bl1G6wsQI1SPGpmrr
   H30VtBTB0eby+V8jlXBZ7XcEpLu2yZAbVkZhdIThLhUFxLR1ssD8Z/TWw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885892"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885892"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978731"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 07/21] libperf evlist: Move ->idx() into mmap_per_evsel()
Date:   Fri, 22 Apr 2022 19:23:48 +0300
Message-Id: <20220422162402.147958-8-adrian.hunter@intel.com>
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

Move ->idx() into mmap_per_evsel() in preparation for adding evsel as a
parameter.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 6d0fa7b2f417..673c267f900e 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -474,6 +474,9 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			 */
 			refcount_set(&map->refcnt, 2);
 
+			if (ops->idx)
+				ops->idx(evlist, mp, idx);
+
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
@@ -516,9 +519,6 @@ mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output = -1;
 		int output_overwrite = -1;
 
-		if (ops->idx)
-			ops->idx(evlist, mp, thread);
-
 		if (mmap_per_evsel(evlist, ops, thread, mp, 0, thread,
 				   &output, &output_overwrite))
 			goto out_unmap;
@@ -543,9 +543,6 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 		int output = -1;
 		int output_overwrite = -1;
 
-		if (ops->idx)
-			ops->idx(evlist, mp, cpu);
-
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (mmap_per_evsel(evlist, ops, cpu, mp, cpu,
 					   thread, &output, &output_overwrite))
-- 
2.25.1

