Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0C49BC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiAYTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:35:10 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17360 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiAYTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643139285; x=1674675285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NAvOTNs9bwZgrhJlwLaHAnqjrea7JZaYZR3NRB0BhzQ=;
  b=OWYQ4X37BjUoSYndpLfKy9mR9yVcQjo+AEWYvslArd2IgfEEbuvsBR6h
   b75DdvT0XHkhgfKS3ClNEGUlIPN6Wrb7GNhoaYtTv3fQmdP13Wr5oc2TK
   xZfbjGF60emkn6HZxO3eE0UfehfNuwP32OyIKp3tCabbxMBIY/WmFlTzm
   Y=;
X-IronPort-AV: E=Sophos;i="5.88,315,1635206400"; 
   d="scan'208";a="168477491"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 25 Jan 2022 19:34:43 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com (Postfix) with ESMTPS id B0A7141860;
        Tue, 25 Jan 2022 19:34:42 +0000 (UTC)
Received: from EX13D02UWB003.ant.amazon.com (10.43.161.48) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02UWB003.ant.amazon.com (10.43.161.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 25 Jan 2022 19:34:33 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Tue, 25 Jan 2022 19:34:33
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 4B27421E70; Tue, 25 Jan 2022 19:34:33 +0000 (UTC)
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
Subject: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
Date:   Tue, 25 Jan 2022 19:20:10 +0000
Message-ID: <20220125192016.20538-3-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <20220125192016.20538-1-alisaidi@amazon.com>
References: <20220125192016.20538-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode more SPE events and op types to allow for processing by perf
scripts. For example looking for branches which may indicate candidates
for conversion to a CSEL, store exclusives that are candidates for
conversion to LSE atomics and record the source information for memory
ops.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c     | 18 ++++++++++++++++++
 .../util/arm-spe-decoder/arm-spe-decoder.h     |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 5e390a1a79ab..177bac0f7128 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -191,6 +191,20 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 					decoder->record.op = ARM_SPE_ST;
 				else
 					decoder->record.op = ARM_SPE_LD;
+				if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
+					if (payload & SPE_OP_PKT_AT)
+						decoder->record.op |= ARM_SPE_LDST_ATOMIC;
+					if (payload & SPE_OP_PKT_EXCL)
+						decoder->record.op |= ARM_SPE_LDST_EXCL;
+					if (payload & SPE_OP_PKT_AR)
+						decoder->record.op |= ARM_SPE_LDST_ACQREL;
+				}
+			} else if (idx == SPE_OP_PKT_HDR_CLASS_BR_ERET) {
+				decoder->record.op = ARM_SPE_BR;
+				if (payload & SPE_OP_PKT_COND)
+					decoder->record.op |= ARM_SPE_BR_COND;
+				if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
+					decoder->record.op |= ARM_SPE_BR_IND;
 			}
 			break;
 		case ARM_SPE_EVENTS:
@@ -218,8 +232,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_MISPRED))
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
+			if (payload & BIT(EV_NOT_TAKEN))
+				decoder->record.type |= ARM_SPE_BR_NOT_TAKEN;
+
 			break;
 		case ARM_SPE_DATA_SOURCE:
+			decoder->record.source = payload;
 			break;
 		case ARM_SPE_BAD:
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 69b31084d6be..113e427afe99 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -22,11 +22,18 @@ enum arm_spe_sample_type {
 	ARM_SPE_TLB_MISS	= 1 << 5,
 	ARM_SPE_BRANCH_MISS	= 1 << 6,
 	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
+	ARM_SPE_BR_NOT_TAKEN	= 1 << 8,
 };
 
 enum arm_spe_op_type {
 	ARM_SPE_LD		= 1 << 0,
 	ARM_SPE_ST		= 1 << 1,
+	ARM_SPE_LDST_EXCL	= 1 << 2,
+	ARM_SPE_LDST_ATOMIC	= 1 << 3,
+	ARM_SPE_LDST_ACQREL	= 1 << 4,
+	ARM_SPE_BR		= 1 << 5,
+	ARM_SPE_BR_COND		= 1 << 6,
+	ARM_SPE_BR_IND		= 1 << 7,
 };
 
 struct arm_spe_record {
@@ -40,6 +47,7 @@ struct arm_spe_record {
 	u64 virt_addr;
 	u64 phys_addr;
 	u64 context_id;
+	u16 source;
 };
 
 struct arm_spe_insn;
-- 
2.24.4.AMZN

