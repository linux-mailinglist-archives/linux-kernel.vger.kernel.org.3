Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3741858A382
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiHDWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiHDWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD55D481D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j15so1370328wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=Uy4/PmcDOe2Eof+0b+O/7o+pqZYYipxVXGrQMmZN5OI42mD7hQdvXvaw2QGdZV6xAj
         b8Kg7QbEojFnmj883y9T6VEb5J/AT0pINLeJwdZchf4K2yEOxLSCawtQqgpVvPxa4Lu7
         73zFqv+f0sQUjqSYkVXYEuRICcywEVOd2TUbso0ZjGqiIf668+ZNibK6AyIf8KnpCGcw
         3VrsVhdfdGOwxCuyll8sVOzDXOR29+Yj8QalGUbbBlSaeNoUxFbo6YvbxaWu2e+BcRVS
         OR+STRQOAdIr+xERdigPLfMAp2p13sFmmvpUmHBWzmXfZC+FcqoHfr2J2UaE5CCkN1LZ
         lUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0/7L9Lc2wRZZo52YCs91vi96h8X92jsylQFQZGCnX0s=;
        b=0VTUhOhqsX9ChjlrvYYD1gWLnVO7wgKJE3bW9nWxMuHnpa2vz0Cl2NjUmsKcCTnUhJ
         Z5b4zCN3W0Obi7z4eKZUOTxxjzTS4BanrIATT5VTh2M1zUea5P3hEkhk7W+m/d1+Sxpz
         o0sGjS9EPnthKxqMYBeXooq1rDZD7o5sTxw6VODpaXk/oLCj+nWDgdbtGLyuWVRrYGh6
         CLgVFPg++/vvknPvfEO8iZyBkhYh5HjsR4j3A3+ZuX/ZQKA6OE+FWg4WdLVJbTHy6m5D
         rEj2gDFYE0gXQhknxDMOblbjJ50cRP6HVm47UiMObLfxOwlFuIJlNPnAbb6Poca+anMc
         EG6g==
X-Gm-Message-State: ACgBeo2VAvu0Yf4zpjxVtIRtZ53Iv/Gb0SPxZ/6P77xTVft8d5gSMKKF
        Fv6XAUEa/avGSgktmI4F4bU1gw==
X-Google-Smtp-Source: AA6agR7S80zLKj6REvRGOQ79tjssRS7dol4Zsknr1lEVxrkb/3a1IeO+7V6QVVOgHUxNtU0UhnxWaw==
X-Received: by 2002:a5d:6512:0:b0:21e:cdab:1598 with SMTP id x18-20020a5d6512000000b0021ecdab1598mr2532679wru.687.1659653521316;
        Thu, 04 Aug 2022 15:52:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:01 -0700 (PDT)
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
Subject: [PATCH v5 05/33] thermal/drivers/generic-adc: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:21 +0200
Message-Id: <20220804224349.1926752-6-daniel.lezcano@linexp.org>
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
---
 drivers/thermal/thermal-generic-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 73665c3ccfe0..323e273e3298 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -52,9 +52,9 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	return temp;
 }
 
-static int gadc_thermal_get_temp(void *data, int *temp)
+static int gadc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct gadc_thermal_info *gti = data;
+	struct gadc_thermal_info *gti = tz->devdata;
 	int val;
 	int ret;
 
@@ -68,7 +68,7 @@ static int gadc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops gadc_thermal_ops = {
+static const struct thermal_zone_device_ops gadc_thermal_ops = {
 	.get_temp = gadc_thermal_get_temp,
 };
 
@@ -143,8 +143,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->dev = &pdev->dev;
 	platform_set_drvdata(pdev, gti);
 
-	gti->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, gti,
-							   &gadc_thermal_ops);
+	gti->tz_dev = devm_thermal_of_zone_register(&pdev->dev, 0, gti,
+						    &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
 		if (ret != -EPROBE_DEFER)
-- 
2.25.1

