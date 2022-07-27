Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D7583465
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbiG0VDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiG0VDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDE156B80
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i8so3127753wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qNXTGFtlOgyRJms2wUe/LQRkw+99ki5ct4br/6n4uE=;
        b=QPHAvvQkj70Y803XO/PVmLOMcqwmSt5eOVTiGxW2Qx92bhC5Cph0f5iuO3Z6NUdnBl
         HrayMHWWgdq6NDxPwLIkgAN5g0Fuj0BAFFevscZ3priNoJMtSzHLpt0zpRrUB6NY6F2E
         IAWrrL89tl1w8JNQADd1CHG8sY+r92EVszvnuiUCxO77ctb2bdS7w3YGK0Vt8EZh7kQI
         idVkJO8bZMNX25FwECOR1cE+/1UWl19L3ZXVlhFGe46nAIqGhx+/fL4m/qEpWS8Pfff4
         APBruzthgSN+cVpzRUZLSdIDIpk9qXXuMQwJCTCsYn5OsBoazXC1AemMB9a3Tfc/UK9F
         q92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qNXTGFtlOgyRJms2wUe/LQRkw+99ki5ct4br/6n4uE=;
        b=5xBb95ZR4QyZEgbcduiW77lg5tWyDXXaThd9r7OrlnVOeivuk/mEMM/gfS20dOltuw
         XFRze7qh9OY0n9bctz0L0i3awIw/r0uKRcFycZXQf9yU1KjK+ymny72vm3eeqjpXQTlJ
         6RVBmjA9SBXrjKJ5V07l2rBxlQfWPWqtGikVUB102IKi7JLA12R5Rg24X27kf9+3AaEZ
         RBymxtHCCzVQJlSgzpc4PmADdxrCsUPrdlFCwElRjGy/oblxD5RzlDYY7yoaEfDUwRSr
         7uAs86P2ABeHKeXQIaYhK3Aw/aLtcLoGDE5mFA6twzsOFzdFLbZS8qyQA9h1o277ybSl
         yf9A==
X-Gm-Message-State: AJIora+NjuoOOCBW0uguUhUhRDWYuOxamum8WdgAf4aJ2Wp82OvdsjTz
        n/Duk0P2lZY4pgYLeMYNoHyZRA==
X-Google-Smtp-Source: AGRyM1u62p/rY229sA+4Ohz9Ha2FoxypBBltUN5/AlW8l3lQClXZB3VbR6iNS2o8SjNZ5nd9VhwX/w==
X-Received: by 2002:adf:f90c:0:b0:21e:5293:4390 with SMTP id b12-20020adff90c000000b0021e52934390mr15255954wrr.167.1658955797002;
        Wed, 27 Jul 2022 14:03:17 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:16 -0700 (PDT)
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
Subject: [PATCH v3 06/32] thermal/drivers/mmio: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:27 +0200
Message-Id: <20220727210253.3794069-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/thermal_mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index 360b0dfdc3b0..1bf1a16533da 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -20,11 +20,10 @@ static u32 thermal_mmio_readb(void __iomem *mmio_base)
 	return readb(mmio_base);
 }
 
-static int thermal_mmio_get_temperature(void *private, int *temp)
+static int thermal_mmio_get_temperature(struct thermal_zone_device *tz, int *temp)
 {
 	int t;
-	struct thermal_mmio *sensor =
-		(struct thermal_mmio *)private;
+	struct thermal_mmio *sensor = tz->devdata;
 
 	t = sensor->read_mmio(sensor->mmio_base) & sensor->mask;
 	t *= sensor->factor;
@@ -34,7 +33,7 @@ static int thermal_mmio_get_temperature(void *private, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops thermal_mmio_ops = {
+static const struct thermal_zone_device_ops thermal_mmio_ops = {
 	.get_temp = thermal_mmio_get_temperature,
 };
 
@@ -68,10 +67,10 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							    0,
-							    sensor,
-							    &thermal_mmio_ops);
+	thermal_zone = devm_thermal_of_zone_register(&pdev->dev,
+						     0,
+						     sensor,
+						     &thermal_mmio_ops);
 	if (IS_ERR(thermal_zone)) {
 		dev_err(&pdev->dev,
 			"failed to register sensor (%ld)\n",
@@ -79,7 +78,7 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal_zone);
 	}
 
-	thermal_mmio_get_temperature(sensor, &temperature);
+	thermal_mmio_get_temperature(thermal_zone, &temperature);
 	dev_info(&pdev->dev,
 		 "thermal mmio sensor %s registered, current temperature: %d\n",
 		 pdev->name, temperature);
-- 
2.25.1

