Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B306501B91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbiDNTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243648AbiDNTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB8E9CBD;
        Thu, 14 Apr 2022 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962967; x=1681498967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ESMOhfAIzHVEWWSaUAwTLXvAmE92GhwSV4ExM0OTanc=;
  b=nLthzPKnSweKCj0AcuOEskETcauynR1AsatWIsMUo8mVZ3pQ3DHsZncp
   yBjYrbu0yJP+x5EcOEoCvQCzL9JWm5FhrgKFLahHwYeq9If4zW5RDh6n6
   6+Ck2YcxTBF+iaNXCLzbZuQzcIo5PazdvSksTSsN94veEVmUu81qYofZ3
   ECcKBdW3TGLru0++oy8ltg9Oe2kd84W3t9tSHdB2kxAGBCfT3x+enN5OE
   r9Ns+CZQSvGPnagUXjUF9ZU5xVXbF3+rokRlzmuDCHAvWhgWKGUmTdt2d
   MAsLBuctbCYizd5wnTPEdyICsBKeh+Wg3eQSR8V2t5dz99ku17hdpm8M2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349445609"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="349445609"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527515393"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 12:02:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 579E7D1; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
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
Subject: [PATCH v5 0/6] gpiolib: more helpers and fwnode conversion
Date:   Thu, 14 Apr 2022 22:02:36 +0300
Message-Id: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a spin-off (*) of the previous work of switching GPIO library
to use fwnode instead of of_node. Here we introduce a couple of
a new macro helpers, which allows to switch some of the drivers
to use fwnode and partially fwnode APIs. As a result of this cleanup
a few drivers switched to use GPIO fwnode instead of of_node.

*) it's subset of it with a new (patch 1) helper.

Marek, Martin, can you give this a try?
This requires at least two patches for GPIO library to be applied.

Bart, Linus, I can take it thru my tree with an immutable branch if
it's the way you prefer, otherwise please suggest on how to proceed.

Changelog v5:
- dropped tested patches (this series based on them, though)
- introduced a new helper (thanks Marek and Martin for reporting an issue)
- redone Armada and Meson code using newly introduced helper

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

Andy Shevchenko (6):
  gpiolib: Introduce a helper to get first GPIO controller node
  pinctrl: armada-37xx: Switch to use fwnode instead of of_node
  pinctrl: armada-37xx: Reuse GPIO fwnode in
    armada_37xx_irqchip_register()
  pinctrl: meson: Rename REG_* to MESON_REG_*
  pinctrl: meson: Enable COMPILE_TEST
  pinctrl: meson: Replace custom code by gpiochip_node_count() call

 drivers/pinctrl/meson/Kconfig               |  2 +-
 drivers/pinctrl/meson/pinctrl-meson.c       | 52 ++++++++++-----------
 drivers/pinctrl/meson/pinctrl-meson.h       | 28 +++++------
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 34 ++++----------
 include/linux/gpio/driver.h                 | 10 ++++
 5 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.35.1

