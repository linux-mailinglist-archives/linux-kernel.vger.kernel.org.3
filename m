Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625258733F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiHAVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiHAVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B7481C3
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:24:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso6126812wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=jTCkN/FsnFc9VrryWqPs923cW+htGj25/cCktKLVZG2LwE0du2AgJv/DKBW1kGzcTA
         8gwoZQt7/SG5UqzG7VcF4/RMUbN8z8zLfsZLYs+7Z8FAYYrCg12FXv87yyryTnCeieti
         lFtWEU2t6NfpKMPxYxQ6uQzLfhNnjAq/f8gnaMjYmPZEmVO+IH+o4UZhtUSS9Fq1878Q
         1FO+WIjvI3StRSZRT2yggoq/ktKGtomz3zc/Y6cVrG31J6MTM7h/fEESEdTaDavvCybX
         QBkffEXUtGOg0ieTV/+lAH4m64eGe8g+RQ+lLk8a1XngX2euevL0frNQAernct2U238d
         UC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=vvT43ZwQyH36F5bjgExw40siQUFH8htL/E2FE1hlVlwP60bOil4JHoJaoM0mbDQkfC
         /1L6FYkoIUtQL5ogfzGPgY1HmUAvf1DQ/Puu2uaFKCZKdSPoJbTOylF8tEgMrOHl6Vuu
         qXvAebjTIHu3ejT7l4Qdbex5aA2vIL4NECDN5Q9vrYpn9Mwe6JMlFo6ChbAJwX+NaHDf
         TJjKl16D0pRbzFU4FuPc8iInh3hzpBXHLQaFOqHrGhOlUU+VlF3lY/dx6nJpj+5DjV3Q
         b8w14RB3Ws06nVio8aq7Kyki6WFEsU+YRvCEg+j1gx8+ayUfoqIeS5F90vvlhEDc+ooP
         Wkag==
X-Gm-Message-State: AJIora/55GGYzjT6KJnTj+JhOtrealQkQD/apf7bsKtbuNAsacXCY3N6
        B5z+nuDdnaCjS5usTJGcdm1wXw==
X-Google-Smtp-Source: AGRyM1tEHlqXHn1llUypH6gHVdeS9yeDRdpgOfRH5spOgnM4JZAMrjAyTqf5MulvhNGAatdy6tkiGw==
X-Received: by 2002:a05:600c:190b:b0:3a3:45c5:9f43 with SMTP id j11-20020a05600c190b00b003a345c59f43mr11954478wmq.130.1659389039083;
        Mon, 01 Aug 2022 14:23:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:58 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 23/32] thermal/drivers/hisilicon: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:35 +0200
Message-Id: <20220801212244.1124867-24-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/hisi_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index b29ab09040d5..cc5da71b6f55 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -442,9 +442,9 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	return 0;
 }
 
-static int hisi_thermal_get_temp(void *__data, int *temp)
+static int hisi_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct hisi_thermal_sensor *sensor = __data;
+	struct hisi_thermal_sensor *sensor = tz->devdata;
 	struct hisi_thermal_data *data = sensor->data;
 
 	*temp = data->ops->get_temp(sensor);
@@ -455,7 +455,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
+static const struct thermal_zone_device_ops hisi_of_thermal_ops = {
 	.get_temp = hisi_thermal_get_temp,
 };
 
@@ -467,7 +467,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 	data->ops->irq_handler(sensor);
 
-	hisi_thermal_get_temp(sensor, &temp);
+	temp = data->ops->get_temp(sensor);
 
 	if (temp >= sensor->thres_temp) {
 		dev_crit(&data->pdev->dev,
@@ -492,9 +492,9 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	int ret, i;
 	const struct thermal_trip *trip;
 
-	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							   sensor->id, sensor,
-							   &hisi_of_thermal_ops);
+	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
+						    sensor->id, sensor,
+						    &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
 		sensor->tzd = NULL;
-- 
2.25.1

