Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89258A375
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbiHDWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiHDWwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:52:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261272EEF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so1385358wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yY7L3sqNECPS66oxsrQOipowqI7T9PMCADR4st5QAxA=;
        b=3Y9D4c0pyJct0t/fz7pa2WXBbqdvotgWraefV8v2UY7pxsaEPt47JCaSTkf6H1qQLb
         zbV5fNW+BcLlFmg4MLjR1sDclhAnx2dD40KR0SZYM4m84+448LPEWoXQ5iGn+K1PJfI6
         yB0eq540SKxHm53nel5dNm8EomKKvVGli1jwkxbvVnldrZQIDKz0QECXvKW8wDvKfpyi
         FdMpej2QIt8qODrFpHMwTvjfVSqtT9u4ICOpLczrwXysPLZQlLbOAIqXJI0mwg0K/hKB
         9Nj+dxEcYXA6UYrxN5KSthGlB9t+c0NsF7xYrUQ0oD6HeLXnhB2iF/4Qw0dDWT1rDRjI
         K+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yY7L3sqNECPS66oxsrQOipowqI7T9PMCADR4st5QAxA=;
        b=lA1a7gQrNfLP8RAQ/C56/gq9p0kQaJYDCjbc3VD/Qhf9ef/GsoZawtD0qQRtV7eJe8
         z+YrNuDglhs0Q0scmYMtlT0YzaO/ZI6s2D+qm9un2QR3wKD/kyoOSspyjIcQU0iIeP6G
         Vh0tVgMalam7nxE434Wzq6CV7M7T0lnhZTMgZLtnVhrz8lBSyI7y6ueTG4hch/JUBbJv
         kEauFcrblbmxlXh79gwMp2lLXvd1BufuXwTatQ0Z9hiZou5cO1OaZErRZvg+B+pD+qnU
         xTM7FSR8kmRaBoIic1BBXceJeq1MrzRaDOYDGyFTIO/km1UAPMjoDh33bOYCpkkMvGl5
         ieUg==
X-Gm-Message-State: ACgBeo10BRm1HdQn3ioNChVhRtzuLcNOaWXepK3/V5Wkk5x59bt/BF72
        XG/w1xTPPOPLS981PlFOQKCP0Q==
X-Google-Smtp-Source: AA6agR5kNFd41Sa5oFqkxaJt/vY0sCyYBpHlLVNk5sjOZyy1oAqv1odmMR8zg0KdC1W58YFZxfJbeA==
X-Received: by 2002:a5d:6512:0:b0:21e:cdab:1598 with SMTP id x18-20020a5d6512000000b0021ecdab1598mr2533247wru.687.1659653546829;
        Thu, 04 Aug 2022 15:52:26 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:26 -0700 (PDT)
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
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE)
Subject: [PATCH v5 12/33] thermal/drivers/st: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:28 +0200
Message-Id: <20220804224349.1926752-13-daniel.lezcano@linexp.org>
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
 drivers/thermal/st/stm_thermal.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 5fd3fb8912a6..78feb802a87d 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -302,9 +302,9 @@ static int stm_disable_irq(struct stm_thermal_sensor *sensor)
 	return 0;
 }
 
-static int stm_thermal_set_trips(void *data, int low, int high)
+static int stm_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 itr1, th;
 	int ret;
 
@@ -350,9 +350,9 @@ static int stm_thermal_set_trips(void *data, int low, int high)
 }
 
 /* Callback to get temperature from HW */
-static int stm_thermal_get_temp(void *data, int *temp)
+static int stm_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct stm_thermal_sensor *sensor = data;
+	struct stm_thermal_sensor *sensor = tz->devdata;
 	u32 periods;
 	int freqM, ret;
 
@@ -474,7 +474,7 @@ static int stm_thermal_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
 			 stm_thermal_suspend, stm_thermal_resume);
 
-static const struct thermal_zone_of_device_ops stm_tz_ops = {
+static const struct thermal_zone_device_ops stm_tz_ops = {
 	.get_temp	= stm_thermal_get_temp,
 	.set_trips	= stm_thermal_set_trips,
 };
@@ -539,9 +539,9 @@ static int stm_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sensor->th_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
-							      sensor,
-							      &stm_tz_ops);
+	sensor->th_dev = devm_thermal_of_zone_register(&pdev->dev, 0,
+						       sensor,
+						       &stm_tz_ops);
 
 	if (IS_ERR(sensor->th_dev)) {
 		dev_err(&pdev->dev, "%s: thermal zone sensor registering KO\n",
@@ -572,7 +572,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
 	return 0;
 
 err_tz:
-	thermal_zone_of_sensor_unregister(&pdev->dev, sensor->th_dev);
 	return ret;
 }
 
@@ -582,7 +581,6 @@ static int stm_thermal_remove(struct platform_device *pdev)
 
 	stm_thermal_sensor_off(sensor);
 	thermal_remove_hwmon_sysfs(sensor->th_dev);
-	thermal_zone_of_sensor_unregister(&pdev->dev, sensor->th_dev);
 
 	return 0;
 }
-- 
2.25.1

