Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8035806A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiGYV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbiGYV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965FF24948
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so17621743wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=zjdR9E4eOlA7485Udy+F2VuliqkiFtNIb1Iy4w6TDM2S/95oYjkeZp+tds9IdXlTrN
         UKK8Gw6ragqY1xMt8eZfQHNwDqD68UnFmmUfzoLdJbUp4lMGXcN12f163r33Qk4Xd8Z8
         XGs1McLdMgndqRB1i008YqqhJf92BvX8OwHMyVonsqJGKCK32FzXeAcmuD9HJmgs4Bqo
         /Ggn2UVy0G9Md/0qfkM/zSxb3AWAB2dZM75b+/EvLSCkCzLIJJ+ITFofgMgg9OEpQ5F5
         cBe9uqk66HuS8yIjHXcNQKACIt97G6V6qWVcBBQnW47liQ/c5Hti0OYKiUNRxC0GYfOW
         UeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=b4/DibQP6Gd0ztahtDygjklvGWXTALZmWmOJzuH5TXZNXjeA/ondfoDa4GcF2Q2Hch
         JmcnHhSYen1bVP3zFKsRyucuQ2fNuLgRwHdr8HiNeX+VyqHmAXnBll0AyKY3gqtKdX6U
         lNIyAm6+TCSRZuqjL4ZuI48aeJeSgPlbBMJgdzkcNNSBmB3GdE1ePxDIFDKMo+mm9Bqf
         pj6kCpQkoWEPlb014VrKuiStap6LBCBGMlH1dGm1qKzpviM0Gb2JCXPhhxxSq3ervwu7
         c/EA83KgSDu5FQc1+W8vhsNOkbx/4F6HYH19ijicOX5JFSuxDzZfW4ji015BcVI5Luuy
         mucg==
X-Gm-Message-State: AJIora8Idoq9ZsQ8CLIazxtA/hIev6tI8w55Uo8x7+J4mbOto5jUYrIa
        TtX5aaNcgEiYLCJlouO3XfX2cQ==
X-Google-Smtp-Source: AGRyM1us+9EShmMg2IdStuWqW6GotveB0ReZJ6CFToeHn6HBdpQ5syMyeuCIZtxuWywyLn/TlD8REg==
X-Received: by 2002:a5d:59a4:0:b0:21e:8704:ea35 with SMTP id p4-20020a5d59a4000000b0021e8704ea35mr4646344wrr.442.1658784455921;
        Mon, 25 Jul 2022 14:27:35 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:35 -0700 (PDT)
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
Subject: [PATCH v2 16/32] thermal/drivers/imx: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:21 +0200
Message-Id: <20220725212637.2818207-17-daniel.lezcano@linexp.org>
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

