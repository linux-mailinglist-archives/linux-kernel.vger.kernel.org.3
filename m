Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6F545A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbiFJCzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiFJCzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:55:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9335849F34;
        Thu,  9 Jun 2022 19:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654829704; x=1686365704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7T9oTi1+gCh7W12rcI4H82ILOO2Ne7XZFAwIAhAFYA=;
  b=Xhimmu5eA02GtNvOC1/2F/a/7vRxGFCoUv+V0+sw3fgWOn0pmLbTZ0H1
   NJs/J1hiGQehgDr9ht/p9Q3FG7aJnpkBdd4pYtCATE2QP+tbrJJ8A+7bF
   0cUYqqD6M5L4Q48VC04krQR0dKAISD/jMAyZmabtNnF+d6Sbds0gqYK6B
   2vV3WjxEl721T31tM2regoJx9uq2+fOblvnPDit6GVZm1WogvplePVsCB
   LA7DGUnO8MsgJJgT3ecDwlxG/ZVCW+bqBnyBtXRvEWcdUbuGxXeX4ZM3M
   Q4/V0/2Bftlu0pgn5m5xgNqJA+kWm4dRjA+iibWnk1j9chW9RoKNie58L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257318933"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257318933"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="566670336"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2022 19:55:01 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v3 1/5] perf stat: Revert "perf stat: Add default hybrid events"
Date:   Fri, 10 Jun 2022 10:54:45 +0800
Message-Id: <20220610025449.2089232-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
References: <20220610025449.2089232-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

This reverts commit ac2dc29edd21 ("perf stat: Add default hybrid
events").

Between this patch and the reverted patch, the commit 6c1912898ed2
("perf parse-events: Rename parse_events_error functions") and the
commit 07eafd4e053a ("perf parse-event: Add init and exit to
parse_event_error") clean up the parse_events_error_*() codes. The
related change is also reverted.

The reverted patch is hard to be extended to support new default
events, e.g., Topdown events, and the existing "--detailed" option
on a hybrid platform.

A new solution will be proposed in the following patch to enable the
perf stat default on a hybrid platform.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
Change log:
  v3:
    * no change since v1.

 tools/perf/builtin-stat.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ce87a8eb7d7..6ac79d95f3b5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1685,12 +1685,6 @@ static int add_default_attributes(void)
   { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
   { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
 
-};
-	struct perf_event_attr default_sw_attrs[] = {
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
-  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
 };
 
 /*
@@ -1947,30 +1941,6 @@ static int add_default_attributes(void)
 	}
 
 	if (!evsel_list->core.nr_entries) {
-		if (perf_pmu__has_hybrid()) {
-			struct parse_events_error errinfo;
-			const char *hybrid_str = "cycles,instructions,branches,branch-misses";
-
-			if (target__has_cpu(&target))
-				default_sw_attrs[0].config = PERF_COUNT_SW_CPU_CLOCK;
-
-			if (evlist__add_default_attrs(evsel_list,
-						      default_sw_attrs) < 0) {
-				return -1;
-			}
-
-			parse_events_error__init(&errinfo);
-			err = parse_events(evsel_list, hybrid_str, &errinfo);
-			if (err) {
-				fprintf(stderr,
-					"Cannot set up hybrid events %s: %d\n",
-					hybrid_str, err);
-				parse_events_error__print(&errinfo, hybrid_str);
-			}
-			parse_events_error__exit(&errinfo);
-			return err ? -1 : 0;
-		}
-
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
 
-- 
2.25.1

