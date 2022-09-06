Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6205ADEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiIFFCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFFB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:01:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C05FAE6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:01:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso13806817pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Ldy1JheZ7FCt/jxCBpowwGYgtHJwSVrIu+wqfaCl/vY=;
        b=nS/IBGO0rkxxmQBAJnHTCAVhZXQMmuvxeYcH4cs0a+YlhuWNKPCfsikPzsfr+LtkfS
         6dFJ5Am/5uICOdFpIGq/cx5Ty18vXBL5HjnMo25/A19VuntRo3kInFc5HXDwqXipYAXa
         lWfAnEwLa24gqV2ERkHMSTaM/oY4KPV5rCTgrmuDgm+veZmX3NhMMcfHii8y1J4o6Kb9
         Lw0bP2cIXWGns+aWg8QGuWN0SFgs2KVVSyTlxcBThiPpAceQ//nY5KRXd3hwpW+MT6js
         NWTXNndRl3RG92hAeaDqG4JS0NklRtEHizXIr+N822eajjg/pYzeW8CKOgACy83iNz4M
         6YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ldy1JheZ7FCt/jxCBpowwGYgtHJwSVrIu+wqfaCl/vY=;
        b=RHiCaIMamTj91TkuDhUj/7AsitBBUCQJI5KwggFjKS1tuWf+dCiG1L+VzKU9I8abr1
         nTgT/ljfYjPwUYmo9aArLNeXsBlFYKF3zDB04QXZT63ZR+8rjV8F9Ps0lm7lI3+d9D4Y
         hr0jQlvaDJS5pYdN6Sdi4/C1ASQJfWYnVT3as+pKaelA1k+61j7ZYdFk4ssjpiYXtHrc
         M4bTX/QZZr+gVVNrOASlBFEnC4719FniyUbzUvZvUh/EGAzhQ4ci9z0iGgTn8xP3j2mW
         oVS6CwN+sdYqCoqAb9enB0fpENirJsgC72cyeT1h8y3VhqqYNtk1JqzXY+WO/F2Px1ab
         qpYw==
X-Gm-Message-State: ACgBeo3bYWsnyYMHZYdZ4VFlJmeXaX89c/bLj7CRa0l3OFznuWpBcNfD
        kuLTqv8G6hUynmtBIff6WNXF0lDUuc0=
X-Google-Smtp-Source: AA6agR6eECcxcWLwzhSb2s5VjWwhFiSzmD6nMYitrRoHBLxpoQHYUvHfxSxhVHWM2Ica/isLr3/jyw==
X-Received: by 2002:a17:903:1ce:b0:16e:f510:6666 with SMTP id e14-20020a17090301ce00b0016ef5106666mr51788528plh.158.1662440511104;
        Mon, 05 Sep 2022 22:01:51 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id e15-20020aa798cf000000b005364e0ec330sm203458pfm.59.2022.09.05.22.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 22:01:50 -0700 (PDT)
Date:   Mon, 5 Sep 2022 22:01:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: stmpe: switch to using gpiod API
Message-ID: <YxbUO7WM0TbUBatv@google.com>
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

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/stmpe.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 987e251d90ae..0c4f74197d3e 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -8,14 +8,13 @@
  */
 
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/mfd/core.h>
@@ -30,17 +29,12 @@
  * @irq_trigger: IRQ trigger to use for the interrupt to the host
  * @autosleep: bool to enable/disable stmpe autosleep
  * @autosleep_timeout: inactivity timeout in milliseconds for autosleep
- * @irq_over_gpio: true if gpio is used to get irq
- * @irq_gpio: gpio number over which irq will be requested (significant only if
- *	      irq_over_gpio is true)
  */
 struct stmpe_platform_data {
 	int id;
 	unsigned int blocks;
 	unsigned int irq_trigger;
 	bool autosleep;
-	bool irq_over_gpio;
-	int irq_gpio;
 	int autosleep_timeout;
 };
 
@@ -1349,13 +1343,6 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 	if (pdata->id < 0)
 		pdata->id = -1;
 
-	pdata->irq_gpio = of_get_named_gpio_flags(np, "irq-gpio", 0,
-				&pdata->irq_trigger);
-	if (gpio_is_valid(pdata->irq_gpio))
-		pdata->irq_over_gpio = 1;
-	else
-		pdata->irq_trigger = IRQF_TRIGGER_NONE;
-
 	of_property_read_u32(np, "st,autosleep-timeout",
 			&pdata->autosleep_timeout);
 
@@ -1381,6 +1368,7 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 	struct stmpe_platform_data *pdata;
 	struct device_node *np = ci->dev->of_node;
 	struct stmpe *stmpe;
+	struct gpio_desc *irq_gpio;
 	int ret;
 	u32 val;
 
@@ -1434,18 +1422,20 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 	if (ci->init)
 		ci->init(stmpe);
 
-	if (pdata->irq_over_gpio) {
-		ret = devm_gpio_request_one(ci->dev, pdata->irq_gpio,
-				GPIOF_DIR_IN, "stmpe");
-		if (ret) {
-			dev_err(stmpe->dev, "failed to request IRQ GPIO: %d\n",
-					ret);
-			return ret;
-		}
+	irq_gpio = devm_gpiod_get_optional(ci->dev, "irq", GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(irq_gpio);
+	if (ret) {
+		dev_err(stmpe->dev, "failed to request IRQ GPIO: %d\n", ret);
+		return ret;
+	}
 
-		stmpe->irq = gpio_to_irq(pdata->irq_gpio);
+	if (irq_gpio) {
+		stmpe->irq = gpiod_to_irq(irq_gpio);
+		pdata->irq_trigger = gpiod_is_active_low(irq_gpio) ?
+					IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
 	} else {
 		stmpe->irq = ci->irq;
+		pdata->irq_trigger = IRQF_TRIGGER_NONE;
 	}
 
 	if (stmpe->irq < 0) {
-- 
2.37.2.789.g6183377224-goog


-- 
Dmitry
