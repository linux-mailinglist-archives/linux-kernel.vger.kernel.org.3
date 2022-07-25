Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A2580681
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiGYV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237279AbiGYV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:27:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50CD240BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d8so17620181wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjRNYXxMr1okCGj2grS3n0YP83rNlXVFleMjal7EwMQ=;
        b=OIuAB0R9S3R0tuYdjIBG57LQF+mePnOC043+5qSLc1ib/ai4upOfIOdf9MDbpdnNAY
         69xcbFujx7clZjtfBx2AUniExqL68WETLo/ro5plYDHF2dm2jcHUCA28R+s5M7sEHYzm
         qK/QpGx9jxJ5xqBF3xC1QgPtx5U2luys/7100ia1pEVzJFeylfZShNIXVqkEwDKjrkGy
         1HAml7bDM5OgPBk4jhKEBRnvThszfIQF2aSegtuyuZ/o8J0brue7cCq9gmoCwjOawwdD
         zgUCWqGAW4VLdmBLEAJjBI3zC5s5biq0FFb5WW8ngU1liX7hVifrFJkKSJ5/onXXmBvX
         QHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjRNYXxMr1okCGj2grS3n0YP83rNlXVFleMjal7EwMQ=;
        b=L6LhNachJt3/EWXNfG5Ry10rLUd020qNO4mOe87+G8eW5BhBXV7Ri0CbnQsVjA4pLF
         GsqnWfGr4RNhEkKds8fRkAfxPU8tn2FXZwQcWivPvm8XmtXwyKYifPu0rmwRdsEyNQjI
         d0xlpI5Q4Ggl99vEtwaPo/juHVJULgjOgpA4NOCOs0K0dMyEWdPDBi+6nK89Cnfr7g4B
         kyFNdvDGbqPKRWDy3ufX5cHAYDVXY1+eeOXQSTSUYJo7wCIQDcLEiXy5ziGsrpNMrBZP
         fIfRsnoPgk5Ocw+cst4XPUtLYduvU8yVkI+34v+wKWvaOZkJIRZrJ2BnMaSM5Dng3EWm
         WF4w==
X-Gm-Message-State: AJIora+Q8VYIXYsQh5UUwZqwheir5EFoy151vnsu1TcQbXO9FhvKkShp
        XFLsJVD8nQjcu6sVSsuSivPD96jI8DI6ZQ==
X-Google-Smtp-Source: AGRyM1sGJg6voMCj36V47GPyX5uHOVj+RQfDFEEN855bo6t/AOnZ4PIQMt6CH6kefeVtmha+prt3zA==
X-Received: by 2002:a5d:514e:0:b0:21e:4fe8:cbb2 with SMTP id u14-20020a5d514e000000b0021e4fe8cbb2mr8557499wrt.162.1658784417139;
        Mon, 25 Jul 2022 14:26:57 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:26:56 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v2 03/32] thermal/drivers/rockchip: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:08 +0200
Message-Id: <20220725212637.2818207-4-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
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
 drivers/thermal/rockchip_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index dc3a9c276a09..819e059cde71 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1211,9 +1211,9 @@ static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
+static int rockchip_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	struct rockchip_thermal_sensor *sensor = _sensor;
+	struct rockchip_thermal_sensor *sensor = tz->devdata;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
 
@@ -1224,9 +1224,9 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
 				     sensor->id, thermal->regs, high);
 }
 
-static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
+static int rockchip_thermal_get_temp(struct thermal_zone_device *tz, int *out_temp)
 {
-	struct rockchip_thermal_sensor *sensor = _sensor;
+	struct rockchip_thermal_sensor *sensor = tz->devdata;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = sensor->thermal->chip;
 	int retval;
@@ -1239,7 +1239,7 @@ static int rockchip_thermal_get_temp(void *_sensor, int *out_temp)
 	return retval;
 }
 
-static const struct thermal_zone_of_device_ops rockchip_of_thermal_ops = {
+static const struct thermal_zone_device_ops rockchip_of_thermal_ops = {
 	.get_temp = rockchip_thermal_get_temp,
 	.set_trips = rockchip_thermal_set_trips,
 };
@@ -1326,8 +1326,8 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 
 	sensor->thermal = thermal;
 	sensor->id = id;
-	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-					sensor, &rockchip_of_thermal_ops);
+	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev, id, sensor,
+						    &rockchip_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		error = PTR_ERR(sensor->tzd);
 		dev_err(&pdev->dev, "failed to register sensor %d: %d\n",
-- 
2.25.1

