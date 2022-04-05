Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6184F3D94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359140AbiDEOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbiDEJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661545AF5;
        Tue,  5 Apr 2022 02:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37E2A61645;
        Tue,  5 Apr 2022 09:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99892C385A0;
        Tue,  5 Apr 2022 09:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150283;
        bh=kvr3sgPHf3axRXpU69GmALbuJdlD0kPFvleuTBcq6Zs=;
        h=From:To:Cc:Subject:Date:From;
        b=nTHfcfgak7hSxFqxNbhLh4AJg51mWI8KHIOyE5zAXrlYOgb6MJQ+6YZTvcMUcVfvp
         mEBjp9B7+wd3LhIv2uS6m9Uqj2Up+ozw8k7Q6u7/HkixCURqQFJphhER666GvzQTAt
         p1Sojt0z4bv7mCg1xlsPJ99mk1SPhiE0fHKSy8RNWBnpNJ4wM0zJfzgK23IGU9TfRT
         FI7wLblmei0I7MxyE8KA242e+AYN0pIDxlFYyDB/kvKdK7zPM8WOmPgfLdbVZOiLFk
         pD6r04D5dAyzsHpOOhNz3ZlloUCklIMaoloroJ1alTHwFu6WSysd0ma1VFfrKEevNV
         5VCPHejg0qrSQ==
From:   Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
Date:   Tue,  5 Apr 2022 11:17:38 +0200
Message-Id: <20220405091750.3076973-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I revisited some patches from a few years back, to see what
is needed forsome of the remaining platforms to become part of
CONFIG_ARCH_MULTIPLATFORM.

A few things happened since I last looked at this, which helps to make
this easier:

 - The ixp4xx platform saw a large scale cleanup

 - The ep93xx platform lost support for MaverickCrunch FPUs and
   gained support for the common clock subsystem

 - The OMAP1 platform has a proposed patch for the common
   clock subsystem.

 - The generic IRQ entry code is now used everywhere, including
   on IOP32x.

 - The s3c24xx platform is scheduled for removal next year

It appears that we can now convert almost all the remaining platforms
(ep93xx, dove, s3c24xx, iop32x and ixp4xx), leaving only:

 - OMAP1 has a separate series, since the conversion is non- trivial,
   and depends on the clk conversion from Janusz Krzysztofik. I'll
   post that separately.

 - PXA needs an even longer series, which I've also sent in the past,
   but I'll keep that for later.

 - The three StrongARM based platforms remain quite different from
   the rest, and I expect that to stay this way, until they are
   eventually removed from the tree.

For simplicity I'd want to merge the series directly through the
soc tree, provided there are no regressions or other concerns
with the patches.

       Arnd

Arnd Bergmann (12):
  ARM: versatile: move integrator/realview/vexpress to versatile
  ARM: ep93xx: renumber interrupts
  ARM: ep93xx: enable SPARSE_IRQ
  ARM: ep93xx: make mach/ep93xx-regs.h local
  ARM: ep93xx: multiplatform support
  ARM: dove: multiplatform support
  ARM: s3c24xx: remove support for ISA drivers on BAST PC/104
  ARM: s3c24xx: convert to sparse-irq
  ARM: s3c: enable s3c24xx multiplatform support
  ARM: iop32x: enable multiplatform support
  ARM: rework endianess selection
  ARM: ixp4xx: enable multiplatform support

 MAINTAINERS                                   |   3 -
 arch/arm/Kconfig                              |  87 +----
 arch/arm/Makefile                             |   7 +-
 .../compressed/misc-ep93xx.h}                 |  70 ++--
 arch/arm/boot/compressed/misc.c               |   4 +
 arch/arm/configs/dove_defconfig               |   2 +
 arch/arm/configs/ep93xx_defconfig             |   2 +
 arch/arm/mach-asm9260/Kconfig                 |   1 +
 arch/arm/mach-aspeed/Kconfig                  |   2 +-
 arch/arm/mach-at91/Kconfig                    |   3 +-
 arch/arm/mach-clps711x/Kconfig                |   1 +
 arch/arm/mach-davinci/Kconfig                 |   1 +
 arch/arm/mach-dove/Kconfig                    |  16 +-
 arch/arm/mach-dove/Makefile                   |   2 +
 arch/arm/mach-dove/include/mach/uncompress.h  |  34 --
 arch/arm/mach-ep93xx/Kconfig                  |  13 +
 arch/arm/mach-ep93xx/adssphere.c              |   1 +
 arch/arm/mach-ep93xx/core.c                   |   5 +-
 arch/arm/mach-ep93xx/edb93xx.c                |   8 +
 .../{include/mach => }/ep93xx-regs.h          |   4 -
 arch/arm/mach-ep93xx/gesbc9312.c              |   1 +
 arch/arm/mach-ep93xx/gpio-ep93xx.h            |   2 +-
 arch/arm/mach-ep93xx/include/mach/irqs.h      |  79 -----
 arch/arm/mach-ep93xx/irqs.h                   |  76 +++++
 arch/arm/mach-ep93xx/micro9.c                 |   4 +
 arch/arm/mach-ep93xx/simone.c                 |   1 +
 arch/arm/mach-ep93xx/snappercl15.c            |   1 +
 arch/arm/mach-ep93xx/soc.h                    |   3 +-
 arch/arm/mach-ep93xx/ts72xx.c                 |   3 +-
 arch/arm/mach-ep93xx/vision_ep9307.c          |   1 +
 arch/arm/mach-exynos/Kconfig                  |   1 -
 arch/arm/mach-gemini/Kconfig                  |   1 +
 arch/arm/mach-highbank/Kconfig                |   1 -
 arch/arm/mach-hisi/Kconfig                    |   2 +-
 arch/arm/mach-imx/Kconfig                     |   4 +-
 arch/arm/mach-integrator/Kconfig              | 125 -------
 arch/arm/mach-integrator/Makefile             |  10 -
 arch/arm/mach-iop32x/Kconfig                  |  18 +-
 arch/arm/mach-iop32x/em7210.c                 |   1 +
 arch/arm/mach-iop32x/glantank.c               |   1 +
 arch/arm/mach-iop32x/include/mach/irqs.h      |  14 -
 .../arm/mach-iop32x/include/mach/uncompress.h |  25 --
 arch/arm/mach-iop32x/iq31244.c                |   1 +
 arch/arm/mach-iop32x/iq80321.c                |   1 +
 arch/arm/mach-iop32x/irqs.h                   |   2 +
 arch/arm/mach-iop32x/n2100.c                  |   1 +
 arch/arm/mach-ixp4xx/Kconfig                  |  22 +-
 arch/arm/mach-ixp4xx/Makefile.boot            |   4 -
 .../arm/mach-ixp4xx/include/mach/uncompress.h |  54 ---
 arch/arm/mach-keystone/Kconfig                |   1 -
 arch/arm/mach-lpc32xx/Kconfig                 |   1 +
 arch/arm/mach-mmp/Kconfig                     |   2 +-
 arch/arm/mach-moxart/Kconfig                  |   1 +
 arch/arm/mach-mv78xx0/Kconfig                 |   1 +
 arch/arm/mach-mvebu/Kconfig                   |   3 +-
 arch/arm/mach-mxs/Kconfig                     |   1 +
 arch/arm/mach-nomadik/Kconfig                 |   1 +
 arch/arm/mach-npcm/Kconfig                    |   2 +-
 arch/arm/mach-nspire/Kconfig                  |   1 +
 arch/arm/mach-orion5x/Kconfig                 |   1 +
 arch/arm/mach-oxnas/Kconfig                   |   2 +-
 arch/arm/mach-qcom/Kconfig                    |   1 -
 arch/arm/mach-realview/Kconfig                | 103 ------
 arch/arm/mach-realview/Makefile               |   8 -
 arch/arm/mach-s3c/Kconfig.s3c24xx             |  25 +-
 arch/arm/mach-s3c/bast-ide.c                  |   2 +-
 arch/arm/mach-s3c/bast-irq.c                  |   2 +-
 arch/arm/mach-s3c/cpu.c                       |   2 +-
 arch/arm/mach-s3c/dev-audio-s3c64xx.c         |   2 +-
 arch/arm/mach-s3c/dev-uart-s3c64xx.c          |   2 +-
 arch/arm/mach-s3c/devs.c                      |   2 +-
 arch/arm/mach-s3c/gpio-samsung.c              |   2 +-
 arch/arm/mach-s3c/include/mach/io-s3c24xx.h   |  50 ---
 arch/arm/mach-s3c/include/mach/io.h           |   8 -
 arch/arm/mach-s3c/irq-pm-s3c24xx.c            |   2 +-
 arch/arm/mach-s3c/irq-s3c24xx.c               |   2 +-
 .../{include/mach => }/irqs-s3c24xx.h         |  18 +-
 .../{include/mach => }/irqs-s3c64xx.h         |   0
 arch/arm/mach-s3c/{include/mach => }/irqs.h   |   0
 arch/arm/mach-s3c/mach-amlm5900.c             |   2 +
 arch/arm/mach-s3c/mach-anubis.c               |   6 +-
 arch/arm/mach-s3c/mach-anw6410.c              |   2 +-
 arch/arm/mach-s3c/mach-at2440evb.c            |   1 +
 arch/arm/mach-s3c/mach-bast.c                 |   6 +-
 arch/arm/mach-s3c/mach-crag6410-module.c      |   2 +-
 arch/arm/mach-s3c/mach-crag6410.c             |   2 +-
 arch/arm/mach-s3c/mach-gta02.c                |   1 +
 arch/arm/mach-s3c/mach-h1940.c                |   1 +
 arch/arm/mach-s3c/mach-hmt.c                  |   2 +-
 arch/arm/mach-s3c/mach-jive.c                 |   2 +-
 arch/arm/mach-s3c/mach-mini2440.c             |   3 +-
 arch/arm/mach-s3c/mach-mini6410.c             |   2 +-
 arch/arm/mach-s3c/mach-n30.c                  |   2 +
 arch/arm/mach-s3c/mach-ncp.c                  |   2 +-
 arch/arm/mach-s3c/mach-nexcoder.c             |   1 +
 arch/arm/mach-s3c/mach-osiris.c               |   6 +-
 arch/arm/mach-s3c/mach-otom.c                 |   1 +
 arch/arm/mach-s3c/mach-qt2410.c               |   1 +
 arch/arm/mach-s3c/mach-real6410.c             |   2 +-
 arch/arm/mach-s3c/mach-rx1950.c               |   1 +
 arch/arm/mach-s3c/mach-rx3715.c               |   7 +-
 arch/arm/mach-s3c/mach-smartq5.c              |   2 +-
 arch/arm/mach-s3c/mach-smartq7.c              |   2 +-
 arch/arm/mach-s3c/mach-smdk2410.c             |   1 +
 arch/arm/mach-s3c/mach-smdk2413.c             |   3 +
 arch/arm/mach-s3c/mach-smdk2416.c             |  11 +-
 arch/arm/mach-s3c/mach-smdk2440.c             |  11 +-
 arch/arm/mach-s3c/mach-smdk2443.c             |  12 +-
 arch/arm/mach-s3c/mach-smdk6400.c             |   2 +-
 arch/arm/mach-s3c/mach-smdk6410.c             |   2 +-
 arch/arm/mach-s3c/mach-tct_hammer.c           |   1 +
 arch/arm/mach-s3c/mach-vr1000.c               |   6 +-
 arch/arm/mach-s3c/mach-vstms.c                |   1 +
 .../mach-s3c/{include/mach => }/map-base.h    |   6 +
 arch/arm/mach-s3c/map-s3c24xx.h               |   2 +-
 arch/arm/mach-s3c/map-s3c64xx.h               |   2 +-
 arch/arm/mach-s3c/pl080.c                     |   2 +-
 arch/arm/mach-s3c/pm-core-s3c24xx.h           |   2 +-
 arch/arm/mach-s3c/pm-s3c2412.c                |   2 +-
 arch/arm/mach-s3c/pm-s3c64xx.c                |   2 +-
 arch/arm/mach-s3c/pm.c                        |   2 +-
 arch/arm/mach-s3c/s3c2443.c                   |   2 +-
 arch/arm/mach-s3c/s3c24xx.h                   |   2 +-
 arch/arm/mach-s3c/s3c64xx.c                   |   2 +-
 arch/arm/mach-s3c/simtec-usb.c                |   2 +-
 arch/arm/mach-socfpga/Kconfig                 |   1 -
 arch/arm/mach-spear/Kconfig                   |   2 +-
 arch/arm/mach-sunxi/Kconfig                   |   3 +-
 arch/arm/mach-versatile/Kconfig               | 309 ++++++++++++++++++
 arch/arm/mach-versatile/Makefile              |  32 +-
 .../Makefile.boot                             |   0
 .../{mach-vexpress => mach-versatile}/dcscb.c |   4 +-
 .../dcscb_setup.S                             |   2 -
 .../headsmp.S                                 |   2 -
 .../hotplug.c                                 |   2 +-
 .../cm.h => mach-versatile/integrator-cm.h}   |   0
 .../integrator-hardware.h}                    |   0
 .../core.c => mach-versatile/integrator.c}    |   8 +-
 .../common.h => mach-versatile/integrator.h}  |   0
 .../integrator_ap.c                           |   8 +-
 .../integrator_cp.c                           |   8 +-
 .../platsmp-realview.c}                       |   2 +-
 .../platsmp-vexpress.c}                       |   7 +-
 .../platsmp.c                                 |   4 +-
 .../include/plat => mach-versatile}/platsmp.h |   2 -
 .../realview.c}                               |   0
 .../{mach-vexpress => mach-versatile}/spc.c   |   0
 .../{mach-vexpress => mach-versatile}/spc.h   |   0
 .../tc2_pm.c                                  |   2 -
 .../v2m-mps2.c                                |   0
 .../{mach-vexpress => mach-versatile}/v2m.c   |   2 +-
 .../{versatile_dt.c => versatile.c}           |   0
 .../core.h => mach-versatile/vexpress.h}      |   0
 arch/arm/mach-vexpress/Kconfig                |  81 -----
 arch/arm/mach-vexpress/Makefile               |  19 --
 arch/arm/mach-vt8500/Kconfig                  |   1 +
 arch/arm/mach-zynq/Kconfig                    |   1 -
 arch/arm/mm/Kconfig                           |  28 +-
 arch/arm/plat-versatile/Makefile              |   5 -
 159 files changed, 708 insertions(+), 937 deletions(-)
 rename arch/arm/{mach-ep93xx/include/mach/uncompress.h => boot/compressed/misc-ep93xx.h} (51%)
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 rename arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h (94%)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-ep93xx/irqs.h
 delete mode 100644 arch/arm/mach-integrator/Kconfig
 delete mode 100644 arch/arm/mach-integrator/Makefile
 delete mode 100644 arch/arm/mach-iop32x/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ixp4xx/Makefile.boot
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-realview/Kconfig
 delete mode 100644 arch/arm/mach-realview/Makefile
 delete mode 100644 arch/arm/mach-s3c/include/mach/io-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/include/mach/io.h
 rename arch/arm/mach-s3c/{include/mach => }/irqs-s3c24xx.h (95%)
 rename arch/arm/mach-s3c/{include/mach => }/irqs-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/irqs.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/map-base.h (87%)
 rename arch/arm/{mach-vexpress => mach-versatile}/Makefile.boot (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb.c (97%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb_setup.S (95%)
 rename arch/arm/{plat-versatile => mach-versatile}/headsmp.S (94%)
 rename arch/arm/{plat-versatile => mach-versatile}/hotplug.c (98%)
 rename arch/arm/{mach-integrator/cm.h => mach-versatile/integrator-cm.h} (100%)
 rename arch/arm/{mach-integrator/hardware.h => mach-versatile/integrator-hardware.h} (100%)
 rename arch/arm/{mach-integrator/core.c => mach-versatile/integrator.c} (95%)
 rename arch/arm/{mach-integrator/common.h => mach-versatile/integrator.h} (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_ap.c (97%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_cp.c (96%)
 rename arch/arm/{mach-realview/platsmp-dt.c => mach-versatile/platsmp-realview.c} (98%)
 rename arch/arm/{mach-vexpress/platsmp.c => mach-versatile/platsmp-vexpress.c} (96%)
 rename arch/arm/{plat-versatile => mach-versatile}/platsmp.c (97%)
 rename arch/arm/{plat-versatile/include/plat => mach-versatile}/platsmp.h (87%)
 rename arch/arm/{mach-realview/realview-dt.c => mach-versatile/realview.c} (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.h (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/tc2_pm.c (99%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m-mps2.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m.c (97%)
 rename arch/arm/mach-versatile/{versatile_dt.c => versatile.c} (100%)
 rename arch/arm/{mach-vexpress/core.h => mach-versatile/vexpress.h} (100%)
 delete mode 100644 arch/arm/mach-vexpress/Kconfig
 delete mode 100644 arch/arm/mach-vexpress/Makefile
 delete mode 100644 arch/arm/plat-versatile/Makefile

-- 
2.29.2
Cc: Russell King <linux@armlinux.org.uk>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Simtec Linux Team <linux@simtec.co.uk>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: patches@opensource.cirrus.com
