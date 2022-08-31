Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954135A7993
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiHaI4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiHaIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:55:56 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670B5B060
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:55:07 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s15so8764148ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lnl267LttqWe2usDLJlWLuZ0tm1nJ6Hhdwia6TRWNNo=;
        b=tAKs2+0n+cIiiXUwPXFlhU2KFcSzHpC2eY0PjZmqCjxG/am0USbUKAsaQ+dS1v3S7F
         60DL8zX0WG4TD0FBO+v3VrqWW4VyvBZXR6uTABYESTRmrl4UqPB5lzfUe43igchdZjuj
         oYhV2+6aNaJsZ2iMzCtOrEuIvaqnanukl+fAnsamTE4oousVIpO/V7BFJqRvxHInG4cw
         X30o3nTNtxzpD0CUNXmT2WDvcoGIWH/f2gXC2+U406+t2ruEuIpO7353DEl3S8vDQw6v
         C1+G7hyH2xJggd/MFbiIcTel1Amb+5qLquc0PZFkZyWnPNRHDglCToxXKp8k64hEcNMw
         rxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lnl267LttqWe2usDLJlWLuZ0tm1nJ6Hhdwia6TRWNNo=;
        b=YobeDeM14AUpbUZkuwyEHW1JwyrTGIV+in62iwj2PjXRpoJ4+K6Temmr5HFVZLy4Y+
         OX8/w2JUlvqLKpGQfVfoUS23Ud6K1mc0GQ937alwVs+tDjTlbMMtmzgl01HmIi0ZyMpG
         XbO3f1jHPC13dr9CqEJfwCMHq+I3slJkRj2Dw6SVOvldicsa6dtLNZ/C2BoczVxODOE3
         /Volx553Av53mflQ4NObfdmAhX9bFv06pEP8k4iBYNwnJ7KzolLYxwd3VyEMZMv2TFJ6
         x2JfRkz03S+/MAGQva05QojmbQCjTrFe0v5RyW8W5EFlgBqYmr9CbDdcdaHdW6fw2+DM
         KTZw==
X-Gm-Message-State: ACgBeo3qJZcVEyJrZvKsL3XvZByONrcSZNat4FUMtCY5ZxmUWB0tQLhH
        vV3EBx51moUWfos7w81dRnnrbg==
X-Google-Smtp-Source: AA6agR57Lx9exXXbeKImW3GP2VbSitZpMsi1LmCtb7hDyTtS8nOgBPh+Z+p6Sht3I+zR85yh0wfXmA==
X-Received: by 2002:a2e:a551:0:b0:25f:eb63:2588 with SMTP id e17-20020a2ea551000000b0025feb632588mr8273782ljn.9.1661936103697;
        Wed, 31 Aug 2022 01:55:03 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b004946c99e78asm988047lfr.277.2022.08.31.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:55:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH] mfd/omap1: htc-i2cpld: Convert to a pure GPIO driver
Date:   Wed, 31 Aug 2022 10:53:01 +0200
Message-Id: <20220831085301.490906-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing GPIO numbers pertaining to ourselves through
platform data, just request GPIO descriptors from our own GPIO
chips and use them, and cut down on the unnecessary complexity.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
If one of the OMAP1 people can provide an ACK then it's best
if Lee takes this into the MFD tree.
---
 arch/arm/mach-omap1/board-htcherald.c |  9 ----
 drivers/mfd/htc-i2cpld.c              | 59 ++++++++++++---------------
 include/linux/htcpld.h                |  2 -
 3 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index ec049cee49c6..291d294b5824 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -141,13 +141,6 @@
 #define HTCPLD_GPIO_DOWN_DPAD		HTCPLD_BASE(7, 4)
 #define HTCPLD_GPIO_ENTER_DPAD		HTCPLD_BASE(7, 3)
 
-/*
- * The htcpld chip requires a gpio write to a specific line
- * to re-enable interrupts after one has occurred.
- */
-#define HTCPLD_GPIO_INT_RESET_HI	HTCPLD_BASE(2, 7)
-#define HTCPLD_GPIO_INT_RESET_LO	HTCPLD_BASE(2, 0)
-
 /* Chip 5 */
 #define HTCPLD_IRQ_RIGHT_KBD		HTCPLD_IRQ(0, 7)
 #define HTCPLD_IRQ_UP_KBD		HTCPLD_IRQ(0, 6)
@@ -348,8 +341,6 @@ static struct htcpld_chip_platform_data htcpld_chips[] = {
 };
 
 static struct htcpld_core_platform_data htcpld_pfdata = {
-	.int_reset_gpio_hi = HTCPLD_GPIO_INT_RESET_HI,
-	.int_reset_gpio_lo = HTCPLD_GPIO_INT_RESET_LO,
 	.i2c_adapter_id	   = 1,
 
 	.chip		   = htcpld_chips,
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 417b0355d904..a6d47ce27efe 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -20,7 +20,9 @@
 #include <linux/irq.h>
 #include <linux/spinlock.h>
 #include <linux/htcpld.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 struct htcpld_chip {
@@ -58,8 +60,8 @@ struct htcpld_data {
 	uint               irq_start;
 	int                nirqs;
 	uint               chained_irq;
-	unsigned int       int_reset_gpio_hi;
-	unsigned int       int_reset_gpio_lo;
+	struct gpio_desc   *int_reset_gpio_hi;
+	struct gpio_desc   *int_reset_gpio_lo;
 
 	/* htcpld info */
 	struct htcpld_chip *chip;
@@ -196,9 +198,9 @@ static irqreturn_t htcpld_handler(int irq, void *dev)
 	 * be asserted.
 	 */
 	if (htcpld->int_reset_gpio_hi)
-		gpio_set_value(htcpld->int_reset_gpio_hi, 1);
+		gpiod_set_value(htcpld->int_reset_gpio_hi, 1);
 	if (htcpld->int_reset_gpio_lo)
-		gpio_set_value(htcpld->int_reset_gpio_lo, 0);
+		gpiod_set_value(htcpld->int_reset_gpio_lo, 0);
 
 	return IRQ_HANDLED;
 }
@@ -562,35 +564,26 @@ static int htcpld_core_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Request the GPIO(s) for the int reset and set them up */
-	if (pdata->int_reset_gpio_hi) {
-		ret = gpio_request(pdata->int_reset_gpio_hi, "htcpld-core");
-		if (ret) {
-			/*
-			 * If it failed, that sucks, but we can probably
-			 * continue on without it.
-			 */
-			dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
-			htcpld->int_reset_gpio_hi = 0;
-		} else {
-			htcpld->int_reset_gpio_hi = pdata->int_reset_gpio_hi;
-			gpio_set_value(htcpld->int_reset_gpio_hi, 1);
-		}
-	}
+	htcpld->int_reset_gpio_hi = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
+							      7, "htcpld-core", GPIO_ACTIVE_HIGH,
+							      GPIOD_OUT_HIGH);
+	if (!htcpld->int_reset_gpio_hi)
+		/*
+		 * If it failed, that sucks, but we can probably
+		 * continue on without it.
+		 */
+		dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
 
-	if (pdata->int_reset_gpio_lo) {
-		ret = gpio_request(pdata->int_reset_gpio_lo, "htcpld-core");
-		if (ret) {
-			/*
-			 * If it failed, that sucks, but we can probably
-			 * continue on without it.
-			 */
-			dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
-			htcpld->int_reset_gpio_lo = 0;
-		} else {
-			htcpld->int_reset_gpio_lo = pdata->int_reset_gpio_lo;
-			gpio_set_value(htcpld->int_reset_gpio_lo, 0);
-		}
-	}
+
+	htcpld->int_reset_gpio_lo = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
+							      0, "htcpld-core", GPIO_ACTIVE_HIGH,
+							      GPIOD_OUT_LOW);
+	if (!htcpld->int_reset_gpio_lo)
+		/*
+		 * If it failed, that sucks, but we can probably
+		 * continue on without it.
+		 */
+		dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
 
 	dev_info(dev, "Initialized successfully\n");
 	return 0;
diff --git a/include/linux/htcpld.h b/include/linux/htcpld.h
index 842fce69ac06..5f8ac9b1d724 100644
--- a/include/linux/htcpld.h
+++ b/include/linux/htcpld.h
@@ -13,8 +13,6 @@ struct htcpld_chip_platform_data {
 };
 
 struct htcpld_core_platform_data {
-	unsigned int                      int_reset_gpio_hi;
-	unsigned int                      int_reset_gpio_lo;
 	unsigned int                      i2c_adapter_id;
 
 	struct htcpld_chip_platform_data  *chip;
-- 
2.37.2

