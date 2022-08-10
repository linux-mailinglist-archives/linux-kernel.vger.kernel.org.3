Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3755258E81F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiHJHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiHJHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:47:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8806E89D;
        Wed, 10 Aug 2022 00:47:46 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A4oIb2002937;
        Wed, 10 Aug 2022 07:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MDH5gCC0TxYIfWN0V+I8hbbu8ncTkQeK1wf0UC9ezmA=;
 b=ai4aL4nTgnTWACQnw25UFA7qDOARnLgFIg53OInLB3dQpGRVIV0Oc2yl4ghg+2EILdUw
 pNB5ZI01cZE5m0Wx8Ufc/rTrUTVSAp1K70hq+LjaZAmjFDVvz2aFSuLFdg0oZHbK3DXn
 F4GBE/c2A3Mzzkdsqupge2Joc3oqq80Jk4UcEQKvnv2Y2Trs7cqEyopDNqT7+dcHJOu7
 qrGIg1T5CrqG6a4anQI8nOoUVW/LlUT1U/BgIwnOXcG1/lDQVO+wt7bekCDey31T+e5U
 EnfOPNZJDCzJ0S8w8PuFCZheU6ekCnhlsdM2dmI6IQdl7JxTgDdIP7XW6RX9xwztLulA 8g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqr1mbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:47:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27A7l3Zs006174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 07:47:03 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:47:03 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 00:46:57 -0700
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
Subject: [PATCH v3 7/8] remoteproc: qcom: Add support for memory sandbox
Date:   Wed, 10 Aug 2022 13:15:57 +0530
Message-ID: <1660117558-21829-8-git-send-email-quic_srivasam@quicinc.com>
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
X-Proofpoint-GUID: VB7Oj8jVKBdEzjLHAFgeLDNRqvIb4g1p
X-Proofpoint-ORIG-GUID: VB7Oj8jVKBdEzjLHAFgeLDNRqvIb4g1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Update pil driver with SMMU mapping for allowing authorised
memory access to ADSP firmware, by reading required memory
regions either from device tree file or from resource table
embedded in ADSP binary header.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V2:
	-- Replace platform_bus_type with adsp->dev->bus.
	-- Use API of_parse_phandle_with_args() instead of of_parse_phandle_with_fixed_args().
	-- Replace adsp->is_wpss with adsp->is_adsp.
	-- Update error handling in adsp_start().

 drivers/remoteproc/qcom_q6v5_adsp.c | 107 +++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index f2945bf..b9cafe2 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -9,6 +9,7 @@
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -48,6 +49,8 @@
 #define LPASS_PWR_ON_REG		0x10
 #define LPASS_HALTREQ_REG		0x0
 
+#define SID_MASK_DEFAULT        0xF
+
 #define QDSP6SS_XO_CBCR		0x38
 #define QDSP6SS_CORE_CBCR	0x20
 #define QDSP6SS_SLEEP_CBCR	0x3c
@@ -78,7 +81,7 @@ struct adsp_pil_data {
 struct qcom_adsp {
 	struct device *dev;
 	struct rproc *rproc;
-
+	struct iommu_domain *iommu_dom;
 	struct qcom_q6v5 q6v5;
 
 	struct clk *xo;
@@ -333,6 +336,94 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
+{
+	struct of_phandle_args args;
+	struct fw_rsc_devmem *rsc_fw;
+	struct fw_rsc_hdr *hdr;
+	const __be32 *prop;
+	long long sid;
+	unsigned long mem_phys;
+	unsigned long iova;
+	unsigned int mem_size;
+	unsigned int flag;
+	unsigned int len;
+	int access_level;
+	int offset;
+	int ret;
+	int rc;
+	int i;
+
+	rc = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
+	if (rc < 0)
+		sid = -1;
+	else
+		sid = args.args[0] & SID_MASK_DEFAULT;
+
+	adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
+	if (!adsp->iommu_dom) {
+		dev_err(adsp->dev, "failed to allocate iommu domain\n");
+		return -ENOMEM;
+	}
+
+	ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
+	if (ret) {
+		dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
+		return -EBUSY;
+	}
+
+	/* Add SID configuration for ADSP Firmware to SMMU */
+	adsp->mem_phys =  adsp->mem_phys | (sid << 32);
+
+	ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
+			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
+	if (ret) {
+		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
+		return ret;
+	}
+
+	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		for (i = 0; i < len; i++) {
+			iova = be32_to_cpu(prop[i++]);
+			mem_phys = be32_to_cpu(prop[i++]);
+			mem_size = be32_to_cpu(prop[i++]);
+			access_level = be32_to_cpu(prop[i]);
+
+			if (access_level)
+				flag = IOMMU_READ | IOMMU_WRITE;
+			else
+				flag = IOMMU_READ;
+
+			ret = iommu_map(adsp->iommu_dom, iova, mem_phys, mem_size, flag);
+			if (ret) {
+				dev_err(adsp->dev, "failed to map addr = %p mem_size = %x\n",
+						&(mem_phys), mem_size);
+				return ret;
+			}
+		}
+	} else {
+		if (!rproc->table_ptr)
+			return 0;
+
+		for (i = 0; i < rproc->table_ptr->num; i++) {
+			offset = rproc->table_ptr->offset[i];
+			hdr = (void *)rproc->table_ptr + offset;
+			rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
+
+			ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
+						rsc_fw->len, rsc_fw->flags);
+			if (ret) {
+				pr_err("%s; unable to map adsp memory address\n", __func__);
+				return ret;
+			}
+		}
+	}
+	return 0;
+}
+
+
 static int adsp_start(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
@@ -343,9 +434,16 @@ static int adsp_start(struct rproc *rproc)
 	if (ret)
 		return ret;
 
+	if (adsp->is_adsp_sb_needed) {
+		ret = adsp_map_smmu(adsp, rproc);
+		if (ret) {
+			dev_err(adsp->dev, "ADSP smmu mapping failed\n");
+			goto disable_irqs;
+		}
+	}
 	ret = clk_prepare_enable(adsp->xo);
 	if (ret)
-		goto disable_irqs;
+		goto adsp_smmu_unmap;
 
 	ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
 				    adsp->proxy_pd_count);
@@ -401,6 +499,11 @@ static int adsp_start(struct rproc *rproc)
 	qcom_rproc_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 disable_xo_clk:
 	clk_disable_unprepare(adsp->xo);
+adsp_smmu_unmap:
+	if (adsp->is_adsp_sb_needed) {
+		iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
+		iommu_domain_free(adsp->iommu_dom);
+	}
 disable_irqs:
 	qcom_q6v5_unprepare(&adsp->q6v5);
 
-- 
2.7.4

