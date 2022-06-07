Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4778E5349A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbiEZEO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 00:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiEZEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 00:14:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D792BBA549;
        Wed, 25 May 2022 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653538463; x=1685074463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Afe+8qBSl2piyzpW9nlVRsqVQ0k/PfZ498BzMr6RHgA=;
  b=kT/PVm9uHQ/NHmuNQBJS5rSfCyWfigKpPfZDBS28r2JpQbHlGu5oS1Za
   QpD+InuXTlE1ruheUfSjP4to1cuHVztSG5DqwecE5ciDRwCgCe2ddqP9K
   PneGvtlCSG+km/kJ88Ij6MLOUQMSrq21vHdfzGRxUkURnKEKC01scVW/U
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 May 2022 21:14:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 21:14:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 21:14:22 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 25 May 2022 21:14:18 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_guptap@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts
Date:   Thu, 26 May 2022 09:44:03 +0530
Message-ID: <20220526041403.9984-1-quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLB sync timeouts can be due to various reasons such as TBU power down
or pending TCU/TBU invalidation/sync and so on. Debugging these often
require dumping of some implementation defined registers to know the
status of TBU/TCU operations and some of these registers are not
accessible in non-secure world such as from kernel and requires SMC
calls to read them in the secure world. So, add this debug support
to dump implementation defined registers for TLB sync timeout issues.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---

Changes in v2:
 * Use scm call consistently so that it works on older chipsets where
   some of these regs are secure registers.
 * Add device specific data to get the implementation defined register
   offsets.

---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
 3 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7820711c4560..bb68aa85b28b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -5,13 +5,27 @@
 
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
+#include <linux/delay.h>
 #include <linux/of_device.h>
 #include <linux/qcom_scm.h>
 
 #include "arm-smmu.h"
 
+#define QCOM_DUMMY_VAL	-1
+
+enum qcom_smmu_impl_reg_offset {
+	QCOM_SMMU_TBU_PWR_STATUS,
+	QCOM_SMMU_STATS_SYNC_INV_TBU_ACK,
+	QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR,
+};
+
+struct qcom_smmu_config {
+	const u32 *reg_offset;
+};
+
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
+	const struct qcom_smmu_config *cfg;
 	bool bypass_quirk;
 	u8 bypass_cbndx;
 	u32 stall_enabled;
@@ -22,6 +36,56 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 	return container_of(smmu, struct qcom_smmu, smmu);
 }
 
+static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+				int sync, int status)
+{
+	int ret;
+	unsigned int spin_cnt, delay;
+	u32 reg, tbu_pwr_status, sync_inv_ack, sync_inv_progress;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct qcom_smmu_config *cfg;
+
+	arm_smmu_writel(smmu, page, sync, QCOM_DUMMY_VAL);
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			reg = arm_smmu_readl(smmu, page, status);
+			if (!(reg & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
+				return;
+			cpu_relax();
+		}
+		udelay(delay);
+	}
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
+
+	cfg = qsmmu->cfg;
+	if (!cfg)
+		return;
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + cfg->reg_offset[QCOM_SMMU_TBU_PWR_STATUS],
+				&tbu_pwr_status);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read TBU power status: %d\n", ret);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + cfg->reg_offset[QCOM_SMMU_STATS_SYNC_INV_TBU_ACK],
+				&sync_inv_ack);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read TBU sync/inv ack status: %d\n", ret);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + cfg->reg_offset[QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR],
+				&sync_inv_progress);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read TCU syn/inv progress: %d\n", ret);
+
+	dev_err_ratelimited(smmu->dev,
+			    "TBU: power_status %#x sync_inv_ack %#x sync_inv_progress %#x\n",
+			    tbu_pwr_status, sync_inv_ack, sync_inv_progress);
+}
+
 static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
 		u32 reg)
 {
@@ -374,6 +438,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
@@ -382,12 +447,84 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
+	.tlb_sync = qcom_smmu_tlb_sync,
+};
+
+/* Implementation Defined Register Space 0 register offsets */
+static const u32 qcom_smmu_impl0_reg_offset[] = {
+	[QCOM_SMMU_TBU_PWR_STATUS]		= 0x2204,
+	[QCOM_SMMU_STATS_SYNC_INV_TBU_ACK]	= 0x25dc,
+	[QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR]	= 0x2670,
+};
+
+static const struct qcom_smmu_config qcm2290_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sc7180_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sc7280_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sc8180x_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sc8280xp_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm6125_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm6350_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm8150_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm8250_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm8350_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct qcom_smmu_config sm8450_smmu_cfg = {
+	.reg_offset = qcom_smmu_impl0_reg_offset,
+};
+
+static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
+	{ .compatible = "qcom,msm8998-smmu-v2" },
+	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcm2290_smmu_cfg },
+	{ .compatible = "qcom,sc7180-smmu-500", .data = &sc7180_smmu_cfg },
+	{ .compatible = "qcom,sc7280-smmu-500", .data = &sc7280_smmu_cfg},
+	{ .compatible = "qcom,sc8180x-smmu-500", .data = &sc8180x_smmu_cfg },
+	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &sc8280xp_smmu_cfg },
+	{ .compatible = "qcom,sdm630-smmu-v2" },
+	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6125-smmu-500", .data = &sm6125_smmu_cfg},
+	{ .compatible = "qcom,sm6350-smmu-500", .data = &sm6350_smmu_cfg},
+	{ .compatible = "qcom,sm8150-smmu-500", .data = &sm8150_smmu_cfg },
+	{ .compatible = "qcom,sm8250-smmu-500", .data = &sm8250_smmu_cfg },
+	{ .compatible = "qcom,sm8350-smmu-500", .data = &sm8350_smmu_cfg },
+	{ .compatible = "qcom,sm8450-smmu-500", .data = &sm8450_smmu_cfg },
+	{ }
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 		const struct arm_smmu_impl *impl)
 {
 	struct qcom_smmu *qsmmu;
+	const struct of_device_id *match;
+	const struct device_node *np = smmu->dev->of_node;
 
 	/* Check to make sure qcom_scm has finished probing */
 	if (!qcom_scm_is_available())
@@ -398,28 +535,16 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 		return ERR_PTR(-ENOMEM);
 
 	qsmmu->smmu.impl = impl;
+	match = of_match_node(qcom_smmu_impl_of_match, np);
+	if (!match)
+		goto out;
+
+	qsmmu->cfg = match->data;
 
+out:
 	return &qsmmu->smmu;
 }
 
-static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
-	{ .compatible = "qcom,msm8998-smmu-v2" },
-	{ .compatible = "qcom,qcm2290-smmu-500" },
-	{ .compatible = "qcom,sc7180-smmu-500" },
-	{ .compatible = "qcom,sc7280-smmu-500" },
-	{ .compatible = "qcom,sc8180x-smmu-500" },
-	{ .compatible = "qcom,sc8280xp-smmu-500" },
-	{ .compatible = "qcom,sdm630-smmu-v2" },
-	{ .compatible = "qcom,sdm845-smmu-500" },
-	{ .compatible = "qcom,sm6125-smmu-500" },
-	{ .compatible = "qcom,sm6350-smmu-500" },
-	{ .compatible = "qcom,sm8150-smmu-500" },
-	{ .compatible = "qcom,sm8250-smmu-500" },
-	{ .compatible = "qcom,sm8350-smmu-500" },
-	{ .compatible = "qcom,sm8450-smmu-500" },
-	{ }
-};
-
 #ifdef CONFIG_ACPI
 static struct acpi_platform_list qcom_acpi_platlist[] = {
 	{ "LENOVO", "CB-01   ", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..4c5b51109835 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2099,6 +2099,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 	ioaddr = res->start;
+	smmu->ioaddr = ioaddr;
+
 	/*
 	 * The resource size should effectively match the value of SMMU_TOP;
 	 * stash that temporarily until we know PAGESIZE to validate it with.
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 2b9b42fb6f30..703fd5817ec1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -278,6 +278,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 
 	void __iomem			*base;
+	phys_addr_t			ioaddr;
 	unsigned int			numpage;
 	unsigned int			pgshift;
 
-- 
2.33.1

