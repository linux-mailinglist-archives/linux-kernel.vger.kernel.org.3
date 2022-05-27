Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54DB53687C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354836AbiE0VaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354755AbiE0V3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:29:46 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A6F2BB2A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:29:43 -0700 (PDT)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl [83.9.1.119])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C74EB2058B;
        Fri, 27 May 2022 23:29:40 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Date:   Fri, 27 May 2022 23:28:59 +0200
Message-Id: <20220527212901.29268-5-konrad.dybcio@somainline.org>
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

Some IOMMUs associated with some TZ firmwares may support switching
to the AArch64 pagetable format by sending a "set pagetable format"
scm command indicating the IOMMU secure ID and the context number
to switch.

Add a DT property "qcom,use-aarch64-pagetables" for this driver to
send this command to the secure world and to switch the pagetable
format to benefit of the ARM64 IOMMU pagetables, where possible.

Note that, even though the command should be valid to switch each
context, the property is made global because:
1. It doesn't make too much sense to switch only one or two
   context(s) to AA64 instead of just the entire thing
2. Some IOMMUs will go crazy and produce spectacular results when
   trying to mix up the pagetables on a per-context basis.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 54 +++++++++++++++----
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index ba0b77889f02..72ae0595efff 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -47,6 +47,8 @@ to non-secure vs secure interrupt line.
                      secure lines.  (Ie. if the iommu contains secure
                      context banks)
 - qcom,ctx-num     : The number associated to the context bank
+- qcom,use-aarch64-pagetables : Switch to AArch64 pagetable format on all
+                                contexts declared in this IOMMU
 
 
 ** Examples:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 129e322f56a6..530aa92bf6a1 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -52,6 +52,7 @@ struct qcom_iommu_dev {
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 num_ctxs;
+	bool			 use_aarch64_pt;
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
 };
 
@@ -164,11 +165,17 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct qcom_iommu_dev *qcom_iommu = qcom_domain->iommu;
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
 		size_t s = size;
 
-		iova = (iova >> 12) << 12;
-		iova |= ctx->asid;
+		if (qcom_iommu->use_aarch64_pt) {
+			iova >>= 12;
+			iova |= (unsigned long)ctx->asid << 48;
+		} else {
+			iova &= (1UL << 12) - 1UL;
+			iova |= ctx->asid;
+		}
 		do {
 			iommu_writel(ctx, reg, iova);
 			iova += granule;
@@ -248,6 +255,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
+	enum io_pgtable_fmt pgtbl_fmt;
+	unsigned long ias, oas;
 	int i, ret = 0;
 	u32 reg;
 
@@ -255,10 +264,19 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	if (qcom_domain->iommu)
 		goto out_unlock;
 
+	if (qcom_iommu->use_aarch64_pt) {
+		pgtbl_fmt = ARM_64_LPAE_S1;
+		ias = oas = 48;
+	} else {
+		pgtbl_fmt = ARM_32_LPAE_S1;
+		ias = 32;
+		oas = 40;
+	}
+
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
-		.ias		= 32,
-		.oas		= 40,
+		.ias		= ias,
+		.oas		= oas,
 		.tlb		= &qcom_flush_ops,
 		.iommu_dev	= qcom_iommu->dev,
 	};
@@ -266,7 +284,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 	qcom_domain->iommu = qcom_iommu;
 	qcom_domain->fwspec = fwspec;
 
-	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, qcom_domain);
+	pgtbl_ops = alloc_io_pgtable_ops(pgtbl_fmt, &pgtbl_cfg, qcom_domain);
 	if (!pgtbl_ops) {
 		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
 		ret = -ENOMEM;
@@ -280,6 +298,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
+		u32 tcr[2];
 
 		if (!ctx->secure_init) {
 			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
@@ -292,11 +311,25 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		qcom_iommu_reset_ctx(ctx);
 
+
+		tcr[0] = arm_smmu_lpae_tcr(&pgtbl_cfg);
+		tcr[1] = arm_smmu_lpae_tcr2(&pgtbl_cfg);
+
+		if (!qcom_iommu->use_aarch64_pt) {
+			tcr[0] |= ARM_SMMU_TCR_EAE;
+		} else {
+			/* This shall not fail, or spectacular things happen! */
+			if (qcom_scm_iommu_set_pt_format(qcom_iommu->sec_id, ctx->asid, 1)) {
+				dev_warn(qcom_iommu->dev, "Cannot set AArch64 pt format\n");
+				goto out_clear_iommu;
+			}
+
+			tcr[1] |= ARM_SMMU_TCR2_AS;
+		}
+
 		/* TCR */
-		iommu_writel(ctx, ARM_SMMU_CB_TCR2,
-				arm_smmu_lpae_tcr2(&pgtbl_cfg));
-		iommu_writel(ctx, ARM_SMMU_CB_TCR,
-			     arm_smmu_lpae_tcr(&pgtbl_cfg) | ARM_SMMU_TCR_EAE);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR2, tcr[1]);
+		iommu_writel(ctx, ARM_SMMU_CB_TCR, tcr[0]);
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
@@ -844,6 +877,9 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (of_property_read_bool(dev->of_node, "qcom,use-aarch64-pagetables"))
+		qcom_iommu->use_aarch64_pt = true;
+
 	if (qcom_iommu_has_secure_context(qcom_iommu)) {
 		ret = qcom_iommu_sec_ptbl_init(dev);
 		if (ret) {
-- 
2.36.1

