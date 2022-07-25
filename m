Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB13580683
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiGYV1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiGYV05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:26:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B620240B5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so10196185wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fP/YW6lKk1YJJQWc/7vmVyoV6adpF0oqi8olxQPTOI=;
        b=0feYwnXx3S2BBot69kmOpOTZrOsVcBHsOOlpGhAPFhioWbRVeQHiw/hj/JuMtOW/LV
         DwFre0nCZhvE/hFn5q5PLOu9okhYPqsKOU6CAEhCih7dgJSPKU2Ue+mAR1lsqagakOkr
         d++OwpTy0W0iW2VfW7XeTLxJfwBFFTJK8dWPTBFo0Ldiag2euoH79Yyl4iLlgJYW3Gdp
         DZAbZkHp/WDhpQucou3zO6xIcpVuLglLDwr3Xuf3mVIvoMUvJDLkU0kLe8oH3eMArfJQ
         UqkC73BCw9tFAWNyU5DkrrDdIZQifHXyD/yf18HM6OUPLyAhLvJ0cBU8knK6aasVbEXI
         WQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fP/YW6lKk1YJJQWc/7vmVyoV6adpF0oqi8olxQPTOI=;
        b=LrDUCRWvIGEO+p0SAyaoyzICFEBchP9J6mzwU7lZ1nxMfvxm9333Q2lvL/GnwIDHHq
         rrbalM0JAcPlm1cO43UrxSSkfFytgSxyJ5UiglIzR/EHdsf73PFfd1EoTftkLDXr5j0C
         u59Aw23XadPlQV8D17KsxKv5brRVFYEVcZKhdBXvUGYF4BVx1fOfpZpGIIRfEvE5ouQj
         kNbcueXotynH7dO61DHclo+0uA5Zt/PQMdWA8oi/uwJ868RSFhPbBCJlJ65q9XCY8jdv
         OrGW14oY1hjU7GcXwbW8sDvanwXzSzUeeVDt3TrWgTykdNK0FF0/tkXY8314w8s+c/5i
         /q3w==
X-Gm-Message-State: AJIora/7qkApJhKRZ83wBo+ehdEqbbjtKdfEE/BI1sGJDDeE61adcbfY
        oc2NiKJC729sVQltNDsLz4AUpA==
X-Google-Smtp-Source: AGRyM1vv+NfHkenD1U/kXF1SKD3HXOzTovyjxIVECBK7dlbN40kZjZRJ7zfmTEtYX0kW37/lnxex+g==
X-Received: by 2002:a05:600c:1549:b0:3a3:2aa2:6f60 with SMTP id f9-20020a05600c154900b003a32aa26f60mr9660502wmg.57.1658784414975;
        Mon, 25 Jul 2022 14:26:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm12668772wrv.94.2022.07.25.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:26:54 -0700 (PDT)
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
Subject: [PATCH v2 02/32] thermal/of: Make new code and old code co-exist
Date:   Mon, 25 Jul 2022 23:26:07 +0200
Message-Id: <20220725212637.2818207-3-daniel.lezcano@linexp.org>
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

This transient change allows to use old and new OF together until all
the drivers are converted to use the new OF API.

This will go away when the old OF code will be removed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_core.c |  6 ------
 drivers/thermal/thermal_of.c   | 13 +++++++++++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0d9e9b175f93..a4783ab7eabd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1495,10 +1495,6 @@ static int __init thermal_init(void)
 	if (result)
 		goto unregister_governors;
 
-	result = of_parse_thermal_zones();
-	if (result)
-		goto unregister_class;
-
 	result = register_pm_notifier(&thermal_pm_nb);
 	if (result)
 		pr_warn("Thermal: Can not register suspend notifier, return %d\n",
@@ -1506,8 +1502,6 @@ static int __init thermal_init(void)
 
 	return 0;
 
-unregister_class:
-	class_unregister(&thermal_class);
 unregister_governors:
 	thermal_unregister_governors();
 error:
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 7e7713c32e89..dbb450a9823c 100644
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

