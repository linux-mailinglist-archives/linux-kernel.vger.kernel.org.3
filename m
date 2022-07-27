Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1069583499
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiG0VEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiG0VD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753645A3F2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r8-20020a1c4408000000b003a34ac64bdfso246634wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=sC2Ai27O69uAGSDYSZpdJpP/oeyl0OE/RcgBX+BdoB3Y0I/M6nubdanBnQPgZb5YWr
         qbJcL4CxovNNdvwpoowp5MAQKhpF74r2MSRHTwf8jDYkFTgNE1iKkqMyBE63z/2hUBB6
         dBgxJ7aNS5aRx0+eqN/lVYJbkQ/6w8/+lnmMFfOvxKSNe3OC7Fc/6RqVXE1U2yBkRD4e
         mzF5S+le0WNbwT2v4DCRsWlp4xk5zpHajHw8JDjelJ1xyzmtSK+LHWiUUMjcV5LBbEZx
         VRaWuJUo9rmLh0LwR2E53ShN6iqT0DOuUMlwod9ZwFa6Hmbw2NLVBFAvp2+xfXW3yWvB
         5xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFiHrv2DBvb+sLFBPejQnOaA+sJY54jHJpFAimKLr80=;
        b=KgqobBxJLfkN5SCCJwplYfnydA2FjY++IaWCszzlb1/kVaYkJ4+RVKGJQYmjGH5MGA
         PzWBVBlhaHDQq5sx30AGcp0TGWEZZhzSK5gdp4fOAZJ6AJnelXoOH6BDjgMoPH5MpWb/
         ZEeYrkPNWTQOHaTd/S4stj+OsCvtZdXJXnCBiB4xuVXKzOQusZqm2ckGsOYF8RT1dwx5
         BH3ktykWhsyGqZFjXaLgpoy244CXdSYRyoDVQyuK5+Hsr/FDgaEgu85dp9kkVTYAoNKh
         UmxCA61YJXVa7mcjrSTXtTqIhnQy0Sa548yVdxHSFmmimNCUbRuA4mQGJSEhyIl9dtL8
         D18Q==
X-Gm-Message-State: AJIora+Sd0TezK21qh/hnkFv5JJUEV4VjBy7qiPj9jcTArcBzD8kFuVK
        tfBvud4Bg4OAYwDrjrqugAd59w==
X-Google-Smtp-Source: AGRyM1sqgGSRdzUKCd//rZYqkm++yo9JtB3EuRlVmE+Rn5b6MkOX+oLwQZN/MQ8ypSFVoslPaYUDag==
X-Received: by 2002:a05:600c:4110:b0:3a3:33cd:3984 with SMTP id j16-20020a05600c411000b003a333cd3984mr4294274wmi.128.1658955834090;
        Wed, 27 Jul 2022 14:03:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:53 -0700 (PDT)
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
Subject: [PATCH v3 18/32] thermal/drivers/rzg2l: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:39 +0200
Message-Id: <20220727210253.3794069-19-daniel.lezcano@linexp.org>
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
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 51ae80eda6af..2e0649f38506 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -114,7 +114,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static const struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -207,8 +207,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
-- 
2.25.1

