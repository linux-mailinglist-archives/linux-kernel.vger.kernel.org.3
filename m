Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDE25ABAE6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIBWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIBWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:43:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A49EA15D;
        Fri,  2 Sep 2022 15:43:42 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282L4fBA016212;
        Fri, 2 Sep 2022 22:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=6M5dp3trBJ8WDJJrWqCEo3IXPxB3TyWcmUQuDOO0+zA=;
 b=IFoAuIGogRzELtt843yBwaFyzUl+AshGko0SAtQNGINXNxtUA0e6TZ5EX6AT0cxrP6ih
 L8DJWKT1vbptoXYfx5FgkxI+rSYY1PgrX8WeNcPNmuahyBVSZbnEB3WtpW+dbzRJio5F
 dqUBbeDc6o8Eucl6uSr0HJh6irbrWYluqwyFmeh3gwpOF1e26sobX2ZTaA5hzu5+mfqo
 j0jT8/MFOk5RxQI2LqdZ9eiwOh+uxiTxYCWkY5QyNljYcqvKSlECh1tK5FluQAqDa2hb
 zc/zlchjIEglX9cLpKIUZ7Xqag7s6fIBH6LlLtlbCzXQ2kWFNNK5EIcDzmrRnxDjAzIX 1g== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb5k93ump-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 22:43:30 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 282MhT0G013398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 22:43:29 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 2 Sep 2022 15:43:29 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <quic_cang@quicinc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/4] ufs: core: Add Event Specific Interrupt configuration vendor specific ops
Date:   Fri, 2 Sep 2022 15:41:39 -0700
Message-ID: <94347f53d62f8ecf7dc2f2e13e2586f395efdb62.1662157846.git.quic_asutoshd@quicinc.com>
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
X-Proofpoint-ORIG-GUID: TR6Hobyl6lP6MNmpWQB4motNxi0gGJ-h
X-Proofpoint-GUID: TR6Hobyl6lP6MNmpWQB4motNxi0gGJ-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0
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

As Event Specific Interrupt message format is not defined in UFSHCI JEDEC
specs, and the ESI handling highly depends on how the format is designed,
hence add a vendor specific ops such that SoC vendors can configure their
own ESI handlers. If ESI vops is not provided or returning error, go with
the legacy (central) interrupt way.
Added APIs to enable ESI and config ESI base addresses.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 14 ++++++++++++++
 drivers/ufs/core/ufshcd-priv.h |  8 ++++++++
 drivers/ufs/core/ufshcd.c      |  6 ++++++
 include/ufs/ufshcd.h           |  5 +++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index e23557b..7f95754 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -457,3 +457,17 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
+
+void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
+{
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
+		      REG_UFS_MEM_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
+
+void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
+{
+	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
+	ufshcd_writel(hba, msg->address_hi, REG_UFS_ESIUBA);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_esi);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 4e9e2755..b709695 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -254,6 +254,14 @@ static inline int ufshcd_mcq_vops_get_hba_mac(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_esi)
+		return hba->vops->config_esi(hba);
+
+	return -EOPNOTSUPP;
+}
+
 static inline void ufshcd_inc_tp(struct ufs_hw_queue *q)
 {
 	u32 mask = q->max_entries - 1;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ec40d46..f5bb0eb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8306,6 +8306,12 @@ static int ufshcd_config_mcq(struct ufs_hba *hba)
 		goto err;
 	}
 
+	ret = ufshcd_mcq_vops_config_esi(hba);
+	if (ret) {
+		dev_info(hba->dev, "MCQ ESI not available %d\n", ret);
+		ret = 0;
+	}
+
 	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
 	ufshcd_mcq_make_queues_operational(hba);
 	ufshcd_mcq_config_mac(hba, hba->nutrs);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 8c10b09..71bab73 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -16,6 +16,7 @@
 #include <linux/blk-crypto-profile.h>
 #include <linux/blk-mq.h>
 #include <linux/devfreq.h>
+#include <linux/msi.h>
 #include <linux/pm_runtime.h>
 #include <scsi/scsi_device.h>
 #include <ufs/unipro.h>
@@ -297,6 +298,7 @@ struct ufs_pwr_mode_info {
  * @get_outstanding_cqs: called to get outstanding completion queues
  * @config_queues: called to config Runtime Operation Pointers
  * @get_hba_mac: called to get vendor specific mac value
+ * @config_esi: called to config Event Specific Interrupt
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -339,6 +341,7 @@ struct ufs_hba_variant_ops {
 				       unsigned long *ocqs);
 	int	(*config_queues)(struct ufs_hba *hba);
 	int	(*get_hba_mac)(struct ufs_hba *hba);
+	int	(*config_esi)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -1230,6 +1233,8 @@ extern int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 extern int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 			struct ufs_pa_layer_attr *desired_pwr_mode);
 extern int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode);
+extern void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+extern void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
 /* UIC command interfaces for DME primitives */
 #define DME_LOCAL	0
-- 
2.7.4

