Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685751C598
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382436AbiEERB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382251AbiEERBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:01:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C95D187
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651769872; x=1683305872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTIPWG3rKADJejUjpz4vWXPl4+M9vgjae0Hy0+Q8pUM=;
  b=Q2GPWedLsc2qs1LcUEkmlbl5VcIa7Bz0N/Na0YznEhnMy1Y9WoN6XM69
   vdALfywhryAQY+zk/D/ZeNQOqrITlcOzIBACwz00edenXGf69OhuVeq1J
   FPJBN9lxvb4JSMs8BMXYEpe+5c8prNYR4wSomr4HxwXbyaH2Lx0CoJeeB
   UmcVsCdxTYIyPG4Cze/8g2cRK1St4yvPIxdKSMnPKTRXU3G6yDmtOMXc0
   yl/iTr5fusFlLcHBiy5q6OzZVVh3OKZQ9WN3NkcfElnV2qTt/KfNgsMxh
   wLS8qjBIvslHrBQaIYHnb7+HxNk4xhyJ94perKzPPMpTgibzAhZY/v29a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248718196"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248718196"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 09:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709032919"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2022 09:57:16 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V1 14/23] perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
Date:   Thu,  5 May 2022 19:56:30 +0300
Message-Id: <20220505165639.361733-15-adrian.hunter@intel.com>
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

Use evlist__add_system_wide_dummy() in record__config_text_poke() in
preparation for allowing system-wide events on all CPUs while the user
requested events are on only user requested CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 069825c48d40..83d2f2b5dcda 100644
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
+	evsel = evlist__add_system_wide_dummy(evlist);
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

