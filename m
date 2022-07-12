Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEC571880
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiGLL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiGLL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:28:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E6640C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625322; x=1689161322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=94KgKSWfdtzq1V4a3xLl/CsdDgK+DoD3CPqR8VX7yH8=;
  b=R0tJrt1fFhBC7MAZUUexJmVC0Mi2jnOXvXmH90nNPk6f+emohkJ+t/lv
   YC9mV8ZbzOAL7u9siyabxIydFR94ioEvfWJR8NnxT5ByqDeg5cwKy+T6x
   HltBzxJuRpk2DCwDcsNo7++d6XjrkoVwR4MmlQYRWShnydoGtXz6YLMdx
   9kaSw4LkqJG9q3r5SLy5hI40mKCu2yW+DXy4BuhLgYgduwbsi2o3f6yP8
   lnZqIh4zJiU52rDPPN6K6leQGPHIzWYPSx5Od9KLhs+AieOom0opQvxf1
   ntSbJb5Bg/76kBDBPixd0BOIHpYZrXHVL85O+TmObvecY5QjowcAiy0ZK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310523786"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="310523786"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="652870338"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tests: Fix Track with sched_switch test for hybrid case
Date:   Tue, 12 Jul 2022 14:28:24 +0300
Message-Id: <20220712112824.28770-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712112824.28770-1-adrian.hunter@intel.com>
References: <20220712112824.28770-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If cpu_core PMU event fails to parse, try also cpu_atom PMU event when
parsing cycles event.

Fixes: 43eb05d06679 ("perf tests: Support 'Track with sched_switch' test for hybrid")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/switch-tracking.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 0c0c2328bf4e..6f53bee33f7c 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -324,6 +324,7 @@ static int process_events(struct evlist *evlist,
 static int test__switch_tracking(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	const char *sched_switch = "sched:sched_switch";
+	const char *cycles = "cycles:u";
 	struct switch_tracking switch_tracking = { .tids = NULL, };
 	struct record_opts opts = {
 		.mmap_pages	     = UINT_MAX,
@@ -372,12 +373,19 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
-	if (perf_pmu__has_hybrid())
-		err = parse_events(evlist, "cpu_core/cycles/u", NULL);
-	else
-		err = parse_events(evlist, "cycles:u", NULL);
+	if (perf_pmu__has_hybrid()) {
+		cycles = "cpu_core/cycles/u";
+		err = parse_events(evlist, cycles, NULL);
+		if (err) {
+			cycles = "cpu_atom/cycles/u";
+			pr_debug("Trying %s\n", cycles);
+			err = parse_events(evlist, cycles, NULL);
+		}
+	} else {
+		err = parse_events(evlist, cycles, NULL);
+	}
 	if (err) {
-		pr_debug("Failed to parse event cycles:u\n");
+		pr_debug("Failed to parse event %s\n", cycles);
 		goto out_err;
 	}
 
-- 
2.25.1

