Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4C5B1423
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIHFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIHFk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:40:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B6765834;
        Wed,  7 Sep 2022 22:40:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t3so11688553ply.2;
        Wed, 07 Sep 2022 22:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QlMbk8e/zVNzu6UyNqDpiCSRzKyYMJFXh85E1yOMis8=;
        b=L1oYb4LwB4FgUBLn2yYOimsTSa67Iizy6gQuVNFZgIaZKWboQWuRGJfHrumz2Qqfi8
         nKIUqxXy3db3ifLuJgBo5rl3BFcxIs8GXTugMglRbQglRLMbBu135PUetF27FjVY5HJq
         v5/LdZ7r5r0F88vybRPVqAQzbuNkD5z69Bu/XOHqi/roByj0EkaDhxC+QOl5NL9xeCcj
         360K8loeK2MxqlrAtyftApB2J+tm5mA2VRKQg2L5SQEPnvAqNTIwx4pHQdOiDcw2Jo1z
         GwYCKIjeFmjMgEKZt3GxZt5rJqs9DA55uSIf/g65WeowMBsT6talChHDge6dPleW3G4r
         Lptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QlMbk8e/zVNzu6UyNqDpiCSRzKyYMJFXh85E1yOMis8=;
        b=3LS3fx2LBS+d9pz0koHUovIjx4HGBuBx8OEzUr5fjSQiAH7JcsTvdWZEpo45Azrdmz
         TuxIImVWyfxR0fxS737O9FQRg7qZX4E33O2RjG8AiCYaWSjjqlUc0pmQbxtsbpXaskIB
         Ou4vld2tcbSQ1nhqETAP01NvhT5qcZj9pYvlE3vYJv9H8yVYlbNgFufJ9TtHan8UtGqH
         lXpxF0CBngDZ14Y/Bop8NTKAhLHaufnCv608gk0kZesg0hdPvVw06kpA5s9jjXpmffTO
         ZgfGZHNOCpRueDkm2vyX0/p9bYygB7+1Ewq0597Qb7r4cmH/o13gCHznAUwgMmWcFiDW
         ddCg==
X-Gm-Message-State: ACgBeo1ldloQNPLP6j5EvL/Ic6JvqBN7UPChw8ivT19fHYKjj6lYEXbU
        9rj9POqAMJX1MOhNsqYT7mwB/rDxnFg=
X-Google-Smtp-Source: AA6agR7QZVNONsNsKbmiTxdKd5Jfir6zjA0AMwNAgSnuDCanNwyY8c5fmGDScL+j29eHH3jPwSlO9Q==
X-Received: by 2002:a17:90b:4a10:b0:1fb:2e77:a33 with SMTP id kk16-20020a17090b4a1000b001fb2e770a33mr2331729pjb.67.1662615592827;
        Wed, 07 Sep 2022 22:39:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7af1:2c0d:fbfa:b9d7])
        by smtp.gmail.com with ESMTPSA id i67-20020a626d46000000b0053e7d3b8d6dsm2685183pfc.1.2022.09.07.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:39:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] gpiolib: of: do not ignore requested index when applying quirks
Date:   Wed,  7 Sep 2022 22:39:46 -0700
Message-Id: <20220908053949.3564796-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

We should not ignore index passed into of_find_gpio() when handling
quirks. While in practice this change will not have any effect, it
will allow consolidate quirk handling.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a037b50bef33..c08564948bf9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -372,7 +372,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
  * properties should be named "foo-gpios" so we have this special kludge for
  * them.
  */
-static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
+static struct gpio_desc *of_find_spi_gpio(struct device *dev,
+					  const char *con_id,
+					  unsigned int idx,
 					  enum of_gpio_flags *of_flags)
 {
 	char prop_name[32]; /* 32 is max size of property name */
@@ -393,7 +395,7 @@ static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id
 	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
 	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
 
-	desc = of_get_named_gpiod_flags(np, prop_name, 0, of_flags);
+	desc = of_get_named_gpiod_flags(np, prop_name, idx, of_flags);
 	return desc;
 }
 
@@ -434,7 +436,9 @@ static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
  * properties should be named "foo-gpios" so we have this special kludge for
  * them.
  */
-static struct gpio_desc *of_find_regulator_gpio(struct device *dev, const char *con_id,
+static struct gpio_desc *of_find_regulator_gpio(struct device *dev,
+						const char *con_id,
+						unsigned int idx,
 						enum of_gpio_flags *of_flags)
 {
 	/* These are the connection IDs we accept as legacy GPIO phandles */
@@ -457,12 +461,13 @@ static struct gpio_desc *of_find_regulator_gpio(struct device *dev, const char *
 	if (i < 0)
 		return ERR_PTR(-ENOENT);
 
-	desc = of_get_named_gpiod_flags(np, con_id, 0, of_flags);
+	desc = of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 	return desc;
 }
 
 static struct gpio_desc *of_find_arizona_gpio(struct device *dev,
 					      const char *con_id,
+					      unsigned int idx,
 					      enum of_gpio_flags *of_flags)
 {
 	if (!IS_ENABLED(CONFIG_MFD_ARIZONA))
@@ -471,17 +476,18 @@ static struct gpio_desc *of_find_arizona_gpio(struct device *dev,
 	if (!con_id || strcmp(con_id, "wlf,reset"))
 		return ERR_PTR(-ENOENT);
 
-	return of_get_named_gpiod_flags(dev->of_node, con_id, 0, of_flags);
+	return of_get_named_gpiod_flags(dev->of_node, con_id, idx, of_flags);
 }
 
 static struct gpio_desc *of_find_usb_gpio(struct device *dev,
 					  const char *con_id,
+					  unsigned int idx,
 					  enum of_gpio_flags *of_flags)
 {
 	/*
-	 * Currently this USB quirk is only for the Fairchild FUSB302 host which is using
-	 * an undocumented DT GPIO line named "fcs,int_n" without the compulsory "-gpios"
-	 * suffix.
+	 * Currently this USB quirk is only for the Fairchild FUSB302 host
+	 * which is using an undocumented DT GPIO line named "fcs,int_n"
+	 * without the compulsory "-gpios" suffix.
 	 */
 	if (!IS_ENABLED(CONFIG_TYPEC_FUSB302))
 		return ERR_PTR(-ENOENT);
@@ -489,7 +495,7 @@ static struct gpio_desc *of_find_usb_gpio(struct device *dev,
 	if (!con_id || strcmp(con_id, "fcs,int_n"))
 		return ERR_PTR(-ENOENT);
 
-	return of_get_named_gpiod_flags(dev->of_node, con_id, 0, of_flags);
+	return of_get_named_gpiod_flags(dev->of_node, con_id, idx, of_flags);
 }
 
 struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
@@ -518,7 +524,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 	if (gpiod_not_found(desc)) {
 		/* Special handling for SPI GPIOs if used */
-		desc = of_find_spi_gpio(dev, con_id, &of_flags);
+		desc = of_find_spi_gpio(dev, con_id, idx, &of_flags);
 	}
 
 	if (gpiod_not_found(desc)) {
@@ -530,14 +536,14 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 	if (gpiod_not_found(desc)) {
 		/* Special handling for regulator GPIOs if used */
-		desc = of_find_regulator_gpio(dev, con_id, &of_flags);
+		desc = of_find_regulator_gpio(dev, con_id, idx, &of_flags);
 	}
 
 	if (gpiod_not_found(desc))
-		desc = of_find_arizona_gpio(dev, con_id, &of_flags);
+		desc = of_find_arizona_gpio(dev, con_id, idx, &of_flags);
 
 	if (gpiod_not_found(desc))
-		desc = of_find_usb_gpio(dev, con_id, &of_flags);
+		desc = of_find_usb_gpio(dev, con_id, idx, &of_flags);
 
 	if (IS_ERR(desc))
 		return desc;
-- 
2.37.2.789.g6183377224-goog

