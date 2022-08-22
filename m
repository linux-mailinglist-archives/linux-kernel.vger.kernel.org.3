Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB2A59BB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiHVIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiHVIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:23:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18127D56;
        Mon, 22 Aug 2022 01:23:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27M8C1PU022320;
        Mon, 22 Aug 2022 08:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NRhqXg8CC7bRyrO+2T0kaicCl7jB3rTvLAmesS0CbKE=;
 b=B/51MjodUcC5CHiv3mUVy+JSvv8bZwvJp3kVKnRlsvnJmdijCp2ScdsBeXjgh/bdMDu9
 OWkdRBla3uYa8I0XCO1wDfGoOdQ+dy2dEyr4mggDDbJfuqhurtJWyRYQiJLvMVTEoj0R
 FSO3Nxkvl0JqXLtpllC+lOVaVp/K2uaTM/V0IvlfEIhfqg2BcQCyymAW1LlsRBtLtXkz
 yhFkGbWM8KSEqhGoofetUYeqgsaL4CyEHaCoNKd7aGGdDC7AeStt9vM3pibpuap3e9XY
 3KB9/oxH5sdHU/xqjcAVJjxRJil3AYusXKJU95R1tkD4Y/J7T0ZIN0VuzDdUz0yRUAJ4 zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j2vwn3nc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:22:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27M8MbTS015742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 08:22:37 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 22 Aug 2022 01:22:32 -0700
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
Subject: [RESEND v5 2/7] remoteproc: qcom: Add flag in adsp private data structure
Date:   Mon, 22 Aug 2022 13:51:58 +0530
Message-ID: <1661156523-22611-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eHCiFXVKFCID7Zy-3aiqdD4Qrfz2b8Vf
X-Proofpoint-ORIG-GUID: eHCiFXVKFCID7Zy-3aiqdD4Qrfz2b8Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flag in qcom_adsp private data structure and initialize
it to distinguish ADSP and WPSS modules.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
Changes since V2:
	-- Add is_adsp_sb_needed flag instead of is_wpss.

 drivers/remoteproc/qcom_q6v5_adsp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 2f3b9f5..d0b767f 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -62,6 +62,7 @@ struct adsp_pil_data {
 	const char *sysmon_name;
 	int ssctl_id;
 	bool is_wpss;
+	bool adsp_sandbox_needed;
 	bool auto_boot;
 
 	const char **clk_ids;
@@ -99,6 +100,7 @@ struct qcom_adsp {
 	phys_addr_t mem_reloc;
 	void *mem_region;
 	size_t mem_size;
+	bool adsp_sandbox_needed;
 
 	struct device *proxy_pds[QCOM_Q6V5_RPROC_PROXY_PD_MAX];
 	size_t proxy_pd_count;
@@ -602,6 +604,8 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->dev = &pdev->dev;
 	adsp->rproc = rproc;
 	adsp->info_name = desc->sysmon_name;
+	adsp->adsp_sandbox_needed = desc->adsp_sandbox_needed;
+
 	platform_set_drvdata(pdev, adsp);
 
 	if (desc->is_wpss)
-- 
2.7.4

