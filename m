Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C2598007
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbiHRIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiHRIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:23:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7A35AA12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:23:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so537085wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FAp+0S/t7YU8InMU47zEYoFV6slTO7PsovSrf3VShbY=;
        b=UQEOdCXast/aVv2yzUyT3f163CbbsbfK40Fhq89SICeLrnHvr8BQPZACV829x46meB
         gsdIHoVasi+2HlCR6KEbwFc3TecNtZdVow7X9iiBT7CVqLv8wzxvH5Fl+mxpfQUdBd9o
         CAL/u+nPhAJcQjYPc6ImtxKm9dJceW8e62YTqr5pXW71SbxpOdxfAe3KhzMlgwrtthht
         6V+RyQdZSvfETC1BGn6d0CCdzsHueK2juQPpYacViJBBlV0Zpkybyx3jYgLdDBoph54X
         X5qZUlVJ0Vpqtg5CTloy4ChxYE2v2qm/5bSLHP0+6s0PGcNSrGSg+cOCda5w82Vc5W76
         RpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FAp+0S/t7YU8InMU47zEYoFV6slTO7PsovSrf3VShbY=;
        b=qT2o1umU0vHAYiK5klzIsyOaKL9d6sYoAlf8DjjecRtJZ/VN1HZiQm/ehkOfSzD8jY
         VwG9dCzkRV4nrE6ZfzDGLJqu49tZUUZb483y3F8IbUEBR2co8V0xnMPSbgT0oEWiNYy5
         GAzot6awdapcevM5tLes+uo6+ZepMx1xZtG3mV7LRgDQKvlNAepneYsRUmIDqy1eWoBk
         i4Faww/zH8use1no7aNEATYNhBwV0lKswCOAoiXCd3b915E8fDXZCuWjJQTnmNKbOs02
         au83q7TXUM8wP0H2r5rZULXTXGwL/7yP8H7GqHFATiCYzjzYnsCghFvvC8pcrt+m5jeq
         XDsQ==
X-Gm-Message-State: ACgBeo0BuveYiUvzTBzCNt4UBZ9sBvE5l27hr+t394JuhLK55RKirE0D
        BEXH2jRL6g+hg5rqWV9cE2xOKw==
X-Google-Smtp-Source: AA6agR7zY1nXRjjOmclKfrXCmqTPJxgMWrGP9Pw8tJA2JaDaDUWT2uqYEwmhD2A7jnfXF6/dnWTSAw==
X-Received: by 2002:a1c:7703:0:b0:3a5:aefa:68e3 with SMTP id t3-20020a1c7703000000b003a5aefa68e3mr1179966wmi.158.1660811009863;
        Thu, 18 Aug 2022 01:23:29 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p30-20020a1c545e000000b003a500b612fcsm4634005wmi.12.2022.08.18.01.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 01:23:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 2/2] thermal/of: Remove the thermal_zone_of_get_sensor_id() function
Date:   Thu, 18 Aug 2022 10:23:16 +0200
Message-Id: <20220818082316.2717095-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
References: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
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

