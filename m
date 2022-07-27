Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8A58348B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiG0VGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiG0VFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:05:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1B6172E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so106629wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hWFZXwysMvsN10lXDK6sChpf4X2qhnFs4AeSH8mvwTs=;
        b=fKlk36kNOIXutyiEJaCv7Gy8Y8SXPlCpXEpYT3v5hsMHepohYOURnllehr0xqrdsih
         078Fcvs34wsDW8L5O5Pd7eWtz38QHUh1HtvR4zooK/5hbc97+Wmqbny72ol7qEj20n3v
         GJV9ONI+/SmPBwYp1ysGn6xl2li8XJ7rlA9/L3pzQVAH9NdJeieQevx7mwXWpqjgeSoa
         y3rBAk4q3yoQrnxQHvFy1QFxG2EKnxE9CDr+o4Pfk15EcgVvqz2DQxJyuis6Eot8avz/
         0qyxFLygD/WvXkzaPZoOgQu6Nur+1H3zTbzuIy0Cw3V0q/rP5rk2p5z1Bc3boCtnkvAC
         qrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hWFZXwysMvsN10lXDK6sChpf4X2qhnFs4AeSH8mvwTs=;
        b=Li3VwkJc9ZJd6Vom29lARH8OxeJ/VkE+W0WGU6X2etB7C/XeKmrlbzzz4Pij1xSW1u
         KO18zd3MJLNrNh+UZVpxi2eRO8pHznJ8vrqZqSJ+Y+ryFzH5bH9K7ifg+ijVv+aAAthp
         w015MxBQ1T2bMXjqsaUlEue3drqy9ZQtr+//QG7bPCrXgOzZyB+S431XlT1PSGbnzB3v
         k7jiccbSXFq1YrmjU0D9LzorG89Op1kEwjOQ2sAOr6EGP/ja/bQJqcSX0Bi188xPpuzm
         KADz3ZrMNiBl41XA+i+HwvzDqi+mQwchLyBk9K619ScRYmvtoOv898ZXs0OB7KuZ3Zk9
         hbnQ==
X-Gm-Message-State: AJIora8jJ5QMgncUyn9/TVcrK7FO+VQlKsyT91c0derdhblikTWin4ov
        vsq0VrrrRthDFo9c3m8RWXHqRA==
X-Google-Smtp-Source: AGRyM1uvQcL47CIAsOneuLf1vtRWhov+nEkxHt6C1rGUbebVn2iW0PNibO5XgN8bydxhr3hGx4Gw1g==
X-Received: by 2002:a05:600c:1c26:b0:3a3:2251:c3cb with SMTP id j38-20020a05600c1c2600b003a32251c3cbmr4353158wms.126.1658955854767;
        Wed, 27 Jul 2022 14:04:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:14 -0700 (PDT)
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
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support)
Subject: [PATCH v3 27/32] iio/drivers/sun4i_gpadc: Switch to new of thermal API
Date:   Wed, 27 Jul 2022 23:02:48 +0200
Message-Id: <20220727210253.3794069-28-daniel.lezcano@linexp.org>
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
 drivers/iio/adc/sun4i-gpadc-iio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2d393a4dfff6..13d1e937357c 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -412,9 +412,9 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_get_temp(void *data, int *temp)
+static int sun4i_gpadc_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct sun4i_gpadc_iio *info = data;
+	struct sun4i_gpadc_iio *info = tz->devdata;
 	int val, scale, offset;
 
 	if (sun4i_gpadc_temp_read(info->indio_dev, &val))
@@ -428,7 +428,7 @@ static int sun4i_gpadc_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
+static const struct thermal_zone_device_ops sun4i_ts_tz_ops = {
 	.get_temp = &sun4i_gpadc_get_temp,
 };
 
@@ -637,9 +637,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
+		info->tzd = thermal_of_zone_register(info->sensor_device,
+						     0, info,
+						     &sun4i_ts_tz_ops);
 		/*
 		 * Do not fail driver probing when failing to register in
 		 * thermal because no thermal DT node is found.
-- 
2.25.1

