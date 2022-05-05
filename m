Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770551C57E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382184AbiEERAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382158AbiEERAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B1580D7
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769810; x=1683305810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=96NhVcF681Cf6EUdn2T2JGsKemHJ0OT0snZUFHPMbgc=;
  b=eyF2gEEL+Sa0/PPaq9/RA8A9b04v1Rny/We6SxiJDe8GLb52qX6ksc89
   /GciW3WD1Bx1gcJpGI3NFHBtbhOPakU4bQGDBNkC9sph9kJ+LEEra8T1J
   NnzIzAT4QgqtMW8Di5LLiJT6enMmjLCqAr1vfeqFpaTOAjgrB0AHlykhH
   lHbswMAdFm+/kaxW6pv2kvC4xfDQ7aXimDTHEDVd0fV1aCs/AUMHRMbdz
   2WsKQAbh8S456qnovSNfbi/XKufC5ny+rGFuDOh/mVDFmUSSCtDVD5l9Y
   jQFUKKjHpxnJKnUYOAbAYgoHmCRPxlGFdJlxkpkRmJaGOmd7NM7LV6M5C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717812"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717812"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032762"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 03/23] perf evlist: Use libperf functions in evlist__enable_event_idx()
Date:   Thu,  5 May 2022 19:56:19 +0300
Message-Id: <20220505165639.361733-4-adrian.hunter@intel.com>
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

