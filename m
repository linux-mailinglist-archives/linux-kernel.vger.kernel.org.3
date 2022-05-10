Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65CE5212C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiEJKzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiEJKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 485212AD743;
        Tue, 10 May 2022 03:49:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 163451595;
        Tue, 10 May 2022 03:49:15 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 834FD3F66F;
        Tue, 10 May 2022 03:49:12 -0700 (PDT)
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
Subject: [PATCH 10/20] perf vendors events arm64: Arm Cortex-A55
Date:   Tue, 10 May 2022 11:47:48 +0100
Message-Id: <20220510104758.64677-11-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A55
Add corresponding common events
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a55.json

which is based on PMU event descriptions from the Arm Cortex-A55 Technical
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
 .../arch/arm64/arm/cortex-a55/branch.json     |  59 ++++++
 .../arch/arm64/arm/cortex-a55/bus.json        |  17 ++
 .../arch/arm64/arm/cortex-a55/cache.json      | 188 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a55/exception.json  |  20 ++
 .../arm64/arm/cortex-a55/instruction.json     |  65 ++++++
 .../arch/arm64/arm/cortex-a55/memory.json     |  17 ++
 .../arch/arm64/arm/cortex-a55/pipeline.json   |  80 ++++++++
 .../arch/arm64/common-and-microarch.json      |   6 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 9 files changed, 453 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
new file mode 100644
index 000000000000..8633d5db42a0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/branch.json
@@ -0,0 +1,59 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "PublicDescription": "Predicted conditional branch executed.This event counts when any branch which can be predicted by the conditional predictor is retired. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xC9",
+        "EventName": "BR_COND_PRED",
+        "BriefDescription": "Predicted conditional branch executed.This event counts when any branch which can be predicted by the conditional predictor is retired. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Indirect branch mis-predicted.This event counts when any indirect branch which can be predicted by the BTAC is retired, and has mispredicted for either the condition or the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCA",
+        "EventName": "BR_INDIRECT_MIS_PRED",
+        "BriefDescription": "Indirect branch mis-predicted.This event counts when any indirect branch which can be predicted by the BTAC is retired, and has mispredicted for either the condition or the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Indirect branch mis-predicted due to address mis-compare.This event counts when any indirect branch which can be predicted by the BTAC is retired, was taken and correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCB",
+        "EventName": "BR_INDIRECT_ADDR_MIS_PRED",
+        "BriefDescription": "Indirect branch mis-predicted due to address mis-compare.This event counts when any indirect branch which can be predicted by the BTAC is retired, was taken and correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Conditional branch mis-predicted.This event counts when any branch which can be predicted by the conditional predictor is retired, and has mis-predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off. Conditional indirect branches which correctly predicted the condition but mis-predicted on the address do not count this event",
+        "EventCode": "0xCC",
+        "EventName": "BR_COND_MIS_PRED",
+        "BriefDescription": "Conditional branch mis-predicted.This event counts when any branch which can be predicted by the conditional predictor is retired, and has mis-predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off. Conditional indirect branches which correctly predicted the condition but mis-predicted on the address do not count this event"
+    },
+    {
+        "PublicDescription": "Indirect branch with predicted address executed.This event counts when any indirect branch which can be predicted by the BTAC is retired, was taken and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCD",
+        "EventName": "BR_INDIRECT_ADDR_PRED",
+        "BriefDescription": "Indirect branch with predicted address executed.This event counts when any indirect branch which can be predicted by the BTAC is retired, was taken and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Procedure return with predicted address executed.This event counts when any procedure return which can be predicted by the CRS is retired, was taken and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCE",
+        "EventName": "BR_RETURN_ADDR_PRED",
+        "BriefDescription": "Procedure return with predicted address executed.This event counts when any procedure return which can be predicted by the CRS is retired, was taken and correctly predicted the condition. This event still counts when branch prediction is disabled due to the MMU being off"
+    },
+    {
+        "PublicDescription": "Procedure return mis-predicted due to address mis-compare.This event counts when any procedure return which can be predicted by the CRS is retired, was taken and correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off",
+        "EventCode": "0xCF",
+        "EventName": "BR_RETURN_ADDR_MIS_PRED",
+        "BriefDescription": "Procedure return mis-predicted due to address mis-compare.This event counts when any procedure return which can be predicted by the CRS is retired, was taken and correctly predicted the condition, and has mispredicted the address. This event still counts when branch prediction is disabled due to the MMU being off"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
new file mode 100644
index 000000000000..cd684c7ae026
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/cache.json
@@ -0,0 +1,188 @@
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
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
+    },
+    {
+        "PublicDescription": "Level 3 cache refill due to prefetch. This event counts any linefills from the hardware prefetcher which cause an allocation into the L3 cache. Note It might not be possible to both distinguish hardware vs software prefetches and also which prefetches cause an allocation. If so, only hardware prefetches should be counted, regardless of whether they allocate. If either the core is configured without a per-core L2 or the cluster is configured without an L3 cache, this event is not implemented",
+        "EventCode": "0xC0",
+        "EventName": "L3D_CACHE_REFILL_PREFETCH",
+        "BriefDescription": "Level 3 cache refill due to prefetch. This event counts any linefills from the hardware prefetcher which cause an allocation into the L3 cache. Note It might not be possible to both distinguish hardware vs software prefetches and also which prefetches cause an allocation. If so, only hardware prefetches should be counted, regardless of whether they allocate. If either the core is configured without a per-core L2 or the cluster is configured without an L3 cache, this event is not implemented"
+    },
+    {
+        "PublicDescription": "Level 2 cache refill due to prefetch. +//0 If the core is configured with a per-core L2 cache: This event does not count. +//0 If the core is configured without a per-core L2 cache: This event counts the cluster cache event, as defined by L3D_CACHE_REFILL_PREFETCH. +//0 If there is neither a per-core cache nor a cluster cache configured, this event is not implemented",
+        "EventCode": "0xC1",
+        "EventName": "L2D_CACHE_REFILL_PREFETCH",
+        "BriefDescription": "Level 2 cache refill due to prefetch. +//0 If the core is configured with a per-core L2 cache: This event does not count. +//0 If the core is configured without a per-core L2 cache: This event counts the cluster cache event, as defined by L3D_CACHE_REFILL_PREFETCH. +//0 If there is neither a per-core cache nor a cluster cache configured, this event is not implemented"
+    },
+    {
+        "PublicDescription": "Level 1 data cache refill due to prefetch. This event counts any linefills from the prefetcher which cause an allocation into the L1 D-cache",
+        "EventCode": "0xC2",
+        "EventName": "L1D_CACHE_REFILL_PREFETCH",
+        "BriefDescription": "Level 1 data cache refill due to prefetch. This event counts any linefills from the prefetcher which cause an allocation into the L1 D-cache"
+    },
+    {
+        "PublicDescription": "Level 2 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L2 cache",
+        "EventCode": "0xC3",
+        "EventName": "L2D_WS_MODE",
+        "BriefDescription": "Level 2 cache write streaming mode. This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L2 cache"
+    },
+    {
+        "PublicDescription": "Level 1 data cache entering write streaming mode.This event counts for each entry into write-streaming mode",
+        "EventCode": "0xC4",
+        "EventName": "L1D_WS_MODE_ENTRY",
+        "BriefDescription": "Level 1 data cache entering write streaming mode.This event counts for each entry into write-streaming mode"
+    },
+    {
+        "PublicDescription": "Level 1 data cache write streaming mode.This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L1 D-cache",
+        "EventCode": "0xC5",
+        "EventName": "L1D_WS_MODE",
+        "BriefDescription": "Level 1 data cache write streaming mode.This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L1 D-cache"
+    },
+    {
+        "PublicDescription": "Level 3 cache write streaming mode.This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L3 cache",
+        "EventCode": "0xC7",
+        "EventName": "L3D_WS_MODE",
+        "BriefDescription": "Level 3 cache write streaming mode.This event counts for each cycle where the core is in write-streaming mode and not allocating writes into the L3 cache"
+    },
+    {
+        "PublicDescription": "Level 2 TLB last-level walk cache access.This event does not count if the MMU is disabled",
+        "EventCode": "0xD0",
+        "EventName": "L2D_LLWALK_TLB",
+        "BriefDescription": "Level 2 TLB last-level walk cache access.This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB last-level walk cache refill.This event does not count if the MMU is disabled",
+        "EventCode": "0xD1",
+        "EventName": "L2D_LLWALK_TLB_REFILL",
+        "BriefDescription": "Level 2 TLB last-level walk cache refill.This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB level-2 walk cache access.This event counts accesses to the level-2 walk cache where the last-level walk cache has missed. The event only counts when the translation regime of the pagewalk uses level 2 descriptors. This event does not count if the MMU is disabled",
+        "EventCode": "0xD2",
+        "EventName": "L2D_L2WALK_TLB",
+        "BriefDescription": "Level 2 TLB level-2 walk cache access.This event counts accesses to the level-2 walk cache where the last-level walk cache has missed. The event only counts when the translation regime of the pagewalk uses level 2 descriptors. This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB level-2 walk cache refill.This event does not count if the MMU is disabled",
+        "EventCode": "0xD3",
+        "EventName": "L2D_L2WALK_TLB_REFILL",
+        "BriefDescription": "Level 2 TLB level-2 walk cache refill.This event does not count if the MMU is disabled"
+    },
+    {
+        "PublicDescription": "Level 2 TLB IPA cache access. This event counts on each access to the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access is counted. +//0 If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xD4",
+        "EventName": "L2D_S2_TLB",
+        "BriefDescription": "Level 2 TLB IPA cache access. This event counts on each access to the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access is counted. +//0 If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "Level 2 TLB IPA cache refill. This event counts on each refill of the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access which causes a refill is counted. +//0 If stage 2 translation is disabled, this event does not count",
+        "EventCode": "0xD5",
+        "EventName": "L2D_S2_TLB_REFILL",
+        "BriefDescription": "Level 2 TLB IPA cache refill. This event counts on each refill of the IPA cache. +//0 If a single pagewalk needs to make multiple accesses to the IPA cache, each access which causes a refill is counted. +//0 If stage 2 translation is disabled, this event does not count"
+    },
+    {
+        "PublicDescription": "Level 2 cache stash dropped.This event counts on each stash request received from the interconnect or ACP, that is targeting L2 and gets dropped due to lack of buffer space to hold the request",
+        "EventCode": "0xD6",
+        "EventName": "L2D_CACHE_STASH_DROPPED",
+        "BriefDescription": "Level 2 cache stash dropped.This event counts on each stash request received from the interconnect or ACP, that is targeting L2 and gets dropped due to lack of buffer space to hold the request"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
new file mode 100644
index 000000000000..99f1ab987709
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/exception.json
@@ -0,0 +1,20 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "PublicDescription": "Predecode error",
+        "EventCode": "0xC6",
+        "EventName": "PREDECODE_ERROR",
+        "BriefDescription": "Predecode error"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
new file mode 100644
index 000000000000..e762fab9e2d8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/instruction.json
@@ -0,0 +1,65 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "LD_RETIRED"
+    },
+    {
+        "ArchStdEvent": "ST_RETIRED"
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
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
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
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
new file mode 100644
index 000000000000..d9229173d189
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/memory.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_RETIRED"
+    },
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
new file mode 100644
index 000000000000..6c6b5869cf70
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a55/pipeline.json
@@ -0,0 +1,80 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, cache miss.This event counts every cycle the DPU IQ is empty and there is an instruction cache miss being processed",
+        "EventCode": "0xE1",
+        "EventName": "STALL_FRONTEND_CACHE",
+        "BriefDescription": "No operation issued due to the frontend, cache miss.This event counts every cycle the DPU IQ is empty and there is an instruction cache miss being processed"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, TLB miss.This event counts every cycle the DPU IQ is empty and there is an instruction L1 TLB miss being processed",
+        "EventCode": "0xE2",
+        "EventName": "STALL_FRONTEND_TLB",
+        "BriefDescription": "No operation issued due to the frontend, TLB miss.This event counts every cycle the DPU IQ is empty and there is an instruction L1 TLB miss being processed"
+    },
+    {
+        "PublicDescription": "No operation issued due to the frontend, pre-decode error.This event counts every cycle the DPU IQ is empty and there is a pre-decode error being processed",
+        "EventCode": "0xE3",
+        "EventName": "STALL_FRONTEND_PDERR",
+        "BriefDescription": "No operation issued due to the frontend, pre-decode error.This event counts every cycle the DPU IQ is empty and there is a pre-decode error being processed"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend interlock.This event counts every cycle that issue is stalled and there is an interlock. Stall cycles due to a stall in Wr (typically awaiting load data) are excluded",
+        "EventCode": "0xE4",
+        "EventName": "STALL_BACKEND_ILOCK",
+        "BriefDescription": "No operation issued due to the backend interlock.This event counts every cycle that issue is stalled and there is an interlock. Stall cycles due to a stall in Wr (typically awaiting load data) are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, interlock, AGU.This event counts every cycle that issue is stalled and there is an interlock that is due to a load/store instruction waiting for data to calculate the address in the AGU. Stall cycles due to a stall in Wr (typically awaiting load data) are excluded",
+        "EventCode": "0xE5",
+        "EventName": "STALL_BACKEND_ILOCK_AGU",
+        "BriefDescription": "No operation issued due to the backend, interlock, AGU.This event counts every cycle that issue is stalled and there is an interlock that is due to a load/store instruction waiting for data to calculate the address in the AGU. Stall cycles due to a stall in Wr (typically awaiting load data) are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, interlock, FPU.This event counts every cycle that issue is stalled and there is an interlock that is due to an FPU/NEON instruction. Stall cycles due to a stall in the Wr stage (typically awaiting load data) are excluded",
+        "EventCode": "0xE6",
+        "EventName": "STALL_BACKEND_ILOCK_FPU",
+        "BriefDescription": "No operation issued due to the backend, interlock, FPU.This event counts every cycle that issue is stalled and there is an interlock that is due to an FPU/NEON instruction. Stall cycles due to a stall in the Wr stage (typically awaiting load data) are excluded"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load.This event counts every cycle there is a stall in the Wr stage due to a load",
+        "EventCode": "0xE7",
+        "EventName": "STALL_BACKEND_LD",
+        "BriefDescription": "No operation issued due to the backend, load.This event counts every cycle there is a stall in the Wr stage due to a load"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store.This event counts every cycle there is a stall in the Wr stage due to a store",
+        "EventCode": "0xE8",
+        "EventName": "STALL_BACKEND_ST",
+        "BriefDescription": "No operation issued due to the backend, store.This event counts every cycle there is a stall in the Wr stage due to a store"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load, cache miss.This event counts every cycle there is a stall in the Wr stage due to a load which is waiting on data (due to missing the cache or being non-cacheable)",
+        "EventCode": "0xE9",
+        "EventName": "STALL_BACKEND_LD_CACHE",
+        "BriefDescription": "No operation issued due to the backend, load, cache miss.This event counts every cycle there is a stall in the Wr stage due to a load which is waiting on data (due to missing the cache or being non-cacheable)"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, load, TLB miss.This event counts every cycle there is a stall in the Wr stage due to a load which has missed in the L1 TLB",
+        "EventCode": "0xEA",
+        "EventName": "STALL_BACKEND_LD_TLB",
+        "BriefDescription": "No operation issued due to the backend, load, TLB miss.This event counts every cycle there is a stall in the Wr stage due to a load which has missed in the L1 TLB"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store, STB full.This event counts every cycle there is a stall in the Wr stage due to a store which is waiting due to the STB being full",
+        "EventCode": "0xEB",
+        "EventName": "STALL_BACKEND_ST_STB",
+        "BriefDescription": "No operation issued due to the backend, store, STB full.This event counts every cycle there is a stall in the Wr stage due to a store which is waiting due to the STB being full"
+    },
+    {
+        "PublicDescription": "No operation issued due to the backend, store, TLB miss.This event counts every cycle there is a stall in the Wr stage due to a store which has missed in the L1 TLB",
+        "EventCode": "0xEC",
+        "EventName": "STALL_BACKEND_ST_TLB",
+        "BriefDescription": "No operation issued due to the backend, store, TLB miss.This event counts every cycle there is a stall in the Wr stage due to a store which has missed in the L1 TLB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 20923bf10adc..c50b231ce03b 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -293,6 +293,12 @@
         "EventName": "LL_CACHE_MISS_RD",
         "BriefDescription": "Last level cache miss, read"
     },
+    {
+        "PublicDescription": "Attributable memory read access to another socket in a multi-socket system",
+        "EventCode": "0x38",
+        "EventName": "REMOTE_ACCESS_RD",
+        "BriefDescription": "Attributable memory read access to another socket in a multi-socket system"
+    },
     {
         "PublicDescription": "Level 1 data cache long-latency read miss.  The counter counts each memory read access counted by L1D_CACHE that incurs additional latency because it returns data from outside the Level 1 data or unified cache of this processing element.",
         "EventCode": "0x39",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 2ce90180e3fa..b8f0a299d204 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -23,6 +23,7 @@
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd040,v1,arm/cortex-a35,core
+0x00000000410fd050,v1,arm/cortex-a55,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
-- 
2.25.1

