Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EFC5793B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiGSHCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiGSHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:02:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E57201B9;
        Tue, 19 Jul 2022 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658214167; x=1689750167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zYEE7oA0AAXjpYw8BgsEJRJVz8FYDDcx/D6Yvikbr/I=;
  b=EbBGJWaJySGh8P8vrUver9jnIJs3CtrbIK6O+BqTKTkU58/+Uz7KlZaq
   uROsMbzMOpPm5vjj2sU5Tm4R9Z/mv76kS/VihEsXNn3a0jqmj2DZGsZoH
   Z60Ns2LVETzu+57pttV7l5XN1JE3Y4TCUq2sAJNZZGw/iNtWJYOBP86KV
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jul 2022 00:02:47 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg01-sd.qualcomm.com with ESMTP; 19 Jul 2022 00:02:47 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id BCB9B22784; Tue, 19 Jul 2022 00:02:46 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     bvanassche@acm.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, beanhuo@micron.com, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        quic_cang@quicinc.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] scsi: ufs-qcom: Implement three CMQ related vops
Date:   Tue, 19 Jul 2022 00:01:59 -0700
Message-Id: <1658214120-22772-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read MCQ_CQIS_VS to figure out the outstanding CQs for legacy ISR.
Configure the MCQ Runtime Operation Pointers.
Implement the MCQ ESI handler.

Co-developed-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/host/ufs-qcom.c | 116 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.h |   2 +
 2 files changed, 118 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 473fad8..7a9e023 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1424,6 +1424,119 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
+					unsigned long *ocqs)
+{
+	return -EINVAL;
+}
+
+static int ufs_qcom_config_mcq_rop(struct ufs_hba *hba)
+{
+	struct ufshcd_mcq_rop_info_t *rop;
+	struct ufshcd_res_info_t *mem_res, *sqdao_res;
+	int i;
+
+	mem_res = &hba->res[RES_MEM];
+	sqdao_res = &hba->res[RES_MCQ_SQD];
+
+	if (!mem_res->base || !sqdao_res->base)
+		return -EINVAL;
+
+	for(i = 0; i < ROP_MAX; i++) {
+		rop = &hba->mcq_rop[i];
+		rop->offset = sqdao_res->resource->start -
+			      mem_res->resource->start + 0x40 * i;
+		rop->stride = 0x100;
+		rop->base = sqdao_res->base + 0x40 * i;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct device *dev = msi_desc_to_dev(desc);
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	ufshcd_mcq_config_esi(hba, msg);
+}
+
+static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *__hba)
+{
+	struct ufs_hba *hba = __hba;
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	u32 event_id = irq - host->esi_base;
+	struct ufs_hw_queue *hwq = &hba->uhq[event_id];
+
+	ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+
+	return IRQ_HANDLED;
+}
+
+static int ufs_qcom_config_mcq_esi(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct msi_desc *desc;
+	struct msi_desc *failed_desc = NULL;
+	u32 reg;
+	int nr_irqs, ret;
+
+	/*
+	 * 1. We only handle CQs as of now.
+	 * 2. Poll queues do not need ESI.
+	 */
+	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	ret = platform_msi_domain_alloc_irqs(hba->dev, nr_irqs,
+					     ufs_qcom_write_msi_msg);
+	if (ret)
+		goto out;
+
+	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
+		if (!desc->msi_index)
+			host->esi_base = desc->irq;
+
+		ret = devm_request_irq(hba->dev, desc->irq,
+				       ufs_qcom_mcq_esi_handler,
+				       0, "qcom-mcq-esi", hba);
+		if (ret) {
+			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err = %d\n",
+				__func__, desc->irq, ret);
+			failed_desc = desc;
+			break;
+		}
+	}
+
+	if (ret) {
+		/* Rewind */
+		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
+			if (desc == failed_desc)
+				break;
+			devm_free_irq(hba->dev, desc->irq, hba);
+		}
+	} else {
+		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+		    host->hw_ver.step == 0) {
+			reg = ufshcd_readl(hba, REG_UFS_CFG3);
+			reg |= 0x1F000;
+			ufshcd_writel(hba, reg, REG_UFS_CFG3);
+		}
+		ufshcd_mcq_enable_esi(hba);
+	}
+
+out:
+	if (ret)
+		dev_warn(hba->dev, "Failed to request Platform MSI %d\n", ret);
+	return ret;
+}
+
+#else
+static int ufs_qcom_config_mcq_esi(struct ufs_hba *hba)
+{
+	return -EINVAL;
+}
+#endif
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1447,6 +1560,9 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
+	.config_mcq_rop		= ufs_qcom_config_mcq_rop,
+	.config_mcq_esi		= ufs_qcom_config_mcq_esi,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a3..f6f06b2 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -53,6 +53,7 @@ enum {
 	 * added in HW Version 3.0.0
 	 */
 	UFS_AH8_CFG				= 0xFC,
+	REG_UFS_CFG3				= 0x271C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
@@ -221,6 +222,7 @@ struct ufs_qcom_host {
 	struct reset_controller_dev rcdev;
 
 	struct gpio_desc *device_reset;
+	int esi_base;
 };
 
 static inline u32
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

