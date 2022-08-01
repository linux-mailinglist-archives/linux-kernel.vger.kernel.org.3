Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44948587310
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiHAVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHAVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C8831236
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso6130047wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=f7uWQU5EGyzNqYPjs9kpBBhCAH2B3HL7mKaGdagSMrQSMx8RunYXMAz//tmA5EuuO4
         d4ttQkvk+baacMSL59Og6n+tzwhUTWvl+2eiCb8Q97P29CuaoWJixHe3HXsIZ0XjK0CB
         1n72fRlvyOKcBrO+YfZvBiHGLz7pDHg96D+7UpYJhKfOmDWo/v/vgtTA97BJNW7ZMEfP
         FJrizxciakGQkEeDx0deuUb+LzgvyrJ5yU1HHE6zlwrNZcy4hn7p9VeQM4QEiV/vYzk8
         QIrMYjTS3PRAS5eSKCzBuMcy419o+C1yf+1kmng+7hqPRr6cOZ7Cup3q29OH75AtBWWk
         2KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NVvhouf/ZsSYzyYoQ6bj2MFHWvALAEEXijoyeWSBKFg=;
        b=7CcVijzCTIdZv38tFhU13CRSJIoFle0GFSfbHmvyVDVwUPmNdhhpHjcqgWvkuGmPQX
         amldLYSfcZB3fCeHCEthD7BWYqAfgvZjIvyUXcj89XxtsgC9Y+bASRNVLElDD3SqvWrM
         3lOnJv/udmMmNWWVtsUcMMRxPYKrwxQHQvszjXDl1j2lg3xoJ2erm9U0bGtCrqt2L8RC
         281Yye6U7RCW0sTCUBCFmBIhNXscjJ3B7lvqQT/eWtre187STbUETkkmoSP9LhjssxhZ
         9CYz3dSmafUwg1dswZTGswXUAKYKfZX4dv4i7ID/d9mdCx+U9cM1d3JpEi7zY62XyQib
         S7xg==
X-Gm-Message-State: AJIora8Ne6+GxtIb+k0httCjx3NviEEZQpdJG9J/o5CAcuxWlIq5UKA+
        Oc0fIKzvtPJupgzShg/lTwVzFQ==
X-Google-Smtp-Source: AGRyM1uES3aCRMlbHJ5Cg/hFvgMvUaqSCH+lAZaCp6y7MVfWDfjUVTG9k752wJC+oAnwcwuEUqJK8Q==
X-Received: by 2002:a1c:f709:0:b0:3a0:3b29:5eb2 with SMTP id v9-20020a1cf709000000b003a03b295eb2mr12637431wmh.133.1659388988417;
        Mon, 01 Aug 2022 14:23:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:08 -0700 (PDT)
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
Subject: [PATCH v4 04/32] thermal/drivers/uniphier: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:16 +0200
Message-Id: <20220801212244.1124867-5-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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

