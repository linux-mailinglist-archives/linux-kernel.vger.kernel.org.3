Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A544ACC45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiBGWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBGWsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:48:00 -0500
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D5C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:47:59 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id HCncnIqRubnFGHCncnWXsD; Mon, 07 Feb 2022 23:47:57 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 07 Feb 2022 23:47:57 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify memory allocation
Date:   Mon,  7 Feb 2022 23:47:55 +0100
Message-Id: <598bd905103dcbe5653a54bb0dfb5a8597728214.1644274051.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
References: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_bitmap_zalloc() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is NOT compile tested.
I don't have the needed cross compiling tools.

v2: - remove the dev_err() message
    - remove the 'bitmap' variable
    - update the error handling path to be more future proof and return
      an explicit 0 in the success path
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 14d06aad0726..bbc4eeb42811 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2911,32 +2911,20 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
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
-	int ret = 0;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
-	atomic_long_t *bitmap;
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
-	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
-	if (!bitmap) {
-		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
-		ret = -ENOMEM;
-	} else {
-		cmdq->valid_map = bitmap;
-		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
-	}
+	cmdq->valid_map = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
+							      GFP_KERNEL);
+	if (!cmdq->valid_map)
+		return -ENOMEM;
 
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
-- 
2.32.0

