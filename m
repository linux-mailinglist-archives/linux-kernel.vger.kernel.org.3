Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE2501B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbiDNTFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237668AbiDNTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B32E9CAB;
        Thu, 14 Apr 2022 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962967; x=1681498967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abvzvPHtAqKTHl2gIEKqzUhJaatXpwBCLqpsS/ifsxo=;
  b=oI2yEGETVY9Z1vMT3Nes+Da5ay8rc2JVQ8JECIabfK3+LRjA1YRC6LfN
   5+JH34OHk50UbYzGA752A1GJDbpWOlqZqfX3ACMMwJHQiovO3snfOS+K+
   A5r28NPLpacYRKeoLWm0UuP3EiwRglfhlea4cjmdcyXmbDTZF3O7RVz+z
   vs+5eOXw5Pi1CgFk/rCry/CSkZnv5WtAj1oxv4Vd3heP+dAuE3B0LuOlq
   F+q3Vwbp21uFuJBinnEiBey9WRjEeYstXkGZZFmrwkOBmSzLSAnVOAw+q
   Gie6h5ftIK1RnPDum5bBc/yo+UfDdjrKqkrcMYRr7vodpVgkHsmhs9lQi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="260606853"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="260606853"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="612440530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2022 12:02:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63A0D67; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 1/6] gpiolib: Introduce a helper to get first GPIO controller node
Date:   Thu, 14 Apr 2022 22:02:37 +0300
Message-Id: <20220414190242.22178-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
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

Introduce a helper to get first GPIO controller node which drivers
may want to use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 12de0b22b4ef..83e2d72e51bb 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -766,4 +766,14 @@ static inline unsigned int gpiochip_node_count(struct device *dev)
 	return count;
 }
 
+static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
+{
+	struct fwnode_handle *fwnode;
+
+	for_each_gpiochip_node(dev, fwnode)
+		return fwnode;
+
+	return NULL;
+}
+
 #endif /* __LINUX_GPIO_DRIVER_H */
-- 
2.35.1

