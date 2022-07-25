Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410365806CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiGYVbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiGYV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569C25296
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g2so9659817wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=fpGNc8n1xXJ0imA/RGA543TJhgsAaJo9AZK6Lbnx9rKmV/f4ipl9YuG4iyqU1Pn+HK
         DWc6xfs4lcvmwoejpmcgy2XzCrnJHfp6HwZ8Jiky/3RVh1f1l59Hd/amLfHg2Y9SfiTG
         4x8uBz8cwG/3nLpf9sXeO+ZJmOBET2cLqsaRGNPOelXNBEQizf5w6T7qX8+skV1dvZQA
         sICPw4uNgIU0Nul5Pz25KafqkTB2Ta3xShV6Og2pH2/NK63YTo9ichfn6UBguYYRa5a5
         5p3ujwgdzN0+e3NFNffrZxxCHrThrJCeLd6yOUGVsaZwsL0qtwaxwg6Gii+lwqemHQOk
         ib+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtIC8RNPtrIhefVP3qkzn/ojto5ZENqxzOLIoU7Obsk=;
        b=iYKnynXRhJ/aAZJMgVQJv1sGi62FelnMHFUmQnCxqV1C7AlRvDpAPqlKR9KBek9W5s
         mu00SD8ETrnGaqV7+Aq7peZvgbCfiwlpTfNswRA5ZEK3ILuxtlMTJsMJEDoOnvoF9L5A
         nbaXTPEReTdEwSevi8oaqyi1rEj88Y9ZNRIHV44RKAgR44zUBDhlxyoVX6Ic3eTY0IIG
         x8CIszqJLeZ/r2bW8zlYRZ5DiI8kmEphgpk3xcRF2xTaKYf3LItLlivd9dk5OubYi/ez
         F3wkreG+e5nN9wE8Yvk6WBl6zouFlRsv4yuTANh5mwAcUHf2Ic6AAlPRE9fUb5Srq6ca
         fj1g==
X-Gm-Message-State: AJIora9ligT9uanmyahx4udg9G/qdIWPYstkRVfSm7ncxT0RgCNCmCVi
        DvlBHHLoBhILWUMXn2hF8NHLDQ==
X-Google-Smtp-Source: AGRyM1uPbLXiSnUUCqzUagWvav4f7h6KELyLpVVBzYURiv4OmSHpWYSoTI1UWdB3mM3+TprKDaKLPA==
X-Received: by 2002:adf:f245:0:b0:21d:a39a:bed5 with SMTP id b5-20020adff245000000b0021da39abed5mr8266370wrp.508.1658784470723;
        Mon, 25 Jul 2022 14:27:50 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:50 -0700 (PDT)
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
Subject: [PATCH v2 23/32] thermal/drivers/hisilicon: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:28 +0200
Message-Id: <20220725212637.2818207-24-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

