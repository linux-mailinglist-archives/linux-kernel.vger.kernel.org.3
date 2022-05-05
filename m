Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E351C580
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiEERAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382188AbiEERAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6765C84B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769816; x=1683305816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmgLT3++XhqTWVdBdh5S0YpkjcFM/rxG/d0fFbdGMr8=;
  b=kXc8ehNJQWg9I47COANY75Ai2RjG9NyfbiHbplZYlhzf2neqsAaQS6BL
   z3V3GHIXADBsdcwsSLG6y0S6Y6Ex5fL90p+YwVm4Ebz7T+Qarp+4ZZ3Sh
   mM4vn34qc7MUtnE809PQgynDUl6NcZ2jSpQi4Rclc2l+W7an3x3EywtEx
   6DnuAzzk0YPw8Qit4Iz9DeOoPmlK7Ov1W4igj1zgeVv+5PTGSI7aQS50H
   Ypg8M3yAGa8bLGtfeKVRGXYJkc5D+jdveP/s3DfmL7JjYk4kOZ88vkrE+
   EuuqNqKNwlMousz8LQNmZCTeYtB8QR78xY3Cc+YDklChriPYosmN8MK5I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717823"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032781"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:53 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 05/23] perf auxtrace: Do not mix up mmap idx
Date:   Thu,  5 May 2022 19:56:21 +0300
Message-Id: <20220505165639.361733-6-adrian.hunter@intel.com>
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

The idx is with respect to evlist not evsel. That hasn't mattered because
they are the same at present. Prepare for that not being the case, which it
won't be when sideband tracking events are allowed on all CPUs even when
auxtrace is limited to selected CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 10936a38031f..b11549ae39df 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -640,8 +640,14 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
 {
 	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
 
-	if (per_cpu_mmaps)
-		return perf_evsel__enable_cpu(&evsel->core, idx);
+	if (per_cpu_mmaps) {
+		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
+		int cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
+
+		if (cpu_map_idx == -1)
+			return -EINVAL;
+		return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
+	}
 
 	return perf_evsel__enable_thread(&evsel->core, idx);
 }
-- 
2.25.1

