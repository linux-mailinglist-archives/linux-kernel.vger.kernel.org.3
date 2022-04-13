Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD74FF5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiDMLo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiDMLo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:44:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A325B3F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649850155; x=1681386155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pc/6HPO4blcqQ8mb57rhAC2N4j6pix5v/8x3MNiluX0=;
  b=FJtnwzR8eCS4UVvtEsWX6xDxtW7YKIwLLUewaS1qFMJA+mdXDyWtsJt9
   eZ5Yh3A6pvpniA6sLG7Xoax7/eVdkXFeswYqoi3IfhhuL9885cAzgtaTC
   9hjI7s9I0b+Kxot1w7nHnkkHFtH71yNl0TbQHjqHrnZ1/3N8d4CIWDfkM
   34rc7z8nzm5Md5pmZS56KHSHz554rOqCSjgAS3AqBifhKrQC3ArWdHN0U
   xEnMh+0oPyMbpXGnjwlipRuX+fRh0aX40lQP1+JJHsdOm9yZ0BLGFB5R6
   InQcUZwGNTZFAJ7WvMDW2YNNZwpROz9VypjCl8GtWNXWm1M6dgFqYVFYJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249930915"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="249930915"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="660898227"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2022 04:42:33 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix segfault accessing sample_id xyarray
Date:   Wed, 13 Apr 2022 14:42:32 +0300
Message-Id: <20220413114232.26914-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_evsel sample_id is an xyarray which can cause a segfault when
accessed beyond its size. e.g.

 # perf record -e intel_pt// -C 1 sleep 1
 Segmentation fault (core dumped)

That is happening because a dummy event is opened to capture text poke
events accoss all CPUs, however the mmap logic is allocating according
to the number of user_requested_cpus.

In general, perf sometimes uses the evsel cpus to open events, and
sometimes the evlist user_requested_cpus. However, it is not necessary
to determine which case is which because the opened event file
descriptors are also in an xyarray, the size of whch can be used
to correctly allocate the size of the sample_id xyarray, because there
is one ID per file descriptor. Note, in the affected code path,
perf_evsel fd array is subsequently used to get the file descriptor for
the mmap, so it makes sense for the xyarrays to be the same size there.

Fixes: 246eba8e9041c4 ("perf tools: Add support for PERF_RECORD_TEXT_POKE")
Fixes: d1a177595b3a82 ("libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf")
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 1b15ba13c477..a09315538a30 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -577,7 +577,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 {
 	struct perf_evsel *evsel;
 	const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
-	const struct perf_thread_map *threads = evlist->threads;
 
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
@@ -589,7 +588,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	perf_evlist__for_each_entry(evlist, evsel) {
 		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
 		    evsel->sample_id == NULL &&
-		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
+		    perf_evsel__alloc_id(evsel, evsel->fd->max_x, evsel->fd->max_y) < 0)
 			return -ENOMEM;
 	}
 
-- 
2.25.1

