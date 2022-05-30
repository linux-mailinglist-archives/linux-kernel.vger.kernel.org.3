Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E455A53881C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiE3UPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiE3UPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:15:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B91481486
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q7so5052454wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tSb7UJsPw6fMK+gU6mTIYkwhoB6cAnQoeEgSTcX6/b8=;
        b=ueLCtT8HrcGEyzdRDJmnkTKVUsCJvfppcoiRujOdqjJ6m+mcEENWGPW1E1dQV8M9Q9
         zA5C8YoLjTwZpAqaCXYpf75KEZLoxBV7kxjlL28SQBbWmWJrG8TnBXzL+Dk7FTuzNpF3
         Kn09zUv7N9xWjsLZQhUMXjxLZ2dGpq87apiiLcA/g7EsoCS/sYD7ajo1O1/1vqdUugqr
         9sO1ZPXTBwxSuv6CarfFQS8tFJ1G1m+0+RwDZdIIF0TRG+Kd8pEjXiqdKdza6zdtn4TG
         A5BXQY0WEPEjOre5d8ebOqo4QUISRsDGzzevA5fR9SXe5ai2Oo9w4RLguoDgyDujQ8cP
         Qhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tSb7UJsPw6fMK+gU6mTIYkwhoB6cAnQoeEgSTcX6/b8=;
        b=nH3+RTWhdPYa0AxQdz6kH/oKKvoYXurVxovJ6U26GpovA+uAUL6EDx6NtfdkV+IQHf
         1H530ZjNiEl0E47aJlx7JDFv/Xvm8LxbGE3qjuWBt323AJi+ekWFlpOBeM1HdvH1Q/mQ
         zdONyyhxc9L11zLhVz93Wzfttszq/XxnxIrXiPJ9+ob+9/dAP3yH8z67qe82oYX3Sdfx
         Rd9I+HMczaJNGWbCMx2nMKYGUClf8Bo1AaniNaASzKB3TxMPfCI+VF9jstndy+CE0VCH
         5gaGLXcOVHJQNNe8u5OVkOWWjvQgYXQhoCtcuR318xWwTLh04xMMkv9jRssmi+vD6CS5
         We6A==
X-Gm-Message-State: AOAM531IKTFSXGJgcLcZF75M7w1RAtY4LTROBd7M4BOWSe3W8Xu64Pdf
        MUtZ4eNCVM6mTGKjJRCkX4Dedg==
X-Google-Smtp-Source: ABdhPJwiSzKSg4qkJcPG/0zZ8t9Q6QeHPF/daPy2MXTaCiYXpMfO/YtIWydybS5kvNowbkqSfI9riA==
X-Received: by 2002:a5d:648e:0:b0:210:18f6:f954 with SMTP id o14-20020a5d648e000000b0021018f6f954mr11230877wri.323.1653941703895;
        Mon, 30 May 2022 13:15:03 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe101000000b0020d110bc39esm9770401wrz.64.2022.05.30.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:15:03 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 4/7] soc: mediatek: mutex: add MT8365 support
Date:   Mon, 30 May 2022 22:14:33 +0200
Message-Id: <20220530201436.902505-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530201436.902505-1-fparent@baylibre.com>
References: <20220530201436.902505-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mutex support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 981d56967e7a..b8d5c4a62542 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -110,6 +110,20 @@
 #define MT8195_MUTEX_MOD_DISP_DP_INTF0		21
 #define MT8195_MUTEX_MOD_DISP_PWM0		27
 
+#define MT8365_MUTEX_MOD_DISP_OVL0		7
+#define MT8365_MUTEX_MOD_DISP_OVL0_2L		8
+#define MT8365_MUTEX_MOD_DISP_RDMA0		9
+#define MT8365_MUTEX_MOD_DISP_RDMA1		10
+#define MT8365_MUTEX_MOD_DISP_WDMA0		11
+#define MT8365_MUTEX_MOD_DISP_COLOR0		12
+#define MT8365_MUTEX_MOD_DISP_CCORR		13
+#define MT8365_MUTEX_MOD_DISP_AAL		14
+#define MT8365_MUTEX_MOD_DISP_GAMMA		15
+#define MT8365_MUTEX_MOD_DISP_DITHER		16
+#define MT8365_MUTEX_MOD_DISP_DSI0		17
+#define MT8365_MUTEX_MOD_DISP_PWM0		20
+#define MT8365_MUTEX_MOD_DISP_DPI0		22
+
 #define MT2712_MUTEX_MOD_DISP_PWM2		10
 #define MT2712_MUTEX_MOD_DISP_OVL0		11
 #define MT2712_MUTEX_MOD_DISP_OVL1		12
@@ -315,6 +329,22 @@ static const unsigned int mt8195_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DP_INTF0] = MT8195_MUTEX_MOD_DISP_DP_INTF0,
 };
 
+static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8365_MUTEX_MOD_DISP_AAL,
+	[DDP_COMPONENT_CCORR] = MT8365_MUTEX_MOD_DISP_CCORR,
+	[DDP_COMPONENT_COLOR0] = MT8365_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_DITHER] = MT8365_MUTEX_MOD_DISP_DITHER,
+	[DDP_COMPONENT_DPI0] = MT8365_MUTEX_MOD_DISP_DPI0,
+	[DDP_COMPONENT_DSI0] = MT8365_MUTEX_MOD_DISP_DSI0,
+	[DDP_COMPONENT_GAMMA] = MT8365_MUTEX_MOD_DISP_GAMMA,
+	[DDP_COMPONENT_OVL0] = MT8365_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL_2L0] = MT8365_MUTEX_MOD_DISP_OVL0_2L,
+	[DDP_COMPONENT_PWM0] = MT8365_MUTEX_MOD_DISP_PWM0,
+	[DDP_COMPONENT_RDMA0] = MT8365_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8365_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_WDMA0] = MT8365_MUTEX_MOD_DISP_WDMA0,
+};
+
 static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
@@ -423,6 +453,14 @@ static const struct mtk_mutex_data mt8195_mutex_driver_data = {
 	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
 };
 
+static const struct mtk_mutex_data mt8365_mutex_driver_data = {
+	.mutex_mod = mt8365_mutex_mod,
+	.mutex_sof = mt8183_mutex_sof,
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.no_clk = true,
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev)
 {
 	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
@@ -665,6 +703,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt8192_mutex_driver_data},
 	{ .compatible = "mediatek,mt8195-disp-mutex",
 	  .data = &mt8195_mutex_driver_data},
+	{ .compatible = "mediatek,mt8365-disp-mutex",
+	  .data = &mt8365_mutex_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
-- 
2.36.1

