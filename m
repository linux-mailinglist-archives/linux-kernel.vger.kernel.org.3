Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5365749632B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379053AbiAUQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378980AbiAUQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:26 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68DC06173B;
        Fri, 21 Jan 2022 08:54:26 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q186so14347327oih.8;
        Fri, 21 Jan 2022 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+onRDSB8NBPE12vkU5FSeD+tqXtPtVIIqSZAFj9Gqb8=;
        b=VV0tazK7JhQqvueYD1I/rC7s9R8HgpUIHqZqhR0so78OUBIyxJzsOkZkyJNytnuH7E
         8/O7RYFDXW+m/2+S3G2iaeCYXRKOQbxjyBtfnVarWEzqFkEXXDl3a+GJpNvA3sM80C95
         WuRWMpBE7RWUc93hiZl44IJ9aFgyDh6wqo4DW90F6w6rMrEv82svtmvyjBfGRb8cut8/
         2SBxiOwNDSBRpIXXJ87wFFU6h+UWqFA2sBo+NxfJsuUo4Jt3EDjJCiy4dHf03oZfGYwf
         pG/cb31Cj2GH81TFWwKHFwFng9ad7x6gluu3fQaKgahICi8VznMMQJFRSudA0gAb/DJY
         TDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+onRDSB8NBPE12vkU5FSeD+tqXtPtVIIqSZAFj9Gqb8=;
        b=yZ87zy1JOiMiIyqjEBZeOmwh1jdpJWwn9Zvr0KqOx78ENNM3aSz8xnCmFjS7OQFw6u
         aOZZh9vdfh7dAmkNqKrr77Pr2FXUm3n1Rw7WsbRAhhCq2c7oFkbVsMsmxB2QD3cVmhfh
         tBvgFWxNGrI5lCfoV7lQsidZ5IjI32LwOAtZqMR2t7dVBMMAUfSykkBEhr4jWj+VPmUc
         ANv+0txlyxhZSWJ2d8HgcpAGwSfi84kYBZB7MubI0TytZkVAbG+9HSkamF9ZQHVtlobm
         8WGdx1SbplS0hHq928Rc2dmqhGsBQOIhwAqvzmYBbJWeWBwR7+MD4dX2TThsHqr2xU8a
         0Mkw==
X-Gm-Message-State: AOAM531tSO7v2NQcmSHksFN6oJE8PZ/cnXMVnY7WjXqUsKxvxXEcJhRS
        lHZwP6mQVUohSKaHlP86Yfo=
X-Google-Smtp-Source: ABdhPJzH/cMZPe1PawEcN7hDEZjfPuESpYNcLZvMMWhAMFkqLEdpxOA/Lmu+Qc3XChTtI6z7i2zqIg==
X-Received: by 2002:a05:6808:1709:: with SMTP id bc9mr1280338oib.130.1642784065694;
        Fri, 21 Jan 2022 08:54:25 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:25 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH 04/31] iio: light: cm3605: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:09 -0300
Message-Id: <20220121165436.30956-5-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/iio/light/cm3605.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 50d34a98839c..f60db6cd9e6d 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -238,7 +238,7 @@ static int cm3605_probe(struct platform_device *pdev)
 
 	/* Just name the trigger the same as the driver */
 	led_trigger_register_simple("cm3605", &cm3605->led);
-	led_trigger_event(cm3605->led, LED_FULL);
+	led_trigger_event(cm3605->led, 255);
 
 	indio_dev->info = &cm3605_info;
 	indio_dev->name = "cm3605";
@@ -255,7 +255,7 @@ static int cm3605_probe(struct platform_device *pdev)
 	return 0;
 
 out_remove_trigger:
-	led_trigger_event(cm3605->led, LED_OFF);
+	led_trigger_event(cm3605->led, 0);
 	led_trigger_unregister_simple(cm3605->led);
 out_disable_aset:
 	gpiod_set_value_cansleep(cm3605->aset, 0);
@@ -269,7 +269,7 @@ static int cm3605_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
 
-	led_trigger_event(cm3605->led, LED_OFF);
+	led_trigger_event(cm3605->led, 0);
 	led_trigger_unregister_simple(cm3605->led);
 	gpiod_set_value_cansleep(cm3605->aset, 0);
 	iio_device_unregister(indio_dev);
@@ -283,7 +283,7 @@ static int __maybe_unused cm3605_pm_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cm3605 *cm3605 = iio_priv(indio_dev);
 
-	led_trigger_event(cm3605->led, LED_OFF);
+	led_trigger_event(cm3605->led, 0);
 	regulator_disable(cm3605->vdd);
 
 	return 0;
@@ -298,7 +298,7 @@ static int __maybe_unused cm3605_pm_resume(struct device *dev)
 	ret = regulator_enable(cm3605->vdd);
 	if (ret)
 		dev_err(dev, "failed to enable regulator in resume path\n");
-	led_trigger_event(cm3605->led, LED_FULL);
+	led_trigger_event(cm3605->led, 255);
 
 	return 0;
 }
-- 
2.34.1

