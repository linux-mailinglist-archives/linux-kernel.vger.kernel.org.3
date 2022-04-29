Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAC514A61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359756AbiD2NXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359753AbiD2NXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3EB6478;
        Fri, 29 Apr 2022 06:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54B4FB833F7;
        Fri, 29 Apr 2022 13:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45B0C385A4;
        Fri, 29 Apr 2022 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651238423;
        bh=rHVYr57dbOsqQzVGO8ZUi+05f97hAqo5rq0GSWs8oNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFon7tQHLarg5gre2seT0mH3cSWZoXUXwW0QTQ+oDGO+HBypTAl7c675rnYZ0/kZt
         VvXR6Yy4P9islJsz6yqTN9wqXIasqjWT7qL2Co9nCrCqPBOfFZUW+2T9SKdPRU/Ht4
         yFX+gDj6Y3xndZcMikWHkksAvwZQxZv5S13qMh8Pna/Tn/WqSV2scd4efTL6to0Xgj
         r2eczmfvtNm8+OBpxL6dSGcTCq1ApnPCd/FSmV58SSxDlgR7/jYtnlSkuDuEqf8nPM
         qKIezZetKwLoIxjRPh3dhnB7bJIu8FnUqE7Vtxh+kjSLGah99+XzR+cl/SZNAEFCII
         2a6hyHtdmn3dA==
Received: by pali.im (Postfix)
        id 4D5CCCAF; Fri, 29 Apr 2022 15:20:21 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO
Date:   Fri, 29 Apr 2022 15:13:49 +0200
Message-Id: <20220429131349.21229-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220429131349.21229-1-pali@kernel.org>
References: <20220429131349.21229-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards is WDI logic of max6370 chip connected via GPIO.
So extend max63xx_wdt driver to allow specifying WDI logic via GPIO.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v2:
* Usage of dev_err_probe()
* Fixing assignment of wdt->ping
* Remove clearing of wdt->gpio_wdi
* Move YAML change to separate patch
---
 drivers/watchdog/max63xx_wdt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e1541cfae0d..6e43f9e6d7eb 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/property.h>
+#include <linux/gpio/consumer.h>
 
 #define DEFAULT_HEARTBEAT 60
 #define MAX_HEARTBEAT     60
@@ -53,6 +54,9 @@ struct max63xx_wdt {
 	void __iomem *base;
 	spinlock_t lock;
 
+	/* GPIOs */
+	struct gpio_desc *gpio_wdi;
+
 	/* WDI and WSET bits write access routines */
 	void (*ping)(struct max63xx_wdt *wdt);
 	void (*set)(struct max63xx_wdt *wdt, u8 set);
@@ -158,6 +162,17 @@ static const struct watchdog_info max63xx_wdt_info = {
 	.identity = "max63xx Watchdog",
 };
 
+static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
+{
+	spin_lock(&wdt->lock);
+
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
+	udelay(1);
+	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
+
+	spin_unlock(&wdt->lock);
+}
+
 static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
 {
 	u8 val;
@@ -225,10 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
+	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT)
+		return dev_err_probe(dev, PTR_ERR(wdt->gpio_wdi),
+				     "unable to request gpio: %ld\n",
+				     PTR_ERR(wdt->gpio_wdi));
+
 	err = max63xx_mmap_init(pdev, wdt);
 	if (err)
 		return err;
 
+	if (!IS_ERR(wdt->gpio_wdi))
+		wdt->ping = max63xx_gpio_ping;
+
 	platform_set_drvdata(pdev, &wdt->wdd);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
-- 
2.20.1

