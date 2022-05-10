Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA485212B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiEJKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiEJKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB4228F1FA;
        Tue, 10 May 2022 03:48:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE9D12FC;
        Tue, 10 May 2022 03:48:46 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.33.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 711763F66F;
        Tue, 10 May 2022 03:48:44 -0700 (PDT)
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
Subject: [PATCH 01/20] perf vendors events arm64: Arm Cortex-A5
Date:   Tue, 10 May 2022 11:47:39 +0100
Message-Id: <20220510104758.64677-2-nick.forrington@arm.com>
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

Add PMU events for Arm Cortex-A5
Add corresponding common events
Update mapfile.csv

Event data based on:
https://github.com/ARM-software/data/tree/master/pmu/cortex-a5.json

which is based on PMU event descriptions from the Arm Cortex-A5 Technical
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
 .../arch/arm64/arm/cortex-a5/branch.json      |  8 +++++
 .../arch/arm64/arm/cortex-a5/cache.json       | 23 ++++++++++++
 .../arch/arm64/arm/cortex-a5/exception.json   | 11 ++++++
 .../arch/arm64/arm/cortex-a5/instruction.json | 29 +++++++++++++++
 .../arch/arm64/arm/cortex-a5/memory.json      |  8 +++++
 .../arch/arm64/common-and-microarch.json      | 36 +++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |  1 +
 7 files changed, 116 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json
new file mode 100644
index 000000000000..79f2016c53b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/branch.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json
new file mode 100644
index 000000000000..54c21ef64b18
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/cache.json
@@ -0,0 +1,23 @@
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
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json
new file mode 100644
index 000000000000..8e6da69a1cbd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/exception.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json
new file mode 100644
index 000000000000..7c018f439206
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/instruction.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json
new file mode 100644
index 000000000000..2c319f936957
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a5/memory.json
@@ -0,0 +1,8 @@
+[
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 80d7a70829a0..20923bf10adc 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -35,6 +35,18 @@
         "EventName": "L1D_TLB_REFILL",
         "BriefDescription": "Attributable Level 1 data TLB refill"
     },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, load",
+        "EventCode": "0x06",
+        "EventName": "LD_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, load"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, store",
+        "EventCode": "0x07",
+        "EventName": "ST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, store"
+    },
     {
         "PublicDescription": "Instruction architecturally executed",
         "EventCode": "0x08",
@@ -59,6 +71,30 @@
         "EventName": "CID_WRITE_RETIRED",
         "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR"
     },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, software change of the PC",
+        "EventCode": "0x0C",
+        "EventName": "PC_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, software change of the PC"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, immediate branch",
+        "EventCode": "0x0D",
+        "EventName": "BR_IMMED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, immediate branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, procedure return",
+        "EventCode": "0x0E",
+        "EventName": "BR_RETURN_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, procedure return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, unaligned",
+        "EventCode": "0x0F",
+        "EventName": "UNALIGNED_LDST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, unaligned"
+    },
     {
         "PublicDescription": "Mispredicted or not predicted branch speculatively executed",
         "EventCode": "0x10",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index b899db48c12a..154d1fc61ee4 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,6 +12,7 @@
 #
 #
 #Family-model,Version,Filename,EventType
+0x00000000410fc050,v1,arm/cortex-a5,core
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
-- 
2.25.1

