Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51A951D797
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391861AbiEFMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391817AbiEFMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEFA6623A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839978; x=1683375978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LRq1SlY2gGua71JaYm5rJE61X/sDRu2yHyaAYqwOIkw=;
  b=eKSBwUKE3NfdTi2SR5ieFRZpDXyBgyqCszSrxcSAsqfHy88aewQ18yF4
   7HsP50ZfCrSWCvmrRrmOta9hMk4w7a8Nc+Cc0+qZLutcSJIdCc096WsJH
   JAu837YkYeDP8moFFB23mJtfpzaMni5ZrmtME9y2a/Wrs+HgRsysBLtao
   /XvFznicRfi1sFDDheOU/okFpY8r6QDItoGedFKY7krIzFGMCXYIr7pQr
   F8h73SHabz1FC5JFJshm+fzg2MISRrXMhrmIjQ6qn6naK9sM8WBceLcwv
   Rc5UQoQPEitKIxDN5jI0KzHNaNQ0hJi4QEDOGuolhtezHI+maYLAMjyXa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045745"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045745"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440712"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/23] perf auxtrace: Do not mix up mmap idx
Date:   Fri,  6 May 2022 15:25:43 +0300
Message-Id: <20220506122601.367589-6-adrian.hunter@intel.com>
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

The idx is with respect to evlist not evsel. That hasn't mattered because
they are the same at present. Prepare for that not being the case, which it
won't be when sideband tracking events are allowed on all CPUs even when
auxtrace is limited to selected CPUs.

Acked-by: Ian Rogers <irogers@google.com>
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

