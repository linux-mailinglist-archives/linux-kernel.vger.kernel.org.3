Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E858E819
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHJHsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHJHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BC66E8A2;
        Wed, 10 Aug 2022 00:47:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A4xHSk026309;
        Wed, 10 Aug 2022 07:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kw2ZC8sC7x+cqfiQ3ZNhh2i8yULi4ctNpNX8Ot1GGII=;
 b=cFyiP88LdcfcWDYpYTBYSWJjPtZbBfyi6YjBJvycHpRIHgNRZEW1LZd/MMZCEBFZzoI1
 yAi2F0p4nbj+vT9spYvUjaHqzXEDunbGnq9+MRy+MjFxS6vS3HWuT2zCbEVlRYoYcn8G
 OO+Lcr1jjIM7+ZoM/atJkXxqYAh60bPsnpi8+VcTCONXm2N+OtiGRK0UJuMQYDkSJ/De
 /Qa6m2+8c5ldIMkrOufT5O/t/itaVqFcjj3VwdG+sB0CKspYDC7o0XdwLiNzi1X1QkWB
 opY609GEsAg31QItzW7tlRCrnd3SYuauj8nTCM6KjfGpKSjEMDpR8g025ooT7tNiB9vz LQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqgsknn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:46:58 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A7kvJM007719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:46:57 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:57 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:51 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 6/8] remoteproc: qcom: Add efuse evb selection control
Date:   Wed, 10 Aug 2022 13:15:56 +0530
Message-ID: <1660117558-21829-7-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FWtNN2bzBRZin2gP8hRV3nvFWfzCHZj1
X-Proofpoint-ORIG-GUID: FWtNN2bzBRZin2gP8hRV3nvFWfzCHZj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=990 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse evb selection control and enable it for starting ADSP.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 141fd339..f2945bf 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -56,6 +56,7 @@
 
 #define LPASS_BOOT_CORE_START	BIT(0)
 #define LPASS_BOOT_CMD_START	BIT(0)
+#define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
 
 struct adsp_pil_data {
 	int crash_reason_smem;
@@ -86,6 +87,7 @@ struct qcom_adsp {
 	struct clk_bulk_data *clks;
 
 	void __iomem *qdsp6ss_base;
+	void __iomem *lpass_efuse;
 
 	struct reset_control *pdc_sync_reset;
 	struct reset_control *restart;
@@ -368,6 +370,9 @@ static int adsp_start(struct rproc *rproc)
 	/* Program boot address */
 	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
 
+	if (adsp->lpass_efuse)
+		writel(LPASS_EFUSE_Q6SS_EVB_SEL, adsp->lpass_efuse);
+
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
 	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
 
@@ -522,6 +527,11 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
 		return PTR_ERR(adsp->qdsp6ss_base);
 	}
 
+	adsp->lpass_efuse =  devm_platform_ioremap_resource_byname(pdev, "lpass_efuse");
+	if (IS_ERR(adsp->lpass_efuse)) {
+		adsp->lpass_efuse = NULL;
+		dev_dbg(adsp->dev, "failed to map LPASS efuse registers\n");
+	}
 	syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
 	if (!syscon) {
 		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
-- 
2.7.4

