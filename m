Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D55212B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiEJKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbiEJKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A45028F1F2;
        Tue, 10 May 2022 03:49:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFF961477;
        Tue, 10 May 2022 03:49:01 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7559F3F66F;
        Tue, 10 May 2022 03:48:59 -0700 (PDT)
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
Subject: [PATCH 05/20] perf vendors events arm64: Arm Cortex-A15
Date:   Tue, 10 May 2022 11:47:43 +0100
Message-Id: <20220510104758.64677-6-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A15
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a15.json

which is based on PMU event descriptions from the Arm Cortex-A15 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a15/branch.json     | 17 ++++
 .../arch/arm64/arm/cortex-a15/bus.json        | 29 +++++++
 .../arch/arm64/arm/cortex-a15/cache.json      | 80 +++++++++++++++++++
 .../arch/arm64/arm/cortex-a15/exception.json  |  8 ++
 .../arm64/arm/cortex-a15/instruction.json     | 59 ++++++++++++++
 .../arch/arm64/arm/cortex-a15/memory.json     | 20 +++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 7 files changed, 214 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json
new file mode 100644
index 000000000000..2f2d137f5f55
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/branch.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json
new file mode 100644
index 000000000000..31505994c06c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/bus.json
@@ -0,0 +1,29 @@
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
+        "ArchStdEvent": "BUS_ACCESS_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json
new file mode 100644
index 000000000000..1bd59e7d982b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/cache.json
@@ -0,0 +1,80 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json
new file mode 100644
index 000000000000..ae0f6b656a77
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/exception.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json
new file mode 100644
index 000000000000..8d2863d0d712
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/instruction.json
@@ -0,0 +1,59 @@
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
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
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
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json
new file mode 100644
index 000000000000..e3d08f1f7c92
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a15/memory.json
@@ -0,0 +1,20 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 80f37f8f650b..536652b8580b 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,6 +16,7 @@
 0x00000000410fc070,v1,arm/cortex-a7,core
 0x00000000410fc080,v1,arm/cortex-a8,core
 0x00000000410fc090,v1,arm/cortex-a9,core
+0x00000000410fc0f0,v1,arm/cortex-a15,core
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
-- 
2.25.1

