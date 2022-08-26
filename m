Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C085A28F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbiHZN7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbiHZN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:59:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E32A8CC9;
        Fri, 26 Aug 2022 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661522379; x=1693058379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/meUrRRrUqzCFxt2Pstb3X+gBFy9iEKKyPVauqg701Y=;
  b=TTpQKS7QZ8lJdLwyS1Ee7x7VmVOT9cmX9pzOpXPMcG9uIA8Ex83qDvf1
   rpH5W3R7E2K+KGQKRMbHPVmE1cxzHnbIVrylDx6+OiQmS2fASkGUmeMBA
   0qvRXSOXwKRt4PZAwTcFchHRbLV+qZbwjxHTdd2f8b0gjC5PRdI3Jmrxk
   Oj7i4PG38KKVWfdZ/9+vN3j1L1EaFtuwC9q6bBt/hKLjOXb8H3T2UFGOw
   r0BgeqIBKk6WZ1gKxoh+TcIfqJjo8ySYCbDvUQ8gQGtfGEeABr/vuNvXG
   xMFGiI1k16p7hQocTlKTx2LofhlEuyKHnUwr7vQzrSuAMYC6bazX2y4zL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="356224884"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="356224884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 06:59:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="671473573"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga008.fm.intel.com with ESMTP; 26 Aug 2022 06:59:36 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH] perf stat: Fix L2 Topdown metrics disappear for raw events
Date:   Fri, 26 Aug 2022 22:00:57 +0800
Message-Id: <20220826140057.3289401-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

In perf/Documentation/perf-stat.txt, for "--td-level" the default "0" means
the max level that the current hardware support. So we need initialize the
stat_config.topdown_level to TOPDOWN_MAX_LEVEL when “--td-level=0” or no
“--td-level” option. Otherwise, for the hardware with a max level is 2, the
2nd level metrics disappear for raw events in this case. The issue cannot
be observed for the perf stat default or "--topdown" options. This commit
fixes the raw events issue and removes the duplicated code for the perf
stat default.

Before:

 # ./perf stat -e "cpu-clock,context-switches,cpu-migrations,page-faults,instructions,cycles,ref-cycles,branches,branch-misses,{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}" sleep 1

 Performance counter stats for 'sleep 1':

              1.03 msec cpu-clock                        #    0.001 CPUs utilized
                 1      context-switches                 #  966.216 /sec
                 0      cpu-migrations                   #    0.000 /sec
                60      page-faults                      #   57.973 K/sec
         1,132,112      instructions                     #    1.41  insn per cycle
           803,872      cycles                           #    0.777 GHz
         1,909,120      ref-cycles                       #    1.845 G/sec
           236,634      branches                         #  228.640 M/sec
             6,367      branch-misses                    #    2.69% of all branches
         4,823,232      slots                            #    4.660 G/sec
         1,210,536      topdown-retiring                 #     25.1% Retiring
           699,841      topdown-bad-spec                 #     14.5% Bad Speculation
         1,777,975      topdown-fe-bound                 #     36.9% Frontend Bound
         1,134,878      topdown-be-bound                 #     23.5% Backend Bound
           189,146      topdown-heavy-ops                #  182.756 M/sec
           662,012      topdown-br-mispredict            #  639.647 M/sec
         1,097,048      topdown-fetch-lat                #    1.060 G/sec
           416,121      topdown-mem-bound                #  402.063 M/sec

       1.002423690 seconds time elapsed

       0.002494000 seconds user
       0.000000000 seconds sys

After:

 # ./perf stat -e "cpu-clock,context-switches,cpu-migrations,page-faults,instructions,cycles,ref-cycles,branches,branch-misses,{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound,topdown-heavy-ops,topdown-br-mispredict,topdown-fetch-lat,topdown-mem-bound}" sleep 1

 Performance counter stats for 'sleep 1':

              1.13 msec cpu-clock                        #    0.001 CPUs utilized
                 1      context-switches                 #  882.128 /sec
                 0      cpu-migrations                   #    0.000 /sec
                61      page-faults                      #   53.810 K/sec
         1,137,612      instructions                     #    1.29  insn per cycle
           881,477      cycles                           #    0.778 GHz
         2,093,496      ref-cycles                       #    1.847 G/sec
           236,356      branches                         #  208.496 M/sec
             7,090      branch-misses                    #    3.00% of all branches
         5,288,862      slots                            #    4.665 G/sec
         1,223,697      topdown-retiring                 #     23.1% Retiring
           767,403      topdown-bad-spec                 #     14.5% Bad Speculation
         2,053,322      topdown-fe-bound                 #     38.8% Frontend Bound
         1,244,438      topdown-be-bound                 #     23.5% Backend Bound
           186,665      topdown-heavy-ops                #      3.5% Heavy Operations       #     19.6% Light Operations
           725,922      topdown-br-mispredict            #     13.7% Branch Mispredict      #      0.8% Machine Clears
         1,327,400      topdown-fetch-lat                #     25.1% Fetch Latency          #     13.7% Fetch Bandwidth
           497,775      topdown-mem-bound                #      9.4% Memory Bound           #     14.1% Core Bound

       1.002701530 seconds time elapsed

       0.002744000 seconds user
       0.000000000 seconds sys

Fixes: 63e39aa6ae10 ("perf stat: Support L2 Topdown events")
Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ded90d851f75..4664d21d076f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1911,6 +1911,9 @@ static int add_default_attributes(void)
 		free(str);
 	}
 
+	if (!stat_config.topdown_level)
+		stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
+
 	if (!evsel_list->core.nr_entries) {
 		if (target__has_cpu(&target))
 			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
@@ -1927,8 +1930,6 @@ static int add_default_attributes(void)
 		}
 		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
 			return -1;
-
-		stat_config.topdown_level = TOPDOWN_MAX_LEVEL;
 		/* Platform specific attrs */
 		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
 			return -1;
-- 
2.25.1

