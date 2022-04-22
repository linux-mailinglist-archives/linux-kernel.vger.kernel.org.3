Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA8250BCD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387209AbiDVQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384259AbiDVQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF05E177
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644672; x=1682180672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crxuzt4gLoX8IcXFkNYs+Aei/k0QGJ6XtDfeNQ1ym+k=;
  b=lf05/Bl3Pw/MJPoL8l1UuChcK+4ly02qJQJyDJFdLnQZ6MYB4Sl4H5aJ
   R8owLjIoXLd5RqiSbwwnYPAXeXox5f8WUqz05sIESz2Ez6Zr2BQ+ZoVJy
   AxPGQw3f7XFZAcUdMCGzP0VS1Iuq4nl6o/m8BO52AMVkEQcZBOkNs0hKA
   O9PUjLV+a/Na8J4VGOjE6+XyrOAKxrG/hSmjmt2XNQ2dxJBihQn/RRlOH
   ugj9NImt+4SNSc9gYSu8NE/K3KRc97jp1AX4Qtshsc0ghjeYmdVkeWRuO
   0pItSuP5PjTKPyB64/e1BgUZabofaVQ5M3qZlQkzPqGYYPwK3CGg35OD7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885812"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885812"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978602"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 02/21] libperf evsel: Add perf_evsel__enable_thread()
Date:   Fri, 22 Apr 2022 19:23:43 +0300
Message-Id: <20220422162402.147958-3-adrian.hunter@intel.com>
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

Add perf_evsel__enable_thread() as a counterpart to
perf_evsel__enable_cpu(), to enable all events for a thread.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evsel.c              | 10 ++++++++++
 tools/lib/perf/include/perf/evsel.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 20ae9f5f8b30..2a1f07f877be 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -360,6 +360,16 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
 	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, cpu_map_idx);
 }
 
+int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
+{
+	int err = 0;
+	int i;
+
+	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
+		err = perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i, thread);
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

