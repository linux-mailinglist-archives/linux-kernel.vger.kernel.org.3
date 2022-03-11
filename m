Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1C4D66B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbiCKQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350563AbiCKQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:48:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82811D3064;
        Fri, 11 Mar 2022 08:47:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso11577789pjb.1;
        Fri, 11 Mar 2022 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQSz1eMw8TQ9rQfCaHjzrl9QXxNcm9tRAV14mBAQhK4=;
        b=FIdbCdcn3irCmXMp/JkjPGj4Yb+mS4vgWxYtze9R/vOlwUwCM3Z52m7vPncuxA2R10
         irBaykx6W83UbQZBeShL/Ms4VTWRr0TATBfft7Yc5vTDBfBxPMva1TFLh2Es6f3gufV6
         k3/pD1ABFXDYOCQy1BnvUOhYi1C4S3/HtDwc4CRiDO1a4wiI24mLf9HwHQyjsFHzoBCE
         5MKeMcCZD0cJ0dgMolufl+HC3lxwl6toKL5N0HpepLAtK/bYq2zjd1hWOfA2eczUL79T
         VtUBcT4ebo2PulUhNEfNVvJ6r3i/UNl3XeMw4SN8GmyaLnsgGlaG7ZtS6OlqdifNPTJN
         xNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQSz1eMw8TQ9rQfCaHjzrl9QXxNcm9tRAV14mBAQhK4=;
        b=0txi/1sOxlC0V1OrRKYScDF7nHCA4qao2tmzttExbks0nTEHW0w505a8Ku2DqysdB8
         6U9opC/VTHt4SFjeCqGwx0/P7b/x6qieq8+xvPIiWXodUz+sHqFI8ZSh5Vjm4su4qgsf
         q1FKdB9vwe4pSKUPXHRZo531coro3w/3QT9p9PnVnapyj6RJM7Kz2erJTxJ3CnEysZaj
         83y8wfgmZsmrUVtOoGWWHvEGDkxufDxc9oz4gIBYLl/R4x0af7OgXQw9OE/4bEV+lQ5l
         vRZQ5xH/GJycoMuFRhRfWrOI6+Z4vOhzqY0WO+m55c7ghSwiB7bis8DBusOfvT12GJpf
         Iq9Q==
X-Gm-Message-State: AOAM5303zrSpwMAiX7VlzuNcEnoWhDFtkkEiE7w3XqyJm9rJQJKrtzfZ
        NHs2emyoRtvcdD2hA+0dKsU=
X-Google-Smtp-Source: ABdhPJzH2al+WOxtzl9QJWHLyLiteESq8j6wHU5c+VLwW1i9Y69jsSAJEAcNVaVZdEu/Y8RHcu52gQ==
X-Received: by 2002:a17:903:244b:b0:151:d869:3b1f with SMTP id l11-20020a170903244b00b00151d8693b1fmr11453798pls.155.1647017234357;
        Fri, 11 Mar 2022 08:47:14 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:47:13 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/7] iio: adc: sc27xx: add support for PMIC sc2730
Date:   Sat, 12 Mar 2022 00:46:26 +0800
Message-Id: <20220311164628.378849-6-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311164628.378849-1-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

sc2730 is the product of sc27xx series.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 108 ++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 2603ce313b07..b89637c051ac 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -13,9 +13,11 @@
 #include <linux/slab.h>
 
 /* PMIC global registers definition */
+#define SC2730_MODULE_EN		0x1808
 #define SC2731_MODULE_EN		0xc08
 #define SC27XX_MODULE_ADC_EN		BIT(5)
 #define SC2721_ARM_CLK_EN		0xc0c
+#define SC2730_ARM_CLK_EN		0x180c
 #define SC2731_ARM_CLK_EN		0xc10
 #define SC27XX_CLK_ADC_EN		BIT(5)
 #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
@@ -293,6 +295,80 @@ static int sc2721_adc_get_ratio(int channel, int scale)
 	return SC27XX_VOLT_RATIO(1, 1);
 }
 
+static int sc2730_adc_get_ratio(int channel, int scale)
+{
+	switch (channel) {
+	case 14:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(68, 900);
+		case 1:
+			return SC27XX_VOLT_RATIO(68, 1760);
+		case 2:
+			return SC27XX_VOLT_RATIO(68, 2327);
+		case 3:
+			return SC27XX_VOLT_RATIO(68, 3654);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 15:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(1, 3);
+		case 1:
+			return SC27XX_VOLT_RATIO(1000, 5865);
+		case 2:
+			return SC27XX_VOLT_RATIO(500, 3879);
+		case 3:
+			return SC27XX_VOLT_RATIO(500, 6090);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 16:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(48, 100);
+		case 1:
+			return SC27XX_VOLT_RATIO(480, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(480, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(48, 406);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 21:
+	case 22:
+	case 23:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(3, 8);
+		case 1:
+			return SC27XX_VOLT_RATIO(375, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(375, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(300, 3248);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	default:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(1, 1);
+		case 1:
+			return SC27XX_VOLT_RATIO(1000, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(1000, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(1000, 4060);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	}
+	return SC27XX_VOLT_RATIO(1, 1);
+}
+
 static int sc2731_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -349,6 +425,22 @@ static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
 	}
 }
 
+static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		if (i == 5 || i == 10 || i == 19 || i == 30 || i == 31)
+			data->channel_scale[i] = 3;
+		else if (i == 7 || i == 9)
+			data->channel_scale[i] = 2;
+		else if (i == 13)
+			data->channel_scale[i] = 1;
+		else
+			data->channel_scale[i] = 0;
+	}
+}
+
 static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 {
 	int i;
@@ -449,7 +541,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 						    SC27XX_ADC_REFVOL_VDD28,
 						    SC27XX_ADC_REFVOL_VDD28);
 			if (ret_volref) {
-				dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n,ret_volref");
+				dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n",
+					ret_volref);
 				ret = ret || ret_volref;
 			}
 		}
@@ -695,6 +788,18 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
 	.get_ratio = sc2731_adc_get_ratio,
 };
 
+static const struct sc27xx_adc_variant_data sc2730_data = {
+	.pmic_type = SC27XX_ADC,
+	.module_en = SC2730_MODULE_EN,
+	.clk_en = SC2730_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &big_scale_graph_calib,
+	.sscale_cal = &small_scale_graph_calib,
+	.init_scale = sc2730_adc_scale_init,
+	.get_ratio = sc2730_adc_get_ratio,
+};
+
 static const struct sc27xx_adc_variant_data sc2721_data = {
 	.pmic_type = SC2721_ADC,
 	.module_en = SC2731_MODULE_EN,
@@ -809,6 +914,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
-- 
2.25.1

