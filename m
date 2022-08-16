Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DC595ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiHPLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiHPLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:50:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFA1A05E;
        Tue, 16 Aug 2022 04:25:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GBDO9U020498;
        Tue, 16 Aug 2022 11:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=QEUBd+vfZF0oXr4+1SuXKSbdIUpuzR7vFfdc53uAHtY=;
 b=JAJPZPLUtpjuAIeKHmPDv/qLhlGgMHeSiAqaVaTWM6oObMqbvCBo47mYHokYLc/fZylH
 Iwq91h2BLF4K6AugNIADuGC/JtKsAUNXhvcMVwJORMgi2e/wVwOJMhj11PVxs3uTFtWO
 qxoAxGKHK2CZkkuVEspzLICnPhWb+ycp7LQ6Vky3y8TTD3ipiOSAeHGts3ODqiyVIQ0O
 8KIANI61L+MzR7WYdYlmp9Fh75bnyxExfyKsyDgKKtzVNVl8wwi/i7A7VGIYqY4wEFRf
 tcIoYAE1JyywT9NlHEhans6VChW8r0fU+2IxS3FHyDXtRTbJ9dsCsCLIvuhZt9KWZ661 Bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j058t12gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 11:24:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GBOjkS016330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 11:24:45 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 04:24:39 -0700
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
Subject: [PATCH v5 6/7] remoteproc: qcom: Add support for memory sandbox
Date:   Tue, 16 Aug 2022 16:53:53 +0530
Message-ID: <1660649034-4303-7-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660649034-4303-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660649034-4303-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uA2cXuv-hRvPitZBzpPazmbNa-kHMoAf
X-Proofpoint-GUID: uA2cXuv-hRvPitZBzpPazmbNa-kHMoAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208160042
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
Changes since V4:
	-- Split the code and add appropriate APIs for resource allocation and free.
	-- Update adsp_unmap_smmu with missing free ops call.
	-- Update normalizing length value in adsp_of_unmap_smmu.
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
	-- Add smmu unmapping in error case and in adsp stop.
Changes since V2:
	-- Replace platform_bus_type with adsp->dev->bus.
	-- Use API of_parse_phandle_with_args() instead of of_parse_phandle_with_fixed_args().
	-- Replace adsp->is_wpss with adsp->is_adsp.
	-- Update error handling in adsp_start().

 drivers/remoteproc/qcom_q6v5_adsp.c | 200 +++++++++++++++++++++++++++++++++++-
 1 file changed, 198 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index b0a63a0..b0faa4b 100644
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
@@ -333,6 +336,185 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
+{
+	unsigned long iova;
+	unsigned int mem_size;
+	int i;
+
+	len /= sizeof(__be32);
+	for (i = 0; i < len; i++) {
+		iova = be32_to_cpu(prop[i++]);
+		/* Skip Physical address*/
+		i++;
+		mem_size = be32_to_cpu(prop[i++]);
+		iommu_unmap(iommu_dom, iova, mem_size);
+	}
+}
+
+static void adsp_rproc_unmap_smmu(struct rproc *rproc, int len)
+{
+	struct fw_rsc_devmem *rsc_fw;
+	struct fw_rsc_hdr *hdr;
+	int offset;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		offset = rproc->table_ptr->offset[i];
+		hdr = (void *)rproc->table_ptr + offset;
+		rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
+
+		iommu_unmap(rproc->domain, rsc_fw->da, rsc_fw->len);
+	}
+}
+
+static void adsp_unmap_smmu(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+	const __be32 *prop;
+	unsigned int len;
+
+	iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
+
+	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
+	if (prop) {
+		adsp_of_unmap_smmu(adsp->iommu_dom, prop, len);
+	} else {
+		if (rproc->table_ptr)
+			adsp_rproc_unmap_smmu(rproc, rproc->table_ptr->num);
+	}
+
+	iommu_domain_free(adsp->iommu_dom);
+}
+
+static int adsp_of_map_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
+{
+	unsigned long mem_phys;
+	unsigned long iova;
+	unsigned int mem_size;
+	unsigned int flag;
+	int access_level;
+	int ret;
+	int i;
+
+	len /= sizeof(__be32);
+	for (i = 0; i < len; i++) {
+		iova = be32_to_cpu(prop[i++]);
+		mem_phys = be32_to_cpu(prop[i++]);
+		mem_size = be32_to_cpu(prop[i++]);
+		access_level = be32_to_cpu(prop[i]);
+
+		if (access_level)
+			flag = IOMMU_READ | IOMMU_WRITE;
+		else
+			flag = IOMMU_READ;
+
+		ret = iommu_map(iommu_dom, iova, mem_phys, mem_size, flag);
+		if (ret) {
+			pr_err("failed to map addr = %p mem_size = %x\n", &(mem_phys), mem_size);
+			goto of_smmu_unmap;
+		}
+	}
+	return 0;
+of_smmu_unmap:
+	adsp_of_unmap_smmu(iommu_dom, prop, i);
+	return ret;
+}
+
+static int adsp_rproc_map_smmu(struct rproc *rproc, int len)
+{
+	struct fw_rsc_devmem *rsc_fw;
+	struct fw_rsc_hdr *hdr;
+	int offset;
+	int ret;
+	int i;
+
+	if (!rproc->table_ptr)
+		return 0;
+
+	for (i = 0; i < rproc->table_ptr->num; i++) {
+		offset = rproc->table_ptr->offset[i];
+		hdr = (void *)rproc->table_ptr + offset;
+		rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
+
+		ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
+					rsc_fw->len, rsc_fw->flags);
+		if (ret) {
+			pr_err("failed to map addr = %p mem_size = %x\n", rsc_fw->pa, rsc_fw->len);
+			goto  rproc_smmu_unmap;
+		}
+	}
+
+	return 0;
+
+rproc_smmu_unmap:
+	adsp_rproc_unmap_smmu(rproc, i);
+	return ret;
+}
+
+static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
+{
+	struct of_phandle_args args;
+	const __be32 *prop;
+	long long sid;
+	unsigned int len;
+	int ret;
+
+	ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
+	if (ret < 0)
+		sid = -1;
+	else
+		sid = args.args[0] & SID_MASK_DEFAULT;
+
+	adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
+	if (!adsp->iommu_dom) {
+		dev_err(adsp->dev, "failed to allocate iommu domain\n");
+		ret = -ENOMEM;
+		goto domain_free;
+	}
+
+	ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
+	if (ret) {
+		dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
+		ret = -EBUSY;
+		goto detach_device;
+	}
+
+	/* Add SID configuration for ADSP Firmware to SMMU */
+	adsp->mem_phys =  adsp->mem_phys | (sid << 32);
+
+	ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
+			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
+	if (ret) {
+		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
+		goto sid_unmap;
+	}
+
+	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
+	if (prop) {
+		ret = adsp_of_map_smmu(adsp->iommu_dom, prop, len);
+		if (ret) {
+			dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");
+			goto sid_unmap;
+		}
+	} else {
+		ret = adsp_rproc_map_smmu(rproc, len);
+		if (ret) {
+			dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");
+			goto sid_unmap;
+		}
+	}
+	return 0;
+
+sid_unmap:
+	iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
+detach_device:
+	iommu_domain_free(adsp->iommu_dom);
+domain_free:
+	return ret;
+}
+
+
 static int adsp_start(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
@@ -343,9 +525,16 @@ static int adsp_start(struct rproc *rproc)
 	if (ret)
 		return ret;
 
+	if (adsp->adsp_sandbox_needed) {
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
@@ -401,6 +590,9 @@ static int adsp_start(struct rproc *rproc)
 	qcom_rproc_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 disable_xo_clk:
 	clk_disable_unprepare(adsp->xo);
+adsp_smmu_unmap:
+	if (adsp->adsp_sandbox_needed)
+		adsp_unmap_smmu(rproc);
 disable_irqs:
 	qcom_q6v5_unprepare(&adsp->q6v5);
 
@@ -429,6 +621,9 @@ static int adsp_stop(struct rproc *rproc)
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
+	if (adsp->adsp_sandbox_needed)
+		adsp_unmap_smmu(rproc);
+
 	handover = qcom_q6v5_unprepare(&adsp->q6v5);
 	if (handover)
 		qcom_adsp_pil_handover(&adsp->q6v5);
@@ -460,6 +655,7 @@ static const struct rproc_ops adsp_ops = {
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.load = adsp_load,
 	.panic = adsp_panic,
 };
-- 
2.7.4

