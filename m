Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245575834A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiG0VE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiG0VEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:04:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5C5FAC2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bn9so15199451wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKzLkry3f0ucVVy+WiLh8Z5rguSF04AWiaZnad/6qXc=;
        b=V5EiUEXx+rxpD2x7dAlpQFzhtferQJNMlWB6V64J5f3Dn3ix0VTiZwll+sc1KHWHfs
         smaJvoVWQdKlSteR5Heu4rJADIN+izyadU8+UL4ZHKIrJMXpcek7GoaVrXY208ahymrP
         zC8UErc8SgjfDWh3uyOBf8ZyC2fY1LlgEI5giCoFrHekdJmjIKAlzFcKFPMOda6G3S9f
         76MAc+h5/oQh927jVn3UaxGywfc8E4MDD5RI7Z/2xyhgTo1xNem901QIGjTiYfdPWU9H
         /ajFfZN5qgQ+mFCWai4yFBe+zIAocZZnvC6lK25eP724Ny5Ria7SK+V99cYGSF8XWU+C
         oEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKzLkry3f0ucVVy+WiLh8Z5rguSF04AWiaZnad/6qXc=;
        b=OjQfcc2jZPljPbluWoKIu2kYfPNdFW/wjgRhUUmF3QxCUIZrFt9HMGOkovxWqpDC/6
         9VMFeZFgTKRsyeHT0qxO39rq4AJ5x+C9zK7YAz63MWbDuOAjUFJKBpu9NYpJCOty9fa8
         /P9XLVCyErdMD9MnrJCCOI1hUiS+R8mf4diBuD3jgUl+RVZpVjtPELS2vmnE87vFx5/k
         ddfWI9hitwbVbL8GZ/XoNgwvx7w3pvAxMELifUjnak9E4BFDlKH/s2xRsELfYX5QU3Vx
         2oduFfcYktzTgwwQERAFAzYp48LlT1AygnxCIke6XjwFYKtQURFTW2kAPPws1bOekP99
         9tIg==
X-Gm-Message-State: AJIora9WUitHMrDpMc00UCxpAAVG1fqqoBMlfPNkuYSg25wV5JeFw+TE
        zcQ9orWzGx2yEa0EaVPvQiJM5Q==
X-Google-Smtp-Source: AGRyM1tUfFlw70NDpaN3IZj4drYng/Z0H7he3Le/1luvz5CtsdfxryffiI5+cwmcPKTDthRRMEUwtw==
X-Received: by 2002:a5d:43c3:0:b0:21e:b9ec:1d9f with SMTP id v3-20020a5d43c3000000b0021eb9ec1d9fmr5108516wrr.89.1658955840505;
        Wed, 27 Jul 2022 14:04:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:00 -0700 (PDT)
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
Subject: [PATCH v3 21/32] thermal/drivers/banggap: Switch to new of API
Date:   Wed, 27 Jul 2022 23:02:42 +0200
Message-Id: <20220727210253.3794069-22-daniel.lezcano@linexp.org>
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
 drivers/thermal/k3_bandgap.c       | 12 ++++++------
 drivers/thermal/k3_j72xx_bandgap.c | 12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/k3_bandgap.c b/drivers/thermal/k3_bandgap.c
index 5d0b3ffc6f46..22c9bcb899c3 100644
--- a/drivers/thermal/k3_bandgap.c
+++ b/drivers/thermal/k3_bandgap.c
@@ -139,9 +139,9 @@ static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 	return 0;
 }
 
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -151,7 +151,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -213,9 +213,9 @@ static int k3_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->base + data[id].ctrl_offset);
 
 		data[id].tzd =
-		devm_thermal_zone_of_sensor_register(dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		devm_thermal_of_zone_register(dev, id,
+					      &data[id],
+					      &k3_of_thermal_ops);
 		if (IS_ERR(data[id].tzd)) {
 			dev_err(dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(data[id].tzd);
diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 115a44eb4fbf..16b6bcf1bf4f 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -247,9 +247,9 @@ static inline int k3_bgp_read_temp(struct k3_thermal_data *devdata,
 }
 
 /* Get temperature callback function for thermal zone */
-static int k3_thermal_get_temp(void *devdata, int *temp)
+static int k3_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct k3_thermal_data *data = devdata;
+	struct k3_thermal_data *data = tz->devdata;
 	int ret = 0;
 
 	ret = k3_bgp_read_temp(data, temp);
@@ -259,7 +259,7 @@ static int k3_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
+static const struct thermal_zone_device_ops k3_of_thermal_ops = {
 	.get_temp = k3_thermal_get_temp,
 };
 
@@ -474,10 +474,8 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		writel(val, data[id].bgp->cfg2_base + data[id].ctrl_offset);
 
 		bgp->ts_data[id] = &data[id];
-		ti_thermal =
-		devm_thermal_zone_of_sensor_register(bgp->dev, id,
-						     &data[id],
-						     &k3_of_thermal_ops);
+		ti_thermal = devm_thermal_of_zone_register(bgp->dev, id, &data[id],
+							   &k3_of_thermal_ops);
 		if (IS_ERR(ti_thermal)) {
 			dev_err(bgp->dev, "thermal zone device is NULL\n");
 			ret = PTR_ERR(ti_thermal);
-- 
2.25.1

