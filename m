Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C477B4964F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382064AbiAUS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:26:07 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20331 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiAUS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642789566; x=1674325566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GtfC2adnN8e0FlU+Pzw38v4HLYKFGTj1LqZMspVP5xI=;
  b=MiKoOjKm3alUFSmy1bUo8lAHP3rkr4rFZQb2jr6q2GXayyQGIUAh4/Fx
   NDAct3SQccs3HPxSEoDZIk5I6Pcy2/m+x+XnygM1LVK31AEBxagOw4J8r
   N/ycPcHIep/jBDN2MfOD4U7RaypXa0CCVueluTNU0M2WmFkc3ES77K6yL
   I=;
X-IronPort-AV: E=Sophos;i="5.88,306,1635206400"; 
   d="scan'208";a="189114961"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-5a09360d.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 21 Jan 2022 18:26:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-5a09360d.us-west-2.amazon.com (Postfix) with ESMTPS id CE756418E7;
        Fri, 21 Jan 2022 18:26:04 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 21 Jan 2022 18:26:04 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 21 Jan 2022 18:26:04 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Fri, 21 Jan 2022 18:26:03
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 9E46D21BB4; Fri, 21 Jan 2022 18:26:03 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
Subject: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Date:   Fri, 21 Jan 2022 18:24:49 +0000
Message-ID: <20220121182456.13538-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
the same encoding. I can't find encoding information for any other SPE
implementations to unify their choices with Arm's thus that is left for future
work.

This changes enables the expected behavior of perf c2c on a system with SPE where
lines that are shared among multiple cores show up in perf c2c output. 

Signed-off-by: Ali Saidi <alisaidi@amazon.com> 
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |  1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 12 +++++
 tools/perf/util/arm-spe.c                     | 48 ++++++++++++++-----
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 5e390a1a79ab..091987dd3966 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -220,6 +220,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 
 			break;
 		case ARM_SPE_DATA_SOURCE:
+			decoder->record.source = payload;
 			break;
 		case ARM_SPE_BAD:
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 69b31084d6be..1ecf4ee99415 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -29,10 +29,22 @@ enum arm_spe_op_type {
 	ARM_SPE_ST		= 1 << 1,
 };
 
+enum arm_spe_neoverse_data_source {
+	ARM_SPE_NV_L1D        = 0x0,
+	ARM_SPE_NV_L2         = 0x8,
+	ARM_SPE_NV_PEER_CORE  = 0x9,
+	ARM_SPE_NV_LCL_CLSTR  = 0xa,
+	ARM_SPE_NV_SYS_CACHE  = 0xb,
+	ARM_SPE_NV_PEER_CLSTR = 0xc,
+	ARM_SPE_NV_REMOTE     = 0xd,
+	ARM_SPE_NV_DRAM       = 0xe,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
 	u32 op;
+	u16 source;
 	u32 latency;
 	u64 from_ip;
 	u64 to_ip;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2b64e3f588b..d025af13f5e4 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -34,6 +34,7 @@
 #include "arm-spe-decoder/arm-spe-decoder.h"
 #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
+#include <../../../arch/arm64/include/asm/cputype.h>
 #define MAX_TIMESTAMP (~0ULL)
 
 struct arm_spe {
@@ -45,6 +46,7 @@ struct arm_spe {
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
+	u64				midr;
 
 	struct perf_tsc_conversion	tc;
 
@@ -399,9 +401,16 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
 	return false;
 }
 
-static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
+static const struct midr_range neoverse_spe[] = {
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	{},
+};
+
+static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
 	union perf_mem_data_src	data_src = { 0 };
+	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
@@ -409,19 +418,30 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
 		data_src.mem_op = PERF_MEM_OP_STORE;
 
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
-		data_src.mem_lvl = PERF_MEM_LVL_L3;
+		if (is_neoverse && record->source == ARM_SPE_NV_DRAM) {
+			data_src.mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		} else if (is_neoverse && record->source == ARM_SPE_NV_PEER_CLSTR) {
+			data_src.mem_snoop = PERF_MEM_SNOOP_HITM;
+			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		} else {
+			data_src.mem_lvl = PERF_MEM_LVL_L3;
 
-		if (record->type & ARM_SPE_LLC_MISS)
-			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
-		else
-			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+			if (record->type & ARM_SPE_LLC_MISS)
+				data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+			else
+				data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+		}
 	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
-		data_src.mem_lvl = PERF_MEM_LVL_L1;
+		if (is_neoverse && record->source == ARM_SPE_NV_L2) {
+			data_src.mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		} else {
+			data_src.mem_lvl = PERF_MEM_LVL_L1;
 
-		if (record->type & ARM_SPE_L1D_MISS)
-			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
-		else
-			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+			if (record->type & ARM_SPE_L1D_MISS)
+				data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+			else
+				data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+		}
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
@@ -446,7 +466,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
-	data_src = arm_spe__synth_data_source(record);
+	data_src = arm_spe__synth_data_source(record, spe->midr);
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
@@ -796,6 +816,10 @@ static int arm_spe_process_event(struct perf_session *session,
 	u64 timestamp;
 	struct arm_spe *spe = container_of(session->auxtrace,
 			struct arm_spe, auxtrace);
+	const char *cpuid = perf_env__cpuid(session->evlist->env);
+	u64 midr = strtol(cpuid, NULL, 16);
+
+	spe->midr = midr;
 
 	if (dump_trace)
 		return 0;
-- 
2.33.1

