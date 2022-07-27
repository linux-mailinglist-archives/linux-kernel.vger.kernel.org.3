Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E6583483
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiG0VEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiG0VD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC660501
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id i205-20020a1c3bd6000000b003a2fa488efdso1537586wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=i7fp0SeixfZAM7P9V78PX18dsuN66k6ZVzcgeS4ZKDbrk+me9DJ/CdNeSSKKWoXJvZ
         rMH5veAqbNi2xR2gbSCDKjOS6I/fAZ76bTHjBfyDf078RzBFnSvw36REEX9VmjUb1scM
         0Rs/LcXNOCTMl11DVu21DUGQP/k6Cw1tjSO1kzPwcgXEvNiTbNnihBaM0/KdLxe0Bmcy
         RFKwf18WcDLOWeJA9Y7Djs70y3MQYVwjZr3hjYC/GtmFguDbkbzpcAY0HJ4enBXB/w1F
         Eb8+h1Vfo74qPodoGYqi0GgdIZZXQKANXgm1t9/fPVFM4lX7z0OUxxGweKgVLmCl9rdz
         Ku4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3KXZ40ukCVssYokTyD4CFy6bR4TME8bIQCib4ndaUEM=;
        b=ToKuon4YaVaCb/6BDtcZug55ZMdczfuZrLkeWljrqfeWEGT3NlNY0ngTjVrYqjuDlZ
         HVTC2lhuga3L59Mw1WYdV/14ryeak6YQBCse4dSiF3YGk8n/kN0s5Y1z/C7pK0RXqGpM
         dpho1/vY6gmOEfT5o1Xzp/vi6XwECMitfVifTCksG+wQTW9znbq1IsHwUkoj4yP8OBTK
         tpzjxeFObtdv2RJgW0SBmQzaZR5wvz16RDOt5ULvspzrwwybuB60LG5vegIwmD8BJ2bt
         h2Evmm+zAzfHuY7mcao+PhB+MJcJY597TB+35I09gk8/JY4e9MjLNB7ZHCbClLSNt+vx
         FUNQ==
X-Gm-Message-State: AJIora++GqDa/1TmfeogbfuElgbm4woW1Y5Qk0TciomA74+CwWVZ9vDA
        U6uCCl/NzmaT09ltAcx5l2SCgA==
X-Google-Smtp-Source: AGRyM1vBq4Cj13SgN0+qvycu1pEFDh2ajcfzWNsQ/tRu83ov3FJsBnoXNvAoV0pq4Plz/QY/RYorxQ==
X-Received: by 2002:a05:600c:1986:b0:3a3:490b:1fd4 with SMTP id t6-20020a05600c198600b003a3490b1fd4mr4152269wmq.140.1658955825184;
        Wed, 27 Jul 2022 14:03:45 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:44 -0700 (PDT)
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
Subject: [PATCH v3 14/32] thermal/drivers/armada: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:35 +0200
Message-Id: <20220727210253.3794069-15-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/armada_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2ebfb5be4b3..52d63b3997fe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -420,9 +420,9 @@ static struct thermal_zone_device_ops legacy_ops = {
 	.get_temp = armada_get_temp_legacy,
 };
 
-static int armada_get_temp(void *_sensor, int *temp)
+static int armada_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct armada_thermal_sensor *sensor = _sensor;
+	struct armada_thermal_sensor *sensor = tz->devdata;
 	struct armada_thermal_priv *priv = sensor->priv;
 	int ret;
 
@@ -450,7 +450,7 @@ static int armada_get_temp(void *_sensor, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops of_ops = {
+static const struct thermal_zone_device_ops of_ops = {
 	.get_temp = armada_get_temp,
 };
 
@@ -928,9 +928,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Register the sensor */
 		sensor->priv = priv;
 		sensor->id = sensor_id;
-		tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							  sensor->id, sensor,
-							  &of_ops);
+		tz = devm_thermal_of_zone_register(&pdev->dev,
+						   sensor->id, sensor,
+						   &of_ops);
 		if (IS_ERR(tz)) {
 			dev_info(&pdev->dev, "Thermal sensor %d unavailable\n",
 				 sensor_id);
-- 
2.25.1

