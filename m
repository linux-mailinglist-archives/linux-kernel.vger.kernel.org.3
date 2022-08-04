Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCF58A3A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiHDWyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiHDWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:53:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066773928
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p8-20020a05600c05c800b003a50311d75cso2691662wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=BnUNUZYLN7ye95mrTNiuuTRdjINFgpZDmCQNh/1OQ+ENDcf7DLutgXECkAisxOizCh
         Fcx1GPr9x9ucUiL1dpmhJSo1m5G+ZHUxOhPWJeDeKoZU4VgCt6lWMK9BSw8f68WEq+E9
         V/JCMmc9L2TbCHxldIBDdywRSdKg5gvABW20mWM6XBaUz2ds0p8MrJPe+BHjjysdrmla
         V8uqRUw7ANKPDuKOMrcnm75alHOjyrtd+Pt6feqr4Ul1emiH9yiXM1eBQo0XuPg1g81D
         lVq+naLM5MDcBXkj0Co1SrcgZ8y6lP8Bq/2hU7VPcXvbtXZDPEMryVxMal4cpZv/Fysy
         ywrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lgLe7sgvzaU3jF4XA+SfoE2vippSYThYf8kMVph3yKg=;
        b=ZMPHpGBwG5TE9A7Jwha4TeDgucoqvXLfQTOcipF55sphJ/CLctrLsu+3R4N88GpJJh
         EsDNk73vGEWfBhwowIym4D+pxGAXi4pbp+L22VQHjQMYZgxGC5rw6CdrOfbh1/Z8oMzr
         gTICzQH1dfD1R8FG8Pc/4BKuPdr07lTgx0oP6O+8v4yTnID/RluO1AdEftJvyGNITH53
         cFhmW2LbD8F2l41bHNj2Dd5deWPn+JG40DIvDnF0qUOn7W1+dkLI9DBgiDm5Svulrz+x
         P3Jk+ObWaSKKuOmc2v+oIV+4SLofqhlwDJWgdfaODfOksIsn2dS8dw19MiKs8KrvdP4b
         tBAw==
X-Gm-Message-State: ACgBeo1NKvSxS541Nmps010sSNheNdf7NUey1HrFmtGySCQZYRTIq2yY
        OkLmE2mNxmcqTWSVjOKZBn0yNw==
X-Google-Smtp-Source: AA6agR5QyPu3uRUeCiCJ42UmZqVJIVRkJlxI0ymgy5gtoBV4l1VoQoknXLstuesOJR/T9yR6ehtu/w==
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id ib6-20020a05600ca14600b003a31e794446mr2795380wmb.158.1659653555553;
        Thu, 04 Aug 2022 15:52:35 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:35 -0700 (PDT)
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
Subject: [PATCH v5 16/33] thermal/drivers/imx: Switch to new of API
Date:   Fri,  5 Aug 2022 00:43:32 +0200
Message-Id: <20220804224349.1926752-17-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

