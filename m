Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F34583487
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbiG0VEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiG0VD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BD6051D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d8so25985509wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=jZFwziLi1QRj+gAtn+EUomuOooQMzKebyFMh8wB57mgJd6MiPgz4XhXFHPpyI2Eqq0
         +UukbTfXprAGUcQY0nlij8M76MI0KQLMpec1yCxfu/7J0x3rWa63DzXuwH9Pp9+GFsQi
         z739WG7sGM/1HT6GSp8328CSMVvGiOq0dHRUrwjC2oSKb1osCAUuyT0pC8vFvfqq/pZA
         RmMrldALamX4T0srDPdYCLKaStdO1xMm2HuXP7EgDbwn4SHyJnFN+HnJ4UeIKaGMMkHU
         qj2DOMflTQprH6+W8m7buQHnC1j+w5ruKDdx+HK9nZ/YLklkjXOu8+UCKAalGhy4/hxk
         Ko2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=xSBf/VW4qyRDP84PwbuyWyZ/zrWirlg1mPuP4wDWcYMxYdwtv/ab2cSxpUmmkmWUV2
         rlgUQcRHy4HtI9IyLFKs6Dx6ymGcP0IzhEnvCPUXfO5LDnWQfjIfWIrkQS4a4o8YPmKj
         OrCl9OwcsPoQRw+QiummVJIO4VoWWtBlt7CyliOz9Ik3RAOpgqrz8NySgXM3LQWrVCXy
         wyV5klvN6gaW7pDy/H7366etpK4Yi86U8bgXXng0s0Y8jSD5SxzhelE9znO3k13Ih0xA
         GSs10Fr3HXEKagLKo1VfuJiQXRSV/9NBAXTseRnusLNDia/EZCJBWOEkT+IrPM0I8ZNl
         NkVQ==
X-Gm-Message-State: AJIora8nWTrnlUtkbKfT2yhXXZV623HK4C6AJT55YJaAFhOv7FGN5L8g
        FM/TEY2gaRIwLH4tzBR69rrxdQ==
X-Google-Smtp-Source: AGRyM1s76+7yXYHY4OonT2tDvEKKanbOE7ybrghZycJlv5jGCG8SfZR8feV7r8VD6klcmdzRR/UXMQ==
X-Received: by 2002:a05:6000:1f93:b0:21e:ada7:7d1f with SMTP id bw19-20020a0560001f9300b0021eada77d1fmr5939832wrb.555.1658955829704;
        Wed, 27 Jul 2022 14:03:49 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:49 -0700 (PDT)
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
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v3 16/32] thermal/drivers/imx: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:37 +0200
Message-Id: <20220727210253.3794069-17-daniel.lezcano@linexp.org>
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
 drivers/thermal/imx8mm_thermal.c | 14 +++++++-------
 drivers/thermal/imx_sc_thermal.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/imx8mm_thermal.c b/drivers/thermal/imx8mm_thermal.c
index af666bd9e8d4..e2c2673025a7 100644
--- a/drivers/thermal/imx8mm_thermal.c
+++ b/drivers/thermal/imx8mm_thermal.c
@@ -96,15 +96,15 @@ static int imx8mp_tmu_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static int tmu_get_temp(void *data, int *temp)
+static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct tmu_sensor *sensor = data;
+	struct tmu_sensor *sensor = tz->devdata;
 	struct imx8mm_tmu *tmu = sensor->priv;
 
-	return tmu->socdata->get_temp(data, temp);
+	return tmu->socdata->get_temp(sensor, temp);
 }
 
-static struct thermal_zone_of_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
@@ -165,9 +165,9 @@ static int imx8mm_tmu_probe(struct platform_device *pdev)
 	for (i = 0; i < data->num_sensors; i++) {
 		tmu->sensors[i].priv = tmu;
 		tmu->sensors[i].tzd =
-			devm_thermal_zone_of_sensor_register(&pdev->dev, i,
-							     &tmu->sensors[i],
-							     &tmu_tz_ops);
+			devm_thermal_of_zone_register(&pdev->dev, i,
+						      &tmu->sensors[i],
+						      &tmu_tz_ops);
 		if (IS_ERR(tmu->sensors[i].tzd)) {
 			ret = PTR_ERR(tmu->sensors[i].tzd);
 			dev_err(&pdev->dev,
diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 331a241eb0ef..10bfa6507eb4 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -43,11 +43,11 @@ struct imx_sc_msg_misc_get_temp {
 	} data;
 } __packed __aligned(4);
 
-static int imx_sc_thermal_get_temp(void *data, int *temp)
+static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_sc_msg_misc_get_temp msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	struct imx_sc_sensor *sensor = data;
+	struct imx_sc_sensor *sensor = tz->devdata;
 	int ret;
 
 	msg.data.req.resource_id = sensor->resource_id;
@@ -70,7 +70,7 @@ static int imx_sc_thermal_get_temp(void *data, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops imx_sc_thermal_ops = {
+static const struct thermal_zone_device_ops imx_sc_thermal_ops = {
 	.get_temp = imx_sc_thermal_get_temp,
 };
 
@@ -109,10 +109,10 @@ static int imx_sc_thermal_probe(struct platform_device *pdev)
 			break;
 		}
 
-		sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-								   sensor->resource_id,
-								   sensor,
-								   &imx_sc_thermal_ops);
+		sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
+							    sensor->resource_id,
+							    sensor,
+							    &imx_sc_thermal_ops);
 		if (IS_ERR(sensor->tzd)) {
 			dev_err(&pdev->dev, "failed to register thermal zone\n");
 			ret = PTR_ERR(sensor->tzd);
-- 
2.25.1

