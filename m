Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E39957187F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiGLL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiGLL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:28:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8891632A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625320; x=1689161320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onTgph3rXetM5BAUTtdZP1dl7HRIsTscsKh4CTi0arU=;
  b=gXIIyl/CWBXT6PJE9aoQCamiVjn+0bf79PNZmEIAPuvtlCWREdZqE5Ot
   gVBvzI7yQ4LcqubYG6MxRbmVwT6pctrjEMn6r5vVA4OgZ3m5yjtbl0+1U
   f2pCT/+6Qe9GTPO6IirO1k3bEh2vyp6vDoMksa7fBeRMGkMpq+DOWdaNv
   6BYbCzkgQoSOMFM8glbWzV8RjUadVXwrE2Qk8SKxncbV71k24UYHsiwIh
   do9iYjBB6Hh2LLUO5SZf9+ys55Ap+Kavzm4tOLytlX9vR7X+1cOLlA/x9
   PXv53cRzryzU927x+C+7/nMTbp0ey6DaqNwz/WOPVlnEBMyIqTnZVTsfR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310523781"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="310523781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="652870324"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:28:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf parse-events: Fix segfault when event parser gets an error
Date:   Tue, 12 Jul 2022 14:28:23 +0300
Message-Id: <20220712112824.28770-2-adrian.hunter@intel.com>
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

parse_events() is often called with parse_events_error set to NULL.
Make parse_events_error__handle() not segfault in that case.

Fixes: 43eb05d06679 ("perf tests: Support 'Track with sched_switch' test for hybrid")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7ed235740431..700c95eafd62 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2391,9 +2391,12 @@ void parse_events_error__exit(struct parse_events_error *err)
 void parse_events_error__handle(struct parse_events_error *err, int idx,
 				char *str, char *help)
 {
-	if (WARN(!str, "WARNING: failed to provide error string\n")) {
-		free(help);
-		return;
+	if (WARN(!str, "WARNING: failed to provide error string\n"))
+		goto out_free;
+	if (!err) {
+		/* Assume caller does not want message printed */
+		pr_debug("event syntax error: %s\n", str);
+		goto out_free;
 	}
 	switch (err->num_errors) {
 	case 0:
@@ -2419,6 +2422,11 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
 		break;
 	}
 	err->num_errors++;
+	return;
+
+out_free:
+	free(str);
+	free(help);
 }
 
 #define MAX_WIDTH 1000
-- 
2.25.1

