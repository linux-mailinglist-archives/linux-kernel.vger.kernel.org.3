Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394F47E195
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbhLWKiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:38:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:29250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347755AbhLWKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640255887; x=1671791887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuR52/Ba94yPsgQ4lSZpBqqDPD9qPXxRGfzZH9LoHw8=;
  b=KmkPKtePD+ZbztE7IWV24FNuik5c78VLQn4XKsJfAI0Vim9De2oXzbpA
   1gln9F/EuibwIRduI/p1vETqUGOA9MnFH6cGh+kKMmYIRwwmW5VaoX550
   ZX5gFDCGDNir/9nK6qQXMBeD9o8LQi9ERTl/npU4rbv5wz+IGARKGzB9k
   /9r2CLr+Mdkd0dqo2h6hUv1XAQjvHZ0M6rMjAfkeMiDYR8oEW3+ehybRE
   yW7DlJ2n5TCTzVJ6o0kiEgKlQU/Y1LomgeV2Q4YPTJqCv0XqKr7HI4v1l
   Z/oKKJEJ7goT79HPQWqtyQeYkfk6dSIlJofbtVXYYLPXBwyVjFhmpIN9u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="241027274"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="241027274"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="664546190"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 02:38:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD5ADD4; Thu, 23 Dec 2021 12:38:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/2] gpio: dwapb: Switch to use fwnode instead of of_node
Date:   Thu, 23 Dec 2021 12:38:09 +0200
Message-Id: <20211223103809.12343-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
References: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it and hence rectify the ACPI
case which uses software nodes.

Note, in this case it's rather logical fix that doesn't
affect functionality, thus no backporting required.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-dwapb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index ec0767d7800d..b0f3aca61974 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -15,7 +15,6 @@
 #include <linux/irq.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/reset.h>
@@ -515,9 +514,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
 		return err;
 	}
 
-#ifdef CONFIG_OF_GPIO
-	port->gc.of_node = to_of_node(pp->fwnode);
-#endif
+	port->gc.fwnode = pp->fwnode;
 	port->gc.ngpio = pp->ngpio;
 	port->gc.base = pp->gpio_base;
 
-- 
2.34.1

