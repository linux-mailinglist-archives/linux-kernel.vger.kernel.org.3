Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C1531466
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbiEWO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiEWO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:58:00 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784625B3E7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:57:59 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NAop16010138;
        Mon, 23 May 2022 07:57:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=v/B4AlQx7PG7tjuY19pO8yuyNMYXuDuePg9o75QMG18=;
 b=OTED9Icf9CxfInCDpdqiNma6D3CgO8WVS3r9OX1CGlb2gn9KV6E5tLPELEf/Ba2L+dps
 Cq7tZ8Go9VGHCk8VVDbPLMQBodliQEyWgNvmy7wo8eWvbfzu66CpMOMoVAyJ3SpW87Qr
 IEprFkR58MWZSZvkY6ehKkvnWg7ONMQxoiEtSpYxvj7f4t0qq5Ie/7oHkr4rvSrnbU0B
 jVvpW2rRpePSPP6qNKydH5oYcEXw2ajXu+j7b0D951lbC0nxfWWwsJbx6uGnTc+iprji
 L5CExrMw7PZwOeNxcH1+gDzWoAQSUgzSbS9kj7SdWHeIoQ4zljS0ItUDRD4LgaTrPkJi kw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3g6ykkx8a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 07:57:46 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 23 May
 2022 07:57:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 23 May 2022 07:57:44 -0700
Received: from BG-SER530.marvell.com (BG-SER530.marvell.com [10.28.8.21])
        by maili.marvell.com (Postfix) with ESMTP id BBF513F7043;
        Mon, 23 May 2022 07:57:41 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>,
        <amitsinght@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH] perf/marvell_cn10k: Add MPAM support for TAD PMU
Date:   Mon, 23 May 2022 20:27:38 +0530
Message-ID: <20220523145738.2750368-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _kYeYifwefI2VFM4JQgUBdFzhpetjbbc
X-Proofpoint-ORIG-GUID: _kYeYifwefI2VFM4JQgUBdFzhpetjbbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_06,2022-05-23_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAD PMU supports following counters that can be filtered by MPAM
partition id.
    - (0x1a) tad_alloc_dtg : Allocations to DTG.
    - (0x1b) tad_alloc_ltg : Allocations to LTG.
    - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
    - (0x1d) tad_hit_dtg   : DTG hits.
    - (0x1e) tad_hit_ltg   : LTG hits.
    - (0x1f) tad_hit_any   : Hit in LTG/DTG.
    - (0x20) tad_tag_rd    : Total tag reads.

Add a new 'partid' attribute of 16-bits to get the partition id
passed from perf tool. This value would be stored in config1 field
of perf_event_attr structure.

Example:
perf stat -e tad/tad_alloc_any,partid=0x12/ <program>

- Drop read of TAD_PRF since we don't have to preserve any
  bit fields and always write an updated value.
- Update register offsets of TAD_PRF and TAD_PFC.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 282d3a071a67..f552e6bffcac 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -18,10 +18,12 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
-#define TAD_PFC_OFFSET		0x0
+#define TAD_PFC_OFFSET		0x800
 #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
-#define TAD_PRF_OFFSET		0x100
+#define TAD_PRF_OFFSET		0x900
 #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
+#define TAD_PRF_MATCH_PARTID	(1 << 8)
+#define TAD_PRF_PARTID_NS	(1 << 10)
 #define TAD_PRF_CNTSEL_MASK	0xFF
 #define TAD_MAX_COUNTERS	8
 
@@ -86,23 +88,32 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	u32 event_idx = event->attr.config;
 	u32 counter_idx = hwc->idx;
+	u32 partid_filter = 0;
 	u64 reg_val;
+	u32 partid;
 	int i;
 
 	hwc->state = 0;
 
+	/* Extract the partid (if any) passed by user */
+	partid = event->attr.config1 & 0x3f;
+
 	/* Typically TAD_PFC() are zeroed to start counting */
 	for (i = 0; i < tad_pmu->region_cnt; i++)
 		writeq_relaxed(0, tad_pmu->regions[i].base +
 			       TAD_PFC(counter_idx));
 
+	/* Only some counters are filterable by MPAM */
+	if (partid && (event_idx > 0x19) && (event_idx < 0x21))
+		partid_filter = TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
+				(partid << 11);
+
 	/* TAD()_PFC() start counting on the write
 	 * which sets TAD()_PRF()[CNTSEL] != 0
 	 */
 	for (i = 0; i < tad_pmu->region_cnt; i++) {
-		reg_val = readq_relaxed(tad_pmu->regions[i].base +
-					TAD_PRF(counter_idx));
-		reg_val |= (event_idx & 0xFF);
+		reg_val = (event_idx & 0xFF);
+		reg_val |= partid_filter;
 		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
 			       TAD_PRF(counter_idx));
 	}
@@ -221,9 +232,11 @@ static const struct attribute_group tad_pmu_events_attr_group = {
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(partid, "config1:0-15");
 
 static struct attribute *tad_pmu_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_partid.attr,
 	NULL
 };
 
-- 
2.34.1

