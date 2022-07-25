Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1215806B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiGYV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiGYV2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:28:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1B9252B4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso7087354wmm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=wAqIxUamNgGfpXlAtv5dRL3vUzGyBJmyD2ekYHrdDe8vQTZ/ycyXgh882FiO+8X5xh
         9rfkhRLXg0mb7GqSGcNY1W7GdCLS8uNloydV6P0oUp0sjyxtYJTlAYkEHNKQIuAsB+He
         8lF3OcbuLRLQHqPRgZ7gADkIOAPHmuDuPARzJSylftVm7ZM1IgS74UB+Un5KRHhZ3v0V
         cB1xOICwt+Vvwy1ZXGUBw2fxXy0xr/qT+m2pc3f5nhPtT3suqe2PVfOtCng/j7YSTtqs
         Y28PjSzufx88vVPjnchNtaso0n2S5pcXwxlyjwrwX4K3n1123qPqLkUmTYrmGMfBqmJG
         bgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQwrODMneSzL3hNZushZmArM7t54Sdd+4j1p+OO3JS8=;
        b=dm49wYF3+0IxxCENQBqQ24PGvHXDmaa7oLkw3xrc/y/xwDIpiOWxlTwtFi7Qi9ox/V
         vWoxr0Xt60EJ55sQLRz9IdCAbXdPQ4Hbj2jEAFwLNcGg5ZNcezM3iGkVr+0y8kJuwr9Y
         8sf+r7JgrPQeCD06s/WA0j/DWuCvXCGUA/YX34rD7hXzSxKGqRwD3WEUdYMqXFGWipAm
         dLguRMnWqvkizZtI0D1WmKScoRgT8AZUQ0eV9Ndibi8v8vTam3f5yuTRQXgNNRmiZZgp
         8yRDbHV8GoqVip/lDs1uEpFxp0bSsonaoXefeQFjPnwvT8ZF7p8UMTmq/wcf8MLHCFdb
         aRjw==
X-Gm-Message-State: AJIora8oAwqBhDRP9Oc52Nz4AY8m3iyYBhbkpibnzae3DFqnK5MYirw/
        z8YZHPBgnLWYynHBgspGk3F6sA==
X-Google-Smtp-Source: AGRyM1tbvETSoIRv7uuZ9n4quQqOkazqYwKqHrQODDUEp+EUyJvLC5o19BvGxgtpTnCBj1LhJX76jg==
X-Received: by 2002:a05:600c:1552:b0:3a3:2e4c:bd0a with SMTP id f18-20020a05600c155200b003a32e4cbd0amr18447864wmg.82.1658784472932;
        Mon, 25 Jul 2022 14:27:52 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:27:52 -0700 (PDT)
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
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH v2 24/32] thermal/drivers/ti-soc: Switch to new of API
Date:   Mon, 25 Jul 2022 23:26:29 +0200
Message-Id: <20220725212637.2818207-25-daniel.lezcano@linexp.org>
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
 .../thermal/ti-soc-thermal/ti-thermal-common.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 703039d8b937..8a9055bd376e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -65,10 +65,10 @@ static inline int ti_thermal_hotspot_temperature(int t, int s, int c)
 
 /* thermal zone ops */
 /* Get temperature callback function for thermal zone */
-static inline int __ti_thermal_get_temp(void *devdata, int *temp)
+static inline int __ti_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct thermal_zone_device *pcb_tz = NULL;
-	struct ti_thermal_data *data = devdata;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	const struct ti_temp_sensor *s;
 	int ret, tmp, slope, constant;
@@ -85,8 +85,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = thermal_zone_get_slope(data->ti_thermal);
-	constant = thermal_zone_get_offset(data->ti_thermal);
+	slope = thermal_zone_get_slope(tz);
+	constant = thermal_zone_get_offset(tz);
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
@@ -107,9 +107,9 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
 {
-	struct ti_thermal_data *data = p;
+	struct ti_thermal_data *data = tz->devdata;
 	struct ti_bandgap *bgp;
 	int id, tr, ret = 0;
 
@@ -130,7 +130,7 @@ static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops ti_of_thermal_ops = {
+static const struct thermal_zone_device_ops ti_of_thermal_ops = {
 	.get_temp = __ti_thermal_get_temp,
 	.get_trend = __ti_thermal_get_trend,
 };
@@ -170,7 +170,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return -EINVAL;
 
 	/* in case this is specified by DT */
-	data->ti_thermal = devm_thermal_zone_of_sensor_register(bgp->dev, id,
+	data->ti_thermal = devm_thermal_of_zone_register(bgp->dev, id,
 					data, &ti_of_thermal_ops);
 	if (IS_ERR(data->ti_thermal)) {
 		dev_err(bgp->dev, "thermal zone device is NULL\n");
-- 
2.25.1

