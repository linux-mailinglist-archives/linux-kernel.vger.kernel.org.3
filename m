Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA447E30D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbhLWMQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:16:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:23528 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348111AbhLWMQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640261764; x=1671797764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7FQ2IEmT8mWBPh81vbvG7hrcxIOTKBMWQNfn4dHMECo=;
  b=jHTfo8qmD1CrzeVoMXlIlT9h8kzCYrEXPLQtlmZpPpKFlJlVem41cjVV
   uylxyNg4CEPYczxPKBiVhXgumg7oaU78ze2TxAnR2yVkI59Lzb/OByxaU
   zEirEuUeYx8TQa6oM5a+xyx+AC2TUXjVtXun3l5RxsPEVzS/BS5KFsAKi
   SMsyLmQYpswKC7GpW4RbK9+iZEsUqGZmfvFdaOpU+Q6zzxq2c4JzvYdmL
   SNhHhPs7wnkLdCSqq5GTBewhS+UbvP4yl/NIp1Bh9cNx3H1cF1Emvg1A7
   h5LXApdsj3uxt38F9FbCI/fMlSiuHHrMm6TWL5q/LYDIEDh5X3CLyhmqq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227659140"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="227659140"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:16:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="756781942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Dec 2021 04:16:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C051A120; Thu, 23 Dec 2021 14:16:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: regmap: Switch to use fwnode instead of of_node
Date:   Thu, 23 Dec 2021 14:16:06 +0200
Message-Id: <20211223121606.67055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-regmap.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 69c219742083..6383136cbe59 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -244,16 +244,12 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
+	chip->fwnode = config->fwnode;
 	chip->base = -1;
 	chip->ngpio = config->ngpio;
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
 
-#if defined(CONFIG_OF_GPIO)
-	/* gpiolib will use of_node of the parent if chip->of_node is NULL */
-	chip->of_node = to_of_node(config->fwnode);
-#endif /* CONFIG_OF_GPIO */
-
 	/*
 	 * If our regmap is fast_io we should probably set can_sleep to false.
 	 * Right now, the regmap doesn't save this property, nor is there any
-- 
2.34.1

