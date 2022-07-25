Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7308580685
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiGYV1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbiGYV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD68248CD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h8so17695930wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=4A+rmH5FZdlInKT/IX846VUtAcg0whbHzdGUMh3sSe86/B1YPdQRtpISDXGnDjKA5A
         iEDwo0gN2W4HpW0UywK46TukdfyayePcb0aOuLa7dTqW2cFn/M5ZPAglWQMYjZcOcI2a
         0WY6tPthSUe455uxDY0nXn0k934l/ir3s/PoEFq8oVnsfsBmzKbzFZsrsTCoMTKVBZdP
         ikGa5fkkOueujzOcly3zondACVTnIUtnipqKXG7HYH6OtYamjFgZxRjlqv6haVL3RicO
         9VVXIW9lbt/ltgGuL+UiMAiNfhETPIyA3b2wPL4V70YN7DHCRyHPIZKjbR9WDKGRxav8
         jWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=0J2HzSvLgwkTvbvr2D3sEsApQx9kxb27W9higm2pDZJ7cNIfpovj29g8cDJrJ4mKAx
         Hfq8KhvBAjfwH60k6AA5tKZqZVk5e7CnJZJMzQJDuE0BqSbGGjfUhAtFv3dLXDiZTLF/
         Aad0MsPVDsW9vMuF8OGjx9P0fdjXtXSt+00X8RGFLdAK6aNhCFAnYxhKu+h7h2bYpG67
         SoGpxYj/0eD77pRCbxsHBnlBUx8vDaSNzAR0ZKkQBCEsBJUurmqMnnIfWZCl2dW20OBl
         haLufR4N07zFLWXm3JG067yMbXvZi5guac+40vduzVrCSKr+ilapxtlm+qS0a6U2un6o
         Ay6w==
X-Gm-Message-State: AJIora96pOwYyIOuv+r1B0PFV1IDsc+ni70QmOHdqUaf/+iQXLeHIrvd
        d3cnDshi0G+Mo4ZjlHkyu4Lvpg==
X-Google-Smtp-Source: AGRyM1vUW151zyjWsaoIvJE7BR05pGeZN5me8jAFH/+l052fUdKUSaAu9hi8tNyIfy5CuOwaH6kQNw==
X-Received: by 2002:a05:6000:719:b0:21e:4530:c558 with SMTP id bs25-20020a056000071900b0021e4530c558mr8323291wrb.243.1658784419294;
        Mon, 25 Jul 2022 14:26:59 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:26:58 -0700 (PDT)
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
        Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/UNIPHIER
        ARCHITECTURE)
Subject: [PATCH v2 04/32] thermal/drivers/uniphier: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:09 +0200
Message-Id: <20220725212637.2818207-5-daniel.lezcano@linexp.org>
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
 drivers/thermal/uniphier_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 4cae5561a2a3..4111d99ef50e 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -187,9 +187,9 @@ static void uniphier_tm_disable_sensor(struct uniphier_tm_dev *tdev)
 	usleep_range(1000, 2000);	/* The spec note says at least 1ms */
 }
 
-static int uniphier_tm_get_temp(void *data, int *out_temp)
+static int uniphier_tm_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct uniphier_tm_dev *tdev = data;
+	struct uniphier_tm_dev *tdev = tz->devdata;
 	struct regmap *map = tdev->regmap;
 	int ret;
 	u32 temp;
@@ -204,7 +204,7 @@ static int uniphier_tm_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops uniphier_of_thermal_ops = {
+static const struct thermal_zone_device_ops uniphier_of_thermal_ops = {
 	.get_temp = uniphier_tm_get_temp,
 };
 
@@ -289,8 +289,8 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tdev);
 
-	tdev->tz_dev = devm_thermal_zone_of_sensor_register(dev, 0, tdev,
-						&uniphier_of_thermal_ops);
+	tdev->tz_dev = devm_thermal_of_zone_register(dev, 0, tdev,
+						     &uniphier_of_thermal_ops);
 	if (IS_ERR(tdev->tz_dev)) {
 		dev_err(dev, "failed to register sensor device\n");
 		return PTR_ERR(tdev->tz_dev);
-- 
2.25.1

