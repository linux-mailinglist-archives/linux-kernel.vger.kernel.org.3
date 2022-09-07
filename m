Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD425B092E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIGPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIGPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:49:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92FAB1CB06;
        Wed,  7 Sep 2022 08:49:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7077106F;
        Wed,  7 Sep 2022 08:49:48 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B42B53F71A;
        Wed,  7 Sep 2022 08:49:40 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf vendor events: Update events for Neoverse E1
Date:   Wed,  7 Sep 2022 16:49:30 +0100
Message-Id: <20220907154932.60808-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These CPUs contain the same PMU events (as per the Arm Technical
Reference manuals for Cortex A65 and Neoverse E1)

This de-duplicates event data, and avoids issues in previous E1 event
data (not present in A65 data)
* Missing implementation defined events
* Inclusion of events that are not implemented:
  - L1D_CACHE_ALLOCATE
  - SAMPLE_POP
  - SAMPLE_FEED
  - SAMPLE_FILTRATE
  - SAMPLE_COLLISION

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
V1 -> V2: Remove proposed E1 changes. Use A65 data for A65 and E1 instead

.../{cortex-a65 => cortex-a65-e1}/branch.json |   0
 .../{cortex-a65 => cortex-a65-e1}/bus.json    |   0
 .../{cortex-a65 => cortex-a65-e1}/cache.json  |   0
 .../{cortex-a65 => cortex-a65-e1}/dpu.json    |   0
 .../exception.json                            |   0
 .../{cortex-a65 => cortex-a65-e1}/ifu.json    |   0
 .../instruction.json                          |   0
 .../{cortex-a65 => cortex-a65-e1}/memory.json |   0
 .../pipeline.json                             |   0
 .../arch/arm64/arm/neoverse-e1/branch.json    |  17 ---
 .../arch/arm64/arm/neoverse-e1/bus.json       |  17 ---
 .../arch/arm64/arm/neoverse-e1/cache.json     | 107 ------------------
 .../arch/arm64/arm/neoverse-e1/exception.json |  14 ---
 .../arm64/arm/neoverse-e1/instruction.json    |  65 -----------
 .../arch/arm64/arm/neoverse-e1/memory.json    |  23 ----
 .../arch/arm64/arm/neoverse-e1/pipeline.json  |   8 --
 .../arch/arm64/arm/neoverse-e1/spe.json       |  14 ---
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   4 +-
 18 files changed, 2 insertions(+), 267 deletions(-)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/dpu.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/exception.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/ifu.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/instruction.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/arm/{cortex-a65 => cortex-a65-e1}/pipeline.json (100%)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/branch.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/bus.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/cache.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/dpu.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/dpu.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/dpu.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/exception.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/ifu.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/instruction.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/memory.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/arm/cortex-a65/pipeline.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
deleted file mode 100644
index 2f2d137f5f55..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/branch.json
+++ /dev/null
@@ -1,17 +0,0 @@
-[
-    {
-        "ArchStdEvent": "BR_MIS_PRED"
-    },
-    {
-        "ArchStdEvent": "BR_PRED"
-    },
-    {
-        "ArchStdEvent": "BR_IMMED_SPEC"
-    },
-    {
-        "ArchStdEvent": "BR_RETURN_SPEC"
-    },
-    {
-        "ArchStdEvent": "BR_INDIRECT_SPEC"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
deleted file mode 100644
index 75d850b781ac..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/bus.json
+++ /dev/null
@@ -1,17 +0,0 @@
-[
-    {
-        "ArchStdEvent": "CPU_CYCLES"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS"
-    },
-    {
-        "ArchStdEvent": "BUS_CYCLES"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_RD"
-    },
-    {
-        "ArchStdEvent": "BUS_ACCESS_WR"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
deleted file mode 100644
index 3ad15e3a93a9..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
+++ /dev/null
@@ -1,107 +0,0 @@
-[
-    {
-        "ArchStdEvent": "L1I_CACHE_REFILL"
-    },
-    {
-        "ArchStdEvent": "L1I_TLB_REFILL"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE"
-    },
-    {
-        "ArchStdEvent": "L1D_TLB_REFILL"
-    },
-    {
-        "ArchStdEvent": "L1I_CACHE"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WB"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_REFILL"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_WB"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_ALLOCATE"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_ALLOCATE"
-    },
-    {
-        "ArchStdEvent": "L1D_TLB"
-    },
-    {
-        "ArchStdEvent": "L1I_TLB"
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE_ALLOCATE"
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE_REFILL"
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE"
-    },
-    {
-        "ArchStdEvent": "L2D_TLB_REFILL"
-    },
-    {
-        "ArchStdEvent": "L2D_TLB"
-    },
-    {
-        "ArchStdEvent": "DTLB_WALK"
-    },
-    {
-        "ArchStdEvent": "ITLB_WALK"
-    },
-    {
-        "ArchStdEvent": "LL_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "LL_CACHE_MISS_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_WR"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_WR"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
-    },
-    {
-        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE_RD"
-    },
-    {
-        "ArchStdEvent": "L3D_CACHE_REFILL_RD"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
deleted file mode 100644
index 27c3fe9c831a..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/exception.json
+++ /dev/null
@@ -1,14 +0,0 @@
-[
-    {
-        "ArchStdEvent": "EXC_TAKEN"
-    },
-    {
-        "ArchStdEvent": "MEMORY_ERROR"
-    },
-    {
-        "ArchStdEvent": "EXC_IRQ"
-    },
-    {
-        "ArchStdEvent": "EXC_FIQ"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
deleted file mode 100644
index 6c3b8f772e7f..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
+++ /dev/null
@@ -1,65 +0,0 @@
-[
-    {
-        "ArchStdEvent": "SW_INCR"
-    },
-    {
-        "ArchStdEvent": "LD_RETIRED"
-    },
-    {
-        "ArchStdEvent": "ST_RETIRED"
-    },
-    {
-        "ArchStdEvent": "INST_RETIRED"
-    },
-    {
-        "ArchStdEvent": "EXC_RETURN"
-    },
-    {
-        "ArchStdEvent": "CID_WRITE_RETIRED"
-    },
-    {
-        "ArchStdEvent": "PC_WRITE_RETIRED"
-    },
-    {
-        "ArchStdEvent": "BR_IMMED_RETIRED"
-    },
-    {
-        "ArchStdEvent": "BR_RETURN_RETIRED"
-    },
-    {
-        "ArchStdEvent": "INST_SPEC"
-    },
-    {
-        "ArchStdEvent": "TTBR_WRITE_RETIRED"
-    },
-    {
-        "ArchStdEvent": "BR_RETIRED"
-    },
-    {
-        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
-    },
-    {
-        "ArchStdEvent": "LD_SPEC"
-    },
-    {
-        "ArchStdEvent": "ST_SPEC"
-    },
-    {
-        "ArchStdEvent": "LDST_SPEC"
-    },
-    {
-        "ArchStdEvent": "DP_SPEC"
-    },
-    {
-        "ArchStdEvent": "ASE_SPEC"
-    },
-    {
-        "ArchStdEvent": "VFP_SPEC"
-    },
-    {
-        "ArchStdEvent": "CRYPTO_SPEC"
-    },
-    {
-        "ArchStdEvent": "ISB_SPEC"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
deleted file mode 100644
index 78ed6dfcedc1..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
+++ /dev/null
@@ -1,23 +0,0 @@
-[
-    {
-        "ArchStdEvent": "MEM_ACCESS"
-    },
-    {
-        "ArchStdEvent": "REMOTE_ACCESS_RD"
-    },
-    {
-        "ArchStdEvent": "MEM_ACCESS_RD"
-    },
-    {
-        "ArchStdEvent": "MEM_ACCESS_WR"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_LD_SPEC"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_ST_SPEC"
-    },
-    {
-        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
deleted file mode 100644
index eeac798d403a..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/pipeline.json
+++ /dev/null
@@ -1,8 +0,0 @@
-[
-    {
-        "ArchStdEvent": "STALL_FRONTEND"
-    },
-    {
-        "ArchStdEvent": "STALL_BACKEND"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
deleted file mode 100644
index 20f2165c85fe..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
+++ /dev/null
@@ -1,14 +0,0 @@
-[
-    {
-        "ArchStdEvent": "SAMPLE_POP"
-    },
-    {
-        "ArchStdEvent": "SAMPLE_FEED"
-    },
-    {
-        "ArchStdEvent": "SAMPLE_FILTRATE"
-    },
-    {
-        "ArchStdEvent": "SAMPLE_COLLISION"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 406f6edd4e12..ad502d00f460 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -17,7 +17,8 @@
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd040,v1,arm/cortex-a35,core
 0x00000000410fd050,v1,arm/cortex-a55,core
-0x00000000410fd060,v1,arm/cortex-a65,core
+0x00000000410fd060,v1,arm/cortex-a65-e1,core
+0x00000000410fd4a0,v1,arm/cortex-a65-e1,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000410fd090,v1,arm/cortex-a73,core
@@ -34,7 +35,6 @@
 0x00000000410fd470,v1,arm/cortex-a710,core
 0x00000000410fd480,v1,arm/cortex-x2,core
 0x00000000410fd490,v1,arm/neoverse-n2,core
-0x00000000410fd4a0,v1,arm/neoverse-e1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.25.1

