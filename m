Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F8512FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbiD1JXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbiD1JTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:19:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BC2AC5E;
        Thu, 28 Apr 2022 02:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC24AB82C2E;
        Thu, 28 Apr 2022 09:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503C0C385A9;
        Thu, 28 Apr 2022 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651137382;
        bh=EwqTDOFG4cur2yOUWY0eqlQeG96O0SBRWYEdM0HpvnM=;
        h=From:To:Cc:Subject:Date:From;
        b=YQWeMhhIYWkVP4QpudZiHEyFzRV7W+O8k3op2HEwj6pt4oqeJreaEcS5GNME8vZPT
         DBo3LcroC01kZ+vPss5pM9mSOknFl/mBhOZj54a8tFq1mlKruzaOBfB08INCvSD5MM
         YRoSbcZfOF9tjfhYSUJZ9oJwJFT+FBR9VIdKr+6wvIS/7nNZPzxMGSCYEzlJ5K70Tp
         kk2pM0jintE8ylwfXCeOpHft5uJQ1FDV1x8fTumX+jPKJvS7Wboxj5mRYVVDu9HJAD
         Xd6tsBXiJVgiUDwP8FbLuffVi8vijy1vi3JAgn8n5cZLfOsBR/V8OLEYlXDbYPUiRw
         F2dexix1oWy5Q==
Received: by pali.im (Postfix)
        id 40A928A0; Thu, 28 Apr 2022 11:16:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: max63xx_wdt: Add support for specifying WDI logic via GPIO
Date:   Thu, 28 Apr 2022 11:16:03 +0200
Message-Id: <20220428091603.6838-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
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

On some boards is WDI logic of max6370 chip connected via GPIO. So extend
max63xx_wdt driver and DTS schema to allow specifying WDI logic via GPIO.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../bindings/watchdog/maxim,max63xx.yaml      |  4 +++
 drivers/watchdog/max63xx_wdt.c                | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index ab9641e845db..a97aa0135ef9 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -27,6 +27,10 @@ properties:
     description: This is a 1-byte memory-mapped address
     maxItems: 1
 
+  gpios:
+    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
+    maxItems: 1
+
 required:
   - compatible
   - reg
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9e1541cfae0d..eaf00c3f06a5 100644
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
@@ -225,6 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
+	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT) {
+		if (PTR_ERR(wdt->gpio_wdi) != -EPROBE_DEFER)
+			dev_err(dev, "unable to request gpio: %ld\n",
+				PTR_ERR(wdt->gpio_wdi));
+		return PTR_ERR(wdt->gpio_wdi);
+	}
+
+	if (!IS_ERR(wdt->gpio_wdi))
+		wdt->ping = max63xx_gpio_ping;
+	else
+		wdt->gpio_wdi = NULL;
+
 	err = max63xx_mmap_init(pdev, wdt);
 	if (err)
 		return err;
-- 
2.20.1

