Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA550BCD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384259AbiDVQ2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384296AbiDVQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED595E15B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644673; x=1682180673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96NhVcF681Cf6EUdn2T2JGsKemHJ0OT0snZUFHPMbgc=;
  b=LfdsGX3bb1T10cZcqGW5X+5ecOdrmuRAFCjl2vtBGV8dmQFPbQ3KQMEn
   dublefkvCmnLPasFZawTe0eVfG1jsT2flgGxZMpZ8LMs/t1mEmplANYuo
   JWYdq12XHSga4F9yj3kosPNhB0SpGDoteSq+PePcre2/oNJsVpbOOUPvn
   lmx7StghxReKrmLY0WccgOa7anbUva4S6Otbki/Q9JnbunjSL/J5rSRo/
   BOfAfCxAjzGqPH7YD3NIdqxYEIEsBU9KUdic+IG7tuhckSRM9xFoowKH2
   t87juokpAgO5wMHu/z+pF8EXoj7CpvrjDiIVlhRu5Uc/+eIYWG7WZqqun
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885824"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885824"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978618"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 03/21] perf evlist: Use libperf functions in evlist__enable_event_idx()
Date:   Fri, 22 Apr 2022 19:23:44 +0300
Message-Id: <20220422162402.147958-4-adrian.hunter@intel.com>
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

evlist__enable_event_idx() is used only for auxtrace events which are never
system_wide. Simplify by using libperf enable event functions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.c | 44 ++--------------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 52ea004ba01e..9fcecf7daa62 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -334,14 +334,6 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
 	return 0;
 }
 
-static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
-{
-	if (evsel->core.system_wide)
-		return 1;
-	else
-		return perf_thread_map__nr(evlist->core.threads);
-}
-
 struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
 {
 	struct evlist_cpu_iterator itr = {
@@ -546,46 +538,14 @@ void evlist__toggle_enable(struct evlist *evlist)
 	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
 }
 
-static int evlist__enable_event_cpu(struct evlist *evlist, struct evsel *evsel, int cpu)
-{
-	int thread;
-	int nr_threads = evlist__nr_threads(evlist, evsel);
-
-	if (!evsel->core.fd)
-		return -EINVAL;
-
-	for (thread = 0; thread < nr_threads; thread++) {
-		int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
-static int evlist__enable_event_thread(struct evlist *evlist, struct evsel *evsel, int thread)
-{
-	int cpu;
-	int nr_cpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
-
-	if (!evsel->core.fd)
-		return -EINVAL;
-
-	for (cpu = 0; cpu < nr_cpus; cpu++) {
-		int err = ioctl(FD(evsel, cpu, thread), PERF_EVENT_IOC_ENABLE, 0);
-		if (err)
-			return err;
-	}
-	return 0;
-}
-
 int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
 {
 	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
 
 	if (per_cpu_mmaps)
-		return evlist__enable_event_cpu(evlist, evsel, idx);
+		return perf_evsel__enable_cpu(&evsel->core, idx);
 
-	return evlist__enable_event_thread(evlist, evsel, idx);
+	return perf_evsel__enable_thread(&evsel->core, idx);
 }
 
 int evlist__add_pollfd(struct evlist *evlist, int fd)
-- 
2.25.1

