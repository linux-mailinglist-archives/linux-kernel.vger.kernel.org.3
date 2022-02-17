Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C874B98DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiBQGJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:09:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiBQGJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:09:13 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC4C7E5B;
        Wed, 16 Feb 2022 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645078139; x=1676614139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=55r7vcOOWbj/oXy8k3YYhpmLfRt+lwKbKv2++d6u+g8=;
  b=adOtjPG6eNNsyMa3butJTzWVQh9UZPgmUBekdW0xC7u8qUKz9WqNzDGh
   XmjBwpc4QyV5gnryGvHbWciFAsxPJ4K9IisUu6tjMvERJDaQL2iZTcyBa
   CafnZK1wN83f3hHLPZNj7uP+ghn5/Yd7T+UfzEkSqsnxhtWr+rjvWHuq9
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Feb 2022 22:08:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:08:52 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 22:08:51 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 22:08:46 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v14 02/10] ASoC: qcom: Move lpass_pcm_data structure to lpass header
Date:   Thu, 17 Feb 2022 11:37:38 +0530
Message-ID: <1645078066-9365-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645078066-9365-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645078066-9365-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare lpass_pcm_data structure in lpass header file instead of
platform source file to make common use of it by other drivers

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 5 -----
 sound/soc/qcom/lpass.h          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a59e9d2..a44162c 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -18,11 +18,6 @@
 
 #define DRV_NAME "lpass-platform"
 
-struct lpass_pcm_data {
-	int dma_ch;
-	int i2s_port;
-};
-
 #define LPASS_PLATFORM_BUFFER_SIZE	(24 *  2 * 1024)
 #define LPASS_PLATFORM_PERIODS		2
 
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index c0f0247..f0d21cd 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -257,6 +257,11 @@ struct lpass_variant {
 	int num_clks;
 };
 
+struct lpass_pcm_data {
+	int dma_ch;
+	int i2s_port;
+};
+
 /* register the platform driver from the CPU DAI driver */
 int asoc_qcom_lpass_platform_register(struct platform_device *);
 int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev);
-- 
2.7.4

