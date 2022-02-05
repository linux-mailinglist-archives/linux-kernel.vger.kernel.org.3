Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D194AAA6C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380564AbiBERLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:11:16 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:62259 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380561AbiBERLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:11:12 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id GOadngRjHxHdTGOadnEh74; Sat, 05 Feb 2022 18:11:11 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 05 Feb 2022 18:11:11 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Simplify memory allocation
Date:   Sat,  5 Feb 2022 18:11:10 +0100
Message-Id: <018afc7c92ae4132ac901b088b72ab5979256a9e.1644081032.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
References: <de9e8705169b5dc873f6ce9f9a17598de89aa6a7.1644081032.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is NOT compile tested.
I don't have the needed cross compiling tools.
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 14d06aad0726..ba0e7f1f7dbf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2911,12 +2911,6 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static void arm_smmu_cmdq_free_bitmap(void *data)
-{
-	unsigned long *bitmap = data;
-	bitmap_free(bitmap);
-}
-
 static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 {
 	int ret = 0;
@@ -2927,13 +2921,13 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
-	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	bitmap = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
+						     GFP_KERNEL);
 	if (!bitmap) {
 		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
 		ret = -ENOMEM;
 	} else {
 		cmdq->valid_map = bitmap;
-		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
 	}
 
 	return ret;
-- 
2.32.0

