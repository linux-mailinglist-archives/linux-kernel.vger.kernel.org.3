Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA89B56852E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiGFKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiGFKS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:18:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DEB26104;
        Wed,  6 Jul 2022 03:18:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk26so6292862wrb.11;
        Wed, 06 Jul 2022 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZitLhDQD9kDVmoJ2dINCS+lJD/dI3bVyhkfcBoE0Dtw=;
        b=iFKl31u8Ih5ByIfMqj8MoNPmII1cJU+gs5jbz2CNRxcLZQHqMVZVD+4mNquTGCwWNj
         S88uxrhpyta0x3t/FRlFenlY5y1Nb2cjG5gPzIaBtk3eKVLBy3ObTZ4VIXBUORwFSXzT
         3NCPEsdCmqzJU7H7AedpFM+qqJ1c/fkBK9C51acQtZx+NjsOI0sf9VxC3wui8y+p5FLY
         ah1Ht4yUIOhijU11fhN/4iqh2MU+7JKb9fDTTmv5RYB+S2k3TVrGhQ4yjp6IQ4levvXF
         kIiQjCnsL3unRAE0UTnqdF/0hK9gA0u5VYlbwbU1yjdsstdFaH0YKiyQzRn6AgB2+vbg
         Gp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZitLhDQD9kDVmoJ2dINCS+lJD/dI3bVyhkfcBoE0Dtw=;
        b=7T3WIg+J6/qf7Ll9esCTz8z0naPJsCRbbcMQ/EcSVN6wCEEBA+3bqcSoy43G0rvi9Y
         pIkuwqQiuca9Znb4GNZmDGc84yFsW5flBYwsEMjJbVpwcXnVoImj02zjJe2f/dlpFe+m
         uXg5qZcEQwabUs5v+cRXBXYW9mrfnCY10DR1N52Uk8CCUoDUzHtdW6uxuGHnr1UdGuRY
         9ESmUH3SoEUarkqr35QPn8IcUM4QmHll04T0d8xXnL7oidJpuBdwN8BYRQGIn2LH0m/m
         TlynTiGBExGaySicCGyW8Jb3OaGSJO1in8zrnX8ltcK7rb+5WtltvNwKWT2DVRgiEcwo
         5fZw==
X-Gm-Message-State: AJIora8ajc5MtzssEQrnpz1L2USXI67KcojV3O4pwNWpftHO8BvesaeT
        Xl579Rj8q/qxAufgR/3jRMXlOtDHY4M=
X-Google-Smtp-Source: AGRyM1stL2li5g5NYxRtorxrddQCmRZeYGFwGySg0OLhpb1kq2Szw4Ckjl/t46tWF0GwI98l33V1pA==
X-Received: by 2002:a5d:5887:0:b0:21b:c5d0:fd4b with SMTP id n7-20020a5d5887000000b0021bc5d0fd4bmr38454247wrf.244.1657102723222;
        Wed, 06 Jul 2022 03:18:43 -0700 (PDT)
Received: from localhost (92.40.202.167.threembb.co.uk. [92.40.202.167])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b003a03e63e428sm27948801wms.36.2022.07.06.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:18:42 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 08/13] iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
Date:   Wed,  6 Jul 2022 11:18:57 +0100
Message-Id: <20220706101902.4984-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
References: <20220706101902.4984-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adc_en2 flag is essentially specific to axp20x-compatible devices
because it hardcodes register values. Replace it with a mask field
so the register value can be specified in device match data.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index ab25e6e1ff65..75bda94dbce1 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -623,9 +623,9 @@ struct axp_data {
 	int				num_channels;
 	struct iio_chan_spec const	*channels;
 	unsigned long			adc_en1_mask;
+	unsigned long			adc_en2_mask;
 	int				(*adc_rate)(struct axp20x_adc_iio *info,
 						    int rate);
-	bool				adc_en2;
 	struct iio_map			*maps;
 };
 
@@ -634,8 +634,8 @@ static const struct axp_data axp20x_data = {
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
 	.channels = axp20x_adc_channels,
 	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
+	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
 	.adc_rate = axp20x_adc_rate,
-	.adc_en2 = true,
 	.maps = axp20x_maps,
 };
 
@@ -645,7 +645,6 @@ static const struct axp_data axp22x_data = {
 	.channels = axp22x_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp22x_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 };
 
@@ -655,7 +654,6 @@ static const struct axp_data axp813_data = {
 	.channels = axp813_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp813_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 };
 
@@ -713,10 +711,10 @@ static int axp20x_probe(struct platform_device *pdev)
 	/* Enable the ADCs on IP */
 	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
 
-	if (info->data->adc_en2)
-		/* Enable GPIO0/1 and internal temperature ADCs */
+	if (info->data->adc_en2_mask)
 		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
-				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
+				   info->data->adc_en2_mask,
+				   info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
 	info->data->adc_rate(info, 100);
@@ -741,7 +739,7 @@ static int axp20x_probe(struct platform_device *pdev)
 fail_map:
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return ret;
@@ -757,7 +755,7 @@ static int axp20x_remove(struct platform_device *pdev)
 
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return 0;
-- 
2.35.1

