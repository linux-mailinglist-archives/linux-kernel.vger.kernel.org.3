Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A251D7A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiEFMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391936AbiEFMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:31:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569469CE2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840020; x=1683376020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTtoB8qJmnTAP7gdy08K2/84cmvK2f3oN4KlLARHgnY=;
  b=TkirqcuHakRBCdZtJzJcjoEulZpe/9QGP284wrGoVSks+223pM+ll2fO
   PmPFzDPqndjCuCAsXU/cMeUxfYyp2lsBGTcDO7yvtKR60lGYE+V92nzV0
   Z4o1LUj+1A5VG4Ha2Wr9KnBcbwH0M8UxHdoD27oIRKXxE33+tiCnxVGhw
   aX17w0xu1LU8AOuXjJMdiK4EiqxHiUsG6+IQMaQFz7Huk1YGrG7SfkbPb
   Jg7nD5/s7VIhHq3S3eYpXhhlPT+RWSYkSWINgGdmxI/O7ciX6shwDZFpM
   RFkzEdYz1NqsEK+GsOzOOWwd4SqcNlN6I2InXQwyOVMpBGQJIAPm4LGNL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045881"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045881"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709441172"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 22/23] perf tools: Allow system-wide events to keep their own CPUs
Date:   Fri,  6 May 2022 15:26:00 +0300
Message-Id: <20220506122601.367589-23-adrian.hunter@intel.com>
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

Currently, user_requested_cpus supplants system-wide CPUs when the evlist
has_user_cpus. Change that so that system-wide events retain their own
CPUs and they are added to all_cpus.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 1c801f8da44f..9a6801b53274 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -40,12 +40,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->own_cpus || evlist->has_user_cpus) {
-		perf_cpu_map__put(evsel->cpus);
-		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
-	} else if (!evsel->system_wide &&
-		   !evsel->requires_cpu &&
-		   perf_cpu_map__empty(evlist->user_requested_cpus)) {
+	if (!evsel->own_cpus ||
+	    (!evsel->system_wide && evlist->has_user_cpus) ||
+	    (!evsel->system_wide &&
+	     !evsel->requires_cpu &&
+	     perf_cpu_map__empty(evlist->user_requested_cpus))) {
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__get(evlist->user_requested_cpus);
 	} else if (evsel->cpus != evsel->own_cpus) {
-- 
2.25.1

