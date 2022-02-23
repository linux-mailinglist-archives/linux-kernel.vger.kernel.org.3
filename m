Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE54C09D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiBWDDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiBWDDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:03:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28864667C;
        Tue, 22 Feb 2022 19:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645585373; x=1677121373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YcTI272Lbbj7J4gDJWasOBDPpWoxZKcxYdeFowu9rjU=;
  b=KZ3TivfZGJoNWd65AxCI0iVkUQXz/3jTRuIxWpCSKAS97Xnkj+N2SfFK
   WXMjCWWWVtbYQc6w4FxqvlS1G19rzY3EeS/ISWKFqvtSo35W3vhyD9PFA
   pcTI7xXv+UeUIFCdwyH+gNujqy8Hl714GX38WMtM2WSJdqPsbeBK/imH2
   RD3Sa0OOCRRKnRc7nSu4GCxAAkDm+ZR/2xClDEON+ndg4FjWiF9wLyQtN
   Fr6rSGFpcH820wljWYjAZ1O1WLCR9/lFAx7rW6YTVfc32joR+j9jobrmH
   ajCUfI1r2E+//SHWkjzPuLGnkFRNbZ/kNlolaVQ0Fetbf28kkjZTp+AIF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251792026"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251792026"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 19:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="627926494"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2022 19:02:49 -0800
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf vendor events intel: Add uncore event list for Alderlake
Date:   Wed, 23 Feb 2022 19:01:35 +0800
Message-Id: <20220223110135.1943210-1-zhengjun.xing@linux.intel.com>
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

Add JSON uncore events for Alderlake to perf.

Based on JSON list v1.06:

https://download.01.org/perfmon/ADL/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/alderlake/uncore-memory.json     | 222 ++++++++++++++++++
 .../arch/x86/alderlake/uncore-other.json      |  40 ++++
 2 files changed, 262 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
new file mode 100644
index 000000000000..d82d6f62a6fb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
@@ -0,0 +1,222 @@
+[
+    {
+        "BriefDescription": "Number of clocks",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 read request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 read request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read prefetch request from IA",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0A",
+        "EventName": "UNC_M_PREFETCH_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Hot state",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_DRAM_THERMAL_HOT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Warm state",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_DRAM_THERMAL_WARM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Hit",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Empty",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming read request page status is Page Miss",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Hit",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Empty",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "incoming write request page status is Page Miss",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_CAS_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_CAS_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a read request sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a write request sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command sent to DRAM",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM for a read/write request",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x27",
+        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command sent to DRAM due to page table idle timer expiration",
+        "Counter": "0,1,2,3,4",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x28",
+        "EventName": "UNC_M_PRE_COUNT_IDLE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B read  request entering the Memory Controller 0 to DRAM (sum of all channels)",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B read request entering the Memory Controller 1 to DRAM (sum of all channels)",
+        "Counter": "3",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 0 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM",
+        "Counter": "1",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts every 64B write request entering the Memory Controller 1 to DRAM (sum of all channels). Each write request counts as a new request incrementing this counter. However, same cache line write requests (both full and partial) are combined to a single 64 byte data transfer to DRAM",
+        "Counter": "4",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
new file mode 100644
index 000000000000..50de82c29944
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -0,0 +1,40 @@
+[
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
+        "Counter": "Fixed",
+        "CounterType": "PGMABLE",
+	"EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "Unit": "CLOCK"
+    },
+    {
+        "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of requests allocated in Coherency Tracker",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    }
+]
-- 
2.25.1

