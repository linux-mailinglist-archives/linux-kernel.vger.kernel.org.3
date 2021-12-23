Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8F947E336
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbhLWM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:27:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:55676 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243438AbhLWM13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262449; x=1671798449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dNPeiHUfQEwh0MOOenGj8Gw+5i/UqdlyMV+wEfV1pQs=;
  b=GYfp75mtTZn16uGsWlsIgMHl2c/9icKQMyHhB/JccjubElBildK2nEio
   +uzI2trzEqEQURe8FrmYS2toeuYUEzIDrd0/HjGgR9t2NGQRaiND1nyR8
   skjDSpt+2ldbRq60kJOXZMw31oxxN07t2OBznSER39DCiYzKKKb9N7M23
   VyoAu/U9eEhfOi0AxEcVU28WV09OEJZZbQVAIovZ07smS4uueIJ8BwIk3
   nMUa1DvLm7Zwhj4NjxeNIm9/L49IsGnUfHXNkarnvJEjvw+RqBCy7SDL9
   zI8BmhMIaOCgqjVclqu+ruZmQ9/oV4eZm1m9Xd5J7xDYdQqwhWeskB+j9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="265026225"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="265026225"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:27:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="607742322"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2021 04:27:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD489120; Thu, 23 Dec 2021 14:27:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: altera-a10sr: Switch to use fwnode instead of of_node
Date:   Thu, 23 Dec 2021 14:27:33 +0200
Message-Id: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
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
 drivers/gpio/gpio-altera-a10sr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-altera-a10sr.c b/drivers/gpio/gpio-altera-a10sr.c
index 6af51feda06f..be1ed7ee5225 100644
--- a/drivers/gpio/gpio-altera-a10sr.c
+++ b/drivers/gpio/gpio-altera-a10sr.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/altera-a10sr.h>
 #include <linux/module.h>
+#include <linux/property.h>
 
 /**
  * struct altr_a10sr_gpio - Altera Max5 GPIO device private data structure
@@ -88,7 +89,7 @@ static int altr_a10sr_gpio_probe(struct platform_device *pdev)
 
 	gpio->gp = altr_a10sr_gc;
 	gpio->gp.parent = pdev->dev.parent;
-	gpio->gp.of_node = pdev->dev.of_node;
+	gpio->gp.fwnode = dev_fwnode(&pdev->dev);
 
 	return devm_gpiochip_add_data(&pdev->dev, &gpio->gp, gpio);
 }
-- 
2.34.1

