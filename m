Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E851D792
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391784AbiEFM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391771AbiEFM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:29:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002C65D67B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839969; x=1683375969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrXoe0hgaEcEZHX/TJlJBZD3R2f/+XqTEOuTr09xmSY=;
  b=WW10p5pnjiHGhBndWGXhiR0PuMEsC9NL0kj7hUon8M4fnhUTPCEgUEmI
   fe0fmVjWAxa9fwh96jWrHoqQm6mjXuC6zy9EVrXEi5916DYgVCC5RQDaj
   j0UyUjCXpMwkOtwG0Vo9IwoNpCrZM3oQndGbOCyBLzP51t6Kmhu+FnrRT
   Q2Ha0g0+Wbt2nFykFE7uR0aSbZgms4h3gU1HzRANzbSfO7+Misu2VBWjt
   mDTyxq2qyHbQjBEDZXwWYlaGU6WCEQoQsTaaA/L+nDXbdqFLdkLhJJwiC
   CBb3GJdyB/J3OsHgh6xLp8CavovPhX0nRLNXuucZ+/v/MuXfUvo18Wbfh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045732"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045732"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440665"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:07 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/23] libperf evsel: Add perf_evsel__enable_thread()
Date:   Fri,  6 May 2022 15:25:40 +0300
Message-Id: <20220506122601.367589-3-adrian.hunter@intel.com>
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

Add perf_evsel__enable_thread() as a counterpart to
perf_evsel__enable_cpu(), to enable all events for a thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evsel.c              | 15 +++++++++++++++
 tools/lib/perf/include/perf/evsel.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 20ae9f5f8b30..c1d58673f6ef 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -360,6 +360,21 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
 }
 
+int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
+{
+	struct perf_cpu cpu __maybe_unused;
+	int idx;
+	int err;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
 	int i;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 2a9516b42d15..699c0ed97d34 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -36,6 +36,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
+LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
 LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
-- 
2.25.1

