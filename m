Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8652CF75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiESJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiESJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:31:32 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526545C858;
        Thu, 19 May 2022 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652952691; x=1684488691;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ffzJdDsrpiOXwHfaBnfKeYfCI/DEp+tB96pIcEPg41s=;
  b=FxOHe/DqDJcqI4B7CDKTA7iZ21quTEteaV5OI0yZQ+iiycY6TLV24rNC
   4TJG4Om6asnVu/E1Hgwvj+5aN/WqZ0gzThNEoOHsqrx5q7M7MFq+L9APJ
   cPVvRfm/tR56eDCyoazgUX6BrfeWmKEQ5K+K5dvnUAfDZTxLWToa3LMoh
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 02:31:30 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 02:31:30 -0700
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 02:31:27 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <vboma@qti.qualcomm.com>, <quic_vgarodia@quicinc.com>
Subject: [PATCH] media: venus: hfi_platform: Correct supported codecs for sc7280
Date:   Thu, 19 May 2022 15:01:18 +0530
Message-ID: <1652952678-14747-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP8 codec is deprecated for sc7280 SOC. Fix in platform layer to
update the supported codecs accordingly.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_parser.c   |  6 ++++--
 drivers/media/platform/qcom/venus/hfi_platform.c | 21 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_platform.h |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 5b8389b..6cf74b2 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -234,6 +234,7 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
 	const struct hfi_plat_caps *caps = NULL;
 	u32 enc_codecs, dec_codecs, count = 0;
 	unsigned int entries;
+	int ret;
 
 	plat = hfi_platform_get(core->res->hfi_version);
 	if (!plat)
@@ -242,8 +243,9 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
 	if (inst)
 		return 0;
 
-	if (plat->codecs)
-		plat->codecs(&enc_codecs, &dec_codecs, &count);
+	ret = hfi_platform_get_codecs(core, &enc_codecs, &dec_codecs, &count);
+	if (ret)
+		return ret;
 
 	if (plat->capabilities)
 		caps = plat->capabilities(&entries);
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
index f16f896..bc9b431 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2020, The Linux Foundation. All rights reserved.
  */
+#include <linux/of_device.h>
 #include "hfi_platform.h"
+#include "core.h"
 
 const struct hfi_platform *hfi_platform_get(enum hfi_version version)
 {
@@ -66,3 +68,22 @@ hfi_platform_get_codec_lp_freq(enum hfi_version version, u32 codec, u32 session_
 	return freq;
 }
 
+int
+hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codecs, u32 *count)
+{
+	const struct hfi_platform *plat;
+
+	plat = hfi_platform_get(core->res->hfi_version);
+	if (!plat)
+		return -EINVAL;
+
+	plat->codecs(enc_codecs, dec_codecs, count);
+
+	if (of_device_is_compatible(core->dev->of_node, "qcom,sc7280-venus")) {
+		*enc_codecs &= ~HFI_VIDEO_CODEC_VP8;
+		*dec_codecs &= ~HFI_VIDEO_CODEC_VP8;
+	}
+
+	return 0;
+}
+
diff --git a/drivers/media/platform/qcom/venus/hfi_platform.h b/drivers/media/platform/qcom/venus/hfi_platform.h
index 1dcf408..ec89a90 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform.h
+++ b/drivers/media/platform/qcom/venus/hfi_platform.h
@@ -66,4 +66,6 @@ unsigned long hfi_platform_get_codec_vsp_freq(enum hfi_version version, u32 code
 					      u32 session_type);
 unsigned long hfi_platform_get_codec_lp_freq(enum hfi_version version, u32 codec,
 					     u32 session_type);
+int hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codecs,
+			    u32 *count);
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

