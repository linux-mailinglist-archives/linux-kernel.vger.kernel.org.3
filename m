Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F34EEBA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiDAKjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbiDAKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:38:12 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A14266B6C;
        Fri,  1 Apr 2022 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648809383; x=1680345383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WOuu6zwMsg2iOvdBnmg8kIG4pCFXH+CIzNQjuQN2qTs=;
  b=W5VHwjFnGNiMTjT4iQpRJLAx8+W5XNVsmhPjRfomqSNT8iTrPgOiEEOC
   +PSADAub4w/6C/JoOPfTjiv/9jLtMi8oIbgCsXheCEbDXKjq+75jbmyyC
   E2ETkMVert/LSfqW+lBEYxl/fzE5+6B1WlmLO8q9vBqik4rliC9eQvxe/
   YztktppTumi7AAKSvgZ+QufcOUz6QZcubkkqABFMGohpLgm7sqoOhx3Nu
   qgaQ29WnEIqNC2STcDGVX5a6XXR6D64eSqHANAshqB0Q30nx2fyLhrJWD
   MJe8Eg1xdtcsXnKn2xAfDVCIcc/Q3TudFtXcHMTXP3GXZDJGYf9ot/qk3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="320790075"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="320790075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="695847063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2022 03:35:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DAA5A5F2; Fri,  1 Apr 2022 13:36:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Qianggui Song <qianggui.song@amlogic.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v4 06/13] pinctrl: renesas: rza1: Replace custom code by gpiochip_node_count() call
Date:   Fri,  1 Apr 2022 13:35:57 +0300
Message-Id: <20220401103604.8705-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have generic function to count GPIO controller nodes
under a given device, there is no need to open code it. Replace
custom code by gpiochip_node_count() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rza1.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index c1d6e9512c7a..acc00b1a955d 100644
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
+	ngpiochips = gpiochip_node_count(rza1_pctl->dev);
 	if (ngpiochips == 0) {
 		dev_dbg(rza1_pctl->dev, "No gpiochip registered\n");
 		return 0;
-- 
2.35.1

