Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B185B1EBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiIHNZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiIHNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:24:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116ED51A2B;
        Thu,  8 Sep 2022 06:24:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Cxq8n017019;
        Thu, 8 Sep 2022 13:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=uyuD80VLPNSnCDFRkjpOw8ma52k8KaatGk3RxBELPPY=;
 b=hE61toNMUn1wYmbAOqTmuLYQTNVxQ38QKz38z+zqfSYX4CtxOrIZsAiC7dRsSQMcrAe7
 Z7h31rXdoOZlPSMrU242oGYEQAF93wg6RqvG8l2PcDXnVuy9UbCQt7EDggrO+DJ+FC+e
 IpGvZTDOoHyy9uK/Z1+xNaw5zZ/X9c8Jz7qfeDSOSpnDwDRjj0o3NPC7SA6T7i2ud7G3
 m8moX1EAmniSWR9axJPZncXddWi/227b/e03Ii+WFKFae1DfZsmSrh/8zkXsEU6GUGLH
 BHfCgnAmBO7sgudmCeTHUs1h9KIzx0y/A0Igjs3gzm5HDRtL9KER1DO0i/AcGbV86Wtd Bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swt11h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:24:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288DOGJP005351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 13:24:16 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 06:24:10 -0700
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
Subject: [PATCH v6 2/8] remoteproc: qcom: Add flag in adsp private data structure
Date:   Thu, 8 Sep 2022 18:53:36 +0530
Message-ID: <1662643422-14909-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9bLxx1skLbhur00I_anDQ9Q4YRM6bKEG
X-Proofpoint-ORIG-GUID: 9bLxx1skLbhur00I_anDQ9Q4YRM6bKEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_08,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flag in qcom_adsp private data structure and initialize
it to distinguish ADSP and WPSS modules for using iommu selectively.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since V5:
	-- Rename adsp_sandbox_needed to has_iommu.
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
Changes since V2:
	-- Add is_adsp_sb_needed flag instead of is_wpss.

 drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 2f3b9f5..fa2ccac 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -62,6 +62,7 @@ struct adsp_pil_data {
 	const char *sysmon_name;
 	int ssctl_id;
 	bool is_wpss;
+	bool has_iommu;
 	bool auto_boot;
 
 	const char **clk_ids;
@@ -99,6 +100,7 @@ struct qcom_adsp {
 	phys_addr_t mem_reloc;
 	void *mem_region;
 	size_t mem_size;
+	bool has_iommu;
 
 	struct device *proxy_pds[QCOM_Q6V5_RPROC_PROXY_PD_MAX];
 	size_t proxy_pd_count;
@@ -596,12 +598,15 @@ static int adsp_probe(struct platform_device *pdev)
 	}
 
 	rproc->auto_boot = desc->auto_boot;
+	rproc->has_iommu = desc->has_iommu;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	adsp = (struct qcom_adsp *)rproc->priv;
 	adsp->dev = &pdev->dev;
 	adsp->rproc = rproc;
 	adsp->info_name = desc->sysmon_name;
+	adsp->has_iommu = desc->has_iommu;
+
 	platform_set_drvdata(pdev, adsp);
 
 	if (desc->is_wpss)
-- 
2.7.4

