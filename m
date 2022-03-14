Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80084D904B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiCNXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbiCNXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:23:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265B3EBA8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:22:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id l8so6165248pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTF3MZGrTrbbQBMFcXYIOTh9HtDp424Yii0gfHDnI3s=;
        b=DEbcg7a0FewhWxynEwK5kauLWHUGcpNDoR+MdC5VIYWvWpX2rz5b91OIaGFURVMnfb
         q3hXqUYeybDDJz1QDOLMNBhh6mXeVfRrav2WoVpH8OVXFw1kC2K+7Sbv/GmzdVClQLFf
         IyIla5QeRs4DH4PbQtzD+UvNmSHxr87Chi/YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTF3MZGrTrbbQBMFcXYIOTh9HtDp424Yii0gfHDnI3s=;
        b=3DCQZP37oToLoCKHJFwU5/1dYmzXqBZrwcUCryDYT4hasxyPqN2Fk3uEbV94dFaVNJ
         fZgHDO9wRqykj734FHo4ZNQuqYr232smlRple2grgeFw1OIhpKIgpSZbWR4Gxs44vMSI
         GkEY0LIbYXB+J7PXJT2w9Sizn3xONm4vkY8nWwTsDwNKbTXcYcU99+fs1Pg1Vs96R0We
         XNge7IE3JYpKQGu7UsZ6Ju5P3bilIBrVt/qIQFqMcQlIyPrRljr20mVCEAvTqOofSpMV
         3vhoBwHtYvGhwPaf6O1XCwF3FkLjDrFCCmfUQwwNtxwN2qon/76uUwAzt66lpTzyaKhf
         cFcg==
X-Gm-Message-State: AOAM530RBoLtaL3LcnIg36NPYDpa5xMT3ao2VvxbvOK0S8LC01p2uzvy
        PwpoaxqHU3k5wbKB+rqbKKKwLQ==
X-Google-Smtp-Source: ABdhPJyHDD7+U4Q4gKpUul9TuXDJ7ndb/zq7ae6ri8YDgtV7oGuMAQnM2OEOZCDz1gWGMqkRPzwNVg==
X-Received: by 2002:a05:6a00:238f:b0:4f6:b09a:4c63 with SMTP id f15-20020a056a00238f00b004f6b09a4c63mr25930668pfc.35.1647300138739;
        Mon, 14 Mar 2022 16:22:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:c7b4:6b67:b9a2:ab68])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b004f6f267dcc9sm20759886pfm.187.2022.03.14.16.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 16:22:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_spi: Boot fingerprint processor during probe
Date:   Mon, 14 Mar 2022 16:22:14 -0700
Message-Id: <20220314232214.4183078-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220314232214.4183078-1-swboyd@chromium.org>
References: <20220314232214.4183078-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio control to this driver so that the fingerprint device can be
booted if the BIOS isn't doing it already. This eases bringup of new
hardware as we don't have to wait for the BIOS to be ready, supports
kexec where the GPIOs may not be configured by the previous boot stage,
and is all around good hygiene because we control GPIOs for this device
from the device driver.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Craig Hesling <hesling@chromium.org>
Cc: Tom Hughes <tomhughes@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 38 ++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 14c4046fa04d..77577650afce 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -4,6 +4,7 @@
 // Copyright (C) 2012 Google, Inc
 
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -77,6 +78,8 @@ struct cros_ec_spi {
 	unsigned int start_of_msg_delay;
 	unsigned int end_of_msg_delay;
 	struct kthread_worker *high_pri_worker;
+	struct gpio_desc *boot0;
+	struct gpio_desc *reset;
 };
 
 typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
@@ -690,7 +693,7 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
 }
 
-static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
+static int cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	u32 val;
@@ -703,6 +706,31 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
 	if (!ret)
 		ec_spi->end_of_msg_delay = val;
+
+	if (!of_device_is_compatible(np, "google,cros-ec-fp"))
+		return 0;
+
+	ec_spi->boot0 = devm_gpiod_get(dev, "boot0", 0);
+	if (IS_ERR(ec_spi->boot0))
+		return PTR_ERR(ec_spi->boot0);
+
+	ec_spi->reset = devm_gpiod_get(dev, "reset", 0);
+	if (IS_ERR(ec_spi->reset))
+		return PTR_ERR(ec_spi->reset);
+
+	/*
+	 * Take the FPMCU out of reset and wait for it to boot if it's in
+	 * bootloader mode or held in reset. Otherwise the BIOS has already
+	 * powered on the device earlier in boot in which case there's nothing
+	 * to do.
+	 */
+	if (!gpiod_get_value(ec_spi->boot0) || gpiod_get_value(ec_spi->reset)) {
+		gpiod_set_value(ec_spi->boot0, 1);
+		gpiod_set_value(ec_spi->reset, 0);
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
 }
 
 static void cros_ec_spi_high_pri_release(void *worker)
@@ -754,8 +782,10 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (!ec_dev)
 		return -ENOMEM;
 
-	/* Check for any DT properties */
-	cros_ec_spi_dt_probe(ec_spi, dev);
+	/* Check for any DT properties and boot fpmcu if applicable */
+	err = cros_ec_spi_dt_probe(ec_spi, dev);
+	if (err)
+		return err;
 
 	spi_set_drvdata(spi, ec_dev);
 	ec_dev->dev = dev;
@@ -813,12 +843,14 @@ static SIMPLE_DEV_PM_OPS(cros_ec_spi_pm_ops, cros_ec_spi_suspend,
 			 cros_ec_spi_resume);
 
 static const struct of_device_id cros_ec_spi_of_match[] = {
+	{ .compatible = "google,cros-ec-fp", },
 	{ .compatible = "google,cros-ec-spi", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cros_ec_spi_of_match);
 
 static const struct spi_device_id cros_ec_spi_id[] = {
+	{ "cros-ec-fp", 0 },
 	{ "cros-ec-spi", 0 },
 	{ }
 };
-- 
https://chromeos.dev

