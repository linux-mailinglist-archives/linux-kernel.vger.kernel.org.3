Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B1590DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbiHLIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiHLIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:51:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD80FA925D;
        Fri, 12 Aug 2022 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294299; x=1691830299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XektTh+zpZ/iYrgcAkbXtJA02td3HOeSRKGIpE6A8Us=;
  b=RakZlghyuKbwVAtUP/H0DsXe7+AKnkwfgKdupbKEqeSFTR0j2eIdgfZ8
   /kEbglOGLqrtVycSOVNXzCcTPJRusIUIN/HHwq/b3358PbkYyfcIUqNgF
   4ZafzQ4EiOcFCQAarItyAb7h4fBAhm6JYqVsiak3XWe9NT27xCDTyQzS1
   G5ABkWY+jNBQptDDssTdjRatz+Dn2J+5Ly4xS5PgzNHWE+9bHuf+yYyWH
   /pTZo6RgSagDUNFr+irPjKsyMoMiTs6D7TltnHJU2d3+zWZo6otjMkkPY
   wMCLa/uRgiE4otR5jKfrgID5zMP9rL5AnCpHGzClX4dYVLG4ydw7x/5qI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353297771"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="353297771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451389"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:51:36 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 02/11] perf vendor events: Update events and metrics for broadwellx
Date:   Fri, 12 Aug 2022 16:52:30 +0800
Message-Id: <20220812085239.3089231-3-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update to v19, the metrics are based on TMA 4.4 full, update events and add
new metrics “UNCORE_FREQ” for broadwellx.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the broadwellx files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/broadwellx/bdx-metrics.json      |   6 +
 .../arch/x86/broadwellx/uncore-cache.json     | 163 +-----------------
 2 files changed, 10 insertions(+), 159 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 720ee7c9332d..a3a15ee52841 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -444,6 +444,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "cbox_0@event\\=0x0@ / #num_dies / duration_time / 1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
index 1b9c1570aa47..abee6f773c1f 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
@@ -846,20 +846,19 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line). Derived from unc_c_tor_inserts.opcode",
+        "BriefDescription": "TOR Inserts; Opcode Match",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=0x180,filter_tid=0x3e",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line)",
+        "BriefDescription": "PCIe writes (partial cache line). Derived from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=0x180,filter_tid=0x3e",
         "PerPkg": "1",
         "UMask": "0x1",
@@ -876,17 +875,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "L2 demand and L2 prefetch code references to LLC",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=0x181",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -898,17 +886,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Streaming stores (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=0x18c",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derived from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -920,17 +897,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Streaming stores (partial cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=0x18d",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe read current. Derived from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -942,17 +908,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe read current",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=0x19e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe write references (full cache line). Derived from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -964,17 +919,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe write references (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=0x1c8,filter_tid=0x3e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Evictions",
         "Counter": "0,1,2,3",
@@ -1035,17 +979,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x187",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1057,17 +990,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "MMIO reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x187,filter_nc=1",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1079,17 +1001,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "MMIO writes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x18f,filter_nc=1",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for RFO. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1101,17 +1012,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for RFO",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x190",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for code reads. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1123,17 +1023,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for code reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x191",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for data reads. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1145,17 +1034,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for data reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x192",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC misses for PCIe read current. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1167,17 +1045,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC misses for PCIe read current",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x19e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "ItoM write misses (as part of fast string memcpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1189,17 +1056,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "ItoM write misses (as part of fast string memcpy stores) + PCIe full line writes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x1c8",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe write misses (full cache line). Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1211,17 +1067,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe write misses (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=0x1c8,filter_tid=0x3e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
         "Counter": "0,1,2,3",
-- 
2.25.1

