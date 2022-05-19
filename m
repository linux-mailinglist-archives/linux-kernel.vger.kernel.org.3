Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D379E52CD68
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiESHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiESHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:43:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16853A88A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:43:06 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3hd20JtHz1JC2l;
        Thu, 19 May 2022 15:41:42 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:43:04 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 15:43:04 +0800
From:   keliu <liuke94@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH 2/2] drivers/perf:Directly use ida_alloc()/free()
Date:   Thu, 19 May 2022 08:01:27 +0000
Message-ID: <20220519080127.147030-2-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519080127.147030-1-liuke94@huawei.com>
References: <20220519080127.147030-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/perf/arm-ccn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 40b352e8aa7f..728d13d8e98a 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1250,7 +1250,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	ccn->dt.cmp_mask[CCN_IDX_MASK_OPCODE].h = ~(0x1f << 9);
 
 	/* Get a convenient /sys/event_source/devices/ name */
-	ccn->dt.id = ida_simple_get(&arm_ccn_pmu_ida, 0, 0, GFP_KERNEL);
+	ccn->dt.id = ida_alloc(&arm_ccn_pmu_ida, GFP_KERNEL);
 	if (ccn->dt.id == 0) {
 		name = "ccn";
 	} else {
@@ -1312,7 +1312,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 					    &ccn->dt.node);
 error_set_affinity:
 error_choose_name:
-	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
+	ida_free(&arm_ccn_pmu_ida, ccn->dt.id);
 	for (i = 0; i < ccn->num_xps; i++)
 		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
 	writel(0, ccn->dt.base + CCN_DT_PMCR);
@@ -1329,7 +1329,7 @@ static void arm_ccn_pmu_cleanup(struct arm_ccn *ccn)
 		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
 	writel(0, ccn->dt.base + CCN_DT_PMCR);
 	perf_pmu_unregister(&ccn->dt.pmu);
-	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
+	ida_free(&arm_ccn_pmu_ida, ccn->dt.id);
 }
 
 static int arm_ccn_for_each_valid_region(struct arm_ccn *ccn,
-- 
2.25.1

