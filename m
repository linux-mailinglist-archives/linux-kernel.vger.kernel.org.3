Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80055A9B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIAPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiIAPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:19:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D59A583F0D;
        Thu,  1 Sep 2022 08:19:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F20ED1;
        Thu,  1 Sep 2022 08:19:28 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEBB63F766;
        Thu,  1 Sep 2022 08:19:20 -0700 (PDT)
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
Subject: [PATCH] perf vendor events: Add missing Neoverse V1 events
Date:   Thu,  1 Sep 2022 16:18:04 +0100
Message-Id: <20220901151804.294823-1-nick.forrington@arm.com>
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

Based on updated data from:
https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json

which is based on PMU event descriptions from the Arm Neoverse V1
Technical Reference Manual.

This adds the following missing events:
ASE_INST_SPEC
SVE_INST_SPEC
SVE_PRED_SPEC
SVE_PRED_EMPTY_SPEC
SVE_PRED_FULL_SPEC
SVE_PRED_PARTIAL_SPEC
SVE_LDFF_SPEC
SVE_LDFF_FAULT_SPEC
FP_SCALE_OPS_SPEC
FP_FIXED_OPS_SPEC

It also moves REMOTE_ACCESS from other.json to memory.json.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../arm64/arm/neoverse-v1/instruction.json    | 30 +++++++++++++++++++
 .../arch/arm64/arm/neoverse-v1/memory.json    |  3 ++
 .../arch/arm64/arm/neoverse-v1/other.json     |  5 ----
 3 files changed, 33 insertions(+), 5 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
index 25825e14c535..e29b88fb7f24 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
@@ -85,5 +85,35 @@
     },
     {
         "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC"
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
index e3d08f1f7c92..5aff6e93c1ad 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
@@ -2,6 +2,9 @@
     {
         "ArchStdEvent": "MEM_ACCESS"
     },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS"
+    },
     {
         "ArchStdEvent": "MEM_ACCESS_RD"
     },
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
deleted file mode 100644
index 20d8365756c5..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
+++ /dev/null
@@ -1,5 +0,0 @@
-[
-    {
-        "ArchStdEvent": "REMOTE_ACCESS"
-    }
-]
-- 
2.25.1

