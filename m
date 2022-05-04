Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290CD51AD4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377374AbiEDSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377365AbiEDSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:52:44 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD7619281;
        Wed,  4 May 2022 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651690145; x=1683226145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nyaq8rgExJohCmR7zMDXM3nviHVHqHiyIvnP+zDFzfs=;
  b=AZ+VS8XIKzUjZVYGaUmAka0TAw16C/ZFaZZVJkyCoqaooFTMkBz7KaVN
   JN+WimcgUc2aUKWGumzNNfNhS3rsXKt3Hw1Vwc72bCPQNrPHT3kSy6HQN
   I3ikZ3zShzj+JRu2uMlISAQhmlTceoHtPs9+KlWZBaT/khtEKKFMWesis
   E=;
X-IronPort-AV: E=Sophos;i="5.91,198,1647302400"; 
   d="scan'208";a="1012911897"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 04 May 2022 18:49:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-b09ea7fa.us-west-2.amazon.com (Postfix) with ESMTPS id 2812A41E00;
        Wed,  4 May 2022 18:49:04 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 4 May 2022 18:48:59 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 4 May 2022 18:48:59 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Wed, 4 May 2022 18:48:58 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 7970420CC; Wed,  4 May 2022 18:48:57 +0000 (UTC)
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
Subject: [PATCH v8 4/5] perf arm-spe: Don't set data source if it's not a memory operation
Date:   Wed, 4 May 2022 18:48:49 +0000
Message-ID: <20220504184850.24986-5-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504184850.24986-1-alisaidi@amazon.com>
References: <20220504184850.24986-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Except memory load and store operations, Arm SPE records also can
support other operation types, bug when set the data source field the
current code assumes a record is a either load operation or store
operation, this leads to wrongly synthesize memory samples.

This patch strictly checks the record operation type, it only sets data
source only for the operation types ARM_SPE_LD and ARM_SPE_ST,
otherwise, returns zero for data source.  Therefore, we can synthesize
memory samples only when data source is a non-zero value, the function
arm_spe__is_memory_event() is useless and removed.

Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2b64e3f588b..e032efc03274 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -387,26 +387,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-#define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
-			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
-			 ARM_SPE_REMOTE_ACCESS)
-
-static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
-{
-	if (type & SPE_MEM_TYPE)
-		return true;
-
-	return false;
-}
-
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { 0 };
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-	else
+	else if (record->op == ARM_SPE_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
+	else
+		return 0;
 
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
 		data_src.mem_lvl = PERF_MEM_LVL_L3;
@@ -510,7 +500,11 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
-	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
+	/*
+	 * When data_src is zero it means the record is not a memory operation,
+	 * skip to synthesize memory sample for this case.
+	 */
+	if (spe->sample_memory && data_src) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
-- 
2.32.0

