Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2622E544FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiFIOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243552AbiFIOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:52:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BB1DB1E2;
        Thu,  9 Jun 2022 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654786369; x=1686322369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhS3zD/EOK7DCRRrEKVkJqq9D19wwalFl1hpBBbQQZg=;
  b=Er44pyHwbJhVe7tj9KaURwnFSkbympG99mxTmwSH4Gw3/RslnEAR468U
   IXvUMxUTybt7ipz8KChKIt90Ib/m0hjHxv2cIsOMfJqALevyr6i5QxBFe
   gMTgSIxHE2s/pyvei3vrI8w/wRRK5C7PH8qcHmbH+NapZVq/cjAk0ubv/
   jGYRQ/7B8pkOMzljudGgW/hzlfBCCpP6Xeog4scgHvjy0aGmAdp35aHb+
   jvNBmBSOTb6UoNawo5surXto+Mhmo9ZZG628tc3RSx3ZYBbMRHGue2r1u
   A29fo3pkcUhqFaprskm9qvjgG2vAw52US+wQVWn5dwxsptvWT2fWuYi9F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257736230"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257736230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="827633512"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2022 07:52:45 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH v2 1/5] perf stat: Revert "perf stat: Add default hybrid events"
Date:   Thu,  9 Jun 2022 22:53:10 +0800
Message-Id: <20220609145314.2064632-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
References: <20220609145314.2064632-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
  v2:
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

