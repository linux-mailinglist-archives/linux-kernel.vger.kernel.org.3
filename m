Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE16597A18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiHQXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiHQXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:15:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116ECABD58
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:15:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so95263wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FAp+0S/t7YU8InMU47zEYoFV6slTO7PsovSrf3VShbY=;
        b=vmxd23h3CgHfjk4V5JZvUsKDnOZgufjfND0t2o1KBZQr6d+y886Y+C08IiNDrFuV0W
         Km4dAalac3EbtT/Ww+DoRLF++YozVKJSvSuDfoBpcybyfbJYWLkxlr9QYhwPooUS8IqU
         HwbcUnHQPvTKoaRE6mpEiMxsCYOm7F8gQoKkgduJMFDAx6BG/O+GHOKUPxCMyuzdME8l
         oI6o1lqGDXvLozrxWjEyL06biH4NMHr+SbtvdBRYJH7vnLm8bv88ehTQU3loxw0Q/Nsi
         K+097RW10XExwWNTs2OucjPVk1J9AJ1g2DFjhY/QDCm8vPvJd1lrJHRMyBCoN2+2rqum
         b+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FAp+0S/t7YU8InMU47zEYoFV6slTO7PsovSrf3VShbY=;
        b=VzFRsZAaQiXquP0RtUF70AoUnccVoqUXplxOi2XsBk1b+cxOrHtfUHCU+XqNodcXn6
         o88RnkyXAbR1Dp7LMZGOeo+qtUWcFRXa2tY0Atn1ZJk3ZaSDLDqmrpIx218PWjf4qiNl
         pY/Zlreilvfb0eLjHuhW1YXr0X1s+agZ1mJrCJwUHEYAXlBFXyz0iGWzmJN9GrrAwQQv
         pgfdFi/tIZ3HEA/JquDm260TuRV5Ha8WqxSb+BGezJLVq5TvlCh6KM0iiJzX+3eRq1Ka
         4qE4zos28Zbt7IvGRcR4to3jx1NioNpw9cY+hdRPF92ZVz8ylaxcNqLpU7fnurS+3ksn
         43vw==
X-Gm-Message-State: ACgBeo3sBL8R4uVi41A3SiOVr0mD0NUV7gX5Hz/3C7P6pGCa/FviKTHV
        mpeiFVroQdTeDu4+Wng2p/9ivw==
X-Google-Smtp-Source: AA6agR51Q7GBXsRdO47Gle1+xrKCXRwcqVH25hN6raTnvfs7hipfhpD/aA5uTx9JDC+wKqEGl9nNcg==
X-Received: by 2002:a1c:3b56:0:b0:3a5:b699:3d5a with SMTP id i83-20020a1c3b56000000b003a5b6993d5amr170670wma.45.1660778149529;
        Wed, 17 Aug 2022 16:15:49 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003a5ad7f6de2sm137216wms.15.2022.08.17.16.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:15:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] thermal/of: Remove the thermal_zone_of_get_sensor_id() function
Date:   Thu, 18 Aug 2022 01:15:33 +0200
Message-Id: <20220817231533.2639806-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817231533.2639806-1-daniel.lezcano@linaro.org>
References: <20220817231533.2639806-1-daniel.lezcano@linaro.org>
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

The function thermal_zone_of_get_sensor_id() is no longer used
anywhere, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 44 ------------------------------------
 include/linux/thermal.h      | 10 --------
 2 files changed, 54 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fd2fb84bf246..d4b6335ace15 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -130,50 +130,6 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 	return -EINVAL;
 }
 
-/**
- * thermal_zone_of_get_sensor_id - get sensor ID from a DT thermal zone
- * @tz_np: a valid thermal zone device node.
- * @sensor_np: a sensor node of a valid sensor device.
- * @id: the sensor ID returned if success.
- *
- * This function will get sensor ID from a given thermal zone node and
- * the sensor node must match the temperature provider @sensor_np.
- *
- * Return: 0 on success, proper error code otherwise.
- */
-
-int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-				  struct device_node *sensor_np,
-				  u32 *id)
-{
-	struct of_phandle_args sensor_specs;
-	int ret;
-
-	ret = of_parse_phandle_with_args(tz_np,
-					 "thermal-sensors",
-					 "#thermal-sensor-cells",
-					 0,
-					 &sensor_specs);
-	if (ret)
-		return ret;
-
-	if (sensor_specs.np != sensor_np) {
-		of_node_put(sensor_specs.np);
-		return -ENODEV;
-	}
-
-	if (sensor_specs.args_count > 1)
-		pr_warn("%pOFn: too many cells in sensor specifier %d\n",
-		     sensor_specs.np, sensor_specs.args_count);
-
-	*id = sensor_specs.args_count ? sensor_specs.args[0] : 0;
-
-	of_node_put(sensor_specs.np);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_of_get_sensor_id);
-
 /***   functions parsing device tree nodes   ***/
 
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 86c24ddd5985..a5a18351a898 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -310,9 +310,6 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 
 void thermal_of_zone_unregister(struct thermal_zone_device *tz);
 
-int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-				  struct device_node *sensor_np,
-				  u32 *id);
 #else
 static inline
 struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
@@ -336,13 +333,6 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 						   struct thermal_zone_device *tz)
 {
 }
-
-static inline int thermal_zone_of_get_sensor_id(struct device_node *tz_np,
-						struct device_node *sensor_np,
-						u32 *id)
-{
-	return -ENOENT;
-}
 #endif
 
 #ifdef CONFIG_THERMAL
-- 
2.34.1

