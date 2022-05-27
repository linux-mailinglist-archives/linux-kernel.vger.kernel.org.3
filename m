Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E367536873
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354748AbiE0V3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345653AbiE0V3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:29:41 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EDA6CA8B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:40 -0700 (PDT)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl [83.9.1.119])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 356B520569;
        Fri, 27 May 2022 23:29:38 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/qcom: Write TCR before TTBRs to fix ASID access behavior
Date:   Fri, 27 May 2022 23:28:57 +0200
Message-Id: <20220527212901.29268-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527212901.29268-1-konrad.dybcio@somainline.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

As also stated in the arm-smmu driver, we must write the TCR before
writing the TTBRs, since the TCR determines the access behavior of
some fields.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 1728d4d7fe25..75f353866c40 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -273,18 +273,18 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
-		/* TTBRs */
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
-				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
-		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
-
 		/* TCR */
 		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
 				arm_smmu_lpae_tcr2(&pgtbl_cfg));
 		iommu_writel(ctx, ARM_SMMU_CB_TCR,
 			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
 
+		/* TTBRs */
+		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
+				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
+				FIELD_PREP(ARM_SMMU_TTBRn_ASID, ctx->asid));
+		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
+
 		/* MAIRs (stage-1 only) */
 		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.mair);
-- 
2.36.1

