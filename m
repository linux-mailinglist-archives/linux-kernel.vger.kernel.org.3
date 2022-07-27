Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2958347D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiG0VD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiG0VDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349AB56B9D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so1543020wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=ZB3UhNs3AeVVn5lE/Qx7VhLtMTM1N5/9UpBE5cO0Dn9UtveO39OTCAjKBAZgyUl8+A
         kZrr1hUPyDk5W6tz/eWVVlqV6sWsMLPQdfNPQlwYKlfqB3t5eyAH9iAap8QWRzDVX/7N
         PzEkWWALuU5cRQNVnYV+6MYpHhw3WktCKFJd7/r+unS/LcGFvV0JjdgbjgW2M40rz5oq
         m5Wd1gOXA+jmYiqb4Wak2VEHr1rf7ymqrc63IDXba8Y/fBX+b7loNJ7IS175luiLX5xH
         Qw7FwJxmyaLtAttpV6xInq0jq+mBIvMFzZMPyH0oXC0irfGSNL2FkGRQ971+u/UuRcct
         5/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=Kt8vYwzPMnc5qcpZGqaH7ZluaLo2aAUCKUWDkFUuaG59xnWQUta7lQX3JLMwjy9GL6
         bsUHrUiXifZEf89Gz7B/aNA9o8zOGQBE841kMuGfIymEX37d37zgwEd9bTaQFKf6Labn
         q1XNtB9R9EehKJshEXDO6RkztycTEKt1g4j2lCD11P3yEBbOgdXicQ115xSdTuEtLcZe
         4ew79MZ5RR0HmjEDoCG2V3Afj4f+pGlZsc0S/3codvDxxiOnOtTfRDTwV4z/tRp71dzE
         59aK6UlEgpkgzBtIpyp4rFjPH1jd1ZfFj0Sh9AERIIeLj4Qgw+FB19sFvwxcQG9zWVeq
         tfxA==
X-Gm-Message-State: AJIora/VuMh2vNYLxLCT6IlKTujwAwreK3IZDjXQr+PtU/X3PVBjE+BQ
        T5vIG0Q9AnpB5gbmtF7Qzzz+vw==
X-Google-Smtp-Source: AGRyM1tb9CCnwLsIuuMrl/2cOGc16fYKeJjOIOu13WumWMc57bh/0Zula9eFD8t2r1SwYDZgK4+WUA==
X-Received: by 2002:a05:600c:1991:b0:3a3:3f0d:d9d9 with SMTP id t17-20020a05600c199100b003a33f0dd9d9mr4368049wmq.79.1658955792597;
        Wed, 27 Jul 2022 14:03:12 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:12 -0700 (PDT)
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
Subject: [PATCH v3 04/32] thermal/drivers/uniphier: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:25 +0200
Message-Id: <20220727210253.3794069-5-daniel.lezcano@linexp.org>
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

