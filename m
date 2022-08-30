Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAC5A717B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiH3XQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiH3XQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:16 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D958508
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v15so4016310iln.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7ZEan4dUIr4kyidENcq5otkByPrODYTGYAeqI0A8+e8=;
        b=LApH22aYoOcy5NnYQugoO/J3M0CLi/hfdEKlV68a+FlU9/g3ppYT09Zb9kwyhIgWaS
         ZP/wtdixww0XHWj3JGOcKhrVNTbf9U6p5+OfIczWxQzjErD9UQbQCP7+Y5bVswEAuUqo
         GrsQUy3M1h78ragkpBl15xJRDPorgcgvNIJlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7ZEan4dUIr4kyidENcq5otkByPrODYTGYAeqI0A8+e8=;
        b=D4dZQLnxu48mDmk1JArhgMCjcEiQr8mPNiaRxHZCqblfHBRsv+GegHLAhZG3v/Ff12
         2AbcRa27qd8fCVdehTSUWzmElAJtwbiS9biGac3hirJ0cAsb+15wTPW+66hH/MBQp99p
         6/7RrOWng8QdUW4gNtsMUM8Fb+9Hg6IGw5q3d2f3W3dtzFNsJx9xDpr4yjD/1x2deStR
         xi/Ms+c8Ky4CDOIBX8nWVVB67YcJrl8klZpZs5q/K8vVknAfzOsl1liNDoOuNitwG683
         zD49REO+PUZwPfd+baIkSviMyWGnxgS6EYtDcshZBrr655omu5x23l/TV5kts1QzW+ih
         pLkQ==
X-Gm-Message-State: ACgBeo3lNbfvCW3si8bYbuaf4kfRHeX9D55OM2bEJEhlJkYq6rBR5/9k
        tUb+rXYMkXjLs/1KDE7VNbLwlA==
X-Google-Smtp-Source: AA6agR5otYu8crgU35WEswV0uWH0vHlaPxNiC7sb/8ztwtwmzx04J0ktO27LDEvZ2EzTGwJlWRPoGA==
X-Received: by 2002:a92:4449:0:b0:2de:95f1:8b80 with SMTP id a9-20020a924449000000b002de95f18b80mr13223148ilm.232.1661901374643;
        Tue, 30 Aug 2022 16:16:14 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:14 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] gpiolib: acpi: Add wake_capable parameter to acpi_dev_gpio_irq_get_by
Date:   Tue, 30 Aug 2022 17:15:36 -0600
Message-Id: <20220830171332.3.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI spec defines the SharedAndWake and ExclusiveAndWake share type
keywords. This is an indication that the GPIO IRQ can also be used as a
wake source. This change exposes the wake_capable bit so drivers can
correctly enable wake functionality instead of making an assumption.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/gpio/gpio-pca953x.c |  3 ++-
 drivers/gpio/gpiolib-acpi.c | 11 ++++++++++-
 drivers/gpio/gpiolib-acpi.h |  2 ++
 include/linux/acpi.h        | 14 +++++++++++---
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ecd7d169470b06..df02c3eb34a294 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -130,7 +130,8 @@ static int pca953x_acpi_get_irq(struct device *dev)
 	if (ret)
 		dev_warn(dev, "can't add GPIO ACPI mapping\n");
 
-	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0);
+	ret = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(dev), "irq-gpios", 0,
+				       NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 9be1376f9a627f..5cda2fcf7f43df 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -741,6 +741,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.debounce = agpio->debounce_timeout;
 		lookup->info.gpioint = gpioint;
+		lookup->info.wake_capable = agpio->wake_capable;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
@@ -991,6 +992,7 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * @adev: pointer to a ACPI device to get IRQ from
  * @name: optional name of GpioInt resource
  * @index: index of GpioInt resource (starting from %0)
+ * @wake_capable: Set to 1 if the IRQ is wake capable
  *
  * If the device has one or more GpioInt resources, this function can be
  * used to translate from the GPIO offset in the resource to the Linux IRQ
@@ -1002,9 +1004,13 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * The function takes optional @name parameter. If the resource has a property
  * name, then only those will be taken into account.
  *
+ * The GPIO is considered wake capable if GpioInt specifies SharedAndWake or
+ * ExclusiveAndWake.
+ *
  * Return: Linux IRQ number (> %0) on success, negative errno on failure.
  */
-int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index)
+int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
+			     int index, int *wake_capable)
 {
 	int idx, i;
 	unsigned int irq_flags;
@@ -1061,6 +1067,9 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
 				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
 			}
 
+			if (wake_capable)
+				*wake_capable = info.wake_capable;
+
 			return irq;
 		}
 
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index e476558d947136..1ac6816839dbce 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -18,6 +18,7 @@ struct acpi_device;
  * @pin_config: pin bias as provided by ACPI
  * @polarity: interrupt polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
+ * @wake_capable: wake capability as provided by ACPI
  * @debounce: debounce timeout as provided by ACPI
  * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
  */
@@ -28,6 +29,7 @@ struct acpi_gpio_info {
 	int pin_config;
 	int polarity;
 	int triggering;
+	bool wake_capable;
 	unsigned int debounce;
 	unsigned int quirks;
 };
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc5479..7ee946758c5bcc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1202,7 +1202,8 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio);
-int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index);
+int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
+			     int index, int *wake_capable);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
@@ -1215,7 +1216,8 @@ static inline bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 	return false;
 }
 static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
-					   const char *name, int index)
+					   const char *name, int index,
+					   int *wake_capable)
 {
 	return -ENXIO;
 }
@@ -1223,7 +1225,13 @@ static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
 
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
-	return acpi_dev_gpio_irq_get_by(adev, NULL, index);
+	return acpi_dev_gpio_irq_get_by(adev, NULL, index, NULL);
+}
+
+static inline int acpi_dev_gpio_irq_get_wake(struct acpi_device *adev,
+					     int index, int *wake_capable)
+{
+	return acpi_dev_gpio_irq_get_by(adev, NULL, index, wake_capable);
 }
 
 /* Device properties */
-- 
2.37.2.672.g94769d06f0-goog

