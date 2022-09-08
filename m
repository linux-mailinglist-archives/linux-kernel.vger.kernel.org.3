Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC55B1B56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiIHLZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIHLZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:25:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5BCA4CA01;
        Thu,  8 Sep 2022 04:25:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F1514BF;
        Thu,  8 Sep 2022 04:25:35 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEB9A3F71A;
        Thu,  8 Sep 2022 04:25:27 -0700 (PDT)
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
Subject: [PATCH] perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
Date:   Thu,  8 Sep 2022 12:25:18 +0100
Message-Id: <20220908112519.64614-1-nick.forrington@arm.com>
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

Move REMOTE_ACCESS event from other.json to memory.json for Neoverse
CPUs. This is consistent with other Arm (Cortex) CPUs.

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 .../perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json | 3 +++
 .../perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json  | 5 -----
 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json | 3 +++
 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json  | 5 -----
 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json | 3 +++
 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json  | 5 -----
 6 files changed, 9 insertions(+), 15 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
index 20a929e7728d..5bed2514b245 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
@@ -3,6 +3,9 @@
         "PublicDescription": "This event counts memory accesses due to load or store instructions. This event counts the sum of MEM_ACCESS_RD and MEM_ACCESS_WR.",
         "ArchStdEvent": "MEM_ACCESS"
     },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS"
+    },
     {
          "ArchStdEvent": "MEM_ACCESS_RD"
     },
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
deleted file mode 100644
index 20d8365756c5..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
+++ /dev/null
@@ -1,5 +0,0 @@
-[
-    {
-        "ArchStdEvent": "REMOTE_ACCESS"
-    }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
index e522113aeb96..7b2b21ac150f 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/memory.json
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
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
deleted file mode 100644
index 20d8365756c5..000000000000
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/other.json
+++ /dev/null
@@ -1,5 +0,0 @@
-[
-    {
-        "ArchStdEvent": "REMOTE_ACCESS"
-    }
-]
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

