Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52D567110
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiGEOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGEOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:30:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D92186
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:30:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so17825518wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9da/QeGRcCpJ3hrNNbUxLvYG+ekB8n1mPdVYqACHlDE=;
        b=qJ1jQ4Djp+QCkJQZAfjaPN1oWlWpXMqSQ7m1QtXXjO1NjnA2KMKPRbfyFYbsGMc9Mk
         ckvOYj5vSNE3GJ6eYUhFTR3DSG7OD25RC3cIfWY968lh20+Z8ssqVY+TrQ3mit9Ydnjs
         y/3/Mm3p/Zpj/dO2+AIAYwmBUFsgRYpI7A/f+V6db+/I3sPm4De5fxXdPXdb9P+08iuZ
         yMLSiPQ9zPhWjNvWAmDlt+LALLKMIWe3t/ifboqldxkOcF+ZASqx/E6P3LGhI+Zsvcxo
         +5nEgBXHNbPVhc797wnVMsDM9bMjG5j4SsRA3x7dVK7UmHB+zRstrfjdnoW0W77tXULt
         07Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9da/QeGRcCpJ3hrNNbUxLvYG+ekB8n1mPdVYqACHlDE=;
        b=xIy4VZbG3m8EWiwKUyOQ7PaXDQHuiEBsDJxx7O6BNfH6MPb95udRNc4yawePhVjpvP
         ZmFJ6QR9/vUWGa4FcCYBS4iRwer2eUu+ToD7ll/+iyn5OsIPJGMzGMwg69ACkKotQAYC
         A27cwzgHVPVvqCvXMBm/jtyj4J4QLu/C8VXk1VBV3B7H956XJ/MPTZKHrrhdfbj9BRcq
         VcXVxf2j1GcTpXPoSGpKtckRA4WwI8MEDUZaSMPS9ZeMWersUAkjaJprcgKpqN7J825U
         0csloHZ/5XL7DxMjFqpAuewD2vJBTbaY2iVYvPtQRqg5+sM/7hwUwypvwypsHkE+xChQ
         CNaw==
X-Gm-Message-State: AJIora9Lyj34tTgFGjBQRpUB21wh5W0IwU5tuFaszjaRh5P9WZuU44ZE
        Cc6O9TYCnOi45rQUEz8C6LNtsA==
X-Google-Smtp-Source: AGRyM1uIuR4D4oP9T7niGz4yUtI/9LS6rl4g2JOCPOUNle/hM11AhMMJzP+iEitvCALdmqMvJWVYig==
X-Received: by 2002:a05:6000:1011:b0:21d:4212:854a with SMTP id a17-20020a056000101100b0021d4212854amr24909543wrx.179.1657031426855;
        Tue, 05 Jul 2022 07:30:26 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003a02f957245sm18525743wmq.26.2022.07.05.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:30:26 -0700 (PDT)
From:   Philippe Boos <pboos@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Philippe Boos <pboos@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] watchdog: meson: keep running if already active
Date:   Tue,  5 Jul 2022 16:24:44 +0200
Message-Id: <20220705142444.17063-1-pboos@baylibre.com>
X-Mailer: git-send-email 2.20.1
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

If the watchdog is already running (e.g.: started by bootloader) then
the kernel driver should keep the watchdog active but the amlogic driver
turns it off.

Let the driver fix the clock rate then restart the watchdog if it was
previously active.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Philippe Boos <pboos@baylibre.com>
---
 drivers/watchdog/meson_gxbb_wdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 5a9ca10fbcfa..8c2c6f7f3bb5 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -146,6 +146,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct meson_gxbb_wdt *data;
 	int ret;
+	u32 regval;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -177,6 +178,8 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 	data->wdt_dev.timeout = DEFAULT_TIMEOUT;
 	watchdog_set_drvdata(&data->wdt_dev, data);
 
+	regval = readl(data->reg_base + GXBB_WDT_CTRL_REG);
+
 	/* Setup with 1ms timebase */
 	writel(((clk_get_rate(data->clk) / 1000) & GXBB_WDT_CTRL_DIV_MASK) |
 		GXBB_WDT_CTRL_EE_RESET |
@@ -186,6 +189,13 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
 
 	meson_gxbb_wdt_set_timeout(&data->wdt_dev, data->wdt_dev.timeout);
 
+	if ((regval & GXBB_WDT_CTRL_EN) != 0) {
+		ret = meson_gxbb_wdt_start(&data->wdt_dev);
+		if (ret)
+			return ret;
+		set_bit(WDOG_HW_RUNNING, &data->wdt_dev.status);
+	}
+
 	watchdog_stop_on_reboot(&data->wdt_dev);
 	return devm_watchdog_register_device(dev, &data->wdt_dev);
 }
-- 
2.20.1

