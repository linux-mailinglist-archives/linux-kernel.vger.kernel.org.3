Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6794EB07B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbiC2PbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiC2Pa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:30:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67233F7F51;
        Tue, 29 Mar 2022 08:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648567756; x=1680103756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNunbYDvPM71E+oAn/SOKUWabTWxhBKKB0W3yFW6B0c=;
  b=bjOmGtbIwl5B9iEEPikudLtvoL4m23hYlRzPC5NQwrAs25FMYKbDvQg8
   pujaMaCgQvYfPGK0GXfitvCZLlgbWezZzcFOINmf4NZwVKBp7YHwZsGSt
   9NGnCUrENozqv7tJ7hGSeBp6+HOGhoc7bwcKWC0wJpROFCkoGPJzxOkEf
   bK0+cIZvkBWUDCBJypuWE9lKSm1E76bL2DbXY0MkiM9tR9F90FjaQSUYl
   I2NPsPRrZcHSBX2giaQMSBkZYf0RwpY1LABNsF877CjEtpgJPR8XE1uCa
   pQDJd/7rKXZH56UqcXo1QoNV1C8SNb1lFLktJGsUmgpyJ0j+vLv9neF4s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241430660"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="241430660"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="653044837"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2022 08:29:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17FB01A1; Tue, 29 Mar 2022 18:29:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 02/13] gpiolib: Introduce gpiochip_node_count() helper
Date:   Tue, 29 Mar 2022 18:29:15 +0300
Message-Id: <20220329152926.50958-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpiochip_node_count() helper iterates over the device child nodes that
have the "gpio-controller" property set. It returns the number of such nodes
under a given device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e6b9c17614ef..bc2ea9f65022 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -755,4 +755,16 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
 	device_for_each_child_node(dev, child)					\
 		if (!fwnode_property_present(child, "gpio-controller")) {} else
 
+static inline unsigned int gpiochip_node_count(struct device *dev)
+{
+	struct fwnode_handle *child;
+	unsigned int count;
+
+	count = 0;
+	for_each_gpiochip_node(dev, child)
+		count++;
+
+	return count;
+}
+
 #endif /* __LINUX_GPIO_DRIVER_H */
-- 
2.35.1

