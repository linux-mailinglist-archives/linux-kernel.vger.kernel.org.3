Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E415427A8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiFHHLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiFHGfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:35:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56911CA11;
        Tue,  7 Jun 2022 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654670106; x=1686206106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jm28u6Ir4ybevXN4P17bAsnLSqrmLUHXrFHzOKSdLBg=;
  b=J7lOtjXP0/pe4KESaUFNEgxxeFEJthAQqXbALXwpOBAL2EKTnQWrCZXv
   fh2UINvZ7Iu9nLcWsNNeqr2eNukSM+Jjo4s3HsVzvDkNSKEcY2CTzGi6j
   Idw1xrqAbo4w+BHc/wKTImqD/mE8khR8Tm2VZ5nyATs4rS8wN2gfvMhrq
   6tG1CBpIke5vHGmHF1FGlrv0QITt1wsGsxQVoc/i4woJiK9T+D/bkr0wX
   ANnH5Oo18Lh0mOXVzwDhjKZOQTAWAh4Pp++sTH3rnGmwEOAF32Ho/0mta
   SXmAUIftyEeH6XG+Ow4PIqWy0pxpA9L7s+lZiDwDh9Ts2HMvRHca31rAa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="340883188"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="340883188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 23:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="579923913"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2022 23:34:38 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf vendor events intel: Update event list for Snowridgex
Date:   Wed,  8 Jun 2022 14:34:39 +0800
Message-Id: <20220608063439.1997394-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608063439.1997394-1-zhengjun.xing@linux.intel.com>
References: <20220608063439.1997394-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

More uncore events are added in the converter tool:

https://github.com/intel/event-converter-for-linux-perf

Re-generate the perf events based on Snowridgex(SNR) event list v1.19:

https://download.01.org/perfmon/SNR/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../pmu-events/arch/x86/snowridgex/cache.json |     2 +-
 .../arch/x86/snowridgex/floating-point.json   |     2 +-
 .../arch/x86/snowridgex/frontend.json         |     2 +-
 .../arch/x86/snowridgex/memory.json           |     2 +-
 .../arch/x86/snowridgex/uncore-memory.json    |   481 +-
 .../arch/x86/snowridgex/uncore-other.json     | 25243 +++++++++++++++-
 .../arch/x86/snowridgex/uncore-power.json     |   199 +-
 .../arch/x86/snowridgex/virtual-memory.json   |     2 +-
 8 files changed, 24434 insertions(+), 1499 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json b/tools/p=
erf/pmu-events/arch/x86/snowridgex/cache.json
index e142f294b42e..0582288a6f9c 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
@@ -1133,4 +1133,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json =
b/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
index c7780fa54689..f51278b155e7 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/floating-point.json
@@ -33,4 +33,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json b/tool=
s/perf/pmu-events/arch/x86/snowridgex/frontend.json
index c752c52ba03e..4fe368b06e4e 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/frontend.json
@@ -102,4 +102,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json b/tools/=
perf/pmu-events/arch/x86/snowridgex/memory.json
index 76eaefafdc89..5770d6ed34fc 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
@@ -439,4 +439,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
index b7ff25a5d717..cc07d4ddb82e 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
@@ -1,74 +1,185 @@
 [
     {
-        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to r=
ead",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x04",
-        "EventName": "LLC_MISSES.MEM_READ",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x0f",
+        "UMask": "0x04",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to w=
rite",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x08",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "read requests to memory controller",
+        "BriefDescription": "All DRAM read CAS commands issued (including =
underfills)",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
         "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x0f",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
+        "BriefDescription": "All DRAM write CAS commands issued",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
-        "EventName": "LLC_MISSES.MEM_WRITE",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x30",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "write requests to memory controller",
+        "BriefDescription": "All DRAM CAS commands issued",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
-        "EventName": "UNC_M_CAS_COUNT.WR",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x30",
+        "UMask": "0x3f",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory controller clock ticks",
+        "BriefDescription": "Number of DRAM Refreshes Issued",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventName": "UNC_M_CLOCKTICKS",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.OPPORTUNISTIC",
         "PerPkg": "1",
+        "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for reads",
+        "BriefDescription": "Number of DRAM Refreshes Issued",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M_PRE_COUNT.RD",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
         "PerPkg": "1",
         "UMask": "0x04",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for writes",
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to p=
age table",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x02",
-        "EventName": "UNC_M_PRE_COUNT.WR",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Clockticks",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Half clockticks for IMC",
+        "Counter": "FIXED",
+        "CounterType": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_HCLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
         "PerPkg": "1",
-        "UMask": "0x08",
         "Unit": "iMC"
     },
     {
@@ -78,168 +189,364 @@
         "EventCode": "0x01",
         "EventName": "UNC_M_ACT_COUNT.ALL",
         "PerPkg": "1",
-        "PublicDescription": "DRAM Activate Count : All Activates : Counts=
 the number of DRAM Activate commands sent on this channel.  Activate comma=
nds are issued to open up a page on the DRAM devices so that it can be read=
 or written to with a CAS.  One can calculate the number of Page Misses by =
subtracting the number of Page Miss precharges from the number of Activates=
.",
         "UMask": "0x0B",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM CAS commands issued",
+        "BriefDescription": "DRAM Precharge commands",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1C",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Data Buffer Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All DRAM read CAS commands issued (does not i=
nclude underfills)",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x04",
-        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of DRAM CAS commands=
 issued on this channel.",
-        "UMask": "0x3f",
+        "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "BriefDescription": "DRAM underfill read CAS commands issued",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x45",
-        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
         "PerPkg": "1",
-        "PublicDescription": "Number of DRAM Refreshes Issued : Counts the=
 number of refreshes issued.",
         "UMask": "0x04",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "BriefDescription": "DRAM Activate Count : Activate due to Bypass",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x45",
-        "EventName": "UNC_M_DRAM_REFRESH.OPPORTUNISTIC",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_ACT_COUNT.BYP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM RD_CA=
S commands w/auto-pre",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_CA=
S commands w/ auto-pre",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.WR_PRE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_0",
         "PerPkg": "1",
-        "PublicDescription": "Number of DRAM Refreshes Issued : Counts the=
 number of refreshes issued.",
         "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x45",
-        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_1",
         "PerPkg": "1",
-        "PublicDescription": "Number of DRAM Refreshes Issued : Counts the=
 number of refreshes issued.",
         "UMask": "0x02",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Half clockticks for IMC",
-        "Counter": "FIXED",
-        "CounterType": "FIXED",
-        "EventCode": "0xff",
-        "EventName": "UNC_M_HCLOCKTICKS",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_2",
         "PerPkg": "1",
-        "PublicDescription": "Half clockticks for IMC",
+        "UMask": "0x04",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands.",
+        "BriefDescription": "CKE_ON_CYCLES by Rank : DIMM ID",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.LOW_3",
         "PerPkg": "1",
-        "PublicDescription": "DRAM Precharge commands. : Counts the number=
 of DRAM Precharge commands sent on this channel.",
-        "UMask": "0x1C",
+        "UMask": "0x08",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to p=
age table",
+        "BriefDescription": "Throttle Cycles for Rank 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x02",
-        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_POWER_CRIT_THROTTLE_CYCLES.SLOT0",
         "PerPkg": "1",
-        "PublicDescription": "DRAM Precharge commands. : Precharge due to =
page table : Counts the number of DRAM Precharge commands sent on this chan=
nel. : Prechages from Page Table",
-        "UMask": "0x10",
+        "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Allocations",
+        "BriefDescription": "Throttle Cycles for Rank 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_POWER_CRIT_THROTTLE_CYCLES.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT0",
         "PerPkg": "1",
-        "PublicDescription": "Read Pending Queue Allocations : Counts the =
number of allocations into the Read Pending Queue.  This queue is used to s=
chedule reads out to the memory controller and to track the requests.  Requ=
ests allocate into the RPQ soon after they enter the memory controller, and=
 need credits for an entry in this buffer before being sent from the HA to =
the iMC.  They deallocate after the CAS command has been issued to memory. =
 This includes both ISOCH and non-ISOCH requests.",
         "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Allocations",
+        "BriefDescription": "Throttle Cycles for Rank 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.SLOT1",
         "PerPkg": "1",
-        "PublicDescription": "Read Pending Queue Allocations : Counts the =
number of allocations into the Read Pending Queue.  This queue is used to s=
chedule reads out to the memory controller and to track the requests.  Requ=
ests allocate into the RPQ soon after they enter the memory controller, and=
 need credits for an entry in this buffer before being sent from the HA to =
the iMC.  They deallocate after the CAS command has been issued to memory. =
 This includes both ISOCH and non-ISOCH requests.",
         "UMask": "0x02",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Occupancy",
+        "BriefDescription": "Read Pending Queue Not Empty",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x80",
-        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH0",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE.PCH0",
         "PerPkg": "1",
-        "PublicDescription": "Read Pending Queue Occupancy : Accumulates t=
he occupancies of the Read Pending Queue each cycle.  This can then be used=
 to calculate both the average occupancy (in conjunction with the number of=
 cycles not empty) and the average latency (in conjunction with the number =
of allocations).  The RPQ is used to schedule reads out to the memory contr=
oller and to track the requests.  Requests allocate into the RPQ soon after=
 they enter the memory controller, and need credits for an entry in this bu=
ffer before being sent from the HA to the iMC. They deallocate after the CA=
S command has been issued to memory.",
+        "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Occupancy",
+        "BriefDescription": "Read Pending Queue Not Empty",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x81",
-        "EventName": "UNC_M_RPQ_OCCUPANCY_PCH1",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE.PCH1",
         "PerPkg": "1",
-        "PublicDescription": "Read Pending Queue Occupancy : Accumulates t=
he occupancies of the Read Pending Queue each cycle.  This can then be used=
 to calculate both the average occupancy (in conjunction with the number of=
 cycles not empty) and the average latency (in conjunction with the number =
of allocations).  The RPQ is used to schedule reads out to the memory contr=
oller and to track the requests.  Requests allocate into the RPQ soon after=
 they enter the memory controller, and need credits for an entry in this bu=
ffer before being sent from the HA to the iMC. They deallocate after the CA=
S command has been issued to memory.",
+        "UMask": "0x02",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Allocations",
+        "BriefDescription": "Write Pending Queue Not Empty",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE.PCH0",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Allocations : Counts the=
 number of allocations into the Write Pending Queue.  This can then be used=
 to calculate the average queuing latency (in conjunction with the WPQ occu=
pancy count).  The WPQ is used to schedule write out to the memory controll=
er and to track the writes.  Requests allocate into the WPQ soon after they=
 enter the memory controller, and need credits for an entry in this buffer =
before being sent from the CHA to the iMC.  They deallocate after being iss=
ued to DRAM.  Write requests themselves are able to complete (from the pers=
pective of the rest of the system) as soon they have posted to the iMC.",
         "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Allocations",
+        "BriefDescription": "Write Pending Queue Not Empty",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE.PCH1",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Allocations : Counts the=
 number of allocations into the Write Pending Queue.  This can then be used=
 to calculate the average queuing latency (in conjunction with the WPQ occu=
pancy count).  The WPQ is used to schedule write out to the memory controll=
er and to track the writes.  Requests allocate into the WPQ soon after they=
 enter the memory controller, and need credits for an entry in this buffer =
before being sent from the CHA to the iMC.  They deallocate after being iss=
ued to DRAM.  Write requests themselves are able to complete (from the pers=
pective of the rest of the system) as soon they have posted to the iMC.",
         "UMask": "0x02",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Occupancy",
+        "BriefDescription": "Write Pending Queue CAM Match",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x82",
-        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH0",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT.PCH0",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happenning in the iMC for writes before the=
y are actually issued to memory.  High average occupancies will generally c=
oincide with high write major mode counts.",
+        "UMask": "0x01",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Occupancy",
+        "BriefDescription": "Write Pending Queue CAM Match",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_M_WPQ_OCCUPANCY_PCH1",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT.PCH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT.PCH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT.PCH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M_DRAM_PRE_ALL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel PPD Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M_POWER_CHANNEL_PPD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Clock-Enabled Self-Refresh",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_POWER_SELF_REFRESH",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Data Buffer Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M_RDB_FULL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Data Buffer Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M_RDB_NOT_EMPTY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Data Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M_RDB_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M_RPQ_CYCLES_FULL_PCH0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M_RPQ_CYCLES_FULL_PCH1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL_PCH0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL_PCH1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands. : DRAM WR_CA=
S commands w/o auto-pre",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_CAS_COUNT.WR_NONPRE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to p=
age miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
+        "PerPkg": "1",
+        "UMask": "0x0c",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for the =
Memory Controller",
+        "Counter": "4",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_M_CLOCKTICKS_FREERUN",
         "PerPkg": "1",
-        "PublicDescription": "Write Pending Queue Occupancy : Accumulates =
the occupancies of the Write Pending Queue each cycle.  This can then be us=
ed to calculate both the average queue occupancy (in conjunction with the n=
umber of cycles not empty) and the average latency (in conjunction with the=
 number of allocations).  The WPQ is used to schedule write out to the memo=
ry controller and to track the writes.  Requests allocate into the WPQ soon=
 after they enter the memory controller, and need credits for an entry in t=
his buffer before being sent from the HA to the iMC.  They deallocate after=
 being issued to DRAM.  Write requests themselves are able to complete (fro=
m the perspective of the rest of the system) as soon they have posted to th=
e iMC.  This is not to be confused with actually performing the write to DR=
AM.  Therefore, the average latency for this queue is actually not useful f=
or deconstruction intermediate write latencies.  So, we provide filtering b=
ased on if the request has posted or not.  By using the not posted filter, =
we can track how long writes spent in the iMC before completions were sent =
to the HA.  The posted filter, on the other hand, provides information abou=
t how much queueing is actually happenning in the iMC for writes before the=
y are actually issued to memory.  High average occupancies will generally c=
oincide with high write major mode counts.",
         "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
index 5194ce1b4390..c54b6b1e30de 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-other.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "Clockticks of the uncore caching and home age=
nt (CHA)",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventName": "UNC_CHA_CLOCKTICKS",
@@ -8,569 +8,572 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "Normal priority reads issued to the memory co=
ntroller from the CHA",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "config1=3D0x40e33",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : Full Lin=
e Non-ISOCH",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40e33",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.=
ia_miss",
+        "BriefDescription": "Lines Victimized : All Lines Victimized",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "config1=3D0x40040e33",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0x0F",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO reads",
+        "BriefDescription": "Local read requests that miss the SF/LLC and =
remote read requests sent to the CHA's home agent",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40040e33",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0x03",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts=
.ia_miss",
+        "BriefDescription": "Local write requests that miss the SF/LLC and=
 remote write requests sent to the CHA's home agent",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "config1=3D0x40041e33",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0x0c",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for E-state e=
ntries",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for M-state e=
ntries",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for S-state e=
ntries",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "PerPkg": "1",
+        "UMask": "0x04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO writes",
+        "BriefDescription": "TOR Inserts : All requests from iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40041e33",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
         "PerPkg": "1",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0xC001FF01",
+        "UMaskExt": "0xC001FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "TOR Inserts : All requests from iA Cores that=
 Hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "config1=3D0x41833",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0xC001FD01",
+        "UMaskExt": "0xC001FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line)",
+        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Hi=
t the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x41833",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0xC80FFD01",
+        "UMaskExt": "0xC80FFD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Hi=
t the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "config1=3D0x41a33",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
+        "UMask": "0xC807FD01",
+        "UMaskExt": "0xC807FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line)",
+        "BriefDescription": "TOR Inserts : All requests from iA Cores that=
 Missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x41a33",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0xC001FE01",
         "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "read requests from home agent",
+        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Mi=
ssed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
         "PerPkg": "1",
-        "UMask": "0x03",
+        "UMask": "0xC80FFE01",
+        "UMaskExt": "0xC80FFE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "write requests from home agent",
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Mi=
ssed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
         "PerPkg": "1",
-        "UMask": "0x0c",
+        "UMask": "0xC807FE01",
+        "UMaskExt": "0xC807FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_read.part0",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Inserts : All requests from IO Devices",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_READ",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DAT=
A_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_II=
O_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0xC001FF04",
+        "UMaskExt": "0xC001FF",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Inserts : All requests from IO Devices th=
at hit the LLC",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DAT=
A_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_II=
O_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0xC001FD04",
+        "UMaskExt": "0xC001FD",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_write.part0",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Inserts : All requests from IO Devices th=
at missed the LLC",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0xC001FE04",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : All requests from iA Cores",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0xC001FF01",
+        "UMaskExt": "0xC001FF",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : All requests from iA Cores th=
at Hit the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0xC001FD01",
+        "UMaskExt": "0xC001FD",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 2",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : All requests from iA Cores th=
at Missed the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 3",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : CRds issued by iA Cores that =
Missed the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0xC80FFE01",
+        "UMaskExt": "0xC80FFE",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 1",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : RFOs issued by iA Cores that =
Missed the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0xC807FE01",
+        "UMaskExt": "0xC807FE",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 2",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : All requests from IO Devices",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0xC001FF04",
+        "UMaskExt": "0xC001FF",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 3",
-        "Counter": "0,1",
+        "BriefDescription": "TOR Occupancy : All requests from IO Devices =
that hit the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0xC001FD04",
+        "UMaskExt": "0xC001FD",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "CMS Clockticks",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "TOR Occupancy : All requests from IO Devices =
that missed the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_CHA_CMS_CLOCKTICKS",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
         "PerPkg": "1",
-        "PublicDescription": "CMS Clockticks",
+        "UMask": "0xC001FE04",
+        "UMaskExt": "0xC001FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Normal priority reads issued to the memory co=
ntroller from the CHA",
+        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices that=
 missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x59",
-        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a normal (Non-Isochronous) read =
is issued to any of the memory controller channels from the CHA.",
-        "UMask": "0x01",
+        "UMask": "0xCC43FE04",
+        "UMaskExt": "0xCC43FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "CHA to iMC Full Line Writes Issued : Full Lin=
e Non-ISOCH",
+        "BriefDescription": "CMS Clockticks",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x5B",
-        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "EventCode": "0xc0",
+        "EventName": "UNC_CHA_CMS_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a normal (Non-Isochronous) full =
line write is issued from the CHA to any of the memory controller channels.=
",
-        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
+        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x34",
-        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
-        "UMask": "0x1BC1FF",
-        "UMaskExt": "0x1BC1",
+        "UMask": "0xC88FFD01",
+        "UMaskExt": "0xC88FFD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Lines Victimized : All Lines Victimized",
+        "BriefDescription": "TOR Inserts : DRd_Opts issued by iA Cores tha=
t hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
         "PerPkg": "1",
-        "PublicDescription": "Lines Victimized : All Lines Victimized : Co=
unts the number of lines that were victimized on a fill.  This can be filte=
red by the state that the line was in.",
-        "UMask": "0x0F",
+        "UMask": "0xC827FD01",
+        "UMaskExt": "0xC827FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for E-state e=
ntries.",
+        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s that hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x3D",
-        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking exclusive lines in the cores? cache.? Snoop filter capacity=
 evictions occur when the snoop filter is full and evicts an existing entry=
 to track a new entry.? Does not count clean evictions such as when a core?=
s cache replaces a tracked cacheline with a new cacheline.",
-        "UMask": "0x02",
+        "UMask": "0xC8A7FD01",
+        "UMaskExt": "0xC8A7FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for M-state e=
ntries.",
+        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores th=
at Hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x3D",
-        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking modified lines in the cores? cache.? Snoop filter capacity =
evictions occur when the snoop filter is full and evicts an existing entry =
to track a new entry.? Does not count clean evictions such as when a core?s=
 cache replaces a tracked cacheline with a new cacheline.",
-        "UMask": "0x01",
+        "UMask": "0xC887FD01",
+        "UMaskExt": "0xC887FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for S-state e=
ntries.",
+        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x3D",
-        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking shared lines in the cores? cache.? Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry.? Does not count clean evictions such as when a core?s c=
ache replaces a tracked cacheline with a new cacheline.",
-        "UMask": "0x04",
+        "UMask": "0xC88FFE01",
+        "UMaskExt": "0xC88FFE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All requests from iA Cores",
+        "BriefDescription": "TOR Inserts : DRd_Opt issued by iA Cores that=
 missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores : C=
ounts the number of entries successfuly inserted into the TOR that match qu=
alifications specified by the subevent.   Does not include addressless requ=
ests such as locks and interrupts.",
-        "UMask": "0xC001FF01",
-        "UMaskExt": "0xC001FF",
+        "UMask": "0xC827FE01",
+        "UMaskExt": "0xC827FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CLFlushes issued by iA Cores",
+        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s that missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CLFlushes issued by iA Cores :=
 Counts the number of entries successfuly inserted into the TOR that match =
qualifications specified by the subevent.   Does not include addressless re=
quests such as locks and interrupts.",
-        "UMask": "0xC8C7FF01",
-        "UMaskExt": "0xC8C7FF",
+        "UMask": "0xC8A7FE01",
+        "UMaskExt": "0xC8A7FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CRDs issued by iA Cores",
+        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores th=
at Missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRDs issued by iA Cores : Coun=
ts the number of entries successfuly inserted into the TOR that match quali=
fications specified by the subevent.   Does not include addressless request=
s such as locks and interrupts.",
-        "UMask": "0xC80FFF01",
-        "UMaskExt": "0xC80FFF",
+        "UMask": "0xC887FE01",
+        "UMaskExt": "0xC887FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opts issued by iA Cores",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "TOR Occupancy : DRd_Opts issued by iA Cores t=
hat hit the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores : =
Counts the number of entries successfuly inserted into the TOR that match q=
ualifications specified by the subevent.   Does not include addressless req=
uests such as locks and interrupts.",
-        "UMask": "0xC827FF01",
-        "UMaskExt": "0xC827FF",
+        "UMask": "0xC827FD01",
+        "UMaskExt": "0xC827FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA Co=
res that hit the LLC",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es : Counts the number of entries successfuly inserted into the TOR that ma=
tch qualifications specified by the subevent.   Does not include addressles=
s requests such as locks and interrupts.",
-        "UMask": "0xC8A7FF01",
-        "UMaskExt": "0xC8A7FF",
+        "UMask": "0xC8A7FD01",
+        "UMaskExt": "0xC8A7FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : All requests from iA Cores that=
 Hit the LLC",
+        "BriefDescription": "TOR Occupancy : DRd_Opt issued by iA Cores th=
at missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "UMask": "0xC827FE01",
+        "UMaskExt": "0xC827FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices that=
 Hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Hit the LLC : Counts the number of entries successfuly inserted into the =
TOR that match qualifications specified by the subevent.   Does not include=
 addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FD01",
-        "UMaskExt": "0xC001FD",
+        "UMask": "0xCC43FD04",
+        "UMaskExt": "0xCC43FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Hi=
t the LLC",
+        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfuly inserted into the TOR=
 that match qualifications specified by the subevent.   Does not include ad=
dressless requests such as locks and interrupts.",
-        "UMask": "0xC80FFD01",
-        "UMaskExt": "0xC80FFD",
+        "UMask": "0xCC43FF04",
+        "UMaskExt": "0xCC43FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at hit the LLC",
+        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat hit the LLC : Counts the number of entries successfuly inserted into th=
e TOR that match qualifications specified by the subevent.   Does not inclu=
de addressless requests such as locks and interrupts.",
-        "UMask": "0xC88FFD01",
-        "UMaskExt": "0xC88FFD",
+        "UMask": "0xC887FF01",
+        "UMaskExt": "0xC887FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opts issued by iA Cores tha=
t hit the LLC",
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores th=
at hit the LLC : Counts the number of entries successfuly inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
-        "UMask": "0xC827FD01",
-        "UMaskExt": "0xC827FD",
+        "UMask": "0xC807FF01",
+        "UMaskExt": "0xC807FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s that hit the LLC",
+        "BriefDescription": "TOR Inserts : DRd_Opts issued by iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that hit the LLC : Counts the number of entries successfuly inserted int=
o the TOR that match qualifications specified by the subevent.   Does not i=
nclude addressless requests such as locks and interrupts.",
-        "UMask": "0xC8A7FD01",
-        "UMaskExt": "0xC8A7FD",
+        "UMask": "0xC827FF01",
+        "UMaskExt": "0xC827FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Hi=
t the LLC",
+        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfuly inserted into the TOR=
 that match qualifications specified by the subevent.   Does not include ad=
dressless requests such as locks and interrupts.",
-        "UMask": "0xC807FD01",
-        "UMaskExt": "0xC807FD",
+        "UMask": "0xC8A7FF01",
+        "UMaskExt": "0xC8A7FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores th=
at Hit the LLC",
+        "BriefDescription": "TOR Inserts : CRDs issued by iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Hit the LLC : Counts the number of entries successfuly inserted into th=
e TOR that match qualifications specified by the subevent.   Does not inclu=
de addressless requests such as locks and interrupts.",
-        "UMask": "0xC887FD01",
-        "UMaskExt": "0xC887FD",
+        "UMask": "0xC80FFF01",
+        "UMaskExt": "0xC80FFF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Mi=
ssed the LLC",
+        "BriefDescription": "TOR Occupancy : RFOs issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC807FF01",
+        "UMaskExt": "0xC807FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRd_Opts issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "PerPkg": "1",
+        "UMask": "0xC827FF01",
+        "UMaskExt": "0xC827FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA Co=
res",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC8A7FF01",
+        "UMaskExt": "0xC8A7FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CRDs issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "PerPkg": "1",
+        "UMask": "0xC80FFF01",
+        "UMaskExt": "0xC80FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : CLFlushes issued by iA Cores",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfuly inserted into the =
TOR that match qualifications specified by the subevent.   Does not include=
 addressless requests such as locks and interrupts.",
-        "UMask": "0xC80FFE01",
-        "UMaskExt": "0xC80FFE",
+        "UMask": "0xC8C7FF01",
+        "UMaskExt": "0xC8C7FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : CRd_Prefs issued by iA Cores th=
at Missed the LLC",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC : Counts the number of entries successfuly inserted into=
 the TOR that match qualifications specified by the subevent.   Does not in=
clude addressless requests such as locks and interrupts.",
-        "UMask": "0xC88FFE01",
-        "UMaskExt": "0xC88FFE",
+        "UMask": "0xCD43FF04",
+        "UMaskExt": "0xCD43FF",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opt issued by iA Cores that=
 missed the LLC",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that hit the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t missed the LLC : Counts the number of entries successfuly inserted into t=
he TOR that match qualifications specified by the subevent.   Does not incl=
ude addressless requests such as locks and interrupts.",
-        "UMask": "0xC827FE01",
-        "UMaskExt": "0xC827FE",
+        "UMask": "0xCD43FD04",
+        "UMaskExt": "0xCD43FD",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Core=
s that missed the LLC",
+        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC : Counts the number of entries successfuly inserted =
into the TOR that match qualifications specified by the subevent.   Does no=
t include addressless requests such as locks and interrupts.",
-        "UMask": "0xC8A7FE01",
-        "UMaskExt": "0xC8A7FE",
+        "UMask": "0xCD43FE04",
+        "UMaskExt": "0xCD43FE",
         "Unit": "CHA"
     },
     {
@@ -580,7 +583,6 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_FULL_STREAMING_WR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts; Data read from local IA that mi=
sses in the snoop filter",
         "UMask": "0xc867fe01",
         "UMaskExt": "0xc867fe",
         "Unit": "CHA"
@@ -592,33 +594,30 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_PARTIAL_STREAMING_WR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts; Data read from local IA that mi=
sses in the snoop filter",
         "UMask": "0xc86ffe01",
         "UMaskExt": "0xc86ffe",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Mi=
ssed the LLC",
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores that M=
issed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfuly inserted into the =
TOR that match qualifications specified by the subevent.   Does not include=
 addressless requests such as locks and interrupts.",
-        "UMask": "0xC807FE01",
-        "UMaskExt": "0xC807FE",
+        "UMask": "0xC86FFE01",
+        "UMaskExt": "0xC86FFE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores th=
at Missed the LLC",
+        "BriefDescription": "TOR Inserts : WiLs issued by iA Cores that Mi=
ssed LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC : Counts the number of entries successfuly inserted into=
 the TOR that match qualifications specified by the subevent.   Does not in=
clude addressless requests such as locks and interrupts.",
-        "UMask": "0xC887FE01",
-        "UMaskExt": "0xC887FE",
+        "UMask": "0xC87FDE01",
+        "UMaskExt": "0xC87FDE",
         "Unit": "CHA"
     },
     {
@@ -628,1768 +627,24200 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : UCRdFs issued by iA Cores that=
 Missed LLC : Counts the number of entries successfuly inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0xC877DE01",
         "UMaskExt": "0xC877DE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores that M=
issed the LLC",
+        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices =
that missed the LLC",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores that =
Missed the LLC : Counts the number of entries successfuly inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
-        "UMask": "0xC86FFE01",
-        "UMaskExt": "0xC86FFE",
+        "UMask": "0xC8F3FE04",
+        "UMaskExt": "0xC8F3FE",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores that M=
issed the LLC",
+        "BriefDescription": "TOR Occupancy : PCIRdCurs issued by IO Device=
s that missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0xc8f3fe04",
+        "UMaskExt": "0xc8f3fe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices =
that hit the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0xC8F3FD04",
+        "UMaskExt": "0xC8F3FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0xC8F3FF04",
+        "UMaskExt": "0xC8F3FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : PCIRdCurs issued by IO Device=
s",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0xC8F3FF04",
+        "UMaskExt": "0xC8F3FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores that M=
issed the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "UMask": "0xC867FE01",
+        "UMaskExt": "0xC867FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x1BC1FF",
+        "UMaskExt": "0x1BC1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Clockticks of the integrated IO (IIO) traffic=
 controller",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number requests PCIe makes of the main die : =
All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU.COMMIT.ALL",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for IIO =
clocktick",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_CLOCKTICKS_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 0",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 7",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 6",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 5",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 4",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 3",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 2",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 1",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0-7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0xff",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 0-7",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Lost Forward",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "PCIITOM request issued by the IRP unit to the=
 mesh with the intention of writing a full cacheline",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops : WbMtoI",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total IRP occupancy of inbound read and write=
 requests to coherent memory",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0f",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": ": All Inserts Inbound (p2p + faf + cset)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clockticks of the IO coherency tracker (IRP)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF RF full",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_FAF_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Occupancy of the IRP FAF queue",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF allocation -- sent to ADQ",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_FAF_TRANSACTIONS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit M li=
ne in the IIO cache",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (M2M)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_M2M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M2M_CMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to PCI (M2P)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2P_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M2P_CMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
+        "Counter": "FIXED",
+        "CounterType": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Local - All Lines",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x200F",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counter 0 Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_CHA_COUNTER0_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of times that an RFO hit in S state",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Local INVITOE requests (exclusive ownership o=
f a cache line without receiving data) that miss the SF/LLC and remote INVI=
TOE requests sent to the CHA's home agent",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Phy=
Addr Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0xC001FFff",
+        "UMaskExt": "0xC001FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CRds issued by iA Cores that =
Hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "PerPkg": "1",
+        "UMask": "0xC80FFD01",
+        "UMaskExt": "0xC80FFD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFOs issued by iA Cores that =
Hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC807FD01",
+        "UMaskExt": "0xC807FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : RFOs issued by IO Devices that =
missed the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "PerPkg": "1",
+        "UMask": "0xc803fe04",
+        "UMaskExt": "0xc803fe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFOs issued by IO Devices tha=
t missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "PerPkg": "1",
+        "UMask": "0xc803fe04",
+        "UMaskExt": "0xc803fe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMs issued by IO Devices th=
at missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "UMask": "0xcc43fe04",
+        "UMaskExt": "0xcc43fe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass : Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass : Intermediate bypass Taken=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.INTERMEDIATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass : Not Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Single External Sn=
oops",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EXT_ONE",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Single Core Reques=
ts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_ONE",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Single Eviction",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_ONE",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Any Single Snoop",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.ANY_ONE",
+        "PerPkg": "1",
+        "UMask": "0xF1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Multiple External =
Snoops",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EXT_GTONE",
+        "PerPkg": "1",
+        "UMask": "0x22",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Multiple Core Requ=
ests",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
+        "PerPkg": "1",
+        "UMask": "0x42",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Multiple Eviction",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "PerPkg": "1",
+        "UMask": "0x82",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued : Any Cycle with Mul=
tiple Snoops",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.ANY_GTONE",
+        "PerPkg": "1",
+        "UMask": "0xF2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_CHA_DIRECT_GO.HA_TOR_DEALLOC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_CHA_DIRECT_GO.HA_SUPPRESS_NO_D2C",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_CHA_DIRECT_GO.HA_SUPPRESS_DRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.EXTCMP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.PULL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.GO",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.GO_PULL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.FAST_GO",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.FAST_GO_PULL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.NOP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Direct GO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_CHA_DIRECT_GO_OPC.IDLE_DUE_SUPPRESS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "HA to iMC Reads Issued : ISOCH",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_IMC_READS_COUNT.PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Lines in M state",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.M_STATE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Lines in E state",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.E_STATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Lines in S State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.S_STATE",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Local Only",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ONLY",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Local - Lines in M State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "PerPkg": "1",
+        "UMask": "0x2001",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Local - Lines in E State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "PerPkg": "1",
+        "UMask": "0x2002",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Local - Lines in S State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "PerPkg": "1",
+        "UMask": "0x2004",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc : Silent Snoop Eviction",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RSPI_WAS_FSE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc : Write Combining Aliasing",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.WC_ALIASING",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc : CV0 Prefetch Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.CV0_PREF_VIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc : CV0 Prefetch Miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.CV0_PREF_MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.RMW_SETMATCH",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.GOTRACK_PAMATCH",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.GOTRACK_ALLOWSNP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.GOTRACK_WAYMATCH",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.GOTRACK_ALLWAYRSV",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.PTL_INPIPE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.IRQ_SETMATCH_VICP",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.FSF_VICP",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.ONE_FSF_VIC",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.TORID_MATCH_GO_P",
+        "PerPkg": "1",
+        "UMaskExt": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.IPQ_SETMATCH_VICP",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.WAY_MATCH",
+        "PerPkg": "1",
+        "UMaskExt": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.ONE_RSP_CON",
+        "PerPkg": "1",
+        "UMaskExt": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.IDX_INPIPE",
+        "PerPkg": "1",
+        "UMaskExt": "0x100",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.SETMATCHENTRYWSCT",
+        "PerPkg": "1",
+        "UMaskExt": "0x200",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.ALLRSFWAYS_RES",
+        "PerPkg": "1",
+        "UMaskExt": "0x800",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.RRQ_SETMATCH_VICP",
+        "PerPkg": "1",
+        "UMaskExt": "0x1000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.ISMQ_SETMATCH_VICP",
+        "PerPkg": "1",
+        "UMaskExt": "0x2000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.SF_WAYS_RES",
+        "PerPkg": "1",
+        "UMaskExt": "0x4000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.LLC_WAYS_RES",
+        "PerPkg": "1",
+        "UMaskExt": "0x8000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.NOTALLOWSNOOP",
+        "PerPkg": "1",
+        "UMaskExt": "0x10000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.TOPA_MATCH",
+        "PerPkg": "1",
+        "UMaskExt": "0x20000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.IVEGRCREDIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x40000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.BLEGRCREDIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x80000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.ADEGRCREDIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x100000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.AKEGRCREDIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x200000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.HACREDIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x400000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_AD_REQ",
+        "PerPkg": "1",
+        "UMaskExt": "0x800000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_AD_RSP",
+        "PerPkg": "1",
+        "UMaskExt": "0x1000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_BL_RSP",
+        "PerPkg": "1",
+        "UMaskExt": "0x2000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_BL_WB",
+        "PerPkg": "1",
+        "UMaskExt": "0x4000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_BL_NCB",
+        "PerPkg": "1",
+        "UMaskExt": "0x8000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Pipe Rejects",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_CHA_PIPE_REJECT.VN_BL_NCS",
+        "PerPkg": "1",
+        "UMaskExt": "0x10000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC8",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC9",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC10",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC11",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC11",
+        "PerPkg": "1",
+        "UMaskExt": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC12",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC12",
+        "PerPkg": "1",
+        "UMaskExt": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty : MC13",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC13",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations : IRQ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations : IRQ Rejected=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations : PRQ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations : PRQ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : AD=
 REQ on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : AD=
 RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCS on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI AK Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI IV Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : AN=
Y0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : HA=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : LL=
C Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : SF=
 Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : Vi=
ctim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : LL=
C or SF Way",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "IRQ Requests (from CMS) Rejected - Set 1 : Al=
low Snoop",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects - Set 1 : HA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2D",
+        "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2D",
+        "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy : IRQ",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 0 : Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : LLC OR SF Way",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries - Set 1 : PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : AD=
 REQ on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : AD=
 RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 RSP on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : BL=
 NCS on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI AK Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 0 : No=
n UPI IV Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : AN=
Y0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : HA=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : LL=
C Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : SF=
 Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Vi=
ctim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : LL=
C OR SF Way",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Al=
low Snoop",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PRQ Requests (from CMS) Rejected - Set 1 : Ph=
yAddr Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : AD REQ on VN0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : AD RSP on VN0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : BL RSP on VN0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : BL NCB on VN0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : BL NCS on VN0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : Non UPI AK Re=
quest",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 0 : Non UPI IV Re=
quest",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : ANY0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : HA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : LLC Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : SF Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : Victim",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : LLC OR SF Way=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : Allow Snoop",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries - Set 1 : PhyAddr Match=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent : Snoops sent for Local Requests",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent : Broadcast snoops for Local Requ=
ests",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.BCST_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent : Directed snoops for Local Reque=
sts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.DIRECT_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspI",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspIFwd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPIFWD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspSFwd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPSFWD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : Rsp*WB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPWB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : Rsp*FWD*WB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPFWDWB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspCnflct",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPCNFLCT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local : RspFwd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPFWD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : MtoI RspIFwdM=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.MTOI_RSPIFWDM",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : MtoI RspIData=
M",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.MTOI_RSPDATAM",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : RspIFwdPtl Hi=
t SF",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.RSPIFWDMPTL_HITSF",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : RspIFwdPtl Hi=
t LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.RSPIFWDMPTL_HITLLC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : Pull Data Par=
tial - Hit SF",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.PULLDATAPTL_HITSF",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Misc Snoop Responses Received : Pull Data Par=
tial - Hit LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_CHA_SNOOP_RSP_MISC.PULLDATAPTL_HITLLC",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbPushMtoI : Pushed to LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x56",
+        "EventName": "UNC_CHA_WB_PUSH_MTOI.LLC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbPushMtoI : Pushed to Memory",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x56",
+        "EventName": "UNC_CHA_WB_PUSH_MTOI.MEM",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC8",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC9",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC10",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC11",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC11",
+        "PerPkg": "1",
+        "UMaskExt": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC12",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC12",
+        "PerPkg": "1",
+        "UMaskExt": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty : MC13",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC13",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Sent (on 0?)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.SENT0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Dropped (on 0?) - No Credits=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.DROP0_NOCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Dropped (on 0?) - Conflict",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.DROP0_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Sent (on 1?)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.SENT1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Dropped (on 1?) - No Credits=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.DROP1_NOCRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "XPT Prefetches : Dropped (on 1?) - Conflict",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_CHA_XPT_PREF.DROP1_CONFLICT",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : I State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.I",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : SnoopFilter - S State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.SF_S",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : SnoopFilter - E State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.SF_E",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : SnoopFilter - H State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.SF_H",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : S State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.S",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : E State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.E",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : M State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.M",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : F State",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.F",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : RFO Requests",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
+        "PerPkg": "1",
+        "UMask": "0x1BC8FF",
+        "UMaskExt": "0x1BC8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : IRQ - iA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_IA",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : SF/LLC Evictions",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : PRQ - IOSF",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_IOSF",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : IRQ - Non iA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IRQ_NON_IA",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : PRQ - Non IOSF",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PRQ_NON_IOSF",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : All from Local IO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "PerPkg": "1",
+        "UMask": "0xC000FF04",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : All from Local iA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "PerPkg": "1",
+        "UMask": "0xC000FF01",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : All from Local iA and IO",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0xC000FF05",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just Hits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.HIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MISS",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.DDR",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.DDR4",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : MMCFG Access",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MMCFG",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just Local Targets",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOCAL_TGT",
+        "PerPkg": "1",
+        "UMaskExt": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Match the Opcode in b[29:19] of=
 the extended umask field",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MATCH_OPC",
+        "PerPkg": "1",
+        "UMaskExt": "0x200",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Match the PreMorphed Opcode in =
b[29:19] of the extended umask field",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PREMORPH_OPC",
+        "PerPkg": "1",
+        "UMaskExt": "0x400",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just NearMem",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.NEARMEM",
+        "PerPkg": "1",
+        "UMaskExt": "0x400000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just NotNearMem",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.NOT_NEARMEM",
+        "PerPkg": "1",
+        "UMaskExt": "0x800000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just NonCoherent",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.NONCOH",
+        "PerPkg": "1",
+        "UMaskExt": "0x1000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : Just ISOC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ISOC",
+        "PerPkg": "1",
+        "UMaskExt": "0x2000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : IRQ - iA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_IA",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : SF/LLC Evictions",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : PRQ - IOSF",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : IRQ - Non iA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ_NON_IA",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : PRQ - Non IOSF",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ_NON_IOSF",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : All from Local IO",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "PerPkg": "1",
+        "UMask": "0xC000FF04",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : All from Local iA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "PerPkg": "1",
+        "UMask": "0xC000FF01",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : All from Local iA and IO",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0xC000FF05",
+        "UMaskExt": "0xC000FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just Hits",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.HIT",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just Misses",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MISS",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : MMCFG Access",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MMCFG",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just Local Targets",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOCAL_TGT",
+        "PerPkg": "1",
+        "UMaskExt": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Match the Opcode in b[29:19] =
of the extended umask field",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MATCH_OPC",
+        "PerPkg": "1",
+        "UMaskExt": "0x200",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Match the PreMorphed Opcode i=
n b[29:19] of the extended umask field",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PREMORPH_OPC",
+        "PerPkg": "1",
+        "UMaskExt": "0x400",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just NearMem",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.NEARMEM",
+        "PerPkg": "1",
+        "UMaskExt": "0x400000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just NotNearMem",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.NOT_NEARMEM",
+        "PerPkg": "1",
+        "UMaskExt": "0x800000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just NonCoherent",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.NONCOH",
+        "PerPkg": "1",
+        "UMaskExt": "0x1000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : Just ISOC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ISOC",
+        "PerPkg": "1",
+        "UMaskExt": "0x2000000",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_CHA_AG1_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Vertical",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.VERT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Horizontal",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Local",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Remote",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_NONLOCAL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled - IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_STALL_IV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled -  No =
Credit",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_STALL_NOCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBA",
+        "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBA",
+        "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_CHA_HORZ_RING_AKC_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_CHA_HORZ_RING_AKC_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_CHA_HORZ_RING_AKC_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_CHA_HORZ_RING_AKC_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Left",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB9",
+        "EventName": "UNC_CHA_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Right",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB9",
+        "EventName": "UNC_CHA_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE6",
+        "EventName": "UNC_CHA_MISC_EXTERNAL.MBE_INST0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE6",
+        "EventName": "UNC_CHA_MISC_EXTERNAL.MBE_INST1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Data Responses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : Acknowle=
dgements to Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Acknowledg=
ements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Data Respo=
nses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Snoops of =
processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_CHA_RxR_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IFV - Credi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AKC - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_CHA_RxR_INSERTS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AKC - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_CHA_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AKC - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Credited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Credited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AKC - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AKC - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AKC - Uncre=
dited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : IV - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.IV_AG1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS_1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS_1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : IV=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_VERT_NACK1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_VERT_NACK1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : IV=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED1.TGC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_VERT_RING_AKC_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_VERT_RING_AKC_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_VERT_RING_AKC_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_VERT_RING_AKC_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use : Up",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_VERT_RING_IV_IN_USE.UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use : Down",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_VERT_RING_IV_IN_USE.DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_CHA_VERT_RING_TGC_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_CHA_VERT_RING_TGC_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_CHA_VERT_RING_TGC_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_CHA_VERT_RING_TGC_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xae",
+        "EventName": "UNC_CHA_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe4",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED_1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Any Request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1FFFFF",
+        "UMaskExt": "0x1FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.DATA_READ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "PerPkg": "1",
+        "UMask": "0x1bc1ff",
+        "UMaskExt": "0x1bc1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Flush or Invalidate Requests",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.FLUSH_INV",
+        "PerPkg": "1",
+        "UMask": "0x1A44FF",
+        "UMaskExt": "0x1A44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.CODE_READ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
+        "PerPkg": "1",
+        "UMask": "0x1bd0ff",
+        "UMaskExt": "0x1bd0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC88FFD01",
+        "UMaskExt": "0xC88FFD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores =
that Hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC887FD01",
+        "UMaskExt": "0xC887FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores =
that Missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC88FFE01",
+        "UMaskExt": "0xC88FFE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA Co=
res that missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC8A7FE01",
+        "UMaskExt": "0xC8A7FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores =
that Missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC887FE01",
+        "UMaskExt": "0xC887FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : RFOs issued by IO Devices that =
hit the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC803FD04",
+        "UMaskExt": "0xC803FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMs issued by IO Devices th=
at Hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "UMask": "0xCC43FD04",
+        "UMaskExt": "0xCC43FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFOs issued by IO Devices tha=
t hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC803FD04",
+        "UMaskExt": "0xC803FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : RFOs issued by IO Devices",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC803FF04",
+        "UMaskExt": "0xC803FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; CRd Pref from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC88FFF01",
+        "UMaskExt": "0xC88FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFOs issued by IO Devices",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
+        "PerPkg": "1",
+        "UMask": "0xC803FF04",
+        "UMaskExt": "0xC803FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMs issued by IO Devices",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
+        "PerPkg": "1",
+        "UMask": "0xCC43FF04",
+        "UMaskExt": "0xCC43FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC887FF01",
+        "UMaskExt": "0xC887FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; CRd Pref from local IA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "PerPkg": "1",
+        "UMask": "0xC88FFF01",
+        "UMaskExt": "0xC88FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : CLFlushOpts issued by iA Cores",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "UMask": "0xC8D7FF01",
+        "UMaskExt": "0xC8D7FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0xCC23FF04",
+        "UMaskExt": "0xCC23FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : CLFlushes issued by IO Devices",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0xC8C3FF04",
+        "UMaskExt": "0xC8C3FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WbMtoIs issued by an iA Cores. =
Modified Write Backs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0xcc27ff01",
+        "UMaskExt": "0xcc27ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; WCiLF misses from local IA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_FULL_STREAMING_WR",
+        "PerPkg": "1",
+        "UMask": "0xc867fe01",
+        "UMaskExt": "0xc867fe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; WCiL misses from local IA",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_PARTIAL_STREAMING_WR",
+        "PerPkg": "1",
+        "UMask": "0xc86ffe01",
+        "UMaskExt": "0xc86ffe",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : RFO Request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Transactions homed locally Fi=
lter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x800",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : All Request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ANY_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Data Read Request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Write Request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.OTHER_REQ_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Flush or Invalidate Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.FLUSH_OR_INV_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : CRd Request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE_READ_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Local request Filter",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.COREPREF_OR_DMND_LOCAL_F",
+        "PerPkg": "1",
+        "UMaskExt": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : All Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.MISS_ALL",
+        "PerPkg": "1",
+        "UMask": "0x1fe001",
+        "UMaskExt": "0x1fe0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
+        "PerPkg": "1",
+        "UMask": "0x1fc1ff",
+        "UMaskExt": "0x1fc1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Data Read Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x1bc101",
+        "UMaskExt": "0x1bc1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DMND_READ_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x841ff",
+        "UMaskExt": "0x841",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x842ff",
+        "UMaskExt": "0x842",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x888ff",
+        "UMaskExt": "0x888",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
+        "PerPkg": "1",
+        "UMask": "0xC867FF01",
+        "UMaskExt": "0xC867FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
+        "PerPkg": "1",
+        "UMask": "0xC86FFF01",
+        "UMaskExt": "0xC86FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : DDR4 Access",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.DDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DDR4 Access",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.DDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : PCIRdCurs issued by IO Device=
s that hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0xC8F3FD04",
+        "UMaskExt": "0xC8F3FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores that=
 Missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "UMask": "0xC867FE01",
+        "UMaskExt": "0xC867FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores that=
 Missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "UMask": "0xC86FFE01",
+        "UMaskExt": "0xC86FFE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CLFlushes issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0xC8C7FF01",
+        "UMaskExt": "0xC8C7FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CLFlushOpts issued by iA Core=
s",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "UMask": "0xC8D7FF01",
+        "UMaskExt": "0xC8D7FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0xCC27FF01",
+        "UMaskExt": "0xCC27FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : UCRdFs issued by iA Cores tha=
t Missed LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "UMask": "0xC877DE01",
+        "UMaskExt": "0xC877DE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WiLs issued by iA Cores that =
Missed LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
+        "PerPkg": "1",
+        "UMask": "0xC87FDE01",
+        "UMaskExt": "0xC87FDE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WCiLF issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
+        "PerPkg": "1",
+        "UMask": "0xC867FF01",
+        "UMaskExt": "0xC867FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WCiLs issued by iA Cores",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
+        "PerPkg": "1",
+        "UMask": "0xC86FFF01",
+        "UMaskExt": "0xC86FFF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : WbMtoIs issued by IO Devices",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0xCC23FF04",
+        "UMaskExt": "0xCC23FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : CLFlushes issued by IO Device=
s",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0xC8C3FF04",
+        "UMaskExt": "0xC8C3FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "UMask": "0xCD43FF04",
+        "UMaskExt": "0xCD43FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "UMask": "0xCD43FD04",
+        "UMaskExt": "0xCD43FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : ItoMCacheNears, indicating a =
partial write request, from IO Devices that missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "UMask": "0xCD43FE04",
+        "UMaskExt": "0xCD43FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WBEFtoEs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
+        "PerPkg": "1",
+        "UMask": "0xcc3fff01",
+        "UMaskExt": "0xcc3fff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Missed the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FE01",
+        "UMaskExt": "0xC837FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores tha=
t Hit the LLC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FD01",
+        "UMaskExt": "0xC837FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : DRd PTEs issued by iA Cores",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FF01",
+        "UMaskExt": "0xC837FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WBStoIs issued by an IA Core.  =
Non Modified Write Backs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
+        "PerPkg": "1",
+        "UMask": "0xcc67ff01",
+        "UMaskExt": "0xcc67ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WBEFtoIs issued by an IA Core. =
 Non Modified Write Backs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
+        "PerPkg": "1",
+        "UMask": "0xcc37ff01",
+        "UMaskExt": "0xcc37ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : WBMtoEs issued by an IA Core.  =
Non Modified Write Backs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
+        "PerPkg": "1",
+        "UMask": "0xcc2fff01",
+        "UMaskExt": "0xcc2fff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRdPte issued by iA Cores due=
 to a page walk",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FF01",
+        "UMaskExt": "0xC837FF",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRdPte issued by iA Cores due=
 to a page walk that hit the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FD01",
+        "UMaskExt": "0xC837FD",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy : DRdPte issued by iA Cores due=
 to a page walk that missed the LLC",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRDPTE",
+        "PerPkg": "1",
+        "UMask": "0xC837FE01",
+        "UMaskExt": "0xC837FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Code Read Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE_READ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x1BD001",
+        "UMaskExt": "0x1BD0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : RFO Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_MISS",
+        "PerPkg": "1",
+        "UMask": "0x1BC801",
+        "UMaskExt": "0x1BC8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Reads",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ",
+        "PerPkg": "1",
+        "UMask": "0x1BD9FF",
+        "UMaskExt": "0x1BD9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Read Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x1BD901",
+        "UMaskExt": "0x1BD9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Locally HOMed Read Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_MISS_LOC_HOM",
+        "PerPkg": "1",
+        "UMask": "0x0BD901",
+        "UMaskExt": "0x0BD9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Remotely HOMed Read Misses",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_MISS_REM_HOM",
+        "PerPkg": "1",
+        "UMask": "0x13D901",
+        "UMaskExt": "0x13D9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Locally Requested Reads that =
are Locally HOMed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_LOCAL_LOC_HOM",
+        "PerPkg": "1",
+        "UMask": "0x09D9FF",
+        "UMaskExt": "0x09D9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Remotely Requested Reads that=
 are Locally HOMed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_REMOTE_LOC_HOM",
+        "PerPkg": "1",
+        "UMask": "0x0A19FF",
+        "UMaskExt": "0x0A19",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Locally Requested Reads that =
are Remotely HOMed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_LOCAL_REM_HOM",
+        "PerPkg": "1",
+        "UMask": "0x11D9FF",
+        "UMaskExt": "0x11D9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Reads that Hit the Snoop Filt=
er",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_SF_HIT",
+        "PerPkg": "1",
+        "UMask": "0x1BD90E",
+        "UMaskExt": "0x1BD9",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Remotely requested Read or Sn=
oop Misses that are Remotely HOMed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.READ_OR_SNOOP_REMOTE_MISS_REM_HOM=
",
+        "PerPkg": "1",
+        "UMask": "0x161901",
+        "UMaskExt": "0x1619",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Filters Requests for those th=
at write info into the cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITES_AND_OTHER",
+        "PerPkg": "1",
+        "UMask": "0x1A42FF",
+        "UMaskExt": "0x1A42",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups : Code Reads",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE_READ",
+        "PerPkg": "1",
+        "UMask": "0x1BD0FF",
+        "UMaskExt": "0x1BD0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB lookups first",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB lookups all",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.ALL_LOOKUPS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Hits to a 4K Page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Hits to a 2M Page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Hits to a 1G Page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOTLB Fills (same as IOTLB miss)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.MISSES",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Context cache lookups",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Context cache hits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PageWalk cache lookup",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWT_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": IOMMU memory access",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Cycles PWT full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.CYC_PWT_FULL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Interrupt Entry cache lookup",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Interrupt Entry cache hit",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_HITS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus a=
nd !(PCIE bus)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : Non-PCIE bus a=
nd PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : !(Non-PCIE bus=
) and PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus : !(Non-PCIE bus=
) and !(PCIE bus)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus an=
d !(PCIE bus)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : Non-PCIE bus an=
d PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : !(Non-PCIE bus)=
 and PCIE bus",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus : !(Non-PCIE bus)=
 and !(PCIE bus)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number requests PCIe makes of the main die : =
Drop request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU.ALL.DROP",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's PCICFG space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reading from=
 Card's IO space",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Atomic requests t=
argeting DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Messages",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : At=
omic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Me=
ssages",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.IOMMU0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x100",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.IOMMU1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x200",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counting disabled",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_IIO_NOTHING",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PWT occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_IIO_PWT_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Symbol Times on Link",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_IIO_SYMBOL_TIMES",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "1",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "2",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART1_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "3",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART2_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "4",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART3_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "5",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART4_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "6",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART5_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "7",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART6_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "8",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_IN.PART7_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "9",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART0_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "13",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART4_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "12",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART3_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "11",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART2_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "10",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART1_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "15",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART6_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "14",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART5_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Free running counter that increments for ever=
y 32 bytes of data sent from the IO agent to the SOC",
+        "Counter": "16",
+        "CounterType": "FREERUN",
+        "EventName": "UNC_IIO_BANDWIDTH_OUT.PART7_FREERUN",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PWC Hit to a 4K page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_4K_HITS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PWC Hit to a 2M page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_2M_HITS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PWC Hit to a 1G page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_1G_HITS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PWT Hit to a 256T page",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_512G_HITS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": PageWalk cache fill",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.PWC_CACHE_FILLS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Global IOTLB invalidation cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_GBL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Domain-selective IOTLB invalidation cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_DOMAIN",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Page-selective IOTLB invalidation cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_PAGE",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Context cache global invalidation cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_CTXT_CACHE_INVAL_GBL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Domain-selective Context cache invalidation=
 cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_CTXT_CACHE_INVAL_DOMAIN",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Device-selective Context cache invalidation=
 cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_CTXT_CACHE_INVAL_DEVICE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : MsgB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Multi=
-cast",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Ubox",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Memor=
y",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Remot=
e P2P",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Local=
 P2P",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Confi=
ned P2P",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num requests sent by PCIe - by target : Abort=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "ITC address map 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_IIO_NUM_TGT_MATCHED_REQ_OF_CPU",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Issuing to IOMMU",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_REQ",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Processing response from IOMMU",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_HIT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Request Ownership",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Issuing final read or write of line",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Writing line",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": ": Passing data to be written",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC5",
+        "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - cacheline complete : Request O=
wnership",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - cacheline complete : Issuing f=
inal read or write of line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - cacheline complete : Writing l=
ine",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - cacheline complete : Passing d=
ata to be written",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CL_CMPL.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Issuing to IOMMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.IOMMU_REQ",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Processing response f=
rom IOMMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.IOMMU_HIT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Request Ownership",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Issuing final read or=
 write of line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Writing line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request complete : Passing data to be wr=
itten",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_CMPL.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - pass complete : Request Owners=
hip",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - pass complete : Issuing final =
read or write of line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - pass complete : Writing line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Request - pass complete : Passing data t=
o be written",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_IIO_REQ_FROM_PCIE_PASS_CMPL.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Issuing to IO=
MMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.IOMMU_REQ",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Processing re=
sponse from IOMMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.IOMMU_HIT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Request Owner=
ship",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Issuing final=
 read or write of line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Writing line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests : Passing data =
to be written",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_IIO_INBOUND_ARB_REQ.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Issui=
ng to IOMMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.IOMMU_REQ",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Proce=
ssing response from IOMMU",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.IOMMU_HIT",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Reque=
st Ownership",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.REQ_OWN",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Issui=
ng final read or write of line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.FINAL_RD_WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Writi=
ng line",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.WR",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Incoming arbitration requests granted : Passi=
ng data to be written",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_IIO_INBOUND_ARB_WON.DATA",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Outbound cacheline requests issued : 64B requ=
ests issued to device",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_IIO_OUTBOUND_CL_REQS_ISSUED.TO_IO",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Outbound TLP (transaction layer packet) reque=
sts issued : To device",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_IIO_OUTBOUND_TLP_REQS_ISSUED.TO_IO",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number requests sent to PCIe from main die : =
From IRP",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_NUM_REQ_FROM_CPU.IRP",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number requests sent to PCIe from main die : =
From ITC",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_NUM_REQ_FROM_CPU.ITC",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number requests sent to PCIe from main die : =
Completion allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xc2",
+        "EventName": "UNC_IIO_NUM_REQ_FROM_CPU.PREALLOC",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts : All Ports",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "PortMask": "0xFF",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 0-7",
+        "Counter": "2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Snoop Responses : Hit M",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "RFO request issued by the IRP unit to the mes=
h with the intention of writing a partial cacheline",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy : Any Source",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0F",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy : Snoops",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0F",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.IV_Q",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops : CLFlush",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": ": All Inserts Outbound (BL, AK, Snoops)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_I_IRP_ALL.OUTBOUND_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": ": All Inserts Outbound (BL, AK, Snoops)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_I_IRP_ALL.EVICTS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1e",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Re=
ad Transactions as Secondary",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1e",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Wr=
ite Transactions as Secondary",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1e",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of At=
omic Transactions as Secondary",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Transfers =
From Primary to Secondary",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Prefetch Ack Hints =
From Primary to Secondary",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Slow path fwpf didn=
't find prefetch",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.SLOWPATH_FWPF_NO_PRF",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Slow Transfer of I Line=
",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1f",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Slow Transfer of S Line=
",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1f",
+        "EventName": "UNC_I_MISC1.SLOW_S",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Slow Transfer of E Line=
",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1f",
+        "EventName": "UNC_I_MISC1.SLOW_E",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Slow Transfer of M Line=
",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1f",
+        "EventName": "UNC_I_MISC1.SLOW_M",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Received Invalid",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Received Valid",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : P2P reads",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.RD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : P2P Writes",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.WR",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : P2P Message",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.MSG",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : P2P completions",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.CMPL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : Match if remote only",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.REM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : match if remote and target=
 matches",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.REM_AND_TGT_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : match if local only",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.LOC",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions : match if local and target =
matches",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.LOC_AND_TGT_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : Miss",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : Hit I",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : Hit E or S",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : SnpCode",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : SnpData",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses : SnpInv",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count : Writes",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count : Atomic",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count : Other",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count : Select Source",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Requests",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_P2P_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Occupancy",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_P2P_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0B",
+        "EventName": "UNC_I_TxC_AK_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Cycles Full",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x05",
+        "EventName": "UNC_I_TxC_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Inserts",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_I_TxC_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Occupancy",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x08",
+        "EventName": "UNC_I_TxC_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Cycles Full",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x06",
+        "EventName": "UNC_I_TxC_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Inserts",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_I_TxC_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Occupancy",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x09",
+        "EventName": "UNC_I_TxC_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Cycles Full",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x07",
+        "EventName": "UNC_I_TxC_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Inserts",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_I_TxC_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Occupancy",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0A",
+        "EventName": "UNC_I_TxC_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD0 Egress Credits Stalls",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1A",
+        "EventName": "UNC_I_TxR2_AD0_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD1 Egress Credits Stalls",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1B",
+        "EventName": "UNC_I_TxR2_AD1_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_TxR2_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0D",
+        "EventName": "UNC_I_TxS_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0E",
+        "EventName": "UNC_I_TxS_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0C",
+        "EventName": "UNC_I_TxS_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that miss the=
 IIO cache",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit M, E=
, S or I line in the IIO",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT",
+        "PerPkg": "1",
+        "UMask": "0x7e",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit E or=
 S line in the IIO cache",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit I li=
ne in the IIO cache",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass : Not Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x22",
+        "EventName": "UNC_M2M_BYPASS_M2M_EGRESS.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles when direct to core mode, which bypass=
es the CHA, was disabled",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads in which direct to core trans=
action was overridden",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : All, regardless of =
priority. - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x0704",
+        "UMaskExt": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Normal Priority - A=
ll Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x0701",
+        "UMaskExt": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : All Writes - All C=
hannels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1C10",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Full Line Non-ISOC=
H - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x1C01",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Partial Non-ISOCH =
- All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x1C02",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2M_RxC_AD_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x05",
+        "EventName": "UNC_M2M_RxC_BL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x06",
+        "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x09",
+        "EventName": "UNC_M2M_TxC_AD_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0A",
+        "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass : Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x22",
+        "EventName": "UNC_M2M_BYPASS_M2M_EGRESS.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass : Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_BYPASS_M2M_INGRESS.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass : Not Taken",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_BYPASS_M2M_INGRESS.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Normal Priority - C=
h0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH0_NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x0101",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Critical Priority -=
 Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH0_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0102",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : All, regardless of =
priority. - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH0_ALL",
+        "PerPkg": "1",
+        "UMask": "0x0104",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : From TGR - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH0_FROM_TGR",
+        "PerPkg": "1",
+        "UMask": "0x0140",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Normal Priority - C=
h1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH1_NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x0201",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Critical Priority -=
 Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH1_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0202",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : All, regardless of =
priority. - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH1_ALL",
+        "PerPkg": "1",
+        "UMask": "0x0204",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : From TGR - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.CH1_FROM_TGR",
+        "PerPkg": "1",
+        "UMask": "0x0240",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Full Line Non-ISOC=
H - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_FULL",
+        "PerPkg": "1",
+        "UMask": "0x0401",
+        "UMaskExt": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Partial Non-ISOCH =
- Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x0402",
+        "UMaskExt": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Full Line - =
Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_FULL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0404",
+        "UMaskExt": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Partial - Ch=
0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0408",
+        "UMaskExt": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : All Writes - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_ALL",
+        "PerPkg": "1",
+        "UMask": "0x0410",
+        "UMaskExt": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : From TGR - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_FROM_TGR",
+        "PerPkg": "1",
+        "UMaskExt": "0x05",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Full Line Non-ISOC=
H - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_FULL",
+        "PerPkg": "1",
+        "UMask": "0x0801",
+        "UMaskExt": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Partial Non-ISOCH =
- Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x0802",
+        "UMaskExt": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Full Line - =
Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_FULL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0804",
+        "UMaskExt": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Partial - Ch=
1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0808",
+        "UMaskExt": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : All Writes - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_ALL",
+        "PerPkg": "1",
+        "UMask": "0x0810",
+        "UMaskExt": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : From TGR - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_FROM_TGR",
+        "PerPkg": "1",
+        "UMaskExt": "0x09",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number Packet Header Matches : Mesh Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M2M_PKT_MATCH.MESH",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number Packet Header Matches : MC Match",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M2M_PKT_MATCH.MC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Regular : C=
hannel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_M2M_RPQ_NO_REG_CRD.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Regular : C=
hannel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x43",
+        "EventName": "UNC_M2M_RPQ_NO_REG_CRD.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Special : C=
hannel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_NO_SPEC_CRD.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Special : C=
hannel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_NO_SPEC_CRD.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2M_TRACKER_FULL.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2M_TRACKER_FULL.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x49",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x49",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2M_TRACKER_NE.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2M_TRACKER_NE.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound Ring Transactions on AK : NDR Transa=
ctions",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_M2M_TxC_AK.NDR",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound Ring Transactions on AK : CRD Transa=
ctions to Cbo",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x39",
+        "EventName": "UNC_M2M_TxC_AK.CRD_CBO",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credit Acquired : Common M=
esh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M2M_TxC_AK_CREDITS_ACQUIRED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credit Acquired : Common M=
esh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M2M_TxC_AK_CREDITS_ACQUIRED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full : Common Mesh Stop - =
Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full : Common Mesh Stop - =
Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.RDCRD0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCRD0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCMP0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.RDCRD1",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCRD1",
+        "PerPkg": "1",
+        "UMask": "0x90",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCMP1",
+        "PerPkg": "1",
+        "UMask": "0xA0",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty : Common Mesh St=
op - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty : Common Mesh St=
op - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations : Common Mesh =
Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations : Common Mesh =
Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.PREF_RD_CAM_HIT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AK Egress (to CMS) Credits : C=
ommon Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_CYCLES.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AK Egress (to CMS) Credits : C=
ommon Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_CYCLES.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AK Egress (to CMS) Cre=
dits : Common Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_STALLED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AK Egress (to CMS) Cre=
dits : Common Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_STALLED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy : Common Mesh St=
op - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy : Common Mesh St=
op - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache : Dat=
a to Cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2M_TxC_BL.DRS_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache : Dat=
a to Core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2M_TxC_BL.DRS_CORE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credit Acquired : Common M=
esh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2M_TxC_BL_CREDITS_ACQUIRED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credit Acquired : Common M=
esh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2M_TxC_BL_CREDITS_ACQUIRED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full : Common Mesh Stop - =
Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full : Common Mesh Stop - =
Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty : Common Mesh St=
op - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty : Common Mesh St=
op - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations : Common Mesh =
Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations : Common Mesh =
Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No BL Egress (to CMS) Credits : C=
ommon Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1B",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_CYCLES.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No BL Egress (to CMS) Credits : C=
ommon Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1B",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_CYCLES.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No BL Egress (to CMS) Cre=
dits : Common Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_STALLED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No BL Egress (to CMS) Cre=
dits : Common Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_STALLED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "WPQ Flush : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_WPQ_FLUSH.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "WPQ Flush : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x58",
+        "EventName": "UNC_M2M_WPQ_FLUSH.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Regular : =
Channel 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_NO_REG_CRD.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M-&gt;iMC WPQ Cycles w/Credits - Special : =
Channel 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_NO_SPEC_CRD.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WR_TRACKER_FULL.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WR_TRACKER_FULL.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full : Mirror",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WR_TRACKER_FULL.MIRR",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_WR_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_WR_TRACKER_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WR_TRACKER_NE.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WR_TRACKER_NE.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty : Mirror",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x63",
+        "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Non-Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x63",
+        "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x62",
+        "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Non-Posted Occupancy : Channel =
1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x62",
+        "EventName": "UNC_M2M_WR_TRACKER_NONPOSTED_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_WR_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_WR_TRACKER_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy : Mirror",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_WR_TRACKER_OCCUPANCY.MIRR",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Posted Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M2M_WR_TRACKER_POSTED_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Posted Inserts : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M2M_WR_TRACKER_POSTED_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Posted Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M2M_WR_TRACKER_POSTED_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Posted Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M2M_WR_TRACKER_POSTED_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Non-Inclusive Miss=
 - Ch0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH0_NI_MISS",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Non-Inclusive Miss=
 - Ch1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.CH1_NI_MISS",
+        "PerPkg": "1",
+        "UMaskExt": "0x0C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Full : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_FULL.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Full : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_FULL.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Not Empty : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6C",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_NE.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Not Empty : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6C",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_NE.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH0_HITA0_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH0_HITA1_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH0_MISS_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH0_RSP_PDRESET",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH1_HITA0_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH1_HITA1_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH1_MISS_INVAL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Deallocs",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6E",
+        "EventName": "UNC_M2M_PREFCAM_DEALLOCS.CH1_RSP_PDRESET",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped : XPT - Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6F",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH0_XPT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped : XPT - Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6F",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.CH1_XPT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT - =
Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.CH0_XPT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT - =
Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.CH1_XPT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T - Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.CH0_XPT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T - Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.CH1_XPT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.PF_SECURE_DROP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.NOT_PF_SAD_REGION",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.PF_CAM_HIT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.STOP_B2B",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.ERRORBLK_RxC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.PF_AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.PF_CAM_FULL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.WPQ_PROXY",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.RPQ_PROXY",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch0 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x70",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH0.XPT_THRESH",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.PF_SECURE_DROP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.NOT_PF_SAD_REGION",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.PF_CAM_HIT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.STOP_B2B",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.ERRORBLK_RxC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.PF_AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.PF_CAM_FULL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.WPQ_PROXY",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.RPQ_PROXY",
+        "PerPkg": "1",
+        "UMaskExt": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped Ch1 - Reasons",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x71",
+        "EventName": "UNC_M2M_PREFCAM_DROP_REASONS_CH1.XPT_THRESH",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS.CH0_XPT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS.CH1_XPT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6A",
+        "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6A",
+        "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": ": Channel 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x76",
+        "EventName": "UNC_M2M_PREFCAM_RESP_MISS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": ": Channel 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x76",
+        "EventName": "UNC_M2M_PREFCAM_RESP_MISS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR_NONTGR",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WR_TRACKER_NE.MIRR_PWR",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_WR_TRACKER_OCCUPANCY.MIRR_NONTGR",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_WR_TRACKER_OCCUPANCY.MIRR_PWR",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8B",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8D",
+        "EventName": "UNC_M2M_AG1_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8F",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Vertical",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.VERT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Horizontal",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Local",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.DPT_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Remote",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.DPT_NONLOCAL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled - IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.DPT_STALL_IV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled -  No =
Credit",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAF",
+        "EventName": "UNC_M2M_DISTRESS_ASSERTED.DPT_STALL_NOCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M2M_HORZ_RING_AKC_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M2M_HORZ_RING_AKC_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M2M_HORZ_RING_AKC_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M2M_HORZ_RING_AKC_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Left",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M2M_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Right",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M2M_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE6",
+        "EventName": "UNC_M2M_MISC_EXTERNAL.MBE_INST0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE6",
+        "EventName": "UNC_M2M_MISC_EXTERNAL.MBE_INST1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Data Responses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : Acknowle=
dgements to Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Acknowledg=
ements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Data Respo=
nses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Snoops of =
processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE5",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE2",
+        "EventName": "UNC_M2M_RxR_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IFV - Credi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AKC - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE1",
+        "EventName": "UNC_M2M_RxR_INSERTS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AKC - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD1",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD5",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xD7",
+        "EventName": "UNC_M2M_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AKC - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Credited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Credited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AKC - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AKC - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AKC - Uncre=
dited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : IV - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.IV_AG1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS_1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS_1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : IV=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_VERT_NACK1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_VERT_NACK1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : IV - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : IV=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED0.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED1.AKC_AG1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED1.TGC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_VERT_RING_AKC_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_VERT_RING_AKC_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_VERT_RING_AKC_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_VERT_RING_AKC_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use : Up",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_VERT_RING_IV_IN_USE.UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use : Down",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_VERT_RING_IV_IN_USE.DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M2M_VERT_RING_TGC_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M2M_VERT_RING_TGC_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M2M_VERT_RING_TGC_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M2M_VERT_RING_TGC_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x64",
+        "EventName": "UNC_M2M_MIRR_WRQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x65",
+        "EventName": "UNC_M2M_MIRR_WRQ_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xae",
+        "EventName": "UNC_M2M_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_M2M_RxC_AD_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x03",
+        "EventName": "UNC_M2M_RxC_AD_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M2M_RxC_AK_WR_CMP",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x08",
+        "EventName": "UNC_M2M_RxC_BL_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x07",
+        "EventName": "UNC_M2M_RxC_BL_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe4",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED_1",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number AD Ingress Credits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2M_TGR_AD_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number BL Ingress Credits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_M2M_TGR_BL_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Credit Acquired",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0d",
+        "EventName": "UNC_M2M_TxC_AD_CREDITS_ACQUIRED",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Credits Occupancy",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0e",
+        "EventName": "UNC_M2M_TxC_AD_CREDIT_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0c",
+        "EventName": "UNC_M2M_TxC_AD_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0b",
+        "EventName": "UNC_M2M_TxC_AD_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AD Egress (to CMS) Credits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0f",
+        "EventName": "UNC_M2M_TxC_AD_NO_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AD Egress (to CMS) Cre=
dits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2M_TxC_AD_NO_CREDIT_STALLED",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AKC Credits",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M2M_TxC_AKC_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : Critical Priority -=
 All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x0702",
+        "UMaskExt": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC : From TGR - All Chan=
nels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.FROM_TGR",
+        "PerPkg": "1",
+        "UMask": "0x0740",
+        "UMaskExt": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Full Line - =
All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FULL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x1C04",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : ISOCH Partial - Al=
l Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x1C08",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : From TGR - All Cha=
nnels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FROM_TGR",
+        "PerPkg": "1",
+        "UMaskExt": "0x1D",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC : Non-Inclusive Miss=
 - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.NI_MISS",
+        "PerPkg": "1",
+        "UMaskExt": "0x1C",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Full : All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6B",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_FULL.ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Not Empty : All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6C",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_NE.ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Prefetches Dropped : XPT - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6f",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_DROPS.XPT_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.XPT_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6A",
+        "EventName": "UNC_M2M_PREFCAM_OCCUPANCY.ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": ": All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x76",
+        "EventName": "UNC_M2M_PREFCAM_RESP_MISS.ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x07",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT - =
All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.XPT_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x6D",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS.XPT_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Occupancy - Prefetches",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x77",
+        "EventName": "UNC_M2M_RxC_AD_PREF_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT & =
UPI- Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.CH0_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T & UPI - All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.XPTUPI_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T & UPI - Ch 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.CH2_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T & UPI - Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.CH1_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Not Merged with CAMed Prefetches : XP=
T & UPI - Ch 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_NO_MERGE.CH0_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT & =
UPI- All Channels",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.XPTUPI_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT & =
UPI- Ch 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.CH2_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Demands Merged with CAMed Prefetches : XPT & =
UPI - Ch 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_MERGE.CH1_XPTUPI",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : DRS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.DRS_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : DRS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.DRS_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCB_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCB_1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCS_0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credit Acquired : NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x33",
+        "EventName": "UNC_M2P_IIO_CREDITS_ACQUIRED.NCS_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : DRS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_M2P_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_M2P_IIO_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Failed to Acquire a Credit : NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x34",
+        "EventName": "UNC_M2P_IIO_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : DRS to CMS Port 0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.DRS_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : DRS to CMS Port 1=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.DRS_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : NCB to CMS Port 0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.NCB_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : NCB to CMS Port 1=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.NCB_1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : NCS to CMS Port 0=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.NCS_0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "M2PCIe IIO Credits in Use : NCS to CMS Port 1=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x32",
+        "EventName": "UNC_M2P_IIO_CREDITS_USED.NCS_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.IIO_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.IIO_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.IIO_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.IIO_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Full",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2P_TxC_CYCLES_FULL.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.AK_0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.AK_1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Cycles Not Empty",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2P_TxC_CYCLES_NE.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.AD_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.BL_0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.AK_CRD_0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.AD_1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.BL_1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress (to CMS) Ingress",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2P_TxC_INSERTS.AK_CRD_1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
0 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
0 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
1 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
1 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
2 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
2 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF2_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
3 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF3_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 0 : M2IOSF=
3 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_0.M2IOSF3_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
4 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF4_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
4 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF4_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
5 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF5_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Dedicated P2P Credit Taken - 1 : M2IOSF=
5 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2P_LOCAL_DED_P2P_CRD_TAKEN_1.M2IOSF5_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF0 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF0 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF1 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF1 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF2 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF2 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF2_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF3 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF3_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 0 : M2=
IOSF3 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_0.MS2IOSF3_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF4 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF4_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF4 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF4_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF5 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF5_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Dedicated Credits Returned - 1 : M2=
IOSF5 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M2P_LOCAL_P2P_DED_RETURNED_1.MS2IOSF5_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Shared Credits Returned : Agent0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Shared Credits Returned : Agent1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local P2P Shared Credits Returned : Agent2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2P_LOCAL_P2P_SHAR_RETURNED.AGENT_2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Returned to credit ri=
ng : Agent5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_RETURNED.AGENT_5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF0 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF0 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF1 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF1 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF2 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF2 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF2_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF3 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF3_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 0 : M2IOSF3 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_0.M2IOSF3_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF4 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF4_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF4 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF4_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF5 -=
 NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF5_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Local Shared P2P Credit Taken - 1 : M2IOSF5 -=
 NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_TAKEN_1.M2IOSF5_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF0 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF0 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF1 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF1 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF2 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF2 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF2_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF3 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF3_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 0 : M2IO=
SF3 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_0.M2IOSF3_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF4 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4b",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF4_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF4 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4b",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF4_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF5 - NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4b",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF5_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Waiting on Local Shared P2P Credit - 1 : M2IO=
SF5 - NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4b",
+        "EventName": "UNC_M2P_LOCAL_SHAR_P2P_CRD_WAIT_1.M2IOSF5_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "P2P Credit Occupancy : Local NCB",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.LOCAL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "P2P Credit Occupancy : Local NCS",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.LOCAL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "P2P Credit Occupancy : Remote NCB",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.REMOTE_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "P2P Credit Occupancy : Remote NCS",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.REMOTE_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "P2P Credit Occupancy : All",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2P_P2P_CRD_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Dedicated Credits Received : Local NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2P_P2P_DED_RECEIVED.LOCAL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Dedicated Credits Received : Local NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2P_P2P_DED_RECEIVED.LOCAL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Dedicated Credits Received : Remote NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2P_P2P_DED_RECEIVED.REMOTE_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Dedicated Credits Received : Remote NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2P_P2P_DED_RECEIVED.REMOTE_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Dedicated Credits Received : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2P_P2P_DED_RECEIVED.ALL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Shared Credits  Received : Local NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.LOCAL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Shared Credits  Received : Local NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.LOCAL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Shared Credits  Received : Remote NCB",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.REMOTE_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Shared Credits  Received : Remote NCS",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.REMOTE_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Shared Credits  Received : All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2P_P2P_SHAR_RECEIVED.ALL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote P2P Shared Credits Returned : Agent0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote P2P Shared Credits Returned : Agent1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote P2P Shared Credits Returned : Agent2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2P_REMOTE_P2P_SHAR_RETURNED.AGENT_2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Remote Shared P2P Credit Returned to credit r=
ing : Agent2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2P_REMOTE_SHAR_P2P_CRD_RETURNED.AGENT_2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_IDI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_NCB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2P_RxC_CYCLES_NE.CHA_NCS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.CHA_IDI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.CHA_NCB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2P_RxC_INSERTS.CHA_NCS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x81",
+        "EventName": "UNC_M2P_AG0_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_M2P_AG0_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x89",
+        "EventName": "UNC_M2P_AG0_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8a",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M2P_AG0_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x85",
+        "EventName": "UNC_M2P_AG1_AD_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x87",
+        "EventName": "UNC_M2P_AG1_AD_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired : For Transgre=
ss 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M2P_AG1_BL_CRD_ACQUIRED1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8f",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8f",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy : For Transgr=
ess 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x8f",
+        "EventName": "UNC_M2P_AG1_BL_CRD_OCCUPANCY1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Vertical",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.VERT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : Horizontal",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Local",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.DPT_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Remote",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.DPT_NONLOCAL",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled - IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.DPT_STALL_IV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Distress signal asserted : DPT Stalled -  No =
Credit",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaf",
+        "EventName": "UNC_M2P_DISTRESS_ASSERTED.DPT_STALL_NOCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Up",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xba",
+        "EventName": "UNC_M2P_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements =
: Down",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xba",
+        "EventName": "UNC_M2P_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb6",
+        "EventName": "UNC_M2P_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb6",
+        "EventName": "UNC_M2P_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb6",
+        "EventName": "UNC_M2P_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb6",
+        "EventName": "UNC_M2P_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xbb",
+        "EventName": "UNC_M2P_HORZ_RING_AKC_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xbb",
+        "EventName": "UNC_M2P_HORZ_RING_AKC_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xbb",
+        "EventName": "UNC_M2P_HORZ_RING_AKC_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xbb",
+        "EventName": "UNC_M2P_HORZ_RING_AKC_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb7",
+        "EventName": "UNC_M2P_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb7",
+        "EventName": "UNC_M2P_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb7",
+        "EventName": "UNC_M2P_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb7",
+        "EventName": "UNC_M2P_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M2P_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Left and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M2P_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Even",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M2P_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use : Right and Odd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M2P_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Left",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb9",
+        "EventName": "UNC_M2P_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use : Right",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xb9",
+        "EventName": "UNC_M2P_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe6",
+        "EventName": "UNC_M2P_MISC_EXTERNAL.MBE_INST0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Miscellaneous Events (mostly from MS2IDI) : N=
umber of cycles MBE is high for MS2IDI1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe6",
+        "EventName": "UNC_M2P_MISC_EXTERNAL.MBE_INST1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xac",
+        "EventName": "UNC_M2P_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xac",
+        "EventName": "UNC_M2P_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xac",
+        "EventName": "UNC_M2P_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
 : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xac",
+        "EventName": "UNC_M2P_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaa",
+        "EventName": "UNC_M2P_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaa",
+        "EventName": "UNC_M2P_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Data Responses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaa",
+        "EventName": "UNC_M2P_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring. :=
 Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaa",
+        "EventName": "UNC_M2P_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xaa",
+        "EventName": "UNC_M2P_RING_BOUNCES_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xad",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xad",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : BL",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xad",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xad",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring : Acknowle=
dgements to Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xad",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : AD",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xab",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Acknowledg=
ements to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xab",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Data Respo=
nses to core",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xab",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring : Snoops of =
processor's cache",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xab",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xab",
+        "EventName": "UNC_M2P_RING_SINK_STARVED_VERT.AKC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe5",
+        "EventName": "UNC_M2P_RxR_BUSY_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe2",
+        "EventName": "UNC_M2P_RxR_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : IFV - Credi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe3",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Uncredi=
ted",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - Credite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AKC - Uncred=
ited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe1",
+        "EventName": "UNC_M2P_RxR_INSERTS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Uncredite=
d",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AKC - Uncredit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xe0",
+        "EventName": "UNC_M2P_RxR_OCCUPANCY.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd0",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd2",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_AD_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd4",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG0.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 2",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 4",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 5",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd6",
+        "EventName": "UNC_M2P_STALL0_NO_TxR_HORZ_CRD_BL_AG1.TGR7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd1",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd1",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd1",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG0.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd3",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd3",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd3",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_AD_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd5",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG0_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 8",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd7",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR8",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 9",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd7",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR9",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits : Fo=
r Transgress 10",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xd7",
+        "EventName": "UNC_M2P_STALL1_NO_TxR_HORZ_CRD_BL_AG1_1.TGR10",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa6",
+        "EventName": "UNC_M2P_TxR_HORZ_ADS_USED.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AKC - Uncredited=
",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used : BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa7",
+        "EventName": "UNC_M2P_TxR_HORZ_BYPASS.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AK",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.BL_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
IV",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - Credited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AKC - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.AKC_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
AD - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.AD_ALL",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full : =
BL - All",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa2",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_FULL.BL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.AD_UNCRD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AK",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.AK",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores that =
Missed the LLC : Counts the number of entries successfuly inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
-        "UMask": "0xC867FE01",
-        "UMaskExt": "0xC867FE",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : WiLs issued by iA Cores that Mi=
ssed LLC",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Uncredited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.BL_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : WiLs issued by iA Cores that M=
issed LLC : Counts the number of entries successfuly inserted into the TOR =
that match qualifications specified by the subevent.   Does not include add=
ressless requests such as locks and interrupts.",
-        "UMask": "0xC87FDE01",
-        "UMaskExt": "0xC87FDE",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : IV",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.IV",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores : Coun=
ts the number of entries successfuly inserted into the TOR that match quali=
fications specified by the subevent.   Does not include addressless request=
s such as locks and interrupts.",
-        "UMask": "0xC807FF01",
-        "UMaskExt": "0xC807FF",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : RFO_Prefs issued by iA Cores",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - Credited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores :=
 Counts the number of entries successfuly inserted into the TOR that match =
qualifications specified by the subevent.   Does not include addressless re=
quests such as locks and interrupts.",
-        "UMask": "0xC887FF01",
-        "UMaskExt": "0xC887FF",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : All requests from IO Devices",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - Credited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from IO Devices :=
 Counts the number of entries successfuly inserted into the TOR that match =
qualifications specified by the subevent.   Does not include addressless re=
quests such as locks and interrupts.",
-        "UMask": "0xC001FF04",
-        "UMaskExt": "0xC001FF",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : All requests from IO Devices th=
at hit the LLC",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AKC - Uncredited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.AKC_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat hit the LLC : Counts the number of entries successfuly inserted into th=
e TOR that match qualifications specified by the subevent.   Does not inclu=
de addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FD04",
-        "UMaskExt": "0xC001FD",
-        "Unit": "CHA"
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices that=
 Hit the LLC",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : AD - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.AD_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC : Counts the number of entries successfuly inserted into the =
TOR that match qualifications specified by the subevent.   Does not include=
 addressless requests such as locks and interrupts.",
-        "UMask": "0xCC43FD04",
-        "UMaskExt": "0xCC43FD",
-        "Unit": "CHA"
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that hit the LLC",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty : BL - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
+        "EventCode": "0xa3",
+        "EventName": "UNC_M2P_TxR_HORZ_CYCLES_NE.BL_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that hit the LLC : Counts the number =
of entries successfuly inserted into the TOR that match qualifications spec=
ified by the subevent.   Does not include addressless requests such as lock=
s and interrupts.",
-        "UMask": "0xCD43FD04",
-        "UMaskExt": "0xCD43FD",
-        "Unit": "CHA"
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices =
that hit the LLC",
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Uncredit=
ed",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.AD_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that hit the LLC : Counts the number of entries successfuly inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
-        "UMask": "0xC8F3FD04",
-        "UMaskExt": "0xC8F3FD",
-        "Unit": "CHA"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices",
+        "BriefDescription": "CMS Horizontal Egress Inserts : AK",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.AK",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices : C=
ounts the number of entries successfuly inserted into the TOR that match qu=
alifications specified by the subevent.   Does not include addressless requ=
ests such as locks and interrupts.",
-        "UMask": "0xCC43FF04",
-        "UMaskExt": "0xCC43FF",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices",
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Uncredit=
ed",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.BL_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices : Counts the number of entries succes=
sfuly inserted into the TOR that match qualifications specified by the sube=
vent.   Does not include addressless requests such as locks and interrupts.=
",
-        "UMask": "0xCD43FF04",
-        "UMaskExt": "0xCD43FF",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : All requests from IO Devices th=
at missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Inserts : IV",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.IV",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat missed the LLC : Counts the number of entries successfuly inserted into=
 the TOR that match qualifications specified by the subevent.   Does not in=
clude addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FE04",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMs issued by IO Devices that=
 missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - Credited=
",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC : Counts the number of entries successfuly inserted into t=
he TOR that match qualifications specified by the subevent.   Does not incl=
ude addressless requests such as locks and interrupts.",
-        "UMask": "0xCC43FE04",
-        "UMaskExt": "0xCC43FE",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : ItoMCacheNears, indicating a pa=
rtial write request, from IO Devices that missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - Credited=
",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC : Counts the numb=
er of entries successfuly inserted into the TOR that match qualifications s=
pecified by the subevent.   Does not include addressless requests such as l=
ocks and interrupts.",
-        "UMask": "0xCD43FE04",
-        "UMaskExt": "0xCD43FE",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices =
that missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Inserts : AKC - Uncredi=
ted",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.AKC_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that missed the LLC : Counts the number of entries successfuly inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
-        "UMask": "0xC8F3FE04",
-        "UMaskExt": "0xC8F3FE",
-        "Unit": "CHA"
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Inserts : PCIRdCurs issued by IO Devices",
+        "BriefDescription": "CMS Horizontal Egress Inserts : AD - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.AD_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 : Counts the number of entries successfuly inserted into the TOR that matc=
h qualifications specified by the subevent.   Does not include addressless =
requests such as locks and interrupts.",
-        "UMask": "0xC8F3FF04",
-        "UMaskExt": "0xC8F3FF",
-        "Unit": "CHA"
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from iA Cores",
+        "BriefDescription": "CMS Horizontal Egress Inserts : BL - All",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M2P_TxR_HORZ_INSERTS.BL_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from iA Cores :=
 For each cycle, this event accumulates the number of valid entries in the =
TOR that match qualifications specified by the subevent.     Does not inclu=
de addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FF01",
-        "UMaskExt": "0xC001FF",
-        "Unit": "CHA"
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRDs issued by iA Cores",
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Uncredited=
",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.AD_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : CRDs issued by iA Cores : Fo=
r each cycle, this event accumulates the number of valid entries in the TOR=
 that match qualifications specified by the subevent.     Does not include =
addressless requests such as locks and interrupts.",
-        "UMask": "0xC80FFF01",
-        "UMaskExt": "0xC80FFF",
-        "Unit": "CHA"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Opts issued by iA Cores",
+        "BriefDescription": "CMS Horizontal Egress NACKs : AK",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.AK",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
: For each cycle, this event accumulates the number of valid entries in the=
 TOR that match qualifications specified by the subevent.     Does not incl=
ude addressless requests such as locks and interrupts.",
-        "UMask": "0xC827FF01",
-        "UMaskExt": "0xC827FF",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA Co=
res",
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Uncredited=
",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.BL_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores : For each cycle, this event accumulates the number of valid entries i=
n the TOR that match qualifications specified by the subevent.     Does not=
 include addressless requests such as locks and interrupts.",
-        "UMask": "0xC8A7FF01",
-        "UMaskExt": "0xC8A7FF",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from iA Cores th=
at Hit the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : IV",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.IV",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FD01",
-        "UMaskExt": "0xC001FD",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Opts issued by iA Cores t=
hat hit the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - Credited",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC : For each cycle, this event accumulates the number of val=
id entries in the TOR that match qualifications specified by the subevent. =
    Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC827FD01",
-        "UMaskExt": "0xC827FD",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA Co=
res that hit the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - Credited",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that hit the LLC : For each cycle, this event accumulates the number o=
f valid entries in the TOR that match qualifications specified by the subev=
ent.     Does not include addressless requests such as locks and interrupts=
.",
-        "UMask": "0xC8A7FD01",
-        "UMaskExt": "0xC8A7FD",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from iA Cores th=
at Missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : AKC - Uncredite=
d",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.AKC_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FE01",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : CRds issued by iA Cores that =
Missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : AD - All",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.AD_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC80FFE01",
-        "UMaskExt": "0xC80FFE",
-        "Unit": "CHA"
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : DRd_Opt issued by iA Cores th=
at missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress NACKs : BL - All",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "EventCode": "0xa4",
+        "EventName": "UNC_M2P_TxR_HORZ_NACK.BL_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC : For each cycle, this event accumulates the number of v=
alid entries in the TOR that match qualifications specified by the subevent=
.     Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC827FE01",
-        "UMaskExt": "0xC827FE",
-        "Unit": "CHA"
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : RFOs issued by iA Cores that =
Missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Uncred=
ited",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.AD_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC : For each cycle, this event accumulates the number of vali=
d entries in the TOR that match qualifications specified by the subevent.  =
   Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC807FE01",
-        "UMaskExt": "0xC807FE",
-        "Unit": "CHA"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : RFOs issued by iA Cores",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AK",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.AK",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores : Fo=
r each cycle, this event accumulates the number of valid entries in the TOR=
 that match qualifications specified by the subevent.     Does not include =
addressless requests such as locks and interrupts.",
-        "UMask": "0xC807FF01",
-        "UMaskExt": "0xC807FF",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from IO Devices",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Uncred=
ited",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.BL_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 : For each cycle, this event accumulates the number of valid entries in th=
e TOR that match qualifications specified by the subevent.     Does not inc=
lude addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FF04",
-        "UMaskExt": "0xC001FF",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from IO Devices =
that hit the LLC",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : IV",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.IV",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC : For each cycle, this event accumulates the number of va=
lid entries in the TOR that match qualifications specified by the subevent.=
     Does not include addressless requests such as locks and interrupts.",
-        "UMask": "0xC001FD04",
-        "UMaskExt": "0xC001FD",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - Credit=
ed",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : All requests from IO Devices =
that missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - Credit=
ed",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC : For each cycle, this event accumulates the number of=
 valid entries in the TOR that match qualifications specified by the subeve=
nt.     Does not include addressless requests such as locks and interrupts.=
",
-        "UMask": "0xC001FE04",
-        "UMaskExt": "0xC001FE",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : PCIRdCurs issued by IO Device=
s that missed the LLC",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AKC - Uncre=
dited",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.AKC_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC : For each cycle, this event accumulates the number =
of valid entries in the TOR that match qualifications specified by the sube=
vent.     Does not include addressless requests such as locks and interrupt=
s.",
-        "UMask": "0xc8f3fe04",
-        "UMaskExt": "0xc8f3fe",
-        "Unit": "CHA"
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "TOR Occupancy : PCIRdCurs issued by IO Device=
s",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : AD - All",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.AD_ALL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es : For each cycle, this event accumulates the number of valid entries in =
the TOR that match qualifications specified by the subevent.     Does not i=
nclude addressless requests such as locks and interrupts.",
-        "UMask": "0xC8F3FF04",
-        "UMaskExt": "0xC8F3FF",
-        "Unit": "CHA"
+        "UMask": "0x11",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Clockticks of the integrated IO (IIO) traffic=
 controller",
+        "BriefDescription": "CMS Horizontal Egress Occupancy : BL - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_IIO_CLOCKTICKS",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M2P_TxR_HORZ_OCCUPANCY.BL_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks of the integrated IO (IIO) traffi=
c controller",
-        "Unit": "IIO"
+        "UMask": "0x44",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Free running counter that increments for IIO =
clocktick",
-        "CounterType": "FREERUN",
-        "EventName": "UNC_IIO_CLOCKTICKS_FREERUN",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - Uncredited",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.AD_UNCRD",
         "PerPkg": "1",
-        "PublicDescription": "Free running counter that increments for int=
egrated IO (IIO) traffic controller clockticks",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0-7",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AK",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.AK",
         "PerPkg": "1",
-        "PortMask": "0xff",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 0-7",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - Uncredited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.BL_UNCRD",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 0",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
IV",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.IV",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 1 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 1",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AKC - Uncredited",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.AKC_UNCRD",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 2",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x80",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
AD - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.AD_ALL",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 3",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 4",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation : =
BL - All",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
-        "FCMask": "0x04",
+        "EventCode": "0xa5",
+        "EventName": "UNC_M2P_TxR_HORZ_STARVED.BL_ALL",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 0 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 4",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 5",
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
-        "FCMask": "0x04",
+        "EventCode": "0x9c",
+        "EventName": "UNC_M2P_TxR_VERT_ADS_USED.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 1 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 5",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 6",
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
-        "FCMask": "0x04",
+        "EventCode": "0x9c",
+        "EventName": "UNC_M2P_TxR_VERT_ADS_USED.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 6",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 7",
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
-        "FCMask": "0x04",
+        "EventCode": "0x9c",
+        "EventName": "UNC_M2P_TxR_VERT_ADS_USED.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data : Part 2 : x16 card plugged in to Lane 0/1/2/3, Or x8 card plug=
ged in to Lane 0/1, Or x4 card is plugged in to slot 7",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 0-7",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
-        "FCMask": "0x04",
+        "EventCode": "0x9c",
+        "EventName": "UNC_M2P_TxR_VERT_ADS_USED.BL_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 0-7",
-        "UMask": "0xff",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 0",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.AD_AG0",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 0 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 0",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 1",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.AK_AG0",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 1 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 1",
         "UMask": "0x02",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 2",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.BL_AG0",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 2 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 2",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 3",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : IV - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.IV_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 3 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 3",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 4",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AD - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.AD_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 4 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 4",
         "UMask": "0x10",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 5",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AK - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.AK_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 5 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 5",
         "UMask": "0x20",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 6",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : BL - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
-        "FCMask": "0x04",
+        "EventCode": "0x9d",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS.BL_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 6 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 6",
         "UMask": "0x40",
-        "Unit": "IIO"
-    },
-    {
-        "BriefDescription": "PCIe Completion Buffer Occupancy of completio=
ns with data : Part 7",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xd5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
-        "FCMask": "0x04",
-        "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer Occupancy : Part 7 : =
x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or =
x4 card is plugged in to slot 7",
-        "UMask": "0x80",
-        "Unit": "IIO"
-    },
-    {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
-        "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
-        "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugge=
d in to Lane 0/1, Or x4 card is plugged in to slot 0",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x9e",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS_1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x4 card is plugged in to slot 1",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "CMS Vertical ADS Used : AKC - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x9e",
+        "EventName": "UNC_M2P_TxR_VERT_BYPASS_1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged =
in to slot 2",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x4 card is plugged in to slot 3",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x16 card plugged in to Lane 4/5/6/7, Or x8 card plugge=
d in to Lane 4/5, Or x4 card is plugged in to slot 4",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x4 card is plugged in to slot 5",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : IV=
 - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x8 card plugged in to Lane 6/7, Or x4 card is plugged =
in to slot 6",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AD=
 - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Data requested by the CPU : Core reporting c=
ompletion of Card read from Core DRAM : Number of DWs (4 bytes) requested b=
y the main die.  Includes all requests initiated by the main die, including=
 reads and writes. : x4 card is plugged in to slot 7",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
 - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or=
 x4 card is plugged in to slot 0",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : BL=
 - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 1",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot 2",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full : AK=
C - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_FULL1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 3",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x16 card plugged in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or=
 x4 card is plugged in to slot 4",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 5",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x8 card plugged in to Lane 6/7, Or x4 card is plugged in to slot 6",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested by the CPU : Core writing to C=
ard's MMIO space",
-        "Counter": "2,3",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : IV - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Data requested by the CPU : Core writing to =
Card's MMIO space : Number of DWs (4 bytes) requested by the main die.  Inc=
ludes all requests initiated by the main die, including reads and writes. :=
 x4 card is plugged in to slot 7",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AD - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugge=
d in to Lane 0/1, Or x4 card is plugged in to slot 0",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AK - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 1",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : BL - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged =
in to slot 2",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 3",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
 : AKC - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2P_TxR_VERT_CYCLES_NE1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x16 card plugged in to Lane 4/5/6/7, Or x8 card plugge=
d in to Lane 4/5, Or x4 card is plugged in to slot 4",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 5",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x8 card plugged in to Lane 6/7, Or x4 card is plugged =
in to slot 6",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Data requested of the CPU : CmpD - device sen=
ding completion to CPU request",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.CMPD.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Data requested of the CPU : CmpD - device se=
nding completion to CPU request : Number of DWs (4 bytes) the card requests=
 of the main die.    Includes all requests initiated by the Card, including=
 reads and writes. : x4 card is plugged in to slot 7",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : IV - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x16 =
card plugged in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 c=
ard is plugged in to slot 4",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : AD - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 5",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : AK - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x8 c=
ard plugged in to Lane 6/7, Or x4 card is plugged in to slot 6",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : BL - Agent 1",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Data requested of the CPU : Card reading fro=
m DRAM : Number of DWs (4 bytes) the card requests of the main die.    Incl=
udes all requests initiated by the Card, including reads and writes. : x4 c=
ard is plugged in to slot 7",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS1.AKC_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations : AKC - Agent 1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2P_TxR_VERT_INSERTS1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x16 ca=
rd plugged in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 car=
d is plugged in to slot 4",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 5",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x8 car=
d plugged in to Lane 6/7, Or x4 card is plugged in to slot 6",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
-        "Counter": "0,1",
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 0",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Data requested of the CPU : Card writing to =
DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includ=
es all requests initiated by the Card, including reads and writes. : x4 car=
d is plugged in to slot 7",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number requests PCIe makes of the main die : =
All",
+        "BriefDescription": "CMS Vertical Egress NACKs : IV",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x85",
-        "EventName": "UNC_IIO_NUM_REQ_OF_CPU.COMMIT.ALL",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0xFF",
-        "PublicDescription": "Number requests PCIe makes of the main die :=
 All : Counts full PCIe requests before they're broken into a series of cac=
he-line size requests as measured by DATA_REQ_OF_CPU and TXN_REQ_OF_CPU.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress NACKs : AD - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x16 card plu=
gged in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is p=
lugged in to slot 0",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress NACKs : AK - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 1",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress NACKs : BL - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2P_TxR_VERT_NACK0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x8 card plug=
ged in to Lane 2/3, Or x4 card is plugged in to slot 2",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2P_TxR_VERT_NACK1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 3",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress NACKs : AKC - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2P_TxR_VERT_NACK1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x16 card plu=
gged in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 card is p=
lugged in to slot 4",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 5",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x8 card plug=
ged in to Lane 6/7, Or x4 card is plugged in to slot 6",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore reading from Card's MMIO space : Also known as Outbound.  Number of req=
uests initiated by the main die, including reads and writes. : x4 card is p=
lugged in to slot 7",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : IV - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x16 card plugg=
ed in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plu=
gged in to slot 0",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AD - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 1",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AK - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x8 card plugge=
d in to Lane 2/3, Or x4 card is plugged in to slot 2",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : BL - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 3",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x16 card plugg=
ed in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 card is plu=
gged in to slot 4",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vert Egress Occupancy : AKC - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2P_TxR_VERT_OCCUPANCY1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 5",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x8 card plugge=
d in to Lane 6/7, Or x4 card is plugged in to slot 6",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Card's MMIO space",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Number Transactions requested by the CPU : C=
ore writing to Card's MMIO space : Also known as Outbound.  Number of reque=
sts initiated by the main die, including reads and writes. : x4 card is plu=
gged in to slot 7",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x16 card plugged in to Lane 0/1/2/3, Or x8 card plugged in to Lan=
e 0/1, Or x4 card is plugged in to slot 0",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : IV=
",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.IV_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x4 card is plugged in to slot 1",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AD=
 - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot =
2",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
 - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x4 card is plugged in to slot 3",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : BL=
 - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0x9a",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED0.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x16 card plugged in to Lane 4/5/6/7, Or x8 card plugged in to Lan=
e 4/5, Or x4 card is plugged in to slot 4",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0x9b",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED1.AKC_AG0",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x4 card is plugged in to slot 5",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 1",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0x9b",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED1.AKC_AG1",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x8 card plugged in to Lane 6/7, Or x4 card is plugged in to slot =
6",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Cm=
pD - device sending completion to CPU request",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation : AK=
C - Agent 0",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.CMPD.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0x9b",
+        "EventName": "UNC_M2P_TxR_VERT_STARVED1.TGC",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
mpD - device sending completion to CPU request : Also known as Inbound.  Nu=
mber of 64B cache line requests initiated by the Card, including reads and =
writes. : x4 card is plugged in to slot 7",
-        "UMask": "0x80",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AD Ring In Use : Up and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M2P_VERT_RING_AD_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x16 card plugge=
d in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plug=
ged in to slot 0",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AD Ring In Use : Up and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M2P_VERT_RING_AD_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 1",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AD Ring In Use : Down and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M2P_VERT_RING_AD_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x8 card plugged=
 in to Lane 2/3, Or x4 card is plugged in to slot 2",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AD Ring In Use : Down and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M2P_VERT_RING_AD_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 3",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0xb4",
+        "EventName": "UNC_M2P_VERT_RING_AKC_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x16 card plugge=
d in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 card is plug=
ged in to slot 4",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AKC Ring In Use : Up and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0xb4",
+        "EventName": "UNC_M2P_VERT_RING_AKC_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 5",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0xb4",
+        "EventName": "UNC_M2P_VERT_RING_AKC_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x8 card plugged=
 in to Lane 6/7, Or x4 card is plugged in to slot 6",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "BriefDescription": "Vertical AKC Ring In Use : Down and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0xb4",
+        "EventName": "UNC_M2P_VERT_RING_AKC_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard reading from DRAM : Also known as Inbound.  Number of 64B cache line re=
quests initiated by the Card, including reads and writes. : x4 card is plug=
ged in to slot 7",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical AK Ring In Use : Up and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "EventCode": "0xb1",
+        "EventName": "UNC_M2P_VERT_RING_AK_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x16 card plugged =
in to Lane 0/1/2/3, Or x8 card plugged in to Lane 0/1, Or x4 card is plugge=
d in to slot 0",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical AK Ring In Use : Up and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "EventCode": "0xb1",
+        "EventName": "UNC_M2P_VERT_RING_AK_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 1",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical AK Ring In Use : Down and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "EventCode": "0xb1",
+        "EventName": "UNC_M2P_VERT_RING_AK_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x8 card plugged i=
n to Lane 2/3, Or x4 card is plugged in to slot 2",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical AK Ring In Use : Down and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "EventCode": "0xb1",
+        "EventName": "UNC_M2P_VERT_RING_AK_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 3",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical BL Ring in Use : Up and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
-        "FCMask": "0x07",
+        "EventCode": "0xb2",
+        "EventName": "UNC_M2P_VERT_RING_BL_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x10",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x16 card plugged =
in to Lane 4/5/6/7, Or x8 card plugged in to Lane 4/5, Or x4 card is plugge=
d in to slot 4",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical BL Ring in Use : Up and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
-        "FCMask": "0x07",
+        "EventCode": "0xb2",
+        "EventName": "UNC_M2P_VERT_RING_BL_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PortMask": "0x20",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 5",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical BL Ring in Use : Down and Even",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
-        "FCMask": "0x07",
+        "EventCode": "0xb2",
+        "EventName": "UNC_M2P_VERT_RING_BL_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PortMask": "0x40",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x8 card plugged i=
n to Lane 6/7, Or x4 card is plugged in to slot 6",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "BriefDescription": "Vertical BL Ring in Use : Down and Odd",
         "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
-        "FCMask": "0x07",
+        "EventCode": "0xb2",
+        "EventName": "UNC_M2P_VERT_RING_BL_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PortMask": "0x80",
-        "PublicDescription": "Number Transactions requested of the CPU : C=
ard writing to DRAM : Also known as Inbound.  Number of 64B cache line requ=
ests initiated by the Card, including reads and writes. : x4 card is plugge=
d in to slot 7",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Total IRP occupancy of inbound read and write=
 requests to coherent memory.",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical IV Ring in Use : Up",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x0f",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "EventCode": "0xb3",
+        "EventName": "UNC_M2P_VERT_RING_IV_IN_USE.UP",
         "PerPkg": "1",
-        "PublicDescription": "Total IRP occupancy of inbound read and writ=
e requests to coherent memory.  This is effectively the sum of read occupan=
cy and write occupancy.",
-        "UMask": "0x04",
-        "Unit": "IRP"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Clockticks of the IO coherency tracker (IRP)",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical IV Ring in Use : Down",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_I_CLOCKTICKS",
+        "EventCode": "0xb3",
+        "EventName": "UNC_M2P_VERT_RING_IV_IN_USE.DN",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks of the IO coherency tracker (IRP)=
",
-        "Unit": "IRP"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "PCIITOM request issued by the IRP unit to the=
 mesh with the intention of writing a full cacheline.",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Even",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "EventCode": "0xb5",
+        "EventName": "UNC_M2P_VERT_RING_TGC_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "PCIITOM request issued by the IRP unit to th=
e mesh with the intention of writing a full cacheline to coherent memory, w=
ithout a RFO.  PCIITOM is a speculative Invalidate to Modified command that=
 requests ownership of the cacheline and does not move data from the mesh t=
o IRP cache.",
-        "UMask": "0x10",
-        "Unit": "IRP"
+        "UMask": "0x01",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Coherent Ops : WbMtoI",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical TGC Ring In Use : Up and Odd",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "EventCode": "0xb5",
+        "EventName": "UNC_M2P_VERT_RING_TGC_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Coherent Ops : WbMtoI : Counts the number of=
 coherency related operations servied by the IRP",
-        "UMask": "0x40",
-        "Unit": "IRP"
+        "UMask": "0x02",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "FAF RF full",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Even",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x17",
-        "EventName": "UNC_I_FAF_FULL",
+        "EventCode": "0xb5",
+        "EventName": "UNC_M2P_VERT_RING_TGC_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "FAF RF full",
-        "Unit": "IRP"
+        "UMask": "0x04",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue.",
-        "Counter": "0,1",
+        "BriefDescription": "Vertical TGC Ring In Use : Down and Odd",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x18",
-        "EventName": "UNC_I_FAF_INSERTS",
+        "EventCode": "0xb5",
+        "EventName": "UNC_M2P_VERT_RING_TGC_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Inbound read requests to coherent memory, re=
ceived by the IRP and inserted into the Fire and Forget queue (FAF), a queu=
e used for processing inbound reads in the IRP.",
-        "Unit": "IRP"
+        "UMask": "0x08",
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "Occupancy of the IRP FAF queue.",
-        "Counter": "0,1",
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x19",
-        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "EventCode": "0xae",
+        "EventName": "UNC_M2P_RING_SRC_THRTL",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy of the IRP Fire and Forget (FAF) q=
ueue, a queue used for processing inbound reads in the IRP.",
-        "Unit": "IRP"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": "FAF allocation -- sent to ADQ",
-        "Counter": "0,1",
+        "BriefDescription": "Transgress Injection Starvation",
+        "Counter": "0,1,2,3",
         "CounterType": "PGMABLE",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_FAF_TRANSACTIONS",
+        "EventCode": "0xe4",
+        "EventName": "UNC_M2P_RxR_CRD_STARVED_1",
         "PerPkg": "1",
-        "PublicDescription": "FAF allocation -- sent to ADQ",
-        "Unit": "IRP"
+        "Unit": "M2PCIe"
     },
     {
-        "BriefDescription": ": All Inserts Inbound (p2p + faf + cset)",
+        "BriefDescription": "Message Received : VLW",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0x20",
-        "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
         "PerPkg": "1",
-        "PublicDescription": ": All Inserts Inbound (p2p + faf + cset)",
         "UMask": "0x01",
-        "Unit": "IRP"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Misc Events - Set 1 : Lost Forward",
+        "BriefDescription": "Message Received : MSI",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0x1F",
-        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Misc Events - Set 1 : Lost Forward : Snoop p=
ulled away ownership before a write was committed",
-        "UMask": "0x10",
-        "Unit": "IRP"
+        "UMask": "0x02",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Responses to snoops of any type that hit M li=
ne in the IIO cache",
+        "BriefDescription": "Message Received : IPI",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0x12",
-        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Responses to snoops of any type (code, data,=
 invalidate) that hit M line in the IIO cache",
-        "UMask": "0x78",
-        "Unit": "IRP"
+        "UMask": "0x04",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP.",
+        "BriefDescription": "Message Received : Doorbell",
         "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0x11",
-        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Inbound write (fast path) requests to cohere=
nt memory, received by the IRP resulting in write ownership requests issued=
 by IRP to the mesh.",
         "UMask": "0x08",
-        "Unit": "IRP"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Clockticks of the mesh to memory (M2M)",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Message Received : Interrupt",
+        "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventName": "UNC_M2M_CLOCKTICKS",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks of the mesh to memory (M2M)",
-        "Unit": "M2M"
+        "UMask": "0x10",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "CMS Clockticks",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "Cycles PHOLD Assert to Ack : Assert to ACK",
+        "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_M2M_CMS_CLOCKTICKS",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
-        "PublicDescription": "CMS Clockticks",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Clockticks of the mesh to PCI (M2P)",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "IDI Lock/SplitLock Cycles",
+        "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0x01",
-        "EventName": "UNC_M2P_CLOCKTICKS",
+        "EventCode": "0x44",
+        "EventName": "UNC_U_LOCK_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks of the mesh to PCI (M2P)",
-        "Unit": "M2PCIe"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "CMS Clockticks",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "RACU Request",
+        "Counter": "0,1",
         "CounterType": "PGMABLE",
-        "EventCode": "0xc0",
-        "EventName": "UNC_M2P_CMS_CLOCKTICKS",
-        "PerPkg": "1",
-        "PublicDescription": "CMS Clockticks",
-        "Unit": "M2PCIe"
-    },
-    {
-        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
-        "Counter": "FIXED",
-        "CounterType": "FIXED",
-        "EventCode": "0xff",
-        "EventName": "UNC_U_CLOCKTICKS",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks in the UBOX using a dedicated 48-=
bit Fixed Counter",
         "Unit": "UBOX"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
index ea62c092b43f..e3ef1de7f893 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
@@ -5,7 +5,204 @@
         "CounterType": "PGMABLE",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Clockticks of the power control unit (PCU)",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 0 Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x75",
+        "EventName": "UNC_P_FIVR_PS_PS0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 1 Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x76",
+        "EventName": "UNC_P_FIVR_PS_PS1_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 2 Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x77",
+        "EventName": "UNC_P_FIVR_PS_PS2_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 3 Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x78",
+        "EventName": "UNC_P_FIVR_PS_PS3_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "AVX256 Frequency Clipping",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x49",
+        "EventName": "UNC_P_FREQ_CLIP_AVX256",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "AVX512 Frequency Clipping",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x4a",
+        "EventName": "UNC_P_FREQ_CLIP_AVX512",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x05",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x73",
+        "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Memory Phase Shedding Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2F",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C0",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2A",
+        "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2B",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2C",
+        "EventName": "UNC_P_PKG_RESIDENCY_C3_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x2D",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x0A",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x09",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Total Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x72",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x42",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State : C0 and C1",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State : C3",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State : C6 and C7",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "PerPkg": "1",
         "Unit": "PCU"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
index ecbfc335a9b6..2b22f9c5fabd 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/virtual-memory.json
@@ -362,4 +362,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     }
-]
\ No newline at end of file
+]
--=20
2.25.1

