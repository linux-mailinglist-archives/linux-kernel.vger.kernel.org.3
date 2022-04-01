Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFD4EEB6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiDAKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343982AbiDAKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:37:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3121266B63;
        Fri,  1 Apr 2022 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648809352; x=1680345352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nXk4zlyXR8B57i9BaB9FWZP2fV36YlgrhivlcqXLjKY=;
  b=TfvAAiG7O/se6YSiXM3eW+5AdHgnI5Mn6OcpKNwAmkwCEf8OiTi4bbT/
   aP5JDGDjeVKdZCB8sDSOLXzTb4N/V9B2VJ4j77IWe4ybWoSPTyhTztBTp
   sInFXdl+4otVlvjr0y/AlbeC/Dz7Tv1biXBVYtIENdOszvDsUQB+43AKt
   AIqPHRnNWfIhEniKlAodmE0BnwltR2A30wtDsxrA9UViqK432Qwh5sRf7
   uDZDOgqeoparW/ht59dunLv8Iy5bJN8nrM9m6kkR4Ff4if6XpeHoBtFFC
   No36xx3l0E2dFNSYjvsdJLncPNxY/Sb212GHiDcDJ72yVlMFXr9rXQoVE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="257680697"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="257680697"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="843133139"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2022 03:35:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92A23179; Fri,  1 Apr 2022 13:36:05 +0300 (EEST)
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
Subject: [PATCH v4 00/13] gpiolib: Two new helpers and way toward fwnode
Date:   Fri,  1 Apr 2022 13:35:51 +0300
Message-Id: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

This is a spin-off of the previous work of switching GPIO library
to use fwnode instead of of_node. Here we introduce a couple of
a new macro helpers, which allows to switch some of the drivers
to use fwnode and partially fwnode APIs. As a result of this cleanup
a few drivers switched to use GPIO fwnode instead of of_node.

Bart, Linus, I can take it thru my tree with an immutable branch if
it's the way you prefer, otherwise please suggest on how to proceed.

Changelog v4:
- fixed compilation of the Samsung pin control drivers (LKP)
- explained in the commit message why namespacing is good for meson defs
- added tag to one of meson patches (Neil)

Changelog v3:
- moved count initialization to the definition in patch 2 (Geert)
- replaced of_args by args, used %pfwP in patch 7 (Geert)
- fixed kernel doc warning in patch 7
- added tags to patches 1, 2, 6, and 7 (Geert)
- added tag to patch 4 (Fabien)
- renamed MREG to MESON_REG in patch 9 (Neil)
- added tag to patch 10 (Neil)
- used --base for cover-letter

Changelog v2:
- properly based, so kbuild bot may test it (LKP)
- fixed typo in the macro (Geert)
- split to two macro helpers and rename the gpiochip_count()
- tagged one of stm32 and one of meson patches (Fabien, Neil)
- unified previously standalone armada patch
- due to above rewrote the armada patch from v1 completely (Sergey)
- added a lot of a new patches
- compile tested all of them on x86

Andy Shevchenko (13):
  gpiolib: Introduce for_each_gpiochip_node() loop helper
  gpiolib: Introduce gpiochip_node_count() helper
  pinctrl: stm32: Replace custom code by gpiochip_node_count() call
  pinctrl: stm32: Switch to use for_each_gpiochip_node() helper
  pinctrl: samsung: Switch to use for_each_gpiochip_node() helper
  pinctrl: renesas: rza1: Replace custom code by gpiochip_node_count()
    call
  pinctrl: renesas: rza1: Switch to use for_each_gpiochip_node() helper
  pinctrl: npcm7xx: Switch to use for_each_gpiochip_node() helper
  pinctrl: meson: Rename REG_* to MESON_REG_*
  pinctrl: meson: Enable COMPILE_TEST
  pinctrl: meson: Replace custom code by gpiochip_node_count() call
  pinctrl: armada-37xx: Switch to use fwnode instead of of_node
  pinctrl: armada-37xx: Reuse GPIO fwnode in
    armada_37xx_irqchip_register()

 drivers/pinctrl/meson/Kconfig               |   2 +-
 drivers/pinctrl/meson/pinctrl-meson.c       |  52 ++++---
 drivers/pinctrl/meson/pinctrl-meson.h       |  24 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |  34 ++---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c   | 142 +++++++++-----------
 drivers/pinctrl/renesas/pinctrl-rza1.c      |  47 ++-----
 drivers/pinctrl/samsung/pinctrl-exynos.c    |   8 +-
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c   |   2 +-
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c   |   4 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c   |  30 ++---
 drivers/pinctrl/samsung/pinctrl-samsung.h   |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c       |  80 +++++------
 include/linux/gpio/driver.h                 |  18 ++-
 13 files changed, 198 insertions(+), 247 deletions(-)


base-commit: e5071887cd2296a7704dbcd10c1cedf0f11cdbd5
-- 
2.35.1

