Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71050BCEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387585AbiDVQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384500AbiDVQ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:28:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A05F4D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644707; x=1682180707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+j3iX2VD2lFE9udYfL2G3MvXc1UL3QsUfNRYOFA+AGI=;
  b=cVUim6ki3o/FtLSYueYsJV1xaTihWCpuxKd1bH8U+8ZSw4Ey5pAGrTD5
   ZL4q888LStejmZtPnatAAVGxcJiAfQWCjugmO5Dwq54xw1+skre7VzzEa
   oUS8k7O3P66XGOipwcYknYqKHMk15b0lFX5Adj/yLwssT7Kz74NjT/8Gr
   0bCPAapO5QqabonrcZLiKfasZZmJ5TqngDky89wV3Av5hg0JvuLbmJ3CS
   jgskNg5JG3SWpgZR5t2yhMk2VYzcwMebiXFpnXdkBNVcVDFgVr0KTmEI0
   s6TSrPTs+Fhr18QcHYMPW+jGIiDMqnM0GE+iW+jPRkn0T9pjVGI51YKaP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264886111"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264886111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577979314"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:25:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 21/21] perf tools: Allow system-wide events to keep their own threads
Date:   Fri, 22 Apr 2022 19:24:02 +0300
Message-Id: <20220422162402.147958-22-adrian.hunter@intel.com>
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

System-wide events do not have threads, so do not propagate threads to
them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 51fd550e326f..076a27650491 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -51,8 +51,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
-	perf_thread_map__put(evsel->threads);
-	evsel->threads = perf_thread_map__get(evlist->threads);
+	if (!evsel->system_wide) {
+		perf_thread_map__put(evsel->threads);
+		evsel->threads = perf_thread_map__get(evlist->threads);
+	}
+
 	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
-- 
2.25.1

