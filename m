Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF94CE59A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 16:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiCEPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 10:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEPnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 10:43:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285211DD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 07:43:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r129-20020a1c4487000000b003898fc06f1eso79867wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5knFVechqLRRoXBkQeiWnLlTmYCcvi5f90+imAg2cOY=;
        b=6GIQsk7E60HvmrJlWOB81ghr8WfFAcCK+WRKuC0zMYbLUAyMbvPV3UGg/4t9Ex/Izw
         j0J1Q1P1AgBIk1cRAD0yuuE4KPHIsoZZOPhdJLF7p+MH+eb3XMzhgYWdiaocbjGb+MPi
         mTql/YSVVPTp8YJse7dT4MJH/H3lkmCbTFp5mGSLlemQlXdewTib1NRWfljatEvLBjBD
         56ygfhUrASNeL59k33XDDaT0fozZKeizkB1kEK4YwnkI5eLQzmWWol2w29OwcUH0wM1j
         Sb8aCjZ6N3XDpjvFP1qu6LASl0WNJ35/lkCCUvi/JhfpgbDdxGYdgutd/uuvDUX5jShU
         m+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5knFVechqLRRoXBkQeiWnLlTmYCcvi5f90+imAg2cOY=;
        b=A+52iejXagem/2S6BtyLJIizZRm+tB9igYCIsyMXcHr+sFXBTPg9FokIg4RCqYWgZ1
         KvmN6E64N01OGenqzEHjbkX9Omw3bcvK+CodN5spc6K6aEEKwrARZinyQSdhDA1vgENY
         013pVYhoSHW7V8pNPNIcCsMIo1nLgn604M5ZcUyQc8R6P3mnV33vMGZtndL/7AxD3jLE
         PBAwGY7CYgoNdQDvcHrnOdr9aAxBVoQI8SqfMDWEqKTg5fxDA3OdnY+tbJJbuRaB5Gwy
         A00QTJqdhGYsYAaDZLUW+SAPSuFfoZCTMQWgGP2+LXrvIGifYkqq1JxhIRReK1ULn4eD
         eZyg==
X-Gm-Message-State: AOAM533Rp+1J3a0ROLdG2IhMJvWKrjNfQOYClcXmK9SuYOUze6X3nySg
        2TMbCHhcDAoWGhZzcZMx6NMyqA==
X-Google-Smtp-Source: ABdhPJy+SNKXJeLTJy8POUvyAoiHW/OMNnPo+MkaECuSUorkrJ9qGUSpWqPl+BU0JFsdnVH8sPrg1w==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr12016162wmm.17.1646494978708;
        Sat, 05 Mar 2022 07:42:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b001a65e479d20sm6758970wrb.83.2022.03.05.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 07:42:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpiolib: fix the size of the ngpios variable
Date:   Sat,  5 Mar 2022 16:42:56 +0100
Message-Id: <20220305154256.278394-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ngpio fields both in struct gpio_device as well as gpio_chip are
16 bit unsigned integers. Let's not risk an overflow and use the correct
size when reading the device property.

Fixes: 9dbd1ab20509 ("gpiolib: check the 'ngpios' property in core gpiolib code")
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a3d14277f17c..147b86db16aa 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -607,7 +607,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = gc->base;
 	unsigned int i;
 	int ret = 0;
-	u32 ngpios;
+	u16 ngpios;
 
 	if (gc->fwnode)
 		fwnode = gc->fwnode;
@@ -665,7 +665,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 * of GPIO lines.
 	 */
 	if (gc->ngpio == 0) {
-		ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
+		ret = device_property_read_u16(&gdev->dev, "ngpios", &ngpios);
 		if (ret == -ENODATA)
 			/*
 			 * -ENODATA means that there is no property found and
-- 
2.30.1

