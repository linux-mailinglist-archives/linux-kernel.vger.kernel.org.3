Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4358A394
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHDWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240409AbiHDWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:54:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B474375
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:52:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p10so1336115wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=507KINL6A4/AmFndHS1iP7gQvMCv3nao7sFdYMMwu/Q=;
        b=SXwwjHMSFBkV6d3469j+NGk8We34QnvhrAFoCUQy19G/CXiE8tYZi9XqMgsGr+jFyE
         Xelv0ZhLlbiXuGahZu23c1X6O1vdQ6ITYqy8IvtQ/E24plUi803+XJSfWsaQ9w9nAgNZ
         o3Zo5Re3uYnblJhzl2e/gNOmbi08DEjJQvpRg50yZMDPblEi+5mJH5JPd8SsvhRWXoK/
         WDZA8OdIGNiK5ve1+zUq1MyrGFmF5pKr9w/6AdTAYbdc//8sLdAHJjS5VLI37KWzLb/M
         6X3a+fSAwCkyq5qGOCu0TcGWC3SXKqsmUBU+e0oHWEmzENa8hGpbpybU2AnNvQDwQ8q+
         Q2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=507KINL6A4/AmFndHS1iP7gQvMCv3nao7sFdYMMwu/Q=;
        b=daPZDSS13j8RqpenyfEr/hDxYpnlghTAnq96fDvmG5eGNmzaIJQyCamZMO/uhJD+/p
         hR5al4lmL14KwlVb8eI2Gimqk9HW7X/Tb4lFfp/+u8AjuUirniXbAKwjUKcOiEiSyIDm
         wtqFJ1uSpfgnnmS3U49YHtEPF0zlgwSxGmR3m6iYwXe5bxd5KfYSMg0EGI8TlPlyOUDm
         5hczBZr5wduL6lr3RSLzZdPXEyM44SERxaZUbYD8iGC6I83Cmhbjy4RlBEiXVplCnWrS
         WodYPRvRZYe78zOy+BkzMa6qmEMO8rRceGmW3YzqrwC07mEUqA+rmoAtCp9uMWLxKpoc
         32lQ==
X-Gm-Message-State: ACgBeo0wgnicBXAU8OE3NQCOWP1dwvhG+y2BZPXM+BZFNIRvv3sh6N38
        AQmfNFEO1iFzo55ItakQiY+I6g==
X-Google-Smtp-Source: AA6agR5FB/1c0hMGtxm0/d0QPNlvMrEglZyNig5yfbDgVc3THf+62GhkvC52FzxRKY7DlFnXy24cQA==
X-Received: by 2002:a05:6000:1447:b0:21d:b22b:e5d with SMTP id v7-20020a056000144700b0021db22b0e5dmr2442958wrx.189.1659653576746;
        Thu, 04 Aug 2022 15:52:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:52:56 -0700 (PDT)
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
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org (open list:PMBUS HARDWARE MONITORING
        DRIVERS)
Subject: [PATCH v5 26/33] hwmon/drivers/pm_bus: Switch to new of thermal API
Date:   Fri,  5 Aug 2022 00:43:42 +0200
Message-Id: <20220804224349.1926752-27-daniel.lezcano@linexp.org>
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
 drivers/hwmon/pmbus/pmbus_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 02912022853d..3b9bb2123a1a 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1109,9 +1109,9 @@ struct pmbus_thermal_data {
 	struct pmbus_sensor *sensor;
 };
 
-static int pmbus_thermal_get_temp(void *data, int *temp)
+static int pmbus_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct pmbus_thermal_data *tdata = data;
+	struct pmbus_thermal_data *tdata = tz->devdata;
 	struct pmbus_sensor *sensor = tdata->sensor;
 	struct pmbus_data *pmbus_data = tdata->pmbus_data;
 	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
@@ -1135,7 +1135,7 @@ static int pmbus_thermal_get_temp(void *data, int *temp)
 	return ret;
 }
 
-static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
+static const struct thermal_zone_device_ops pmbus_thermal_ops = {
 	.get_temp = pmbus_thermal_get_temp,
 };
 
@@ -1153,8 +1153,8 @@ static int pmbus_thermal_add_sensor(struct pmbus_data *pmbus_data,
 	tdata->sensor = sensor;
 	tdata->pmbus_data = pmbus_data;
 
-	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
-						   &pmbus_thermal_ops);
+	tzd = devm_thermal_of_zone_register(dev, index, tdata,
+					    &pmbus_thermal_ops);
 	/*
 	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
 	 * so ignore that error but forward any other error.
-- 
2.25.1

