Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333894CF287
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiCGHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiCGHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:23:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A155FAC;
        Sun,  6 Mar 2022 23:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646637769; x=1678173769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bU6exYqGnTwB5vvdEZLW2SQGHSrLLH83oJPg1oIJrr0=;
  b=Dx5b9UK7JBTv+zJ8QskfeJqhrEH8dJnT/yq/xdGNsGg2AZk2bKSSwrd9
   6zse010L/X+bm9RIOswuEWnLgwXjRd7jCRE6UvfLRsuS70B41VtTpBbpW
   fm6zSigS46XYvJ2DUNfzTk4QYlgc7050uD8ELRR21OIcerKBbDbsoI7YF
   snI0hn2Krhao2PIE1Cza6BAHc1c31JUUfNmZpraWqOUKdRWyoqWDhTivo
   SaLP4e5RYevD8sWtW5L4iKsecwhxEuYCXVJtjIMpeyceotpcRYBJ8N3eL
   tCmVCEkXqCR6Oib0lfuCiuHlWaohmqLE1yBRqp82yILWIpJCrwylha8HL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="241753779"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="241753779"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 23:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="537004537"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2022 23:22:45 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH] perf parse: Fix event parser error for hybrid systems
Date:   Mon,  7 Mar 2022 23:16:27 +0800
Message-Id: <20220307151627.30049-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

This bug happened on hybrid systems when both cpu_core and cpu_atom
have the same event name such as "UOPS_RETIRED.MS" while their event
terms are different, then during perf stat, the event for cpu_atom
will parse fail and then no output for cpu_atom.

UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/

It is because event terms in the "head" of parse_events_multi_pmu_add
will be changed to event terms for cpu_core after parsing UOPS_RETIRED.MS
for cpu_core, then when parsing the same event for cpu_atom, it still
uses the event terms for cpu_core, but event terms for cpu_atom are
different with cpu_core, the event parses for cpu_atom will fail. This
patch fixes it, the event terms should be parsed from the original
event.

This patch can work for the hybrid systems that have the same event
in more than 2 PMUs. It also can work in non-hybrid systems.

Before:

 #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1

Using CPUID GenuineIntel-6-97-1
UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
Control descriptor is not initialized
UOPS_RETIRED.MS: 2737845 16068518485 16068518485

 Performance counter stats for 'system wide':

         2,737,845      cpu_core/UOPS_RETIRED.MS/

       1.002553850 seconds time elapsed

After:

 #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1

Using CPUID GenuineIntel-6-97-1
UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/
Control descriptor is not initialized
UOPS_RETIRED.MS: 1977555 16076950711 16076950711
UOPS_RETIRED.MS: 568684 8038694234 8038694234

 Performance counter stats for 'system wide':

         1,977,555      cpu_core/UOPS_RETIRED.MS/
           568,684      cpu_atom/UOPS_RETIRED.MS/

       1.004758259 seconds time elapsed

Fixes: fb0811535e92c6c1 ("perf parse-events: Allow config on kernel PMU events")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 tools/perf/util/parse-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9739b05b999e..8bf7f914ea0e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1648,6 +1648,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 {
 	struct parse_events_term *term;
 	struct list_head *list = NULL;
+	struct list_head *orig_head = NULL;
 	struct perf_pmu *pmu = NULL;
 	int ok = 0;
 	char *config;
@@ -1674,7 +1675,6 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 	list_add_tail(&term->list, head);
 
-
 	/* Add it for all PMUs that support the alias */
 	list = malloc(sizeof(struct list_head));
 	if (!list)
@@ -1687,13 +1687,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
+				parse_events_copy_term_list(head, &orig_head);
 				if (!parse_events_add_pmu(parse_state, list,
-							  pmu->name, head,
+							  pmu->name, orig_head,
 							  true, true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
 				}
+				parse_events_terms__delete(orig_head);
 			}
 		}
 	}
-- 
2.25.1

