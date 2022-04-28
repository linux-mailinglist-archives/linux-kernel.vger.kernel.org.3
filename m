Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90351352F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbiD1Nfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiD1Nfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6521244;
        Thu, 28 Apr 2022 06:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782F860DED;
        Thu, 28 Apr 2022 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A624C385AA;
        Thu, 28 Apr 2022 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152743;
        bh=JsV1sFJZ9UUFrPthW2CdJOTShILL+Ek8c6jy/gf9mwM=;
        h=From:To:Cc:Subject:Date:From;
        b=JaQ31fAT1d+xml6BUXcP6jWSgm9Vn27s18u8CIB0dLus0yKqY17XNjfNXQppuCr1U
         6NlfvoqfYKWzb+i41z/7vz6jW0z4A9ByuyY79icFmCs+zmgfLDEtp88fhakXbCt3IF
         6ugCyogfKF/kv93Gyytiklj5EvCUmqwq0u1AuehFDx6wNwP5bQGcR5nNGIO4iEToMO
         d6FPKDTNBqU48+uMXnidFtMc83FjxMfGVanKZ7BB5g5jiQUfyjPdO9+yH30RLNqglY
         3TyP/lhv9Z96O71ercIX/Xc6uVPiXsD7Kjsa5sKVSOewblrr/Hz6eWKo3QW6utPNId
         G9TkYzVDWGz+w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/6] ARM: omap/davinci/spear fixes for multiplatform
Date:   Thu, 28 Apr 2022 15:31:52 +0200
Message-Id: <20220428133210.990808-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I got a few emails about (harmless) warnings and one build
failure or my pending omap1 multiplatform changes. I fixed them
up here, and added three more patches to move the platform
headers from the now obsolete include/mach/ subdir into
the corresponding platforms where this was not already done.

I already have these in the arm/multiplatform branch of the soc
tree, and if everyone is happy with the changes, I'll just
merge this into the for-next branch.

      Arnd

Arnd Bergmann (6):
  ARM: omap2: remove include/mach/ subdirectory
  ARM: davinci: remove include/mach/ subdirectory
  ARM: spear: remove include/mach/ subdirectory
  ARM: omap: fix address space warnings from sparse
  ARM: omap2: fix missing declaration warnings
  ARM: omap1: add back omap_set_dma_priority() stub

 arch/arm/mach-davinci/Makefile                |   4 +-
 arch/arm/mach-davinci/board-da830-evm.c       |   7 +-
 arch/arm/mach-davinci/board-da850-evm.c       |   7 +-
 arch/arm/mach-davinci/board-dm355-evm.c       |   5 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |   5 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   6 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |   7 +-
 arch/arm/mach-davinci/board-dm646x-evm.c      |   5 +-
 arch/arm/mach-davinci/board-mityomapl138.c    |   8 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |   7 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c   |   6 +-
 arch/arm/mach-davinci/board-sffsdr.c          |   6 +-
 arch/arm/mach-davinci/common.c                |   4 +-
 .../mach-davinci/{include/mach => }/common.h  |   0
 .../mach-davinci/{include/mach => }/cputype.h |   2 +-
 arch/arm/mach-davinci/da830.c                 |  11 +-
 arch/arm/mach-davinci/da850.c                 |  12 +-
 arch/arm/mach-davinci/da8xx-dt.c              |   4 +-
 .../mach-davinci/{include/mach => }/da8xx.h   |   5 +-
 arch/arm/mach-davinci/davinci.h               |   3 +-
 arch/arm/mach-davinci/devices-da8xx.c         |   7 +-
 arch/arm/mach-davinci/devices.c               |   7 +-
 arch/arm/mach-davinci/dm355.c                 |  12 +-
 arch/arm/mach-davinci/dm365.c                 |  12 +-
 arch/arm/mach-davinci/dm644x.c                |  12 +-
 arch/arm/mach-davinci/dm646x.c                |  12 +-
 .../{include/mach => }/hardware.h             |   0
 arch/arm/mach-davinci/include/mach/mux.h      | 990 ------------------
 .../mach-davinci/include/mach/uncompress.h    |  97 --
 arch/arm/mach-davinci/mux.c                   |   4 +-
 arch/arm/mach-davinci/mux.h                   | 969 ++++++++++++++++-
 arch/arm/mach-davinci/pdata-quirks.c          |   4 +-
 arch/arm/mach-davinci/pm.c                    |   9 +-
 arch/arm/mach-davinci/{include/mach => }/pm.h |   0
 arch/arm/mach-davinci/serial.c                |   4 +-
 .../mach-davinci/{include/mach => }/serial.h  |   2 +-
 arch/arm/mach-davinci/sram.c                  |   2 +-
 arch/arm/mach-davinci/usb-da8xx.c             |   7 +-
 arch/arm/mach-davinci/usb.c                   |   5 +-
 arch/arm/mach-omap1/board-ams-delta.c         |   2 +-
 arch/arm/mach-omap1/fb.c                      |   2 +-
 arch/arm/mach-omap1/i2c.c                     |   1 +
 arch/arm/mach-omap1/omap-dma.c                |  18 +-
 arch/arm/mach-omap1/sram-init.c               |   2 +-
 arch/arm/mach-omap1/timer32k.c                |   2 +-
 arch/arm/mach-omap2/Makefile                  |   3 -
 arch/arm/mach-omap2/common.h                  |  13 +-
 arch/arm/mach-omap2/dma.c                     |   1 +
 arch/arm/mach-omap2/include/mach/hardware.h   |   3 -
 arch/arm/mach-omap2/include/mach/irqs.h       |   3 -
 arch/arm/mach-omap2/include/mach/serial.h     |  66 --
 arch/arm/mach-omap2/omap-iommu.c              |   1 +
 arch/arm/mach-omap2/pdata-quirks.c            |  11 -
 arch/arm/mach-omap2/serial.h                  |  67 +-
 arch/arm/mach-spear/Makefile                  |   2 -
 arch/arm/mach-spear/include/mach/irqs.h       |  35 -
 arch/arm/mach-spear/include/mach/uncompress.h |  42 -
 .../mach-spear/{include/mach => }/misc_regs.h |   4 +-
 arch/arm/mach-spear/pl080.c                   |   4 +-
 arch/arm/mach-spear/platsmp.c                 |   2 +-
 arch/arm/mach-spear/restart.c                 |   2 +-
 .../arm/mach-spear/{include/mach => }/spear.h |   0
 arch/arm/mach-spear/spear1310.c               |   2 +-
 arch/arm/mach-spear/spear13xx.c               |   2 +-
 arch/arm/mach-spear/spear300.c                |   2 +-
 arch/arm/mach-spear/spear310.c                |   2 +-
 arch/arm/mach-spear/spear320.c                |   2 +-
 arch/arm/mach-spear/spear3xx.c                |   4 +-
 arch/arm/mach-spear/spear6xx.c                |   4 +-
 include/linux/omap-dma.h                      |   7 +
 70 files changed, 1172 insertions(+), 1408 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/common.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cputype.h (98%)
 rename arch/arm/mach-davinci/{include/mach => }/da8xx.h (99%)
 rename arch/arm/mach-davinci/{include/mach => }/hardware.h (100%)
 delete mode 100644 arch/arm/mach-davinci/include/mach/mux.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/uncompress.h
 rename arch/arm/mach-davinci/{include/mach => }/pm.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/serial.h (97%)
 delete mode 100644 arch/arm/mach-omap2/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/serial.h
 delete mode 100644 arch/arm/mach-spear/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-spear/include/mach/uncompress.h
 rename arch/arm/mach-spear/{include/mach => }/misc_regs.h (87%)
 rename arch/arm/mach-spear/{include/mach => }/spear.h (100%)

-- 
2.29.2

