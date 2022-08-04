Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006D58A36E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHDWwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiHDWv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:51:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB513C8D4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:51:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so3168944wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=gDrKK+ABb++UEN5IohDsJzyGk+rDGu+3S5fXSEpKqR8svo0vm9z9XqRCMQDd1DQ/li
         NvevuLYuXv0pKqtTfpGmLagFbHrDED0K77NPeSqhiSZNZUaJPOuugLvc3iKTDtGDul6M
         pmRXtBfeJTa6OlV0eiZEum+kxEJ8rgk2XIXU9owLnTUiWI9cqzUSWJljhGs5eFLnL4BR
         NLcmd1wWvc/iOn6OpEa7yUWvkKSc+T16K7d19Nab+25GgCGLd7kI1xmoZqoX5MX/udhs
         BNxbA6wMuql7rovDGUx64AmeIokgGX09MKj6pJRgxhPmaGgAO32WLgRM2ypPLUum3d8v
         E+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=7Ra7nlu44xXU9AJ8YuJcVWeMePVU9jfGReNwDlIWHTL319hfpPZC/gvUAH3WXr9m+7
         jUXql1wCq/PitkxzCnR7rMWqMeZpvk1xLvZV+IR6xuc7AuMuEwQQf3RG0+KcHVy6cu8K
         6MEqW6YYiOZDPEeP2TMhozxn4P9OcL12v6SnC2RfFmBDE51glWaFKKOJfK19OUgVHv3P
         pGMnxg8bwFUPJ+l5tjSiyIoLyeh7GJ9Sogvma8zSdlk/Qh7kmjW9HgFEfmlTzDQTSYX/
         lgI4kbw4E4E5orwzhZstRRLUZmf4t74smk99OZIiovLZgKFgz1yJ6eKfvni8J9T2+Ydm
         Qy5A==
X-Gm-Message-State: ACgBeo0gli7DWmlmvc4P7OmihyjhOdgOq8yBAM/de9+WDqfG4C+E1sfE
        aOUqFysZk9Z8S6FvsmLJGb0w9A==
X-Google-Smtp-Source: AA6agR4yzg6P2Wq5LquxIwEqYsgiFcBCZCqmZPNRBaz0QKzziuNvGijBJqPtBb0vVxxt3kOwTBbQ0w==
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id i19-20020a05600c355300b003a32b65299emr7295841wmq.145.1659653514941;
        Thu, 04 Aug 2022 15:51:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:31aa:ed2c:3f7:19d])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b0021f87e8945asm2495906wrf.12.2022.08.04.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:51:54 -0700 (PDT)
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
Subject: [PATCH v5 02/33] thermal/of: Make new code and old code co-exist
Date:   Fri,  5 Aug 2022 00:43:18 +0200
Message-Id: <20220804224349.1926752-3-daniel.lezcano@linexp.org>
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

This transient change allows to use old and new OF together until all
the drivers are converted to use the new OF API.

This will go away when the old OF code will be removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c |  6 ------
 drivers/thermal/thermal_of.c   | 13 +++++++++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f50098d33152..b4c68410c158 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1491,10 +1491,6 @@ static int __init thermal_init(void)
 	if (result)
 		goto unregister_governors;
 
-	result = of_parse_thermal_zones();
-	if (result)
-		goto unregister_class;
-
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)
 		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
@@ -1502,8 +1498,6 @@ static int __init thermal_init(void)
 
 	return 0;
 
-unregister_class:
-	class_unregister(&thermal_class);
 unregister_governors:
 	thermal_unregister_governors();
 error:
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4fd06b576aa..07bde07ddc04 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -485,6 +485,15 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 {
 	struct device_node *np, *child, *sensor_np;
 	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
+	static int old_tz_initialized;
+	int ret;
+
+	if (!old_tz_initialized) {
+		ret = of_parse_thermal_zones();
+		if (ret)
+			return ERR_PTR(ret);
+		old_tz_initialized = 1;
+	}
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
@@ -1004,7 +1013,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	return ERR_PTR(ret);
 }
 
-static __init void of_thermal_free_zone(struct __thermal_zone *tz)
+static void of_thermal_free_zone(struct __thermal_zone *tz)
 {
 	struct __thermal_bind_params *tbp;
 	int i, j;
@@ -1517,7 +1526,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
  * Return: 0 on success, proper error code otherwise
  *
  */
-int __init of_parse_thermal_zones(void)
+int of_parse_thermal_zones(void)
 {
 	struct device_node *np, *child;
 	struct __thermal_zone *tz;
-- 
2.25.1

