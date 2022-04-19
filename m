Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AE507064
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbiDSO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349223AbiDSO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A015F5C;
        Tue, 19 Apr 2022 07:25:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q3so15933395plg.3;
        Tue, 19 Apr 2022 07:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFMLwEUVVk76Mzd5qrOtxHvqSQjnERCVtVM5fsPy+p4=;
        b=JlgE6g45z/I2s26ZdFaOdcufmpElVRjbI1XBl8TsGNzGVjXxTdIvRyJp/MwWl5RKfo
         acO95fBYs9uCa0jPcweVZ1PSQq8ZPPzM0sorAOg0/D8k6kc5CayqX0oaUyiUCv1f6jIE
         /38GJIq9B1SvIE/aPwFkMakK6UDCjk/P4xNdT+elCgv/7huZKFnn79+9ArmDbj16pbpJ
         ILLP2MZ7+GHnFPvR4GtzXKl91wjEiD3R4/RI9Z5wo9yMMv0kW+En0w3hAhMszat2cHEV
         iT/jdsBVxiUJMUoMumojgIENgm50qlPaPYgIuLMzE4RcnAJg4k5ri7NgolgH3znCru4C
         j81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFMLwEUVVk76Mzd5qrOtxHvqSQjnERCVtVM5fsPy+p4=;
        b=E8NTTxrIMBkpIrqpb6yl7RS8WgX/6SfVzRi1bJ0f39OIpmktCYhlbMOIo0Y9igtAZ0
         J8bHGbMry3+B/UQxD5RzP4ozej9Pz9iUpz4qpMrxV1UsOOTd5Oj74DIvsnpzOPu+iGyQ
         zDadGOW7NIWv6KdmwcRZJMu9+SKXjBIRnW86ISoZV8F4BS0tSp4sgDa6MLUEw8tMf4K+
         eXYI7ReXbHdeauH43hUZdcjrpZysp8vTKh0LLxHENGqqJqm3yvRihppt41kz0JTEceG3
         gPlhlvGg+Sw5CfhVLuzLX5dsHZ4VdoWVMwtI1RqoX/XHCkWTcOw8/uqwe6Dc6EVx+yX0
         paCA==
X-Gm-Message-State: AOAM5333WZ0M5MTyd+7BnoUHJ9ZVLUxbF5EjRzKq4KLQc815Ptg41l6S
        ZchbuHAeaPw/1O/IpAHVyDc=
X-Google-Smtp-Source: ABdhPJyGTM2xEWviNdpGZmaW+tlLjnlRjuwrual7KPpWRORmwNu0u4c1bnPQfu50aNQaO7VUKJNmYQ==
X-Received: by 2002:a17:90b:38c4:b0:1d2:66cf:568f with SMTP id nn4-20020a17090b38c400b001d266cf568fmr16852165pjb.18.1650378341893;
        Tue, 19 Apr 2022 07:25:41 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:41 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 7/7] iio: adc: sc27xx: add support for PMIC sc2730
Date:   Tue, 19 Apr 2022 22:24:58 +0800
Message-Id: <20220419142458.884933-8-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
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

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 116 +++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 40686ee60c01..a12f7090311d 100644
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
@@ -304,6 +306,80 @@ static int sc2721_adc_get_ratio(int channel, int scale)
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
@@ -360,6 +436,33 @@ static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
 	}
 }
 
+static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		switch (i) {
+		case 5:
+		case 10:
+		case 19:
+		case 30:
+		case 31:
+			data->channel_scale[i] = 3;
+			break;
+		case 7:
+		case 9:
+			data->channel_scale[i] = 2;
+			break;
+		case 13:
+			data->channel_scale[i] = 1;
+			break;
+		default:
+			data->channel_scale[i] = 0;
+			break;
+		}
+	}
+}
+
 static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 {
 	int i;
@@ -721,6 +824,18 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
 	.set_volref = false,
 };
 
+static const struct sc27xx_adc_variant_data sc2730_data = {
+	.module_en = SC2730_MODULE_EN,
+	.clk_en = SC2730_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &big_scale_graph_calib,
+	.sscale_cal = &small_scale_graph_calib,
+	.init_scale = sc2730_adc_scale_init,
+	.get_ratio = sc2730_adc_get_ratio,
+	.set_volref = false,
+};
+
 static const struct sc27xx_adc_variant_data sc2721_data = {
 	.module_en = SC2731_MODULE_EN,
 	.clk_en = SC2721_ARM_CLK_EN,
@@ -832,6 +947,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
-- 
2.25.1

