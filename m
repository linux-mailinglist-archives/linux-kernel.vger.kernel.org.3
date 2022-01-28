Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B397749F4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbiA1Hr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:47:57 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38425 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347057AbiA1Hrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356067; x=1674892067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMZlFlCb84aD0YjAhO0uLEuPJULrmhQSmpDp/x+j5O0=;
  b=kOnAFl62EDZ2t2nfUBvxa54ulLHbivXrrXXDdVhSDBPTKFHYMhrIEZEb
   yx0sqdpzs8FC8S8CI5vTNqeJd4e94oboigWjIM3HOFJgrADTW3mB3gmg7
   GSw5rl689fdARxvWnzqdjEzEOTswBmf7jwaBmwFDAumqvFcdo6EXzA1K+
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 23:47:47 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:47:47 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:46 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:42 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv2 2/9] soc: qcom: llcc: Update the logic for version info extraction
Date:   Fri, 28 Jan 2022 13:17:09 +0530
Message-ID: <a82d7c32348c51fcc2b63e220d91b318bf706c83.1643355594.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643355594.git.quic_saipraka@quicinc.com>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLCC HW version info is made up of major, branch, minor and echo
version bits each of which are 8bits. Several features in newer
LLCC HW are based on the full version rather than just major or
minor versions such as write-subcache enable which is applicable
for versions v2.0.0.0 and later, also upcoming write-subcache
cacheable for SM8450 SoC which is only present in versions v2.1.0.0
and later, so it makes it easier and cleaner to just directly
compare with the full version than adding additional major/branch/
minor/echo version checks. So remove the earlier major version check
and add full version check for those features.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 9 +++++----
 include/linux/soc/qcom/llcc-qcom.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index b3a34f117a7c..8d4953800fa9 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -37,7 +37,6 @@
 #define CACHE_LINE_SIZE_SHIFT         6
 
 #define LLCC_COMMON_HW_INFO           0x00030000
-#define LLCC_MAJOR_VERSION_MASK       GENMASK(31, 24)
 
 #define LLCC_COMMON_STATUS0           0x0003000c
 #define LLCC_LB_CNT_MASK              GENMASK(31, 28)
@@ -55,6 +54,8 @@
 
 #define BANK_OFFSET_STRIDE	      0x80000
 
+#define LLCC_VERSION_2_0_0_0          0x02000000
+
 /**
  * struct llcc_slice_config - Data associated with the llcc slice
  * @usecase_id: Unique id for the client's use case
@@ -504,7 +505,7 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 			return ret;
 	}
 
-	if (drv_data->major_version == 2) {
+	if (drv_data->version >= LLCC_VERSION_2_0_0_0) {
 		u32 wren;
 
 		wren = config->write_scid_en << config->slice_id;
@@ -598,12 +599,12 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/* Extract major version of the IP */
+	/* Extract version of the IP */
 	ret = regmap_read(drv_data->bcast_regmap, LLCC_COMMON_HW_INFO, &version);
 	if (ret)
 		goto err;
 
-	drv_data->major_version = FIELD_GET(LLCC_MAJOR_VERSION_MASK, version);
+	drv_data->version = version;
 
 	ret = regmap_read(drv_data->regmap, LLCC_COMMON_STATUS0,
 						&num_banks);
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 9e8fd92c96b7..beecf00b707d 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -83,7 +83,7 @@ struct llcc_edac_reg_data {
  * @bitmap: Bit map to track the active slice ids
  * @offsets: Pointer to the bank offsets array
  * @ecc_irq: interrupt for llcc cache error detection and reporting
- * @major_version: Indicates the LLCC major version
+ * @version: Indicates the LLCC version
  */
 struct llcc_drv_data {
 	struct regmap *regmap;
@@ -96,7 +96,7 @@ struct llcc_drv_data {
 	unsigned long *bitmap;
 	u32 *offsets;
 	int ecc_irq;
-	u32 major_version;
+	u32 version;
 };
 
 #if IS_ENABLED(CONFIG_QCOM_LLCC)
-- 
2.33.1

