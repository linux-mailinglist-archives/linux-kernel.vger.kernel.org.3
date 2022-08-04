Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195758A3B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbiHDW4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbiHDWzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:55:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF23C71BEC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:53:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q30so1318567wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=FKX9Z3lu5p9+zkxIPUhM8w/C+z3omPAZDXnCqkhm/HhFv+gh13aDbT05TjJA3ILAbk
         ZOFjwZyB4Y5xrz5OKqNYQFIIA6F7zmwDh1bIyHOVcbEYOSyd52vjA6leaJ9fsYXafaQ/
         XOYlTZuAGiACFmVbrLcSq8Bjz/kB5+1YOg+YbG27XJv0phaWr5J6UtyKz94hHIjEtclY
         KziHlXU0EivRamGugK/H48E9H4aEFsmbSZGWBi2cwYJECDcO7zwOu1pjxUIsB0GrdCO5
         aoI7kqavYh6mtfC216jlPD5IZR6Ve6go9A3xpozyplhzO17cEat57RAMfjMzwiJQ97UQ
         GWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=tbjv7FRbhESLwromDU1okCYAO5hQeHjJ26VxgXJTUwFoG5OdJvhiQuw/3o6uUi3p2F
         +zTt1++eGsJzI2wvNoyNWEYvtPA2YEBbpVcxzX/SzX1Q8HI389fR34lzd1PTDS5OFbuI
         5xHjAuRjYakZKtDcrDkWuQ+QZV5/91YIp6gof8OZjzqTDgiJGB6rKYF8Umgg1xAeYRK/
         8TzfoRuIwpuwIcbP6FMfY+0ML5hZMJ3o8lPXhoYpdQFvHiO77i7c6JB844iUG2AOxuuo
         jsFzA+AuarXqZLGHUfrMgdRptWTKrY/eqCoQ6kHUR675GV4PdGwJJuAsTqx8zFLykl/V
         Y6yw==
X-Gm-Message-State: ACgBeo02izBwrVerP5W1IPLyWoqDa+wlGy0TMhrGrT9/JBDigJHUfvvg
        FJO4bkxpDrtiCSZZaEGWmz2ZKg==
X-Google-Smtp-Source: AA6agR7ho7QImhaAw1LcxS3fxp/Cg3TdgRBKRAy6d/Xa2F8/R1HTHGhUfKjZTQ9Ff/1SdIr/2zoEwQ==
X-Received: by 2002:adf:fc47:0:b0:220:5f01:6a10 with SMTP id e7-20020adffc47000000b002205f016a10mr2653829wrs.7.1659653591566;
        Thu, 04 Aug 2022 15:53:11 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:53:11 -0700 (PDT)
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
Subject: [PATCH v5 32/33] thermal/core: Move set_trip_temp ops to the sysfs code
Date:   Fri,  5 Aug 2022 00:43:48 +0200
Message-Id: <20220804224349.1926752-33-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
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

Given the trip points can be set in the thermal zone structure, there
is no need of a specific OF function to do that. Move the code in the
place where it is generic, in the sysfs set_trip_temp storing
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c    | 23 -----------------------
 drivers/thermal/thermal_sysfs.c |  5 ++++-
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 07bde07ddc04..403064fed438 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -288,28 +288,6 @@ static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
 	return 0;
 }
 
-static int of_thermal_set_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int temp)
-{
-	struct __thermal_zone *data = tz->devdata;
-
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	if (data->ops && data->ops->set_trip_temp) {
-		int ret;
-
-		ret = data->ops->set_trip_temp(data->sensor_data, trip, temp);
-		if (ret)
-			return ret;
-	}
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].temperature = temp;
-
-	return 0;
-}
-
 static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int *hyst)
 {
@@ -350,7 +328,6 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 static struct thermal_zone_device_ops of_thermal_ops = {
 	.get_trip_type = of_thermal_get_trip_type,
 	.get_trip_temp = of_thermal_get_trip_temp,
-	.set_trip_temp = of_thermal_set_trip_temp,
 	.get_trip_hyst = of_thermal_get_trip_hyst,
 	.set_trip_hyst = of_thermal_set_trip_hyst,
 	.get_crit_temp = of_thermal_get_crit_temp,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5018459e8dd9..3c513561d346 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,7 +115,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
 
-	if (!tz->ops->set_trip_temp)
+	if (!tz->ops->set_trip_temp && !tz->trips)
 		return -EPERM;
 
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
@@ -128,6 +128,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (tz->trips)
+		tz->trips[trip].temperature = temperature;
+
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-- 
2.25.1

