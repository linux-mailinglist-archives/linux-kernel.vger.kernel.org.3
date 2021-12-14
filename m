Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137BA4744E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhLNO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:27:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:28000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbhLNO1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:27:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236519594"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="236519594"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 06:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754828313"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 06:27:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C0FF15C; Tue, 14 Dec 2021 16:27:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] leds: tca6507: Get rid of duplicate of_node assignment
Date:   Tue, 14 Dec 2021 16:27:38 +0200
Message-Id: <20211214142739.60071-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove assignment here.

For the details one may look into the of_gpio_dev_init() implementation.

Call graph:
   --> tca6507_probe_gpios()
     --> gpiochip_add_data()
       --> gpiochip_add_data_with_key()
         --> of_gpio_dev_init()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added call graph to the commit message (Pavel)
 drivers/leds/leds-tca6507.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index de8eed9b667d..1473ced8664c 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -641,9 +641,6 @@ static int tca6507_probe_gpios(struct device *dev,
 	tca->gpio.direction_output = tca6507_gpio_direction_output;
 	tca->gpio.set = tca6507_gpio_set_value;
 	tca->gpio.parent = dev;
-#ifdef CONFIG_OF_GPIO
-	tca->gpio.of_node = of_node_get(dev_of_node(dev));
-#endif
 	err = gpiochip_add_data(&tca->gpio, tca);
 	if (err) {
 		tca->gpio.ngpio = 0;
-- 
2.33.0

