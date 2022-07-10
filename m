Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5F56D163
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGJVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGJVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:24:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266C510548
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so2015967wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPnJAfFnd3wDunU75N6r1WtNSew2hFlVfY0tCu19E2Y=;
        b=LFO9AXb6O5BtHxx4B3bZybckQXVj5Fblc/z1eM9tpN7ttE/Y+4NZ36rPu1yvix+aPF
         Zrff5O8wBjJmNQ2EXX51I/HONyOa1uxQTv5lcO3MqOPZq4yBic4lCmRrJP2RQUbiHkRL
         DwjFUj+HDeV8T0fPxF/OEJRWEV/+Nn94dmTq2FsxnHaxYJvKWqg5yeqDMjmjKZmFXluS
         7fRh6pAeI14jytiRpXCtoUcMxHPS48DCg1GtVMXBzUrD20YIXwCMMum03BnbCiWjl9cS
         TrsZe5QFhZipuyooth+/1s70iT4WZHhsbEaDi/IF7JxTxGY2MyQGMTzAetukdzJoi6AK
         VrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPnJAfFnd3wDunU75N6r1WtNSew2hFlVfY0tCu19E2Y=;
        b=koRSm/qW1xOjn8wKVeHI0jKrYcsr+91fy6S64SLFQ9DD3kn0OGfhLuAsXIZiRE3M0M
         tj+qtR43FH8qmO6TP1/f5DllViDyaZQA2F2OjoSyLv5ykGpoInqeIt0GclYiws3OufYu
         yzoS0GmNUKxV7k7j829ptKB4BxmjlSxvaMgchal7IB1iBAzNkUaDR+qsYYAxdMKEjGsf
         wYUNcStkXX9tSSsO6huB4tpVOnrih+S9+kXoGKD4brIAd7QmkhnoqmHGdWcjWjlkK6jd
         LSVLFdMgCF3c9Dz96DGKEayKE9l/j9xpJx+71rRd2LT6WqT8qoRa+6CAyL7GYN0uISC2
         Glxg==
X-Gm-Message-State: AJIora838PssEdChy6pCxtqGF+NMKH19xOi/T9pDvBBcdCmU4gbOZGrf
        A1rgsCtT/JK9aav9uko1og2zsQ==
X-Google-Smtp-Source: AGRyM1sZxx/vOercXS7JTdWs/lCHIF5gSfc0XtT2aGm8suodLBhBAdSvm+l37u5v38pqT+H2FUkDNQ==
X-Received: by 2002:a1c:f317:0:b0:3a2:df38:9877 with SMTP id q23-20020a1cf317000000b003a2df389877mr11628713wmq.124.1657488277767;
        Sun, 10 Jul 2022 14:24:37 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:24:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 02/33] thermal/of: Make new code and old code co-exist
Date:   Sun, 10 Jul 2022 23:23:52 +0200
Message-Id: <20220710212423.681301-3-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 59e6411fcc23..60ce270f2add 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -485,7 +485,16 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 {
 	struct device_node *np, *child, *sensor_np;
 	struct thermal_zone_device *tzd = ERR_PTR(-ENODEV);
+	static int old_tz_initialized;
+	int ret;
 
+	if (!old_tz_initialized) {
+		ret = of_parse_thermal_zones();
+		if (ret)
+			return ERR_PTR(ret);
+		old_tz_initialized = 1;
+	}
+	
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np)
 		return ERR_PTR(-ENODEV);
@@ -1004,7 +1013,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	return ERR_PTR(ret);
 }
 
-static __init void of_thermal_free_zone(struct __thermal_zone *tz)
+static void of_thermal_free_zone(struct __thermal_zone *tz)
 {
 	struct __thermal_bind_params *tbp;
 	int i, j;
@@ -1509,7 +1518,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
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

