Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A153D56E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350479AbiFDE3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiFDE3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14E4C7AB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c6so192661pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0A69VTOYEimBwAttfVlNj9brzyKfi16C6Mr840OT0WY=;
        b=KGGaPUNxi3TUQZVNajErVcvswcLCNQR7dDHGavSFjifh+0fUCd9mNJZDPourUYtv+c
         Zd/1uSTN2aE3+HsK4nPLAah52nZq24bVp5KKmnHuJ+ZNLh2uW0rz2jCnmMEi9gocszLF
         XzgSB6trsuoF6BxdvRbdGgSfXYS6wNUiJuwuLPJe2bYtiuoVEyFrkedAImPeyoMNcFkk
         EThkaiiHZYDSQenF5RxRXeZiVCpmbAyZrS4x+6LaqY2TpAUQM7A5QWbazz5k0vCQFYsr
         CQlm3gYWVtigs57y4VUd1hqRHF9j/6b/atLyuNbgQHTmyuE1lTXRXW+lMnlkw8DMKOzi
         g/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0A69VTOYEimBwAttfVlNj9brzyKfi16C6Mr840OT0WY=;
        b=0xRNd4+cPLRSW99R8byZfbN/zuDV+KsDXdHU0W1aLXxW5VtNQVFiZ2lXctoOCUY2ZL
         jS4KBxIE/Hf3srarVkiG6ShFp/EdyeDquzYuBWAjfXOWolOODQPrTyNSjgtAWQDcaAtm
         eYSdxGKDoQ1++7XqWohn8tPwsVkqHcV1tGMmsxDMy4aKSQAhJdrDUhKMcXnjPVpZsF5y
         IppEB8kX99+yoCy0tfwutN3eInBzD5HoJYqcmNv0LTAq2eVVllFv+uWaDAwwYhi1fC5A
         3OrSijGX8o8piu4FUAfqiviaTAaB7o1JLVXUrO5s6yPR95bI17xjT2S36RzKWyIQ17Bn
         2Dww==
X-Gm-Message-State: AOAM532hEuETQT3vHn7gOUkVL8UAlUHaNO5Wtl8pwhTk2vJd3dt00AFV
        CAO0XWjOG2ybFwRbtDxMsECDjQ==
X-Google-Smtp-Source: ABdhPJwtDIAnbjkHuLXPjyZcQUFu5Xsd8rzL57GHu1wJg1bb8Tromz9YI2szPeXC6pQVIDwaR9Do3w==
X-Received: by 2002:a65:4501:0:b0:3fc:4895:283b with SMTP id n1-20020a654501000000b003fc4895283bmr11558336pgq.231.1654316951271;
        Fri, 03 Jun 2022 21:29:11 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 05/17] perf arm-spe: Use SPE data source for neoverse cores
Date:   Sat,  4 Jun 2022 12:28:08 +0800
Message-Id: <20220604042820.2270916-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ali Saidi <alisaidi@amazon.com>

When synthesizing data from SPE, augment the type with source information
for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
the same encoding. I can't find encoding information for any other SPE
implementations to unify their choices with Arm's thus that is left for
future work.

This change populates the mem_lvl_num for Neoverse cores as well as the
deprecated mem_lvl namespace.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
 tools/perf/util/arm-spe.c                     | 130 +++++++++++++++---
 3 files changed, 127 insertions(+), 16 deletions(-)

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
index d040406f3314..22dcfe07e886 100644
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
 
@@ -387,35 +389,128 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
+static const struct midr_range neoverse_spe[] = {
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	{},
+};
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
-	else if (record->op == ARM_SPE_ST)
-		data_src.mem_op = PERF_MEM_OP_STORE;
-	else
-		return 0;
+	/*
+	 * We have no data on the hit level or data source for stores in the
+	 * Neoverse SPE records.
+	 */
+	if (record->op & ARM_SPE_ST) {
+		data_src->mem_lvl = PERF_MEM_LVL_NA;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		return;
+	}
+
+	switch (record->source) {
+	case ARM_SPE_NV_L1D:
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_NV_L2:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	case ARM_SPE_NV_PEER_CORE:
+		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	/*
+	 * We don't know if this is L1, L2 but we do know it was a cache-2-cache
+	 * transfer, so set SNOOPX_PEER
+	 */
+	case ARM_SPE_NV_LOCAL_CLUSTER:
+	case ARM_SPE_NV_PEER_CLUSTER:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	/*
+	 * System cache is assumed to be L3
+	 */
+	case ARM_SPE_NV_SYS_CACHE:
+		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
+		data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+		break;
+	/*
+	 * We don't know what level it hit in, except it came from the other
+	 * socket
+	 */
+	case ARM_SPE_NV_REMOTE:
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
+		break;
+	case ARM_SPE_NV_DRAM:
+		data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_RAM;
+		data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+		break;
+	default:
+		break;
+	}
+}
 
+static void arm_spe__synth_data_source_generic(const struct arm_spe_record *record,
+					       union perf_mem_data_src *data_src)
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
+	if (record->op == ARM_SPE_LD)
+		data_src.mem_op = PERF_MEM_OP_LOAD;
+	else if (record->op == ARM_SPE_ST)
+		data_src.mem_op = PERF_MEM_OP_STORE;
+	else
+		return 0;
+
+	if (is_neoverse)
+		arm_spe__synth_data_source_neoverse(record, &data_src);
+	else
+		arm_spe__synth_data_source_generic(record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;
@@ -436,7 +531,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
-	data_src = arm_spe__synth_data_source(record);
+	data_src = arm_spe__synth_data_source(record, spe->midr);
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
@@ -1178,6 +1273,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
 	struct perf_record_time_conv *tc = &session->time_conv;
+	const char *cpuid = perf_env__cpuid(session->evlist->env);
+	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
 	int err;
 
@@ -1197,6 +1294,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
 	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
+	spe->midr = midr;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
 
-- 
2.25.1

