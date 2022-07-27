Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DC5834A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiG0VG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbiG0VFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:05:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C97A61B13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v13so18301446wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=Nn4DbpxPaQKZRIZBoIdp7blR84wd/J1xKB+gsPyzkNCoispCTW6iDyPssreTDkjx+N
         53s+zMgLY8nUfYIaQ16kdrxrymRvWZlb6J8josfOA7Z7kgrvXkruBlW6JXMRrwuhOlr8
         7cYe8UVUXsfNGWMIQm2/PKj3KHISrxd1PQmfMl//3S8auCgPwb+h5WPMa+MdYo/T4rux
         04rlphfLcXBea8nGzub+p+aunnDbrGlTTXchJM2Hz8NSM2jb8QB3ionr4Kx5AxL94a9R
         PGAGylarQLQ2inGBoFnJ8zxsKF6n6a4uSWXB10LS1RjjFvU3tG65CBkJ3o5tg9JmlCfC
         WSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NA8ooyNHoaigd+w7aJNo47HL4zS61/xJOAD4qh1CGLU=;
        b=h5NzjYOK92DrJZHBFe5211pGGBLn2JSq920TplQLc84pfKbhH1Sh4gk9qAbfRRlIo6
         d1m0GpuuDivdnxBqYdcTJAK7YubtTzWUM7We3WCVOoGpaiAvbDTRkFuYsbYEASqpvbAb
         QVOFezKxEwAfLSLoRfKwTWooeyHkVKIjoxTGMHRf9uADWEkAfj5yN+VBDjeKeCjjrE1Q
         krEZfNzPnz1b1bjQ+ji6XfuMyIJRtSdV5HO53d16hizKs0XtXEACQqjifJPOHVt2hHAs
         QkC7hLxGk+KVsqhZcgZmLI+b9weHvWn71K1I2u0927J5xeEAJzvbIpGJLqNtvyAqupQ7
         52ag==
X-Gm-Message-State: AJIora/VviDR2zKhvRPfOk6PKGyU3I4XHbpOlFTTAoK4jRrQQKzibMWN
        RDvNcfa0xCGyjaCs7SIzulHO0w==
X-Google-Smtp-Source: AGRyM1sKohM2nCiXC7Bbzx/UqVwJJuMirKOGWmzxCdKyRMyTX7rtCRaP7yhMjKeMgvsfKG3A+o5ELA==
X-Received: by 2002:a5d:4811:0:b0:21e:3d86:a2df with SMTP id l17-20020a5d4811000000b0021e3d86a2dfmr15965520wrq.633.1658955864592;
        Wed, 27 Jul 2022 14:04:24 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:04:24 -0700 (PDT)
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
Subject: [PATCH v3 31/32] thermal/core: Move set_trip_temp ops to the sysfs code
Date:   Wed, 27 Jul 2022 23:02:52 +0200
Message-Id: <20220727210253.3794069-32-daniel.lezcano@linexp.org>
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

