Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA29B4F7988
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242925AbiDGIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiDGIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2B55772;
        Thu,  7 Apr 2022 01:22:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o10so4226683ple.7;
        Thu, 07 Apr 2022 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/3J9eERIcv96k30MwK0dYPeb6aHTb2oHA9wBoymuaA=;
        b=FMa255Zgqka3jPEGPiX+lWzOAr/BZtmVuMYajEE/m1jfllqEfH32kl2P6oxRHQgWMH
         JjTlBVgo7J/D3jPs4D4U7Pe2PB+RozHl3OoE66sCfQ4LN0L6AwKdOFmShIYDMqWCVqkL
         R5NEfkgVWTJTC/hhNHPXMEYnnkgaudCOw+3pGLkJiOPuwCJbbT+i62BNLloZPnor7C35
         Gb/BQN1lcqT2X5DyAuflENXpaNDAGUVBvAGIqZawYNBOVHHBkXEwrp3UXf79wHlSTJP9
         sBLA74DCO2xG/NVBshiLyI3UZY3IaXqU6Vn28xAc5OTeHCHDe1QOEC7ZHqU12b4ncfq/
         QC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/3J9eERIcv96k30MwK0dYPeb6aHTb2oHA9wBoymuaA=;
        b=hpxXEB2KYP1imHqr8dZ5GEHBkldp/rY79B9GCwkcbObdMY51n9bapos2Bns+mexL/x
         5eJ2LFMu/gD57PoNCnXBWTPTlBi3302F4NHq0FgBf423uCdyVfTlxyLNtJGwqpyXOY70
         0srSpJHYepmvqa2ML2oSwzbtxycs3MHsiB6ygnYukEEe1km8y/DD0fvIsEdj40o+fmSW
         7+VOA2HEwTX869fWIsg26dnByIp9IvambpxWoRJyDlYiF+7ylQT61sIPP/qf47HHAc1H
         rRd38fqooQXBvFSNjLc152VxwYrql4d/9fs3sn3HGNJ0lm6AD3z1OxxGm3YrFXfCVVId
         ptJA==
X-Gm-Message-State: AOAM531Q/aEgrIzs/L/3xihVWKRx0KE4VyQ32mTn8k8MO4ekgO8ohCAW
        ZywwzyBJZv6yO4dofLjM/ETWYFoZ87w5vBm2
X-Google-Smtp-Source: ABdhPJxZUdmEWDtXGLij0lmO2qNP7DercsPmvwlHhaxRkpZusoDD60GC2BBVlU/7LLUX9e4HtFpAqg==
X-Received: by 2002:a17:90a:488c:b0:1c7:b62e:8e8c with SMTP id b12-20020a17090a488c00b001c7b62e8e8cmr14550531pjh.157.1649319750679;
        Thu, 07 Apr 2022 01:22:30 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:30 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/7] iio: adc: sc27xx: add support for PMIC sc2730
Date:   Thu,  7 Apr 2022 16:21:47 +0800
Message-Id: <20220407082148.571442-7-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407082148.571442-1-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
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
 drivers/iio/adc/sc27xx_adc.c | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index eb9e789dd8ee..43655a818d09 100644
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
@@ -307,6 +309,80 @@ static int sc2721_adc_get_ratio(int channel, int scale)
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
@@ -363,6 +439,22 @@ static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
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
@@ -720,6 +812,18 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
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
@@ -834,6 +938,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
-- 
2.25.1

