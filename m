Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E6590DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiHLIwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237831AbiHLIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:51:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B43A98DF;
        Fri, 12 Aug 2022 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294312; x=1691830312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=56a7PcZhOZ9Yw6MOlajv11MSptXFNK/c8XKDc5qgF7E=;
  b=W8fWpRdaW8WejApfJ5lvcZB415eYEI9ZmyjMWh6daHoX3f0J+OqLcGzL
   DOfoxlFyJVbZEf7x6FTKf4bMjX+W+hBZ7mkn+P3XlDTyKKII0CxqxZAlv
   LC/JKXxSn4BxMeNYMFhCnxtXxKx2T4SZuUL70eg54A4XMSogpfl8fckrR
   2BB0KrmBVcbGBZMWQe60aytBbExbyADaNdjFC8wlbKIaQ4dJpeWSmdmWb
   FJjg1kvu33KWH+AQcJHFTGuMA4iXGmkG+0gujrvMrjsS0IiTN4vNgBtDM
   5M5RPJQS//j7mRQUdFoBjLJsy3YUYAPIF+ihwRyf+W++ZG85cti+d1uwU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271328705"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271328705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451437"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:51:48 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 04/11] perf vendor events: Update events and metrics for haswellx
Date:   Fri, 12 Aug 2022 16:52:32 +0800
Message-Id: <20220812085239.3089231-5-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update the events to v25, the metrics are based on TMA 4.4 full, update
events and metrics for haswellx by the latest event converter tools.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the haswellx files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/haswellx/hsx-metrics.json        | 411 +++++++++++++++++-
 .../arch/x86/haswellx/uncore-cache.json       | 173 +-------
 2 files changed, 413 insertions(+), 171 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 5c9e008ca995..d31d76db9d84 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -74,12 +74,6 @@
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "UpTB"
     },
-    {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "Pipeline;Mem",
-        "MetricName": "CPI"
-    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -327,6 +321,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "cbox_0@event\\=3D0x0@ / #num_dies / duration_time /=
 1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
@@ -374,5 +374,404 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD  /  CPU_CLK_UNHALTED.REF_=
TSC  *  #SYSTEM_TSC_FREQ ) / 1000000000",
+        "MetricGroup": "",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": " CPU_CLK_UNHALTED.THREAD  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": " MEM_UOPS_RETIRED.ALL_LOADS  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": " MEM_UOPS_RETIRED.ALL_STORES  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": " L1D.REPLACEMENT  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "l1d_mpi_includes_data_plus_rfo_with_prefetches",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L1_HIT  /  INST_RETIRED.ANY =
",
+        "MetricGroup": "",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": " L2_RQSTS.ALL_CODE_RD  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L2_HIT  /  INST_RETIRED.ANY =
",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": " L2_LINES_IN.ALL  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "l2_mpi_includes_code_plus_data_plus_rfo_with_prefet=
ches",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": " MEM_LOAD_UOPS_RETIRED.L2_MISS  /  INST_RETIRED.ANY=
 ",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": " L2_RQSTS.CODE_RD_MISS  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions. This implies it missed in the ITLB (Instruction TLB) and further=
 levels of TLB.",
+        "MetricExpr": " ITLB_MISSES.WALK_COMPLETED  /  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "itlb_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions. This implies it missed in the Instruction =
Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "MetricExpr": " ITLB_MISSES.WALK_COMPLETED_2M_4M  /  INST_RETIRED.=
ANY ",
+        "MetricGroup": "",
+        "MetricName": "itlb_large_page_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions. This implies it missed in the DTLB and further levels of TL=
B.",
+        "MetricExpr": " DTLB_LOAD_MISSES.WALK_COMPLETED  /  INST_RETIRED.A=
NY ",
+        "MetricGroup": "",
+        "MetricName": "dtlb_load_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "MetricExpr": " DTLB_STORE_MISSES.WALK_COMPLETED  /  INST_RETIRED.=
ANY ",
+        "MetricGroup": "",
+        "MetricName": "dtlb_store_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Intel(R) Quick Path Interconnect (QPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_Q_TxL_FLITS_G0.DATA  * 8 / 1000000) / duratio=
n_time",
+        "MetricGroup": "",
+        "MetricName": "qpi_data_transmit_bw_only_data",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_CAS_COUNT.RD  * 64 / 1000000) / duration_ti=
me",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_CAS_COUNT.WR  * 64 / 1000000) / duration_ti=
me",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(( UNC_M_CAS_COUNT.RD  +  UNC_M_CAS_COUNT.WR ) * 64=
 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
19e@  * 64 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x=
1c8\\,filter_tid\\=3D0x3e@  * 64 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.DSB_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_frodecoded_icache_dsb",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.MITE_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_frolegacy_decode_pipeline_mi=
te",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.MS_UOPS  /  UOPS_ISSUED.ANY )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_fromicrocode_sequencer_ms",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uops delivered from loop stream detector(LSD)=
 as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "100 * ( UOPS_ISSUED.ANY  -  IDQ.MITE_UOPS  -  IDQ.M=
S_UOPS  -  IDQ.DSB_UOPS ) /  UOPS_ISSUED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_froloop_streadetector_lsd",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x182@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x192@ ) =
/  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=
=3D0x181@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x191@ ) =
/  INST_RETIRED.ANY ",
+        "MetricGroup": "",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "MetricExpr": "100 *  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_=
opc\\=3D0x182@  / ( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x1=
82@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x182@ )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_local_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "100 *  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_=
opc\\=3D0x182@  / ( cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x1=
82@  +  cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x182@ )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. Frontend denotes th=
e first part of the processor core responsible to fetch operations that are=
 executed later on by the Backend part. Within the Frontend; a branch predi=
ctor predicts the next address to fetch; cache-lines are fetched from the m=
emory subsystem; parsed into instructions; and lastly decoded into micro-op=
erations (uops). Ideally the Frontend can issue Machine_Width uops every cy=
cle to the Backend. Frontend Bound denotes unutilized issue-slots when ther=
e is no Backend stall; i.e. bubbles where Frontend delivered no uops while =
Backend could have accepted them. For example; stalls due to instruction-ca=
che misses would be categorized under Frontend Bound.",
+        "MetricExpr": "100 * (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) * (=
 (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTE=
D.THREAD  ) ) ) )",
+        "MetricGroup": "TmaL1, PGO",
+        "MetricName": "tma_frontend_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues.  For example; instruction-c=
ache misses; iTLB misses or fetch stalls after a branch misprediction are c=
ategorized under Frontend Latency. In such cases; the Frontend eventually d=
elivers no uops for some period.",
+        "MetricExpr": "100 * ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  , =
 IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_=
CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD=
  ) ) ) )",
+        "MetricGroup": "Frontend, TmaL2",
+        "MetricName": "tma_fetch_latency_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "100 * (  ICACHE.IFDATA_STALL  / (  CPU_CLK_UNHALTED=
.THREAD  ) )",
+        "MetricGroup": "BigFoot, FetchLat, IcMiss",
+        "MetricName": "tma_icache_misses_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
+        "MetricExpr": "100 * ( ( 14 *  ITLB_MISSES.STLB_HIT  +  ITLB_MISSE=
S.WALK_DURATION  ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
+        "MetricGroup": "BigFoot, FetchLat, MemoryTLB",
+        "MetricName": "tma_itlb_misses_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fron=
tend delay in fetching operations from corrected path; following all sorts =
of miss-predicted branches. For example; branchy code with lots of miss-pre=
dictions might get categorized under Branch Resteers. Note the value of thi=
s node may overlap with its siblings.",
+        "MetricExpr": "100 * ( ( 12 ) * (  BR_MISP_RETIRED.ALL_BRANCHES  +=
  MACHINE_CLEARS.COUNT  +  BACLEARS.ANY  ) / (  CPU_CLK_UNHALTED.THREAD  ) =
)",
+        "MetricGroup": "FetchLat",
+        "MetricName": "tma_branch_resteers_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines. The DSB (decod=
ed i-cache) is a Uop Cache where the front-end directly delivers Uops (micr=
o operations) avoiding heavy x86 decoding. The DSB pipeline has shorter lat=
ency and delivered higher bandwidth than the MITE (legacy instruction decod=
e pipeline). Switching between the two pipelines can cause penalties hence =
this metric measures the exposed penalty.",
+        "MetricExpr": "100 * (  DSB2MITE_SWITCHES.PENALTY_CYCLES  / (  CPU=
_CLK_UNHALTED.THREAD  ) )",
+        "MetricGroup": "DSBmiss, FetchLat",
+        "MetricName": "tma_dsb_switches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs). Using proper compiler =
flags or Intel Compiler by default will certainly avoid this. #Link: Optimi=
zation Guide about LCP BKMs.",
+        "MetricExpr": "100 * (  ILD_STALL.LCP  / (  CPU_CLK_UNHALTED.THREA=
D  ) )",
+        "MetricGroup": "FetchLat",
+        "MetricName": "tma_lcp_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS). Commonly used instructions are optimized for delivery by the=
 DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Certa=
in operations cannot be handled natively by the execution pipeline; and mus=
t be performed by microcode (small programs injected into the execution str=
eam). Switching to the MS too often can negatively impact performance. The =
MS is designated to deliver long uop flows required by CISC instructions li=
ke CPUID; or uncommon conditions like Floating Point Assists when dealing w=
ith Denormals.",
+        "MetricExpr": "100 * ( ( 2 ) *  IDQ.MS_SWITCHES  / (  CPU_CLK_UNHA=
LTED.THREAD  ) )",
+        "MetricGroup": "FetchLat, MicroSeq",
+        "MetricName": "tma_ms_switches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues.  For example; inefficienc=
ies at the instruction decoders; or restrictions for caching in the DSB (de=
coded uops cache) are categorized under Fetch Bandwidth. In such cases; the=
 Frontend typically delivers suboptimal amount of uops to the Backend.",
+        "MetricExpr": "100 * ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) *=
 ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHAL=
TED.THREAD  ) ) ) ) - ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOP=
S_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHA=
LTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) =
) )",
+        "MetricGroup": "FetchBW, Frontend, TmaL2",
+        "MetricName": "tma_fetch_bandwidth_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline). This pipeline is used for code that was not pre-cached in the=
 DSB or LSD. For example; inefficiencies due to asymmetric decoders; use of=
 long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
+        "MetricExpr": "100 * ( (  IDQ.ALL_MITE_CYCLES_ANY_UOPS  -  IDQ.ALL=
_MITE_CYCLES_4_UOPS  ) / ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_o=
n  else (  CPU_CLK_UNHALTED.THREAD  ) ) / 2 )",
+        "MetricGroup": "DSBmiss, FetchBW",
+        "MetricName": "tma_mite_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line.  For example; inefficient utilization of the DSB cache structure or b=
ank conflict when reading from it; are categorized here.",
+        "MetricExpr": "100 * ( (  IDQ.ALL_DSB_CYCLES_ANY_UOPS  -  IDQ.ALL_=
DSB_CYCLES_4_UOPS  ) / ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on =
 else (  CPU_CLK_UNHALTED.THREAD  ) ) / 2 )",
+        "MetricGroup": "DSB, FetchBW",
+        "MetricName": "tma_dsb_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. This include slots used to issue uops t=
hat do not eventually get retired and slots for which the issue-pipeline wa=
s blocked due to recovery from earlier incorrect speculation. For example; =
wasted work due to miss-predicted branches are categorized under Bad Specul=
ation category. Incorrect data speculation followed by Memory Ordering Nuke=
s is another example.",
+        "MetricExpr": "100 * ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIR=
E_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  =
else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREA=
D_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_bad_speculation_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction.  These slots are either wasted =
by uops fetched from an incorrectly speculated program path; or stalls when=
 the out-of-order part of the machine needs to recover its state from a spe=
culative path.",
+        "MetricExpr": "100 * ( (  BR_MISP_RETIRED.ALL_BRANCHES  / (  BR_MI=
SP_RETIRED.ALL_BRANCHES  +  MACHINE_CLEARS.COUNT  ) ) * ( (  UOPS_ISSUED.AN=
Y  - (  UOPS_RETIRED.RETIRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLE=
S_ANY  / 2 ) if  #SMT_on  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * (=
 (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTE=
D.THREAD  ) ) ) ) )",
+        "MetricGroup": "BadSpec, BrMispredicts, TmaL2",
+        "MetricName": "tma_branch_mispredicts_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears.  These slots are either wasted by uop=
s fetched prior to the clear; or stalls the out-of-order portion of the mac=
hine needs to recover its state after the clear. For example; this can happ=
en due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modify=
ing-Code (SMC) nukes.",
+        "MetricExpr": "100 * ( ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RET=
IRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on=
  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THR=
EAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) - ( ( =
 BR_MISP_RETIRED.ALL_BRANCHES  / (  BR_MISP_RETIRED.ALL_BRANCHES  +  MACHIN=
E_CLEARS.COUNT  ) ) * ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_SLOTS =
 ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  else  IN=
T_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  /=
 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
+        "MetricGroup": "BadSpec, MachineClears, TmaL2",
+        "MetricName": "tma_machine_clears_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. Backend is the portion of the processor cor=
e where the out-of-order scheduler dispatches ready uops into their respect=
ive execution units; and once completed these uops get retired according to=
 program order. For example; stalls due to data-cache misses or stalls due =
to the divider unit being overloaded are both categorized under Backend Bou=
nd. Backend Bound is further divided into two main categories: Memory Bound=
 and Core Bound.",
+        "MetricExpr": "100 * ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( (=
 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK=
_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_=
SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  el=
se  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_=
ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOP=
S_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2=
 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_backend_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck.  Memory Bound estimat=
es fraction of slots where pipeline is likely stalled due to demand load or=
 store instructions. This accounts mainly for (1) non-completed in-flight m=
emory demand loads which coincides with execution units starvation; in addi=
tion to (2) cases where stores could impose backpressure on the pipeline wh=
en many of them get buffered at the same time (less common out of the two).=
",
+        "MetricExpr": "100 * ( ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYC=
LE_ACTIVITY.STALLS_LDM_PENDING  ) ) +  RESOURCE_STALLS.SB  ) / ( ( ( min(  =
CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) + (  cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x3@  if ( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 =
) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMP=
TY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_=
DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.T=
HREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.=
1 ) else 0 ) +  RESOURCE_STALLS.SB  ) if  #SMT_on  else ( ( min(  CPU_CLK_U=
NHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUT=
ED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if =
( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@=
UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) - (  RS_EVENTS.EMPTY_CYCLES  if ( ( =
( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0=
_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) i=
f  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RE=
SOURCE_STALLS.SB  ) ) ) * ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / ( ( 4 )=
 * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNH=
ALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIRE_SLOT=
S  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  else  =
INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY =
 / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_RE=
TIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) i=
f  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) ) )",
+        "MetricGroup": "Backend, TmaL2",
+        "MetricName": "tma_memory_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache.  The L1 data cache typicall=
y has the shortest latency.  However; in certain cases like loads blocked o=
n older stores; a load might suffer due to high latency even though it is b=
eing satisfied by the L1. Another example is loads who miss in the TLB. The=
se cases are characterized by execution unit stalls; while some non-complet=
ed demand load lives in the machine without having that demand load missing=
 the L1 cache.",
+        "MetricExpr": "100 * ( max( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  =
CYCLE_ACTIVITY.STALLS_LDM_PENDING  ) ) -  CYCLE_ACTIVITY.STALLS_L1D_PENDING=
  ) / (  CPU_CLK_UNHALTED.THREAD  ) , 0 ) )",
+        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
+        "MetricName": "tma_l1_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 m=
isses/L2 hits) can improve the latency and increase performance.",
+        "MetricExpr": "100 * ( (  CYCLE_ACTIVITY.STALLS_L1D_PENDING  -  CY=
CLE_ACTIVITY.STALLS_L2_PENDING  ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
+        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
+        "MetricName": "tma_l2_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core. =
 Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency and=
 increase performance.",
+        "MetricExpr": "100 * ( (  MEM_LOAD_UOPS_RETIRED.L3_HIT  / (  MEM_L=
OAD_UOPS_RETIRED.L3_HIT  + ( 7 ) *  MEM_LOAD_UOPS_RETIRED.L3_MISS  ) ) *  C=
YCLE_ACTIVITY.STALLS_L2_PENDING  / (  CPU_CLK_UNHALTED.THREAD  ) )",
+        "MetricGroup": "CacheMisses, MemoryBound, TmaL3mem",
+        "MetricName": "tma_l3_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads. Better caching can i=
mprove the latency and increase performance.",
+        "MetricExpr": "100 * ( min( ( ( 1 - (  MEM_LOAD_UOPS_RETIRED.L3_HI=
T  / (  MEM_LOAD_UOPS_RETIRED.L3_HIT  + ( 7 ) *  MEM_LOAD_UOPS_RETIRED.L3_M=
ISS  ) ) ) *  CYCLE_ACTIVITY.STALLS_L2_PENDING  / (  CPU_CLK_UNHALTED.THREA=
D  ) ) , ( 1 ) ) )",
+        "MetricGroup": "MemoryBound, TmaL3mem",
+        "MetricName": "tma_drabound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write. Even though store accesses do not typically stall=
 out-of-order CPUs; there are few cases where stores can lead to actual sta=
lls. This metric will be flagged should RFO stores be a bottleneck.",
+        "MetricExpr": "100 * (  RESOURCE_STALLS.SB  / (  CPU_CLK_UNHALTED.=
THREAD  ) )",
+        "MetricGroup": "MemoryBound, TmaL3mem",
+        "MetricName": "tma_store_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck.  Shortage in hardware comput=
e resources; or dependencies in software's instructions are both categorize=
d under Core Bound. Hence it may indicate the machine ran out of an out-of-=
order resource; certain execution units are overloaded or dependencies in p=
rogram's data- or instruction-flow are limiting the performance (e.g. FP-ch=
ained long-latency arithmetic operations).",
+        "MetricExpr": "100 * ( ( 1 - ( (  IDQ_UOPS_NOT_DELIVERED.CORE  / (=
 ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_C=
LK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED.ANY  - (  UOPS_RETIRED.RETIR=
E_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CYCLES_ANY  / 2 ) if  #SMT_on  =
else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREA=
D_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  U=
OPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  /=
 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) ) - ( ( ( ( mi=
n(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.STALLS_LDM_PENDING  ) ) +  R=
ESOURCE_STALLS.SB  ) / ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVI=
TY.CYCLES_NO_EXECUTE  ) ) + (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (=
  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  C=
PU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CL=
K_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) =
/ ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CP=
U_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) if=
  #SMT_on  else ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (  cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  CPU_CLK_UNHA=
LTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@  ) -=
 (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHALTED.THREAD =
 ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( 4 ) * ( (  C=
PU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THR=
EAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) ) ) * ( 1 - ( (  IDQ=
_UOPS_NOT_DELIVERED.CORE  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2=
 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) + ( (  UOPS_ISSUED=
.ANY  - (  UOPS_RETIRED.RETIRE_SLOTS  ) + ( 4 ) * ( (  INT_MISC.RECOVERY_CY=
CLES_ANY  / 2 ) if  #SMT_on  else  INT_MISC.RECOVERY_CYCLES  ) ) / ( ( 4 ) =
* ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHA=
LTED.THREAD  ) ) ) ) + ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) * ( (  C=
PU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THR=
EAD  ) ) ) ) ) ) ) )",
+        "MetricGroup": "Backend, TmaL2, Compute",
+        "MetricName": "tma_core_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active. Divide and square root instructions are per=
formed by the Divider unit and can take considerably longer latency than in=
teger or Floating Point addition; subtraction; or multiplication.",
+        "MetricExpr": "100 * ( 10 *  ARITH.DIVIDER_UOPS  / ( (  CPU_CLK_UN=
HALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) =
)",
+        "MetricGroup": "",
+        "MetricName": "tma_divider_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related).  Two distinct categories can be attributed into this met=
ric: (1) heavy data-dependency among contiguous instructions would manifest=
 in this metric - such cases are often referred to as low Instruction Level=
 Parallelism (ILP). (2) Contention on some hardware execution unit other th=
an Divider. For example; when there are too many multiply operations.",
+        "MetricExpr": "100 * ( ( ( ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  C=
YCLE_ACTIVITY.CYCLES_NO_EXECUTE  ) ) + (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x1@  - (  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED=
.ANY  / (  CPU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D0x2@  ) ) / 2 - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( m=
in(  CPU_CLK_UNHALTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV=
.CORE  ) ) / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on =
 else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STAL=
LS.SB  ) if  #SMT_on  else ( ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTI=
VITY.CYCLES_NO_EXECUTE  ) ) +  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@  - (=
  cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@  if ( (  INST_RETIRED.ANY  / (  C=
PU_CLK_UNHALTED.THREAD  ) ) > 1.8 ) else  cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x2@  ) - (  RS_EVENTS.EMPTY_CYCLES  if ( ( ( 4 ) * ( min(  CPU_CLK_UNHA=
LTED.THREAD  ,  IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE  ) ) / ( ( =
4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_=
UNHALTED.THREAD  ) ) ) ) > 0.1 ) else 0 ) +  RESOURCE_STALLS.SB  ) ) -  RES=
OURCE_STALLS.SB  - ( min(  CPU_CLK_UNHALTED.THREAD  ,  CYCLE_ACTIVITY.STALL=
S_LDM_PENDING  ) ) ) / (  CPU_CLK_UNHALTED.THREAD  ) )",
+        "MetricGroup": "PortsUtil",
+        "MetricName": "tma_ports_utilization_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. Ideally=
; all pipeline slots would be attributed to the Retiring category.  Retirin=
g of 100% would indicate the maximum Pipeline_Width throughput was achieved=
.  Maximizing Retiring typically increases the Instructions-per-cycle (see =
IPC metric). Note that a high Retiring value does not necessary mean there =
is no room for more performance.  For example; Heavy-operations or Microcod=
e Assists are categorized under Retiring. They often indicate suboptimal pe=
rformance and can often be optimized or avoided. ",
+        "MetricExpr": "100 * ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 ) *=
 ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHAL=
TED.THREAD  ) ) ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_retiring_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UPI metric=
) ratio of 1 or less should be expected for decently optimized software run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved.",
+        "MetricExpr": "100 * ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) / ( ( 4 )=
 * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 ) if  #SMT_on  else (  CPU_CLK_UNH=
ALTED.THREAD  ) ) ) ) - ( ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS_ISSUE=
D.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  / 2 =
) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) ) )",
+        "MetricGroup": "Retire, TmaL2",
+        "MetricName": "tma_light_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
+        "MetricExpr": "100 * ( ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS=
_ISSUED.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY=
  / 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) ) )",
+        "MetricGroup": "Retire, TmaL2",
+        "MetricName": "tma_heavy_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The MS=
 is used for CISC instructions not supported by the default decoders (like =
repeat move strings; or CPUID); or by microcode assists used to address som=
e operation modes (like in Floating Point assists). These cases can often b=
e avoided.",
+        "MetricExpr": "100 * ( ( (  UOPS_RETIRED.RETIRE_SLOTS  ) /  UOPS_I=
SSUED.ANY  ) *  IDQ.MS_UOPS  / ( ( 4 ) * ( (  CPU_CLK_UNHALTED.THREAD_ANY  =
/ 2 ) if  #SMT_on  else (  CPU_CLK_UNHALTED.THREAD  ) ) ) )",
+        "MetricGroup": "MicroSeq",
+        "MetricName": "tma_microcode_sequencer_percent",
+        "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 03598904d746..56047f9c6f20 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -964,20 +964,19 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
+        "BriefDescription": "TOR Inserts; Opcode Match",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line)",
+        "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
         "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
         "PerPkg": "1",
         "UMask": "0x1",
@@ -994,17 +993,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=3D0x181",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -1016,17 +1004,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Streaming stores (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=3D0x18c",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -1038,17 +1015,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Streaming stores (partial cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=3D0x18d",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode",
         "Counter": "0,1,2,3",
@@ -1060,17 +1026,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe read current",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe write references (full cache line). Deri=
ved from unc_c_tor_inserts.opcode",
         "Counter": "0,1,2,3",
@@ -1082,17 +1037,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe write references (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Evictions",
         "Counter": "0,1,2,3",
@@ -1121,21 +1065,19 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "TOR Inserts; Miss Opcode Match",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x3",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches",
+        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "EventName": "LLC_MISSES.DATA_READ",
         "Filter": "filter_opc=3D0x182",
         "PerPkg": "1",
         "ScaleUnit": "64Bytes",
@@ -1153,17 +1095,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x187",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.mi=
ss_opcode",
         "Counter": "0,1,2,3",
@@ -1175,17 +1106,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "MMIO reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x187,filter_nc=3D1",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.m=
iss_opcode",
         "Counter": "0,1,2,3",
@@ -1197,17 +1117,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "MMIO writes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1219,17 +1128,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for RFO",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x190",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for code reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1241,17 +1139,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for code reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x191",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1263,17 +1150,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC prefetch misses for data reads",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x192",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1285,17 +1161,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "LLC misses for PCIe read current",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x19e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_op=
code",
         "Counter": "0,1,2,3",
@@ -1307,17 +1172,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x1c8",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "PCIe write misses (full cache line). Derived =
from unc_c_tor_inserts.miss_opcode",
         "Counter": "0,1,2,3",
@@ -1329,17 +1183,6 @@
         "UMask": "0x3",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "PCIe write misses (full cache line)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
-        "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; NID and Opcode Matched",
         "Counter": "0,1,2,3",
--=20
2.25.1

