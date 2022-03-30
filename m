Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20B4EC75E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiC3OwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347326AbiC3OwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:52:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741F4925E;
        Wed, 30 Mar 2022 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651820; x=1680187820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFJ8vSWxdkQP5rCMWcqpqf0iMOqCrH1H7hLKYmjSIpU=;
  b=KT9uA43Quj97EQsS/34LBJUiti+KKxG2KtmHKYDBQQTFBKMuoufIYN5v
   HtX6K5xbKXegXJRtw4sooRh+8smFbfi1OYejjkcjgYbnK2smTVObdzCfS
   eKBYlhmNR6hRTg9OPs+HZWNyPWon3zuvKWr+Tv1z8laLZxQwjTTz1jKig
   /D+8uzVX5hwSNmehuWdaW3mwpunjWkQr2xaExA5XJDc9IV9Mh9CBNGKXe
   C2VqlsoA2cUN2nVWOgtFY4++TsKQUOBbi+q1Sd793ATzdgDS2QCqiK0/V
   kZ3cGJRoAFSzSNH67yIOE3LTU/jr0gjCPXqsj2b3PvtZPMGj3/5k8wEZf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="257139573"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="257139573"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="618556021"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Mar 2022 07:50:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3232C1C3; Wed, 30 Mar 2022 17:50:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
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
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v3 02/13] gpiolib: Introduce gpiochip_node_count() helper
Date:   Wed, 30 Mar 2022 17:50:19 +0300
Message-Id: <20220330145030.1562-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
References: <20220330145030.1562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpiochip_node_count() helper iterates over the device child nodes that
have the "gpio-controller" property set. It returns the number of such nodes
under a given device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/gpio/driver.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 2142ffc7338c..e38565a5056c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -752,4 +752,15 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
 	device_for_each_child_node(dev, child)					\
 		if (!fwnode_property_present(child, "gpio-controller")) {} else
 
+static inline unsigned int gpiochip_node_count(struct device *dev)
+{
+	struct fwnode_handle *child;
+	unsigned int count = 0;
+
+	for_each_gpiochip_node(dev, child)
+		count++;
+
+	return count;
+}
+
 #endif /* __LINUX_GPIO_DRIVER_H */
-- 
2.35.1

