Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B044D5B141B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIHFkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIHFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:39:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11432C139;
        Wed,  7 Sep 2022 22:39:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1247450pjh.3;
        Wed, 07 Sep 2022 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4ndLwzHd7G2+BP/PmRdBNLw7Z+LWVL1ULwxfQOZD3Zg=;
        b=VvZH1Nan9mNPl6toHs4zLiNvyjqFGWWD/OkX99q9ssGh3p9ikPUw4bv/ocCgzYiOr8
         ziUl9/REJovv27KQCo1oEvM4X5wVmd2NeaKam+vx/AsOgwJ/OtnEXbqLD8L8de87f5z/
         /XLDweAhqs0hqhMPD979QTI6qNcKoHXsdurT5Z59gZX+RjJNR5vejbWV24bk6c8tQ+Rz
         Fz6Zs74TNMGuKwRksG53cZC99D8toVwmSP22eReCj0dkcoON+FHvKIpEw+1IJ6vW/c2U
         f0GqgYElDOffSagrqv5HnqWYkC+U3Fl+6XaJJrRiEom+ks3tgv9iEejzvGfYNQUbaamQ
         lwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4ndLwzHd7G2+BP/PmRdBNLw7Z+LWVL1ULwxfQOZD3Zg=;
        b=fpFkWOTviuhrYr3MjJ0PXaYhQXUJbrXI9Ind+RU+jBLz5m+Cfk4IX5H6IRy2WF7pn8
         16bXaSL1gx0pXDnPzNNC5FibiQnxQNYiSq07y2jomyDPaIVoN7Wu+WnoWBd25uw7g3ln
         IyL4ZPI6v5a0oMu6K0Bxk4XUwCtZiq12MzrUmYjRM9XqalxWFXhgqXvhMOgoBIL4ds/q
         JiR38DxfpeanmvNriyGs/tCd1Fxp5ZCcTgcQIuIRnIjfuwhR2DRre8QE82M3VTYkr+Ii
         QZ7uYHm8rJsryIxH3u0LP+SVYywQG3SuY+M+5TIO6k3SuLEWNqZAL9Dj4JkCiQAoMomK
         S9cA==
X-Gm-Message-State: ACgBeo1czM6DCsXEgM0gM9aklQgdmzJp2Rka1zK+p90U2i5o1rW9ZzTO
        di99EURepVYZBIfKqKfwlY5lVzB/IXM=
X-Google-Smtp-Source: AA6agR5ILdtlYAXG0kdz5Vzm6Y0RMHh3SRXlaSwqewLw41FMSHjMuDhFrxHEox/BuJjv7+79XUS+Lg==
X-Received: by 2002:a17:90a:8581:b0:1fd:62e0:67cc with SMTP id m1-20020a17090a858100b001fd62e067ccmr2360732pjn.144.1662615594810;
        Wed, 07 Sep 2022 22:39:54 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7af1:2c0d:fbfa:b9d7])
        by smtp.gmail.com with ESMTPSA id i67-20020a626d46000000b0053e7d3b8d6dsm2685183pfc.1.2022.09.07.22.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:39:54 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] gpiolib: rework quirk handling in of_find_gpio()
Date:   Wed,  7 Sep 2022 22:39:48 -0700
Message-Id: <20220908053949.3564796-3-dmitry.torokhov@gmail.com>
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

Instead of having a string of "if" statements let's put all quirks into
an array and iterate over them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 62 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 30b89b694530..097e948c1d49 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -372,14 +372,12 @@ EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
  * properties should be named "foo-gpios" so we have this special kludge for
  * them.
  */
-static struct gpio_desc *of_find_spi_gpio(struct device *dev,
+static struct gpio_desc *of_find_spi_gpio(struct device_node *np,
 					  const char *con_id,
 					  unsigned int idx,
 					  enum of_gpio_flags *of_flags)
 {
 	char prop_name[32]; /* 32 is max size of property name */
-	const struct device_node *np = dev->of_node;
-	struct gpio_desc *desc;
 
 	/*
 	 * Hopefully the compiler stubs the rest of the function if this
@@ -395,8 +393,7 @@ static struct gpio_desc *of_find_spi_gpio(struct device *dev,
 	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
 	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
 
-	desc = of_get_named_gpiod_flags(np, prop_name, idx, of_flags);
-	return desc;
+	return of_get_named_gpiod_flags(np, prop_name, idx, of_flags);
 }
 
 /*
@@ -404,13 +401,11 @@ static struct gpio_desc *of_find_spi_gpio(struct device *dev,
  * lines rather than "cs-gpios" like all other SPI hardware. Account for this
  * with a special quirk.
  */
-static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
+static struct gpio_desc *of_find_spi_cs_gpio(struct device_node *np,
 					     const char *con_id,
 					     unsigned int idx,
 					     enum of_gpio_flags *of_flags)
 {
-	const struct device_node *np = dev->of_node;
-
 	if (!IS_ENABLED(CONFIG_SPI_MASTER))
 		return ERR_PTR(-ENOENT);
 
@@ -428,7 +423,7 @@ static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
 	 * uses just "gpios" so translate to that when "cs-gpios" is
 	 * requested.
 	 */
-	return of_get_named_gpiod_flags(dev->of_node, "gpios", idx, of_flags);
+	return of_get_named_gpiod_flags(np, "gpios", idx, of_flags);
 }
 
 /*
@@ -436,7 +431,7 @@ static struct gpio_desc *of_find_spi_cs_gpio(struct device *dev,
  * properties should be named "foo-gpios" so we have this special kludge for
  * them.
  */
-static struct gpio_desc *of_find_regulator_gpio(struct device *dev,
+static struct gpio_desc *of_find_regulator_gpio(struct device_node *np,
 						const char *con_id,
 						unsigned int idx,
 						enum of_gpio_flags *of_flags)
@@ -447,8 +442,6 @@ static struct gpio_desc *of_find_regulator_gpio(struct device *dev,
 		"wlf,ldo1ena", /* WM8994 */
 		"wlf,ldo2ena", /* WM8994 */
 	};
-	const struct device_node *np = dev->of_node;
-	struct gpio_desc *desc;
 	int i;
 
 	if (!IS_ENABLED(CONFIG_REGULATOR))
@@ -461,11 +454,10 @@ static struct gpio_desc *of_find_regulator_gpio(struct device *dev,
 	if (i < 0)
 		return ERR_PTR(-ENOENT);
 
-	desc = of_get_named_gpiod_flags(np, con_id, idx, of_flags);
-	return desc;
+	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
-static struct gpio_desc *of_find_arizona_gpio(struct device *dev,
+static struct gpio_desc *of_find_arizona_gpio(struct device_node *np,
 					      const char *con_id,
 					      unsigned int idx,
 					      enum of_gpio_flags *of_flags)
@@ -476,10 +468,10 @@ static struct gpio_desc *of_find_arizona_gpio(struct device *dev,
 	if (!con_id || strcmp(con_id, "wlf,reset"))
 		return ERR_PTR(-ENOENT);
 
-	return of_get_named_gpiod_flags(dev->of_node, con_id, idx, of_flags);
+	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
-static struct gpio_desc *of_find_usb_gpio(struct device *dev,
+static struct gpio_desc *of_find_usb_gpio(struct device_node *np,
 					  const char *con_id,
 					  unsigned int idx,
 					  enum of_gpio_flags *of_flags)
@@ -495,14 +487,27 @@ static struct gpio_desc *of_find_usb_gpio(struct device *dev,
 	if (!con_id || strcmp(con_id, "fcs,int_n"))
 		return ERR_PTR(-ENOENT);
 
-	return of_get_named_gpiod_flags(dev->of_node, con_id, idx, of_flags);
+	return of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 }
 
+typedef struct gpio_desc *(*of_find_gpio_quirk)(struct device_node *np,
+						const char *con_id,
+						unsigned int idx,
+						enum of_gpio_flags *of_flags);
+static const of_find_gpio_quirk of_find_gpio_quirks[] = {
+	of_find_spi_gpio,
+	of_find_spi_cs_gpio,
+	of_find_regulator_gpio,
+	of_find_arizona_gpio,
+	of_find_usb_gpio,
+};
+
 struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			       unsigned int idx, unsigned long *flags)
 {
 	char prop_name[32]; /* 32 is max size of property name */
 	enum of_gpio_flags of_flags;
+	const of_find_gpio_quirk *q;
 	struct gpio_desc *desc;
 	unsigned int i;
 
@@ -522,24 +527,9 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			break;
 	}
 
-	if (gpiod_not_found(desc)) {
-		/* Special handling for SPI GPIOs if used */
-		desc = of_find_spi_gpio(dev, con_id, idx, &of_flags);
-	}
-
-	if (gpiod_not_found(desc))
-		desc = of_find_spi_cs_gpio(dev, con_id, idx, &of_flags);
-
-	if (gpiod_not_found(desc)) {
-		/* Special handling for regulator GPIOs if used */
-		desc = of_find_regulator_gpio(dev, con_id, idx, &of_flags);
-	}
-
-	if (gpiod_not_found(desc))
-		desc = of_find_arizona_gpio(dev, con_id, idx, &of_flags);
-
-	if (gpiod_not_found(desc))
-		desc = of_find_usb_gpio(dev, con_id, idx, &of_flags);
+	/* Properly named GPIO was not found, try workarounds */
+	for (q = of_find_gpio_quirks; gpiod_not_found(desc) && *q; q++)
+		desc = (*q)(dev->of_node, con_id, idx, &of_flags);
 
 	if (IS_ERR(desc))
 		return desc;
-- 
2.37.2.789.g6183377224-goog

