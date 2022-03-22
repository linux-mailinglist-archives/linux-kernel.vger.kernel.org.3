Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CF4E492E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiCVWbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiCVWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:31:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B24C439
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:30:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p15so21455455lfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=WDZwzOksGqQgVAFZZ36dR9dDLRM2t7nrAA8OpwXT/x4=;
        b=RLQuDw/EePVKm588I3/ZlKZQf7XopBpfj3Bfft0yBiFLv0+Dl7zgi+2RD2lGYp+uIz
         OGujiiZFZuWt9N2sGbaU9kBLDL9d6GEhQv8bpHcn6ErHVZ57P6bT7A81z9XIBu0zhO/I
         XZ1WmLK/cfqQoHtcpRdKOUs0KykMq+6M1qB546KMmE4EXOwCRTCEZ9Lm1KCNK2Ef9p1n
         L9X8Lu/l71aQZFyMkvCijSAND+784147B8dT/6q4lGFG3C03axDVhQo7iF8B35kGBeOo
         IB4+oLwX8HTMINtiX4bGNY+0F/oVJ6Rq+u3WjecCAmyLIziRT2DgNGCCIeR2ONFlrEmg
         BYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=WDZwzOksGqQgVAFZZ36dR9dDLRM2t7nrAA8OpwXT/x4=;
        b=f39EM3LGDpqiasF80ZG/QKf7lkGW62JIMWVlphxwGBn+hgMg5/xqrmeCDiiiqm5NLv
         z/Fe50YV3hFvQZ29wFfNnEkVIkfLYcZeLTRIIy+yM7tiKcntGF/rMGJC+psGDbB1X3b3
         5X3XRiTrqz7RD00RIH4TPGFlQ0jC94zx/g77UMYHp8Bdb1S8OWkOT6SLooulnsryaYpH
         eMQiiV6O1L3A29cAQeTASoRbCcTWGowXOLnr0qS2UY+kEM5I5MhEJxHzwkErl43OZ23p
         nVLBHoS4sMg544JweQlBK2NR6wVS+HkSdL47cw+EQkDzs9yXjvN7MDC0ZySoYrJeoRJZ
         hwew==
X-Gm-Message-State: AOAM531+4p1RfZybaGb1vekG01aujxGy/3ZeIGU9cfFvLRQTRW/AlFek
        HcllIVYkGLqYo83juesb97aQdw==
X-Google-Smtp-Source: ABdhPJxK6lqc4QDK3tUQ7+6y03+fLRl5ZCEGr5mNG56Ty4ZkHYr14RFvjNOP9aSVXw4yyaGVmRvEIQ==
X-Received: by 2002:ac2:5feb:0:b0:448:2707:6bfd with SMTP id s11-20020ac25feb000000b0044827076bfdmr20426934lfg.380.1647988203557;
        Tue, 22 Mar 2022 15:30:03 -0700 (PDT)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id g10-20020a19ac0a000000b00441e497867fsm2321462lfc.93.2022.03.22.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:30:03 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: gpio_wdt: Support GPO lines with the toggle algorithm
Date:   Tue, 22 Mar 2022 23:29:11 +0100
Message-Id: <20220322222911.519238-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Westermo
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

Support using GPO lines (i.e. GPIOs that are output-only) with
gpio_wdt using the "toggle" algorithm.

Since its inception, gpio_wdt has configured its GPIO line as an input
when using the "toggle" algorithm, even though it is used as an output
when kicking. This needlessly barred hardware with output-only pins
from using the driver.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---

Hi,

This patch has been in our downstream tree for a long time. We need it
because our kick GPIO can't be used as an input.

What I really can't figure out is why the driver would request the pin
as in input, when it's always going to end up being used as an output
anyway.

So I thought I'd send it upstream in the hopes of either getting it
merged, or an explanation as to why it is needed.

 drivers/watchdog/gpio_wdt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 0923201ce874..f7686688e0e2 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -108,7 +108,6 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct gpio_wdt_priv *priv;
-	enum gpiod_flags gflags;
 	unsigned int hw_margin;
 	const char *algo;
 	int ret;
@@ -122,17 +121,15 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	ret = of_property_read_string(np, "hw_algo", &algo);
 	if (ret)
 		return ret;
-	if (!strcmp(algo, "toggle")) {
+
+	if (!strcmp(algo, "toggle"))
 		priv->hw_algo = HW_ALGO_TOGGLE;
-		gflags = GPIOD_IN;
-	} else if (!strcmp(algo, "level")) {
+	else if (!strcmp(algo, "level"))
 		priv->hw_algo = HW_ALGO_LEVEL;
-		gflags = GPIOD_OUT_LOW;
-	} else {
+	else
 		return -EINVAL;
-	}
 
-	priv->gpiod = devm_gpiod_get(dev, NULL, gflags);
+	priv->gpiod = devm_gpiod_get(dev, NULL, GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod))
 		return PTR_ERR(priv->gpiod);
 
-- 
2.25.1

