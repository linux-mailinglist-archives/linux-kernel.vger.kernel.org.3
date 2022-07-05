Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3D566006
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiGEAKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGEAKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A07679;
        Mon,  4 Jul 2022 17:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C543E617C7;
        Tue,  5 Jul 2022 00:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CAC3411E;
        Tue,  5 Jul 2022 00:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656979845;
        bh=49WWV0PmMuNRg/toHTxKXTpcl6lIvnWwBTpEL9Jpxkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rv45oJlYmwVtT9maPUlCgydT5QmYW1wdIDcDGWzYRptDQZXtY8tEmpD3aYMUtZy/2
         PZNNH6tfw56s1HWcioN9aYkAyAUDNWTNg7t0pRCPgDGtQsqlYdguO9sNpWJKuDdSUM
         WQY8lG5PI2u0v+bh8Bykht1TJFZUgoDk15TrjgJbTVcg4YTLlpRxUqNyW22YDGgmzI
         8a/1/87I5+Pa1ob1Za4rTRFSBBOIae2BPDZqcbjB3lHua+N6/J7yPdpzp2FrAoalbZ
         JzMov3JLO2AAwobqk4gW/kJIUuEzGYW5CffvGXXCqCafodAT6LcZs/bSDNeqOHWCZI
         Rkn1QROl8JuCg==
Received: by pali.im (Postfix)
        id 7D1317AE; Tue,  5 Jul 2022 02:10:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO
Date:   Tue,  5 Jul 2022 02:10:23 +0200
Message-Id: <20220705001023.14660-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220705001023.14660-1-pali@kernel.org>
References: <20220705001023.14660-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards is WDI logic of max6370 chip connected via GPIO.
So extend max63xx_wdt driver to allow specifying WDI logic via GPIO.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
Changes in v3:
* Use gpiod_set_value()
Changes in v2:
* Usage of dev_err_probe()
* Fixing assignment of wdt->ping
* Remove clearing of wdt->gpio_wdi
* Move YAML change to separate patch
---
 drivers/watchdog/max63xx_wdt.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e1541cfae0d..4718695837f6 100644
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
+	gpiod_set_value(wdt->gpio_wdi, 1);
+	udelay(1);
+	gpiod_set_value(wdt->gpio_wdi, 0);
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

