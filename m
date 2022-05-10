Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B245212BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiEJKzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEJKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:53:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C562AC0F1;
        Tue, 10 May 2022 03:49:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FDB1515;
        Tue, 10 May 2022 03:49:07 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC1A13F66F;
        Tue, 10 May 2022 03:49:04 -0700 (PDT)
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
Subject: [PATCH 07/20] perf vendors events arm64: Arm Cortex-A32
Date:   Tue, 10 May 2022 11:47:45 +0100
Message-Id: <20220510104758.64677-8-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A32
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a32.json

which is based on PMU event descriptions from the Arm Cortex-A32 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a32/branch.json     | 11 +++++++
 .../arch/arm64/arm/cortex-a32/bus.json        | 17 ++++++++++
 .../arch/arm64/arm/cortex-a32/cache.json      | 32 +++++++++++++++++++
 .../arch/arm64/arm/cortex-a32/exception.json  | 14 ++++++++
 .../arm64/arm/cortex-a32/instruction.json     | 29 +++++++++++++++++
 .../arch/arm64/arm/cortex-a32/memory.json     |  8 +++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 7 files changed, 112 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json
new file mode 100644
index 000000000000..ece201718284
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/branch.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json
new file mode 100644
index 000000000000..8a9a95e05c32
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/cache.json
@@ -0,0 +1,32 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json
new file mode 100644
index 000000000000..27c3fe9c831a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/exception.json
@@ -0,0 +1,14 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json
new file mode 100644
index 000000000000..7c018f439206
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/instruction.json
@@ -0,0 +1,29 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json
new file mode 100644
index 000000000000..2c319f936957
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a32/memory.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index c24291e0d757..ef3af958aae5 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -18,6 +18,7 @@
 0x00000000410fc090,v1,arm/cortex-a9,core
 0x00000000410fc0e0,v1,arm/cortex-a17,core
 0x00000000410fc0f0,v1,arm/cortex-a15,core
+0x00000000410fd010,v1,arm/cortex-a32,core
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
-- 
2.25.1

