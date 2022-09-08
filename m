Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DFE5B1426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIHFkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIHFka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:40:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E56524B;
        Wed,  7 Sep 2022 22:40:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1266943pjk.0;
        Wed, 07 Sep 2022 22:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dr3pXN+e6v0u95/FxhAXJ2MxZA/HTSueP83RioH1BJE=;
        b=VuXDEhmMWoww3dex6SMpIwyriMwl71bhKntVwMWfcw+3uimJ5hDp/etGXcZDEAbNUA
         nN7P0HcRKWmuULJ7EgE6LsWjDtbd1DK32QwgP7H+AHomax2bQsLoBrAFTqFFPX4ek1uQ
         99g8BeKw/VOlpeXlIBF6VK6tkjcNHjCy/DKHlfwYTEwwF5/Riy+gV14Bvy9rC4Z6Xup7
         yW/mVXVsucvuLOkM7QHhyquIpqvY5bhaU+xeTS2pIs0AcFovgVF1M1TKgxGTzCKnlRbU
         tkTLvavxIjrDsIL8/YqUhK5c0OrR/ns1R69qdwm3YFFYW4Gg9iTWttM4VTdxJWmyQhlW
         vRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dr3pXN+e6v0u95/FxhAXJ2MxZA/HTSueP83RioH1BJE=;
        b=ATlOg375xSfaKIBxYTbNUa8pyT9ZcTXO5VYugAvZx/LFN4q3L/wWTc8mYfOKva5RIk
         YdewsS+bPQknRH2bnNAY8NV0uyVPVw+Uft0//QYIlPjtXB0vkZY2EwfH6UtV0rc37qy6
         pt01uA8Wmkzb2WIksmNzho2u2uhmcg9d73CYHUGuglQKuTc0lseiUf3i2UAOcucMyfXe
         psmOvSKgHunxWMwZhRreL/UmPsl5Xcbffat9Nl6vNT3QrqSir6Rr4hXjfy//SNqbUH8o
         j/9ysDruPSDiR0/TxhZIvvXfre+mfMF2MD4C6/Ta/fbWrKvdTVEeUb9gAqnEGqOrXXaE
         08ng==
X-Gm-Message-State: ACgBeo0tDeEQ76qxh/27/0cpRqZlAURa6+3ELJOIlac1k8N8Os5InoF+
        zf8SP6/a/CmucaK71TR/Wiw=
X-Google-Smtp-Source: AA6agR5ug9c390h07f6ZodxrKWh3b6aS6x/6IGKqnRERoG4OmRKaBOcSKPwJGIZ5w/4kLixVTq9Lmw==
X-Received: by 2002:a17:90b:17ca:b0:200:b25e:cd7c with SMTP id me10-20020a17090b17ca00b00200b25ecd7cmr2339469pjb.53.1662615596296;
        Wed, 07 Sep 2022 22:39:56 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7af1:2c0d:fbfa:b9d7])
        by smtp.gmail.com with ESMTPSA id i67-20020a626d46000000b0053e7d3b8d6dsm2685183pfc.1.2022.09.07.22.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 22:39:55 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] gpiolib: of: factor out conversion from OF flags
Date:   Wed,  7 Sep 2022 22:39:49 -0700
Message-Id: <20220908053949.3564796-4-dmitry.torokhov@gmail.com>
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

There are several places where we need to convert from OF flags to
"normal" GPIO_* flags, so let's introduce a helper and use it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib-of.c | 103 ++++++++++++++------------------------
 1 file changed, 37 insertions(+), 66 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 097e948c1d49..95be5f0d2623 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -289,6 +289,36 @@ int of_get_named_gpio_flags(const struct device_node *np, const char *list_name,
 }
 EXPORT_SYMBOL_GPL(of_get_named_gpio_flags);
 
+/* Converts gpio_lookup_flags into bitmask of GPIO_* values */
+static unsigned long of_convert_gpio_flags(enum of_gpio_flags flags)
+{
+	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+
+	if (flags & OF_GPIO_ACTIVE_LOW)
+		lflags |= GPIO_ACTIVE_LOW;
+
+	if (flags & OF_GPIO_SINGLE_ENDED) {
+		if (flags & OF_GPIO_OPEN_DRAIN)
+			lflags |= GPIO_OPEN_DRAIN;
+		else
+			lflags |= GPIO_OPEN_SOURCE;
+	}
+
+	if (flags & OF_GPIO_TRANSITORY)
+		lflags |= GPIO_TRANSITORY;
+
+	if (flags & OF_GPIO_PULL_UP)
+		lflags |= GPIO_PULL_UP;
+
+	if (flags & OF_GPIO_PULL_DOWN)
+		lflags |= GPIO_PULL_DOWN;
+
+	if (flags & OF_GPIO_PULL_DISABLE)
+		lflags |= GPIO_PULL_DISABLE;
+
+	return lflags;
+}
+
 /**
  * gpiod_get_from_of_node() - obtain a GPIO from an OF node
  * @node:	handle of the OF node
@@ -308,26 +338,14 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 					 enum gpiod_flags dflags,
 					 const char *label)
 {
-	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	unsigned long lflags;
 	struct gpio_desc *desc;
-	enum of_gpio_flags flags;
-	bool active_low = false;
-	bool single_ended = false;
-	bool open_drain = false;
-	bool transitory = false;
+	enum of_gpio_flags of_flags;
 	int ret;
 
-	desc = of_get_named_gpiod_flags(node, propname,
-					index, &flags);
-
-	if (!desc || IS_ERR(desc)) {
+	desc = of_get_named_gpiod_flags(node, propname, index, &of_flags);
+	if (!desc || IS_ERR(desc))
 		return desc;
-	}
-
-	active_low = flags & OF_GPIO_ACTIVE_LOW;
-	single_ended = flags & OF_GPIO_SINGLE_ENDED;
-	open_drain = flags & OF_GPIO_OPEN_DRAIN;
-	transitory = flags & OF_GPIO_TRANSITORY;
 
 	ret = gpiod_request(desc, label);
 	if (ret == -EBUSY && (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
@@ -335,27 +353,7 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (active_low)
-		lflags |= GPIO_ACTIVE_LOW;
-
-	if (single_ended) {
-		if (open_drain)
-			lflags |= GPIO_OPEN_DRAIN;
-		else
-			lflags |= GPIO_OPEN_SOURCE;
-	}
-
-	if (transitory)
-		lflags |= GPIO_TRANSITORY;
-
-	if (flags & OF_GPIO_PULL_UP)
-		lflags |= GPIO_PULL_UP;
-
-	if (flags & OF_GPIO_PULL_DOWN)
-		lflags |= GPIO_PULL_DOWN;
-
-	if (flags & OF_GPIO_PULL_DISABLE)
-		lflags |= GPIO_PULL_DISABLE;
+	lflags = of_convert_gpio_flags(of_flags);
 
 	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
@@ -534,25 +532,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	if (IS_ERR(desc))
 		return desc;
 
-	if (of_flags & OF_GPIO_ACTIVE_LOW)
-		*flags |= GPIO_ACTIVE_LOW;
-
-	if (of_flags & OF_GPIO_SINGLE_ENDED) {
-		if (of_flags & OF_GPIO_OPEN_DRAIN)
-			*flags |= GPIO_OPEN_DRAIN;
-		else
-			*flags |= GPIO_OPEN_SOURCE;
-	}
-
-	if (of_flags & OF_GPIO_TRANSITORY)
-		*flags |= GPIO_TRANSITORY;
-
-	if (of_flags & OF_GPIO_PULL_UP)
-		*flags |= GPIO_PULL_UP;
-	if (of_flags & OF_GPIO_PULL_DOWN)
-		*flags |= GPIO_PULL_DOWN;
-	if (of_flags & OF_GPIO_PULL_DISABLE)
-		*flags |= GPIO_PULL_DISABLE;
+	*flags = of_convert_gpio_flags(of_flags);
 
 	return desc;
 }
@@ -610,16 +590,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 	if (IS_ERR(desc))
 		return desc;
 
-	if (xlate_flags & OF_GPIO_ACTIVE_LOW)
-		*lflags |= GPIO_ACTIVE_LOW;
-	if (xlate_flags & OF_GPIO_TRANSITORY)
-		*lflags |= GPIO_TRANSITORY;
-	if (xlate_flags & OF_GPIO_PULL_UP)
-		*lflags |= GPIO_PULL_UP;
-	if (xlate_flags & OF_GPIO_PULL_DOWN)
-		*lflags |= GPIO_PULL_DOWN;
-	if (xlate_flags & OF_GPIO_PULL_DISABLE)
-		*lflags |= GPIO_PULL_DISABLE;
+	*lflags = of_convert_gpio_flags(xlate_flags);
 
 	if (of_property_read_bool(np, "input"))
 		*dflags |= GPIOD_IN;
-- 
2.37.2.789.g6183377224-goog

