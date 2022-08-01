Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420BA5866CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiHAJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiHAJWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:22:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846382B244
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:22:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q30so8914301wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NGyhhBpF08caSp9ryVolnpYSv07YhtzN63176RAsoRU=;
        b=l/30398qzN7b2NPQpN3AbWdp4u5F62TY0f7bHO8KhDH6oUYCSXYZZFAgib548IFdVB
         sMAN+0tkDOuMrFmM7txJL4GxCcuOUZwEuv8DW0u+5+GYCI6RSENGwHswISFRdzrwNB8v
         EivuaoqHpIGLGhFvzeNIKxHpJ+ef9YkRqFw5ZTOQEFXlphPCmUxHP+K0PVx/llU3aXMI
         YuhkNe87ad5XUhKJRtwJy4l/RQaPjOE1Tl0B8p9l7J+mnHP3XRpMGBLP45AYSLK5udRD
         P/9uGyfKaYLMMxHfiuX0ZigIe7Z/8Wm8qgkmoAPfOhbbTVFh556IUwOYrk+2YKGmU3SQ
         Ek2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NGyhhBpF08caSp9ryVolnpYSv07YhtzN63176RAsoRU=;
        b=c/7JaNngUwt72YCEiEDw1BKoCSngNOEfQkBwZ3anP6CX08yEFslMlOnJZVEXEBYB8Y
         53hDwrkhR9tapuQOFvw/0SLc4ITfTR4fmFh2KtEmAecIQp30g+EsCaqeWMVKwjKKaOaN
         BVZElAWy4unkTjmHOEy9cTl0o/E9tDtkxVYxxXMhkZUPcClwLiMapkbj0PE0lr8COcQB
         nxp8np433QAbqBAGW1KsmhMgdnuGAMu2K6TYj+3Me6XMIL1/3l0fUZd8Sf6cxeAW2P33
         jWxXWmX64gTBL290TopuE7r/8GMbymRyHJoDHLYorjzCVLP3nQg0Eg3U6+eFmOx4yPFs
         VOYA==
X-Gm-Message-State: ACgBeo3pMWfFx6DajfypZH58eQ5cufCgPK4kWRqtgs5QLiRgFZKXRx0e
        9mkJx8Z/ys7RkVsEQUEExJdAdA==
X-Google-Smtp-Source: AA6agR6mnS/kyqOIglz+91cHGdVqd9XYyn4LrVlZGvLKmhDtkndnSHB3h76n4PACAFQZ+hYVLrOHxQ==
X-Received: by 2002:a5d:4f09:0:b0:21e:cc31:50b6 with SMTP id c9-20020a5d4f09000000b0021ecc3150b6mr9186504wru.124.1659345766067;
        Mon, 01 Aug 2022 02:22:46 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c2e5100b003a3186fa559sm13504028wmf.29.2022.08.01.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 02:22:45 -0700 (PDT)
From:   Philippe Boos <pboos@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Philippe Boos <pboos@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] watchdog: meson: keep running if already active
Date:   Mon,  1 Aug 2022 11:21:50 +0200
Message-Id: <20220801092150.4449-1-pboos@baylibre.com>
X-Mailer: git-send-email 2.20.1
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

If the watchdog is already running (e.g.: started by bootloader) then
the kernel driver should keep the watchdog active but the amlogic driver
turns it off.

Let the driver fix the clock rate if already active because we do not
know the previous timebase value. To avoid unintentional resetting we
temporarily set it to its maximum value.

Then keep the enable bit if is was previously active.

Signed-off-by: Philippe Boos <pboos@baylibre.com>
---
 drivers/watchdog/meson_gxbb_wdt.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 5a9ca10fbcfa..8be8fd9e5637 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -146,6 +146,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct meson_gxbb_wdt *data;
 	int ret;
+	u32 ctrl_reg;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -177,13 +178,26 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
 	watchdog_set_drvdata(&data->wdt_dev, data);
 
+	ctrl_reg = readl(data->reg_base + GXBB_WDT_CTRL_REG) &
+				GXBB_WDT_CTRL_EN;
+
+	if (ctrl_reg) {
+		/* Watchdog is running - keep it running but extend timeout
+		 * to the maximum while setting the timebase
+		 */
+		set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
+		meson_gxbb_wdt_set_timeout(&data->wdt_dev,
+				GXBB_WDT_TCNT_SETUP_MASK / 1000);
+	}
+
 	/* Setup with 1ms timebase */
-	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
-		GXBB_WDT_CTRL_EE_RESET |
-		GXBB_WDT_CTRL_CLK_EN |
-		GXBB_WDT_CTRL_CLKDIV_EN,
-		data->reg_base + GXBB_WDT_CTRL_REG);
+	ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
+			GXBB_WDT_CTRL_DIV_MASK) |
+			GXBB_WDT_CTRL_EE_RESET |
+			GXBB_WDT_CTRL_CLK_EN |
+			GXBB_WDT_CTRL_CLKDIV_EN;
 
+	writel(ctrl_reg, data->reg_base + GXBB_WDT_CTRL_REG);
 	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
 
 	watchdog_stop_on_reboot(&data->wdt_dev);
-- 
2.20.1

