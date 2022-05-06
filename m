Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5582F51D7A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391910AbiEFMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391902AbiEFMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:30:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F169499
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840000; x=1683376000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0rQcXAF6ZEjrPKB/Xd3XBumrUbxQfH8kFdetJ4R3a4=;
  b=hxCPag5pQC/Lr/CrdKA4j7xJdpT5uJA1NA5X/k5Ff5v6jU2/WsJHHYw/
   ObTk4I35bt74QYv2HCpsmTo9Q3Bq2McYi5G25wdAtYJgmWwubfn4NDpA5
   iglQ6YzOGPrksoT9+KHlVMkM8Fx9hOhBLqaNJk/lTg2Lq07zHTKfXmQXA
   TgUhQQ6EhdQjQC0St1xb575trOdF3dJO+xG/F9TOJAMhM0zGIMHwlqXET
   walTvBJX2MDvBpQFQIBvx5dyMs6uCX83eWDxkdo3cewyuZV/c7RRerT/F
   Fy7HpnfSKjk6MnLU03HVDsUwn1ylfj1kvEYIlBUg4QENQ585BBuIHZz+x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045832"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045832"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440980"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/23] perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
Date:   Fri,  6 May 2022 15:25:52 +0300
Message-Id: <20220506122601.367589-15-adrian.hunter@intel.com>
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

Use evlist__add_dummy_on_all_cpus() in record__config_text_poke() in
preparation for allowing system-wide events on all CPUs while the user
requested events are on only user requested CPUs.

Acked-by: Ian Rogers <irogers@google.com>
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

