Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE994864C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiAFNAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiAFNA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF8C061245;
        Thu,  6 Jan 2022 05:00:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so8394575pjf.3;
        Thu, 06 Jan 2022 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WV8kUdx5diPnFnndYWzeSXJ8dhJSZmG7R/fq4UIf8gc=;
        b=AFUc0BWmmdf55ILq0cIwsM3mo68RUS+5YbFd1/YzzKKO1o2zjWTMoV5Ur3h2BNp8AP
         hGXZV6lsx7KHV+aJoFwhtbZH0GqiJBOlaPCqaSVH/O3ydUteCemx9LA/js3DyadIPsJc
         0GfX2Kw4q1eA4MD8zvx6CsoP57yhQAryj4fIQD0v+/+LQzBwW/GLhT93ibagw31moKI6
         ulpFSVfhGU1TnDjCnWanl6lpLMJEvFFPWetmVGiTxhFlf1b+e1ZpN49P+6oLQk0YO6Kf
         GoEIADVkNKuSo9eAa57I84k6KWigmnlZ7FKlxdZqvauA78NkMDTVb13SWoiboOg5zhBU
         GlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV8kUdx5diPnFnndYWzeSXJ8dhJSZmG7R/fq4UIf8gc=;
        b=Hc/cUC/HiZVv/urrd+JbtZw3c0HXNSYm7ps5NL5QgDQIygNoxxB+pUaY1KKRCtHk+K
         uybw/1AB2dwvGuWe+Ixxx4UPPkmrxaETOlazKjO5lWP4pEcYHxiR0PFMY2yk5ZepLswN
         lt42XUK/lwxd25XTHeWdHXMifnzS2Yezkv8yCIK2HgAkSXVlCPDHYbgdun1nhfXPMRUm
         y4EETkoPjlSrT2IGTmkkBYWmi1OJV7FcGyW4J1lOPUW2GpO3p+wSWP4FKnZ7K3BWBI9w
         87UFpgocFWky6R82YCG3pbyGBkgWGQmrJAoSODiocCe45Rd6VDeU5xzrn2QbwQS5QllU
         e6qQ==
X-Gm-Message-State: AOAM531keu7Wi6LFjLTdEAZ4QDsH6sZNhhGDi0OolDuZlNbcIR/ahJ/n
        rwz1X3s2p3MiXdLCG+lvhAU=
X-Google-Smtp-Source: ABdhPJykoC/pNxwVvTolg9KJgEIozs+gplKxENh3ahD+aMeop8S9BGX9sK8boTj19T7DXyQia5Snag==
X-Received: by 2002:a17:902:d510:b0:149:3b5d:2b89 with SMTP id b16-20020a170902d51000b001493b5d2b89mr57641511plg.97.1641474029405;
        Thu, 06 Jan 2022 05:00:29 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:29 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iio: adc: sc27xx: add support for PMIC sc2730
Date:   Thu,  6 Jan 2022 20:59:45 +0800
Message-Id: <20220106125947.139523-6-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

sc2730 is the product of sc27xx series.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 105 +++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 7b5c66660ac9..195f44cf61e1 100644
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
@@ -695,6 +787,18 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
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
@@ -807,6 +911,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
-- 
2.25.1

