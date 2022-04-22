Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830850BCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390383AbiDVQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384264AbiDVQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:28:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0DA11155
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644706; x=1682180706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yeBgAM+azx5UIk4Q54bxYbRGOTwsttwK2yuNrO0b0h0=;
  b=O4jgleHjsAzzAEHivZBCvpNGUQk77JOCb4rVV3F+klDzUm4VGhwNy+Gn
   Eitd5ZqIKaiVAvAIfIsrT2Ih8El9urkY5eRHZlfXGi+wtCBjRISOmyrWI
   d37TiiKHxKAw/LYJ20elfUJplB4SiCU/G45crIrkJhLTg3oxUkkTBSPJG
   wywKB/5L+rp88UynqfWGveFQBHFGR3ZgxpOlgxqFq5DQWW59po4NijNvx
   yoh65gfMpNpjnKi6q8G6piZfRqrWLwLWMZ3uapZR32HFg3JEUKKXKnV/T
   AcUb0MZaFeUuzZemKj7gXB6iJUZ4jjLisbs4S3Ld4oWrGUoD9AximTumP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886091"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979268"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:25:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 20/21] perf tools: Allow system-wide events to keep their own CPUs
Date:   Fri, 22 Apr 2022 19:24:01 +0300
Message-Id: <20220422162402.147958-21-adrian.hunter@intel.com>
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

Currently, user_requested_cpus supplants system-wide CPUs when the evlist
has_user_cpus. Change that so that system-wide events retain their own
CPUs and they are added to all_cpus.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9fbcca3fc836..51fd550e326f 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -39,12 +39,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
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

