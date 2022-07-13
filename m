Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1F573673
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiGMMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiGMMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:35:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51CFF513D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657715741; x=1689251741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3pAzny8pJyNJWYxB2mLnKwpw4p9Wlv6vRtW0qp65BY=;
  b=DRD2jqLkFh2Plm8/JM9/q2hWJHk+2Aj770z46dUFiNJOs8o3f5qXifT3
   Tfk9RuaNXBFtQOhP9qegtjQdEJ2H9camxa7wUzH/h91Tbr9oVYrIBFfz3
   82yqGVlhn6pN/NBaXRRU9/ZIlUYem9ikzPdd3u7FQiY6bMGxIFTx9PGd4
   seo0NWc8rqM27eCqgXZdwvUy3pQecpIE4VGe0rdlStrM37zPF0MCNCNDZ
   eoy6millnv6SSFDne0gXEmC4uJwbj6WL6Z4clcDvLtXfBLszG4NTM+hKk
   v5cv7FOPxfsjNhWsIkFImB5tM88HLOgxZOMAmj2G4eMiUTLHSb72RgXR5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286332807"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="286332807"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="592976923"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.236])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 05:35:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tests: Stop Convert perf time to TSC test opening events twice
Date:   Wed, 13 Jul 2022 15:34:58 +0300
Message-Id: <20220713123459.24145-2-adrian.hunter@intel.com>
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

Do not call evlist__open() twice.

Fixes: 5bb017d4b97a ("perf test: Fix error message for test case 71 on s390, where it is not supported")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 4ad0dfbc8b21..8d6d60173693 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -123,11 +123,14 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
 		evsel->core.attr.enable_on_exec = 0;
 	}
 
-	if (evlist__open(evlist) == -ENOENT) {
-		err = TEST_SKIP;
+	ret = evlist__open(evlist);
+	if (ret < 0) {
+		if (ret == -ENOENT)
+			err = TEST_SKIP;
+		else
+			pr_debug("evlist__open() failed\n");
 		goto out_err;
 	}
-	CHECK__(evlist__open(evlist));
 
 	CHECK__(evlist__mmap(evlist, UINT_MAX));
 
-- 
2.25.1

