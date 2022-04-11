Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC14FB390
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiDKGUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbiDKGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:20:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B4C3CFEE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649657886; x=1681193886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WMqosNgxlZ7WImro7S0Sf8rdr2r7XjJad/ExirCdumY=;
  b=bMiQxJ7j31V53XLf50mvWffiP7sH8EFx8Vg25bTQw7dRsoBoqwED+vvT
   fx65Au6C1gfSlK9AQ8P2lJQ7cN9avjM1oRlanjCSYBR3h5hqmfQZY801k
   Jj0GOuae9FzLfbexhr+xratlzjPyWCILq+QvAfao2NUlU4yNDxntFRtNV
   jUJo02uFwROqrRmgYLfO4X2sHNotFH3IwNyNzuUlAiSNGnxKWKZWJ1Zti
   TBlfW9qpqMqRw3NYTtjVE/a+Zv+Ul+rnVojoEP5vGT9Mhbhjj7WsQi54j
   Eq3nmK/uHYMyTM3BbeQb1IW3JlL7ljZcNBq4RlVUBO/0keP5J8jZeF8BY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243927027"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="243927027"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 23:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="723840352"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2022 23:17:59 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Fix misleading add event pmu debug message
Date:   Mon, 11 Apr 2022 09:17:58 +0300
Message-Id: <20220411061758.2458417-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect debug message:

   Attempting to add event pmu 'intel_pt' with '' that may result in
   non-fatal errors

which always appears with perf record -vv and intel_pt e.g.

    perf record -vv -e intel_pt//u uname

The message is incorrect because there will never be non-fatal errors.

Suppress the message if the pmu is 'selectable' i.e. meant to be selected
directly as an event.

Fixes: 4ac22b484d4c79 ("perf parse-events: Make add PMU verbose output clearer")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 24997925ae00..dd84fed698a3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1523,7 +1523,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
 
-	if (verbose > 1) {
+	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
+
+	if (verbose > 1 && !(pmu && pmu->selectable)) {
 		fprintf(stderr, "Attempting to add event pmu '%s' with '",
 			name);
 		if (head_config) {
@@ -1536,7 +1538,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		fprintf(stderr, "' that may result in non-fatal errors\n");
 	}
 
-	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
 	if (!pmu) {
 		char *err_str;
 
-- 
2.25.1

