Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD0597FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbiHRIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbiHRIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:23:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E151A26
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:23:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2468579wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8NLpOLXtDGbGnIWI2tt/ydgWWgOFe09tUzZeMJpoqY4=;
        b=eO2AIrHtHNsyMKSmx/qzcElkransmATImUGE4u4UecOq9aNZ1r1ViPNZ6BRiFbhkoJ
         mfiv4D+d6y2iKdjJc7l+lyQx60OcfgguEtlt4OWTWWlEj/wN8KBk4O2pxSZLuu7+QXJc
         KxzHfEGvEiaC8VFXwTVbhYq3QTsU4c9KiV5T4+drx6Aam5ibT9wbBQQdjTr/aHHCVqLm
         MN8douMKMFzWd4gDHjZZRxyM1gYvyvYcLhaid+xq0unaJwBoG4gZCbOUkFwuV/nz5+OB
         4ag1sNwCIW87yB26EJ1DoqAghv3MUDVp6eJdvpQBzae+/t72sihznLJHeE0a5IQeiTZl
         0VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8NLpOLXtDGbGnIWI2tt/ydgWWgOFe09tUzZeMJpoqY4=;
        b=kkH4U50eHqy951ySbMX56xHpjfaMcyPLEYJlMmCgxUZH+mH2FuFY7KpYrHyWHr0ooX
         P2pUIdICR5fNgrnJ/kHGRC7/3VJfa15NGeE/DWvkuK3tXH35rkbZld1du947BjFB5j9+
         kEXYj5zwumfcCGNpnUAZXkq1IJ5aYousP3L8Fwrh2RwYSU+TpfLbyIqW+qnxmM3THTR3
         ghmyKaZf+74xaKJtEF0HnVnHi3KOKM8jyiKECik1qUwnCvnYZge2h+84hHq//7dwM6kX
         d+EC2m3iNbC54KJ67GhKCSfZvN/G2UnAx3vZUc16q29KVaHB2Sq4xHWhCRLtuHJBrG7s
         4zyA==
X-Gm-Message-State: ACgBeo0e+1ij5W9LI1wvBNEBZSW1UE5VHdgV5BNP+rLFCJFFB4uUJ0k5
        wDCq/Mj9JXr/FAbXOfodHmbs2A==
X-Google-Smtp-Source: AA6agR6UQHo2ZfZuRdqHMwsyEcy/b2R7bfnl0cLe6kVVHgFLIHNfhEbwz0BfmenkP40oA4Yv/WyvXA==
X-Received: by 2002:a05:600c:1c95:b0:3a5:c28a:df3e with SMTP id k21-20020a05600c1c9500b003a5c28adf3emr1173247wms.40.1660811008697;
        Thu, 18 Aug 2022 01:23:28 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003a500b612fcsm4634005wmi.12.2022.08.18.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 01:23:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH v2 1/2] thermal/drivers/imx_sc: Rely on the platform data to get the resource id
Date:   Thu, 18 Aug 2022 10:23:15 +0200
Message-Id: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the imx_sc driver is reimplementing part of the thermal zone
parsing from the thermal OF tree code to get the sensor id associated
with a thermal zone sensor.

The driver platform specific code should know what sensor is present
and not rely on the thermal zone description to do a discovery. Well
that is arguable but all the other drivers have a per platform data
telling what sensor id to use.

The imx_sc thermal driver is the only one using a different
approach. Not invalid but forcing to keep a specific function
'thermal_zone_of_get_sensor_id()' to get the sensor id for a specific
thermal zone as the self-explanatory function tells and having device
tree code inside the driver.

The thermal OF code had a rework and remains now self-encapsulated
with a register/unregister functions and their 'devm' variants, except
for the function mentioned above.

After investigating, it appears the imx_sc sensor is defined in
arch/arm64/boot/dts/freescale/imx8qxp.dtsi:

which defines the cpu-thermal zone with the id: IMX_SC_R_SYSTEM

This dtsi is included by:
 - imx8qxp-ai_ml.dts
 - imx8qxp-colibri.dtsi
 - imx8qxp-mek.dts

The two first ones do not define more thermal zones
The third one adds the pmic-thermal0 zone with id: IMX_SC_R_PMIC_0

The thermal OF code returns -ENODEV if the thermal zone registration
with a specific id fails because the description is not available in
the DT for such a sensor id. In this case we continue with the other
ids without bailing out with an error.

So we can build for the 'fsl,imx-sc-thermal' a compatible data, an
array of sensor ids containing IMX_SC_R_SYSTEM and IMX_SC_R_PMIC_0.

The latter won't be found but that will not result in an error but a
normal case where we continue the initialization with other ids.

Just to clarify, it is what the thermal framework does and what the
other drivers are expecting: when a registration fails with -ENODEV
this is not an error but a case where the description is not found in
the device tree, that be can the entire thermal zones description or a
specific thermal zone with an unknown id.

There is one small functional change but without impact. When there is
no 'thermal-zones' description the probe function was returning
'-ENODEV', now it returns zero. When a thermal zone fails to register
with an error different from '-ENODEV', the error is detected and
returned.

Change the code accordingly and remove the OF code from the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
The changes apply on the linux-next branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

I don't have the platform, so I was not able to test the changes.

Changelog:
 v2:
    - Clarified a bit more the changes description

    - Fix use-after-free and add a couple of comments to reflect the
     patch description

    - Put back the error message in case there is an error with the
      registration

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_sc_thermal.c | 68 ++++++++++++++++----------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 10bfa6507eb4..bba5c730b855 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -76,59 +76,55 @@ static const struct thermal_zone_device_ops imx_sc_thermal_ops = {
 
 static int imx_sc_thermal_probe(struct platform_device *pdev)
 {
-	struct device_node *np, *child, *sensor_np;
 	struct imx_sc_sensor *sensor;
-	int ret;
+	const int *resource_id;
+	int i, ret;
 
 	ret = imx_scu_get_handle(&thermal_ipc_handle);
 	if (ret)
 		return ret;
 
-	np = of_find_node_by_name(NULL, "thermal-zones");
-	if (!np)
-		return -ENODEV;
+	resource_id = of_device_get_match_data(&pdev->dev);
+	if (!resource_id)
+		return -EINVAL;
 
-	sensor_np = of_node_get(pdev->dev.of_node);
+	for (i = 0; resource_id[i] > 0; i++) {
 
-	for_each_available_child_of_node(np, child) {
 		sensor = devm_kzalloc(&pdev->dev, sizeof(*sensor), GFP_KERNEL);
-		if (!sensor) {
-			of_node_put(child);
-			ret = -ENOMEM;
-			goto put_node;
-		}
+		if (!sensor)
+			return -ENOMEM;
 
-		ret = thermal_zone_of_get_sensor_id(child,
-						    sensor_np,
-						    &sensor->resource_id);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"failed to get valid sensor resource id: %d\n",
-				ret);
-			of_node_put(child);
-			break;
-		}
+		sensor->resource_id = resource_id[i];
 
-		sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
-							    sensor->resource_id,
-							    sensor,
-							    &imx_sc_thermal_ops);
+		sensor->tzd = devm_thermal_of_zone_register(&pdev->dev, sensor->resource_id,
+							    sensor, &imx_sc_thermal_ops);
 		if (IS_ERR(sensor->tzd)) {
-			dev_err(&pdev->dev, "failed to register thermal zone\n");
+			/*
+			 * Save the error value before freeing the
+			 * sensor pointer, otherwise we endup with a
+			 * use-after-free error
+			 */
 			ret = PTR_ERR(sensor->tzd);
-			of_node_put(child);
-			break;
+
+			devm_kfree(&pdev->dev, sensor);
+
+			/*
+			 * The thermal framework notifies us there is
+			 * no thermal zone description for such a
+			 * sensor id
+			 */	
+			if (ret == -ENODEV)
+				continue;
+
+			dev_err(&pdev->dev, "failed to register thermal zone\n");
+			return ret;
 		}
 
 		if (devm_thermal_add_hwmon_sysfs(sensor->tzd))
 			dev_warn(&pdev->dev, "failed to add hwmon sysfs attributes\n");
 	}
 
-put_node:
-	of_node_put(sensor_np);
-	of_node_put(np);
-
-	return ret;
+	return 0;
 }
 
 static int imx_sc_thermal_remove(struct platform_device *pdev)
@@ -136,8 +132,10 @@ static int imx_sc_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx_sc_sensors[] = { IMX_SC_R_SYSTEM, IMX_SC_R_PMIC_0, -1 };
+
 static const struct of_device_id imx_sc_thermal_table[] = {
-	{ .compatible = "fsl,imx-sc-thermal", },
+	{ .compatible = "fsl,imx-sc-thermal", .data =  imx_sc_sensors },
 	{}
 };
 MODULE_DEVICE_TABLE(of, imx_sc_thermal_table);
-- 
2.34.1

