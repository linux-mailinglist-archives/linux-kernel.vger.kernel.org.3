Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0E4DBBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355085AbiCQA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354372AbiCQA7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:59:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997E513E31
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id c11so1447370pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1n9UVVKMRQXDGbxIDzUh2jfKVbWO78ULBsARLp7tcY=;
        b=jfxExfhHKLLo+nlGGwg/kE8Wp98nbRHDe7mpV6j9ryWVuWNtR5aVsotE7/Y+oBCKrU
         TSlfbZSGBsJgcuxaFYUd76kKS3SAAYiW9XaHU0b2oEdS57zl/AFIJUdv5NJ9tP/q47MG
         UN6RbggXW88VoY+3jOyluiBheLsz+/pqAt4CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1n9UVVKMRQXDGbxIDzUh2jfKVbWO78ULBsARLp7tcY=;
        b=JFla2k6mIG+xhasMUpycsIR35RFtvDdB59020VCaYo05CeLlLTWGON8dgfmX30HQgz
         Bip0sazFYaPhaNhUcdEqfOHrYg6n8pCDsACBZpBAOr6ImZQAmItNsbskIwpGhOmwNUt0
         pLWtxwY5SK74/R6nxDGCTODrWnsMvY9X2uoPqcsRMBshvm9l2sW1QvjLGWLIrL6Z6GBU
         xALiiCuP7CLUkio8CF1eXZNJfzwLcDPdAYWkywBqZfKoPJzuVLN/NzMOCTM+CyhlMqiH
         F45AkWrqe4zX+LMPrCWyvXvZYQi5nhMBs95UvaDkb5Y6CZDVXacenWsKiJ+2Rk9Ua3Uk
         NoyQ==
X-Gm-Message-State: AOAM530kvzfWeO+3mnfoLJ+bHWDtxDoq8Hqx07jRjy2DBaagDtQQht8g
        K+Jfk+DSvthBmLrcJEs6TcdKsw==
X-Google-Smtp-Source: ABdhPJwS+9f+tcwKXhz47Sw1tD3D6y77gcriRiKA8DMzgNiPiuYcnTfpw9IDP0DyDkMLvXrtVFWTng==
X-Received: by 2002:a05:6a00:2131:b0:4f7:b6da:9ed0 with SMTP id n17-20020a056a00213100b004f7b6da9ed0mr2254839pfj.69.1647478700537;
        Wed, 16 Mar 2022 17:58:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id l20-20020a056a00141400b004f65cedfb09sm4433445pfu.48.2022.03.16.17.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 17:58:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2 3/3] platform/chrome: cros_ec_spi: Boot fingerprint processor during probe
Date:   Wed, 16 Mar 2022 17:58:14 -0700
Message-Id: <20220317005814.2496302-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220317005814.2496302-1-swboyd@chromium.org>
References: <20220317005814.2496302-1-swboyd@chromium.org>
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
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 42 +++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index d0f9496076d6..13d413a2fe46 100644
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
@@ -703,6 +706,37 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
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
+	 * bootloader mode or held in reset. This isn't the normal flow because
+	 * typically the BIOS has already powered on the device to avoid the
+	 * multi-second delay waiting for the FPMCU to boot and be responsive.
+	 */
+	if (gpiod_get_value(ec_spi->boot0) || gpiod_get_value(ec_spi->reset)) {
+		/* Boot0 is sampled on reset deassertion */
+		gpiod_set_value(ec_spi->boot0, 0);
+		gpiod_set_value(ec_spi->reset, 1);
+		usleep_range(1000, 2000);
+		gpiod_set_value(ec_spi->reset, 0);
+
+		/* Wait for boot; there isn't a "boot done" signal */
+		dev_info(dev, "Waiting for FPMCU to boot\n");
+		msleep(2000);
+	}
+
+	return 0;
 }
 
 static void cros_ec_spi_high_pri_release(void *worker)
@@ -754,8 +788,10 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (!ec_dev)
 		return -ENOMEM;
 
-	/* Check for any DT properties */
-	cros_ec_spi_dt_probe(ec_spi, dev);
+	/* Check for any DT properties and boot FPMCU if applicable */
+	err = cros_ec_spi_dt_probe(ec_spi, dev);
+	if (err)
+		return err;
 
 	spi_set_drvdata(spi, ec_dev);
 	ec_dev->dev = dev;
-- 
https://chromeos.dev

