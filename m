Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E851D796
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391815AbiEFMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391794AbiEFM36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:29:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6175DA00
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839975; x=1683375975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYJxt1+PeHnNXfMk/0NPg6Z6cSqkCa8gPc1ALHhXGGI=;
  b=nuW814tfsoTkNdfjNVgFC68sN0+d+Dnw1ye5IJ9rF7atJZvq5lRisCMn
   Dm1WaRDWKaUPfg8P6NLLiRpSJTxdzSqTKs5Vp3WIIoHVB/9Eppnla8NHG
   DtJzBauXZYQ/PKG2Es19tACjWV/qkYTXXelYtt7yKcx5RK5zFaOyBmyAB
   TDkcFAMjVHiFsZhY2GJGlEFjRtWEm67nmBF/KZS58Pn0HCUxDvFqlmQow
   DamiimrXxFPmOFMZ2Mx9FEPOiPrSrdJT1xcXjG4X5dFxWhptCtxgbwACe
   57f/l7WGiYJm3b4qoWpPB8Cax2NT54CNqzeZTTlOLgRKwpe0ouG3+RQMA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045739"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440695"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/23] perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
Date:   Fri,  6 May 2022 15:25:42 +0300
Message-Id: <20220506122601.367589-5-adrian.hunter@intel.com>
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

evlist__enable_event_idx() is used only by auxtrace. Move it to auxtrace.c
in preparation for making it even more auxtrace specific.

Acked-by: Ian Rogers <irogers@google.com>
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

