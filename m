Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006DC590DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiHLIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiHLIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:52:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3322A98F7;
        Fri, 12 Aug 2022 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294348; x=1691830348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gTmGNjJLWqGLKiwko7ClIz5ivG/3agV5J6vtS7ZpP4w=;
  b=VZC9rGi3oOnfxnaSsVERcWbCCgLyFm0yrAvKoDJ4ifQ1CN+ZqRbxjwKm
   6j2G1avfY2ZiKIlTz0vuDV/lau3Kq2gOCZXsObTa9NRU/2eVyELNO+Q01
   b10YnXvxWD8yuI7B83rKVUJmVwfTLJnoc/hhmEQrIDwhrMMN5539aS1Xu
   0ALea/L6w9Ut4VgTMaWN8rEOdZSOjUR5lKme1WwGlKEVgLu3c1SW2rS6f
   sZ1pEiCEDINfMf6P2FcEy2MlzAMJCRBiXjjRHcJFQAftIiQ41sZ8rwkvJ
   9UuoQ9hRxWxXEx9SBYa6KWdv+XHWSMCAe8w4ZVVB7m7HacvHaTJy+2NvH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="274610773"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="274610773"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451505"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:52:21 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 10/11] perf vendor events: Update events and metrics for skylakex
Date:   Fri, 12 Aug 2022 16:52:38 +0800
Message-Id: <20220812085239.3089231-11-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update the events to v1.28, the metrics are based on TMA 4.4 full, update
events and metrics for skylakex by the latest event converter tools.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the skylakex files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/skylakex/skx-metrics.json        |     6 +
 .../arch/x86/skylakex/uncore-memory.json      |  3566 ++-
 .../arch/x86/skylakex/uncore-other.json       | 23442 ++++++++++++++--
 .../arch/x86/skylakex/uncore-power.json       |   201 +
 4 files changed, 25488 insertions(+), 1727 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/uncore-power.js=
on

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index d65420bda04f..6a6764e1504b 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -697,6 +697,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "cha_0@event\\=3D0x0@ / #num_dies / duration_time / =
1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b/t=
ools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
index 56709633c379..0746fcf2ebd9 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
@@ -1,4 +1,31 @@
 [
+    {
+        "BriefDescription": "DRAM Page Activate commands sent due to a wri=
te request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All DRAM Read CAS Commands issued (does not i=
nclude underfills)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Underfill Read CAS Commands issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
         "Counter": "0,1,2,3",
@@ -19,6 +46,15 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; D=
RAM WR_CAS (w/ and w/out auto-pre) in Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "write requests to memory controller. Derived =
from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
@@ -39,6 +75,15 @@
         "UMask": "0xC",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "All DRAM CAS Commands issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
@@ -85,98 +130,3543 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for writes",
+        "BriefDescription": "Read Pending Queue Allocations",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_M_PRE_COUNT.WR",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS",
         "PerPkg": "1",
-        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Page Activate commands sent due to a wri=
te request",
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_WPQ_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Read",
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
-        "EventName": "UNC_M_ACT_COUNT.WR",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.BYP",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.ACT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CAS command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.CAS",
         "PerPkg": "1",
-        "PublicDescription": "Counts DRAM Page Activate commands sent on t=
his channel due to a write request to the iMC (Memory Controller).  Activat=
e commands are issued to open up a page on the DRAM devices so that it can =
be read or written to with a CAS (Column Access Select) command.",
         "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM CAS Commands issued",
+        "BriefDescription": "PRE command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.PRE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; D=
RAM WR_CAS (w/ and w/out auto-pre) in Read Major Mode",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "EventName": "UNC_M_CAS_COUNT.WR_RMM",
         "PerPkg": "1",
-        "PublicDescription": "Counts all CAS (Column Address Select) comma=
nds issued to DRAM per memory channel.  CAS commands are issued to specify =
the address to read or write on DRAM, so this event increments for every re=
ad and write. This event counts whether AutoPrecharge (which closes the DRA=
M Page automatically after a read/write) is enabled or not.",
-        "UMask": "0xF",
+        "UMask": "0x8",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "All DRAM Read CAS Commands issued (does not i=
nclude underfills)",
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; R=
ead CAS issued in WMM",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "EventName": "UNC_M_CAS_COUNT.RD_WMM",
         "PerPkg": "1",
-        "PublicDescription": "Counts CAS (Column Access Select) regular re=
ad commands issued to DRAM on a per channel basis.  CAS commands are issued=
 to specify the address to read or write on DRAM, and this event increments=
 for every regular read.  This event only counts regular reads and does not=
 includes underfill reads due to partial write requests.  This event counts=
 whether AutoPrecharge (which closes the DRAM Page automatically after a re=
ad/write)  is enabled or not.",
-        "UMask": "0x1",
+        "UMask": "0x10",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM Underfill Read CAS Commands issued",
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; R=
ead CAS issued in RMM",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "EventName": "UNC_M_CAS_COUNT.RD_RMM",
         "PerPkg": "1",
-        "PublicDescription": "Counts CAS (Column Access Select) underfill =
read commands issued to DRAM due to a partial write, on a per channel basis=
.  CAS commands are issued to specify the address to read or write on DRAM,=
 and this command counts underfill reads.  Partial writes must be completed=
 by first reading in the underfill from DRAM and then merging in the partia=
l write data before writing the full line back to DRAM. This event will gen=
erally count about the same as the number of partial writes, but may be sli=
ghtly less because of partials hitting in the WPQ (due to a previous write =
request).",
-        "UMask": "0x2",
+        "UMask": "0x20",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; D=
RAM WR_CAS (w/ and w/out auto-pre) in Write Major Mode",
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; R=
ead CAS issued in Read ISOCH Mode",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "EventName": "UNC_M_CAS_COUNT.RD_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; R=
ead CAS issued in Write ISOCH Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M_DRAM_PRE_ALL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number or DRAM Write CAS co=
mmands issued on this channel while in Write-Major-Mode.",
         "UMask": "0x4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Allocations",
+        "BriefDescription": "ECC Correctable Errors",
         "Counter": "0,1,2,3",
-        "EventCode": "0x10",
-        "EventName": "UNC_M_RPQ_INSERTS",
+        "EventCode": "0x9",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of read requests allocated=
 into the Read Pending Queue (RPQ).  This queue is used to schedule reads o=
ut to the memory controller and to track the requests.  Requests allocate i=
nto the RPQ soon after they enter the memory controller, and need credits f=
or an entry in this buffer before being sent from the CHA to the iMC.  The =
requests deallocate after the read CAS command has been issued to DRAM.  Th=
is event counts both Isochronous and non-Isochronous requests which were is=
sued to the RPQ.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read Pending Queue Occupancy",
+        "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_M_RPQ_OCCUPANCY",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.READ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.WRITE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries in the Read Pen=
ding Queue (RPQ) at each cycle.  This can then be used to calculate both th=
e average occupancy of the queue (in conjunction with the number of cycles =
not empty) and the average latency in the queue (in conjunction with the nu=
mber of allocations).  The RPQ is used to schedule reads out to the memory =
controller and to track the requests.  Requests allocate into the RPQ soon =
after they enter the memory controller, and need credits for an entry in th=
is buffer before being sent from the CHA to the iMC. They deallocate from t=
he RPQ after the CAS command has been issued to memory.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Allocations",
+        "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
         "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_M_WPQ_INSERTS",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of writes requests allocat=
ed into the Write Pending Queue (WPQ).  The WPQ is used to schedule writes =
out to the memory controller and to track the requests.  Requests allocate =
into the WPQ soon after they enter the memory controller, and need credits =
for an entry in this buffer before being sent from the CHA to the iMC (Memo=
ry Controller).  The write requests deallocate after being issued to DRAM. =
 Write requests themselves are able to complete (from the perspective of th=
e rest of the system) as soon they have 'posted' to the iMC.",
+        "UMask": "0x4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write Pending Queue Occupancy",
+        "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
         "Counter": "0,1,2,3",
-        "EventCode": "0x81",
-        "EventName": "UNC_M_WPQ_OCCUPANCY",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel DLLOFF Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Critical Throttle Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "UNC_M_POWER_PCU_THROTTLING",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_M_POWER_PCU_THROTTLING",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Pre-charge for writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to by=
pass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.BYP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with LOW priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.LOW",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with MEDIUM priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.MED",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with HIGH priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M_RPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold; Transition from WMM to RMM because of starve counter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.STARVE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Not getting the requested Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_M_WRONG_MM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Clockticks in the Memory Controller using a d=
edicated 48-bit Fixed Counter",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_M_CLOCKTICKS_F",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries in the Write Pe=
nding Queue (WPQ) at each cycle.  This can then be used to calculate both t=
he average queue occupancy (in conjunction with the number of cycles not em=
pty) and the average latency (in conjunction with the number of allocations=
).  The WPQ is used to schedule writes out to the memory controller and to =
track the requests.  Requests allocate into the WPQ soon after they enter t=
he memory controller, and need credits for an entry in this buffer before b=
eing sent from the CHA to the iMC (memory controller).  They deallocate aft=
er being issued to DRAM.  Write requests themselves are able to complete (f=
rom the perspective of the rest of the system) as soon they have 'posted' t=
o the iMC.  This is not to be confused with actually performing the write t=
o DRAM.  Therefore, the average latency for this queue is actually not usef=
ul for deconstruction intermediate write latencies.  So, we provide filteri=
ng based on if the request has posted or not.  By using the 'not posted' fi=
lter, we can track how long writes spent in the iMC before completions were=
 sent to the HA.  The 'posted' filter, on the other hand, provides informat=
ion about how much queueing is actually happenning in the iMC for writes be=
fore they are actually issued to memory.  High average occupancies will gen=
erally coincide with high write major mode counts. Is there a filter of sor=
ts???",
         "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index abe2d068ea0c..f55aeadc630f 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -1,140 +1,151 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CLOCKTICKS",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_CHA_CLOCKTICKS",
+        "Deprecated": "1",
+        "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "Core Cross Snoops Issued; Multiple Core Reque=
sts",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "config1=3D0x40e33",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x42",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "BriefDescription": "Core Cross Snoops Issued; Multiple Eviction",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40e33",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x82",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.=
ia_miss",
+        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Needed",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "config1=3D0x40040e33",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO reads",
+        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Not Needed",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40040e33",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x02",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts=
.ia_miss",
+        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from the HA pipe",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "config1=3D0x40041e33",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "MMIO writes",
+        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from TOR pipe",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x40041e33",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
         "PerPkg": "1",
-        "UMask": "0x21",
+        "UMask": "0x02",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "Read request from a remote socket which hit i=
n the HitMe Cache to a line In the E state",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "config1=3D0x41833",
+        "EventCode": "0x5F",
+        "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x21",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line)",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.DATA_READ",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x41833",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x21",
+        "UMask": "0x3",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_cha_tor_inserts.ia_miss",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.REMOTE_SNOOP",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "config1=3D0x41a33",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x21",
+        "UMask": "0x9",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line)",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_M",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
-        "Filter": "config1=3D0x41a33",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x21",
+        "UMask": "0x1",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "read requests from home agent",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_E",
         "Counter": "0,1,2,3",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
-        "UMask": "0x03",
+        "UMask": "0x2",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "read requests from local home agent",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_S",
         "Counter": "0,1,2,3",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
-        "UMask": "0x01",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of times that an RFO hit in S state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "UMask": "0x08",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "read requests from remote home agent",
+        "BriefDescription": "read requests from home agent",
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
+        "EventName": "UNC_CHA_REQUESTS.READS",
         "PerPkg": "1",
-        "UMask": "0x02",
+        "UMask": "0x03",
         "Unit": "CHA"
     },
     {
@@ -146,6 +157,15 @@
         "UMask": "0x0C",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "read requests from local home agent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "write requests from local home agent",
         "Counter": "0,1,2,3",
@@ -156,477 +176,411 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "write requests from remote home agent",
+        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line  without receiving data",
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
-        "UMask": "0x08",
+        "UMask": "0x10",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UPI interconnect send bandwidth for payload. =
Derived from unc_upi_txl_flits.all_data",
+        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line without receiving data",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UPI_DATA_BANDWIDTH_TX",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
         "PerPkg": "1",
-        "ScaleUnit": "7.11E-06Bytes",
-        "UMask": "0xf",
-        "Unit": "UPI LL"
+        "UMask": "0x20",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "UPI interconnect send bandwidth for payload",
+        "BriefDescription": "RspIFwd Snoop Responses Received",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
         "PerPkg": "1",
-        "ScaleUnit": "7.11E-06Bytes",
-        "UMask": "0xf",
-        "Unit": "UPI LL"
+        "UMask": "0x04",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "RspSFwd Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 1",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Rsp*Fwd*WB Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 2",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 3",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IRQ",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x31",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_read.part0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_READ",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DAT=
A_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_II=
O_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IA",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IRQ",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x31",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth reading at IIO",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DAT=
A_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_II=
O_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REM_ALL",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x30",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_FAST_ASSERTED.HORZ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xA5",
+        "EventName": "UNC_C_FAST_ASSERTED",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Phy=
Addr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x80",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 2",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "Ingress (from CMS) Occupancy; IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "ScaleUnit": "4Bytes",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 3",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IA_HIT",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IRQ_HIT",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x11",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_write.part0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IRQ_MISS",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x21",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "PCI Express bandwidth writing at IIO",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
-        "Filter": "ch_mask=3D0x1f",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC=
_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IO_HIT",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.PRQ_HIT",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x14",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Core Cross Snoops Issued; Multiple Core Reque=
sts",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IO_MISS",
         "Counter": "0,1,2,3",
-        "EventCode": "0x33",
-        "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.PRQ_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
-        "UMask": "0x42",
+        "UMask": "0x24",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Core Cross Snoops Issued; Multiple Eviction",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x33",
-        "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IRQ_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of transactions that trigg=
er a configurable number of cross snoops.  Cores are snooped if the transac=
tion looks up the cache and determines that it is necessary based on the op=
eration type and what CoreValid bits are set.  For example, if 2 CV bits ar=
e set on a data read, the cores must have the data in S state so it is not =
necessary to snoop them.  However, if only 1 CV bit is set the core my have=
 modified the data.  If the transaction was an RFO, it would need to invali=
date the lines.  This event can be filtered based on who triggered the init=
ial snoop(s).",
-        "UMask": "0x82",
+        "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Not Needed",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x53",
-        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IRQ_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts transactions that looked into the mul=
ti-socket cacheline Directory state, and therefore did not send a snoop bec=
ause the Directory indicated it was not needed",
-        "UMask": "0x02",
+        "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state lookup=
s; Snoop Needed",
+        "BriefDescription": "TOR Inserts; Hits from Local IO",
         "Counter": "0,1,2,3",
-        "EventCode": "0x53",
-        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts  transactions that looked into the mu=
lti-socket cacheline Directory state, and sent one or more snoops, because =
the Directory indicated it was needed",
-        "UMask": "0x01",
+        "UMask": "0x14",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from the HA pipe",
+        "BriefDescription": "TOR Inserts; Misses from Local IO",
         "Counter": "0,1,2,3",
-        "EventCode": "0x54",
-        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates memory writes issued from the HA pipe. This does not include=
 memory write requests which are for I (Invalid) or E (Exclusive) cacheline=
s.",
-        "UMask": "0x01",
+        "UMask": "0x24",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory state update=
s; Directory Updated memory write from TOR pipe",
+        "BriefDescription": "TOR Inserts; All from Local iA",
         "Counter": "0,1,2,3",
-        "EventCode": "0x54",
-        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
         "PerPkg": "1",
-        "PublicDescription": "Counts only multi-socket cacheline Directory=
 state updates due to memory writes issued from the TOR pipe which are the =
result of remote transaction hitting the SF/LLC and returning data Core2Cor=
e. This does not include memory write requests which are for I (Invalid) or=
 E (Exclusive) cachelines.",
-        "UMask": "0x02",
+        "UMask": "0x31",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "FaST wire asserted; Horizontal",
+        "BriefDescription": "TOR Inserts; Hits from Local iA",
         "Counter": "0,1,2,3",
-        "EventCode": "0xA5",
-        "EventName": "UNC_CHA_FAST_ASSERTED.HORZ",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles either the local=
 or incoming distress signals are asserted.  Incoming distress includes up,=
 dn and across.",
-        "UMask": "0x02",
+        "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read request from a remote socket which hit i=
n the HitMe Cache to a line In the E state",
+        "BriefDescription": "TOR Inserts : All requests from iA Cores that=
 Missed the LLC",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5F",
-        "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts read requests from a remote socket wh=
ich hit in the HitME cache (used to cache the multi-socket Directory state)=
 to a line in the E(Exclusive) state.  This includes the following read opc=
odes (RdCode, RdData, RdDataMigratory, RdCur, RdInv*, Inv*)",
-        "UMask": "0x01",
+        "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Normal priority reads issued to the memory co=
ntroller from the CHA",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x59",
-        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
+        "BriefDescription": "TOR Occupancy; All from Local iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a normal (Non-Isochronous) read =
is issued to any of the memory controller channels from the CHA.",
-        "UMask": "0x01",
+        "UMask": "0x31",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "CHA to iMC Full Line Writes Issued; Full Line=
 Non-ISOCH",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x5B",
-        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "BriefDescription": "TOR Occupancy; Hits from Local iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a normal (Non-Isochronous) full =
line write is issued from the CHA to the any of the memory controller chann=
els.",
-        "UMask": "0x01",
+        "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Lines Victimized; Lines in E state",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "BriefDescription": "TOR Occupancy; Misses from Local iA",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
-        "UMask": "0x02",
+        "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Lines Victimized; Lines in F State",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; BL NCS VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_BL_NCS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
-        "UMask": "0x08",
+        "UMask": "0x80",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Lines Victimized; Lines in M state",
+        "BriefDescription": "FaST wire asserted; Horizontal",
         "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
-        "UMask": "0x01",
+        "UMask": "0x02",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Lines Victimized; Lines in S State",
+        "BriefDescription": "Clockticks of the uncore caching & home agent=
 (CHA)",
         "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
-        "UMask": "0x04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Number of times that an RFO hit in S state.",
+        "BriefDescription": "Normal priority reads issued to the memory co=
ntroller from the CHA",
         "Counter": "0,1,2,3",
-        "EventCode": "0x39",
-        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a RFO (the Read for Ownership is=
sued before a  write) request hit a cacheline in the S (Shared) state.",
-        "UMask": "0x08",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line  without receiving data",
+        "BriefDescription": "CHA to iMC Full Line Writes Issued; Full Line=
 Non-ISOCH",
         "Counter": "0,1,2,3",
-        "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of requests coming f=
rom a unit on this socket for exclusive ownership of a cache line without r=
eceiving data (INVITOE) to the CHA.",
-        "UMask": "0x10",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Local requests for exclusive ownership of a c=
ache line without receiving data",
+        "BriefDescription": "Read requests from a remote socket",
         "Counter": "0,1,2,3",
         "EventCode": "0x50",
-        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the total number of requests coming f=
rom a remote socket for exclusive ownership of a cache line without receivi=
ng data (INVITOE) to the CHA.",
-        "UMask": "0x20",
+        "UMask": "0x02",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Ingress (from CMS) Allocations; IRQ",
+        "BriefDescription": "RspI Snoop Responses Received",
         "Counter": "0,1,2,3",
-        "EventCode": "0x13",
-        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
         "PerPkg": "1",
-        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
         "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Phy=
Addr Match",
+        "BriefDescription": "Rsp*WB Snoop Responses Received",
         "Counter": "0,1,2,3",
-        "EventCode": "0x19",
-        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Ingress (from CMS) Request Queue Rejects; Ph=
yAddr Match",
-        "UMask": "0x80",
+        "UMask": "0x10",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Ingress (from CMS) Occupancy; IRQ",
-        "EventCode": "0x11",
-        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "BriefDescription": "RspCnflct* Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
-        "UMask": "0x01",
+        "UMask": "0x40",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for E-state e=
ntries.",
+        "BriefDescription": "Snoop filter capacity evictions for M-state e=
ntries",
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
-        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking exclusive lines in the cores cache. Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry. Does not count clean evictions such as when a cores ca=
che replaces a tracked cacheline with a new cacheline.",
-        "UMask": "0x02",
+        "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for M-state e=
ntries.",
+        "BriefDescription": "Snoop filter capacity evictions for E-state e=
ntries",
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
-        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking modified lines in the cores cache. Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry. Does not count clean evictions such as when a cores cac=
he replaces a tracked cacheline with a new cacheline.",
-        "UMask": "0x01",
+        "UMask": "0x02",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Snoop filter capacity evictions for S-state e=
ntries.",
+        "BriefDescription": "Snoop filter capacity evictions for S-state e=
ntries",
         "Counter": "0,1,2,3",
         "EventCode": "0x3D",
         "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
         "PerPkg": "1",
-        "PublicDescription": "Counts snoop filter capacity evictions for e=
ntries tracking shared lines in the cores cache. Snoop filter capacity evic=
tions occur when the snoop filter is full and evicts an existing entry to t=
rack a new entry. Does not count clean evictions such as when a cores cache=
 replaces a tracked cacheline with a new cacheline.",
         "UMask": "0x04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "RspCnflct* Snoop Responses Received",
+        "BriefDescription": "This event is deprecated. ",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspCnflct* Snoop Response was received. This is returned when a snoop =
finds an existing outstanding transaction in a remote caching agent. This t=
riggers conflict resolution hardware. This covers both the opcode RspCnflct=
 and RspCnflctWbI.",
-        "UMask": "0x40",
+        "UMask": "0x30",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "RspI Snoop Responses Received",
+        "BriefDescription": "Lines Victimized; Lines in M state",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspI Snoop Response was received which indicates the remote cache does n=
ot have the data, or when the remote cache silently evicts data (such as wh=
en an RFO: the Read for Ownership issued before a write hits non-modified d=
ata).",
         "UMask": "0x01",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "RspIFwd Snoop Responses Received",
+        "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspIFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data and the requesting agent is able to acquire the dat=
a in E (Exclusive) or M (modified) states.  This is commonly returned with =
RFO (the Read for Ownership issued before a write) transactions.  The snoop=
 could have either been to a cacheline in the M,E,F (Modified, Exclusive or=
 Forward)  states.",
         "UMask": "0x04",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "RspSFwd Snoop Responses Received",
+        "BriefDescription": "Lines Victimized; Lines in F State",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_F",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspSFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data but held on to its current copy.  This is common fo=
r data and code reads that hit in a remote socket in E (Exclusive) or F (Fo=
rward) state.",
         "UMask": "0x08",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Rsp*Fwd*WB Snoop Responses Received",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Hi=
t the LLC",
         "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*Fwd*WB Snoop Response was received which indicates the data was writ=
ten back to its home socket, and the cacheline was forwarded to the request=
or socket.  This snoop response is only used in &gt;=3D 4 socket systems.  =
It is used when a snoop HITM's in a remote caching agent and it directly fo=
rwards data to a requestor, and simultaneously returns data to its home soc=
ket to be written back to memory.",
-        "UMask": "0x20",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "Rsp*WB Snoop Responses Received",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x5C",
-        "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
-        "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode ty=
pe Rsp*WB Snoop Response was received which indicates which indicates the d=
ata was written back to its home.  This is returned when a non-RFO request =
hits a cacheline in the Modified state. The Cache can either downgrade the =
cacheline to a S (Shared) or I (Invalid) state depending on how the system =
has been configured.  This response will also be sent when a cache requests=
 E (Exclusive) ownership of a cache line without receiving data, because th=
e cache must acquire ownership.",
-        "UMask": "0x10",
+        "UMask": "0x11",
         "Unit": "CHA"
     },
     {
@@ -636,40 +590,36 @@
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
         "Filter": "config1=3D0x40233",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Hi=
t the LLC",
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Hi=
t the LLC",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
@@ -680,19 +630,17 @@
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
         "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Hi=
t the LLC",
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Mi=
ssed the LLC",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
-        "UMask": "0x11",
+        "UMask": "0x21",
         "Unit": "CHA"
     },
     {
@@ -702,29 +650,16 @@
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
         "Filter": "config1=3D0x40233",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
-        "UMask": "0x21",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Mi=
ssed the LLC",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
-        "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Mi=
ssed the LLC",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -735,42 +670,36 @@
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
         "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores t=
hat missed the LLC",
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC : Counts the number of entries successfully inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Mi=
ssed the LLC",
+        "BriefDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores t=
hat missed the LLC",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. ",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x35",
-        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
-        "Filter": "CHAfilter1",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. ",
-        "UMask": "0x30",
+        "UMask": "0x11",
         "Unit": "CHA"
     },
     {
@@ -779,37 +708,33 @@
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
         "Filter": "config1=3D0x40233",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
-        "Filter": "config1=3D0x40433",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
-        "Filter": "config1=3D0x4b433",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
         "UMask": "0x11",
         "Unit": "CHA"
     },
@@ -819,18 +744,16 @@
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
         "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
         "UMask": "0x11",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "Filter": "config1=3D0x40033",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
+        "Filter": "config1=3D0x40433",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
-        "UMask": "0x11",
+        "UMask": "0x21",
         "Unit": "CHA"
     },
     {
@@ -839,27 +762,15 @@
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
         "Filter": "config1=3D0x40233",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
-        "UMask": "0x21",
-        "Unit": "CHA"
-    },
-    {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
-        "Filter": "config1=3D0x40433",
-        "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
-        "Filter": "config1=3D0x4b233",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "Filter": "config1=3D0x40033",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
         "UMask": "0x21",
         "Unit": "CHA"
     },
@@ -869,1824 +780,21977 @@
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
         "Filter": "config1=3D0x4b433",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
-        "Filter": "config1=3D0x4b033",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
         "EventCode": "0x36",
-        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
-        "Filter": "config1=3D0x40033",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
         "PerPkg": "1",
-        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
         "UMask": "0x21",
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CLOCKTICKS",
+        "BriefDescription": "Clockticks of the IIO Traffic Controller",
         "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventName": "UNC_C_CLOCKTICKS",
+        "EventCode": "0x1",
+        "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CLOCKTICKS",
-        "Unit": "CHA"
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_FAST_ASSERTED.HORZ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0xA5",
-        "EventName": "UNC_C_FAST_ASSERTED",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_FAST_ASSERTED.HORZ",
-        "UMask": "0x02",
-        "Unit": "CHA"
+        "PortMask": "0x1",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_E",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART1",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_E",
-        "UMask": "0x2",
-        "Unit": "CHA"
+        "PortMask": "0x2",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_F",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART2",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_F",
-        "UMask": "0x8",
-        "Unit": "CHA"
+        "PortMask": "0x4",
+        "UMask": "0x1",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_M",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "PortMask": "0x8",
         "UMask": "0x1",
-        "Unit": "CHA"
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_S",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART0",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "PortMask": "0x1",
         "UMask": "0x4",
-        "Unit": "CHA"
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. ",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.REM_ALL",
-        "Filter": "CHAfilter1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART1",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. ",
-        "UMask": "0x30",
-        "Unit": "CHA"
+        "PortMask": "0x2",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.CORE_GTONE",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x33",
-        "EventName": "UNC_H_CORE_SNP.CORE_GTONE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART2",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.CORE_GTONE",
-        "UMask": "0x42",
-        "Unit": "CHA"
+        "PortMask": "0x4",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.EVICT_GTONE",
-        "Counter": "0,1,2,3",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "Counter": "0,1",
         "Deprecated": "1",
-        "EventCode": "0x33",
-        "EventName": "UNC_H_CORE_SNP.EVICT_GTONE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART3",
+        "FCMask": "0x7",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.EVICT_GTONE",
-        "UMask": "0x82",
-        "Unit": "CHA"
+        "PortMask": "0x8",
+        "UMask": "0x4",
+        "Unit": "IIO"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.NO_SNP",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x53",
-        "EventName": "UNC_H_DIR_LOOKUP.NO_SNP",
+        "BriefDescription": "Write request of 4 bytes made to IIO Part0 by=
 the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part1 by=
 the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part2 by=
 the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part3 by=
 the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part1 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part2 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part3 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part0",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part1",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part2",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part3",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part1",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part2",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part3",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 2",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 3",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_write.part0",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "LLC_MISSES.PCIE_WRITE",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=3D0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_D=
ATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 1",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 2",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 3",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived=
 from unc_iio_data_req_of_cpu.mem_read.part0",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "LLC_MISSES.PCIE_READ",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=3D0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DA=
TA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC=
_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part1 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part2 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part3 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part0 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part1 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part2 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part3 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part0 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part1 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part2 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part3 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part0 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part1 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part2 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part3 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is  made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part0 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part1 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part2 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part3 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 0",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 1",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 2",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 3",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0-3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "FCMask": "0x4",
+        "PerPkg": "1",
+        "PortMask": "0x0f",
+        "UMask": "0x03",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 0-3",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "FCMask": "0x04",
+        "PerPkg": "1",
+        "UMask": "0x0f",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Total IRP occupancy of inbound read and write=
 requests",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "RFO request issued by the IRP unit to the mes=
h with the intention of writing a partial cacheline",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "PCIITOM request issued by the IRP unit to the=
 mesh with the intention of writing a full cacheline",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "Counter": "0,1",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Occupancy of the IRP FAF queue",
+        "Counter": "0,1",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clocks of the Intel Ultra Path Interconnect (=
UPI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Data Response packets that go direct to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2K",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Intel UPI is in L1 power mode (shutdow=
n)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles the Rx of the Intel UPI is in L0p powe=
r mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_FLITS.ALL_NULL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in which the Tx of the Intel Ultra Pat=
h Interconnect (UPI) is in L0p power mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs that bypassed the TxL Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_UPI_TxL_BYPASSED",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_FLITS.ALL_NULL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Protocol header and credit FLITs received fro=
m any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Protocol header and credit FLITs transmitted =
across any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Idle FLITs transmitted",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Null FLITs transmitted from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "UMask": "0x27",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Null FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "UMask": "0x27",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid data FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0x0F",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UPI interconnect send bandwidth for payload. =
Derived from unc_upi_txl_flits.all_data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UPI_DATA_BANDWIDTH_TX",
+        "PerPkg": "1",
+        "ScaleUnit": "7.11E-06Bytes",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UPI interconnect send bandwidth for payload",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "ScaleUnit": "7.11E-06Bytes",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Data Response packets that go direct to Intel=
 UPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Traffic in which the M2M to iMC Bypass was no=
t taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages sent direct to core (bypassing the C=
HA)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Reads to iMC issued at Normal Priority (Non-I=
sochronous)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Reads to iMC issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Partial Non-Isochronous writes to the iMC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Writes to iMC issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; All, regardless of =
priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.NI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch requests that got turn into a demand=
 request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Inserts into the Memory Controller Prefetch Q=
ueue",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M2M_RxC_AD_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M2M_RxC_BL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_M2M_TxC_AD_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles when direct to Intel UPI was disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages sent direct to the Intel UPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetches generated by the flow control queu=
e of the M3UPI unit",
+        "Counter": "0,1,2",
+        "EventCode": "0x29",
+        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass; Intermediate bypass Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.INTERMEDIATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Bypass; Not Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_CHA_BYPASS_CHA_IMC.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Single External Sno=
ops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EXT_ONE",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Single Core Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_ONE",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Single Eviction",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_ONE",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Any Single Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.ANY_ONE",
+        "PerPkg": "1",
+        "UMask": "0xE1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Multiple External S=
noops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EXT_GTONE",
+        "PerPkg": "1",
+        "UMask": "0x22",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Any Cycle with Mult=
iple Snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.ANY_GTONE",
+        "PerPkg": "1",
+        "UMask": "0xE2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; External Snoop to R=
emote Node",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EXT_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Core Request to Rem=
ote Node",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Eviction to Remote =
Node",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x84",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Any Snoop to Remote=
 Node",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.ANY_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0xE4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counter 0 Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_CHA_COUNTER0_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Shared =
hit and op is RdInvOwn, RdInv, Inv*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5F",
+        "EventName": "UNC_CHA_HITME_HIT.SHARED_OWNREQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5F",
+        "EventName": "UNC_CHA_HITME_HIT.WBMTOE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoI, WbPushMtoI, WbFlush, or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5F",
+        "EventName": "UNC_CHA_HITME_HIT.WBMTOI_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RdCode, RdData, RdDataMigratory, RdCur, RdInvOwn, RdInv, Inv*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5E",
+        "EventName": "UNC_CHA_HITME_LOOKUP.READ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoE, WbMtoI, WbPushMtoI, WbFlush, or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5E",
+        "EventName": "UNC_CHA_HITME_LOOKUP.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Misses in HitMe Cache; SF/LL=
C HitS/F and op is RdInvOwn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_CHA_HITME_MISS.SHARED_RDINVOWN",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Misses in HitMe Cache; No SF=
/LLC HitS/F and op is RdInvOwn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_CHA_HITME_MISS.NOTSHARED_RDINVOWN",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of Misses in HitMe Cache; op is=
 RdCode, RdData, RdDataMigratory, RdCur, RdInv, Inv*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_CHA_HITME_MISS.READ_OR_INV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache; op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_CHA_HITME_UPDATE.DEALLOCATE_RSPFWDI_LOC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache; op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_CHA_HITME_UPDATE.RSPFWDI_REM",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache; Update HitMe Cache to SHARed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_CHA_HITME_UPDATE.SHARED",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache; Update HitMe Cache on RdInvOwn even if not RspFwdI*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_CHA_HITME_UPDATE.RDINVOWN",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of Allocate/Update to HitMe=
 Cache; Deallocate HtiME$ on Reads without RspFwdI*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_CHA_HITME_UPDATE.DEALLOCATE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "HA to iMC Reads Issued; ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_IMC_READS_COUNT.PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Writes Issued to the iMC by the HA; Partial N=
on-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Writes Issued to the iMC by the HA; ISOCH Ful=
l Line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Writes Issued to the iMC by the HA; ISOCH Par=
tial",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Writes Issued to the iMC by the HA; Full Line=
 MIG",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_MIG",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Writes Issued to the iMC by the HA; Partial M=
IG",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_MIG",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of times IODC entry allocation =
is attempted; Number of IODC allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_CHA_IODC_ALLOC.INVITOM",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of times IODC entry allocation =
is attempted; Number of IODC allocations dropped due to IODC Full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_CHA_IODC_ALLOC.IODCFULL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts Number of times IODC entry allocation =
is attempted; Number of IDOC allocation dropped due to OSB gate",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_CHA_IODC_ALLOC.OSBGATED",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of IODC deallocations; IODC dea=
llocated due to WbMtoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_CHA_IODC_DEALLOC.WBMTOE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of IODC deallocations; IODC dea=
llocated due to WbMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_CHA_IODC_DEALLOC.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of IODC deallocations; IODC dea=
llocated due to WbPushMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_CHA_IODC_DEALLOC.WBPUSHMTOI",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of IODC deallocations; IODC dea=
llocated due to conflicting transaction",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_CHA_IODC_DEALLOC.SNPOUT",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts number of IODC deallocations; IODC dea=
llocated due to any reason",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_CHA_IODC_DEALLOC.ALL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.WRITE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.ANY",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.REMOTE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x91",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x2f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RSPI_WAS_FSE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc; Write Combining Aliasing",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.WC_ALIASING",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc; CV0 Prefetch Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.CV0_PREF_VIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cbo Misc; CV0 Prefetch Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.CV0_PREF_MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; MC0_SMI0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC0_SMI0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; MC1_SMI1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.MC1_SMI1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; EDC0_SMI2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.EDC0_SMI2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; EDC1_SMI3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.EDC1_SMI3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; EDC2_SMI4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.EDC2_SMI4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx READ Credits Empty; EDC3_SMI5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_CHA_READ_NO_CREDITS.EDC3_SMI5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "write requests from remote home agent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOPS_SENT.ALL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_SNOOPS_SENT.",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Broadcast or directed Snoops sen=
t for Local Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Broadcast or directed Snoops sen=
t for Remote Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOPS_SENT.BCST_LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_SNOOPS_SENT.BCST_LOC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOPS_SENT.BCST_REMOTE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_SNOOPS_SENT.BCST_REM",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOPS_SENT.DIRECT_LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_SNOOPS_SENT.DIRECT_LOC",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOPS_SENT.DIRECT_REMOTE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_SNOOPS_SENT.DIRECT_REM",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received : RspS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSP_WBWB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPFWD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPI",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPIFWD",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPIFWD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPSFWD",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPSFWD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSP_WB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSP_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSP_FWD_WB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSP_FWD_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPCNFLCT",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPCNFLCT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP_LOCAL.RSPFWD",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5D",
+        "EventName": "UNC_H_SNP_RSP_RCV_LOCAL.RSPFWD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.EVICT",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.PRQ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IPQ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.HIT",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.HIT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.MISS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.EVICT",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.PRQ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IPQ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.HIT",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.HIT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.MISS",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbPushMtoI; Pushed to LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_CHA_WB_PUSH_MTOI.LLC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbPushMtoI; Pushed to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_CHA_WB_PUSH_MTOI.MEM",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; MC0_SMI0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC0_SMI0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; MC1_SMI1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.MC1_SMI1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; EDC0_SMI2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.EDC0_SMI2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; EDC1_SMI3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.EDC1_SMI3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; EDC2_SMI4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.EDC2_SMI4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA iMC CHNx WRITE Credits Empty; EDC3_SMI5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_CHA_WRITE_NO_CREDITS.EDC3_SMI5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IO",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOC_IO",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_INSERTS.IA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOC_IA",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IO",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOC_IO",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IA",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOC_IA",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core PMA Events; C1  State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_CHA_CORE_PMA.C1_STATE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core PMA Events; C1 Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_CHA_CORE_PMA.C1_TRANSITION",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core PMA Events; C6 State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_CHA_CORE_PMA.C6_STATE",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core PMA Events; C6 Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_CHA_CORE_PMA.C6_TRANSITION",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core PMA Events; GV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_CHA_CORE_PMA.GV",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_CHA_AG0_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_CHA_AG0_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_CHA_AG0_BL_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_CHA_AG0_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_CHA_AG1_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_CHA_AG1_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_CHA_AG1_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_CHA_AG1_BL_CREDITS_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CMS_CLOCKTICKS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_H_CLOCK",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_CHA_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_CHA_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_CHA_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_CHA_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Left",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Right",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_CHA_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_CHA_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Data Responses to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_CHA_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; Acknowled=
gements to Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Acknowledge=
ments to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Data Respon=
ses to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Snoops of p=
rocessor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_CHA_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RING_SRC_THRTL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xA4",
+        "EventName": "UNC_C_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; IRQ Rejected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.PRQ_REJ",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; RRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.RRQ",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; WBQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.WBQ",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_IPQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x23",
+        "EventName": "UNC_H_RxC_IPQ1_REJECT.ANY_IPQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; LLC Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; SF Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; Merging these tw=
o together to make room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; Allow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; AD =
REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; AD =
RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_IRQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_RxC_IRQ1_REJECT.ANY_REJECT_IRQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; LLC=
 Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; SF =
Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Vic=
tim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Mer=
ging these two together to make room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; All=
ow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_ISMQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x25",
+        "EventName": "UNC_H_RxC_ISMQ1_REJECT.ANY_ISMQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_ISMQ1_RETRY.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2D",
+        "EventName": "UNC_H_RxC_ISMQ1_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy; IPQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy; RRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.RRQ",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy; WBQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.WBQ",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_OTHER1_RETRY.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_RxC_OTHER1_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; LLC Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; SF Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; Merging these two together to =
make room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; Allow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; AD =
REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; AD =
RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; BL =
NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_PRQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_RxC_PRQ1_REJECT.ANY_PRQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; LLC=
 Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; SF =
Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Vic=
tim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; LLC=
 OR SF Way",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; All=
ow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Phy=
Addr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_REQ_Q1_RETRY.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2B",
+        "EventName": "UNC_H_RxC_REQ_Q1_RETRY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; LLC Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; SF Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; Merging these two toge=
ther to make room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; Allow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_RRQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_RxC_RRQ1_REJECT.ANY_RRQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; LLC Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; SF Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; Merging these two together to ma=
ke room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; Allow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; AD REQ on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AD_REQ_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; AD RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AD_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; BL RSP on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_RSP_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; BL WB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_WB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; BL NCB on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_NCB_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; BL NCS on VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.BL_NCS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_WBQ1_REJECT.ANY0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_RxC_WBQ1_REJECT.ANY_WBQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; HA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.HA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; LLC Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.LLC_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; SF Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.SF_VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.VICTIM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; Merging these two together to ma=
ke room for ANY_REJECT_*0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.LLC_OR_SF_WAY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; Allow Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.ALLOW_SNP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_CHA_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_CHA_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; IFV - Credit=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_CHA_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_CHA_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_CHA_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_CHA_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_CHA_TxR_HORZ_ADS_USED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_CHA_TxR_HORZ_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
K - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; I=
V - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_FULL.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_CHA_TxR_HORZ_CYCLES_NE.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_CHA_TxR_HORZ_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_CHA_TxR_HORZ_NACK.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_CHA_TxR_HORZ_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
D - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
K - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; B=
L - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; I=
V - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_CHA_TxR_HORZ_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_CHA_TxR_VERT_ADS_USED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TxR_VERT_BYPASS.IV",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x9E",
+        "EventName": "UNC_H_TxR_VERT_BYPASS.IV_AG1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TxR_VERT_CYCLES_FULL.IV",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x92",
+        "EventName": "UNC_H_TxR_VERT_CYCLES_FULL.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TxR_VERT_CYCLES_NE.IV",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x93",
+        "EventName": "UNC_H_TxR_VERT_CYCLES_NE.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TxR_VERT_INSERTS.IV",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x91",
+        "EventName": "UNC_H_TxR_VERT_INSERTS.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_CHA_TxR_VERT_NACK.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TxR_VERT_OCCUPANCY.IV",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x90",
+        "EventName": "UNC_H_TxR_VERT_OCCUPANCY.IV_AG0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_CHA_TxR_VERT_STARVED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_CHA_VERT_RING_AD_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_CHA_VERT_RING_AK_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_CHA_VERT_RING_BL_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_VERT_RING_IV_IN_USE.UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_CHA_VERT_RING_IV_IN_USE.DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; External RspHitFS=
E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EXT_RSP_HITFSE",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Core RspHitFSE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.CORE_RSP_HITFSE",
+        "PerPkg": "1",
+        "UMask": "0x41",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Evict RspHitFSE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EVICT_RSP_HITFSE",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Any RspHitFSE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.ANY_RSP_HITFSE",
+        "PerPkg": "1",
+        "UMask": "0xE1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; External RspSFwdF=
E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EXT_RSPS_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x22",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Core RspSFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.CORE_RSPS_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x42",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Evict RspSFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EVICT_RSPS_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x82",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Any RspSFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.ANY_RSPS_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0xE2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; External RspIFwdF=
E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EXT_RSPI_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Core RspIFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.CORE_RSPI_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x44",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Evict RspIFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EVICT_RSPI_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0x84",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Any RspIFwdFE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.ANY_RSPI_FWDFE",
+        "PerPkg": "1",
+        "UMask": "0xE4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; External RspSFwdM=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EXT_RSPS_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Core RspSFwdM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.CORE_RSPS_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x48",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Evict RspSFwdM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EVICT_RSPS_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Any RspSFwdM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.ANY_RSPS_FWDM",
+        "PerPkg": "1",
+        "UMask": "0xE8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; External RspIFwdM=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EXT_RSPI_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Core RspIFwdM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.CORE_RSPI_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses; Evict RspIFwdM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.EVICT_RSPI_FWDM",
+        "PerPkg": "1",
+        "UMask": "0x90",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoop Responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_CHA_XSNP_RESP.ANY_RSPI_FWDM",
+        "PerPkg": "1",
+        "UMask": "0xF0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.RRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.RRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x60",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.WBQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x90",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.WBQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0xA0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.PRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.PRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; All from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; All from Local iA and IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL_IO_IA",
+        "PerPkg": "1",
+        "UMask": "0x35",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Hits from Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL_HIT",
+        "PerPkg": "1",
+        "UMask": "0x15",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses from Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL_MISS",
+        "PerPkg": "1",
+        "UMask": "0x25",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; All from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Hits from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Hits from Local",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL_HIT",
+        "PerPkg": "1",
+        "UMask": "0x17",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses from Local",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL_MISS",
+        "PerPkg": "1",
+        "UMask": "0x27",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; VNA Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.VNA",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; VN0 Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.VN0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; AD REQ Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; AD RSP VN0 Cr=
edits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; BL RSP Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; BL DRS Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; BL NCB Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credit Allocations; BL NCS Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_CHA_UPI_CREDITS_ACQUIRED.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; AD VNA Cre=
dits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VNA_AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; BL VNA Cre=
dits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VNA_BL",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; AD REQ VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; AD RSP VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; BL RSP VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; BL DRS VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UPI Ingress Credits In Use Cycles; BL NCB VN0=
 Credits",
+        "EventCode": "0x3B",
+        "EventName": "UNC_CHA_UPI_CREDIT_OCCUPANCY.VN0_BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; Non UPI AK Reque=
st",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; Non UPI IV Reque=
st",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_CHA_RxC_IPQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Non=
 UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Non=
 UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_CHA_RxC_IRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_CHA_RxC_ISMQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_CHA_RxC_ISMQ0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_CHA_RxC_OTHER0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Non=
 UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; Non=
 UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_CHA_RxC_PRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_CHA_RxC_REQ_Q0_RETRY.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_CHA_RxC_RRQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; Non UPI AK Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.AK_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; Non UPI IV Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_CHA_RxC_WBQ0_REJECT.IV_NON_UPI",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Request Queue Retries; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_CHA_RxC_REQ_Q1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Broadcast snoop for Local Reques=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.BCST_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Broadcast snoops for Remote Requ=
ests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.BCST_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Directed snoops for Local Reques=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.DIRECT_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoops Sent; Directed snoops for Remote Reque=
sts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_CHA_SNOOPS_SENT.DIRECT_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspIFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPIFWD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspSFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPSFWD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSP_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*FWD*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSP_FWD_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspCnflct",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPCNFLCT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5D",
+        "EventName": "UNC_CHA_SNOOP_RESP_LOCAL.RSPFWD",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_CHA_CMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Data Read Req=
uest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Write Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE",
+        "PerPkg": "1",
+        "UMask": "0x05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; External Snoo=
p Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNOOP",
+        "PerPkg": "1",
+        "UMask": "0x09",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Any Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache and Snoop Filter Lookups; Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x91",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.M_STATE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.E_STATE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.S_STATE",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.F_STATE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Local - All Lines",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "PerPkg": "1",
+        "UMask": "0x2F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; SF/LLC Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Hit (Not a Miss)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.HIT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.RRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x60",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.WBQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x90",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.WBQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0xA0",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; IRQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; SF/LLC Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; PRQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; IPQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Hit (Not a Miss)",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.HIT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_TOR_OCCUPANCY.ALL_FROM_LOC",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Deprecated": "1",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA4",
+        "EventName": "UNC_CHA_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress Probe Queue Rejects; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_CHA_RxC_IPQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; ANY=
0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Rejects; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_CHA_RxC_ISMQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_CHA_RxC_ISMQ1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Other Retries; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_CHA_RxC_OTHER1_RETRY.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; ANY=
0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_CHA_RxC_PRQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RRQ Rejects; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_CHA_RxC_RRQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBQ Rejects; ANY0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_CHA_RxC_WBQ1_REJECT.ANY0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_CHA_TxR_VERT_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_CHA_TxR_VERT_CYCLES_NE.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_CHA_TxR_VERT_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_CHA_TxR_VERT_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FaST wire asserted; Vertical",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_FAST_ASSERTED.VERT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Local - Lines in M State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Local - Lines in E State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "PerPkg": "1",
+        "UMask": "0x22",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Local - Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Local - Lines in F State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_F",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Remote - Lines in M State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_M",
+        "PerPkg": "1",
+        "UMask": "0x81",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Remote - Lines in E State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_E",
+        "PerPkg": "1",
+        "UMask": "0x82",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Remote - Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_S",
+        "PerPkg": "1",
+        "UMask": "0x84",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Remote - Lines in F State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_F",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Remote - All Lines",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "PerPkg": "1",
+        "UMask": "0x8F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; All from Local",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL_FROM_LOC",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; RdCur misses from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RDCUR",
+        "Filter": "config1=3D0x43C33",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; RFO misses from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; ItoM misses from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "Filter": "config1=3D0x49033",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy;  ITOM Misses from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "Filter": "config1=3D0x49033",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy;  RDCUR misses from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RDCUR",
+        "Filter": "config1=3D0x43C33",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy;  RFO misses from Local IO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts; Port 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.PORT0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts; Port 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.PORT1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts; Port 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.PORT2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIe Completion Buffer Inserts; Port 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.PORT3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num Link  Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_IIO_LINK_NUM_CORR_ERR",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Num Link Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_IIO_LINK_NUM_RETRIES",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number packets that passed the Mask/Match Fil=
ter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_IIO_MASK_MATCH",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus; Non-PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus; PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus; Non-PCIE bus an=
d !(PCIE bus)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus; Non-PCIE bus an=
d PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus; !(Non-PCIE bus)=
 and PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "AND Mask/match for debug bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_IIO_MASK_MATCH_AND.NOT_BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; Non-PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; Non-PCIE bus and=
 !(PCIE bus)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; Non-PCIE bus and=
 PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; !(Non-PCIE bus) =
and PCIE bus",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "OR Mask/match for debug bus; !(Non-PCIE bus) =
and !(PCIE bus)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_IIO_MASK_MATCH_OR.NOT_BUS0_NOT_BUS1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NOTHING",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_IIO_NOTHING",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMICCMP.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMICCMP.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMICCMP.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMICCMP.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART2",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART3",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Symbol Times on Link",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_IIO_SYMBOL_TIMES",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMICCMP.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMICCMP.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMICCMP.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMICCMP.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART3",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; Vtd hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.L4_PAGE_HIT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; context cache miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.CTXT_MISS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; L1 miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.L1_MISS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; L2 miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.L2_MISS",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; L3 miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.L3_MISS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; TLB miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.TLB_MISS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; TLB is full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.TLB_FULL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Access; TLB miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_VTD_ACCESS.TLB1_MISS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "VTd Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_VTD_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.ATOMIC.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MSG.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MSG.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.VTD0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.VTD1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.PEER_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.CFG_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_READ.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.IO_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.MEM_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.VTD0",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.VTD1",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_OUT.PEER_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.ATOMIC.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MEM_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.MSG.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_IN.PEER_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.CFG_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_READ.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.IO_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.MEM_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_READ.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.VTD0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.VTD0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.VTD1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_OUT.PEER_WRITE.VTD1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's PCICFG space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.CFG_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's IO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.IO_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core reading from =
Card's MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Core writing to Ca=
rd's MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Another card (diff=
erent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Another card (diff=
erent IIO stack) reading from this card",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Another card (diff=
erent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU; Another card (diff=
erent IIO stack) writing to this card",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Completion of atom=
ic requests targeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Completion of atom=
ic requests targeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Completion of atom=
ic requests targeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Completion of atom=
ic requests targeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMICCMP.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Atomic requests ta=
rgeting DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.ATOMIC.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card reading from =
DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card reading from =
DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card writing to DR=
AM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card writing to DR=
AM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Messages",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MSG.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card reading from =
another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card reading from =
another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card writing to an=
other Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU; Card writing to an=
other Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's IO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.IO_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e reading from Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's MMIO space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Ano=
ther card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Ano=
ther card (different IIO stack) reading from this card",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Ano=
ther card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Ano=
ther card (different IIO stack) writing to this card",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU; Cor=
e writing to Card's PCICFG space",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.CFG_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d writing to DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d writing to DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d writing to another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d reading from DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d reading from DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Car=
d reading from another Card (same or different stack)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Ato=
mic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMIC.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Com=
pletion of atomic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMICCMP.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Com=
pletion of atomic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMICCMP.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Com=
pletion of atomic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMICCMP.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Com=
pletion of atomic requests targeting DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.ATOMICCMP.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.VTD0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU; Mes=
sages",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MSG.VTD1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Snoops",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.IV_Q",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "IRP Clocks",
+        "Counter": "0,1",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIRdCur",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CRd",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.CRD",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; DRd",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.DRD",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; WbMtoI",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CLFlush",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF RF full",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_FAF_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF allocation -- sent to ADQ",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_FAF_TRANSACTIONS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "All Inserts Inbound (p2p + faf + cset)",
+        "Counter": "0,1",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_IRP_ALL.INBOUND_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "All Inserts Outbound (BL, AK, Snoops)",
+        "Counter": "0,1",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_IRP_ALL.OUTBOUND_INSERTS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0",
+        "Counter": "0,1",
+        "EventCode": "0x1C",
+        "EventName": "UNC_I_MISC0.UNKNOWN",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SLOW_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SLOW_E",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SLOW_M",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Lost Forward",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Invalid",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Valid",
+        "Counter": "0,1",
+        "EventCode": "0x1D",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Requests",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_P2P_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_P2P_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; P2P reads",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.RD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; P2P Writes",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.WR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; P2P Message",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.MSG",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; P2P completions",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.CMPL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; Match if remote only",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.REM",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; match if remote and target =
matches",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.REM_AND_TGT_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; match if local only",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.LOC",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "P2P Transactions; match if local and target m=
atches",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_P2P_TRANSACTIONS.LOC_AND_TGT_MATCH",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Miss",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit I",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit E or S",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit M",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpCode",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpData",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpInv",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Atomic",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Other",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x1A",
+        "EventName": "UNC_I_TxR2_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations",
+        "Counter": "0,1",
+        "EventCode": "0xB",
+        "EventName": "UNC_I_TxC_AK_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Cycles Full",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_TxC_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Inserts",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_TxC_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL DRS Egress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_TxC_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Cycles Full",
+        "Counter": "0,1",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_TxC_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Inserts",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_TxC_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCB Egress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_TxC_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Cycles Full",
+        "Counter": "0,1",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_TxC_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Inserts",
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_TxC_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL NCS Egress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_TxC_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x1B",
+        "EventName": "UNC_I_TxR2_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxS_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxS_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xC",
+        "EventName": "UNC_I_TxS_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit I li=
ne in the IIO cache",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit E or=
 S line in the IIO cache",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit M li=
ne in the IIO cache",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that hit M, E=
, S or I line in the IIO",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT",
+        "PerPkg": "1",
+        "UMask": "0x7e",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Responses to snoops of any type that miss the=
 IIO cache",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AD_VNA_EQ2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.BL_VNA_EQ0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_UPI_M3_BYP_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.BGF_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_UPI_M3_BYP_BLOCKED.BGF_CRD",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_BYP_BLOCKED.GV_BLOCK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_UPI_M3_BYP_BLOCKED.GV_BLOCK",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_CRD_RETURN_BLOCKED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_UPI_M3_CRD_RETURN_BLOCKED",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_LE2",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_BTW_2_THR=
ESH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AD_VNA_BTW_2_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_EQ0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_BTW_0_THR=
ESH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_BL_VNA_BTW_0_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.FLOWQ_AK_VNA_LE3",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.BGF_CRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.BGF_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_M3_RXQ_BLOCKED.GV_BLOCK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_UPI_M3_RXQ_BLOCKED.GV_BLOCK",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles where phy is not in L0, L0c, L0p, L1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_UPI_PHY_INIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "L1 Req Nack",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_UPI_POWER_L1_NACK",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "L1 Req (same as L1 Ack)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_UPI_POWER_L1_REQ",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VNA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VN0",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.VN1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_REQ_SLOT2_FROM_M3.ACK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_UPI_REQ_SLOT2_FROM_M3.ACK",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0. Receive side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_UPI_RxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_UPI_RxL_CRC_ERRORS",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "LLR Requests Sent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_UPI_RxL_CRC_LLR_REQ_TRANSMIT",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VN0",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VN1",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_UPI_RxL_CREDITS_CONSUMED_VNA",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.DATA",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; LLCRD Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; LLCTRL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_FLITS.PROTHDR",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.PROT_HDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.RSP",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets; Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets; Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets; Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S0_RXQ2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ0",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S1_RXQ2",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_UPI_RxL_SLOT_BYPASS.S2_RXQ1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.CFG_CTL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.CFG_CTL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_BYPASS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_BYPASS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_CRED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RXQ_CRED",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.TXQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.TXQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.RETRY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.RETRY",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.DFX",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.DFX",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_CLK_ACTIVE.SPARE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_UPI_TxL0P_CLK_ACTIVE.SPARE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0. Transmit side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_UPI_TxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; LLCRD Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; LLCTRL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_FLITS.PROTHDR",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.PROT_HDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_UPI_TxL_INSERTS",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_UPI_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_VNA_CREDIT_RETURN_BLOCKED_VN01",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_UPI_VNA_CREDIT_RETURN_BLOCKED_VN01",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "UNC_UPI_VNA_CREDIT_RETURN_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ3",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Protocol Header",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Protocol Header",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_UPI_FLOWQ_NO_VNA_CRD.AK_VNA_EQ2",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.LOC",
+        "PerPkg": "1",
+        "UMaskExt": "0x02",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.REM",
+        "PerPkg": "1",
+        "UMaskExt": "0x04",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.DATA_HDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x08",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.NON_DATA_HDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x10",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.DUAL_SLOT_HDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x20",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.SGL_SLOT_HDR",
+        "PerPkg": "1",
+        "UMaskExt": "0x40",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.RSP_NODATA",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_HDR_MATCH.RSP_DATA",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Received; Idle",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Reques=
t",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Reques=
t Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ_OPC",
+        "PerPkg": "1",
+        "UMask": "0x0108",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Snoop",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x09",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Snoop =
Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP_OPC",
+        "PerPkg": "1",
+        "UMask": "0x0109",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "PerPkg": "1",
+        "UMask": "0x0A",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x010A",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
+        "PerPkg": "1",
+        "UMask": "0x0C",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x010C",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Writeb=
ack",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0x0D",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Writeb=
ack",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x010D",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Non-Co=
herent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0x0E",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Non-Co=
herent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x010E",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Non-Co=
herent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0x0F",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Non-Co=
herent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
+        "PerPkg": "1",
+        "UMask": "0x010F",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Reque=
st",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Reque=
st Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ_OPC",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Snoop=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
+        "PerPkg": "1",
+        "UMask": "0x09",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Snoop=
 Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP_OPC",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "PerPkg": "1",
+        "UMask": "0x0A",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10A",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
+        "PerPkg": "1",
+        "UMask": "0x0C",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10C",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Write=
back",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0x0D",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Write=
back",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10D",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Non-C=
oherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "PerPkg": "1",
+        "UMask": "0x0E",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Non-C=
oherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10E",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Non-C=
oherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "PerPkg": "1",
+        "UMask": "0x0F",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Non-C=
oherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
+        "PerPkg": "1",
+        "UMask": "0x10F",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "PerPkg": "1",
+        "UMask": "0x01AA",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port; Respon=
se - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x012A",
+        "UMaskExt": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations; Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations; Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations; Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "PerPkg": "1",
+        "UMask": "0x1AA",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port; Respo=
nse - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPI",
+        "PerPkg": "1",
+        "UMask": "0x12A",
+        "UMaskExt": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M2M_BYPASS_M2M_Egress.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles - at UCLK",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M2M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On Dirty Line in L State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_P",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.DIRTY_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_I",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_S",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_P",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Hit; On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M2M_DIRECTORY_HIT.CLEAN_A",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_I",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_S",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On Dirty Line in L State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_P",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.DIRTY_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_I",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_S",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On NonDirty Line in L State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_P",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Directory Miss; On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M2M_DIRECTORY_MISS.CLEAN_A",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC; Critical Priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Reads Issued to iMC; All, regardless of p=
riority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.FROM_TRANSGRESS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; Full Line Non-ISOCH=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; ISOCH Full Line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FULL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; ISOCH Partial",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; All, regardless of =
priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.FROM_TRANSGRESS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number Packet Header Matches; Mesh Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M2M_PKT_MATCH.MESH",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number Packet Header Matches; MC Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M2M_PKT_MATCH.MC",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_M2M_PREFCAM_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_M2M_PREFCAM_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number AD Ingress Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M2M_TGR_AD_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number BL Ingress Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_M2M_TGR_BL_CREDITS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_FULL.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_FULL.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_FULL.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_NE.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_NE.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M2M_TRACKER_CYCLES_NE.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Inserts; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Inserts; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Inserts; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "UNC_M2M_TRACKER_INSERTS.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M2M_TRACKER_OCCUPANCY.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Data Pending Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "UNC_M2M_TRACKER_PENDING_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN0",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN1",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN2",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_FULL.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_FULL.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Full; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_FULL.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_NE.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_NE.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Cycles Not Empty; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M2M_WRITE_TRACKER_CYCLES_NE.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_M2M_WRITE_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_M2M_WRITE_TRACKER_INSERTS.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_M2M_WRITE_TRACKER_INSERTS.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_M2M_WRITE_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_M2M_WRITE_TRACKER_OCCUPANCY.CH1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write Tracker Occupancy; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_M2M_WRITE_TRACKER_OCCUPANCY.CH2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M2M_AG0_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M2M_AG0_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M2M_AG0_BL_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M2M_AG0_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M2M_AG1_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M2M_AG1_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M2M_AG1_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M2M_AG1_BL_CREDITS_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAE",
+        "EventName": "UNC_M2M_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M2M_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M2M_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M2M_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Left",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Right",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M2M_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M2M_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Acknowledgements to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Data Responses to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Snoops of processor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M2M_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; Acknowled=
gements to Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Acknowledge=
ments to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Data Respon=
ses to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Snoops of p=
rocessor's cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M2M_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M2M_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M2M_RxC_AD_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_M2M_RxC_AD_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M2M_RxC_BL_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M2M_RxC_BL_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M2M_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M2M_RxR_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; IFV - Credit=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.IFV",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M2M_RxR_CRD_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M2M_RxR_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M2M_RxR_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M2M_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Credits Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_M2M_TxC_AD_CREDIT_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Credit Acquired",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_M2M_TxC_AD_CREDITS_ACQUIRED",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_M2M_TxC_AD_CYCLES_FULL",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_M2M_TxC_AD_CYCLES_NE",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AD Egress (to CMS) Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_M2M_TxC_AD_NO_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AD Egress (to CMS) Cre=
dits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M2M_TxC_AD_NO_CREDIT_STALLED",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound Ring Transactions on AK; CRD Transac=
tions to Cbo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_M2M_TxC_AK.CRD_CBO",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound Ring Transactions on AK; NDR Transac=
tions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_M2M_TxC_AK.NDR",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credits Occupancy; Common =
Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M2M_TxC_AK_CREDIT_OCCUPANCY.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credits Occupancy; Common =
Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M2M_TxC_AK_CREDIT_OCCUPANCY.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credit Acquired; Common Me=
sh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M2M_TxC_AK_CREDITS_ACQUIRED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Credit Acquired; Common Me=
sh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M2M_TxC_AK_CREDITS_ACQUIRED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AK Egress (to CMS) Credits; Co=
mmon Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_CYCLES.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No AK Egress (to CMS) Credits; Co=
mmon Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_CYCLES.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AK Egress (to CMS) Cre=
dits; Common Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_STALLED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No AK Egress (to CMS) Cre=
dits; Common Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M2M_TxC_AK_NO_CREDIT_STALLED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2M_TxC_BL.DRS_CACHE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2M_TxC_BL.DRS_CORE",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credits Occupancy; Common =
Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M2M_TxC_BL_CREDIT_OCCUPANCY.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credits Occupancy; Common =
Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_M2M_TxC_BL_CREDIT_OCCUPANCY.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credit Acquired; Common Me=
sh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2M_TxC_BL_CREDITS_ACQUIRED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Credit Acquired; Common Me=
sh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_M2M_TxC_BL_CREDITS_ACQUIRED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full; Common Mesh Stop - N=
ear Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Full; Common Mesh Stop - F=
ar Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_FULL.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty; Common Mesh Sto=
p - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Not Empty; Common Mesh Sto=
p - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M2M_TxC_BL_CYCLES_NE.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations; Common Mesh S=
top - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations; Common Mesh S=
top - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No BL Egress (to CMS) Credits; Co=
mmon Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_CYCLES.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles with No BL Egress (to CMS) Credits; Co=
mmon Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_CYCLES.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No BL Egress (to CMS) Cre=
dits; Common Mesh Stop - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_STALLED.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with No BL Egress (to CMS) Cre=
dits; Common Mesh Stop - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M2M_TxC_BL_NO_CREDIT_STALLED.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Occupancy; Common Mesh Sto=
p - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Occupancy; Common Mesh Sto=
p - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M2M_TxR_HORZ_ADS_USED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Bypass Used; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M2M_TxR_HORZ_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
K - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; I=
V - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x96",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_FULL.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x97",
+        "EventName": "UNC_M2M_TxR_HORZ_CYCLES_NE.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Inserts; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x95",
+        "EventName": "UNC_M2M_TxR_HORZ_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x99",
+        "EventName": "UNC_M2M_TxR_HORZ_NACK.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AK - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Credit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Occupancy; IV - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x94",
+        "EventName": "UNC_M2M_TxR_HORZ_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
D - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
K - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; B=
L - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; I=
V - Bounce",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M2M_TxR_HORZ_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M2M_TxR_VERT_ADS_USED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical ADS Used; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M2M_TxR_VERT_BYPASS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x92",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_FULL.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x93",
+        "EventName": "UNC_M2M_TxR_VERT_CYCLES_NE.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M2M_TxR_VERT_INSERTS.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Occupancy; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M2M_TxR_VERT_OCCUPANCY.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.AD_AG1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.AK_AG0",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.BL_AG1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M2M_VERT_RING_AD_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical AK Ring In Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M2M_VERT_RING_AK_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Down and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.DN_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.UP_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical BL Ring in Use; Up and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M2M_VERT_RING_BL_IN_USE.UP_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_VERT_RING_IV_IN_USE.DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Vertical IV Ring in Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M2M_VERT_RING_IV_IN_USE.UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_M2M_TxC_BL.DRS_UPI",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x40",
+        "EventName": "UNC_NoUnit_TxC_BL.DRS_UPI",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Special; Ch=
annel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Special; Ch=
annel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Special; Ch=
annel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "UNC_M2M_RPQ_CYCLES_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_M2M_TxC_BL.DRS_UPI",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress NACKs; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x98",
+        "EventName": "UNC_M2M_TxR_VERT_NACK.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M2M_TxR_VERT_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Regular; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M2M_WPQ_CYCLES_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_BYPASS_M2M_INGRESS.TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC Bypass; Not Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M2M_BYPASS_M2M_INGRESS.NOT_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M2M_CMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_CYCLES_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_CYCLES_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M->iMC WPQ Cycles w/Credits - Special; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M2M_WPQ_CYCLES_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "FaST wire asserted; Vertical",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_FAST_ASSERTED.VERT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "FaST wire asserted; Horizontal",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M2M_FAST_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Regular; Ch=
annel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M2M_RPQ_CYCLES_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Regular; Ch=
annel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M2M_RPQ_CYCLES_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M to iMC RPQ Cycles w/Credits - Regular; Ch=
annel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M2M_RPQ_CYCLES_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Common Mesh Stop - N=
ear Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Common Mesh Stop - F=
ar Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Read Credit Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.RDCRD0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Write Credit Request=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCRD0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Write Compare Reques=
t",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCMP0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Read Credit Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.RDCRD1",
+        "PerPkg": "1",
+        "UMask": "0x88",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Write Credit Request=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCRD1",
+        "PerPkg": "1",
+        "UMask": "0x90",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; Write Compare Reques=
t",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.WRCMP1",
+        "PerPkg": "1",
+        "UMask": "0xA0",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; Common Mesh Sto=
p - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; Common Mesh Sto=
p - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; Read Credit Req=
uest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; Write Credit Re=
quest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; Write Compare R=
equest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_M2M_TxC_AK_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Common Mesh S=
top - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Common Mesh S=
top - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Read Credit R=
equest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Write Credit =
Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Write Compare=
 Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; Prefetch Read=
 Cam Hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.PREF_RD_CAM_HIT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M2M_TxC_AK_INSERTS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; Common Mesh Sto=
p - Near Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.CMS0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; Common Mesh Sto=
p - Far Side",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.CMS1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; Read Credit Req=
uest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.RDCRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; Write Credit Re=
quest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.WRCRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; Write Compare R=
equest",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.WRCMP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_M2M_TxC_AK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Sideband",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_M2M_TxC_AK_SIDEBAND.RD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AK Egress (to CMS) Sideband",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_M2M_TxC_AK_SIDEBAND.WR",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VNA",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 AD Credits Empty; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x20",
+        "EventName": "UNC_M3UPI_UPI_PEER_AD_CREDITS_EMPTY.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 BL Credits Empty; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 BL Credits Empty; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN1_NCS_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UPI0 BL Credits Empty; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Peer UPI0 on VN0",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN0_PEER_UPI0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Peer UPI1 on VN0",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN0_PEER_UPI1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Peer UPI0 on VN1",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN1_PEER_UPI0",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Peer UPI1 on VN1",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN1_PEER_UPI1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty; VNA Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x22",
+        "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty; Writebacks",
+        "Counter": "0,1,2",
+        "EventCode": "0x22",
+        "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.WB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty; Requests",
+        "Counter": "0,1,2",
+        "EventCode": "0x22",
+        "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.REQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty; Snoops",
+        "Counter": "0,1,2",
+        "EventCode": "0x22",
+        "EventName": "UNC_M3UPI_CHA_AD_CREDITS_EMPTY.SNP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2",
+        "EventCode": "0x1",
+        "EventName": "UNC_M3UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "D2U Sent",
+        "Counter": "0,1,2",
+        "EventCode": "0x2A",
+        "EventName": "UNC_M3UPI_D2U_SENT",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; IIO0 and IIO1 share the =
same ring destination. (1 VN0 credit only)",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO0_IIO1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; IIO2",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO2_NCB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; IIO3",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO3_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; IIO4",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO4_NCB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; IIO5",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.IIO5_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; All IIO targets for NCS =
are in single mask. ORs them together",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "M2 BL Credits Empty; Selected M2p BL NCS cred=
its",
+        "Counter": "0,1,2",
+        "EventCode": "0x23",
+        "EventName": "UNC_M3UPI_M2_BL_CREDITS_EMPTY.NCS_SEL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; AD - Slot 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; AD - Slot 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; AD - Slot 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AD_SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; BL - Slot 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.BL_SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; AK - Slot 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AK_SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Multi Slot Flit Received; AK - Slot 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x3E",
+        "EventName": "UNC_M3UPI_MULTI_SLOT_RCVD.AK_SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for AD; VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x30",
+        "EventName": "UNC_M3UPI_TxC_AD_ARB_FAIL.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.AD_SLOT2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD FlowQ Bypass",
+        "Counter": "0,1,2",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_BYPASS.BL_EARLY_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Not Empty; VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x27",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_CYCLES_NE.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Inserts; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_INSERTS.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN0 REQ Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN0 SNP Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN0 RSP Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN0 WB Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN1 REQ Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN1 SNP Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AD Flow Q Occupancy; VN1 RSP Messages",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M3UPI_TxC_AD_FLQ_OCCUPANCY.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  -  Credit Available; =
VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x34",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_CRD_AVAIL.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN0 RE=
Q Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN0 SN=
P Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN0 WB=
 Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN1 RE=
Q Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN1 SN=
P Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - New Message; VN1 WB=
 Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x33",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NEW_MSG.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN0 REQ =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN0 SNP =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN0 RSP =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN0 WB M=
essages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN1 REQ =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN1 SNP =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN1 RSP =
Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD  - No Credit; VN1 WB M=
essages",
+        "Counter": "0,1,2",
+        "EventCode": "0x32",
+        "EventName": "UNC_M3UPI_TxC_AD_SPEC_ARB_NO_OTHER_PEND.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AK Flow Q Inserts",
+        "Counter": "0,1,2",
+        "EventCode": "0x2F",
+        "EventName": "UNC_M3UPI_TxC_AK_FLQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "AK Flow Q Occupancy",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M3UPI_TxC_AK_FLQ_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN0 NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN0 NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN1 NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Failed ARB for BL; VN1 NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x35",
+        "EventName": "UNC_M3UPI_TxC_BL_ARB_FAIL.VN1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN1 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN1 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_SNP",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Not Empty; VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x28",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_CYCLES_NE.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN0 NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN0 NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN1_NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN1_NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Inserts; VN1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_INSERTS.VN1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN0 RSP Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN0 WB Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN0 NCB Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN0 NCS Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN1 RSP Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN1 WB Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN1_NCS Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "BL Flow Q Occupancy; VN1_NCB Messages",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M3UPI_TxC_BL_FLQ_OCCUPANCY.VN1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN0 WB=
 Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN0 WB=
 Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN0 NC=
S Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN1 RS=
P Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN1 WB=
 Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for BL  - New Message; VN1 NC=
B Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x38",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NEW_MSG.VN1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN0_RSP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
0 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN0_WB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
0 NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN0_NCB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
0 NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN0_NCS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
1 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN1_RSP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
1 WB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN1_WB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
1 NCS Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN1_NCB",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Speculative ARB for AD Failed - No Credit; VN=
1 NCB Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x37",
+        "EventName": "UNC_M3UPI_TxC_BL_SPEC_ARB_NO_OTHER_PEND.VN1_NCS",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5C",
+        "EventName": "UNC_M3UPI_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 No Credits; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5E",
+        "EventName": "UNC_M3UPI_VN0_NO_CREDITS.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5D",
+        "EventName": "UNC_M3UPI_VN1_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.WB",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.NCB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 No Credits; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x5F",
+        "EventName": "UNC_M3UPI_VN1_NO_CREDITS.NCS",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; CHA on VN0",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN0_CHA",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; CHA on VN1",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN1_CHA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Non Idle cycles on V=
N0",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN0_NON_IDLE",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Number of Snoop Targets; Non Idle cycles on V=
N1",
+        "EventCode": "0x3C",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP1_VN1.VN1_NON_IDLE",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Snoop Arbitration; FlowQ Won",
+        "Counter": "0,1,2",
+        "EventCode": "0x3D",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP2_VN1.VN0_SNPFP_NONSNP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Snoop Arbitration; FlowQ Won",
+        "Counter": "0,1,2",
+        "EventCode": "0x3D",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP2_VN1.VN1_SNPFP_NONSNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Snoop Arbitration; FlowQ SnpF Won",
+        "Counter": "0,1,2",
+        "EventCode": "0x3D",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP2_VN1.VN0_SNPFP_VN2SNP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Snoop Arbitration; FlowQ SnpF Won",
+        "Counter": "0,1,2",
+        "EventCode": "0x3D",
+        "EventName": "UNC_M3UPI_TxC_AD_SNPF_GRP2_VN1.VN1_SNPFP_VN0SNP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x80",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x82",
+        "EventName": "UNC_M3UPI_AG0_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x88",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent0 BL Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x8A",
+        "EventName": "UNC_M3UPI_AG0_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x84",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 AD Credits Occupancy; For Transgre=
ss 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x86",
+        "EventName": "UNC_M3UPI_AG1_AD_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 0",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 1",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR1",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.NO_SNP",
         "UMask": "0x2",
-        "Unit": "CHA"
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 2",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 3",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 4",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Occupancy; For Transgre=
ss 5",
+        "EventCode": "0x8E",
+        "EventName": "UNC_M3UPI_AG1_BL_CRD_OCCUPANCY.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 3",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Agent1 BL Credits Acquired; For Transgres=
s 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x8C",
+        "EventName": "UNC_M3UPI_AG1_BL_CREDITS_ACQUIRED.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Clockticks",
+        "Counter": "0,1,2",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M3UPI_CMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Up",
+        "Counter": "0,1,2",
+        "EventCode": "0xAE",
+        "EventName": "UNC_M3UPI_EGRESS_ORDERING.IV_SNOOPGO_UP",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Egress Blocking due to Ordering requirements;=
 Down",
+        "Counter": "0,1,2",
+        "EventCode": "0xAE",
+        "EventName": "UNC_M3UPI_EGRESS_ORDERING.IV_SNOOPGO_DN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M3UPI_HORZ_RING_AD_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Left and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M3UPI_HORZ_RING_AD_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M3UPI_HORZ_RING_AD_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AD Ring In Use; Right and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M3UPI_HORZ_RING_AD_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M3UPI_HORZ_RING_AK_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Left and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M3UPI_HORZ_RING_AK_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M3UPI_HORZ_RING_AK_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal AK Ring In Use; Right and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA9",
+        "EventName": "UNC_M3UPI_HORZ_RING_AK_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M3UPI_HORZ_RING_BL_IN_USE.LEFT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Left and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M3UPI_HORZ_RING_BL_IN_USE.LEFT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M3UPI_HORZ_RING_BL_IN_USE.RIGHT_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal BL Ring in Use; Right and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xAB",
+        "EventName": "UNC_M3UPI_HORZ_RING_BL_IN_USE.RIGHT_ODD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Left",
+        "Counter": "0,1,2",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M3UPI_HORZ_RING_IV_IN_USE.LEFT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Horizontal IV Ring in Use; Right",
+        "Counter": "0,1,2",
+        "EventCode": "0xAD",
+        "EventName": "UNC_M3UPI_HORZ_RING_IV_IN_USE.RIGHT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AD",
+        "Counter": "0,1,2",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; AK",
+        "Counter": "0,1,2",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; BL",
+        "Counter": "0,1,2",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Horizontal Ring.=
; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
AD",
+        "Counter": "0,1,2",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Acknowledgements to core",
+        "Counter": "0,1,2",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Data Responses to core",
+        "Counter": "0,1,2",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Messages that bounced on the Vertical Ring.; =
Snoops of processor's cache",
+        "Counter": "0,1,2",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M3UPI_RING_BOUNCES_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AD",
+        "Counter": "0,1,2",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_HORZ.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; AK",
+        "Counter": "0,1,2",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_HORZ.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; BL",
+        "Counter": "0,1,2",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_HORZ.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_HORZ.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Horizontal Ring; Acknowled=
gements to Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0xA3",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_HORZ.AK_AG1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; AD",
+        "Counter": "0,1,2",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_VERT.AD",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Acknowledge=
ments to core",
+        "Counter": "0,1,2",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_VERT.AK",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Data Respon=
ses to core",
+        "Counter": "0,1,2",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_VERT.BL",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sink Starvation on Vertical Ring; Snoops of p=
rocessor's cache",
+        "Counter": "0,1,2",
+        "EventCode": "0xA2",
+        "EventName": "UNC_M3UPI_RING_SINK_STARVED_VERT.IV",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Source Throttle",
+        "Counter": "0,1,2",
+        "EventCode": "0xA4",
+        "EventName": "UNC_M3UPI_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN0; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4B",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Lost Arb for VN1; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4C",
+        "EventName": "UNC_M3UPI_RxC_ARB_LOST_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; Parallel Bias to VN0",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.PAR_BIAS_VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; Parallel Bias to VN1",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.PAR_BIAS_VN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; No Progress on Pending AD =
VN0",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.NO_PROG_AD_VN0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; No Progress on Pending AD =
VN1",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.NO_PROG_AD_VN1",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; No Progress on Pending BL =
VN0",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.NO_PROG_BL_VN0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; No Progress on Pending BL =
VN1",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.NO_PROG_BL_VN1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Arb Miscellaneous; AD, BL Parallel Win",
+        "Counter": "0,1,2",
+        "EventCode": "0x4D",
+        "EventName": "UNC_M3UPI_RxC_ARB_MISC.ADBL_PARALLEL_WIN",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN0; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x49",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Can't Arb for VN1; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4A",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOAD_REQ_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN0; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x47",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "No Credits to Arb for VN1; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x48",
+        "EventName": "UNC_M3UPI_RxC_ARB_NOCRED_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Ingress Queue Bypasses; AD to Slot 0 on Idle",
+        "Counter": "0,1,2",
+        "EventCode": "0x40",
+        "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S0_IDLE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Ingress Queue Bypasses; AD to Slot 0 on BL Ar=
b",
+        "Counter": "0,1,2",
+        "EventCode": "0x40",
+        "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S0_BL_ARB",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Ingress Queue Bypasses; AD + BL to Slot 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x40",
+        "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S1_BL_SLOT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Ingress Queue Bypasses; AD + BL to Slot 2",
+        "Counter": "0,1,2",
+        "EventCode": "0x40",
+        "EventName": "UNC_M3UPI_RxC_BYPASSED.AD_S2_BL_SLOT",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message lost contest for flit; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x50",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message lost contest for flit; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x51",
+        "EventName": "UNC_M3UPI_RxC_COLLISION_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Miscellaneous Credit Events; Any In BGF FIFO",
+        "Counter": "0,1,2",
+        "EventCode": "0x60",
+        "EventName": "UNC_M3UPI_RxC_CRD_MISC.ANY_BGF_FIFO",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Miscellaneous Credit Events; Any in BGF Path",
+        "Counter": "0,1,2",
+        "EventCode": "0x60",
+        "EventName": "UNC_M3UPI_RxC_CRD_MISC.ANY_BGF_PATH",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Miscellaneous Credit Events; No D2K For Arb",
+        "Counter": "0,1,2",
+        "EventCode": "0x60",
+        "EventName": "UNC_M3UPI_RxC_CRD_MISC.NO_D2K_FOR_ARB",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy; VNA In Use",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.VNA_IN_USE",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy; Packets in BGF FIFO",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.FLITS_IN_FIFO",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy; Packets in BGF Path",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.FLITS_IN_PATH",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy; Transmit Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.TxQ_CRD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy; D2K Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.D2K_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.P1P_TOTAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Credit Occupancy",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_M3UPI_RxC_CRD_OCC.P1P_FIFO",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Cycles Not Emp=
ty; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x43",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Cycles Not Emp=
ty; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x44",
+        "EventName": "UNC_M3UPI_RxC_CYCLES_NE_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Data Flit Not Sent; All",
+        "Counter": "0,1,2",
+        "EventCode": "0x57",
+        "EventName": "UNC_M3UPI_RxC_FLITS_DATA_NOT_SENT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Data Flit Not Sent; No BGF Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x57",
+        "EventName": "UNC_M3UPI_RxC_FLITS_DATA_NOT_SENT.NO_BGF",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Data Flit Not Sent; No TxQ Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x57",
+        "EventName": "UNC_M3UPI_RxC_FLITS_DATA_NOT_SENT.NO_TXQ",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence; Wait on Pum=
p 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P0_WAIT",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence; Wait on Pum=
p 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1_WAIT",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1P_TO_LIMBO",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1P_BUSY",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1P_AT_LIMIT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1P_HOLD_P0",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Generating BL Data Flit Sequence",
+        "Counter": "0,1,2",
+        "EventCode": "0x59",
+        "EventName": "UNC_M3UPI_RxC_FLITS_GEN_BL.P1P_FIFO_FULL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "UNC_M3UPI_RxC_FLITS_MISC",
+        "Counter": "0,1,2",
+        "EventCode": "0x5A",
+        "EventName": "UNC_M3UPI_RxC_FLITS_MISC",
+        "PerPkg": "1",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sent Header Flit; One Message",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.1_MSG",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sent Header Flit; Two Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.2_MSGS",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sent Header Flit; Three Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.3_MSGS",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Sent Header Flit; One Message in non-VNA",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.1_MSG_VNX",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; All",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Needs D=
ata Flit",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.NEED_DATA",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Wait on=
 Pump 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.P0_WAIT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Wait on=
 Pump 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.P1_WAIT",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Don't N=
eed Pump 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.P1_NOT_REQ",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Don't N=
eed Pump 1 - Bubble",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.P1_NOT_REQ_BUT_BUBBLE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Slotting BL Message Into Header Flit; Don't N=
eed Pump 1 - Not Avail",
+        "Counter": "0,1,2",
+        "EventCode": "0x58",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SLOT_BL.P1_NOT_REQ_NOT_AVAIL",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Acumullate",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.ACCUM",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Accumulate Ready",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.ACCUM_READ",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Accumulate Wasted",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.ACCUM_WASTED",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Run-Ahead - Blocked",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.AHEAD_BLOCKED",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Run-Ahead - Message",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.AHEAD_MSG",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Parallel Ok",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.PAR",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Parallel Message",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.PAR_MSG",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 1; Parallel Flit Finished",
+        "Counter": "0,1,2",
+        "EventCode": "0x53",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR1.PAR_FLIT",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 2; Rate-matching Stall",
+        "Counter": "0,1,2",
+        "EventCode": "0x54",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR2.RMSTALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Flit Gen - Header 2; Rate-matching Stall - No=
 Message",
+        "Counter": "0,1,2",
+        "EventCode": "0x54",
+        "EventName": "UNC_M3UPI_RxC_FLIT_GEN_HDR2.RMSTALL_NOMSG",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; All",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; No BGF Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.NO_BGF_CRD",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; No TxQ Credits",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.NO_TXQ_CRD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; No BGF Credits + No Extra Me=
ssage Slotted",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.NO_BGF_NO_MSG",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; No TxQ Credits + No Extra Me=
ssage Slotted",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.NO_TXQ_NO_MSG",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; Sent - One Slot Taken",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.ONE_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; Sent - Two Slots Taken",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.TWO_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Header Not Sent; Sent - Three Slots Taken",
+        "Counter": "0,1,2",
+        "EventCode": "0x55",
+        "EventName": "UNC_M3UPI_RxC_FLIT_NOT_SENT.THREE_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; VN0",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.VN0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; VN1",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.VN1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Parallel Attempt",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_ATTEMPT",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Parallel Success",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_SUCCESS",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Parallel AD Lost",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_AD_LOST",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Parallel BL Lost",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.PARALLEL_BL_LOST",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Can't Slot AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.CANT_SLOT_AD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Message Held; Can't Slot BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x52",
+        "EventName": "UNC_M3UPI_RxC_HELD.CANT_SLOT_BL",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; REQ o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; SNP o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; RSP o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; RSP o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; WB on=
 BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; NCB o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Inserts; NCS o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x41",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; REQ o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; SNP o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; RSP o=
n AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; RSP o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; WB on=
 BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; NCB o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Inserts; NCS o=
n BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x42",
+        "EventName": "UNC_M3UPI_RxC_INSERTS_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; REQ=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; SNP=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; RSP=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; RSP=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; WB =
on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; NCB=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 Ingress (from CMS) Queue - Occupancy; NCS=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x45",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; REQ=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; SNP=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; RSP=
 on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; RSP=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; WB =
on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; NCB=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 Ingress (from CMS) Queue - Occupancy; NCS=
 on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x46",
+        "EventName": "UNC_M3UPI_RxC_OCCUPANCY_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN0 message can't slot into flit; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4E",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN0.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; REQ on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_REQ",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; SNP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_SNP",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; RSP on AD",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.AD_RSP",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; RSP on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_RSP",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; WB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_WB",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; NCB on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_NCB",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "VN1 message can't slot into flit; NCS on BL",
+        "Counter": "0,1,2",
+        "EventCode": "0x4F",
+        "EventName": "UNC_M3UPI_RxC_PACKING_MISS_VN1.BL_NCS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "SMI3 Prefetch Messages; Arrived",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_M3UPI_RxC_SMI3_PFTCH.ARRIVED",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "SMI3 Prefetch Messages; Lost Arbitration",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_M3UPI_RxC_SMI3_PFTCH.ARB_LOST",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "SMI3 Prefetch Messages; Slotted",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_M3UPI_RxC_SMI3_PFTCH.SLOTTED",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "SMI3 Prefetch Messages; Dropped - Old",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_M3UPI_RxC_SMI3_PFTCH.DROP_OLD",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "SMI3 Prefetch Messages; Dropped - Wrap",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_M3UPI_RxC_SMI3_PFTCH.DROP_WRAP",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Used",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.USED",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Corrected",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.CORRECTED",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Level &lt; 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.LT1",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Level &lt; 4",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.LT4",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Level &lt; 5",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.LT5",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Remote VNA Credits; Any In Use",
+        "Counter": "0,1,2",
+        "EventCode": "0x5B",
+        "EventName": "UNC_M3UPI_RxC_VNA_CRD.ANY_IN_USE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M3UPI_RxR_BUSY_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M3UPI_RxR_BUSY_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M3UPI_RxR_BUSY_STARVED.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M3UPI_RxR_BUSY_STARVED.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Bypass; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M3UPI_RxR_BYPASS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Injection Starvation; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.SNP",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x53",
-        "EventName": "UNC_H_DIR_LOOKUP.SNP",
+        "BriefDescription": "Transgress Injection Starvation; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.SNP",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.HA",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x54",
-        "EventName": "UNC_H_DIR_UPDATE.HA",
+        "BriefDescription": "Transgress Injection Starvation; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.HA",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.TOR",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x54",
-        "EventName": "UNC_H_DIR_UPDATE.TOR",
+        "BriefDescription": "Transgress Injection Starvation; IFV - Credit=
",
+        "Counter": "0,1,2",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M3UPI_RxR_CRD_STARVED.IFV",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.TOR",
-        "UMask": "0x2",
-        "Unit": "CHA"
+        "UMask": "0x80",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_HITME_HIT.EX_RDS",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x5F",
-        "EventName": "UNC_H_HITME_HIT.EX_RDS",
+        "BriefDescription": "Transgress Ingress Allocations; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Allocations; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M3UPI_RxR_INSERTS.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.BL_BNC",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.IV_BNC",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.AD_CRD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Transgress Ingress Occupancy; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M3UPI_RxR_OCCUPANCY.BL_CRD",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2",
+        "EventCode": "0xD0",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No AD Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2",
+        "EventCode": "0xD2",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_AD_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent0 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2",
+        "EventCode": "0xD4",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG0.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 0",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 1",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR1",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 2",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR2",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 3",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR3",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 4",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Stall on No BL Agent1 Transgress Credits; For=
 Transgress 5",
+        "Counter": "0,1,2",
+        "EventCode": "0xD6",
+        "EventName": "UNC_M3UPI_STALL_NO_TxR_HORZ_CRD_BL_AG1.TGR5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M3UPI_TxR_HORZ_ADS_USED.AD_BNC",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Horizontal ADS Used; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M3UPI_TxR_HORZ_ADS_USED.AK_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_HITME_HIT.EX_RDS",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_MISC.RFO_HIT_S",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x39",
-        "EventName": "UNC_H_MISC.RFO_HIT_S",
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M3UPI_TxR_HORZ_ADS_USED.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_MISC.RFO_HIT_S",
-        "UMask": "0x8",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_LOCAL",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
+        "BriefDescription": "CMS Horizontal ADS Used; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M3UPI_TxR_HORZ_ADS_USED.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "UMask": "0x10",
-        "Unit": "CHA"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_REMOTE",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
+        "BriefDescription": "CMS Horizontal ADS Used; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x9D",
+        "EventName": "UNC_M3UPI_TxR_HORZ_ADS_USED.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_REMOTE",
-        "UMask": "0x20",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.READS",
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS",
-        "UMask": "0x3",
-        "Unit": "CHA"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS_LOCAL",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "BriefDescription": "CMS Horizontal Bypass Used; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.AK_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS_LOCAL",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.WRITES",
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES",
-        "UMask": "0xC",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES_LOCAL",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x50",
-        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "BriefDescription": "CMS Horizontal Bypass Used; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.IV_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES_LOCAL",
-        "UMask": "0x4",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_INSERTS.IRQ",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x13",
-        "EventName": "UNC_H_RxC_INSERTS.IRQ",
+        "BriefDescription": "CMS Horizontal Bypass Used; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_INSERTS.IRQ",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x19",
-        "EventName": "UNC_H_RxC_IRQ1_REJECT.PA_MATCH",
+        "BriefDescription": "CMS Horizontal Bypass Used; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x9F",
+        "EventName": "UNC_M3UPI_TxR_HORZ_BYPASS.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
-        "UMask": "0x80",
-        "Unit": "CHA"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_OCCUPANCY.IRQ",
-        "Deprecated": "1",
-        "EventCode": "0x11",
-        "EventName": "UNC_H_RxC_OCCUPANCY.IRQ",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_OCCUPANCY.IRQ",
-        "UMask": "0x1",
-        "Unit": "CHA"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x5C",
-        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
K - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.AK_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
-        "UMask": "0x40",
-        "Unit": "CHA"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPIFWD",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x5C",
-        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPIFWD",
-        "UMask": "0x4",
-        "Unit": "CHA"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPSFWD",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x5C",
-        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; I=
V - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.IV_BNC",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPSFWD",
-        "UMask": "0x8",
-        "Unit": "CHA"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0x5C",
-        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; A=
D - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.AD_CRD",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
-        "UMask": "0x20",
-        "Unit": "CHA"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Clockticks of the IIO Traffic Controller",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_IIO_CLOCKTICKS",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Full; B=
L - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x96",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_FULL.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts clockticks of the 1GHz trafiic contro=
ller clock in the IIO unit.",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0-3",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
-        "FCMask": "0x4",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.AD_BNC",
         "PerPkg": "1",
-        "PortMask": "0x0f",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data: Part 0-3",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 0",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
-        "FCMask": "0x4",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.AK_BNC",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data: Part 0",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
-        "FCMask": "0x4",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.BL_BNC",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data: Part 1",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
-        "FCMask": "0x4",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.IV_BNC",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data: Part 2",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer Inserts of completions=
 with data: Part 3",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
-        "FCMask": "0x4",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.AD_CRD",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "PCIe Completion Buffer Inserts of completion=
s with data: Part 3",
-        "UMask": "0x03",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 0-3",
-        "Counter": "2,3",
-        "EventCode": "0xD5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
-        "FCMask": "0x04",
+        "BriefDescription": "Cycles CMS Horizontal Egress Queue is Not Emp=
ty; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x97",
+        "EventName": "UNC_M3UPI_TxR_HORZ_CYCLES_NE.BL_CRD",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer occupancy of completi=
ons with data: Part 0-3",
-        "UMask": "0x0f",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 0",
-        "Counter": "2,3",
-        "EventCode": "0xD5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
-        "FCMask": "0x04",
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.AD_BNC",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer occupancy of completi=
ons with data: Part 0",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 1",
-        "Counter": "2,3",
-        "EventCode": "0xD5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
-        "FCMask": "0x04",
+        "BriefDescription": "CMS Horizontal Egress Inserts; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.AK_BNC",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer occupancy of completi=
ons with data: Part 1",
         "UMask": "0x02",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 2",
-        "Counter": "2,3",
-        "EventCode": "0xD5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
-        "FCMask": "0x04",
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.BL_BNC",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer occupancy of completi=
ons with data: Part 2",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIe Completion Buffer occupancy of completio=
ns with data: Part 3",
-        "Counter": "2,3",
-        "EventCode": "0xD5",
-        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
-        "FCMask": "0x04",
+        "BriefDescription": "CMS Horizontal Egress Inserts; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.IV_BNC",
         "PerPkg": "1",
-        "PublicDescription": "PCIe Completion Buffer occupancy of completi=
ons with data: Part 3",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part0",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Inserts; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.AD_CRD",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part0. In the general case, Part0 refers=
 to a standard PCIe card of any size (x16,x8,x4) that is plugged directly i=
nto one of the PCIe slots. Part0 could also refer to any device plugged int=
o the first slot of a PCIe riser card or to a device attached to the IIO un=
it which starts its use of the bus using lane 0 of the 16 lanes supported b=
y the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part1",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Inserts; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x95",
+        "EventName": "UNC_M3UPI_TxR_HORZ_INSERTS.BL_CRD",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part1. In the general case, Part1 refers=
 to a x4 PCIe card plugged into the second slot of a PCIe riser card, but i=
t could refer to any x4 device attached to the IIO unit using lanes startin=
g at lane 4 of the 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part2",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.AD_BNC",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part2. In the general case, Part2 refers=
 to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, =
but it could refer to any x4 or x8 device attached to the IIO unit and usin=
g lanes starting at lane 8 of the 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for 4 bytes made by the CPU to I=
IO Part3",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress NACKs; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.AK_BNC",
+        "PerPkg": "1",
+        "UMask": "0x02",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.BL_BNC",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every read request for 4 bytes of dat=
a made by a unit on the main die (generally a core) or by another IIO unit =
to the MMIO space of a card on IIO Part3. In the general case, Part3 refers=
 to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but i=
t could brefer to  any device attached to the IIO unit using the lanes star=
ting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part0 by=
 the CPU",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress NACKs; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.IV_BNC",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part0 by a unit on the main die (=
generally a core) or by another IIO unit. In the general case, Part0 refers=
 to a standard PCIe card of any size (x16,x8,x4) that is plugged directly i=
nto one of the PCIe slots. Part0 could also refer to any device plugged int=
o the first slot of a PCIe riser card or to a device attached to the IIO un=
it which starts its use of the bus using lane 0 of the 16 lanes supported b=
y the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part1 by=
 the CPU",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress NACKs; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.AD_CRD",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part1 by a unit on the main die (=
generally a core) or by another IIO unit. In the general case, Part1 refers=
 to a x4 PCIe card plugged into the second slot of a PCIe riser card, but i=
t could refer to any x4 device attached to the IIO unit using lanes startin=
g at lane 4 of the 16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part2 by=
 the CPU",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress NACKs; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x99",
+        "EventName": "UNC_M3UPI_TxR_HORZ_NACK.BL_CRD",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part2 by  a unit on the main die =
(generally a core) or by another IIO unit. In the general case, Part2 refer=
s to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card,=
 but it could refer to any x4 or x8 device attached to the IIO unit and usi=
ng lanes starting at lane 8 of the 16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of 4 bytes made to IIO Part3 by=
 the CPU",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.AD_BNC",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every write request of 4 bytes of dat=
a made to the MMIO space of a card on IIO Part3 by  a unit on the main die =
(generally a core) or by another IIO unit. In the general case, Part3 refer=
s to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but =
it could brefer to any device attached to the IIO unit using the lanes star=
ting at lane 12 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part0",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AK - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.AK_BNC",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part0. Does not include requests made by the same IIO unit. In the gener=
al case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that =
is plugged directly into one of the PCIe slots. Part0 could also refer to a=
ny device plugged into the first slot of a PCIe riser card or to a device a=
ttached to the IIO unit which starts its use of the bus using lane 0 of the=
 16 lanes supported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part1",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.BL_BNC",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part1. Does not include requests made by the same IIO unit. In the gener=
al case, Part1 refers to a x4 PCIe card plugged into the second slot of a P=
CIe riser card, but it could refer to any x4 device attached to the IIO uni=
t using lanes starting at lane 4 of the 16 lanes supported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part2",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; IV - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.IV_BNC",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part2. Does not include requests made by the same IIO unit. In the gener=
al case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot o=
f a PCIe riser card, but it could refer to any x4 or x8 device attached to =
the IIO unit and using lanes starting at lane 8 of the 16 lanes supported b=
y the bus.",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 a different IIO unit to IIO Part3",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; AD - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.AD_CRD",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts ever peer to peer read request for 4 =
bytes of data made by a different IIO unit to the MMIO space of a card on I=
IO Part3. Does not include requests made by the same IIO unit. In the gener=
al case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a P=
CIe riser card, but it could brefer to  any device attached to the IIO unit=
 using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part0 by a different IIO unit",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Occupancy; BL - Credit",
+        "Counter": "0,1,2",
+        "EventCode": "0x94",
+        "EventName": "UNC_M3UPI_TxR_HORZ_OCCUPANCY.BL_CRD",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part0 by a different=
 IIO unit. Does not include requests made by the same IIO unit.  In the gen=
eral case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) tha=
t is plugged directly into one of the PCIe slots. Part0 could also refer to=
 any device plugged into the first slot of a PCIe riser card or to a device=
 attached to the IIO unit which starts its use of the bus using lane 0 of t=
he 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part1 by a different IIO unit",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
D - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M3UPI_TxR_HORZ_STARVED.AD_BNC",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part1 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part1 refers to a x4 PCIe card plugged into the second slot of a =
PCIe riser card, but it could refer to any x4 device attached to the IIO un=
it using lanes starting at lane 4 of the 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part2 by a different IIO unit",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; A=
K - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M3UPI_TxR_HORZ_STARVED.AK_BNC",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part2 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot =
of a PCIe riser card, but it could refer to any x4 or x8 device attached to=
 the IIO unit and using lanes starting at lane 8 of the 16 lanes supported =
by the bus.",
         "UMask": "0x02",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made to=
 IIO Part3 by a different IIO unit",
-        "Counter": "2,3",
-        "EventCode": "0xC0",
-        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; B=
L - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M3UPI_TxR_HORZ_STARVED.BL_BNC",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made to the MMIO space of a card on IIO Part3 by a different=
 IIO unit. Does not include requests made by the same IIO unit. In the gene=
ral case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a =
PCIe riser card, but it could brefer to any device attached to the IIO unit=
 using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Horizontal Egress Injection Starvation; I=
V - Bounce",
+        "Counter": "0,1,2",
+        "EventCode": "0x9B",
+        "EventName": "UNC_M3UPI_TxR_HORZ_STARVED.IV_BNC",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the=
 general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4)=
 that is plugged directly into one of the PCIe slots. Part0 could also refe=
r to any device plugged into the first slot of a PCIe riser card or to a de=
vice attached to the IIO unit which starts its use of the bus using lane 0 =
of the 16 lanes supported by the bus.",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part1 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the=
 general case, Part1 refers to a x4 PCIe card plugged into the second slot =
of a PCIe riser card, but it could refer to any x4 device attached to the I=
IO unit using lanes starting at lane 4 of the 16 lanes supported by the bus=
.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part2 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the=
 general case, Part2 refers to a x4 or x8 PCIe card plugged into the third =
slot of a PCIe riser card, but it could refer to any x4 or x8 device attach=
ed to the IIO unit and using lanes starting at lane 8 of the 16 lanes suppo=
rted by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for 4 bytes made by=
 IIO Part3 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer read request for 4=
 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the=
 general case, Part3 refers to a x4 PCIe card plugged into the fourth slot =
of a PCIe riser card, but it could brefer to any device attached to the IIO=
 unit using the lanes starting at lane 12 of the 16 lanes supported by the =
bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the=
 general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4)=
 that is plugged directly into one of the PCIe slots. Part0 could also refe=
r to any device plugged into the first slot of a PCIe riser card or to a de=
vice attached to the IIO unit which starts its use of the bus using lane 0 =
of the 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the=
 general case, Part1 refers to a x4 PCIe card plugged into the second slot =
of a PCIe riser card, but it could refer to any x4 device attached to the I=
IO unit using lanes starting at lane 4 of the 16 lanes supported by the bus=
.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9C",
+        "EventName": "UNC_M3UPI_TxR_VERT_ADS_USED.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the=
 general case, Part2 refers to a x4 or x8 PCIe card plugged into the third =
slot of a PCIe riser card, but it could refer to any x4 or x8 device attach=
ed to the IIO unit and using lanes starting at lane 8 of the 16 lanes suppo=
rted by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of 4 bytes made by=
 IIO Part0 to an IIO target",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer write request of 4=
 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the=
 general case, Part3 refers to a x4 PCIe card plugged into the fourth slot =
of a PCIe riser card, but it could brefer to  any device attached to the II=
O unit using the lanes starting at lane 12 of the 16 lanes supported by the=
 bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART0",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "UMask": "0x4",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART1",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x2",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
-        "UMask": "0x4",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART2",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.IV",
         "PerPkg": "1",
-        "PortMask": "0x4",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
-        "UMask": "0x4",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART3",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x8",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "UMask": "0x4",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "UMask": "0x1",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART1",
-        "FCMask": "0x7",
+        "BriefDescription": "CMS Vertical ADS Used; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9E",
+        "EventName": "UNC_M3UPI_TxR_VERT_BYPASS.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x2",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
-        "UMask": "0x1",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART2",
-        "FCMask": "0x7",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x4",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
-        "UMask": "0x1",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "Counter": "0,1",
-        "Deprecated": "1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3",
-        "FCMask": "0x7",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x8",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "UMask": "0x1",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part0. In the genera=
l case, part0 refers to a standard PCIe card of any size (x16,x8,x4) that i=
s plugged directly into one of the PCIe slots. Part0 could also refer to an=
y device plugged into the first slot of a PCIe riser card or to a device at=
tached to the IIO unit which starts its use of the bus using lane 0 of the =
16 lanes supported by the bus.",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.IV",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part1. In the genera=
l case, Part1 refers to a x4 PCIe card plugged into the second slot of a PC=
Ie riser card, but it could refer to any x4 device attached to the IIO unit=
 using lanes starting at lane 4 of the 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AD =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part2. In the genera=
l case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of=
 a PCIe riser card, but it could refer to any x4 or x8 device attached to t=
he IIO unit and using lanes starting at lane 8 of the 16 lanes supported by=
 the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part3",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; AK =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by a unit on the main die (generally a core) or =
by another IIO unit to the MMIO space of a card on IIO Part3. In the genera=
l case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PC=
Ie riser card, but it could brefer to  any device attached to the IIO unit =
using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part0 by the CPU",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Full; BL =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x92",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_FULL.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part0 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that i=
s plugged directly into one of the PCIe slots. Part0 could also refer to an=
y device plugged into the first slot of a PCIe riser card or to a device at=
tached to the IIO unit which starts its use of the bus using lane 0 of the =
16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part1 by the CPU",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part1 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part1 refers to a x4 PCIe card plugged into the second slot of a PC=
Ie riser card, but it could refer to any x4 device attached to the IIO unit=
 using lanes starting at lane 4 of the 16 lanes supported by the bus.",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part2 by the CPU",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part2 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of=
 a PCIe riser card, but it could refer to any x4 or x8 device attached to t=
he IIO unit and using lanes starting at lane 8 of the 16 lanes supported by=
 the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made to IIO Part3 by the CPU",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made to the MMIO space of a card on IIO Part3 by a un=
it on the main die (generally a core) or by another IIO unit. In the genera=
l case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PC=
Ie riser card, but it could brefer to  any device attached to the IIO unit =
using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part0",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.IV",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part0. Does not include requests made by the same I=
IO unit. In the general case, part0 refers to a standard PCIe card of any s=
ize (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 =
could also refer to any device plugged into the first slot of a PCIe riser =
card or to a device attached to the IIO unit which starts its use of the bu=
s using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part1",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part1. Does not include requests made by the same I=
IO unit. In the general case, Part1 refers to a x4 PCIe card plugged into t=
he second slot of a PCIe riser card, but it could refer to any x4 device at=
tached to the IIO unit using lanes starting at lane 4 of the 16 lanes suppo=
rted by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part2. Does not include requests made by the same I=
IO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged =
into the third slot of a PCIe riser card, but it could refer to any x4 or x=
8 device attached to the IIO unit and using lanes starting at lane 8 of the=
 16 lanes supported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request for up to a 64 byte=
 transaction is made by a different IIO unit to IIO Part3",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "Cycles CMS Vertical Egress Queue Is Not Empty=
; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x93",
+        "EventName": "UNC_M3UPI_TxR_VERT_CYCLES_NE.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer read request for u=
p to a 64 byte transaction of data made by a different IIO unit to the MMIO=
 space of a card on IIO Part3. Does not include requests made by the same I=
IO unit. In the general case, Part3 refers to a x4 PCIe card plugged into t=
he fourth slot of a PCIe riser card, but it could brefer to  any device att=
ached to the IIO unit using the lanes starting at lane 12 of the 16 lanes s=
upported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part0 by a different IIO unit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.AD_AG0",
+        "PerPkg": "1",
+        "UMask": "0x01",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part0 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part0 refers to a standard PCIe card of any s=
ize (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 =
could also refer to any device plugged into the first slot of a PCIe riser =
card or to a device attached to the IIO unit which starts its use of the bu=
s using lane 0 of the 16 lanes supported by the bus.",
         "UMask": "0x02",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.BL_AG0",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part1 by a different IIO unit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Allocations; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.IV",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part1 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part1 refers to a x4 PCIe card plugged into t=
he second slot of a PCIe riser card, but it could refer to any x4 device at=
tached to the IIO unit using lanes starting at lane 4 of the 16 lanes suppo=
rted by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part2 by a different IIO unit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Allocations; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part2 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged =
into the third slot of a PCIe riser card, but it could refer to any x4 or x=
8 device attached to the IIO unit and using lanes starting at lane 8 of the=
 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made to IIO Part3 by a different IIO unit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xC1",
-        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Allocations; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made to the MMIO space of a card on IIO =
Part3 by a different IIO unit. Does not include requests made by the same I=
IO unit. In the general case, Part3 refers to a x4 PCIe card plugged into t=
he fourth slot of a PCIe riser card, but it could brefer to  any device att=
ached to the IIO unit using the lanes starting at lane 12 of the 16 lanes s=
upported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part0 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Allocations; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x91",
+        "EventName": "UNC_M3UPI_TxR_VERT_INSERTS.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is  made by IIO Part1 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part2 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
-        "UMask": "0x04",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Read request for up to a 64 byte transaction =
is made by IIO Part3 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every read request for up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x04",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part0 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part0 to a unit on the main die (generall=
y memory). In the general case, Part0 refers to a standard PCIe card of any=
 size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part=
0 could also refer to any device plugged into the first slot of a PCIe rise=
r card or to a device attached to the IIO unit which starts its use of the =
bus using lane 0 of the 16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part1 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part1 to a unit on the main die (generall=
y memory). In the general case, Part1 refers to a x4 PCIe card plugged into=
 the second slot of a PCIe riser card, but it could refer to any x4 device =
attached to the IIO unit using lanes starting at lane 4 of the 16 lanes sup=
ported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part2 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress NACKs; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part2 to a unit on the main die (generall=
y memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugge=
d into the third slot of a PCIe riser card, but it could refer to any x4 or=
 x8 device attached to the IIO unit and using lanes starting at lane 8 of t=
he 16 lanes supported by the bus.",
-        "UMask": "0x01",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Write request of up to a 64 byte transaction =
is made by IIO Part3 to Memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every write request of up to a 64 byt=
e transaction of data made by IIO Part3 to a unit on the main die (generall=
y memory). In the general case, Part3 refers to a x4 PCIe card plugged into=
 the fourth slot of a PCIe riser card, but it could brefer to  any device a=
ttached to the IIO unit using the lanes starting at lane 12 of the 16 lanes=
 supported by the bus.",
         "UMask": "0x01",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part0 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part0 to the MMIO space of an IIO tar=
get. In the general case, Part0 refers to a standard PCIe card of any size =
(x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 coul=
d also refer to any device plugged into the first slot of a PCIe riser card=
 or to a device attached to the IIO unit which starts its use of the bus us=
ing lane 0 of the 16 lanes supported by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part1 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.BL_AG0",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part1 to the MMIO space of an IIO tar=
get. In the general case, Part1 refers to a x4 PCIe card plugged into the s=
econd slot of a PCIe riser card, but it could refer to any x4 device attach=
ed to the IIO unit using lanes starting at lane 4 of the 16 lanes supported=
 by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part2 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.IV",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part2 to the MMIO space of an IIO tar=
get. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into=
 the third slot of a PCIe riser card, but it could refer to any x4 or x8 de=
vice attached to the IIO unit and using lanes starting at lane 8 of the 16 =
lanes supported by the bus.",
         "UMask": "0x08",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer read request of up to a 64 byte =
transaction is made by IIO Part3 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; AD - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.AD_AG1",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer read request of up=
 to a 64 byte transaction made by IIO Part3 to the MMIO space of an IIO tar=
get. In the general case, Part3 refers to a x4 PCIe card plugged into the f=
ourth slot of a PCIe riser card, but it could brefer to any device attached=
 to the IIO unit using the lanes starting at lane 12 of the 16 lanes suppor=
ted by the bus.",
-        "UMask": "0x08",
-        "Unit": "IIO"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part0 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; AK - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.AK_AG1",
         "PerPkg": "1",
-        "PortMask": "0x01",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part0 to the MMIO space of a=
n IIO target. In the general case, Part0 refers to a standard PCIe card of =
any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. P=
art0 could also refer to any device plugged into the first slot of a PCIe r=
iser card or to a device attached to the IIO unit which starts its use of t=
he bus using lane 0 of the 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part1 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vert Egress Occupancy; BL - Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x90",
+        "EventName": "UNC_M3UPI_TxR_VERT_OCCUPANCY.BL_AG1",
         "PerPkg": "1",
-        "PortMask": "0x02",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part1 to the MMIO space of a=
n IIO target.In the general case, Part1 refers to a x4 PCIe card plugged in=
to the second slot of a PCIe riser card, but it could refer to any x4 devic=
e attached to the IIO unit using lanes starting at lane 4 of the 16 lanes s=
upported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part2 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.AD_AG0",
         "PerPkg": "1",
-        "PortMask": "0x04",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part2 to the MMIO space of a=
n IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plu=
gged into the third slot of a PCIe riser card, but it could refer to any x4=
 or x8 device attached to the IIO unit and using lanes starting at lane 8 o=
f the 16 lanes supported by the bus.",
-        "UMask": "0x02",
-        "Unit": "IIO"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Peer to peer write request of up to a 64 byte=
 transaction is made by IIO Part3 to an IIO target",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x84",
-        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
-        "FCMask": "0x07",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.AK_AG0",
         "PerPkg": "1",
-        "PortMask": "0x08",
-        "PublicDescription": "Counts every peer to peer write request of u=
p to a 64 byte transaction of data made by IIO Part3 to the MMIO space of a=
n IIO target. In the general case, Part3 refers to a x4 PCIe card plugged i=
nto the fourth slot of a PCIe riser card, but it could brefer to  any devic=
e attached to the IIO unit using the lanes starting at lane 12 of the 16 la=
nes supported by the bus.",
         "UMask": "0x02",
-        "Unit": "IIO"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Total IRP occupancy of inbound read and write=
 requests.",
-        "Counter": "0,1",
-        "EventCode": "0xF",
-        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.BL_AG0",
         "PerPkg": "1",
-        "PublicDescription": "Total IRP occupancy of inbound read and writ=
e requests.  This is effectively the sum of read occupancy and write occupa=
ncy.",
-        "UMask": "0x4",
-        "Unit": "IRP"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "PCIITOM request issued by the IRP unit to the=
 mesh with the intention of writing a full cacheline.",
-        "Counter": "0,1",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AD =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.AD_AG1",
         "PerPkg": "1",
-        "PublicDescription": "PCIITOM request issued by the IRP unit to th=
e mesh with the intention of writing a full cacheline to coherent memory, w=
ithout a RFO.  PCIITOM is a speculative Invalidate to Modified command that=
 requests ownership of the cacheline and does not move data from the mesh t=
o IRP cache.",
         "UMask": "0x10",
-        "Unit": "IRP"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "RFO request issued by the IRP unit to the mes=
h with the intention of writing a partial cacheline.",
-        "Counter": "0,1",
-        "EventCode": "0x10",
-        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; AK =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.AK_AG1",
         "PerPkg": "1",
-        "PublicDescription": "RFO request issued by the IRP unit to the me=
sh with the intention of writing a partial cacheline to coherent memory.  R=
FO is a Read For Ownership command that requests ownership of the cacheline=
 and moves data from the mesh to IRP cache.",
-        "UMask": "0x8",
-        "Unit": "IRP"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue.",
-        "Counter": "0,1",
-        "EventCode": "0x18",
-        "EventName": "UNC_I_FAF_INSERTS",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; BL =
- Agent 1",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.BL_AG1",
         "PerPkg": "1",
-        "PublicDescription": "Inbound read requests to coherent memory, re=
ceived by the IRP and inserted into the Fire and Forget queue (FAF), a queu=
e used for processing inbound reads in the IRP.",
-        "Unit": "IRP"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Occupancy of the IRP FAF queue.",
-        "Counter": "0,1",
-        "EventCode": "0x19",
-        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "BriefDescription": "Vertical AD Ring In Use; Up and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M3UPI_VERT_RING_AD_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Occupancy of the IRP Fire and Forget (FAF) q=
ueue, a queue used for processing inbound reads in the IRP.",
-        "Unit": "IRP"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Inbound write (fast path) requests received b=
y the IRP.",
-        "Counter": "0,1",
-        "EventCode": "0x11",
-        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "BriefDescription": "Vertical AD Ring In Use; Up and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M3UPI_VERT_RING_AD_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Inbound write (fast path) requests to cohere=
nt memory, received by the IRP resulting in write ownership requests issued=
 by IRP to the mesh.",
-        "UMask": "0x8",
-        "Unit": "IRP"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Traffic in which the M2M to iMC Bypass was no=
t taken",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x22",
-        "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
+        "BriefDescription": "Vertical AD Ring In Use; Down and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M3UPI_VERT_RING_AD_IN_USE.DN_EVEN",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Vertical AD Ring In Use; Down and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M3UPI_VERT_RING_AD_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Counts traffic in which the M2M (Mesh to Mem=
ory) to iMC (Memory Controller) bypass was not taken",
-        "UMask": "0x2",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Cycles when direct to core mode (which bypass=
es the CHA) was disabled",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "BriefDescription": "Vertical AK Ring In Use; Up and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M3UPI_VERT_RING_AK_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when direct to core mode (whic=
h bypasses the CHA) was disabled",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Messages sent direct to core (bypassing the C=
HA)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x23",
-        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
+        "BriefDescription": "Vertical AK Ring In Use; Up and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M3UPI_VERT_RING_AK_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when messages were sent direct to cor=
e (bypassing the CHA)",
-        "Unit": "M2M"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Number of reads in which direct to core trans=
action were overridden",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x25",
-        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
+        "BriefDescription": "Vertical AK Ring In Use; Down and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M3UPI_VERT_RING_AK_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts reads in which direct to core transac=
tions (which would have bypassed the CHA) were overridden",
-        "Unit": "M2M"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Number of reads in which direct to Intel UPI =
transactions were overridden",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x28",
-        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "BriefDescription": "Vertical AK Ring In Use; Down and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xA8",
+        "EventName": "UNC_M3UPI_VERT_RING_AK_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Counts reads in which direct to Intel Ultra =
Path Interconnect (UPI) transactions (which would have bypassed the CHA) we=
re overridden",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Cycles when direct to Intel UPI was disabled",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x27",
-        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "BriefDescription": "Vertical BL Ring in Use; Up and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M3UPI_VERT_RING_BL_IN_USE.UP_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the ability to send messa=
ges direct to the Intel Ultra Path Interconnect (bypassing the CHA) was dis=
abled",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Messages sent direct to the Intel UPI",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x26",
-        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
+        "BriefDescription": "Vertical BL Ring in Use; Up and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M3UPI_VERT_RING_BL_IN_USE.UP_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when messages were sent direct to the=
 Intel Ultra Path Interconnect (bypassing the CHA)",
-        "Unit": "M2M"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Number of reads that a message sent direct2 I=
ntel UPI was overridden",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x29",
-        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
+        "BriefDescription": "Vertical BL Ring in Use; Down and Even",
+        "Counter": "0,1,2",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M3UPI_VERT_RING_BL_IN_USE.DN_EVEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a read message that was sent dir=
ect to the Intel Ultra Path Interconnect (bypassing the CHA) was overridden=
",
-        "Unit": "M2M"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookups (any=
 state found)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2D",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
+        "BriefDescription": "Vertical BL Ring in Use; Down and Odd",
+        "Counter": "0,1,2",
+        "EventCode": "0xAA",
+        "EventName": "UNC_M3UPI_VERT_RING_BL_IN_USE.DN_ODD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in Any State (A, I, S or unused)",
-        "UMask": "0x1",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookups (cac=
heline found in A state)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2D",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
+        "BriefDescription": "Vertical IV Ring in Use; Up",
+        "Counter": "0,1,2",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M3UPI_VERT_RING_IV_IN_USE.UP",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state, and found the cacheline mar=
ked in the A (SnoopAll) state, indicating the cacheline is stored in anothe=
r socket in any state, and we must snoop the other sockets to make sure we =
get the latest data.  The data may be stored in any state in the local sock=
et.",
-        "UMask": "0x8",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in I state)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2D",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
+        "BriefDescription": "Vertical IV Ring in Use; Down",
+        "Counter": "0,1,2",
+        "EventCode": "0xAC",
+        "EventName": "UNC_M3UPI_VERT_RING_IV_IN_USE.DN",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the I (Invalid) state indicating the cacheline is not stored in ano=
ther socket, and so there is no need to snoop the other sockets for the lat=
est data.  The data may be stored in any state in the local socket.",
-        "UMask": "0x2",
-        "Unit": "M2M"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory lookup (cach=
eline found in S state)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2D",
-        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
+        "BriefDescription": "D2C Sent",
+        "Counter": "0,1,2",
+        "EventCode": "0x2B",
+        "EventName": "UNC_M3UPI_D2C_SENT",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks i=
nto the multi-socket cacheline Directory state , and found the cacheline ma=
rked in the S (Shared) state indicating the cacheline is either stored in a=
nother socket in the S(hared) state , and so there is no need to snoop the =
other sockets for the latest data.  The data may be stored in any state in =
the local socket.",
-        "UMask": "0x4",
-        "Unit": "M2M"
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
A to I",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
+        "BriefDescription": "FaST wire asserted; Vertical",
+        "Counter": "0,1,2",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M3UPI_FAST_ASSERTED.VERT",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to I (In=
valid)",
-        "UMask": "0x20",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
A to S",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
+        "BriefDescription": "FaST wire asserted; Horizontal",
+        "Counter": "0,1,2",
+        "EventCode": "0xA5",
+        "EventName": "UNC_M3UPI_FAST_ASSERTED.HORZ",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from A (SnoopAll) to S (Sh=
ared)",
-        "UMask": "0x40",
-        "Unit": "M2M"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from/=
to Any state",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
+        "BriefDescription": "Sent Header Flit",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.SLOTS_1",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory to a new state",
-        "UMask": "0x1",
-        "Unit": "M2M"
+        "UMask": "0x10",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
I to A",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
+        "BriefDescription": "Sent Header Flit",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.SLOTS_2",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to A (Sno=
opAll)",
-        "UMask": "0x4",
-        "Unit": "M2M"
+        "UMask": "0x20",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
I to S",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
+        "BriefDescription": "Sent Header Flit",
+        "Counter": "0,1,2",
+        "EventCode": "0x56",
+        "EventName": "UNC_M3UPI_RxC_FLITS_SENT.SLOTS_3",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from I (Invalid) to S (Sha=
red)",
-        "UMask": "0x2",
-        "Unit": "M2M"
+        "UMask": "0x40",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
S to A",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
+        "BriefDescription": "CMS Vertical Egress NACKs; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x98",
+        "EventName": "UNC_M3UPI_TxR_VERT_NACK.IV",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to A (Snoo=
pAll)",
-        "UMask": "0x10",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Multi-socket cacheline Directory update from =
S to I",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2E",
-        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
+        "BriefDescription": "CMS Vertical Egress Injection Starvation; IV",
+        "Counter": "0,1,2",
+        "EventCode": "0x9A",
+        "EventName": "UNC_M3UPI_TxR_VERT_STARVED.IV",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates=
 the multi-socket cacheline Directory state from from S (Shared) to I (Inva=
lid)",
-        "UMask": "0x8",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Reads to iMC issued",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_M2M_IMC_READS.ALL",
+        "BriefDescription": "UPI0 BL Credits Empty; VNA",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VNA",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller).",
-        "UMask": "0x4",
-        "Unit": "M2M"
+        "UMask": "0x01",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Reads to iMC issued at Normal Priority (Non-I=
sochronous)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_M2M_IMC_READS.NORMAL",
+        "BriefDescription": "UPI0 BL Credits Empty; VN0 REQ Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN0_RSP",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
reads to the iMC (Memory Controller).  It only counts  normal priority non-=
isochronous reads.",
-        "UMask": "0x1",
-        "Unit": "M2M"
+        "UMask": "0x02",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Writes to iMC issued",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x38",
-        "EventName": "UNC_M2M_IMC_WRITES.ALL",
+        "BriefDescription": "UPI0 BL Credits Empty; VN0 RSP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN0_NCS_NCB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
writes to the iMC (Memory Controller).",
-        "UMask": "0x10",
-        "Unit": "M2M"
+        "UMask": "0x04",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "M2M Writes Issued to iMC; All, regardless of =
priority.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x38",
-        "EventName": "UNC_M2M_IMC_WRITES.NI",
+        "BriefDescription": "UPI0 BL Credits Empty; VN0 SNP Messages",
+        "Counter": "0,1,2",
+        "EventCode": "0x21",
+        "EventName": "UNC_M3UPI_UPI_PEER_BL_CREDITS_EMPTY.VN0_WB",
         "PerPkg": "1",
-        "PublicDescription": "M2M Writes Issued to iMC; All, regardless of=
 priority.",
-        "UMask": "0x80",
-        "Unit": "M2M"
+        "UMask": "0x08",
+        "Unit": "M3UPI"
     },
     {
-        "BriefDescription": "Partial Non-Isochronous writes to the iMC",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x38",
-        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
+        "BriefDescription": "Message Received; VLW",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues =
partial writes to the iMC (Memory Controller).  It only counts normal prior=
ity non-isochronous writes.",
-        "UMask": "0x2",
-        "Unit": "M2M"
+        "UMask": "0x1",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Prefetch requests that got turn into a demand=
 request",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x56",
-        "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
+        "BriefDescription": "Message Received; MSI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) promote=
s a outstanding request in the prefetch queue due to a subsequent demand re=
ad request that entered the M2M with the same address.  Explanatory Side No=
te: The Prefetch queue is made of CAM (Content Addressable Memory)",
-        "Unit": "M2M"
+        "UMask": "0x2",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Inserts into the Memory Controller Prefetch Q=
ueue",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x57",
-        "EventName": "UNC_M2M_PREFCAM_INSERTS",
+        "BriefDescription": "Message Received; IPI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) receive=
s a prefetch request and inserts it into its outstanding prefetch queue.  E=
xplanatory Side Note: the prefect queue is made from CAM: Content Addressab=
le Memory",
-        "Unit": "M2M"
+        "UMask": "0x4",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "AD Ingress (from CMS) Queue Inserts",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_M2M_RxC_AD_INSERTS",
+        "BriefDescription": "Message Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the a new entry is Received(RxC)=
 and then added to the AD (Address Ring) Ingress Queue from the CMS (Common=
 Mesh Stop).  This is generally used for reads, and",
-        "Unit": "M2M"
+        "UMask": "0x8",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "AD Ingress (from CMS) Occupancy",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
+        "BriefDescription": "Message Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
         "PerPkg": "1",
-        "PublicDescription": "AD Ingress (from CMS) Occupancy",
-        "Unit": "M2M"
+        "UMask": "0x10",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "BL Ingress (from CMS) Allocations",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x5",
-        "EventName": "UNC_M2M_RxC_BL_INSERTS",
+        "BriefDescription": "IDI Lock/SplitLock Cycles",
+        "Counter": "0,1",
+        "EventCode": "0x44",
+        "EventName": "UNC_U_LOCK_CYCLES",
         "PerPkg": "1",
-        "PublicDescription": "BL Ingress (from CMS) Allocations",
-        "Unit": "M2M"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "BL Ingress (from CMS) Occupancy",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x6",
-        "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "Counter": "0,1",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
         "PerPkg": "1",
-        "PublicDescription": "BL Ingress (from CMS) Occupancy",
-        "Unit": "M2M"
+        "UMask": "0x1",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "AD Egress (to CMS) Allocations",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x9",
-        "EventName": "UNC_M2M_TxC_AD_INSERTS",
+        "BriefDescription": "UNC_U_RACU_DRNG.RDRAND",
+        "Counter": "0,1",
+        "EventCode": "0x4C",
+        "EventName": "UNC_U_RACU_DRNG.RDRAND",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress (to CMS) Allocations",
-        "Unit": "M2M"
+        "UMask": "0x1",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "AD Egress (to CMS) Occupancy",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xA",
-        "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
+        "BriefDescription": "UNC_U_RACU_DRNG.RDSEED",
+        "Counter": "0,1",
+        "EventCode": "0x4C",
+        "EventName": "UNC_U_RACU_DRNG.RDSEED",
         "PerPkg": "1",
-        "PublicDescription": "AD Egress (to CMS) Occupancy",
-        "Unit": "M2M"
+        "UMask": "0x2",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "BL Egress (to CMS) Allocations; All",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x15",
-        "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
+        "BriefDescription": "UNC_U_RACU_DRNG.PFTCH_BUF_EMPTY",
+        "Counter": "0,1",
+        "EventCode": "0x4C",
+        "EventName": "UNC_U_RACU_DRNG.PFTCH_BUF_EMPTY",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress (to CMS) Allocations; All",
-        "UMask": "0x03",
-        "Unit": "M2M"
+        "UMask": "0x4",
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "BL Egress (to CMS) Occupancy; All",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x16",
-        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.ALL",
+        "BriefDescription": "RACU Request",
+        "Counter": "0,1",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
         "PerPkg": "1",
-        "PublicDescription": "BL Egress (to CMS) Occupancy; All",
-        "UMask": "0x03",
-        "Unit": "M2M"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Prefetches generated by the flow control queu=
e of the M3UPI unit.",
-        "Counter": "0,1,2",
-        "EventCode": "0x29",
-        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
+        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_U_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Count cases where flow control queue that si=
ts between the Intel Ultra Path Interconnect (UPI) and the mesh spawns a pr=
efetch to the iMC (Memory Controller)",
-        "Unit": "M3UPI"
+        "Unit": "UBOX"
     },
     {
-        "BriefDescription": "Clocks of the Intel Ultra Path Interconnect (=
UPI)",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.CORE_GTONE",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_UPI_CLOCKTICKS",
+        "Deprecated": "1",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_CORE_SNP.CORE_GTONE",
         "PerPkg": "1",
-        "PublicDescription": "Counts clockticks of the fixed frequency clo=
ck controlling the Intel Ultra Path Interconnect (UPI).  This clock runs at=
1/8th the 'GT/s' speed of the UPI link.  For example, a  9.6GT/s  link will=
 have a fixed Frequency of 1.2 Ghz.",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.CORE_GTONE",
+        "UMask": "0x42",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Response packets that go direct to core",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.EVICT_GTONE",
         "Counter": "0,1,2,3",
-        "EventCode": "0x12",
-        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
+        "Deprecated": "1",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_CORE_SNP.EVICT_GTONE",
         "PerPkg": "1",
-        "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to core bypassing the CHA.",
-        "UMask": "0x1",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "UMask": "0x82",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.NO_SNP",
         "Counter": "0,1,2,3",
         "Deprecated": "1",
-        "EventCode": "0x12",
-        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2K",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_DIR_LOOKUP.NO_SNP",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.NO_SNP",
         "UMask": "0x2",
-        "Unit": "UPI LL"
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data Response packets that go direct to Intel=
 UPI",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.SNP",
         "Counter": "0,1,2,3",
-        "EventCode": "0x12",
-        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "Deprecated": "1",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_DIR_LOOKUP.SNP",
         "PerPkg": "1",
-        "PublicDescription": "Counts Data Response (DRS) packets that atte=
mpted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA=
 .",
-        "UMask": "0x2",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.SNP",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles Intel UPI is in L1 power mode (shutdow=
n)",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.HA",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "Deprecated": "1",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_DIR_UPDATE.HA",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the Intel Ultra Path Inte=
rconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down t=
he UPI link.  Link power states are per link and per direction, so for exam=
ple the Tx direction could be in one state while Rx was in another, this ev=
ent only coutns when both links are shutdown.",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.HA",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles the Rx of the Intel UPI is in L0p powe=
r mode",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.TOR",
         "Counter": "0,1,2,3",
-        "EventCode": "0x25",
-        "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
+        "Deprecated": "1",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_DIR_UPDATE.TOR",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the the receive side (Rx)=
 of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a m=
ode where we disable 60% of the UPI lanes, decreasing our bandwidth in orde=
r to save power.",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.TOR",
+        "UMask": "0x2",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_HITME_HIT.EX_RDS",
         "Counter": "0,1,2,3",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
+        "Deprecated": "1",
+        "EventCode": "0x5F",
+        "EventName": "UNC_H_HITME_HIT.EX_RDS",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to t=
he Egress.  This is a latency optimization, and should generally be the com=
mon case.  If this value is less than the number of FLITs transferred, it i=
mplies that there was queueing getting onto the ring, and thus the transact=
ions saw higher latency.",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_HITME_HIT.EX_RDS",
         "UMask": "0x1",
-        "Unit": "UPI LL"
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_MISC.RFO_HIT_S",
         "Counter": "0,1,2,3",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
+        "Deprecated": "1",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.RFO_HIT_S",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly acr=
oss the BGF and into the Egress.  This is a latency optimization, and shoul=
d generally be the common case.  If this value is less than the number of F=
LITs transferred, it implies that there was queueing getting onto the ring,=
 and thus the transactions saw higher latency.",
-        "UMask": "0x2",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_MISC.RFO_HIT_S",
+        "UMask": "0x8",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recei=
ve Buffer",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "Counter": "0,1,2,3",
-        "EventCode": "0x31",
-        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to =
the Egress.  This is a latency optimization, and should generally be the co=
mmon case.  If this value is less than the number of FLITs transferred, it =
implies that there was queueing getting onto the ring, and thus the transac=
tions saw higher latency.",
-        "UMask": "0x4",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "UMask": "0x10",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid data FLITs received from any slot",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_REMOTE",
         "Counter": "0,1,2,3",
-        "EventCode": "0x3",
-        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts valid data FLITs  (80 bit FLow contro=
l unITs: 64bits of data) received from any of the 3 Intel Ultra Path Interc=
onnect (UPI) Receive Queue slots on this UPI unit.",
-        "UMask": "0x0F",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "UMask": "0x20",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Null FLITs received from any slot",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS",
         "Counter": "0,1,2,3",
-        "EventCode": "0x3",
-        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.READS",
         "PerPkg": "1",
-        "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive Qu=
eue slots on this UPI unit.",
-        "UMask": "0x27",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS",
+        "UMask": "0x3",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Protocol header and credit FLITs received fro=
m any slot",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS_LOCAL",
         "Counter": "0,1,2,3",
-        "EventCode": "0x3",
-        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts protocol header and credit FLITs  (80=
 bit FLow control unITs) received from any of the 3 UPI slots on this UPI u=
nit.",
-        "UMask": "0x97",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS_LOCAL",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_FLITS.ALL_NULL",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES",
         "Counter": "0,1,2,3",
         "Deprecated": "1",
-        "EventCode": "0x3",
-        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_RxL_FLITS.ALL_NULL",
-        "UMask": "0x20",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES",
+        "UMask": "0xC",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Cycles in which the Tx of the Intel Ultra Pat=
h Interconnect (UPI) is in L0p power mode",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES_LOCAL",
         "Counter": "0,1,2,3",
-        "EventCode": "0x27",
-        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles when the transmit side (Tx) of=
 the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode=
 where we disable 60% of the UPI lanes, decreasing our bandwidth in order t=
o save power.",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "UMask": "0x4",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "FLITs that bypassed the TxL Buffer",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_INSERTS.IRQ",
         "Counter": "0,1,2,3",
-        "EventCode": "0x41",
-        "EventName": "UNC_UPI_TxL_BYPASSED",
+        "Deprecated": "1",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_RxC_INSERTS.IRQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) w=
hich bypassed the TxL(transmit) FLIT buffer and pass directly out the UPI L=
ink. Generally, when data is transmitted across the Intel Ultra Path Interc=
onnect (UPI), it will bypass the TxQ and pass directly to the link.  Howeve=
r, the TxQ will be used in L0p (Low Power) mode and (Link Layer Retry) LLR =
 mode, increasing latency to transfer out to the link.",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_INSERTS.IRQ",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Null FLITs transmitted from any slot",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "Deprecated": "1",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_RxC_IRQ1_REJECT.PA_MATCH",
         "PerPkg": "1",
-        "PublicDescription": "Counts null FLITs (80 bit FLow control unITs=
) transmitted via any of the 3 Intel Ulra Path Interconnect (UPI) slots on =
this UPI unit.",
-        "UMask": "0x27",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "UMask": "0x80",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Valid Flits Sent; Data",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "Deprecated": "1",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_RxC_OCCUPANCY.IRQ",
         "PerPkg": "1",
-        "PublicDescription": "Shows legal flit time (hides impact of L0p a=
nd L0c).; Count Data Flits (which consume all slots), but how much to count=
 is based on Slot0-2 mask, so count can be 0-3 depending on which slots are=
 enabled for counting..",
-        "UMask": "0x8",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "UMask": "0x1",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Idle FLITs transmitted",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPIFWD",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the Intel Ultra Path Interconnec=
t(UPI) transmits an idle FLIT(80 bit FLow control unITs).  Every UPI cycle =
must be sending either data FLITs, protocol/credit FLITs or idle FLITs.",
-        "UMask": "0x47",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPIFWD",
+        "UMask": "0x4",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "Protocol header and credit FLITs transmitted =
across any slot",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPSFWD",
         "Counter": "0,1,2,3",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
         "PerPkg": "1",
-        "PublicDescription": "Counts protocol header and credit FLITs (80 =
bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path Int=
erconnect) slots on this UPI unit.",
-        "UMask": "0x97",
-        "Unit": "UPI LL"
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPSFWD",
+        "UMask": "0x8",
+        "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_FLITS.ALL_NULL",
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "Counter": "0,1,2,3",
         "Deprecated": "1",
-        "EventCode": "0x2",
-        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
         "PerPkg": "1",
-        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
         "UMask": "0x20",
-        "Unit": "UPI LL"
+        "Unit": "CHA"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/skylakex/uncore-power.json
new file mode 100644
index 000000000000..64301a600ede
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
@@ -0,0 +1,201 @@
+[
+    {
+        "BriefDescription": "pclk Cycles",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_CORE_TRANSITION_CYCLES",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_P_CORE_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_DEMOTIONS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_P_DEMOTIONS",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 0 Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x75",
+        "EventName": "UNC_P_FIVR_PS_PS0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 1 Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x76",
+        "EventName": "UNC_P_FIVR_PS_PS1_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 2 Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x77",
+        "EventName": "UNC_P_FIVR_PS_PS2_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Phase Shed 3 Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x78",
+        "EventName": "UNC_P_FIVR_PS_PS3_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_MCP_PROCHOT_CYCLES",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_P_MCP_PROCHOT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Memory Phase Shedding Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_P_PKG_RESIDENCY_C3_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "UNC_P_PMAX_THROTTLED_CYCLES",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_P_PMAX_THROTTLED_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C0 and C1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C6 and C7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Total Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
+        "PerPkg": "1",
+        "Unit": "PCU"
+    }
+]
--=20
2.25.1

