Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE3F56D1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGJV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiGJV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 17:26:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08691706F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p4so2077540wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Y41vOcDtdL2yhYCNKjxuRzzCxuMEk7Llli1lwExUdg=;
        b=gRio6k2EfN0lPHxe9XKBa+OWp5nlOVY+HqFctDEILdSwLi5dcpH5D2LWh7Vt1IRY62
         SsLQbXlJDTKw40zNL38akvijSko3+Cpus4a8fKWZQHeJGp4/3mhqwhvAPuEMIPIDnVyT
         B0z5SsSkklUDMi4XIMVCry/gSPTWv60RAIB4L3JPVQ9bK29VkMcdluSppqEavwO4d6Zi
         JlapfbIZDRQoG5gvKGlAnEdpFw5O5w0zDrbcWnr5eHQOwY6XAqUx4adp8ABC3ZoZM7gj
         RJouXsT+TFJuIRkU3Yql4isdaWVcCwbGQ2LG/rExqFbEmGSwKXijKUoF820eTrjCdKAQ
         FEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Y41vOcDtdL2yhYCNKjxuRzzCxuMEk7Llli1lwExUdg=;
        b=3Ypr9jWKNB6zWD0PowEZyQ8kDWB6fS/9jH4tDL1/mV4LkQUiVEgpBPACCRn0C6aSsp
         IzOhSirGZYpheLMqGvOHONtOPW8DtyAA8RpIuEjOSkaV0OQaiNzlIwYujCXwKeAKRxVM
         How8niaRq6oPwIbJu/+lrlyuoSLZpNMSqnycRzI4KbTv+TyDWgTXgHh7tTQVwD0Qjmhl
         91YJukCeTb8hqsDhuNCGOviD2zn995tEFXrt+MvBPOKVtmy0Z7BD+hAhBnTVQPdaCfxN
         D8+mmSMeM0EjL0n5Yz8hTqiE7+ueJ3BPYPJ1SX/8DMjT1487GKILC2B2+lsDcnJf2WeP
         2/9g==
X-Gm-Message-State: AJIora9qEw1L4VujaEv3vMG0VOc1S7Iv6J51QVvHqydoN4aE0rsce+Vr
        E1KFZ/FopSh3IvqAmHneM2GLCw==
X-Google-Smtp-Source: AGRyM1v0f0koxAy5K6IGmhH3p5egstHMC1RkTZGC8vOXm5s6fC2BXAXfbIKulZ9qLa6QN67JLNAj5A==
X-Received: by 2002:a05:600c:206:b0:3a2:e224:da6f with SMTP id 6-20020a05600c020600b003a2e224da6fmr9346363wmi.167.1657488325026;
        Sun, 10 Jul 2022 14:25:25 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v1 30/33] thermal/drivers/bcm2835: Switch to new of thermal API
Date:   Sun, 10 Jul 2022 23:24:20 +0200
Message-Id: <20220710212423.681301-31-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index c8e4344d5a3d..4a7c6270dfac 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -88,9 +88,9 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 	return temp;
 }
 
-static int bcm2835_thermal_get_temp(void *d, int *temp)
+static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct bcm2835_thermal_data *data = d;
+	struct bcm2835_thermal_data *data = tz->devdata;
 	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
 
 	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
@@ -135,7 +135,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
 }
 
-static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
+static struct thermal_zone_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
 };
 
@@ -206,8 +206,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			 data->clk, rate);
 
 	/* register of thermal sensor and get info from DT */
-	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-					     &bcm2835_thermal_ops);
+	tz = devm_thermal_of_zone_register(&pdev->dev, 0, data,
+					   &bcm2835_thermal_ops);
 	if (IS_ERR(tz)) {
 		err = PTR_ERR(tz);
 		dev_err(&pdev->dev,
@@ -277,7 +277,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	return 0;
 err_tz:
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 err_clk:
 	clk_disable_unprepare(data->clk);
 
@@ -290,7 +290,7 @@ static int bcm2835_thermal_remove(struct platform_device *pdev)
 	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+	thermal_of_zone_unregister(tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
-- 
2.25.1

