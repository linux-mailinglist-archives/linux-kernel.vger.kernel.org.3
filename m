Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1058A391
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbiHDWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiHDWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:54:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D474CD6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:53:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so1336285wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yipcQksn9MduY+PrR9+yWSi0xxvFjS5CwaaNjBD2ByY=;
        b=S2KeqwvZfM0DPDER/HvTE1y7NC0Tm55kidKrq4rL9Xc+H5FYrDFcOIEUseaTva7uYi
         gOmq2+048MZMCI5bmYJPloNqAjC1K6mmudPkBFRO8oiuPeQL6Bz4Lzl1YStR/7lc2Oar
         2Nz4T74ZBqdaBtnEewTm91x8SpaNS37CdueA7seKTB6jF/fePFHsjFh4qSlZdEYUpY7b
         jqq2/IkZyj+cY1ZoQ6hWwNO2ogtxb1g6GZ9AvqtmMvc7x7efNe4bmIK8pTqEFpQ0C/0z
         J6h9xVBHJcwCw5kK2n9qFH77EJEB6W7snEUk0Px5FLTeOWm97Mq0XcVv7C1dAce9aZm0
         WqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yipcQksn9MduY+PrR9+yWSi0xxvFjS5CwaaNjBD2ByY=;
        b=eeIUn4QSig+HlYxpWo5JHR+/zYoJZ7RCaCZLteZV5Ho4IQw0EAjXd9V2XGAP0inkUo
         9024LlMS5VQGCNr73i7mYUVo2x5mZGYVbPzH4a/xqEGfF7lEJ0qf3Uazj6+3CmZfiJtz
         Yiz27ravPoaKtZIGDdQ8QzRumJStQ9geMbsSTArW3ZrJEM5R2zX7OUoiXm7y8neGpbyT
         zoQuHL9EM0tGCCUL6bVoMpYUg+PP8UxxOIfLbRCVlZUaA65T0eKlCU9MYHO/oGSkDAUK
         68d4o9twF3CHWlfnTu4wS+kvTEvij5ZZ5eoe1hW5FFO9a3zV0xuIcBEAt+CcGJK56XcH
         7ysg==
X-Gm-Message-State: ACgBeo3t7ua6HhSL5EM0OLOL3cXcTtQGxAPlOflk+1KYqEEoqQFXBT85
        XCtZK5F7ooh8PRhw7YGEIUqJXA==
X-Google-Smtp-Source: AA6agR4prrBJ88PSOCbYsd4L35ffscHB6L1wapJ//I4njEFFbXzHgn8YPQNRIl2SjuMcoU8cCP/aiA==
X-Received: by 2002:a5d:6e8d:0:b0:21e:48a4:b267 with SMTP id k13-20020a5d6e8d000000b0021e48a4b267mr2395012wrz.507.1659653582142;
        Thu, 04 Aug 2022 15:53:02 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:01 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v5 28/33] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:44 +0200
Message-Id: <20220804224349.1926752-29-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..a6ade70dedf8 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_get_temp(void *data, int *temp)
+static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_gpadc_iio *info = tz->devdata;
 	int val, scale, offset;
 
 	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
@@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = &sun4i_gpadc_get_temp,
 };
 
@@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		info->tzd = devm_thermal_of_zone_register(info->sensor_device,
+							  0, info,
+							  &sun4i_ts_tz_ops);
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
@@ -681,8 +681,6 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
 		return 0;
 
-	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
-
 	if (!info->no_irq)
 		iio_map_array_unregister(indio_dev);
 
-- 
2.25.1

