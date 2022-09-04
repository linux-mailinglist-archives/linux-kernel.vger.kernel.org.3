Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4B5AC2F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 08:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiIDGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDGSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 02:18:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49847B8E;
        Sat,  3 Sep 2022 23:18:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q3so5647244pjg.3;
        Sat, 03 Sep 2022 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Z5Z7qmFlLuSsO+xrvib6T+DJgQPde93L9BX7g1MGlqg=;
        b=YMXHpZgxEL3K25/6l4BSOlTH1qIIyOs6HeCiAmodYfAOXiD6rgPjPyzL3grdZiOeCm
         O0NB5gFTV99R3tiri/MlVGQtAmYiZmktFzoH+ZBxkfzib47I0rpCuJSxtGHyc/yhbIXw
         so/jNUoxt/TZWGB6hXAs4IOw65lV4RovymEXkueS64g6GIPIlZS6Vw+riG8EeePYrQyA
         n8mdHFJJwrSpKFSxkvNZVpfkBFEbnkksA6oGjrJMTBTeCgi6wHeejEzEu8ZAVE4TFZYC
         HHc8sUEGpw596pfjvfgEAN8VylygFFXTJ7HafWrfiDl+m/4243g7SG47zi5q09Ugitev
         n2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z5Z7qmFlLuSsO+xrvib6T+DJgQPde93L9BX7g1MGlqg=;
        b=gggq79AyKIAdquwfJmYxyQT8fRzDJ8kA1hV8zkd4f9oXbGS8Ct/Hy1bM3OmxGzG33D
         NlJahp0OFaDkGbeY91Oy6WzJZ2hY6WfN4Iuwm9h+R4aAFNsAc4eG1wheQXRVLGmme6FK
         5sTYPlmreUfBKT/GyXjaWSC7EBSzI0yiOll7l3fdKCHZ+8kBcacWyHPRAvfJ00MerzXN
         hehWsaBgknBKVZdM+T/A74ENzvuly+NRx0M538roZhFsOkwZ90JsR8OzxB0O2e0lkLK4
         vhnwa8Oa7wPn2ls+rNW3+CmmD+7EqqvILXSBIKinz4r6d1Rn4sN4Qptpgpo5jZtj0rF5
         0fuw==
X-Gm-Message-State: ACgBeo1O9shOgy/x6K9l2Lntvczw3UbgmWF/oN0seVYxM0frgNOIwKx7
        4eGF6d1CpLSnH7+ALBHi5X0=
X-Google-Smtp-Source: AA6agR49R6kFtjVZXoTHH6HrxeRTdFXMT+DA+lJxZGG2OSqBvKBx7VB0GlQnKynpqDoynD1x79AO+w==
X-Received: by 2002:a17:90a:19d:b0:1f7:2b1a:947a with SMTP id 29-20020a17090a019d00b001f72b1a947amr13633131pjc.118.1662272330987;
        Sat, 03 Sep 2022 23:18:50 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4c3e:ab6a:7205:f32f])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090a108f00b001fb971bc612sm7945384pja.36.2022.09.03.23.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 23:18:50 -0700 (PDT)
Date:   Sat, 3 Sep 2022 23:18:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: make fwnode_get_named_gpiod() static
Message-ID: <YxRDRx3oubAISIB0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no external users of fwnode_get_named_gpiod() anymore, so
let's stop exporting it and mark it as static.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/gpio/gpiolib.c        | 132 +++++++++++++++++-----------------
 include/linux/gpio/consumer.h |  13 ----
 2 files changed, 66 insertions(+), 79 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cc9c0a12259e..4756ea08894f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3798,6 +3798,72 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	return count;
 }
 
+/**
+ * fwnode_get_named_gpiod - obtain a GPIO from firmware node
+ * @fwnode:	handle of the firmware node
+ * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain for the consumer
+ * @dflags:	GPIO initialization flags
+ * @label:	label to attach to the requested GPIO
+ *
+ * This function can be used for drivers that get their configuration
+ * from opaque firmware.
+ *
+ * The function properly finds the corresponding GPIO using whatever is the
+ * underlying firmware interface and then makes sure that the GPIO
+ * descriptor is requested before it is returned to the caller.
+ *
+ * Returns:
+ * On successful request the GPIO pin is configured in accordance with
+ * provided @dflags.
+ *
+ * In case of error an ERR_PTR() is returned.
+ */
+static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
+						const char *propname, int index,
+						enum gpiod_flags dflags,
+						const char *label)
+{
+	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
+	struct gpio_desc *desc = ERR_PTR(-ENODEV);
+	int ret;
+
+	if (is_of_node(fwnode)) {
+		desc = gpiod_get_from_of_node(to_of_node(fwnode),
+					      propname, index,
+					      dflags,
+					      label);
+		return desc;
+	} else if (is_acpi_node(fwnode)) {
+		struct acpi_gpio_info info;
+
+		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
+		if (IS_ERR(desc))
+			return desc;
+
+		acpi_gpio_update_gpiod_flags(&dflags, &info);
+		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
+	} else {
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Currently only ACPI takes this path */
+	ret = gpiod_request(desc, label);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
+	if (ret < 0) {
+		gpiod_put(desc);
+		return ERR_PTR(ret);
+	}
+
+	blocking_notifier_call_chain(&desc->gdev->notifier,
+				     GPIOLINE_CHANGED_REQUESTED, desc);
+
+	return desc;
+}
+
 /**
  * fwnode_gpiod_get_index - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
@@ -4063,72 +4129,6 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(gpiod_get_index);
 
-/**
- * fwnode_get_named_gpiod - obtain a GPIO from firmware node
- * @fwnode:	handle of the firmware node
- * @propname:	name of the firmware property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * This function can be used for drivers that get their configuration
- * from opaque firmware.
- *
- * The function properly finds the corresponding GPIO using whatever is the
- * underlying firmware interface and then makes sure that the GPIO
- * descriptor is requested before it is returned to the caller.
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
-	struct gpio_desc *desc = ERR_PTR(-ENODEV);
-	int ret;
-
-	if (is_of_node(fwnode)) {
-		desc = gpiod_get_from_of_node(to_of_node(fwnode),
-					      propname, index,
-					      dflags,
-					      label);
-		return desc;
-	} else if (is_acpi_node(fwnode)) {
-		struct acpi_gpio_info info;
-
-		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
-		if (IS_ERR(desc))
-			return desc;
-
-		acpi_gpio_update_gpiod_flags(&dflags, &info);
-		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
-	} else
-		return ERR_PTR(-EINVAL);
-
-	/* Currently only ACPI takes this path */
-	ret = gpiod_request(desc, label);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
-	if (ret < 0) {
-		gpiod_put(desc);
-		return ERR_PTR(ret);
-	}
-
-	blocking_notifier_call_chain(&desc->gdev->notifier,
-				     GPIOLINE_CHANGED_REQUESTED, desc);
-
-	return desc;
-}
-EXPORT_SYMBOL_GPL(fwnode_get_named_gpiod);
-
 /**
  * gpiod_get_index_optional - obtain an optional GPIO from a multi-index GPIO
  *                            function
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 37448ee17e81..cf7d64b0ced3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -174,10 +174,6 @@ int desc_to_gpio(const struct gpio_desc *desc);
 /* Child properties interface */
 struct fwnode_handle;
 
-struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
 					 enum gpiod_flags flags,
@@ -553,15 +549,6 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 /* Child properties interface */
 struct fwnode_handle;
 
-static inline
-struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 static inline
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
-- 
2.37.2.789.g6183377224-goog


-- 
Dmitry
