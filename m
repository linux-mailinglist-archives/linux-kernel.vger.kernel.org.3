Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F2583467
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiG0VDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiG0VDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:03:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883FD564F0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so105552wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=cHJX9NulUsGgEM2gMHXyXKcFfgolcnmFk6zGeoNStwoyy/mkxOz1V4vom+fRK8YsrT
         EvXNippjV1OfcY1oRAvwrNUQ8ccU6n6V13PDNgh03EGTxbXyAem3Cdamg2npCh9FZXwe
         0c29yQRuVinmoUCum2/xP3wvCDfTDGvYJYg4jIsT+08fYCONOa67OKtCQcXL8+uObiGl
         A928kAzz7hbeiPu4Ho7pS01L570R3MhIG9pYKSiz/wR4mf9gwM7yUyVT86MMjiQeROGr
         VuSUHRxW/oDljqg1nvakxBXYIXxhY/+4R+JDbwCJwJYTvOJ8TO+DRVm4+ZsGjKbWgR7C
         HQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=tOw4xX5c/LZW0/NCD3fllRFqqRLbnV3S3cnBD1+p8yRW/w5REJ00DXZvPJ8rlgG2Sf
         RgfbNWDamnJR56Gv77QswYqwFkqDmD9kWiYTBdacLY/QwTOWZaoBLfQbmxLa5Al0mbht
         MSlO6FKWGjHMsKqxjsRwnosV6xbQ2HH1pFlr8QT9I0zyd9keJuPOkQCHGvhBE/G+2aS7
         SKBHCYwosBnCCM87I3wQQrNsSnMAX5BkQSl+dseykrrsdKpb1Gv+NPV3UNsTPsvumLWO
         uUQ0bik1CvKwBIJB1Bm4Opj65c+Km5Fp5e3ObiphYEh1jzDM5oNB35UCo1nau8wLU5fP
         LyNQ==
X-Gm-Message-State: AJIora8yNQl5TuJiLHtV038fW+x2/kdQPpwFX2PmqXbfVba763K/ct+Z
        5IrWB5svuFJ1+AePKIWWE5Ouyg==
X-Google-Smtp-Source: AGRyM1sfeugTWdTLOwXeEVfyRk80X5ig0zBKpcbdt657ZHuniCLzSQrxHsR1pQ4QYmSGCXchSTrJVA==
X-Received: by 2002:a05:600c:1c19:b0:3a3:181e:89e with SMTP id j25-20020a05600c1c1900b003a3181e089emr4280546wms.203.1658955788014;
        Wed, 27 Jul 2022 14:03:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c350600b003a38606385esm37908wmq.3.2022.07.27.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 14:03:07 -0700 (PDT)
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
Subject: [PATCH v3 02/32] thermal/of: Make new code and old code co-exist
Date:   Wed, 27 Jul 2022 23:02:23 +0200
Message-Id: <20220727210253.3794069-3-daniel.lezcano@linexp.org>
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

