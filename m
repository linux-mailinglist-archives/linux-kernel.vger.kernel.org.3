Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009F532488
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiEXHzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiEXHzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:55:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E253994FB
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653378918; x=1684914918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ve6cOX7lGewrXwAPgN0/9phGtoH1NeJsEgVZdgiMeM=;
  b=MaRwhVsxfPIrqO+Z3/EN0FxbEIRBO7ZfyewtjXetELplgdjn3MFs3Foh
   fgZTNwxKYRkNd/FDO13c6uCsV+KhJjlsxHRHbh+nY+g3KT22hGvjteyjT
   7F/yrLf9FBM6hGNE1IJqYFgnJdXV9CbkeBzn7KNqPeKADD8eXUljgI/Bd
   ah2+cfis+JfbYDTScuCgli9ogKdzmv0BLU9ZuVD15AQCE8uEKKerNCW9l
   /mkFzfRKQbCOCzL7zMqWGIStNAI/crsWFTiCIDK83EJ4yCsIhDIDJetSg
   vimI/swQCUPymUoA0OydfVrZudH9mOaq6oyLLUwsTUtXh9OH2Ve1AViqz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273455444"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273455444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="717072391"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.210])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:55:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/15] perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
Date:   Tue, 24 May 2022 10:54:27 +0300
Message-Id: <20220524075436.29144-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524075436.29144-1-adrian.hunter@intel.com>
References: <20220524075436.29144-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use evlist__add_dummy_on_all_cpus() in record__config_text_poke() in
preparation for allowing system-wide events on all CPUs while the user
requested events are on only user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a5cf6a99d67f..c8a79f3a8dff 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -869,7 +869,6 @@ static int record__auxtrace_init(struct record *rec __maybe_unused)
 static int record__config_text_poke(struct evlist *evlist)
 {
 	struct evsel *evsel;
-	int err;
 
 	/* Nothing to do if text poke is already configured */
 	evlist__for_each_entry(evlist, evsel) {
@@ -877,27 +876,13 @@ static int record__config_text_poke(struct evlist *evlist)
 			return 0;
 	}
 
-	err = parse_events(evlist, "dummy:u", NULL);
-	if (err)
-		return err;
-
-	evsel = evlist__last(evlist);
+	evsel = evlist__add_dummy_on_all_cpus(evlist);
+	if (!evsel)
+		return -ENOMEM;
 
-	evsel->core.attr.freq = 0;
-	evsel->core.attr.sample_period = 1;
 	evsel->core.attr.text_poke = 1;
 	evsel->core.attr.ksymbol = 1;
-
-	evsel->core.system_wide = true;
-	evsel->no_aux_samples = true;
 	evsel->immediate = true;
-
-	/* Text poke must be collected on all CPUs */
-	perf_cpu_map__put(evsel->core.own_cpus);
-	evsel->core.own_cpus = perf_cpu_map__new(NULL);
-	perf_cpu_map__put(evsel->core.cpus);
-	evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
-
 	evsel__set_sample_bit(evsel, TIME);
 
 	return 0;
-- 
2.25.1

