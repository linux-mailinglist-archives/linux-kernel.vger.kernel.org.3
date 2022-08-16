Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF14C5960C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiHPRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiHPRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:01:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE86E80B6F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:01:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k17so5525689wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Z+IK169aH4eo4oE/yazCWb+E6gZJBwkTwFMy3pmkBbE=;
        b=tXxE5CxvL4XRHBZMKl7I+t8bJ7mpL80Q2V5+u/Fa+hQNVuyLnua1wsTEDEo+vM4eeK
         nt/zsqLCbtCJqj2b8TKM2CDb65ypsE+mgncG4u2oHraVyhxRcKJFm1bq9siYsPNDw5Gr
         0IFnztVyOlaKjI+ToN21O0UsUuP7/kXqcEGh3MvNNpH12YedG8CBSrC5UhQIB1uKYYOP
         tPj/C6cfzrECAs6IQJP06nYn3SNIcSemivgIoQcZhVNd/g7McInd0wOulO9d9nUtEsYx
         J92V3hWaiXQYvRvCtD8C8wh4DD+Sbc6xfjku9HLu6aY8Q/3MlPL9XudQA2mKdeRtmVGB
         fZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Z+IK169aH4eo4oE/yazCWb+E6gZJBwkTwFMy3pmkBbE=;
        b=U/HWzU1xyLgrq7VXDj1CnSvegPcWBhSzgrgqHh2W+lWh7a75F9IoaBoVi+WedD+e+g
         7uy0lb+B2BcQflD43KV6xuY77eYxEGGL/Q35MJTdehLb+bDqhQfsypb7Ua6wGUywWmUi
         vkweRuUema8zxR+OgjPqIavSAbFMDvk4Sg76vu+zZXBM+WH/+0onhhsabDCR9QuctVf9
         RMl4ZmmFM/Hvr0s90AzLH2qmOGERSNaIglGlWuy/dKI29jWDeCeAj2ogoRqFQcrVrp5p
         GWANj1nacZt+XfVcQ7xi77F7N54g1sroz3dkCKZyJDmi4iG/huio95TCbESYLx4JGse6
         kAFA==
X-Gm-Message-State: ACgBeo2Neifv8JaX9x5lLYnrrfiwQxrikCqsrcaspHgNb/b/TvbnCbC2
        u7Js/aRG+S0h1nRwROjp0IO2BQ==
X-Google-Smtp-Source: AA6agR6a0b//5vAESrxZNaPs/j34eNRQa88EX/3HRkt3V06pu7BoM2GP1N9k6uWC5zMoEI4Ka1jYwg==
X-Received: by 2002:a05:600c:3d91:b0:3a5:4132:b6a0 with SMTP id bi17-20020a05600c3d9100b003a54132b6a0mr13237626wmb.126.1660669303392;
        Tue, 16 Aug 2022 10:01:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021d6dad334bsm10659535wrt.4.2022.08.16.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:01:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: qdsp6: q6prm: add new clocks
Date:   Tue, 16 Aug 2022 18:01:18 +0100
Message-Id: <20220816170118.13470-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to new clocks that are added in Q6DSP as part of newer version
of LPASS support on SM8450 and SC8280XP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../sound/qcom,q6dsp-lpass-ports.h            | 18 ++++++++++++++++++
 sound/soc/qcom/qdsp6/q6prm-clocks.c           |  9 +++++++++
 sound/soc/qcom/qdsp6/q6prm.h                  | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 0d3276c8fc11..9f7c5103bc82 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -193,6 +193,24 @@
 #define LPASS_CLK_ID_RX_CORE_MCLK	59
 #define LPASS_CLK_ID_RX_CORE_NPL_MCLK	60
 #define LPASS_CLK_ID_VA_CORE_2X_MCLK	61
+/* Clock ID for MCLK for WSA2 core */
+#define LPASS_CLK_ID_WSA2_CORE_MCLK	62
+/* Clock ID for NPL MCLK for WSA2 core */
+#define LPASS_CLK_ID_WSA2_CORE_2X_MCLK	63
+/* Clock ID for RX Core TX MCLK */
+#define LPASS_CLK_ID_RX_CORE_TX_MCLK	64
+/* Clock ID for RX CORE TX 2X MCLK */
+#define LPASS_CLK_ID_RX_CORE_TX_2X_MCLK	65
+/* Clock ID for WSA core TX MCLK */
+#define LPASS_CLK_ID_WSA_CORE_TX_MCLK	66
+/* Clock ID for WSA core TX 2X MCLK */
+#define LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK	67
+/* Clock ID for WSA2 core TX MCLK */
+#define LPASS_CLK_ID_WSA2_CORE_TX_MCLK	68
+/* Clock ID for WSA2 core TX 2X MCLK */
+#define LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK	69
+/* Clock ID for RX CORE MCLK2 2X  MCLK */
+#define LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK	70
 
 #define LPASS_HW_AVTIMER_VOTE		101
 #define LPASS_HW_MACRO_VOTE		102
diff --git a/sound/soc/qcom/qdsp6/q6prm-clocks.c b/sound/soc/qcom/qdsp6/q6prm-clocks.c
index a26cda5140c1..73b0cbac73d4 100644
--- a/sound/soc/qcom/qdsp6/q6prm-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6prm-clocks.c
@@ -50,6 +50,15 @@ static const struct q6dsp_clk_init q6prm_clks[] = {
 	Q6PRM_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
 	Q6PRM_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
 	Q6PRM_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA2_CORE_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA2_CORE_2X_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_RX_CORE_TX_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_RX_CORE_TX_2X_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA_CORE_TX_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA2_CORE_TX_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK),
+	Q6PRM_CLK(LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK),
 	Q6DSP_VOTE_CLK(LPASS_HW_MACRO_VOTE, Q6PRM_HW_CORE_ID_LPASS,
 		       "LPASS_HW_MACRO"),
 	Q6DSP_VOTE_CLK(LPASS_HW_DCODEC_VOTE, Q6PRM_HW_CORE_ID_DCODEC,
diff --git a/sound/soc/qcom/qdsp6/q6prm.h b/sound/soc/qcom/qdsp6/q6prm.h
index fea4d1954bc1..a988a32086fe 100644
--- a/sound/soc/qcom/qdsp6/q6prm.h
+++ b/sound/soc/qcom/qdsp6/q6prm.h
@@ -64,6 +64,25 @@
 #define Q6PRM_LPASS_CLK_ID_RX_CORE_MCLK				0x30e
 #define Q6PRM_LPASS_CLK_ID_RX_CORE_NPL_MCLK			0x30f
 
+/* Clock ID for MCLK for WSA2 core */
+#define Q6PRM_LPASS_CLK_ID_WSA2_CORE_MCLK 0x310
+/* Clock ID for NPL MCLK for WSA2 core */
+#define Q6PRM_LPASS_CLK_ID_WSA2_CORE_2X_MCLK 0x311
+/* Clock ID for RX Core TX MCLK */
+#define Q6PRM_LPASS_CLK_ID_RX_CORE_TX_MCLK 0x312
+/* Clock ID for RX CORE TX 2X MCLK */
+#define Q6PRM_LPASS_CLK_ID_RX_CORE_TX_2X_MCLK 0x313
+/* Clock ID for WSA core TX MCLK */
+#define Q6PRM_LPASS_CLK_ID_WSA_CORE_TX_MCLK 0x314
+/* Clock ID for WSA core TX 2X MCLK */
+#define Q6PRM_LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK 0x315
+/* Clock ID for WSA2 core TX MCLK */
+#define Q6PRM_LPASS_CLK_ID_WSA2_CORE_TX_MCLK 0x316
+/* Clock ID for WSA2 core TX 2X MCLK */
+#define Q6PRM_LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK 0x317
+/* Clock ID for RX CORE MCLK2 2X  MCLK */
+#define Q6PRM_LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK 0x318
+
 #define Q6PRM_LPASS_CLK_SRC_INTERNAL	1
 #define Q6PRM_LPASS_CLK_ROOT_DEFAULT	0
 #define Q6PRM_HW_CORE_ID_LPASS		1
-- 
2.21.0

