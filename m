Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E784BAF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiBRBdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:33:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiBRBdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:33:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63861B2799;
        Thu, 17 Feb 2022 17:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645148009; x=1676684009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=68iC9cnz+ae05R1FGoesD5y/UbMcqAkHpnWUd6+k1Sc=;
  b=i8bZya4fC7QqS0Q3v9ZsXM9QyMpcd82z4nidTqgc3Ml9jE15DsSuaPjy
   518ThgpjNEBIb6Pi31gCVTkpu5SobGZeNE6TB5VRp6LSASKzFkhko080I
   MhTR+KOeYKT+49lyZoTU0QZ3w1yVdBT8Gie5uQNVhjv+XX+DURXJ7auUM
   gMTRplpG+MmE81goCYlyM+jcFjYzNkW1EJ+oY78Fxl0KBUnL2mos15849
   GfChBTVzFEXXRTQmwidw0S/ICuOa2jieFVT5nRUN4d6vof+T18IEH4DgX
   n7GUpWK9GK2vtTpJjQ8Jm2c9Bgx5+QnKXnwnV3BJnwenT8vpRn21bEiHv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231662947"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231662947"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 17:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="503791413"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 17:33:26 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH] perf tools: fix failed to use cpu list for uncore events
Date:   Fri, 18 Feb 2022 17:31:27 +0800
Message-Id: <20220218093127.1844241-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The 'perf record' and 'perf stat' commands have supported the option
'-C/--cpus' to count or collect only on the list of CPUs provided.
commit 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybrid")
add it to be supported for hybrid. For hybrid support, it checks the
cpu list are available on hybrid PMU. But when we test only uncore
events(or events not in cpu_core and cpu_atom), there is a bug:

Before:
 # perf stat -C0  -e uncore_clock/clockticks/ sleep 1
   failed to use cpu list 0

In this case, for uncore event, its pmu_name is not cpu_core or cpu_atom,
so in evlist__fix_hybrid_cpus, perf_pmu__find_hybrid_pmu should return
NULL,both events_nr and unmatched_count should be 0 ,then the cpu list
check function evlist__fix_hybrid_cpus return -1 and the error "failed
to use cpu list 0" will happen. Bypass "events_nr=0" case then the issue
is fixed.

After:
 # perf stat -C0  -e uncore_clock/clockticks/ sleep 1

 Performance counter stats for 'CPU(s) 0':

       195,476,873      uncore_clock/clockticks/

       1.004518677 seconds time elapsed

When testing with at least one core event and uncore events, it has no
issue.

 # perf stat -C0  -e cpu_core/cpu-cycles/,uncore_clock/clockticks/ sleep 1

 Performance counter stats for 'CPU(s) 0':

         5,993,774      cpu_core/cpu-cycles/
       301,025,912      uncore_clock/clockticks/

       1.003964934 seconds time elapsed

Fixes: 1d3351e631fc ("perf tools: Enable on a list of CPUs for hybrid")
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 tools/perf/util/evlist-hybrid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist-hybrid.c b/tools/perf/util/evlist-hybrid.c
index 7f234215147d..57f02beef023 100644
--- a/tools/perf/util/evlist-hybrid.c
+++ b/tools/perf/util/evlist-hybrid.c
@@ -154,8 +154,8 @@ int evlist__fix_hybrid_cpus(struct evlist *evlist, const char *cpu_list)
 		perf_cpu_map__put(matched_cpus);
 		perf_cpu_map__put(unmatched_cpus);
 	}
-
-	ret = (unmatched_count == events_nr) ? -1 : 0;
+	if (events_nr)
+		ret = (unmatched_count == events_nr) ? -1 : 0;
 out:
 	perf_cpu_map__put(cpus);
 	return ret;
-- 
2.25.1

