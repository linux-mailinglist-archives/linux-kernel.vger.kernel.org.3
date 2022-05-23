Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3C5316BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbiEWRlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbiEWR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:27:43 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB07CB5F;
        Mon, 23 May 2022 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653326601; x=1684862601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dHMAzDZ8V9eE7VWggUzuRgfi+1UxoewsEYqpet3YSy4=;
  b=AJNnbCiv5Yql8xQ4CicU9JEdSRwRe2V1cp2BHvh9ZdjlBCwJi67dR5Iq
   WtZfyfIojPEtll6rOWOFTYv0zXWfxf/w4HMIOAA7gj9lhtW05+xZI8SXI
   TmpQ9c9TUug5ibjVOcjoJ5NkbU0hyl/XFz6N93vNQSNuDAxfYZJFIobFr
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 May 2022 10:19:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:19:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 10:19:08 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 10:19:04 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>, <quic_guptap@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH] iommu/arm-smmu-qcom: Add debug support for TLB sync timeouts
Date:   Mon, 23 May 2022 22:48:47 +0530
Message-ID: <20220523171847.21929-1-quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 50 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      |  2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  4 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7820711c4560..22e9a0085475 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -5,11 +5,19 @@
 
 #include <linux/acpi.h>
 #include <linux/adreno-smmu-priv.h>
+#include <linux/delay.h>
 #include <linux/of_device.h>
 #include <linux/qcom_scm.h>
 
 #include "arm-smmu.h"
 
+#define QCOM_DUMMY_VAL	-1
+
+/* Implementation Defined Register Space 0 registers */
+#define QCOM_SMMU_STATS_SYNC_INV_TBU_ACK	0x5dc
+#define QCOM_SMMU_TBU_PWR_STATUS		0x2204
+#define QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR	0x2670
+
 struct qcom_smmu {
 	struct arm_smmu_device smmu;
 	bool bypass_quirk;
@@ -22,6 +30,46 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 	return container_of(smmu, struct qcom_smmu, smmu);
 }
 
+static void qcom_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+				int sync, int status)
+{
+	u32 sync_inv_ack, sync_inv_progress, tbu_pwr_status;
+	unsigned int spin_cnt, delay;
+	u32 reg;
+	int ret;
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
+	sync_inv_ack = arm_smmu_readl(smmu, ARM_SMMU_IMPL_DEF0,
+				      QCOM_SMMU_STATS_SYNC_INV_TBU_ACK);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + QCOM_SMMU_TBU_PWR_STATUS,
+				&tbu_pwr_status);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read TBU power status: %d\n", ret);
+
+	ret = qcom_scm_io_readl(smmu->ioaddr + QCOM_SMMU_MMU2QSS_AND_SAFE_WAIT_CNTR,
+				&sync_inv_progress);
+	if (ret)
+		dev_err_ratelimited(smmu->dev,
+				    "Failed to read SAFE WAIT counter: %d\n", ret);
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n"
+			    "TBU: sync_inv_ack %#x power_status %#x sync_inv_progress %#x\n",
+			    sync_inv_ack, tbu_pwr_status, sync_inv_progress);
+}
+
 static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
 		u32 reg)
 {
@@ -374,6 +422,7 @@ static const struct arm_smmu_impl qcom_smmu_impl = {
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
+	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
@@ -382,6 +431,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_impl = {
 	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
+	.tlb_sync = qcom_smmu_tlb_sync,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
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
index 2b9b42fb6f30..8cf6567d970f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -278,6 +278,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 
 	void __iomem			*base;
+	phys_addr_t			ioaddr;
 	unsigned int			numpage;
 	unsigned int			pgshift;
 
@@ -502,6 +503,9 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 
 #define ARM_SMMU_GR0		0
 #define ARM_SMMU_GR1		1
+
+#define ARM_SMMU_IMPL_DEF0	2
+
 #define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
 
 #define arm_smmu_gr0_read(s, o)		\
-- 
2.33.1

