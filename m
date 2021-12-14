Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B104744E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhLNO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:27:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:63265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231845AbhLNO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:27:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299765346"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="299765346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 06:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="519235252"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Dec 2021 06:27:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 675AC81; Tue, 14 Dec 2021 16:27:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>,
        Yihao Han <hanyihao@vivo.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] leds: lgm-sso: Get rid of duplicate of_node assignment
Date:   Tue, 14 Dec 2021 16:27:39 +0200
Message-Id: <20211214142739.60071-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214142739.60071-1-andriy.shevchenko@linux.intel.com>
References: <20211214142739.60071-1-andriy.shevchenko@linux.intel.com>
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
   --> sso_gpio_gc_init()
     --> devm_gpiochip_add_data
       --> devm_gpiochip_add_data_with_key
         --> gpiochip_add_data_with_key()
           --> of_gpio_dev_init()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/leds/blink/leds-lgm-sso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/blink/leds-lgm-sso.c b/drivers/leds/blink/leds-lgm-sso.c
index fd8b7573285a..6f270c0272fb 100644
--- a/drivers/leds/blink/leds-lgm-sso.c
+++ b/drivers/leds/blink/leds-lgm-sso.c
@@ -477,7 +477,6 @@ static int sso_gpio_gc_init(struct device *dev, struct sso_led_priv *priv)
 	gc->ngpio               = priv->gpio.pins;
 	gc->parent              = dev;
 	gc->owner               = THIS_MODULE;
-	gc->of_node             = dev->of_node;
 
 	return devm_gpiochip_add_data(dev, gc, priv);
 }
-- 
2.33.0

