Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838D2587331
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiHAVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiHAVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:24:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126847B9F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:48 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so14638wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=MQvKPtV4cPPEtqd/ru50OXpBq4jq0ulTt5NSEP09xq72xFaWr232eUefJriOb/A9bb
         xfvsOYLpwXf8xwGZq1jAlqow7Jkb1JiHLXFGgB38LUsRwyM7eVEJDvtL296RZXsNtTtX
         1EyaL9B1CRTQuQyfXqO3bz5+jxJYC6rNbhQ1DlTKicMHjZzeisU9iqLanCVGBznNQfm3
         wmKQKpxl4zWQA12Lhn9ezXFVgOoNbc5IUDLQMSJbRgO3N5exjcmd2/6qOYw+S54ORXQ6
         kATUJxgOKU4Ox1pCLqpTOMNd/dR16uD9DhQWWzODtLvllXGDMkCSdRWGQQNsxesLTUq6
         gHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=DgQypQ9qjGMQOldReZkzz7luiULJDuJ+Tw+NPSokZL65MQjTM7fp1rYXz0KlRGAM0m
         B8UF9Z2REh44WCDaolri7JfL+mPzVe+neQl64EAh0yHfimSjpllMEdzFFbky8iXK+5tZ
         6fqVozof2pOrqI4A/OU8O2FATXpOjkL7o+Fq1bca39ehF5/QS3MeKKgvD9+02uckKs73
         7vFDHaH3oNWKiO7Xm+MEFO8nNPRlVt86fGOlSKKgYUL0PYWlDTskTjWCtaT4nWyI0aaP
         qy+hWH1ScJ7ZKixbFFNh+KlOOtyrCVoN8Pu2JTuMop3tcUdVzw/WGetUgeMUCQTa1r7x
         EIjg==
X-Gm-Message-State: AJIora/8sPA5851Ry4fOuiZwIpn37DFuff79EvyiPkZ6AuWB/RH3J3r0
        KcH/DOczRM/MUzi0+mZMbP+qzg==
X-Google-Smtp-Source: AGRyM1toNlcBo11EQ6f/7Ra03AhcXcefk2yCPMUDhRSlK+gcfzQ9+3vCJbcuZknYHS3NrvoPcdb2sQ==
X-Received: by 2002:a7b:ca47:0:b0:3a3:1874:648 with SMTP id m7-20020a7bca47000000b003a318740648mr11738181wml.139.1659389024629;
        Mon, 01 Aug 2022 14:23:44 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:44 -0700 (PDT)
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
Subject: [PATCH v4 16/32] thermal/drivers/imx: Switch to new of API
Date:   Mon,  1 Aug 2022 23:22:28 +0200
Message-Id: <20220801212244.1124867-17-daniel.lezcano@linexp.org>
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

