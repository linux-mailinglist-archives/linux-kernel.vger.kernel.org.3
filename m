Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0503A5B141C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIHFj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHFjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:39:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC6E2B264;
        Wed,  7 Sep 2022 22:39:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2521492pjq.1;
        Wed, 07 Sep 2022 22:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4es0Z+5XwTpsNYHTc+clw4irSNbZDC2d3QGKCURiR3c=;
        b=K+g/ZnfkIdznKBgAkVIk2cMZDRKq/vmF4Az7bUbPPpL/jZAiA11F3rEQALLW8OquQM
         utWlMgbIQamRgYDMae0eVE4chV2/lrK0iwRzRyeIop5UXSENXz/oLcYmftavwUSdy/qx
         IMMVJSB8bS5Q2/FOMkeR2OaxSabNafdnmcEwKSxtdL7LzrPVtjHX8GJOv7FQTbS3tNl/
         wTOOdDUNPj3DWCtU45CwAKOTsxmWgfx7ia/f58l/kROSt9DF/27OpthSlTGp1vFzz2Tw
         JVrLIilPjAImxj+vKturX7LRuue5IEVqTkSJDl8VuvLyUUQ1cffZNdjC1P1eleptLv+H
         WAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4es0Z+5XwTpsNYHTc+clw4irSNbZDC2d3QGKCURiR3c=;
        b=HrpiIJPkx5blJY02wkqnzxF5XBlY118K41af8pWlgXapp4UD73Qv+nN/PgXYI1TAhD
         b0dT35zMwGQgeGNz3Nz3wwZL5H4RiSR3gL0CLIx6IVVc9NkgjQ6YwM7XziXVZnM/54sj
         V289k/mdyFcfPe6quUzrCnMN3tWg9dgCNcA1JI6u73BlqBevWX5DpJFgHv7LAJJJbehy
         hUQKRX+REAUUIp8BKljf59oiYCVHdp2e3CNm22b6DDavb+cHomw96rArUzjuxSkO68Xp
         YKF2K2P2vd2/uDtcvy18axi+/klU3gm4JzbbxZkjT8LsZFikjMfL9HyP+Hok1uyE/fHM
         N/rw==
X-Gm-Message-State: ACgBeo1p1gNNximud2YRRllTdyz7UG1BD3E8L0WkM8HV7E0lXAyOjgyV
        tv8FSfbUpPI0oj7wkIIwCUc=
X-Google-Smtp-Source: AA6agR6foFAFZ/aOfcTBBVpjBlrc9Gvn2PHJHzbT7OVwXcw8bxSb0899ZJwJh8Xg8mAVx/FZe4fNBg==
X-Received: by 2002:a17:90b:4c08:b0:200:512e:de26 with SMTP id na8-20020a17090b4c0800b00200512ede26mr2290018pjb.227.1662615593681;
        Wed, 07 Sep 2022 22:39:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7af1:2c0d:fbfa:b9d7])
        by smtp.gmail.com with ESMTPSA id i67-20020a626d46000000b0053e7d3b8d6dsm2685183pfc.1.2022.09.07.22.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:39:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] gpiolib: of: make Freescale SPI quirk similar to all others
Date:   Wed,  7 Sep 2022 22:39:47 -0700
Message-Id: <20220908053949.3564796-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908053949.3564796-1-dmitry.torokhov@gmail.com>
References: <20220908053949.3564796-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for of_find_spi_cs_gpio() to be different from other
quirks: the only variant of property actually used in DTS is "gpios"
(plural) so we can use of_get_named_gpiod_flags() instead of recursing
into of_find_gpio() again.

This will allow us consolidate quirk handling down the road.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index c08564948bf9..30b89b694530 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -407,7 +407,7 @@ static struct gpio_desc *of_find_spi_gpio(struct device *dev,
 static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
 					     const char *con_id,
 					     unsigned int idx,
-					     unsigned long *flags)
+					     enum of_gpio_flags *of_flags)
 {
 	const struct device_node *np = dev->of_node;
 
@@ -428,7 +428,7 @@ static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
 	 * uses just "gpios" so translate to that when "cs-gpios" is
 	 * requested.
 	 */
-	return of_find_gpio(dev, NULL, idx, flags);
+	return of_get_named_gpiod_flags(dev->of_node, "gpios", idx, of_flags);
 }
 
 /*
@@ -527,12 +527,8 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 		desc = of_find_spi_gpio(dev, con_id, idx, &of_flags);
 	}
 
-	if (gpiod_not_found(desc)) {
-		/* This quirk looks up flags and all */
-		desc = of_find_spi_cs_gpio(dev, con_id, idx, flags);
-		if (!IS_ERR(desc))
-			return desc;
-	}
+	if (gpiod_not_found(desc))
+		desc = of_find_spi_cs_gpio(dev, con_id, idx, &of_flags);
 
 	if (gpiod_not_found(desc)) {
 		/* Special handling for regulator GPIOs if used */
-- 
2.37.2.789.g6183377224-goog

