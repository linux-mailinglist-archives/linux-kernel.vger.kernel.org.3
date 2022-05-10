Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955B55212CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbiEJK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiEJKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC0732B030D;
        Tue, 10 May 2022 03:49:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8447E15DB;
        Tue, 10 May 2022 03:49:25 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19B213F66F;
        Tue, 10 May 2022 03:49:22 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Subject: [PATCH 14/20] perf vendors events arm64: Arm Cortex-A75
Date:   Tue, 10 May 2022 11:47:52 +0100
Message-Id: <20220510104758.64677-15-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU events for Arm Cortex-A75
Add corresponding common events
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a75.json

which is based on PMU event descriptions from the Arm Cortex-A75 Technical
Reference Manual.

Common event data based on:
https://github.com/ARM-software/data/blob/master/pmu/common_armv9.json

which is based on PMU event descriptions found in the Arm Architecture
Reference Manual:
https://developer.arm.com/documentation/ddi0487/

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a75/branch.json     |  11 ++
 .../arch/arm64/arm/cortex-a75/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a75/cache.json      | 164 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a75/etm.json        |  14 ++
 .../arch/arm64/arm/cortex-a75/exception.json  |  17 ++
 .../arm64/arm/cortex-a75/instruction.json     |  74 ++++++++
 .../arch/arm64/arm/cortex-a75/memory.json     |  17 ++
 .../arch/arm64/arm/cortex-a75/mmu.json        |  44 +++++
 .../arch/arm64/arm/cortex-a75/pipeline.json   |  44 +++++
 .../arch/arm64/common-and-microarch.json      |   6 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 11 files changed, 409 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
new file mode 100644
index 000000000000..ece201718284
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/branch.json
@@ -0,0 +1,11 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/bus.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS"
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
new file mode 100644
index 000000000000..7efa09800a51
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/cache.json
@@ -0,0 +1,164 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB"
+    },
+    {
+        "ArchStdEvent": "L2I_TLB"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK"
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction cache - Tag RAM",
+        "EventCode": "0xC2",
+        "EventName": "I_TAG_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction cache - Tag RAM"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction cache - Data RAM",
+        "EventCode": "0xC3",
+        "EventName": "I_DATA_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction cache - Data RAM"
+    },
+    {
+        "PublicDescription": "Number of ways read in the instruction BTAC RAM",
+        "EventCode": "0xC4",
+        "EventName": "I_BTAC_RAM_RD",
+        "BriefDescription": "Number of ways read in the instruction BTAC RAM"
+    },
+    {
+        "PublicDescription": "Level 1 PLD TLB refill",
+        "EventCode": "0xE7",
+        "EventName": "L1PLD_TLB_REFILL",
+        "BriefDescription": "Level 1 PLD TLB refill"
+    },
+    {
+        "PublicDescription": "Level 2 preload and MMU prefetcher TLB access. This event only counts software and hardware prefetches at Level 2",
+        "EventCode": "0xE8",
+        "EventName": "L2PLD_TLB",
+        "BriefDescription": "Level 2 preload and MMU prefetcher TLB access. This event only counts software and hardware prefetches at Level 2"
+    },
+    {
+        "PublicDescription": "Level 1 TLB flush",
+        "EventCode": "0xE9",
+        "EventName": "UTLB_FLUSH",
+        "BriefDescription": "Level 1 TLB flush"
+    },
+    {
+        "PublicDescription": "Level 2 TLB access",
+        "EventCode": "0xEA",
+        "EventName": "TLB_ACCESS",
+        "BriefDescription": "Level 2 TLB access"
+    },
+    {
+        "PublicDescription": "Level 1 preload TLB access. This event only counts software and hardware prefetches at Level 1. This event counts all accesses to the preload data micro TLB, that is L1 prefetcher and preload instructions. This event does not take into account whether the MMU is enabled or not",
+        "EventCode": "0xEB",
+        "EventName": "L1PLD_TLB",
+        "BriefDescription": "Level 1 preload TLB access. This event only counts software and hardware prefetches at Level 1. This event counts all accesses to the preload data micro TLB, that is L1 prefetcher and preload instructions. This event does not take into account whether the MMU is enabled or not"
+    },
+    {
+        "PublicDescription": "Prefetch access to unified TLB that caused a page table walk. This event counts software and hardware prefetches",
+        "EventCode": "0xEC",
+        "EventName": "PLDTLB_WALK",
+        "BriefDescription": "Prefetch access to unified TLB that caused a page table walk. This event counts software and hardware prefetches"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
new file mode 100644
index 000000000000..fce852e82369
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/etm.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "ETM trace unit output 0",
+        "EventCode": "0xDE",
+        "EventName": "ETM_EXT_OUT0",
+        "BriefDescription": "ETM trace unit output 0"
+    },
+    {
+        "PublicDescription": "ETM trace unit output 1",
+        "EventCode": "0xDF",
+        "EventName": "ETM_EXT_OUT1",
+        "BriefDescription": "ETM trace unit output 1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
new file mode 100644
index 000000000000..5b04d01de703
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/exception.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "PublicDescription": "Number of traps to hypervisor. This event counts the number of exception traps taken to EL2, excluding HVC instructions. This event is set every time that an exception is executed because of a decoded trap to the hypervisor. CCFAIL exceptions and traps caused by HVC instructions are excluded. This event is not counted when it is accessible from Non-secure EL0 or EL1",
+        "EventCode": "0xDC",
+        "EventName": "EXC_TRAP_HYP",
+        "BriefDescription": "Number of traps to hypervisor. This event counts the number of exception traps taken to EL2, excluding HVC instructions. This event is set every time that an exception is executed because of a decoded trap to the hypervisor. CCFAIL exceptions and traps caused by HVC instructions are excluded. This event is not counted when it is accessible from Non-secure EL0 or EL1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
new file mode 100644
index 000000000000..930ce8a259f3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/instruction.json
@@ -0,0 +1,74 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED"
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
new file mode 100644
index 000000000000..929fc545470f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/memory.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
new file mode 100644
index 000000000000..0e63e68bc8cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/mmu.json
@@ -0,0 +1,44 @@
+[
+    {
+        "PublicDescription": "Duration of a translation table walk handled by the MMU",
+        "EventCode": "0xE0",
+        "EventName": "MMU_PTW",
+        "BriefDescription": "Duration of a translation table walk handled by the MMU"
+    },
+    {
+        "PublicDescription": "Duration of a Stage 1 translation table walk handled by the MMU. This event is not counted when it is accessible from Non-secure EL0 or EL1",
+        "EventCode": "0xE1",
+        "EventName": "MMU_PTW_ST1",
+        "BriefDescription": "Duration of a Stage 1 translation table walk handled by the MMU. This event is not counted when it is accessible from Non-secure EL0 or EL1"
+    },
+    {
+        "PublicDescription": "Duration of a Stage 2 translation table walk handled by the MMU. This event is not counted when it is accessible from Non-secure EL0 or EL1",
+        "EventCode": "0xE2",
+        "EventName": "MMU_PTW_ST2",
+        "BriefDescription": "Duration of a Stage 2 translation table walk handled by the MMU. This event is not counted when it is accessible from Non-secure EL0 or EL1"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by the LSU",
+        "EventCode": "0xE3",
+        "EventName": "MMU_PTW_LSU",
+        "BriefDescription": "Duration of a translation table walk requested by the LSU"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by the instruction side",
+        "EventCode": "0xE4",
+        "EventName": "MMU_PTW_ISIDE",
+        "BriefDescription": "Duration of a translation table walk requested by the instruction side"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by a Preload instruction or Prefetch request",
+        "EventCode": "0xE5",
+        "EventName": "MMU_PTW_PLD",
+        "BriefDescription": "Duration of a translation table walk requested by a Preload instruction or Prefetch request"
+    },
+    {
+        "PublicDescription": "Duration of a translation table walk requested by an address translation operation",
+        "EventCode": "0xE6",
+        "EventName": "MMU_PTW_CP15",
+        "BriefDescription": "Duration of a translation table walk requested by an address translation operation"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
new file mode 100644
index 000000000000..0f8f50823cf1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json
@@ -0,0 +1,44 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "PublicDescription": "A linefill caused an instruction side stall",
+        "EventCode": "0xC0",
+        "EventName": "LF_STALL",
+        "BriefDescription": "A linefill caused an instruction side stall"
+    },
+    {
+        "PublicDescription": "A translation table walk caused an instruction side stall",
+        "EventCode": "0xC1",
+        "EventName": "PTW_STALL",
+        "BriefDescription": "A translation table walk caused an instruction side stall"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the Load-Store Unit (LSU) are busy",
+        "EventCode": "0xD3",
+        "EventName": "D_LSU_SLOT_FULL",
+        "BriefDescription": "Duration for which all slots in the Load-Store Unit (LSU) are busy"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the load-store issue queue are busy. This event counts the cycles where all slots in the LS IQs are full with micro-operations waiting for issuing, and the dispatch stage is not empty",
+        "EventCode": "0xD8",
+        "EventName": "LS_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the load-store issue queue are busy. This event counts the cycles where all slots in the LS IQs are full with micro-operations waiting for issuing, and the dispatch stage is not empty"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the data processing issue queue are busy. This event counts the cycles where all slots in the DP0 and DP1 IQs are full with micro-operations waiting for issuing, and the despatch stage is not empty",
+        "EventCode": "0xD9",
+        "EventName": "DP_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the data processing issue queue are busy. This event counts the cycles where all slots in the DP0 and DP1 IQs are full with micro-operations waiting for issuing, and the despatch stage is not empty"
+    },
+    {
+        "PublicDescription": "Duration for which all slots in the data engine issue queue are busy. This event is set every time that the data engine rename has at least one valid instruction, excluding No Operations (NOPs), that cannot move to the issue stage because accpt_instr is LOW",
+        "EventCode": "0xDA",
+        "EventName": "DE_IQ_FULL",
+        "BriefDescription": "Duration for which all slots in the data engine issue queue are busy. This event is set every time that the data engine rename has at least one valid instruction, excluding No Operations (NOPs), that cannot move to the issue stage because accpt_instr is LOW"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 876b51dae92e..492083b99256 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -179,6 +179,12 @@
         "EventName": "BUS_CYCLES",
         "BriefDescription": "Bus cycle"
     },
+    {
+        "PublicDescription": "Level 1 data cache allocation without refill",
+        "EventCode": "0x1F",
+        "EventName": "L1D_CACHE_ALLOCATE",
+        "BriefDescription": "Level 1 data cache allocation without refill"
+    },
     {
         "PublicDescription": "Attributable Level 2 data cache allocation without refill",
         "EventCode": "0x20",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f413d8b629de..43cdeae3f1b6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -28,6 +28,7 @@
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd090,v1,arm/cortex-a73,core
+0x00000000410fd0a0,v1,arm/cortex-a75,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
-- 
2.25.1

