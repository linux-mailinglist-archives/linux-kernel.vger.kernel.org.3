Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90A583474
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiG0VDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiG0VDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A7564EF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k11so25624954wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjRNYXxMr1okCGj2grS3n0YP83rNlXVFleMjal7EwMQ=;
        b=bz/lScjS2r5eiJBmhXqz7XXESXnUSGQTobnQ+AXj6SVXsjgKUvdIxRIRgLWSqVDBRH
         4H7OXypueV2yxW2VXw/wAPlApBRResMD2SlmrqgH9JdE/sb9nrHecPbeFpNwvRymaEXE
         VmGBKnQEhoqMfgPzELArqsWBadqMsXtnZUZ6/pMaQgYew/E9P6ptEiq9byMJ7+oJFNHU
         df4NqORwHPgTsjRv8pZIaehxAqxoMH/J29Q4cuZSfTKHN3NSzajJeh8QqjGX17tgX4Yz
         YN6GELTlN5uB6lItbmYrI+L/hnuulLyGSX0/o7t5KE4iHlGC0U8jzsSdBsz1lfNNcH6/
         URMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjRNYXxMr1okCGj2grS3n0YP83rNlXVFleMjal7EwMQ=;
        b=geb6FBxY3qbn6hjtSnWo6jYhFiJTtk2xsK9tjTH9T4oq9v1sHgISuTLteCGaAkhN2u
         ILyUQhls0+B2FkfuSc8s04R5F4WoufyTIpIFyM8rIgpdNIlgPZV7uhRBpydsiXiM4vfw
         ycHX2JFPmDvHYjWh3q4DPZVhD1Fp7vDZm2ZevSJORdklh+teNLbO8s0I5MVVRZXhb8b5
         t6th5Ee/TrZUJrhIKgrK7FLkzFlAjNSMkvDWPWupMpaBCnLUPiNbORWIjr6f2LHo4AiN
         AD+p1hxtTKegN2w2Kj1ONLiMqJxPAaRzx3CWTwjGqif89bqueF7+4dvj3pekOyUOux5J
         R22g==
X-Gm-Message-State: AJIora8Xcs+xGitYXzK+0tkdDLVihm9NPZLQ5oj1N5nZzLwg/hKuufYz
        4vafdv8BeVzCaKOjV4MTM5lI5vFTZmro/A==
X-Google-Smtp-Source: AGRyM1vZ2lRLRCtHktVcM48vdHmMcbzE87n3HFKflTsV0i8Ro7ZyuQKlnf4EAcxxZpYg/vhH41BWCg==
X-Received: by 2002:a5d:5986:0:b0:21e:811c:f688 with SMTP id n6-20020a5d5986000000b0021e811cf688mr12538003wri.8.1658955790382;
        Wed, 27 Jul 2022 14:03:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:09 -0700 (PDT)
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
Subject: [PATCH v3 03/32] thermal/drivers/rockchip: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:24 +0200
Message-Id: <20220727210253.3794069-4-daniel.lezcano@linexp.org>
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

