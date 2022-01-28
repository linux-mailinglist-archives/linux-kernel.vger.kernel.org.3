Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67A49F49E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiA1Hro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:47:44 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38425 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346983AbiA1Hrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356062; x=1674892062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jgK4xynC59GISi910hm1lHj1RaNAMv7xK8Hd4WWychM=;
  b=l/qHkzNESTTNCz/AobzivFEkJG4MixbZW29GcDDUpNW0vr2SwPdKkGJS
   XiYybR4nuw6d0xuTyPU1gGx9WHjlCRrJdV649bD/XnZWIUXPFpuqMcbC7
   t5qDo5k5C1CnPaATyWoMVTy+scGrRNSrBVkfTNm9+8omk/4zGRAS07iC+
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Jan 2022 23:47:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:47:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:41 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:36 -0800
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
        Huang Yiwei <hyiwei@codeaurora.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv2 1/9] soc: qcom: llcc: Add support for 16 ways of allocation
Date:   Fri, 28 Jan 2022 13:17:08 +0530
Message-ID: <a7a5f64259c2c02628f03fb59b91e9fa78da2dfb.1643355594.git.quic_saipraka@quicinc.com>
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

From: Huang Yiwei <hyiwei@codeaurora.org>

Add support for 16 ways of allocation for LLCC HW version 2.1.0
and later.

Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index ec52f29c8867..b3a34f117a7c 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -29,8 +29,8 @@
 #define ATTR1_FIXED_SIZE_SHIFT        0x03
 #define ATTR1_PRIORITY_SHIFT          0x04
 #define ATTR1_MAX_CAP_SHIFT           0x10
-#define ATTR0_RES_WAYS_MASK           GENMASK(11, 0)
-#define ATTR0_BONUS_WAYS_MASK         GENMASK(27, 16)
+#define ATTR0_RES_WAYS_MASK           GENMASK(15, 0)
+#define ATTR0_BONUS_WAYS_MASK         GENMASK(31, 16)
 #define ATTR0_BONUS_WAYS_SHIFT        0x10
 #define LLCC_STATUS_READ_DELAY        100
 
-- 
2.33.1

