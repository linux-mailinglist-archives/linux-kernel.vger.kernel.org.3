Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD4597A19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbiHQXPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiHQXPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:15:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA2ABD54
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:15:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso1782863wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=b/4P8tV61EgIGVpYT5PqDxyWk5mmw5Ug4AvquXZ8I1I=;
        b=sLYvUSxTxvkN4moy3D6cbbY1+X0O5s8mJgOA/yM1CzC7QqqkGdIurca/exlpwbQBTn
         mXE9c9OThjIjr3nVPCGM1+NRhayVdNKNzlE4IIP2zcaEVgUdm5Wd2eqOgnDKQkumVdQf
         Yt30oPfgCkh1mkI3l4K7mFppHGeyiA4lnP47Dvg60nZhTB8IJh5+OrudCT41/YOJiNKb
         EdZNtmyBa4l3tzNWRIUUYb6o4kWVUMN31UdeXpSrx03yC0nmB7ilv/Q63w57ausFMU/i
         u04SqhLHSi8IPQbSPowcQ6Dc8MFb9FJR8SMFz+UdxomdGHNT25DSL2uPJWTb/oSDsOKu
         9wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=b/4P8tV61EgIGVpYT5PqDxyWk5mmw5Ug4AvquXZ8I1I=;
        b=gMzjph5CFJz2TMoklvQEHj2SJ6HuUuz80DIvrD4isM70XOyHQQ5ao6mWTFvW+hUwmJ
         feLRZ6P1GGVdKLPoAO/EDW/PDuMKHKbOXPlxUpisH64SdCH0cPiM1st/tlfmw82oYI/P
         o/uUwGkMsAa9JD12jJBkxBwtLcvZLu24eQ0lSPQZ0A2yrZVmKB+Co7BrZdmtP4oSZ72Z
         DmHD+JWQqSn4CbemZgXOuRp3QNPNrypqHvwRrogsfelksQQOKzZBcThFyDYeNe5BgG0m
         zDMH5nYJnvbu9VRy/QEKP4T6PITONj4ZjpWeaBIg/PLjI1B+LX6M5JTJr5t5s7wQh2Af
         pyXA==
X-Gm-Message-State: ACgBeo27Jh2JJtA9msWabdjxL5QTt5dNdMa/84V2M25J/jmBn3nUPhXl
        XxmrXDal+JYeMu0uBBudjhvccQ==
X-Google-Smtp-Source: AA6agR4j6elGVIcaE6QiO4xGHqbTutfNvtnn4E4WjePj71a9Oj/S7DZiz+8u8dBsci/Y2753leDSrQ==
X-Received: by 2002:a05:600c:2311:b0:3a5:af18:75c1 with SMTP id 17-20020a05600c231100b003a5af1875c1mr3389851wmo.90.1660778148345;
        Wed, 17 Aug 2022 16:15:48 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003a5ad7f6de2sm137216wms.15.2022.08.17.16.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:15:47 -0700 (PDT)
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
Subject: [PATCH 1/2] thermal/drivers/imx_sc: Rely on the platform data to get the resource id
Date:   Thu, 18 Aug 2022 01:15:32 +0200
Message-Id: <20220817231533.2639806-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

When a registration fails with -ENODEV this is not an error but a case
where the description is not found in the device tree, that can the
entire thermal zones description or a specific thermal zone with an
unknown id.

Change the code accordingly and remove the OF code from the driver.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
The changes apply on the linux-next branch:

 https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next

I don't have the platform, so I was not able to test the changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_sc_thermal.c | 56 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 10bfa6507eb4..113c04b71df0 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -76,59 +76,41 @@ static const struct thermal_zone_device_ops imx_sc_thermal_ops = {
 
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
-			ret = PTR_ERR(sensor->tzd);
-			of_node_put(child);
-			break;
+			if (PTR_ERR(sensor->tzd) == -ENODEV) {
+				devm_kfree(&pdev->dev, sensor);
+				continue;
+			}
+			return PTR_ERR(sensor->tzd);
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
@@ -136,8 +118,10 @@ static int imx_sc_thermal_remove(struct platform_device *pdev)
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

