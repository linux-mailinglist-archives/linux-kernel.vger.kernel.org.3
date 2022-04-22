Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB250BCE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445590AbiDVQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390678AbiDVQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF269DD1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644694; x=1682180694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTIPWG3rKADJejUjpz4vWXPl4+M9vgjae0Hy0+Q8pUM=;
  b=S8KC4m6A5k9W5r1bWRWe0j6OJKVfkAZNz0jVlIcAjncPwttz4+dLe4Tp
   XPvr7NHu59er8F3ZPciEOUChJC7WdNx8Fsy2DdXfSAFxDSfZR0AvP8+QZ
   Yrjj3nEPKsQmnigbWEMWiSZRDF5P6RznijJ7GEwXSXFr12dQ688mniNg6
   2DrsVwypuJJaXz+46rY5yaZJ9J2oSv5toHnWEAtpFCV2lZSxB9AvjtRdp
   NY5aFWdRngkiTYRtT1Q2u8EljqqyN2/HzwDP9E0sqsVHRPnKDQX6Zks4B
   /uEwQjlvsFuzm86Zu7CmAvQ4tX6TbIkuJAU1beJYo++sn+krQhk0Urq6L
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885992"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978962"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:42 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 14/21] perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
Date:   Fri, 22 Apr 2022 19:23:55 +0300
Message-Id: <20220422162402.147958-15-adrian.hunter@intel.com>
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

