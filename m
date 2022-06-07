Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25C54031F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbiFGPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344456AbiFGPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:52:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2741DF94;
        Tue,  7 Jun 2022 08:52:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so36074942ejq.6;
        Tue, 07 Jun 2022 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oeaHPVfp1//yBkGHWlR8Z0Ee5I5M6hPjA9XXdElc1Wc=;
        b=kmCBISp0o+y+mjkcEDPvMnQZzSbAm4QO/i9jV5GHattlWyMRletWe7VD47t5xwHu2d
         2uatbaSt1LWuXedtjsDl5TpesRACOC7/ZIEJN5YVn1LgxHhhMWsB9dQ16Xdk6oDbwUeG
         JSaqaQ+27KOM33aw9mzXqlpwxuGFAPJsl+7lxyQ8fDlfpoa8enaJE9KKil7IuQQaN0UY
         OoUNzdXNfDtOKgOSSTMo4qbM/VZGSTkxdffMLtwGio2MSjJupUzQmL6GLmzRAs09GyPz
         lPrTxrSBlmE8z13KkIGz47kL3iWn3xmbBZepbn1nnLsDy+kG0DQBYUGaobzOqdh+1pao
         QlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oeaHPVfp1//yBkGHWlR8Z0Ee5I5M6hPjA9XXdElc1Wc=;
        b=q4a2v0fjqErpxJ4Wr5f8fWUy5v+1cg5v1z8gFuoVwkaUQiO5y21AVFEhIL4yzK68FV
         8EBtYbbEAZPgHurwR5PHfhEYuZFfpPiaprtsHNnpG2997EAQjtFBuq/0hZ/1J35K568f
         ibIzT2BoG/qGzYMn9g8piftL+JuxcWkVeRWECorIS85Cy2A/2qY+dxfhWKTtt8VbVDII
         l0zwab6SYNkYyZZcMHgBKKaSKcesTnd0MvRo4G002C8mMEU1YxAzGLuEEqdq0iwmGI4K
         34nxt6I6JcvS6d8BKa6YvKEdGc+/LBsSvZJmgW5bUvDRXh0qwOEf9mGHpEy1cfqSvdtR
         QCiA==
X-Gm-Message-State: AOAM531fi6k7tXbAN8RLwdYX4yEgT7YSFDj0aOX+Rkku3TO5giRHCtn1
        YhPu6T3W2brdN0gNvt6VldM=
X-Google-Smtp-Source: ABdhPJzGTE0D06nqZj0g2Yo36jUgO2WfZRwFfe91hjbPUyG9ihQr1xSP6B7RKNdcEjk4UHYlEyucGQ==
X-Received: by 2002:a17:906:478c:b0:6f4:e6c6:526f with SMTP id cw12-20020a170906478c00b006f4e6c6526fmr27037261ejc.41.1654617163540;
        Tue, 07 Jun 2022 08:52:43 -0700 (PDT)
Received: from localhost (92.40.203.36.threembb.co.uk. [92.40.203.36])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906601600b006fe8b456672sm7998369ejj.3.2022.06.07.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:52:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 11/17] iio: adc: axp20x_adc: Consolidate ADC raw read functions
Date:   Tue,  7 Jun 2022 16:53:18 +0100
Message-Id: <20220607155324.118102-12-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
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

Add an axp20x_id variant field to the axp_data struct and use it
to consolidate the adc_raw functions, reducing code duplication.
Variant IDs are chosen to match the OF compatible strings.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 83 +++++++++++++++---------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 9d5b1de24908..0260433782d8 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -71,6 +71,18 @@ struct axp20x_adc_iio {
 	const struct axp_data	*data;
 };
 
+struct axp_data {
+	const struct iio_info		*iio_info;
+	int				num_channels;
+	struct iio_chan_spec const	*channels;
+	unsigned long			adc_en1_mask;
+	unsigned long			adc_en2_mask;
+	int				(*adc_rate)(struct axp20x_adc_iio *info,
+						    int rate);
+	struct iio_map			*maps;
+	enum axp20x_variants		axp20x_id;
+};
+
 enum axp20x_adc_channel_v {
 	AXP20X_ACIN_V = 0,
 	AXP20X_VBUS_V,
@@ -237,15 +249,24 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
 	int ret, size;
 
-	/*
-	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
-	 * stored on 12 bits, not 13 bits. Only discharging current is on 13
-	 * bits.
-	 */
-	if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
-		size = 13;
-	else
+	switch (info->data->axp20x_id) {
+	case AXP202_ID:
+	case AXP209_ID:
+		/*
+		 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
+		 * stored on 12 bits, not 13 bits. Only discharging current is on 13
+		 * bits.
+		 */
+		if (chan->type == IIO_CURRENT && chan->channel == AXP20X_BATT_DISCHRG_I)
+			size = 13;
+		else
+			size = 12;
+		break;
+
+	default:
 		size = 12;
+		break;
+	}
 
 	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
 	if (ret < 0)
@@ -255,34 +276,6 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
-static int axp22x_adc_raw(struct iio_dev *indio_dev,
-			  struct iio_chan_spec const *chan, int *val)
-{
-	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	int ret;
-
-	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (ret < 0)
-		return ret;
-
-	*val = ret;
-	return IIO_VAL_INT;
-}
-
-static int axp813_adc_raw(struct iio_dev *indio_dev,
-			  struct iio_chan_spec const *chan, int *val)
-{
-	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	int ret;
-
-	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (ret < 0)
-		return ret;
-
-	*val = ret;
-	return IIO_VAL_INT;
-}
-
 static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
 {
 	switch (channel) {
@@ -522,7 +515,7 @@ static int axp22x_read_raw(struct iio_dev *indio_dev,
 		return axp22x_adc_scale(chan, val, val2);
 
 	case IIO_CHAN_INFO_RAW:
-		return axp22x_adc_raw(indio_dev, chan, val);
+		return axp20x_adc_raw(indio_dev, chan, val);
 
 	default:
 		return -EINVAL;
@@ -542,7 +535,7 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
 		return axp813_adc_scale(chan, val, val2);
 
 	case IIO_CHAN_INFO_RAW:
-		return axp813_adc_raw(indio_dev, chan, val);
+		return axp20x_adc_raw(indio_dev, chan, val);
 
 	default:
 		return -EINVAL;
@@ -620,17 +613,6 @@ static int axp813_adc_rate(struct axp20x_adc_iio *info, int rate)
 				 AXP813_ADC_RATE_HZ(rate));
 }
 
-struct axp_data {
-	const struct iio_info		*iio_info;
-	int				num_channels;
-	struct iio_chan_spec const	*channels;
-	unsigned long			adc_en1_mask;
-	int				(*adc_rate)(struct axp20x_adc_iio *info,
-						    int rate);
-	bool				adc_en2;
-	struct iio_map			*maps;
-};
-
 static const struct axp_data axp20x_data = {
 	.iio_info = &axp20x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
@@ -639,6 +621,7 @@ static const struct axp_data axp20x_data = {
 	.adc_rate = axp20x_adc_rate,
 	.adc_en2 = true,
 	.maps = axp20x_maps,
+	.axp20x_id = AXP209_ID,
 };
 
 static const struct axp_data axp22x_data = {
@@ -649,6 +632,7 @@ static const struct axp_data axp22x_data = {
 	.adc_rate = axp22x_adc_rate,
 	.adc_en2 = false,
 	.maps = axp22x_maps,
+	.axp20x_id = AXP221_ID,
 };
 
 static const struct axp_data axp813_data = {
@@ -659,6 +643,7 @@ static const struct axp_data axp813_data = {
 	.adc_rate = axp813_adc_rate,
 	.adc_en2 = false,
 	.maps = axp22x_maps,
+	.axp20x_id = AXP813_ID,
 };
 
 static const struct of_device_id axp20x_adc_of_match[] = {
-- 
2.35.1

