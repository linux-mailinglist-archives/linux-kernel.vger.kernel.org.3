Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015C521232
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiEJKba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiEJKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:31:26 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E5201337
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:27:27 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AA83di031186;
        Tue, 10 May 2022 03:27:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=0Hl5ghIdZdkU4k6qCypCHdoG8Gw3tiISfSLVKrcPEf8=;
 b=S2Vgv/3Gcx2Vzvy8+SAhnxk/3gmlqLl9jkK7IEjz4y8iMSxnrw0aO9dAc4Oo1gYiLiRS
 Oj/clCnWBhXheRKybjiOOxT4a85w0beNKcEGrb4O9AgWUpmPvhzmZgsFayHABvR3ZQi7
 EvBwR82CdvAA+AJjv/NMUbOCWoFonMdg1+YpcUgAQQoUJxFTLiFLBUy0anKCFSMtWiNE
 JuKzf9UAbZNmFiB08Z0LKAhdx2Wduv1CA06WP3MppFLarjajxztV9vpBRG/vTTl/A7ZW
 ixNCXNxfoCBpg5aSU2Er8IsUfMGtTkDVwsWUtYGLHhIdezUV7NYqdgkmaofWXgEdOshU Vw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fyp1br1ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 03:27:16 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 May
 2022 03:27:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 May 2022 03:27:15 -0700
Received: from BG-SER530.marvell.com (BG-SER530.marvell.com [10.28.8.21])
        by maili.marvell.com (Postfix) with ESMTP id E4D203F70A2;
        Tue, 10 May 2022 03:27:12 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH] perf/marvell_cn10k: Fix tad_pmu_event_init() to check pmu type first
Date:   Tue, 10 May 2022 15:56:57 +0530
Message-ID: <20220510102657.487539-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jD1xn7UF0fqxBDyQrEgZmMuwCVBYL4gC
X-Proofpoint-ORIG-GUID: jD1xn7UF0fqxBDyQrEgZmMuwCVBYL4gC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to check the pmu type first and then check event->attr.disabled.
Doing so would avoid reading the disabled attribute of an event that is
not handled by TAD PMU.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 drivers/perf/marvell_cn10k_tad_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index ee67305f822d..282d3a071a67 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -146,12 +146,12 @@ static int tad_pmu_event_init(struct perf_event *event)
 {
 	struct tad_pmu *tad_pmu = to_tad_pmu(event->pmu);
 
-	if (!event->attr.disabled)
-		return -EINVAL;
-
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
+	if (!event->attr.disabled)
+		return -EINVAL;
+
 	if (event->state != PERF_EVENT_STATE_OFF)
 		return -EINVAL;
 
-- 
2.25.1

