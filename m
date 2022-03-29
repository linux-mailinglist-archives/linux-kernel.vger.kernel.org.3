Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB384EB07D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiC2PbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiC2Pa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:30:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5B7F65F2;
        Tue, 29 Mar 2022 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648567755; x=1680103755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FC47RstAGsOQXwOhpbxieb6YpNOjPD5V6VOVXNT0rL8=;
  b=IAqbGJkDQ//NUJaoq4GFCpz+aCHMlnlPF8+yO1tTQZneH9dq1rCwwcRE
   4SPvCh6sIiKMF/u6Xttn3qP43jXlU7GletKtrz8GQoWAKlKIoaitxfaav
   DhrnHGRJS+QFw9jYaXcG4vFkEVRU1QUpZ4RViMox+zam52O6MKmATxKFw
   BbuYtkocQoVtVCqbhH9RcSnwzta7nSJfV4M2cSUPXJ8rPZ9/2b8SsIO5L
   60m9F6b8sxvyKnLd7AI610rmYZAyEOXhgH6NRCcNHBBB2Ebkg9dHrmKGs
   IHhCVw6Qyz1OxnU/CUvZpGeeCqaIKJ29t5LV/HGcnvZl0qRHjZRl5eceu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259462980"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259462980"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="639362645"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2022 08:29:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB10A120; Tue, 29 Mar 2022 18:29:28 +0300 (EEST)
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
Subject: [PATCH v2 00/13] gpiolib: Two new helpers and way toward fwnode
Date:   Tue, 29 Mar 2022 18:29:13 +0300
Message-Id: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
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
to use fwnode and partially fwnode APIs.

Bart, Linus, I can take it thru my tree with an immutable branch if
it's the way you prefer, otherwise please suggest on how to proceed.

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
  pinctrl: meson: Rename REG_* to MREG_*
  pinctrl: meson: Enable COMPILE_TEST
  pinctrl: meson: Replace custom code by gpiochip_node_count() call
  pinctrl: armada-37xx: Switch to use fwnode instead of of_node
  pinctrl: armada-37xx: Reuse GPIO fwnode in
    armada_37xx_irqchip_register()

 drivers/pinctrl/meson/Kconfig               |   2 +-
 drivers/pinctrl/meson/pinctrl-meson.c       |  52 ++++----
 drivers/pinctrl/meson/pinctrl-meson.h       |  24 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |  34 ++---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c   | 141 +++++++++-----------
 drivers/pinctrl/renesas/pinctrl-rza1.c      |  39 ++----
 drivers/pinctrl/samsung/pinctrl-samsung.c   |  30 ++---
 drivers/pinctrl/samsung/pinctrl-samsung.h   |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c       |  80 +++++------
 include/linux/gpio/driver.h                 |  19 ++-
 10 files changed, 187 insertions(+), 236 deletions(-)

-- 
2.35.1

