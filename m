Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE44598695
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiHRO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbiHRO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:56:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF91BD096
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B33B9B821CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AC4C433B5;
        Thu, 18 Aug 2022 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660834594;
        bh=5Lk49R5XTDtUgxjV37M4QLhFkrgyV5d0l00kZ+JmOmg=;
        h=From:To:Cc:Subject:Date:From;
        b=iD/8SLE8Gi1Oj6vB1jLvD7ZUlWW4aOE0kXAABoOA0yezHDrwobJFhT5waMfIU3WwV
         vqpJ4/kp8iO6dHhGQPwPZBXtLv4l0iCFhA/8Hz11VfS21nMXMGJgFmO1cWr2ZlvZDs
         mXdAPO45HkTiMcj84bf6iDPGI4kXikvf7eD5k9GXZBZFKUf4LhxTDsSzRFVNZ1sQeb
         USyBAwY2xl7QurtfjPx90tHpuXy1VoJDWVaQppZvlSPmCaEfT4uuk4eW/Jsz01QPZz
         Gorn6Sv9G8R2RrX9OEJJLydiafgPTolv2LvgCVfMPgaW6mvR+zD0O552y+Xyu9+z5f
         PeW6Kyi2fHaUQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 0/5] ARM: clean up after multiplatform changes
Date:   Thu, 18 Aug 2022 16:56:11 +0200
Message-Id: <20220818145616.3156379-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Now that everything except StrongARM is unified under
CONFIG_ARCH_MULTIPLATFORM, the option is rather meaningless
in its current form.

Rework the Kconfig logic to make this useful again, similar
to the way that RISC-V has CONFIG_NONPORTABLE (with the
opposite polarity), this now controls the visibility of
options that get in the way of building generic kernels,
while allowing custom kernels.

One side-effect is that 'randconfig' builds now rarely hit
strongarm machines, rather than testing them three quarters
of the time.

Arnd Bergmann (5):
  ARM: remove obsolete Makefile.boot infrastructure
  ARM: simplify machdirs/platdirs handling
  ARM: Kconfig: clean up platform selection
  ARM: fix CPU_V6 dependencies
  ARM: make ARCH_MULTIPLATFORM user-visible

 arch/arm/Kconfig                       | 123 ++++++-------------------
 arch/arm/Kconfig.debug                 |   8 +-
 arch/arm/Makefile                      |  40 +++-----
 arch/arm/boot/Makefile                 |  27 ++----
 arch/arm/boot/bootp/Makefile           |  35 ++++++-
 arch/arm/configs/assabet_defconfig     |   2 +
 arch/arm/configs/badge4_defconfig      |   2 +
 arch/arm/configs/cerfcube_defconfig    |   2 +
 arch/arm/configs/collie_defconfig      |   2 +
 arch/arm/configs/footbridge_defconfig  |   2 +
 arch/arm/configs/h3600_defconfig       |   2 +
 arch/arm/configs/hackkit_defconfig     |   2 +
 arch/arm/configs/jornada720_defconfig  |   2 +
 arch/arm/configs/lart_defconfig        |   2 +
 arch/arm/configs/neponset_defconfig    |   2 +
 arch/arm/configs/netwinder_defconfig   |   2 +
 arch/arm/configs/pleb_defconfig        |   2 +
 arch/arm/configs/rpc_defconfig         |   2 +
 arch/arm/configs/shannon_defconfig     |   2 +
 arch/arm/configs/simpad_defconfig      |   2 +
 arch/arm/kernel/devtree.c              |   2 -
 arch/arm/mach-at91/Makefile.boot       |   4 -
 arch/arm/mach-davinci/Makefile.boot    |   8 --
 arch/arm/mach-dove/Makefile            |   2 +-
 arch/arm/mach-dove/Makefile.boot       |   4 -
 arch/arm/mach-ep93xx/Makefile.boot     |   2 -
 arch/arm/mach-footbridge/Kconfig       |  19 +++-
 arch/arm/mach-footbridge/Makefile.boot |   5 -
 arch/arm/mach-imx/Kconfig              |   3 +-
 arch/arm/mach-imx/Makefile.boot        |   0
 arch/arm/mach-iop32x/Makefile.boot     |   4 -
 arch/arm/mach-lpc18xx/Makefile.boot    |   4 -
 arch/arm/mach-lpc32xx/Makefile.boot    |   4 -
 arch/arm/mach-mv78xx0/Makefile         |   2 +-
 arch/arm/mach-mvebu/Makefile           |   2 +-
 arch/arm/mach-nspire/Kconfig           |   2 +-
 arch/arm/mach-omap1/Makefile.boot      |   4 -
 arch/arm/mach-omap2/Kconfig            |   1 +
 arch/arm/mach-orion5x/Makefile         |   2 +-
 arch/arm/mach-rpc/Kconfig              |  21 +++++
 arch/arm/mach-rpc/Makefile.boot        |   5 -
 arch/arm/mach-s3c/Makefile.boot        |   9 --
 arch/arm/mach-sa1100/Kconfig           |  25 ++++-
 arch/arm/mach-sa1100/Makefile.boot     |   9 --
 arch/arm/mach-stm32/Makefile.boot      |   4 -
 arch/arm/mach-versatile/Kconfig        |   2 +
 arch/arm/mach-versatile/Makefile.boot  |   4 -
 arch/arm/mach-vt8500/Makefile.boot     |   4 -
 48 files changed, 181 insertions(+), 239 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-davinci/Makefile.boot
 delete mode 100644 arch/arm/mach-dove/Makefile.boot
 delete mode 100644 arch/arm/mach-ep93xx/Makefile.boot
 delete mode 100644 arch/arm/mach-footbridge/Makefile.boot
 delete mode 100644 arch/arm/mach-imx/Makefile.boot
 delete mode 100644 arch/arm/mach-iop32x/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 delete mode 100644 arch/arm/mach-lpc32xx/Makefile.boot
 delete mode 100644 arch/arm/mach-omap1/Makefile.boot
 create mode 100644 arch/arm/mach-rpc/Kconfig
 delete mode 100644 arch/arm/mach-rpc/Makefile.boot
 delete mode 100644 arch/arm/mach-s3c/Makefile.boot
 delete mode 100644 arch/arm/mach-sa1100/Makefile.boot
 delete mode 100644 arch/arm/mach-stm32/Makefile.boot
 delete mode 100644 arch/arm/mach-versatile/Makefile.boot
 delete mode 100644 arch/arm/mach-vt8500/Makefile.boot

-- 
2.29.2

Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
