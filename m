Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9251C57F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382212AbiEERAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382181AbiEERAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:00:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055755BD23
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769814; x=1683305814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3Ox2DTLOs/z08IyVX3jYaM/ZpEJfS7KJmWeGCum7MI=;
  b=h7aMKMyMYpbEkbKDKuQvBv7JKg4lpFVxOKIiX6CdogVHlHqS0Pei5mD6
   zrIvKKuCVatv1T8hf9i+XFUZ2VZJYr68bmK5EevC0QF2NkqyHT+pXdx6N
   lHo+VrTaJ5/D1svHbNnOP7QONgfcr1tKJIhnUZOuA0Pv48O++lIUQCNq9
   MZCWPDzGo2KEtl+r/Zhee9ggz4lsKlq39xlOfAXmmT9SP1qLGQIm/kGku
   SD39rbgBcCA/O44okIVVP0zWtp6KeFtydCCQHWVGsi2I0cfqxVwI+0ADj
   yj3iBX5C1nuIz1bMElHaKejX9q5xaom/YC1kwG9Myt3XOTIRm8rlG3JxI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248717818"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248717818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032768"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:56:50 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 04/23] perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
Date:   Thu,  5 May 2022 19:56:20 +0300
Message-Id: <20220505165639.361733-5-adrian.hunter@intel.com>
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

evlist__enable_event_idx() is used only by auxtrace. Move it to auxtrace.c
in preparation for making it even more auxtrace specific.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++++
 tools/perf/util/evlist.c   | 10 ----------
 tools/perf/util/evlist.h   |  2 --
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index df1c5bbbaa0d..10936a38031f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -636,6 +636,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
+static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
+{
+	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
+
+	if (per_cpu_mmaps)
+		return perf_evsel__enable_cpu(&evsel->core, idx);
+
+	return perf_evsel__enable_thread(&evsel->core, idx);
+}
+
 int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9fcecf7daa62..f1309b39afe4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -538,16 +538,6 @@ void evlist__toggle_enable(struct evlist *evlist)
 	(evlist->enabled ? evlist__disable : evlist__enable)(evlist);
 }
 
-int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
-{
-	bool per_cpu_mmaps = !perf_cpu_map__empty(evlist->core.user_requested_cpus);
-
-	if (per_cpu_mmaps)
-		return perf_evsel__enable_cpu(&evsel->core, idx);
-
-	return perf_evsel__enable_thread(&evsel->core, idx);
-}
-
 int evlist__add_pollfd(struct evlist *evlist, int fd)
 {
 	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_flag__default);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a21daaa5fc1b..4062f5aebfc1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -196,8 +196,6 @@ void evlist__toggle_enable(struct evlist *evlist);
 void evlist__disable_evsel(struct evlist *evlist, char *evsel_name);
 void evlist__enable_evsel(struct evlist *evlist, char *evsel_name);
 
-int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx);
-
 void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 
 int evlist__create_maps(struct evlist *evlist, struct target *target);
-- 
2.25.1

