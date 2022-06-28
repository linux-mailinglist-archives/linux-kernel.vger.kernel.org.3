Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A355EE09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiF1Tpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiF1Tp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:45:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43843BF86;
        Tue, 28 Jun 2022 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656445144; x=1687981144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYFhbi3TG2EnqrzqyyS6XxZn5TtJ3mVQBigxsTKAzDo=;
  b=mfbf2hDgwcJ5v/BLrejs1ZY853B/SjvzvYyXifOuaxOGiHN7NqLJ41Eb
   hARRI/FY+NeVP3goYtCgayAsJK6eItyw4oTYsAkl0K9KEvHIH5yjiGUY9
   wlprsNmY1+azXJN8h1cW6nJbV5MrwCZTI6RP8i2KCNERvM4QtJXlFQQt8
   6bIx1SMuEvYOe/EiABRLlGBZsV+SVYEn3esM5ZqYrn9RhUkKGnkgEsjHK
   e4kMLOefcuZLawo0NF/dQv+SXoArQHbHdsYRz6kDqSoBRf8VpKneGzQbf
   QdNf2xReZW3rIjdTxTk9VCnKbJy5sNN8E75hBRyNx19yg5BUtU+NzoEmu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270593025"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="270593025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="680179279"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2022 12:39:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40429CE; Tue, 28 Jun 2022 22:39:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpio: adp5588: Do not use defined value for driver name and compatible
Date:   Tue, 28 Jun 2022 22:39:04 +0300
Message-Id: <20220628193906.36350-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's wrong to use defined string literal for three semantically different
cases, i.e.:
1) compatible string, which is part of ABI and has to have specific format;
2) I2C ID, which is user space visible and also ABI;
3) driver name, that can be changed.

Drop the define and use appropriate string literals in place.

While at it, drop comma at terminator entry of OF ID table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-adp5588.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index 51ed23ba4645..d6a229a67044 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -18,8 +18,6 @@
 
 #include <linux/platform_data/adp5588.h>
 
-#define DRV_NAME	"adp5588-gpio"
-
 /*
  * Early pre 4.0 Silicon required to delay readout by at least 25ms,
  * since the Event Counter Register updated 25ms after the interrupt
@@ -422,20 +420,20 @@ static int adp5588_gpio_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adp5588_gpio_id[] = {
-	{DRV_NAME, 0},
+	{ "adp5588-gpio" },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, adp5588_gpio_id);
 
 static const struct of_device_id adp5588_gpio_of_id[] = {
-	{ .compatible = "adi," DRV_NAME, },
-	{},
+	{ .compatible = "adi,adp5588-gpio" },
+	{}
 };
 MODULE_DEVICE_TABLE(of, adp5588_gpio_of_id);
 
 static struct i2c_driver adp5588_gpio_driver = {
 	.driver = {
-		.name = DRV_NAME,
+		.name = "adp5588-gpio",
 		.of_match_table = adp5588_gpio_of_id,
 	},
 	.probe_new = adp5588_gpio_probe,
-- 
2.35.1

