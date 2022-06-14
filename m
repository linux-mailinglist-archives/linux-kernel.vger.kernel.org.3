Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC754B76C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiFNROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiFNRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:14:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8257A20BDA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:14:27 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ECbBRf019264;
        Tue, 14 Jun 2022 10:14:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=7HzzTqBLPZRMlE54+zdUF1g5ucRjNNc3WOeK/gofv9o=;
 b=XG5hul8d0cGrRTHGBiWkgg+ttfCPImVQ8zDPltrlb1Vbxp8UZ0I+efzPwtKCzAoye3SR
 o0XHpOeLYP565HHmHfdAXItZ/mPnzHd2lLTLFW4YH3cFBEAwarImO5/OtQ/EZ/GhCQUb
 pe2AD15KErbwfVNmtct/Is9gFUVJEO95uR/qr5t/RVjz233K5NkCu4GaBeNzjYFZ4Xfr
 uUyR0OyS7jnGAUWIj2nXnz3p4KsFrXoVh9k1MSt+GD3+8Ev0PeJ3DFLdQIUZano99I/d
 NxvQ3MOpFkxmJqqryDX7M4dlLzh8t/J9ofI85D6WocjwpqePTPLE0cgShNvBZClXcKNl BA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gmtjp4p9p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:14:07 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Jun
 2022 10:14:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 10:14:04 -0700
Received: from sbr2s-27.caveonetworks.com (unknown [10.110.140.94])
        by maili.marvell.com (Postfix) with ESMTP id 07E6C3F7090;
        Tue, 14 Jun 2022 10:14:04 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <bbhushan2@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH] perf/marvell_cn10k: Fix TAD PMU register offset
Date:   Tue, 14 Jun 2022 17:13:56 +0000
Message-ID: <20220614171356.773967-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9kmRv0qqqLKWt8nU6lj870Y0CNUWmZ3I
X-Proofpoint-ORIG-GUID: 9kmRv0qqqLKWt8nU6lj870Y0CNUWmZ3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing offset of TAD_PRF and TAD_PFC registers are incorrect.
Hence, fix with the right register offsets.

Also, drop read of TAD_PRF register in tad_pmu_event_counter_start()
since we don't have to preserve any bit fields and always write
an updated value.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 282d3a071a67..664d49d5979e 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -18,9 +18,9 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
-#define TAD_PFC_OFFSET		0x0
+#define TAD_PFC_OFFSET		0x800
 #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
-#define TAD_PRF_OFFSET		0x100
+#define TAD_PRF_OFFSET		0x900
 #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
 #define TAD_PRF_CNTSEL_MASK	0xFF
 #define TAD_MAX_COUNTERS	8
@@ -100,9 +100,7 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
 	 * which sets TAD()_PRF()[CNTSEL] != 0
 	 */
 	for (i = 0; i < tad_pmu->region_cnt; i++) {
-		reg_val = readq_relaxed(tad_pmu->regions[i].base +
-					TAD_PRF(counter_idx));
-		reg_val |= (event_idx & 0xFF);
+		reg_val = event_idx & 0xFF;
 		writeq_relaxed(reg_val,	tad_pmu->regions[i].base +
 			       TAD_PRF(counter_idx));
 	}
-- 
2.34.1

