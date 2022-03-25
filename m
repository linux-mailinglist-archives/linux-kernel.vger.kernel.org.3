Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FEA4E7BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiCYUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiCYUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:07:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D942B18D;
        Fri, 25 Mar 2022 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648238654; x=1679774654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s157fb9lA4a8XOSEq9n0q0pdUa5Gw9sK4n7L6BfC7jE=;
  b=MrfDQR4SBZpLVpd9l0jHg0K3ahLikmX6eJvB2DUlbkEINw81nqp+Q414
   2yUclt0hO4LN/WpcJ1TTe9cvCHXGSDJyeOQnt9poPvC6qNSNNCzRegFnn
   hTdgKhIHW0o8dkT8uXKL6Cx3R2f/omlJfVy2N4ZDmQ2spX6WuveAuk1Lr
   k/T+mcCHsMkzb5aGp0UP8NuC2Gc7fRAJ2PStf7OKd+9JRK5K6gFC5HiFQ
   eJ234Vu2Jg3c9UnvPE685VVxbaP2QpDPQ/faXJXM6mFGvbTXFHrFVqkmA
   JltaEOhW0I7ClVxX8YyR6M++1lG4AKVQ9iwtL0uEy4HeP1LeEEValWtWW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="257537296"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="257537296"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="638321942"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2022 13:04:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C8E61C8; Fri, 25 Mar 2022 22:04:30 +0200 (EET)
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
Subject: [PATCH v1 3/5] pinctrl: renesas: Replace custom code by gpiochip_count() call
Date:   Fri, 25 Mar 2022 22:03:36 +0200
Message-Id: <20220325200338.54270-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have generic function to count GPIO controller nodes
under given device, there is no need to open code it. Replace
custom code by gpiochip_count() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index c1d6e9512c7a..c66e72e7dd71 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -1154,21 +1154,6 @@ static const struct pinmux_ops rza1_pinmux_ops = {
  * RZ/A1 pin controller driver operations
  */
 
-static unsigned int rza1_count_gpio_chips(struct device_node *np)
-{
-	struct device_node *child;
-	unsigned int count = 0;
-
-	for_each_child_of_node(np, child) {
-		if (!of_property_read_bool(child, "gpio-controller"))
-			continue;
-
-		count++;
-	}
-
-	return count;
-}
-
 /**
  * rza1_parse_gpiochip() - parse and register a gpio chip and pin range
  *
@@ -1255,7 +1240,7 @@ static int rza1_gpio_register(struct rza1_pinctrl *rza1_pctl)
 	unsigned int i;
 	int ret;
 
-	ngpiochips = rza1_count_gpio_chips(np);
+	ngpiochips = gpiochip_count(rza1_pctl->dev);
 	if (ngpiochips == 0) {
 		dev_dbg(rza1_pctl->dev, "No gpiochip registered\n");
 		return 0;
-- 
2.35.1

