Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9249F4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbiA1Hr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:47:58 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38425 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347088AbiA1Hrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356072; x=1674892072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ukAjX+U+yEKGbdEmSTIgsKlk+qK8idu6+eH8hiVrwY=;
  b=sT1ZgD+jzddIktgc65ZLVTQ3t7+83lliK+Uat30PHS25of5+f1UNfKu8
   DRsPoS0m3GNabqhM8ffSzuxEVp7ImaVo6ZV969TTfxCRcadiaZae3W5Rb
   Q5j+WzENLg1ERaNGIlaHtJXgEs7jtAfzpF8ijztHAhs63teD6gLfhQXXy
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 23:47:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:47:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:51 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:47 -0800
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
Subject: [PATCHv2 3/9] soc: qcom: llcc: Add write-cache cacheable support
Date:   Fri, 28 Jan 2022 13:17:10 +0530
Message-ID: <83372c8178f579d055ec58212ce5af5d55abadd4.1643355594.git.quic_saipraka@quicinc.com>
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

Newer SoCs with LLCC IP version 2.1.0.0 and later support write
sub-cache cacheable feature. Use a separate llcc_slice_config member
"write_scid_cacheable_en" to identify this feature and program
LLCC_TRP_SCID_WRSC_CACHEABLE_EN register to enable it.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 8d4953800fa9..e845d3919ef3 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -51,10 +51,12 @@
 #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
 #define LLCC_TRP_PCB_ACT              0x21f04
 #define LLCC_TRP_WRSC_EN              0x21f20
+#define LLCC_TRP_WRSC_CACHEABLE_EN    0x21f2c
 
 #define BANK_OFFSET_STRIDE	      0x80000
 
 #define LLCC_VERSION_2_0_0_0          0x02000000
+#define LLCC_VERSION_2_1_0_0          0x02010000
 
 /**
  * struct llcc_slice_config - Data associated with the llcc slice
@@ -80,6 +82,8 @@
  *               collapse.
  * @activate_on_init: Activate the slice immediately after it is programmed
  * @write_scid_en: Bit enables write cache support for a given scid.
+ * @write_scid_cacheable_en: Enables write cache cacheable support for a
+ *			     given scid (not supported on v2 or older hardware).
  */
 struct llcc_slice_config {
 	u32 usecase_id;
@@ -95,6 +99,7 @@ struct llcc_slice_config {
 	bool retain_on_pc;
 	bool activate_on_init;
 	bool write_scid_en;
+	bool write_scid_cacheable_en;
 };
 
 struct qcom_llcc_config {
@@ -515,6 +520,16 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 			return ret;
 	}
 
+	if (drv_data->version >= LLCC_VERSION_2_1_0_0) {
+		u32 wr_cache_en;
+
+		wr_cache_en = config->write_scid_cacheable_en << config->slice_id;
+		ret = regmap_update_bits(drv_data->bcast_regmap, LLCC_TRP_WRSC_CACHEABLE_EN,
+					 BIT(config->slice_id), wr_cache_en);
+		if (ret)
+			return ret;
+	}
+
 	if (config->activate_on_init) {
 		desc.slice_id = config->slice_id;
 		ret = llcc_slice_activate(&desc);
-- 
2.33.1

