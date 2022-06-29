Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739AD5602D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiF2Oab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiF2OaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:30:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF72E680;
        Wed, 29 Jun 2022 07:30:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i25so17248011wrc.13;
        Wed, 29 Jun 2022 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oALC17+xHWdMD5emD1myNyIF9g5exghbqAWAGYP9uCI=;
        b=KewG3lon1dOEk2MIgsdxTHygbprU3VnFu4vSwE/Nt634xd25dfN/GxiZK5tg/9fhJJ
         Vx7U93bE8n9kjv/d5srCdR4uSSphBJgW0QDtiNwsKptYhrFKbqeTQojUHiX0Ffpe2Wx4
         jQRRAHlAdVlfSwNMtjp1/ijnBbwXYh21zThad1tpKRYmSAhJDhbKVDzCSXVpy0xGqFt1
         gr3fu4lVt7BI52l9Kcpj0LRhQPtL/vF2OjCwtc1ORI0eIQ+1jA1s+r9U7rBu0xDmYWQe
         exB1cNRZYshIB+lbZZW7VxFouEwdZvzRwOTflCz09QB90YGvxaomGG4ThR+UZlDcNIis
         8ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oALC17+xHWdMD5emD1myNyIF9g5exghbqAWAGYP9uCI=;
        b=qWjo4eS5tBpTMS+zcEM5X6pPrwLCKtpHe9LOf+z8HGNXBTBPwLbADsyg+syxVb+E9t
         MbVYtydNvyhatFC4GAgKxjeV20yrr9l0zeILlVFeuwWYNMDi+SlIcc02V2Q6OSAtbvRS
         kdqYH/KaX0XHOnkUU+OH0i1TEN+5NYKPHgBFtU7hbvxfNkSu1vs2XnZmdJ8lU/wn+12n
         +3eY7hCAAd19Y0J9597B8aJ3qg+liBhFfuRVqhgquqQZ3iqTkKRWNlZrTbDvBkIrz7s1
         ShI9EFdyFuOsnXKtIzCl23WCfC2mqcjABPk7P4OuszWtVauYmftGafLIX6zzyHc5dNoC
         p0jg==
X-Gm-Message-State: AJIora9ceqCd/nF2uwMQX+Edg55CzjcyJTb+LoB8zbm2wvQdAeooUrWr
        ZjJeVyUavomYcsn7rivISmY=
X-Google-Smtp-Source: AGRyM1tkB+038HWCl9sBAm4/x6I6mvd6zkiI2b0xTLGy+cqKv5dpE2Mkkh0UKuSpY1BgacxdGaMsPA==
X-Received: by 2002:a5d:5846:0:b0:21b:c444:9913 with SMTP id i6-20020a5d5846000000b0021bc4449913mr3295665wrf.128.1656513002510;
        Wed, 29 Jun 2022 07:30:02 -0700 (PDT)
Received: from localhost (92.40.168.16.threembb.co.uk. [92.40.168.16])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm16845237wrs.64.2022.06.29.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:30:01 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 09/15] iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
Date:   Wed, 29 Jun 2022 15:30:40 +0100
Message-Id: <20220629143046.213584-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
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

