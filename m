Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1361C5ABAEA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiIBWoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiIBWoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:44:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97BEC4D2;
        Fri,  2 Sep 2022 15:43:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282LVUaX002021;
        Fri, 2 Sep 2022 22:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=muKCLJscsbIjGX0JOeUeYjuP5L2suTLTSSDuc0hFFns=;
 b=ZJDizchvMvzkuPH+SGii0S5D+a1/QBP7ijpcEk71ecGcHl0Xoi+7OKgm+aub9djG9EG+
 6KqHFu06wB2PXD2aqJ5CJI07tMVFJN4+lfWXy1OcIrrjjv944MoB6sABk9TnEBD41Bz+
 mgU0Tv8D+0u2HR4uG637/wDj6pK0wjYEljRlOZEcJ5wOf3OX00459+qQR00pbzhCtj6s
 rMxU/n07CPJs7+X+4ZzYjRE7F8ymC2Eq5DSYvQ/uVzbEI1+GJE/aT2KZjLOBu0BM4ye4
 PuU2VEINLqJ05yHl90zK8ABAxL+Un3GyOb85TnPMsWo+h8/Fr9P/QFI6R5O1xWucbMjX 1g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb3k3c6a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 22:43:43 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282MhgeJ031512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 22:43:42 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 2 Sep 2022 15:43:42 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 4/4] ufs: host: qcom: Add MCQ support
Date:   Fri, 2 Sep 2022 15:41:40 -0700
Message-ID: <260533ec3a80442b73d3999727bf0a9861462eba.1662157846.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1662157846.git.quic_asutoshd@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cpsveCS_uIHdEVbmAeslFQHXDwUyjNlQ
X-Proofpoint-ORIG-GUID: cpsveCS_uIHdEVbmAeslFQHXDwUyjNlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020101
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <quic_cang@quicinc.com>

Use ESI and define Runtime and Operation definitions for MCQ.

Co-developed-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     |   1 +
 drivers/ufs/core/ufshcd-priv.h |   2 -
 drivers/ufs/host/ufs-qcom.c    | 134 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-qcom.h    |  13 ++++
 include/ufs/ufshcd.h           |   2 +
 5 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 7f95754..24370ae 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -445,6 +445,7 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
 
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq)
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index b709695..a645f8a 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -56,8 +56,6 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 set);
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
-unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
-					 struct ufs_hw_queue *hwq);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 473fad8..d3bbcb6 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -25,6 +25,8 @@
 #define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
 	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
 
+#define	MAX_SUPP_MAC	63
+
 enum {
 	TSTBUS_UAWM,
 	TSTBUS_UARM,
@@ -1424,6 +1426,134 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
+					unsigned long *ocqs)
+{
+	u32 cqis_vs;
+	struct ufshcd_res_info_t *mcq_vs_res = &hba->res[RES_MCQ_VS];
+
+	if (!mcq_vs_res->base)
+		return -EINVAL;
+
+	cqis_vs = readl(mcq_vs_res->base + UFS_MEM_CQIS_VS);
+	*ocqs = cqis_vs;
+
+	return 0;
+}
+
+static int ufs_qcom_config_queues(struct ufs_hba *hba)
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
+	for (i = 0; i < ROP_MAX; i++) {
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
+static int ufs_qcom_config_esi(struct ufs_hba *hba)
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
+			reg = ufshcd_readl(hba, REG_UFS_CFG3);
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
+static int ufs_qcom_config_esi(struct ufs_hba *hba)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
+{
+	return MAX_SUPP_MAC;
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1447,6 +1577,10 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.get_outstanding_cqs	= ufs_qcom_get_outstanding_cqs,
+	.config_queues		= ufs_qcom_config_queues,
+	.get_hba_mac		= ufs_qcom_get_hba_mac,
+	.config_esi		= ufs_qcom_config_esi,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a3..859203a 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -53,6 +53,8 @@ enum {
 	 * added in HW Version 3.0.0
 	 */
 	UFS_AH8_CFG				= 0xFC,
+
+	REG_UFS_CFG3				= 0x271C,
 };
 
 /* QCOM UFS host controller vendor specific debug registers */
@@ -72,6 +74,15 @@ enum {
 	UFS_UFS_DBG_RD_EDTL_RAM			= 0x1900,
 };
 
+/* QCOM UFS MCQ vendor specific registers */
+enum {
+	UFS_MEM_MCQ_VS_CFG0				= 0x0,
+	UFS_MEM_SQIS_VS					= 0x4,
+	UFS_MEM_CQIS_VS					= 0x8,
+	UFS_MEM_IAGIS_VS				= 0xC,
+	UFS_MEM_IAGQTYPE_VS				= 0x10,
+};
+
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
@@ -221,6 +232,8 @@ struct ufs_qcom_host {
 	struct reset_controller_dev rcdev;
 
 	struct gpio_desc *device_reset;
+
+	int esi_base;
 };
 
 static inline u32
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 71bab73..5805128 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1235,6 +1235,8 @@ extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
 extern void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
 extern void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
+extern unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
-- 
2.7.4

