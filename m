Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E05834A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiG0VEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiG0VEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:04:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060B5F980
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so10788710wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=42mA11C3KugEdlssYgkXmp3aVYFcmXl5da1g1i+H0006svGvhYOBl+1OdKUP4GfGDL
         HQl5VNbrBcczKdDjg4FPqehUUAmZqWQyUNwS4qKoa2HcZkR5qWrErBtde/XoDoTv5OOt
         VcJv01a+S7nmvMxjsEUknPTBg4rs824hdmqaiwrpRnbvDbADE8l0TZ/RDEoFx+Fky2vA
         2KeoaSi/NBXckkFvZ0a72yMiA1mEnpH7gaMxXlwO91gX0Haeo3avc3oE1dRKChBuj1oL
         wPGEjDTHdgN/Wcte1am11+1LbKHlLRwBKY7oc7snH4T4suZXlEY/o1m6GlcVEnkBD7Fq
         lP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsU6ca+7WX/xVGECcsjSjS8CnQ/NXZV7RYxDyAjfgbo=;
        b=hp3EodIu6UrMvu63FTfVWtMFxzs4IpPXsYfh8tVrfRMbBlaOAw54mXBUfVmT4nbBlQ
         sFTD5NbvR0CuT0aTaXgA6HLXIXdhNO5J3grSDU3U+3QpNdvhfCkH7zD3YqmoM9EEh4t0
         VIII5Lec3p/APvPAFCZZJgjxQ8tvpER33JbJcDaD3Dsy56+xCarVUryCRgbamOhGEt2X
         vODUmw4mGx+kLjdn6zAuHSzgmcpuYj8ONvOngcXIUhzAhr/ATD9Bzc/9h/sAvmyky//j
         tnKi+tPe81/yEv03U+6xLBriztGC7wimOxHu/yY29cgvtFfm/Skgwc+Vwcp2DoZ/vKOX
         SyVw==
X-Gm-Message-State: AJIora+yxrmwU30bhNU5ipTSsxPmtH+Q4SwSBuz+shX627BsaymTjiJl
        HTxKiiYrUOAUH9nJEl4m3a/giQ==
X-Google-Smtp-Source: AGRyM1vOxFEluw9dBe7VYgeamJpNxBAT4GHX/PZ9QplCY9sqZW0f3+LjS/Bj/oawdfMZy9Kz6vPWIw==
X-Received: by 2002:a05:600c:34c2:b0:3a3:62d3:de5 with SMTP id d2-20020a05600c34c200b003a362d30de5mr4430418wmq.29.1658955836149;
        Wed, 27 Jul 2022 14:03:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:55 -0700 (PDT)
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
Subject: [PATCH v3 19/32] thermal/drivers/qoriq: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:40 +0200
Message-Id: <20220727210253.3794069-20-daniel.lezcano@linexp.org>
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
 drivers/thermal/qoriq_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..d111e218f362 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,9 +82,9 @@ static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
 	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
 }
 
-static int tmu_get_temp(void *p, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct qoriq_sensor *qsensor = p;
+	struct qoriq_sensor *qsensor = tz->devdata;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 	/*
@@ -122,7 +122,7 @@ static int tmu_get_temp(void *p, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -146,9 +146,9 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		sensor->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(dev, id,
-							   sensor,
-							   &tmu_tz_ops);
+		tzd = devm_thermal_of_zone_register(dev, id,
+						    sensor,
+						    &tmu_tz_ops);
 		ret = PTR_ERR_OR_ZERO(tzd);
 		if (ret) {
 			if (ret == -ENODEV)
-- 
2.25.1

