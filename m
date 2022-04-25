Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18D50E180
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiDYNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiDYNZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:25:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC73B24951;
        Mon, 25 Apr 2022 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650892926; x=1682428926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFt4WRRzaPGr6zTEzqGRYmfaZsGarY/aNmCbTV8G+G4=;
  b=PLdMaE5U0KCNQvHs9/k9+tSAvb/wtyFkAVDX6FSkiTg0vQsA1fy5MUph
   gIJ0haVl+CPV2EA63xHNRT2ahYfknaTRrvS0SOkimwW6Bs5miiE25F+d3
   P+ZdyLrXIdqGoJ5+YWIk6ZlW+4kgjt0PHsRvNAQIaP1ERkk4thW9QQ5NL
   KJuPCDTd16JTXpSXLqLuWKnIQim3Q/0cMIamByz+kZNDiSNgwxDa+A9BQ
   z0CHjaCqZ0UvWqosPF/yXe/+CX/u1U2h0FR3a17gSoc/4iHpAJAkYMb9n
   iTkJaOxSEV7rPj+tj/8AitaP30p7LJ8c+SIxwtcE/jlf09pf/4/1YUpTS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="328183589"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="328183589"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="537509756"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2022 06:22:03 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 1/2] perf vendor events intel: Update core event list for Sapphirerapids
Date:   Mon, 25 Apr 2022 21:22:10 +0800
Message-Id: <20220425132211.801228-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update JSON core events for Sapphirerapids to perf.

Based on JSON list v1.01:

https://download.01.org/perfmon/SPR/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../arch/x86/sapphirerapids/cache.json        | 36 ++++++-------
 .../x86/sapphirerapids/floating-point.json    | 24 ++++-----
 .../arch/x86/sapphirerapids/frontend.json     |  4 +-
 .../arch/x86/sapphirerapids/memory.json       |  8 +--
 .../arch/x86/sapphirerapids/other.json        | 53 +++++++++++++++----
 .../arch/x86/sapphirerapids/pipeline.json     | 50 ++++++++++-------
 6 files changed, 110 insertions(+), 65 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 373b28348b57..6fa723c9a6f6 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -90,7 +90,7 @@
         "UMask": "0x1f"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "L2_LINES_OUT.NON_SILENT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
@@ -298,7 +298,7 @@
         "UMask": "0x28"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "LONGEST_LAT_CACHE.MISS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
@@ -490,7 +490,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
@@ -511,7 +511,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
@@ -646,7 +646,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
@@ -853,7 +853,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches on the same socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches on the same socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
@@ -864,7 +864,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
@@ -875,7 +875,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop that hit in another core, which did not forward the data.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop that hit in another core, which did not forward the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
@@ -886,7 +886,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
@@ -897,7 +897,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop was sent and data was returned (Modified or Not Modified).",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop was sent and data was returned (Modified or Not Modified).",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
@@ -908,7 +908,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop hit a modified line in another core's caches which forwarded the data.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop hit a modified line in another core's caches which forwarded the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
@@ -919,7 +919,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
@@ -930,7 +930,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit a modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit a modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
@@ -941,7 +941,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that either hit a non-modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that either hit a non-modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
@@ -963,7 +963,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
@@ -1005,7 +1005,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
@@ -1016,7 +1016,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
@@ -1027,7 +1027,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 1281f293ca41..53d35dddd313 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ARITH.FPDIV_ACTIVE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -22,7 +22,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ASSISTS.SSE_AVX_MIX",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
@@ -32,7 +32,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
@@ -42,7 +42,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
@@ -52,7 +52,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
@@ -150,7 +150,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
@@ -159,7 +159,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
@@ -168,7 +168,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
@@ -178,7 +178,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
@@ -192,12 +192,12 @@
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "TBD",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.SCALAR",
         "SampleAfterValue": "100003",
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
@@ -211,7 +211,7 @@
         "EventCode": "0xcf",
         "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "TBD",
+        "PublicDescription": "FP_ARITH_INST_RETIRED2.VECTOR",
         "SampleAfterValue": "100003",
         "UMask": "0x1c"
     }
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 3b6fb14fc421..04ba0269c73c 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -262,7 +262,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
@@ -291,7 +291,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index 4c385d05a0c7..7436ced3e04e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -44,7 +44,7 @@
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L2_MISS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "5",
@@ -55,7 +55,7 @@
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L3_MISS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "9",
@@ -259,7 +259,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
@@ -270,7 +270,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that missed the L3 Cache and were supplied by the local socket (DRAM or PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM accesses that are controlled by the close or distant SNC Cluster.  It does not count misses to the L3 which go to Local CXL Type 2 Memory or Local Non DRAM.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that missed the L3 Cache and were supplied by the local socket (DRAM or PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM accesses that are controlled by the close or distant SNC Cluster.  It does not count misses to the L3 which go to Local CXL Type 2 Memory or Local Non DRAM.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
index e6d4921a42cb..7d6f8e25bb10 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
@@ -206,7 +206,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have any type of response.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have any type of response.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
@@ -217,7 +217,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.DRAM",
@@ -228,7 +228,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
@@ -239,7 +239,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the close or distant SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the close or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
@@ -250,7 +250,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the close or distant SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the close or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
@@ -261,7 +261,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were not supplied by the local socket's L1, L2, or L3 caches and were supplied by a remote socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were not supplied by the local socket's L1, L2, or L3 caches and were supplied by a remote socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE",
@@ -272,7 +272,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to another socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to another socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
@@ -283,7 +283,29 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM on a distant memory controller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x733004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_PMM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x703004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM on a distant memory controller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
@@ -304,6 +326,17 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hardware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0xFBFF80822",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread.",
         "CollectPEBSRecord": "2",
@@ -316,7 +349,7 @@
         "UMask": "0x7"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "XQ.FULL_CYCLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index 25a12e03cb85..b0920f5b25ed 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -1,13 +1,13 @@
 [
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "AMX_OPS_RETIRED.BF16",
         "EventCode": "0xce",
         "EventName": "AMX_OPS_RETIRED.BF16",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "AMX_OPS_RETIRED.INT8",
         "EventCode": "0xce",
         "EventName": "AMX_OPS_RETIRED.INT8",
         "SampleAfterValue": "1000003",
@@ -54,6 +54,7 @@
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
@@ -337,7 +338,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
@@ -347,7 +348,7 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
@@ -530,6 +531,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
     },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty, the SB was not full and there was no outstanding load.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of cycles total of 0 uops executed on all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) was not full and there was no outstanding load.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
         "CollectPEBSRecord": "2",
@@ -564,7 +576,7 @@
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -595,7 +607,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INST_RETIRED.REP_ITERATION",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -616,7 +628,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_MISC.MBA_STALLS",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.MBA_STALLS",
@@ -636,7 +648,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
@@ -660,7 +672,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.128BIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -670,7 +682,7 @@
         "UMask": "0x13"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.256BIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -702,7 +714,7 @@
         "UMask": "0xc"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -712,7 +724,7 @@
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -722,7 +734,7 @@
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -732,7 +744,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -845,7 +857,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MISC2_RETIRED.LFENCE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
@@ -916,7 +928,7 @@
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
@@ -947,7 +959,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
@@ -1210,7 +1222,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "UOPS_RETIRED.HEAVY",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
@@ -1220,7 +1232,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "UOPS_RETIRED.MS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
-- 
2.25.1

