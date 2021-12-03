Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4C346777E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbhLCMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:40:17 -0500
Received: from foss.arm.com ([217.140.110.172]:48814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351732AbhLCMkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:40:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB6251396;
        Fri,  3 Dec 2021 04:36:51 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.35.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5355E3F5A1;
        Fri,  3 Dec 2021 04:36:49 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] perf vendor events: For the Neoverse N2
Date:   Fri,  3 Dec 2021 12:35:21 +0000
Message-Id: <20211203123525.31127-1-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the common and microarch json file to add counters
available in the Neoverse N2 chip, but should also apply to other ArmV8
and ArmV9 cpus.  Specified in ArmV8 architecture reference manual

  https://developer.arm.com/documentation/ddi0487/gb/?lang=en

Some of the counters added to armv8-common-and-microarch.json are
specified in the ArmV9 architecture reference manual supplement
(issue A.a):

  https://developer.arm.com/documentation/ddi0608/aa

The additional ArmV9 counters are

  TRB_WRAP
  TRCEXTOUT0
  TRCEXTOUT1
  TRCEXTOUT2
  TRCEXTOUT3
  CTI_TRIGOUT4
  CTI_TRIGOUT5
  CTI_TRIGOUT6
  CTI_TRIGOUT7

This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
perf list to output the counter names in categories.

A subsequent patch renames armv8-common-and-microarch.json and
armv8-recommended.json to reflect that counters for armv9 are being
added.

Counters on the Neoverse N2 are stated in its reference manual:

  https://developer.arm.com/documentation/102099/0000

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 .../arch/arm64/arm/neoverse-n2/branch.json    |   8 +
 .../arch/arm64/arm/neoverse-n2/bus.json       |  20 ++
 .../arch/arm64/arm/neoverse-n2/cache.json     | 155 ++++++++++++++
 .../arch/arm64/arm/neoverse-n2/exception.json |  47 +++++
 .../arm64/arm/neoverse-n2/instruction.json    | 143 +++++++++++++
 .../arch/arm64/arm/neoverse-n2/memory.json    |  38 ++++
 .../arch/arm64/arm/neoverse-n2/other.json     |   5 +
 .../arch/arm64/arm/neoverse-n2/pipeline.json  |  23 ++
 .../arch/arm64/arm/neoverse-n2/spe.json       |  14 ++
 .../arch/arm64/arm/neoverse-n2/trace.json     |  29 +++
 .../arm64/armv8-common-and-microarch.json     | 198 ++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 12 files changed, 681 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
new file mode 100644
index 000000000000..79f2016c53b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/branch.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
new file mode 100644
index 000000000000..579c1c993d17
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/bus.json
@@ -0,0 +1,20 @@
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
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
new file mode 100644
index 000000000000..0141f749bff3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/cache.json
@@ -0,0 +1,155 @@
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
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
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
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
new file mode 100644
index 000000000000..344a2d552ad5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
new file mode 100644
index 000000000000..e57cd55937c6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/instruction.json
@@ -0,0 +1,143 @@
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
+        "ArchStdEvent": "OP_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
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
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
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
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_HP_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_SP_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_FULL_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_SCALE_OPS_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_FIXED_OPS_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT8_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT16_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT32_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT64_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
new file mode 100644
index 000000000000..e522113aeb96
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
@@ -0,0 +1,38 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS"
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
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
new file mode 100644
index 000000000000..20d8365756c5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
@@ -0,0 +1,5 @@
+[
+    {
+        "ArchStdEvent": "REMOTE_ACCESS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
new file mode 100644
index 000000000000..f9fae15f7555
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
@@ -0,0 +1,23 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
new file mode 100644
index 000000000000..20f2165c85fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/spe.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
new file mode 100644
index 000000000000..3116135c59e2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/trace.json
@@ -0,0 +1,29 @@
+[
+    {
+        "ArchStdEvent": "TRB_WRAP"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT0"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT1"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT2"
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT3"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT4"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT5"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT6"
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT7"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
index 423767510aff..80d7a70829a0 100644
--- a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
@@ -299,6 +299,30 @@
         "EventName": "STALL_SLOT",
         "BriefDescription": "No operation sent for execution on a slot"
     },
+    {
+        "PublicDescription": "Sample Population",
+        "EventCode": "0x4000",
+        "EventName": "SAMPLE_POP",
+        "BriefDescription": "Sample Population"
+    },
+    {
+        "PublicDescription": "Sample Taken",
+        "EventCode": "0x4001",
+        "EventName": "SAMPLE_FEED",
+        "BriefDescription": "Sample Taken"
+    },
+    {
+        "PublicDescription": "Sample Taken and not removed by filtering",
+        "EventCode": "0x4002",
+        "EventName": "SAMPLE_FILTRATE",
+        "BriefDescription": "Sample Taken and not removed by filtering"
+    },
+    {
+        "PublicDescription": "Sample collided with previous sample",
+        "EventCode": "0x4003",
+        "EventName": "SAMPLE_COLLISION",
+        "BriefDescription": "Sample collided with previous sample"
+    },
     {
         "PublicDescription": "Constant frequency cycles.  The counter increments at a constant frequency equal to the rate of increment of the system counter, CNTPCT_EL0.",
         "EventCode": "0x4004",
@@ -329,6 +353,96 @@
         "EventName": "L3D_CACHE_LMISS_RD",
         "BriefDescription": "Level 3 data cache long-latency read miss"
     },
+    {
+        "PublicDescription": "Trace buffer current write pointer wrapped",
+        "EventCode": "0x400C",
+        "EventName": "TRB_WRAP",
+        "BriefDescription": "Trace buffer current write pointer wrapped"
+    },
+    {
+        "PublicDescription": "PE Trace Unit external output 0",
+        "EventCode": "0x4010",
+        "EventName": "TRCEXTOUT0",
+        "BriefDescription": "PE Trace Unit external output 0"
+    },
+    {
+        "PublicDescription": "PE Trace Unit external output 1",
+        "EventCode": "0x4011",
+        "EventName": "TRCEXTOUT1",
+        "BriefDescription": "PE Trace Unit external output 1"
+    },
+    {
+        "PublicDescription": "PE Trace Unit external output 2",
+        "EventCode": "0x4012",
+        "EventName": "TRCEXTOUT2",
+        "BriefDescription": "PE Trace Unit external output 2"
+    },
+    {
+        "PublicDescription": "PE Trace Unit external output 3",
+        "EventCode": "0x4013",
+        "EventName": "TRCEXTOUT3",
+        "BriefDescription": "PE Trace Unit external output 3"
+    },
+    {
+        "PublicDescription": "Cross-trigger Interface output trigger 4",
+        "EventCode": "0x4018",
+        "EventName": "CTI_TRIGOUT4",
+        "BriefDescription": "Cross-trigger Interface output trigger 4"
+    },
+    {
+        "PublicDescription": "Cross-trigger Interface output trigger 5 ",
+        "EventCode": "0x4019",
+        "EventName": "CTI_TRIGOUT5",
+        "BriefDescription": "Cross-trigger Interface output trigger 5 "
+    },
+    {
+        "PublicDescription": "Cross-trigger Interface output trigger 6",
+        "EventCode": "0x401A",
+        "EventName": "CTI_TRIGOUT6",
+        "BriefDescription": "Cross-trigger Interface output trigger 6"
+    },
+    {
+        "PublicDescription": "Cross-trigger Interface output trigger 7",
+        "EventCode": "0x401B",
+        "EventName": "CTI_TRIGOUT7",
+        "BriefDescription": "Cross-trigger Interface output trigger 7"
+    },
+    {
+        "PublicDescription": "Access with additional latency from alignment",
+        "EventCode": "0x4020",
+        "EventName": "LDST_ALIGN_LAT",
+        "BriefDescription": "Access with additional latency from alignment"
+    },
+    {
+        "PublicDescription": "Load with additional latency from alignment",
+        "EventCode": "0x4021",
+        "EventName": "LD_ALIGN_LAT",
+        "BriefDescription": "Load with additional latency from alignment"
+    },
+    {
+        "PublicDescription": "Store with additional latency from alignment",
+        "EventCode": "0x4022",
+        "EventName": "ST_ALIGN_LAT",
+        "BriefDescription": "Store with additional latency from alignment"
+    },
+    {
+        "PublicDescription": "Checked data memory access",
+        "EventCode": "0x4024",
+        "EventName": "MEM_ACCESS_CHECKED",
+        "BriefDescription": "Checked data memory access"
+    },
+    {
+        "PublicDescription": "Checked data memory access, read",
+        "EventCode": "0x4025",
+        "EventName": "MEM_ACCESS_CHECKED_RD",
+        "BriefDescription": "Checked data memory access, read"
+    },
+    {
+        "PublicDescription": "Checked data memory access, write",
+        "EventCode": "0x4026",
+        "EventName": "MEM_ACCESS_CHECKED_WR",
+        "BriefDescription": "Checked data memory access, write"
+    },
     {
         "PublicDescription": "SIMD Instruction architecturally executed.",
         "EventCode": "0x8000",
@@ -341,6 +455,18 @@
         "EventName": "SVE_INST_RETIRED",
         "BriefDescription": "Instruction architecturally executed, SVE."
     },
+    {
+        "PublicDescription": "ASE operations speculatively executed",
+        "EventCode": "0x8005",
+        "EventName": "ASE_INST_SPEC",
+        "BriefDescription": "ASE operations speculatively executed"
+    },
+    {
+        "PublicDescription": "SVE operations speculatively executed",
+        "EventCode": "0x8006",
+        "EventName": "SVE_INST_SPEC",
+        "BriefDescription": "SVE operations speculatively executed"
+    },
     {
         "PublicDescription": "Microarchitectural operation, Operations speculatively executed.",
         "EventCode": "0x8008",
@@ -359,6 +485,24 @@
         "EventName": "FP_SPEC",
         "BriefDescription": "Floating-point Operations speculatively executed."
     },
+    {
+        "PublicDescription": "Floating-point half-precision operations speculatively executed",
+        "EventCode": "0x8014",
+        "EventName": "FP_HP_SPEC",
+        "BriefDescription": "Floating-point half-precision operations speculatively executed"
+    },
+    {
+        "PublicDescription": "Floating-point single-precision operations speculatively executed",
+        "EventCode": "0x8018",
+        "EventName": "FP_SP_SPEC",
+        "BriefDescription": "Floating-point single-precision operations speculatively executed"
+    },
+    {
+        "PublicDescription": "Floating-point double-precision operations speculatively executed",
+        "EventCode": "0x801C",
+        "EventName": "FP_DP_SPEC",
+        "BriefDescription": "Floating-point double-precision operations speculatively executed"
+    },
     {
         "PublicDescription": "Floating-point FMA Operations speculatively executed.",
         "EventCode": "0x8028",
@@ -389,6 +533,30 @@
         "EventName": "SVE_PRED_SPEC",
         "BriefDescription": "SVE predicated Operations speculatively executed."
     },
+    {
+        "PublicDescription": "SVE predicated operations with no active predicates speculatively executed",
+        "EventCode": "0x8075",
+        "EventName": "SVE_PRED_EMPTY_SPEC",
+        "BriefDescription": "SVE predicated operations with no active predicates speculatively executed"
+    },
+    {
+        "PublicDescription": "SVE predicated operations speculatively executed with all active predicates",
+        "EventCode": "0x8076",
+        "EventName": "SVE_PRED_FULL_SPEC",
+        "BriefDescription": "SVE predicated operations speculatively executed with all active predicates"
+    },
+    {
+        "PublicDescription": "SVE predicated operations speculatively executed with partially active predicates",
+        "EventCode": "0x8077",
+        "EventName": "SVE_PRED_PARTIAL_SPEC",
+        "BriefDescription": "SVE predicated operations speculatively executed with partially active predicates"
+    },
+    {
+        "PublicDescription": "SVE predicated operations with empty or partially active predicates",
+        "EventCode": "0x8079",
+        "EventName": "SVE_PRED_NOT_FULL_SPEC",
+        "BriefDescription": "SVE predicated operations with empty or partially active predicates"
+    },
     {
         "PublicDescription": "SVE MOVPRFX Operations speculatively executed.",
         "EventCode": "0x807C",
@@ -497,6 +665,12 @@
         "EventName": "SVE_LDFF_SPEC",
         "BriefDescription": "SVE First-fault load Operations speculatively executed."
     },
+    {
+        "PublicDescription": "SVE first-fault load operations speculatively executed which set FFR bit to 0",
+        "EventCode": "0x80BD",
+        "EventName": "SVE_LDFF_FAULT_SPEC",
+        "BriefDescription": "SVE first-fault load operations speculatively executed which set FFR bit to 0"
+    },
     {
         "PublicDescription": "Scalable floating-point element Operations speculatively executed.",
         "EventCode": "0x80C0",
@@ -544,5 +718,29 @@
         "EventCode": "0x80C7",
         "EventName": "FP_DP_FIXED_OPS_SPEC",
         "BriefDescription": "Non-scalable double-precision floating-point element Operations speculatively executed."
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE 8-bit integer operations speculatively executed",
+        "EventCode": "0x80E3",
+        "EventName": "ASE_SVE_INT8_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE 8-bit integer operations speculatively executed"
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE 16-bit integer operations speculatively executed",
+        "EventCode": "0x80E7",
+        "EventName": "ASE_SVE_INT16_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE 16-bit integer operations speculatively executed"
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE 32-bit integer operations speculatively executed",
+        "EventCode": "0x80EB",
+        "EventName": "ASE_SVE_INT32_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE 32-bit integer operations speculatively executed"
+    },
+    {
+        "PublicDescription": "Advanced SIMD and SVE 64-bit integer operations speculatively executed",
+        "EventCode": "0x80EF",
+        "EventName": "ASE_SVE_INT64_SPEC",
+        "BriefDescription": "Advanced SIMD and SVE 64-bit integer operations speculatively executed"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 31d8b57ca9bb..b899db48c12a 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -19,6 +19,7 @@
 0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000410fd400,v1,arm/neoverse-v1,core
+0x00000000410fd490,v1,arm/neoverse-n2,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000460f0010,v1,fujitsu/a64fx,core
-- 
2.17.1

