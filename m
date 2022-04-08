Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC34F9DD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiDHT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiDHT4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:56:06 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F61A395E;
        Fri,  8 Apr 2022 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649447641; x=1680983641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78KzzoULlHztaD6JKoh2QWioOahWxYDIMygij3c91ks=;
  b=dgQrROpFXdXTeV0Fn/Wf87mOWzOhNhvnxx2lAF6D64ITBLhdoD+0EGyk
   OWygiJYTfUUxc2mSOb2Cwv1MeLq+uyKMLw3jrn2P8MTg0ryP4QfYOVIG0
   9ZPgr4PYtdpMa195u1XoFDle6nvKNtHynM+Q29Nc+T3mK1ghQGW97feVM
   8=;
X-IronPort-AV: E=Sophos;i="5.90,245,1643673600"; 
   d="scan'208";a="193163929"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 08 Apr 2022 19:53:59 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 4921841791;
        Fri,  8 Apr 2022 19:53:58 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 8 Apr 2022 19:53:56 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 8 Apr 2022 19:53:56 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 75F552C24; Fri,  8 Apr 2022 19:53:55 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <german.gomez@arm.com>,
        <leo.yan@linaro.org>, <acme@kernel.org>
CC:     <alisaidi@amazon.com>, <benh@kernel.crashing.org>,
        <Nick.Forrington@arm.com>, <alexander.shishkin@linux.intel.com>,
        <andrew.kilroy@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>, <will@kernel.org>
Subject: [PATCH v5 4/5] perf arm-spe: Use SPE data source for neoverse cores
Date:   Fri, 8 Apr 2022 19:53:43 +0000
Message-ID: <20220408195344.32764-5-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408195344.32764-1-alisaidi@amazon.com>
References: <20220408195344.32764-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
the same encoding. I can't find encoding information for any other SPE
implementations to unify their choices with Arm's thus that is left for
future work.

This change populates the mem_lvl_num for Neoverse cores instead of the
deprecated mem_lvl namespace.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
 tools/perf/util/arm-spe.c                     | 127 ++++++++++++++++--
 3 files changed, 126 insertions(+), 14 deletions(-)

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
index 69b31084d6be..46a61df1145b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -29,6 +29,17 @@ enum arm_spe_op_type {
 	ARM_SPE_ST		= 1 << 1,
 };
 
+enum arm_spe_neoverse_data_source {
+	ARM_SPE_NV_L1D		 = 0x0,
+	ARM_SPE_NV_L2		 = 0x8,
+	ARM_SPE_NV_PEER_CORE	 = 0x9,
+	ARM_SPE_NV_LOCAL_CLUSTER = 0xa,
+	ARM_SPE_NV_SYS_CACHE	 = 0xb,
+	ARM_SPE_NV_PEER_CLUSTER	 = 0xc,
+	ARM_SPE_NV_REMOTE	 = 0xd,
+	ARM_SPE_NV_DRAM		 = 0xe,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
@@ -40,6 +51,7 @@ struct arm_spe_record {
 	u64 virt_addr;
 	u64 phys_addr;
 	u64 context_id;
+	u16 source;
 };
 
 struct arm_spe_insn;
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2b64e3f588b..a20285cf98e3 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -34,6 +34,7 @@
 #include "arm-spe-decoder/arm-spe-decoder.h"
 #include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
+#include "../../arch/arm64/include/asm/cputype.h"
 #define MAX_TIMESTAMP (~0ULL)
 
 struct arm_spe {
@@ -45,6 +46,7 @@ struct arm_spe {
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
+	u64				midr;
 
 	struct perf_tsc_conversion	tc;
 
@@ -399,33 +401,127 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
 	return false;
 }
 
-static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
+static const struct midr_range neoverse_spe[] = {
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	{},
+};
+
+
+static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
+						union perf_mem_data_src *data_src)
 {
-	union perf_mem_data_src	data_src = { 0 };
+	/*
+	 * Even though four levels of cache hierarchy are possible, no known
+	 * production Neoverse systems currently include more than three levels
+	 * so for the time being we assume three exist. If a production system
+	 * is built with four the this function would have to be changed to
+	 * detect the number of levels for reporting.
+	 */
 
-	if (record->op == ARM_SPE_LD)
-		data_src.mem_op = PERF_MEM_OP_LOAD;
-	else
-		data_src.mem_op = PERF_MEM_OP_STORE;
+	/*
+	 * We have no data on the hit level or data source for stores in the
+	 * Neoverse SPE records.
+	 */
+	if (record->op & ARM_SPE_ST) {
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		return;
+	}
+
+
+	switch (record->source) {
+	case ARM_SPE_NV_L1D:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_NV_L2:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_NV_PEER_CORE:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		break;
+	/*
+	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
+	 * transfer, so set SNOOPX_PEER
+	 */
+	case ARM_SPE_NV_LOCAL_CLUSTER:
+	case ARM_SPE_NV_PEER_CLUSTER:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		break;
+	/*
+	 * System cache is assumed to be L3
+	 */
+	case ARM_SPE_NV_SYS_CACHE:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+		break;
+	/*
+	 * We don't know what level it hit in, except it came from the other
+	 * socket
+	 */
+	case ARM_SPE_NV_REMOTE:
+		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		break;
+	case ARM_SPE_NV_DRAM:
+		data_src->mem_lvl = PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	default:
+		break;
+	}
+}
 
+static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
+						union perf_mem_data_src *data_src)
+{
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
-		data_src.mem_lvl = PERF_MEM_LVL_L3;
+		data_src->mem_lvl = PERF_MEM_LVL_L3;
 
 		if (record->type & ARM_SPE_LLC_MISS)
-			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
 		else
-			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
 	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
-		data_src.mem_lvl = PERF_MEM_LVL_L1;
+		data_src->mem_lvl = PERF_MEM_LVL_L1;
 
 		if (record->type & ARM_SPE_L1D_MISS)
-			data_src.mem_lvl |= PERF_MEM_LVL_MISS;
+			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
 		else
-			data_src.mem_lvl |= PERF_MEM_LVL_HIT;
+			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src.mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+}
+
+static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
+{
+	union perf_mem_data_src	data_src = { 0 };
+	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
+
+	if (record->op & ARM_SPE_LD)
+		data_src.mem_op = PERF_MEM_OP_LOAD;
+	else
+		data_src.mem_op = PERF_MEM_OP_STORE;
+
+	if (is_neoverse)
+		arm_spe__synth_data_source_neoverse(record, &data_src);
+	else
+		arm_spe__synth_data_source_generic(record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;
@@ -446,7 +542,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
-	data_src = arm_spe__synth_data_source(record);
+	data_src = arm_spe__synth_data_source(record, spe->midr);
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
@@ -1183,6 +1279,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
 	struct perf_record_time_conv *tc = &session->time_conv;
+	const char *cpuid = perf_env__cpuid(session->evlist->env);
+	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
 	int err;
 
@@ -1202,6 +1300,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	spe->midr = midr;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
-- 
2.32.0

