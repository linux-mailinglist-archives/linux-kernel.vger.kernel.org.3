Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574265806C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiGYVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiGYV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:29:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079E255AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so10219379wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuGNOlhxehBBwi2MK8Fh7ISvjbM/JkRb1FziqBsU70Y=;
        b=6GQ+E8elxfE4MzPZK59czfj18rZwiW9YGKN0RvLHawL1j5NftSlP90dbquqKY0Ue13
         CgyraxPfRpFoXyQYgLeMwUDDW+E0f6Ja7YQ5SU4rRuZFS73pKwfVBXnWUuNaKCBqs7C/
         YdRFUNzAQPPcyFBgrQ5XjsTy2bKp1ACEXa3Ry0L66la/hUud6toAMR27Hzuv3uDRMBT4
         fob5UmSisNW/aFN3plnVfD0lt2pqUvcJq8Y/Cc9DKLsPP79qy3iUoA6ZMFDY/6bWVESu
         UWvdrMFeT6NgfPJFt0bOL6/MrxMVAhQs/ybLZ8SkVlWEKZ3cmPm3548ojHKxTWKd6Xiw
         +1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuGNOlhxehBBwi2MK8Fh7ISvjbM/JkRb1FziqBsU70Y=;
        b=k5n+raNnl8NR/S4Q27YzC4NQua5qNBW/GiYuvocstOpq3sxf+lRhjExxwqi0g75sfz
         7AeljM3cYwcPHApNFvQ7rM4bQ+kbow3/UOJROlPfHohyv7eabVDZRIhlZ/IY4B0GyqDh
         jjBBIEUPc8Rt9TgQu98DvvyOvicp+9Y+UmtDX3Ubp0urNCAYTkII/b7WT9r38eA6J8PS
         ZEySmIFNt1+RM+AglMTgmMwL/2BBwsjx4o60I6Rhi/g+T9RfmzQFzxE9m0YgG04Ng1cr
         166onL50n36HAUHPJdFkjF3USblCqGHR1+KTDLx90QjnKmhbI4IhjXuqSQbgwlOxOcP8
         Ir8A==
X-Gm-Message-State: AJIora8xczbcbZCSp95ZhIQsYNNRhnRZvUjHDVf6PCqgNS++OsWV6lCc
        esZ2RgM/X2f2eF9CHGVQZUz8IQ==
X-Google-Smtp-Source: AGRyM1v3Zxeg9nAMbSG/6KtM1U5vZi1hSauIM0jGwiJrdyQ1oZWJCkTpkigA35o5Xcxxy6txnWpqdg==
X-Received: by 2002:a7b:ca4a:0:b0:3a3:651f:51d8 with SMTP id m10-20020a7bca4a000000b003a3651f51d8mr3353170wml.102.1658784490592;
        Mon, 25 Jul 2022 14:28:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:28:10 -0700 (PDT)
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
Subject: [PATCH v2 31/32] thermal/core: Move set_trip_temp ops to the sysfs code
Date:   Mon, 25 Jul 2022 23:26:36 +0200
Message-Id: <20220725212637.2818207-32-daniel.lezcano@linexp.org>
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
index dbb450a9823c..988470d44fb6 100644
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

