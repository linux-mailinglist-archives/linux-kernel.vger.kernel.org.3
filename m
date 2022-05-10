Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDBF5212B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiEJKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiEJKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 883E328FE8C;
        Tue, 10 May 2022 03:48:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 140A313D5;
        Tue, 10 May 2022 03:48:54 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C4143F66F;
        Tue, 10 May 2022 03:48:51 -0700 (PDT)
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
Subject: [PATCH 02/20] perf vendors events arm64: Arm Cortex-A7
Date:   Tue, 10 May 2022 11:47:40 +0100
Message-Id: <20220510104758.64677-3-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A7
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a7.json

which is based on PMU event descriptions from the Arm Cortex-A7 Technical
Reference Manual.

Mapping data (for mapfile.csv) based on:
https://github.com/ARM-software/data/blob/master/cpus.json

which is based on Main ID Register (MIDR) information found in the Arm
Technical Reference Manuals for individual CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arch/arm64/arm/cortex-a7/branch.json      |  8 +++++
 .../arch/arm64/arm/cortex-a7/bus.json         | 17 ++++++++++
 .../arch/arm64/arm/cortex-a7/cache.json       | 32 +++++++++++++++++++
 .../arch/arm64/arm/cortex-a7/exception.json   | 11 +++++++
 .../arch/arm64/arm/cortex-a7/instruction.json | 29 +++++++++++++++++
 .../arch/arm64/arm/cortex-a7/memory.json      |  8 +++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 7 files changed, 106 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json
new file mode 100644
index 000000000000..79f2016c53b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/branch.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json
new file mode 100644
index 000000000000..75d850b781ac
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/bus.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json
new file mode 100644
index 000000000000..8a9a95e05c32
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/cache.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json
new file mode 100644
index 000000000000..8e6da69a1cbd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/exception.json
@@ -0,0 +1,11 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json
new file mode 100644
index 000000000000..7c018f439206
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/instruction.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json
new file mode 100644
index 000000000000..2c319f936957
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a7/memory.json
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
index 154d1fc61ee4..9d8ebe3ea6d2 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,7 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fc050,v1,arm/cortex-a5,core
+0x00000000410fc070,v1,arm/cortex-a7,core
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
-- 
2.25.1

