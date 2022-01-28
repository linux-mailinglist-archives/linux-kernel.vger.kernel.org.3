Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FCA49F420
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbiA1HKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:10:40 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:56883 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346682AbiA1HKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643353836; x=1674889836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nH7mhXj4VLeYF0dn/C3UXq2qJvDT8PMUgUmdJY2rDBc=;
  b=OLZTgOMTbmJw5VAgK8hdA/5IqwNKJr1oMh6tQEU2Qh+ogCJbtCkUKWxu
   faZDQa9/b5ori++Rslvec1N1dOkIpNPswhwsUVv39qbRFOhR0hWrg9eO1
   mdW07upMmHOSLPGFqpb4Auy9KLAbgxEsVkgJ8uhGDRu2xzhWq0JL1utS6
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:10:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:10:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:35 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:31 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH 5/9] soc: qcom: llcc: Update register offsets for newer LLCC HW
Date:   Fri, 28 Jan 2022 12:39:29 +0530
Message-ID: <af3dc1ff65dac8e261af1816d4a3fda37858719f.1643353154.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643353154.git.quic_saipraka@quicinc.com>
References: <cover.1643353154.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer LLCC HW have different register offsets for several registers,
currently of which LLCC hardware info and status are used to identify
the LLCC version information and other data. So use separate table to
keep track of these register offsets which vary by different LLCC HW
versions and eases any future addition in variations of register offsets
for newer hardware.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index d14d20d824b2..2306536fbc76 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -36,9 +36,6 @@
 
 #define CACHE_LINE_SIZE_SHIFT         6
 
-#define LLCC_COMMON_HW_INFO           0x00030000
-
-#define LLCC_COMMON_STATUS0           0x0003000c
 #define LLCC_LB_CNT_MASK              GENMASK(31, 28)
 #define LLCC_LB_CNT_SHIFT             28
 
@@ -106,6 +103,12 @@ struct qcom_llcc_config {
 	const struct llcc_slice_config *sct_data;
 	int size;
 	bool need_llcc_cfg;
+	const u32 *reg_offset;
+};
+
+enum llcc_reg_offset {
+	LLCC_COMMON_HW_INFO,
+	LLCC_COMMON_STATUS0,
 };
 
 static const struct llcc_slice_config sc7180_data[] =  {
@@ -223,46 +226,63 @@ static const struct llcc_slice_config sm8350_data[] =  {
 	{ LLCC_CPUHWT,   5, 512,   1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 1 },
 };
 
+static const u32 llcc_v1_2_reg_offset[] = {
+	[LLCC_COMMON_HW_INFO]	= 0x00030000,
+	[LLCC_COMMON_STATUS0]	= 0x0003000c,
+};
+
+static const u32 llcc_v21_reg_offset[] = {
+	[LLCC_COMMON_HW_INFO]	= 0x00034000,
+	[LLCC_COMMON_STATUS0]	= 0x0003400c,
+};
+
 static const struct qcom_llcc_config sc7180_cfg = {
 	.sct_data	= sc7180_data,
 	.size		= ARRAY_SIZE(sc7180_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sc7280_cfg = {
 	.sct_data	= sc7280_data,
 	.size		= ARRAY_SIZE(sc7280_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sdm845_cfg = {
 	.sct_data	= sdm845_data,
 	.size		= ARRAY_SIZE(sdm845_data),
 	.need_llcc_cfg	= false,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sm6350_cfg = {
 	.sct_data	= sm6350_data,
 	.size		= ARRAY_SIZE(sm6350_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8150_cfg = {
 	.sct_data       = sm8150_data,
 	.size           = ARRAY_SIZE(sm8150_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8250_cfg = {
 	.sct_data       = sm8250_data,
 	.size           = ARRAY_SIZE(sm8250_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static const struct qcom_llcc_config sm8350_cfg = {
 	.sct_data       = sm8350_data,
 	.size           = ARRAY_SIZE(sm8350_data),
 	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
@@ -618,13 +638,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	cfg = of_device_get_match_data(&pdev->dev);
+
 	/* Extract version of the IP */
-	ret = regmap_read(drv_data->bcast_regmap, LLCC_COMMON_HW_INFO, &version);
+	ret = regmap_read(drv_data->bcast_regmap, cfg->reg_offset[LLCC_COMMON_HW_INFO],
+			  &version);
 	if (ret)
 		goto err;
 
-	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
-						&num_banks);
+	ret = regmap_read(drv_data->regmap, cfg->reg_offset[LLCC_COMMON_STATUS0],
+			  &num_banks);
 	if (ret)
 		goto err;
 
@@ -632,7 +655,6 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	num_banks >>= LLCC_LB_CNT_SHIFT;
 	drv_data->num_banks = num_banks;
 
-	cfg = of_device_get_match_data(&pdev->dev);
 	llcc_cfg = cfg->sct_data;
 	sz = cfg->size;
 
-- 
2.33.1

