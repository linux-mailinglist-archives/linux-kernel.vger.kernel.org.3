Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D805212DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiEJK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbiEJKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BD042B032B;
        Tue, 10 May 2022 03:49:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2877E1650;
        Tue, 10 May 2022 03:49:28 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AECB03F66F;
        Tue, 10 May 2022 03:49:25 -0700 (PDT)
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
Subject: [PATCH 15/20] perf vendors events arm64: Arm Cortex-A77
Date:   Tue, 10 May 2022 11:47:53 +0100
Message-Id: <20220510104758.64677-16-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510104758.64677-1-nick.forrington@arm.com>
References: <20220510104758.64677-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU events for Arm Cortex-A77
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a77.json

which is based on PMU event descriptions from the Arm Cortex-A77 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a77/branch.json     |  17 +++
 .../arch/arm64/arm/cortex-a77/bus.json        |  17 +++
 .../arch/arm64/arm/cortex-a77/cache.json      | 143 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a77/exception.json  |  47 ++++++
 .../arm64/arm/cortex-a77/instruction.json     |  77 ++++++++++
 .../arch/arm64/arm/cortex-a77/memory.json     |  23 +++
 .../arch/arm64/arm/cortex-a77/pipeline.json   |   8 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 8 files changed, 333 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
new file mode 100644
index 000000000000..2f2d137f5f55
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/branch.json
@@ -0,0 +1,17 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
new file mode 100644
index 000000000000..cbb365f5091f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/cache.json
@@ -0,0 +1,143 @@
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
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR"
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
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
new file mode 100644
index 000000000000..344a2d552ad5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/exception.json
@@ -0,0 +1,47 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_SMC"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
new file mode 100644
index 000000000000..1a74786271d4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/instruction.json
@@ -0,0 +1,77 @@
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
+        "ArchStdEvent": "PC_WRITE_SPEC"
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
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
new file mode 100644
index 000000000000..5aff6e93c1ad
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/memory.json
@@ -0,0 +1,23 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
new file mode 100644
index 000000000000..eeac798d403a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a77/pipeline.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 43cdeae3f1b6..1fa58d247132 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -31,6 +31,7 @@
 0x00000000410fd0a0,v1,arm/cortex-a75,core
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
+0x00000000410fd0d0,v1,arm/cortex-a77,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
 0x00000000410fd460,v1,arm/cortex-a510,core
 0x00000000410fd490,v1,arm/neoverse-n2,core
-- 
2.25.1

