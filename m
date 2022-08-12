Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873A590DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiHLIxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbiHLIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:52:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A181A98C0;
        Fri, 12 Aug 2022 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294352; x=1691830352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+PkUGEcHxe+CpUuQ5yN2RHQnksErokFDnGFnHKRY7cQ=;
  b=eOFtZoC0WrmiYTSRKLA4VvBkimIipgfrzVZ3KYyW9bexQp1uTHxXtnhM
   sGskBWFhV7wFUnCv+hA4xz91udSI3ieac4b3geX0vTPZs3b7YUa/g6usZ
   klctcbjRJpgWVtWeJ2xDFHRud/zqKf2N9QHOdDUwnhy4lr0H3LWY+Yt/1
   GuO1YQI0A6D1c3SqOSzUNClyCToLTSkPm5GDYIu/qJyau9a35o6H98Zw3
   JNItJlSAr1xODKBXEuUU8HzlAXdIQeeNOeg/ecnPYmnKgOiyBfoca7p1+
   EPhE8TuMWA3FLvDHCnm1oeGIyIxOa4vk7kOl5yuL81vJk5jg44k9S0lil
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292350104"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292350104"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:52:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451531"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:52:29 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 11/11] perf vendor events: Update events for snowridgex
Date:   Fri, 12 Aug 2022 16:52:39 +0800
Message-Id: <20220812085239.3089231-12-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update the events to v1.20, update events for snowridgex by the latest
event converter tools.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the snowridgex files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/snowridgex/uncore-other.json     | 111 +++++-------------
 1 file changed, 27 insertions(+), 84 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
index 4750b3806a51..1701db46696d 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
@@ -132,23 +132,22 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "TOR Inserts : All requests from iA Cores that Missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "config1=0x40e33",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
         "PerPkg": "1",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "EventName": "LLC_MISSES.UNCACHEABLE",
         "Filter": "config1=0x40e33",
         "PerPkg": "1",
         "UMask": "0xC001FE01",
@@ -167,18 +166,6 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "MMIO reads",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=0x40040e33",
-        "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -191,18 +178,6 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "MMIO writes",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=0x40041e33",
-        "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -216,19 +191,6 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "Streaming stores (full cache line)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=0x41833",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -242,19 +204,6 @@
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
-    {
-        "BriefDescription": "Streaming stores (partial cache line)",
-        "Counter": "0,1,2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=0x41a33",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
-    },
     {
         "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Missed the LLC",
         "Counter": "0,1,2,3",
@@ -829,31 +778,12 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived from unc_iio_data_req_of_cpu.mem_write.part0",
-        "Counter": "0,1",
-        "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
-    },
-    {
-        "BriefDescription": "PCI Express bandwidth writing at IIO",
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
-        "Filter": "ch_mask=0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
         "PerPkg": "1",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
@@ -900,31 +830,28 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived from unc_iio_data_req_of_cpu.mem_read.part0",
+        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived from unc_iio_data_req_of_cpu.mem_write.part0",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
         "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_READ",
+        "EventName": "LLC_MISSES.PCIE_WRITE",
         "FCMask": "0x07",
         "Filter": "ch_mask=0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
         "PerPkg": "1",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
+        "UMask": "0x01",
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO",
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
-        "Filter": "ch_mask=0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
         "PerPkg": "1",
         "PortMask": "0x01",
         "ScaleUnit": "4Bytes",
@@ -970,6 +897,22 @@
         "UMask": "0x04",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived from unc_iio_data_req_of_cpu.mem_read.part0",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "LLC_MISSES.PCIE_READ",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Data requested of the CPU : CmpD - device sending completion to CPU request",
         "Counter": "0,1",
-- 
2.25.1

