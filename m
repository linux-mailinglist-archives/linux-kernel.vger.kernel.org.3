Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95C058730D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiHAVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiHAVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:23:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CB20F42
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:23:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so15633194wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=DSg9i6mi1zRr8tIRG7LEHdGdQwieI26wdZrfDfg/1DuVXKlY62FbvIEl74Ef1pQP/R
         A8xDFed3mSVX4jXtCxwBNmtCtekcptX44lrj7NvuNVApnHTiljWYt4oxaxW1XrnasHMD
         SK0bTKx5g62w+cZqZ/1mFkbLOQOY/Zeokv9fuUxh7qwVnuiWKaWU+WlrRQ361WHpnewe
         ruh3FKvm0uffM7PGCdrgAVAZgzoKevbw9/8xuyzGMcBAsIcWKUYi0EEWHgTGvL8dlt01
         AEGldD8R4ZdjkXBc1wInoJ9Gq343M9rhPlZQ0fMY7mTXU0fNpIa5kQzlNv/SuN9BMsgr
         6QlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qj/girp3QZIjTVT0mlN9J9xZSF+SZjyq2BVb0HmFUYI=;
        b=x7S4cHgnrYJMMTEo2ghwqbf6zVPeBKXYVsg5esxPvJ3N4zb6oAz7WqDu/r+zRpyiLt
         RohisdkGxBfwg2DhA9xpgmBnfuYJHFQvf27CuUuVvyfzBXA1YyRaZTWkX24xd1456LuJ
         Ozq0PDegPRyKP3gPuzlpSBLMhK/+g8pt1p7fYvbUwuYkMPEWig3SrLGWrxQUmvdc9nOa
         8DG6bLMugFhl7xdUnP/E5PEUL9CmP8kMeBequT/+R7ZvkZ/RhWmuEgc6cMbJRv+B8kzx
         cceppA0EVZnrAkoSsiezXx/y8D39Cc/1GNVSpQUoOcmpnkTkhL3/Jl5vFLRR+vraRLI/
         bNlQ==
X-Gm-Message-State: ACgBeo1zoIhL8vI4ttvigRoRjWgoBhnYcyGIPfch6dVxfVt5cNU/+/pM
        yc0KrcXiK5GJPwNSMBm88nLmVg==
X-Google-Smtp-Source: AA6agR48tog/N0tkWnunwUySFyoIzXs+JMlRIRYJRtizXUQTaNsC/FAlokmAELNVwlXKs9Jv+JpehA==
X-Received: by 2002:a5d:464c:0:b0:220:26a8:d2f2 with SMTP id j12-20020a5d464c000000b0022026a8d2f2mr7436189wrs.309.1659388984152;
        Mon, 01 Aug 2022 14:23:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d00:ceb8:9c09:1302])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12995285wrr.67.2022.08.01.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:23:03 -0700 (PDT)
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
Subject: [PATCH v4 02/32] thermal/of: Make new code and old code co-exist
Date:   Mon,  1 Aug 2022 23:22:14 +0200
Message-Id: <20220801212244.1124867-3-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org>
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

