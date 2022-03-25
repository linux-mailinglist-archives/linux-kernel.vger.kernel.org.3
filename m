Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9F4E7D65
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiCYUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiCYUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:07:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F62BB28;
        Fri, 25 Mar 2022 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648238655; x=1679774655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I9qL3XzxipS1lgo6CpdL7eX6zDMQG8eU8y3dPwQxX+Y=;
  b=O+/skQHCsifZ14BSN7Uy15tbo5g4s/Jyvg4DN2Z3oEBfFPA63/Sa0G6e
   5j7oEQHcpr+3/1+Et3CTNe9E/QrIPTmutCaTZJwJ+acrzc6RNZcceZ9Fa
   v304SzwzTIc+T/bzw5HpqgGpSOsbteO8Ou0zcN6n4dAuX7b419nPH54GX
   jgWNC7pfPca6++ufBqCBz9co6nlLE/ysluceDU2w6vriXUlBxlTJCmpgp
   G0ttNksdCJ3Gdt5ei/lGehDJ9+czS2qRTXqfmoM7v/XmBEGAcd5ZCfuWR
   WjndAspSjBYZRaKm2Beucg6It3nEAza4BTFQBQ5Bj29aGiHYS285GB+fJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258900034"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258900034"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="501886245"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2022 13:04:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75E9F11E; Fri, 25 Mar 2022 22:04:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/5] gpiolib: Introduce gpiochip_count() helper
Date:   Fri, 25 Mar 2022 22:03:34 +0200
Message-Id: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpiochip_count() helper iterates over the device child nodes that have
the "gpio-controller" property set. It returns the number of such nodes
under given device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 894eab753fdf..52918ef5d288 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -9,6 +9,7 @@
 #include <linux/lockdep.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/property.h>
 #include <linux/types.h>
 
 struct gpio_desc;
@@ -750,4 +751,17 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
 }
 #endif /* CONFIG_GPIOLIB */
 
+static inline unsigned int gpiochip_count(struct device *dev)
+{
+	struct fwnode_handle *child;
+	unsigned int count = 0;
+
+	device_for_each_child_node(dev, child) {
+		if (device_property_read_bool(child, "gpio-controller"))
+			count++;
+	}
+
+	return count;
+}
+
 #endif /* __LINUX_GPIO_DRIVER_H */
-- 
2.35.1

