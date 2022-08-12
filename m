Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16B25910FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiHLMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiHLMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:49:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529AB0B27;
        Fri, 12 Aug 2022 05:49:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5wWrC015732;
        Fri, 12 Aug 2022 12:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Xf+IX2U66sCC6/J8Rap0DTZgRqGVjsxKf4X6I9mo4M0=;
 b=Q0S9l4l4MzDEg14U4BPmhVUzqxkAvIqo97ZKV81fDE6VVNKVLS4GAZIwl/SmRccESM7U
 +8IcnrslIBSio7KwP8Z9+C50TjG6Y0BJYSr4F1k/Vf+AC6JAPLffS8DphYJT6yPbTFd7
 73m0zWnK72MDcYGZTO+xpmlRF2Qte3BlKjv9dV2cHHCkOz3cxObcXe/EOd63WnhrdlRh
 rah2we/8HO9WPlAVWIPY51DEoAhTXSPRq7i2midZFHbYGA9WFYnxsPNsK9+u/FDxQHfF
 cYn0vThMZb/W6/V/Q7yv/w/C8x+rcOqI2GN/VI6/aNLA12JA6eVSC6TO/IEc1I6uTJYn tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hw011m7ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27CCmTYt029430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:29 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 12 Aug 2022 05:48:24 -0700
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
Subject: [PATCH v4 4/7] remoteproc: qcom: Replace hard coded values with macros
Date:   Fri, 12 Aug 2022 18:17:43 +0530
Message-ID: <1660308466-410-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -aCgXiQv_6JWU7QasTCsg4O8vjt92OWc
X-Proofpoint-GUID: -aCgXiQv_6JWU7QasTCsg4O8vjt92OWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120034
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard coded values of QDSP6 boot control reg params
with appropriate macro names.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6d409ca..701a615 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -54,6 +54,9 @@
 
 #define QCOM_Q6V5_RPROC_PROXY_PD_MAX	3
 
+#define LPASS_BOOT_CORE_START	BIT(0)
+#define LPASS_BOOT_CMD_START	BIT(0)
+
 struct adsp_pil_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -366,10 +369,10 @@ static int adsp_start(struct rproc *rproc)
 	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
 
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
-	writel(0x1, adsp->qdsp6ss_base + CORE_START_REG);
+	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
 
 	/* Trigger boot FSM to start QDSP6 */
-	writel(0x1, adsp->qdsp6ss_base + BOOT_CMD_REG);
+	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
 
 	/* Wait for core to come out of reset */
 	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
-- 
2.7.4

