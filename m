Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C19466499
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358295AbhLBNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346862AbhLBNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:44:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260EC061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 05:40:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t9so42746951wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/zjxVoZQh++FPpbJ/CZnvxguhK2M34uqFGsoutqJOs=;
        b=QHuxgQ3OEeVvQKCD8zkc7wkuya4ZofcO4drj/2f5m8xI57DSdCJ4DByBgWyLd+ElyR
         Mqjb32vFI475BQ9ppsyqvDA7Kwl5gkp7b3VB71BSJqE9AV72y67zEKItNtcCAuqn/jZY
         XGzhESVMFy1djJo57XajNnU/2kQ0wfVxX1fDsrjqqmpoWtydF6yPAvCfhosd2MPiqgDa
         ntw0DxFl6AnS4QJb9vjI+91gIMSBBPSZrT5EV/V35n00kqlbyN1xKG8o9psTXTQeeE+6
         EFjpbLksmko98uzE6qVEEoNvjBsBos2tGcv1HQlBfzgfUJB8kxwqk0VkYMfiJGPi1NN0
         q6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/zjxVoZQh++FPpbJ/CZnvxguhK2M34uqFGsoutqJOs=;
        b=lUm7A5ViFacSJPL21V+oQPcbxBQdexqW5pqXHigz7PZSAOODeDSGPnZSV9EQs/Rb3t
         gk96RATAk5kuXOqBvRyNw35yhHRuQ37b4zH5ttanuLmGQODfCHuCIqwxnioWuLL8YlwD
         7koLPGS578pIcpnoVGlbCttm/Kg48yqzeDF001e7A6A6Qe1biIBoNyLAMGWcUhbGTEtv
         ZjKWm4jrm3+TYLTeyO1kiHMe/V6nlFiTmUoHLyInNVwOAKClNBHJYHR0djkHAHmPvTmG
         +skAjEylN1RbgvOYbynmmqhALZOFlyblR38ZGKZX3chXA/4IMbI2cLzhhDlb/AmHRkJl
         IYZA==
X-Gm-Message-State: AOAM532csIUbqCesmJhX1n+cZQIBu2vqtHIqJPvftXPe8qh7vd3SYqTh
        Q9T0l0ltKCBVsE+97CyeTANc4w==
X-Google-Smtp-Source: ABdhPJy36F01foZeGeqTbCOZ1V0AxIhVD+1OtHsq9HLzzkTDzMVwAw1CS1fr94wx2VwYv692WVVB6A==
X-Received: by 2002:adf:a193:: with SMTP id u19mr14648689wru.563.1638452437319;
        Thu, 02 Dec 2021 05:40:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id x13sm2660590wrr.47.2021.12.02.05.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 05:40:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 2/2] gpiolib: check the 'ngpios' property in core gpiolib code
Date:   Thu,  2 Dec 2021 14:40:34 +0100
Message-Id: <20211202134034.14048-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211202134034.14048-1-brgl@bgdev.pl>
References: <20211202134034.14048-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers read the 'ngpios' device property on their own, but
since it's defined as a standard GPIO property in the device tree bindings
anyway, it's a good candidate for generalization. If the driver didn't
set its gc->ngpio, try to read the 'ngpios' property from the GPIO
device's firmware node before bailing out.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
v1 -> v2:
- use device_property_read_u32() instead of fwnode_property_read_u32()
- reverse the error check logic

v2 -> v3:
- don't shadow errors other than -ENODATA in device_property_read_u32()

v3 -> v4:
- also make sure we return -EINVAL when the device 'ngpios' property is
  set to 0 (thanks Andy!)

 drivers/gpio/gpiolib.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ede8b8a7aa18..bd9b8cb53476 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -599,6 +599,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	int base = gc->base;
 	unsigned int i;
 	int ret = 0;
+	u32 ngpios;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
@@ -646,6 +647,26 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		goto err_free_dev_name;
 	}
 
+	/*
+	 * Try the device properties if the driver didn't supply the number
+	 * of GPIO lines.
+	 */
+	if (gc->ngpio == 0) {
+		ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
+		if (ret == -ENODATA)
+			/*
+			 * -ENODATA means that there is no property found and
+			 * we want to issue the error message to the user.
+			 * Besides that, we want to return different error code
+			 * to state that supplied value is not valid.
+			 * */
+			ngpios = 0;
+		else if (ret)
+			goto err_free_descs;
+
+		gc->ngpio = ngpios;
+	}
+
 	if (gc->ngpio == 0) {
 		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
 		ret = -EINVAL;
-- 
2.25.1

