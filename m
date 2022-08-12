Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03159110A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiHLMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiHLMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:49:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51269B0B39;
        Fri, 12 Aug 2022 05:49:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C6J8QP018855;
        Fri, 12 Aug 2022 12:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=b62rWQWc7aAt6ZphJwk1WSp3VTQZYefefQmDDbUs7o8=;
 b=ayTvJGWnYMDvkKe57VndNcAkqC6X0AIDFaG9nomsoZPIZOl9HTgLZijGsa6aUvp8OhgR
 t7VbVO/quxYn0akSE9NxqTzWLkrVRnF7tHa0lPafLQePZ9J2W+/iMgE/psLr/wfa3NZj
 6fmW4ZVJMOCp5/2pb1epm2PKCBablhglTozwZJBQ9lCvWLOmlpAD7P3svQfUSl0Zb2nV
 U4kGpEhdPBPPln6VDWPpktDhY9u7yXFHFJL0JPO3cUnnnBIrjO0LbzKe/+tmB0p+rXG9
 x/6pNNWGSZ3atA8sMlrn7OR87PVTSZ84vis5nrx/2m3Li1LU7+WdDFoQ0SmDAiHPIxPs Gg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwh7chdc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27CCmkrp003398
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:46 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 12 Aug 2022 05:48:40 -0700
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
Subject: [PATCH v4 7/7] remoteproc: qcom: Update QDSP6 out-of-reset timeout value
Date:   Fri, 12 Aug 2022 18:17:46 +0530
Message-ID: <1660308466-410-8-git-send-email-quic_srivasam@quicinc.com>
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
X-Proofpoint-GUID: fC-krQFFdLXL9taM3xBUEmkcBkOGChpN
X-Proofpoint-ORIG-GUID: fC-krQFFdLXL9taM3xBUEmkcBkOGChpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208120034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update QDSP6 out-of-reset timeout value to 1 second, as sometimes
ADSP boot failing on SC7280 based platforms with existing value.
Also add few micro seconds sleep after enabling boot core
start register.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index ca45d2c..2b5b172 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -34,7 +34,7 @@
 /* time out value */
 #define ACK_TIMEOUT			1000
 #define ACK_TIMEOUT_US			1000000
-#define BOOT_FSM_TIMEOUT		10000
+#define BOOT_FSM_TIMEOUT		1000000
 /* mask values */
 #define EVB_MASK			GENMASK(27, 4)
 /*QDSP6SS register offsets*/
@@ -534,13 +534,14 @@ static int adsp_start(struct rproc *rproc)
 
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
 	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
+	usleep_range(100, 110);
 
 	/* Trigger boot FSM to start QDSP6 */
 	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
 
 	/* Wait for core to come out of reset */
 	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
-			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
+			val, (val & BIT(0)) != 0, 100, BOOT_FSM_TIMEOUT);
 	if (ret) {
 		dev_err(adsp->dev, "failed to bootup adsp\n");
 		goto disable_adsp_clks;
-- 
2.7.4

