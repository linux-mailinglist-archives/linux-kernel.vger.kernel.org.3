Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B955EED2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiF1UIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiF1UHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:07:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA1193FC;
        Tue, 28 Jun 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656446352; x=1687982352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DfvC3HLUh24fKl5hJoiuDoRE0WZV7LPneh7dsGXO1lY=;
  b=Uz3MyAUsQIIcpravH3JRVuuzk7V1jtCGyTwvqDjKaOAHLqIc/9PrDQc7
   uqOaaJX5Y0FvnzNcWdfHx/Dq6Md+85DGZqsSFss4Qvrd6K3E0XagqEhJF
   tOS4yPSqfGLQgIT7pOKn9J/AXqq9Fd++WOh6rmX4aJmUUDDLD07a65Fok
   +Tayq0K/kO0Afad0+RrajxpIuWjhXYIE6r2iSErojsgznLxofAQf2YfYa
   BXP+Ud+T554ASWSgY+5T57wfAy7mOMvQsHzIC9utflq1v14ON2Y/VLl5y
   A27sJx2w1HsQL2H5apPHawBudnqTBUdDHAqGKLsgvSBO6jkkxAJpB4KNk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261637370"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="261637370"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="680184834"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2022 12:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A8B9D41; Tue, 28 Jun 2022 22:59:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/2] gpio: adnp: Make use of device properties
Date:   Tue, 28 Jun 2022 22:59:13 +0300
Message-Id: <20220628195913.36940-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com>
References: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-adnp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index 075782831044..a6439e3daff0 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -6,8 +6,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
+#include <linux/property.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
@@ -487,19 +488,15 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 
 static int adnp_i2c_probe(struct i2c_client *client)
 {
-	struct device_node *np = client->dev.of_node;
+	struct device *dev = &client->dev;
 	struct adnp *adnp;
 	u32 num_gpios;
 	int err;
 
-	err = of_property_read_u32(np, "nr-gpios", &num_gpios);
+	err = device_property_read_u32(dev, "nr-gpios", &num_gpios);
 	if (err < 0)
 		return err;
 
-	client->irq = irq_of_parse_and_map(np, 0);
-	if (!client->irq)
-		return -EPROBE_DEFER;
-
 	adnp = devm_kzalloc(&client->dev, sizeof(*adnp), GFP_KERNEL);
 	if (!adnp)
 		return -ENOMEM;
@@ -507,8 +504,7 @@ static int adnp_i2c_probe(struct i2c_client *client)
 	mutex_init(&adnp->i2c_lock);
 	adnp->client = client;
 
-	err = adnp_gpio_setup(adnp, num_gpios,
-			of_property_read_bool(np, "interrupt-controller"));
+	err = adnp_gpio_setup(adnp, num_gpios, device_property_read_bool(dev, "interrupt-controller"));
 	if (err)
 		return err;
 
-- 
2.35.1

