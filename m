Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D9573674
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiGMMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGMMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:35:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D857F54F2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657715744; x=1689251744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3fDSdrXThFPOgnv80j6zPOXYaL3bqxiWl9h6trGXaIk=;
  b=Fm3Jol2uweh6MNz/05JZNbgjgeS1G/NiQGRIKsrY23/pD4bVgU7FsqOV
   9rEy33G67J8Kp42McJk76v9qpttuynlnXv7Qc1nWzDsRViAY7aJQJx3hm
   c4zUbXJ03d7UmUNalNRLwlBwWLaK5XWNmu2bEc372JaZU1TLqy61pDbK5
   LfEjNgNK5QLvTFikOuKgGDWl+KHJGJTD3dV6law0+TeCGlXA6hjMrthn/
   o022IfJPgY6HTxwTTHTfsgz46S9bd/a7LUguypdaiw2XOqNoLyFXTnLWv
   RtUnnE5f0OaX9nnqzp0KGgLRk8kSh0llBsMT45h1JyWqqY8o5dU7eA6Wh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286332819"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286332819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="592976939"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tests: Fix Convert perf time to TSC test for hybrid
Date:   Wed, 13 Jul 2022 15:34:59 +0300
Message-Id: <20220713123459.24145-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713123459.24145-1-adrian.hunter@intel.com>
References: <20220713123459.24145-1-adrian.hunter@intel.com>
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

The test does not always correctly determine the number of events for
hybrids, nor allow for more than 1 evsel when parsing.

Fix by iterating the events actually created and getting the correct
evsel for the events processed.

Fixes: d9da6f70eb23 ("perf tests: Support 'Convert perf time to TSC' test for hybrid")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 8d6d60173693..7c7d20fc503a 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -20,8 +20,6 @@
 #include "tsc.h"
 #include "mmap.h"
 #include "tests.h"
-#include "pmu.h"
-#include "pmu-hybrid.h"
 
 /*
  * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
@@ -106,18 +104,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 
 	evlist__config(evlist, &opts, NULL);
 
-	evsel = evlist__first(evlist);
-
-	evsel->core.attr.comm = 1;
-	evsel->core.attr.disabled = 1;
-	evsel->core.attr.enable_on_exec = 0;
-
-	/*
-	 * For hybrid "cycles:u", it creates two events.
-	 * Init the second evsel here.
-	 */
-	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom")) {
-		evsel = evsel__next(evsel);
+	/* For hybrid "cycles:u", it creates two events */
+	evlist__for_each_entry(evlist, evsel) {
 		evsel->core.attr.comm = 1;
 		evsel->core.attr.disabled = 1;
 		evsel->core.attr.enable_on_exec = 0;
@@ -170,10 +158,12 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 				goto next_event;
 
 			if (strcmp(event->comm.comm, comm1) == 0) {
+				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
 				CHECK__(evsel__parse_sample(evsel, event, &sample));
 				comm1_time = sample.time;
 			}
 			if (strcmp(event->comm.comm, comm2) == 0) {
+				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
 				CHECK__(evsel__parse_sample(evsel, event, &sample));
 				comm2_time = sample.time;
 			}
-- 
2.25.1

