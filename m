Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C94F7F71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbiDGMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbiDGMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:49:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA338D5548
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:47:51 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZ1Jp1nkBzBs7t;
        Thu,  7 Apr 2022 20:43:38 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 20:47:49 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:47:49 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v4 1/2] drivers/perf: hisi: Associate PMUs in SICL with CPUs online
Date:   Thu, 7 Apr 2022 20:46:16 +0800
Message-ID: <20220407124617.54521-2-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220407124617.54521-1-liuqi115@huawei.com>
References: <20220407124617.54521-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a PMU is in a SICL (Super IO cluster), it is not appropriate to
associate this PMU with a CPU die. So we associate it with all CPUs
online.

As the firmware of Hip09 platform hasn't been published yet, change
of PMU driver will not influence backwards compatibility between
driver and firmware.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 18 +++++++-----------
 drivers/perf/hisilicon/hisi_uncore_pmu.c    |  4 ++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  1 +
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index bad99d149172..a0ee84d97c41 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -258,13 +258,12 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
 				   struct hisi_pmu *pa_pmu)
 {
 	/*
-	 * Use the SCCL_ID and the index ID to identify the PA PMU,
-	 * while SCCL_ID is the nearst SCCL_ID from this SICL and
-	 * CPU core is chosen from this SCCL to manage this PMU.
+	 * As PA PMU is in a SICL, use the SICL_ID and the index ID
+	 * to identify the PA PMU.
 	 */
 	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
-				     &pa_pmu->sccl_id)) {
-		dev_err(&pdev->dev, "Cannot read sccl-id!\n");
+				     &pa_pmu->sicl_id)) {
+		dev_err(&pdev->dev, "Cannot read sicl-id!\n");
 		return -EINVAL;
 	}
 
@@ -275,6 +274,7 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
 	}
 
 	pa_pmu->ccl_id = -1;
+	pa_pmu->sccl_id = -1;
 
 	pa_pmu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pa_pmu->base)) {
@@ -399,13 +399,9 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	ret = hisi_pa_pmu_dev_probe(pdev, pa_pmu);
 	if (ret)
 		return ret;
-	/*
-	 * PA is attached in SICL and the CPU core is chosen to manage this
-	 * PMU which is the nearest SCCL, while its SCCL_ID is greater than
-	 * one with the SICL_ID.
-	 */
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
-			      pa_pmu->sccl_id - 1, pa_pmu->index_id);
+			      pa_pmu->sicl_id, pa_pmu->index_id);
 	if (!name)
 		return -ENOMEM;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index a738aeab5c04..463061fa8fc8 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -458,6 +458,10 @@ static bool hisi_pmu_cpu_is_associated_pmu(struct hisi_pmu *hisi_pmu)
 {
 	int sccl_id, ccl_id;
 
+	/* If SCCL_ID is -1, the PMU is in a SICL and has no CPU affinity */
+	if (hisi_pmu->sccl_id == -1)
+		return true;
+
 	if (hisi_pmu->ccl_id == -1) {
 		/* If CCL_ID is -1, the PMU only shares the same SCCL */
 		hisi_read_sccl_and_ccl_id(&sccl_id, NULL);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 7f5841d6f592..96eeddad55ff 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -81,6 +81,7 @@ struct hisi_pmu {
 	struct device *dev;
 	struct hlist_node node;
 	int sccl_id;
+	int sicl_id;
 	int ccl_id;
 	void __iomem *base;
 	/* the ID of the PMU modules */
-- 
2.24.0

