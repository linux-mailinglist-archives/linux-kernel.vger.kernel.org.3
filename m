Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D243D50BCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385749AbiDVQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349391AbiDVQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E95E154
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644667; x=1682180667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9mnztbVnyldzRTetwx2U1m/QSQPsG+fgVUfId7SMwU=;
  b=mp2jSdKiNkrvo4jHlSIW+j/FmjiNvyBjYbvgJggB23WheuZ3hb9H0gpE
   TfOES18L1CYrsje4lrYeA4lTuOJYr4Hfg0d/KvFl+AMijr/4r/FYASxXj
   XxxxcqlZrLOn8hmidXkaVXN/WL/txP9WCMUtDWqLBt9jTMTPTtl+wHole
   QAlMIdl/yCLk04O9fYrQ24sfAXDtm1v1dOXTOwpbc44E5byujqarDjxNo
   GHD95e5pk/QQ82QvaytX/k4r1O7VpyA7Q5z3oEMCwsione8VEsZAj+gzp
   H8HwP1VRl17LW+Y0RfRc1jo0z8/8EQlyLFG2qV2d02TsmykuychyPwk04
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885791"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885791"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978578"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 01/21] libperf evsel: Factor out perf_evsel__ioctl()
Date:   Fri, 22 Apr 2022 19:23:42 +0300
Message-Id: <20220422162402.147958-2-adrian.hunter@intel.com>
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

Factor out perf_evsel__ioctl() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evsel.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 210ea7c06ce8..20ae9f5f8b30 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -328,6 +328,17 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 	return 0;
 }
 
+static int perf_evsel__ioctl(struct perf_evsel *evsel, int ioc, void *arg,
+			     int cpu_map_idx, int thread)
+{
+	int *fd = FD(evsel, cpu_map_idx, thread);
+
+	if (fd == NULL || *fd < 0)
+		return -1;
+
+	return ioctl(*fd, ioc, arg);
+}
+
 static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 				 int ioc,  void *arg,
 				 int cpu_map_idx)
@@ -335,13 +346,7 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 	int thread;
 
 	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
-		int err;
-		int *fd = FD(evsel, cpu_map_idx, thread);
-
-		if (fd == NULL || *fd < 0)
-			return -1;
-
-		err = ioctl(*fd, ioc, arg);
+		int err = perf_evsel__ioctl(evsel, ioc, arg, cpu_map_idx, thread);
 
 		if (err)
 			return err;
-- 
2.25.1

