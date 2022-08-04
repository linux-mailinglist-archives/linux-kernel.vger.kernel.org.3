Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7358A37D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiHDWwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbiHDWwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EFB30F45
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so1427335wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4gLdF8Z9GXjLkyxJDJeMcMe40YjZXEY+RZQOYoJu4Mg=;
        b=SV9FayxLpHGjzaI4EaNO5sxgsvLqpjtrdaUFKN2/kSh/+s1uj3wpMLX3Z9L6QbZ5hW
         Wg10Jlq/UHdBCF8rGeXO5GYIe4qGrNuVKlh6ZJy9uMuRR2g4ifm24YW415A76Usc/eUN
         heJ7rsXs6HXWKvbbANjWwLliNbD+t8T2SQBz8gynEHMslxEjMelPAa6zRBQ3YpyEWalQ
         BXaVqKNWzrIzR/1b9MAvMjmdUQcRq4Ru+dMxyBz30NMx6H1jfXTfwxDFGNMv+9aaW7SQ
         zUFv1wMs9NuCR8WIKE0rr06NU3XWU1KAdyKdu4gxskdo7qbTI4FSOWkIpmMoytF3Ysd5
         8i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4gLdF8Z9GXjLkyxJDJeMcMe40YjZXEY+RZQOYoJu4Mg=;
        b=lMsbvU6ki2FMewlXTFQ8R9El6OOmFj0PqDVwA1SA9WR+rtDwRCU9eVvkaenxHI3/q5
         NYVNemRH+Ph1+IRVXSER0t+Sro5FMNfc9GJZjWIv1xZVys7CjDThe7Bt0LchNfTZcgIf
         N7TZDS3KB2OgcKCd9om5DvLUlt0fpBLI0OL+VvlyDdnMAKAkjLNUaybCauPVINyf35nD
         OXyH/F4pKOBSWCsKg9k+MYzmhwvch490HkXHK80TNf9CCbbTrbFa2XiuUrN/yFBnW7YO
         pwvDfPKaYtpNWRSKmR+C3YWGvF5udf/OzUjkVE38Z8zSM/2Lol07+vBgCs3GhXAcuRZt
         x6QA==
X-Gm-Message-State: ACgBeo1K8cfAuweEuew2xLY4xI8lQftkYYJ7ZDN/Bd2PHW69IlggP2Or
        wpcyzlx6MTUPWBTxDaAvWwiRug==
X-Google-Smtp-Source: AA6agR4KA7nFWxHCy1LP1ha2yqeypoamenwWu8KDXBL0rxjw6w7kFRQdcR735hSJSHU9wzvisePuNw==
X-Received: by 2002:a5d:6e8d:0:b0:21e:48a4:b267 with SMTP id k13-20020a5d6e8d000000b0021e48a4b267mr2393881wrz.507.1659653523446;
        Thu, 04 Aug 2022 15:52:03 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:03 -0700 (PDT)
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
Subject: [PATCH v5 06/33] thermal/drivers/mmio: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:22 +0200
Message-Id: <20220804224349.1926752-7-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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
Reviewed-by: Talel Shenhar <talel@amazon.com>
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

