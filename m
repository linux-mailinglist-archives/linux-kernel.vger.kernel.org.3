Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7746C51C57C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382179AbiEERAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiEERA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A533E5676C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769807; x=1683305807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cl6vtEwsBomqQSxnvICeUc0UZLkreCqZW5pix9QQYGo=;
  b=GR6m1kxh74uZp4pRYuVTMOrddobPZL+9AdlQlcoXuBTwlznvABOmU3kV
   UvfrxyRR49fke85AEQR1i5xSVf5+0Yu+fD5rlxJY/faQ9HV61Rdhqyl2M
   07IWYNT0p64DVPRFkOeIDRB8s4knGIqsSSTUOjeKBt0nAVKQ2bVvLbLCb
   WBZRl90Bh06r3R9VTO1DGdqKE0ZJov2VhXtGCM0weA5RAsLMJDaKlxa4f
   qejHdJ2YszDXIKmdivcXsuyRpVdDOF+wbBEZHogcTSo18vRoVtAm0B1GP
   oxlef5jj6ijU/cztm+ufd2rpE6vrYAiXmwRUVglcfNRKjSLgT1fdJMNC2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717807"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032733"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 02/23] libperf evsel: Add perf_evsel__enable_thread()
Date:   Thu,  5 May 2022 19:56:18 +0300
Message-Id: <20220505165639.361733-3-adrian.hunter@intel.com>
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

Add perf_evsel__enable_thread() as a counterpart to
perf_evsel__enable_cpu(), to enable all events for a thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evsel.c              | 10 ++++++++++
 tools/lib/perf/include/perf/evsel.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 20ae9f5f8b30..dcc928dd25f8 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
 }
 
+int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
+{
+	int err = 0;
+	int idx;
+
+	for (idx = 0; idx < xyarray__max_x(evsel->fd) && !err; idx++)
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, idx, thread);
+	return err;
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

