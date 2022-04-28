Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC6C51353D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbiD1Nh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiD1Nh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:37:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5543630B;
        Thu, 28 Apr 2022 06:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D22B4B82D08;
        Thu, 28 Apr 2022 13:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3D2C385A9;
        Thu, 28 Apr 2022 13:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152847;
        bh=ZBLz8uugsYLi5KvMGe/DMTBlaDfUbhFTpXSlj5ruvsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7bOiewtf17r2K44zvuSM6WROxyltw+4mfBoS1uIndhsVTnekpqLts4JFgIaG4qv4
         fbUcEe2npLunjpDuAvw3Q8DwIhbthSkBOqr+TkeC/tk9Y6DdZxM4y+Lxn9x0O52u8k
         e6TUy/ipwozJmt5sIo2Womto3689sQj0CZ2Y7O6UZL+yGHwNFw+ZYi72UJB4KAYkjf
         BU+nN8hb3dz7UuUVXWZ+z7OvB4NssgdpFer0lpd5WVcdk3HkwbeCj81RykceAms8EN
         7Rt9cHBzZKoUjmwiXGu9cwAx9kh3ikdNIYH8Ho0TK9CGRj6p5PGCUvKFcJNl1AG4S8
         kjBlQgzwQLEjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tony@atomide.com, jmkrzyszt@gmail.com, aaro.koskinen@iki.fi,
        vireshk@kernel.org, shiraz.linux.kernel@gmail.com, nsekhar@ti.com,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/6] ARM: davinci: remove include/mach/ subdirectory
Date:   Thu, 28 Apr 2022 15:31:54 +0200
Message-Id: <20220428133210.990808-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220428133210.990808-1-arnd@kernel.org>
References: <20220428133210.990808-1-arnd@kernel.org>
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

The files in include/mach are only used from mach/davinci,
so they are no longer needed in the traditional location.

Move them to arch/arm/mach-davinci/ and drop the logic for
the special include path.

The mach/uncompress.h file is not used at all and can just
be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
 39 files changed, 1064 insertions(+), 1205 deletions(-)
 rename arch/arm/mach-davinci/{include/mach => }/common.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/cputype.h (98%)
 rename arch/arm/mach-davinci/{include/mach => }/da8xx.h (99%)
 rename arch/arm/mach-davinci/{include/mach => }/hardware.h (100%)
 delete mode 100644 arch/arm/mach-davinci/include/mach/mux.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/uncompress.h
 rename arch/arm/mach-davinci/{include/mach => }/pm.h (100%)
 rename arch/arm/mach-davinci/{include/mach => }/serial.h (97%)

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 58838a9de651..b04c084b707e 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -3,9 +3,7 @@
 # Makefile for the linux kernel.
 #
 #
-
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
-
+#
 # Common objects
 obj-y 					:= serial.o usb.o common.o sram.o
 
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 823c9cc98f18..86a037d629bb 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -36,10 +36,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/mux.h>
-#include <mach/da8xx.h>
-
+#include "common.h"
+#include "mux.h"
+#include "da8xx.h"
 #include "irqs.h"
 
 #define DA830_EVM_PHY_ID		""
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 428012687a80..f4df5eceb9be 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -43,10 +43,9 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 
-#include <mach/common.h>
-#include <mach/da8xx.h>
-#include <mach/mux.h>
-
+#include "common.h"
+#include "da8xx.h"
+#include "mux.h"
 #include "irqs.h"
 #include "sram.h"
 
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 3c5a9e3c128a..f7c56f662d4c 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -33,9 +33,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/serial.h>
-#include <mach/common.h>
-
+#include "serial.h"
+#include "common.h"
 #include "davinci.h"
 
 /* NOTE:  this is geared for the standard config, with a socketed
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index e475b2113e70..0f2b61266197 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -27,9 +27,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/serial.h>
-
+#include "common.h"
+#include "serial.h"
 #include "davinci.h"
 
 /* NOTE:  this is geared for the standard config, with a socketed
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index b3bef74c982a..9adcb5879d14 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -36,10 +36,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/mux.h>
-#include <mach/common.h>
 #include <linux/platform_data/i2c-davinci.h>
-#include <mach/serial.h>
 #include <linux/platform_data/mmc-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/keyscan-davinci.h>
@@ -47,6 +44,9 @@
 #include <media/i2c/ths7303.h>
 #include <media/i2c/tvp514x.h>
 
+#include "mux.h"
+#include "common.h"
+#include "serial.h"
 #include "davinci.h"
 
 static inline int have_imager(void)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index cce3a621eb20..070fb06cd1ff 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -37,10 +37,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/mux.h>
-#include <mach/serial.h>
-
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mmc-davinci.h>
@@ -49,6 +45,9 @@
 #include <linux/platform_data/ti-aemif.h>
 
 #include "davinci.h"
+#include "common.h"
+#include "mux.h"
+#include "serial.h"
 #include "irqs.h"
 
 #define DM644X_EVM_PHY_ID		"davinci_mdio-0:01"
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ee91d81ebbfd..f258180f36ae 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -43,9 +43,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/serial.h>
-
+#include "common.h"
+#include "serial.h"
 #include "davinci.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2127969beb96..3f084bdb9bc5 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -28,12 +28,14 @@
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/common.h>
-#include <mach/da8xx.h>
+
+#include "common.h"
+#include "da8xx.h"
+#include "mux.h"
+
 #include <linux/platform_data/mtd-davinci.h>
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/ti-aemif.h>
-#include <mach/mux.h>
 #include <linux/platform_data/spi-davinci.h>
 
 #define MITYOMAPL138_PHY_ID		""
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index b4843f68bb57..94be492b8a9e 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -36,10 +36,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/serial.h>
-#include <mach/mux.h>
-
+#include "common.h"
+#include "serial.h"
+#include "mux.h"
 #include "davinci.h"
 
 #define NEUROS_OSD2_PHY_ID		"davinci_mdio-0:01"
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 88df8011a4e6..20f71856bf7e 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -27,9 +27,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/da8xx.h>
-#include <mach/mux.h>
+#include "common.h"
+#include "da8xx.h"
+#include "mux.h"
 
 #define HAWKBOARD_PHY_ID		"davinci_mdio-0:07"
 
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 6930b2f485d1..e87fd8f82d89 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -22,12 +22,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
-#include <mach/common.h>
 #include <linux/platform_data/i2c-davinci.h>
-#include <mach/serial.h>
-#include <mach/mux.h>
 #include <linux/platform_data/usb-davinci.h>
 
+#include "common.h"
+#include "serial.h"
+#include "mux.h"
 #include "davinci.h"
 
 #define SFFSDR_PHY_ID		"davinci_mdio-0:01"
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index ae61d19f9b3a..0a6f826ff136 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -17,8 +17,8 @@
 #include <asm/tlb.h>
 #include <asm/mach/map.h>
 
-#include <mach/common.h>
-#include <mach/cputype.h>
+#include "common.h"
+#include "cputype.h"
 
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/common.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/common.h
rename to arch/arm/mach-davinci/common.h
diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/cputype.h
similarity index 98%
rename from arch/arm/mach-davinci/include/mach/cputype.h
rename to arch/arm/mach-davinci/cputype.h
index 1fc84e21664d..1fe9f84d5ee6 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/cputype.h
@@ -16,7 +16,7 @@
 #ifndef _ASM_ARCH_CPU_H
 #define _ASM_ARCH_CPU_H
 
-#include <mach/common.h>
+#include "common.h"
 
 struct davinci_id {
 	u8	variant;	/* JTAG ID bits 31:28 */
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 018ab4b549f1..1b86657c6e9d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -16,14 +16,13 @@
 #include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/da8xx.h>
-
 #include <clocksource/timer-davinci.h>
 
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "cputype.h"
+#include "da8xx.h"
 #include "irqs.h"
 #include "mux.h"
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68156e7239a6..cd514c136de0 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -28,16 +28,14 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <clocksource/timer-davinci.h>
 
 #include <asm/mach/map.h>
 
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/da8xx.h>
-#include <mach/pm.h>
-
-#include <clocksource/timer-davinci.h>
-
+#include "common.h"
+#include "cputype.h"
+#include "da8xx.h"
+#include "pm.h"
 #include "irqs.h"
 #include "mux.h"
 
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 0cd2f30aeb9c..45763a9b37ee 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -7,8 +7,8 @@
 
 #include <asm/mach/arch.h>
 
-#include <mach/common.h>
-#include <mach/da8xx.h>
+#include "common.h"
+#include "da8xx.h"
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/da8xx.h
similarity index 99%
rename from arch/arm/mach-davinci/include/mach/da8xx.h
rename to arch/arm/mach-davinci/da8xx.h
index 1618b30661a9..699df08714ba 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/da8xx.h
@@ -21,8 +21,9 @@
 #include <linux/regmap.h>
 #include <linux/videodev2.h>
 
-#include <mach/serial.h>
-#include <mach/pm.h>
+#include "serial.h"
+#include "pm.h"
+
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/i2c-davinci.h>
 #include <linux/platform_data/mmc-davinci.h>
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 208d7a4d3597..e895eaf9c7cc 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -25,7 +25,8 @@
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/keyscan-davinci.h>
-#include <mach/hardware.h>
+
+#include "hardware.h"
 
 #include <media/davinci/vpfe_capture.h>
 #include <media/davinci/vpif_types.h>
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bb368938fc49..ef9593558e5f 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -18,10 +18,9 @@
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
 
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/da8xx.h>
-
+#include "common.h"
+#include "cputype.h"
+#include "da8xx.h"
 #include "asp.h"
 #include "cpuidle.h"
 #include "irqs.h"
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 849e811fade7..199c26d9a2b6 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -14,10 +14,9 @@
 #include <linux/io.h>
 #include <linux/reboot.h>
 
-#include <mach/hardware.h>
-#include <mach/cputype.h>
-#include <mach/mux.h>
-
+#include "hardware.h"
+#include "cputype.h"
+#include "mux.h"
 #include "davinci.h"
 #include "irqs.h"
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5de72d2fa8f0..1d7443c59b14 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -24,15 +24,13 @@
 #include <linux/serial_8250.h>
 #include <linux/spi/spi.h>
 
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/mux.h>
-#include <mach/serial.h>
-
 #include <clocksource/timer-davinci.h>
 
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "cputype.h"
+#include "serial.h"
 #include "asp.h"
 #include "davinci.h"
 #include "irqs.h"
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index c1e0d46996e4..73ccc916f60a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -29,15 +29,13 @@
 #include <linux/serial_8250.h>
 #include <linux/spi/spi.h>
 
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/mux.h>
-#include <mach/serial.h>
-
 #include <clocksource/timer-davinci.h>
 
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "cputype.h"
+#include "serial.h"
 #include "asp.h"
 #include "davinci.h"
 #include "irqs.h"
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 24988939ae46..1ce48d0fb16d 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -21,15 +21,13 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/mux.h>
-#include <mach/serial.h>
-
 #include <clocksource/timer-davinci.h>
 
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "cputype.h"
+#include "serial.h"
 #include "asp.h"
 #include "davinci.h"
 #include "irqs.h"
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 4ffd028ed997..971b2d4e2595 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -22,15 +22,13 @@
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 
-#include <asm/mach/map.h>
-
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/mux.h>
-#include <mach/serial.h>
-
 #include <clocksource/timer-davinci.h>
 
+#include <asm/mach/map.h>
+
+#include "common.h"
+#include "cputype.h"
+#include "serial.h"
 #include "asp.h"
 #include "davinci.h"
 #include "irqs.h"
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/hardware.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/hardware.h
rename to arch/arm/mach-davinci/hardware.h
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
deleted file mode 100644
index 631655e68ae0..000000000000
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ /dev/null
@@ -1,990 +0,0 @@
-/*
- * Table of the DAVINCI register configurations for the PINMUX combinations
- *
- * Author: Vladimir Barinov, MontaVista Software, Inc. <source@mvista.com>
- *
- * Based on linux/include/asm-arm/arch-omap/mux.h:
- * Copyright (C) 2003 - 2005 Nokia Corporation
- *
- * Written by Tony Lindgren
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * Copyright (C) 2008 Texas Instruments.
- */
-
-#ifndef __INC_MACH_MUX_H
-#define __INC_MACH_MUX_H
-
-struct mux_config {
-	const char *name;
-	const char *mux_reg_name;
-	const unsigned char mux_reg;
-	const unsigned char mask_offset;
-	const unsigned char mask;
-	const unsigned char mode;
-	bool debug;
-};
-
-enum davinci_dm644x_index {
-	/* ATA and HDDIR functions */
-	DM644X_HDIREN,
-	DM644X_ATAEN,
-	DM644X_ATAEN_DISABLE,
-
-	/* HPI functions */
-	DM644X_HPIEN_DISABLE,
-
-	/* AEAW functions */
-	DM644X_AEAW,
-	DM644X_AEAW0,
-	DM644X_AEAW1,
-	DM644X_AEAW2,
-	DM644X_AEAW3,
-	DM644X_AEAW4,
-
-	/* Memory Stick */
-	DM644X_MSTK,
-
-	/* I2C */
-	DM644X_I2C,
-
-	/* ASP function */
-	DM644X_MCBSP,
-
-	/* UART1 */
-	DM644X_UART1,
-
-	/* UART2 */
-	DM644X_UART2,
-
-	/* PWM0 */
-	DM644X_PWM0,
-
-	/* PWM1 */
-	DM644X_PWM1,
-
-	/* PWM2 */
-	DM644X_PWM2,
-
-	/* VLYNQ function */
-	DM644X_VLYNQEN,
-	DM644X_VLSCREN,
-	DM644X_VLYNQWD,
-
-	/* EMAC and MDIO function */
-	DM644X_EMACEN,
-
-	/* GPIO3V[0:16] pins */
-	DM644X_GPIO3V,
-
-	/* GPIO pins */
-	DM644X_GPIO0,
-	DM644X_GPIO3,
-	DM644X_GPIO43_44,
-	DM644X_GPIO46_47,
-
-	/* VPBE */
-	DM644X_RGB666,
-
-	/* LCD */
-	DM644X_LOEEN,
-	DM644X_LFLDEN,
-};
-
-enum davinci_dm646x_index {
-	/* ATA function */
-	DM646X_ATAEN,
-
-	/* AUDIO Clock */
-	DM646X_AUDCK1,
-	DM646X_AUDCK0,
-
-	/* CRGEN Control */
-	DM646X_CRGMUX,
-
-	/* VPIF Control */
-	DM646X_STSOMUX_DISABLE,
-	DM646X_STSIMUX_DISABLE,
-	DM646X_PTSOMUX_DISABLE,
-	DM646X_PTSIMUX_DISABLE,
-
-	/* TSIF Control */
-	DM646X_STSOMUX,
-	DM646X_STSIMUX,
-	DM646X_PTSOMUX_PARALLEL,
-	DM646X_PTSIMUX_PARALLEL,
-	DM646X_PTSOMUX_SERIAL,
-	DM646X_PTSIMUX_SERIAL,
-};
-
-enum davinci_dm355_index {
-	/* MMC/SD 0 */
-	DM355_MMCSD0,
-
-	/* MMC/SD 1 */
-	DM355_SD1_CLK,
-	DM355_SD1_CMD,
-	DM355_SD1_DATA3,
-	DM355_SD1_DATA2,
-	DM355_SD1_DATA1,
-	DM355_SD1_DATA0,
-
-	/* I2C */
-	DM355_I2C_SDA,
-	DM355_I2C_SCL,
-
-	/* ASP0 function */
-	DM355_MCBSP0_BDX,
-	DM355_MCBSP0_X,
-	DM355_MCBSP0_BFSX,
-	DM355_MCBSP0_BDR,
-	DM355_MCBSP0_R,
-	DM355_MCBSP0_BFSR,
-
-	/* SPI0 */
-	DM355_SPI0_SDI,
-	DM355_SPI0_SDENA0,
-	DM355_SPI0_SDENA1,
-
-	/* IRQ muxing */
-	DM355_INT_EDMA_CC,
-	DM355_INT_EDMA_TC0_ERR,
-	DM355_INT_EDMA_TC1_ERR,
-
-	/* EDMA event muxing */
-	DM355_EVT8_ASP1_TX,
-	DM355_EVT9_ASP1_RX,
-	DM355_EVT26_MMC0_RX,
-
-	/* Video Out */
-	DM355_VOUT_FIELD,
-	DM355_VOUT_FIELD_G70,
-	DM355_VOUT_HVSYNC,
-	DM355_VOUT_COUTL_EN,
-	DM355_VOUT_COUTH_EN,
-
-	/* Video In Pin Mux */
-	DM355_VIN_PCLK,
-	DM355_VIN_CAM_WEN,
-	DM355_VIN_CAM_VD,
-	DM355_VIN_CAM_HD,
-	DM355_VIN_YIN_EN,
-	DM355_VIN_CINL_EN,
-	DM355_VIN_CINH_EN,
-};
-
-enum davinci_dm365_index {
-	/* MMC/SD 0 */
-	DM365_MMCSD0,
-
-	/* MMC/SD 1 */
-	DM365_SD1_CLK,
-	DM365_SD1_CMD,
-	DM365_SD1_DATA3,
-	DM365_SD1_DATA2,
-	DM365_SD1_DATA1,
-	DM365_SD1_DATA0,
-
-	/* I2C */
-	DM365_I2C_SDA,
-	DM365_I2C_SCL,
-
-	/* AEMIF */
-	DM365_AEMIF_AR_A14,
-	DM365_AEMIF_AR_BA0,
-	DM365_AEMIF_A3,
-	DM365_AEMIF_A7,
-	DM365_AEMIF_D15_8,
-	DM365_AEMIF_CE0,
-	DM365_AEMIF_CE1,
-	DM365_AEMIF_WE_OE,
-
-	/* ASP0 function */
-	DM365_MCBSP0_BDX,
-	DM365_MCBSP0_X,
-	DM365_MCBSP0_BFSX,
-	DM365_MCBSP0_BDR,
-	DM365_MCBSP0_R,
-	DM365_MCBSP0_BFSR,
-
-	/* SPI0 */
-	DM365_SPI0_SCLK,
-	DM365_SPI0_SDI,
-	DM365_SPI0_SDO,
-	DM365_SPI0_SDENA0,
-	DM365_SPI0_SDENA1,
-
-	/* UART */
-	DM365_UART0_RXD,
-	DM365_UART0_TXD,
-	DM365_UART1_RXD,
-	DM365_UART1_TXD,
-	DM365_UART1_RTS,
-	DM365_UART1_CTS,
-
-	/* EMAC */
-	DM365_EMAC_TX_EN,
-	DM365_EMAC_TX_CLK,
-	DM365_EMAC_COL,
-	DM365_EMAC_TXD3,
-	DM365_EMAC_TXD2,
-	DM365_EMAC_TXD1,
-	DM365_EMAC_TXD0,
-	DM365_EMAC_RXD3,
-	DM365_EMAC_RXD2,
-	DM365_EMAC_RXD1,
-	DM365_EMAC_RXD0,
-	DM365_EMAC_RX_CLK,
-	DM365_EMAC_RX_DV,
-	DM365_EMAC_RX_ER,
-	DM365_EMAC_CRS,
-	DM365_EMAC_MDIO,
-	DM365_EMAC_MDCLK,
-
-	/* Key Scan */
-	DM365_KEYSCAN,
-
-	/* PWM */
-	DM365_PWM0,
-	DM365_PWM0_G23,
-	DM365_PWM1,
-	DM365_PWM1_G25,
-	DM365_PWM2_G87,
-	DM365_PWM2_G88,
-	DM365_PWM2_G89,
-	DM365_PWM2_G90,
-	DM365_PWM3_G80,
-	DM365_PWM3_G81,
-	DM365_PWM3_G85,
-	DM365_PWM3_G86,
-
-	/* SPI1 */
-	DM365_SPI1_SCLK,
-	DM365_SPI1_SDO,
-	DM365_SPI1_SDI,
-	DM365_SPI1_SDENA0,
-	DM365_SPI1_SDENA1,
-
-	/* SPI2 */
-	DM365_SPI2_SCLK,
-	DM365_SPI2_SDO,
-	DM365_SPI2_SDI,
-	DM365_SPI2_SDENA0,
-	DM365_SPI2_SDENA1,
-
-	/* SPI3 */
-	DM365_SPI3_SCLK,
-	DM365_SPI3_SDO,
-	DM365_SPI3_SDI,
-	DM365_SPI3_SDENA0,
-	DM365_SPI3_SDENA1,
-
-	/* SPI4 */
-	DM365_SPI4_SCLK,
-	DM365_SPI4_SDO,
-	DM365_SPI4_SDI,
-	DM365_SPI4_SDENA0,
-	DM365_SPI4_SDENA1,
-
-	/* Clock */
-	DM365_CLKOUT0,
-	DM365_CLKOUT1,
-	DM365_CLKOUT2,
-
-	/* GPIO */
-	DM365_GPIO20,
-	DM365_GPIO30,
-	DM365_GPIO31,
-	DM365_GPIO32,
-	DM365_GPIO33,
-	DM365_GPIO40,
-	DM365_GPIO64_57,
-
-	/* Video */
-	DM365_VOUT_FIELD,
-	DM365_VOUT_FIELD_G81,
-	DM365_VOUT_HVSYNC,
-	DM365_VOUT_COUTL_EN,
-	DM365_VOUT_COUTH_EN,
-	DM365_VIN_CAM_WEN,
-	DM365_VIN_CAM_VD,
-	DM365_VIN_CAM_HD,
-	DM365_VIN_YIN4_7_EN,
-	DM365_VIN_YIN0_3_EN,
-
-	/* IRQ muxing */
-	DM365_INT_EDMA_CC,
-	DM365_INT_EDMA_TC0_ERR,
-	DM365_INT_EDMA_TC1_ERR,
-	DM365_INT_EDMA_TC2_ERR,
-	DM365_INT_EDMA_TC3_ERR,
-	DM365_INT_PRTCSS,
-	DM365_INT_EMAC_RXTHRESH,
-	DM365_INT_EMAC_RXPULSE,
-	DM365_INT_EMAC_TXPULSE,
-	DM365_INT_EMAC_MISCPULSE,
-	DM365_INT_IMX0_ENABLE,
-	DM365_INT_IMX0_DISABLE,
-	DM365_INT_HDVICP_ENABLE,
-	DM365_INT_HDVICP_DISABLE,
-	DM365_INT_IMX1_ENABLE,
-	DM365_INT_IMX1_DISABLE,
-	DM365_INT_NSF_ENABLE,
-	DM365_INT_NSF_DISABLE,
-
-	/* EDMA event muxing */
-	DM365_EVT2_ASP_TX,
-	DM365_EVT3_ASP_RX,
-	DM365_EVT2_VC_TX,
-	DM365_EVT3_VC_RX,
-	DM365_EVT26_MMC0_RX,
-};
-
-enum da830_index {
-	DA830_GPIO7_14,
-	DA830_RTCK,
-	DA830_GPIO7_15,
-	DA830_EMU_0,
-	DA830_EMB_SDCKE,
-	DA830_EMB_CLK_GLUE,
-	DA830_EMB_CLK,
-	DA830_NEMB_CS_0,
-	DA830_NEMB_CAS,
-	DA830_NEMB_RAS,
-	DA830_NEMB_WE,
-	DA830_EMB_BA_1,
-	DA830_EMB_BA_0,
-	DA830_EMB_A_0,
-	DA830_EMB_A_1,
-	DA830_EMB_A_2,
-	DA830_EMB_A_3,
-	DA830_EMB_A_4,
-	DA830_EMB_A_5,
-	DA830_GPIO7_0,
-	DA830_GPIO7_1,
-	DA830_GPIO7_2,
-	DA830_GPIO7_3,
-	DA830_GPIO7_4,
-	DA830_GPIO7_5,
-	DA830_GPIO7_6,
-	DA830_GPIO7_7,
-	DA830_EMB_A_6,
-	DA830_EMB_A_7,
-	DA830_EMB_A_8,
-	DA830_EMB_A_9,
-	DA830_EMB_A_10,
-	DA830_EMB_A_11,
-	DA830_EMB_A_12,
-	DA830_EMB_D_31,
-	DA830_GPIO7_8,
-	DA830_GPIO7_9,
-	DA830_GPIO7_10,
-	DA830_GPIO7_11,
-	DA830_GPIO7_12,
-	DA830_GPIO7_13,
-	DA830_GPIO3_13,
-	DA830_EMB_D_30,
-	DA830_EMB_D_29,
-	DA830_EMB_D_28,
-	DA830_EMB_D_27,
-	DA830_EMB_D_26,
-	DA830_EMB_D_25,
-	DA830_EMB_D_24,
-	DA830_EMB_D_23,
-	DA830_EMB_D_22,
-	DA830_EMB_D_21,
-	DA830_EMB_D_20,
-	DA830_EMB_D_19,
-	DA830_EMB_D_18,
-	DA830_EMB_D_17,
-	DA830_EMB_D_16,
-	DA830_NEMB_WE_DQM_3,
-	DA830_NEMB_WE_DQM_2,
-	DA830_EMB_D_0,
-	DA830_EMB_D_1,
-	DA830_EMB_D_2,
-	DA830_EMB_D_3,
-	DA830_EMB_D_4,
-	DA830_EMB_D_5,
-	DA830_EMB_D_6,
-	DA830_GPIO6_0,
-	DA830_GPIO6_1,
-	DA830_GPIO6_2,
-	DA830_GPIO6_3,
-	DA830_GPIO6_4,
-	DA830_GPIO6_5,
-	DA830_GPIO6_6,
-	DA830_EMB_D_7,
-	DA830_EMB_D_8,
-	DA830_EMB_D_9,
-	DA830_EMB_D_10,
-	DA830_EMB_D_11,
-	DA830_EMB_D_12,
-	DA830_EMB_D_13,
-	DA830_EMB_D_14,
-	DA830_GPIO6_7,
-	DA830_GPIO6_8,
-	DA830_GPIO6_9,
-	DA830_GPIO6_10,
-	DA830_GPIO6_11,
-	DA830_GPIO6_12,
-	DA830_GPIO6_13,
-	DA830_GPIO6_14,
-	DA830_EMB_D_15,
-	DA830_NEMB_WE_DQM_1,
-	DA830_NEMB_WE_DQM_0,
-	DA830_SPI0_SOMI_0,
-	DA830_SPI0_SIMO_0,
-	DA830_SPI0_CLK,
-	DA830_NSPI0_ENA,
-	DA830_NSPI0_SCS_0,
-	DA830_EQEP0I,
-	DA830_EQEP0S,
-	DA830_EQEP1I,
-	DA830_NUART0_CTS,
-	DA830_NUART0_RTS,
-	DA830_EQEP0A,
-	DA830_EQEP0B,
-	DA830_GPIO6_15,
-	DA830_GPIO5_14,
-	DA830_GPIO5_15,
-	DA830_GPIO5_0,
-	DA830_GPIO5_1,
-	DA830_GPIO5_2,
-	DA830_GPIO5_3,
-	DA830_GPIO5_4,
-	DA830_SPI1_SOMI_0,
-	DA830_SPI1_SIMO_0,
-	DA830_SPI1_CLK,
-	DA830_UART0_RXD,
-	DA830_UART0_TXD,
-	DA830_AXR1_10,
-	DA830_AXR1_11,
-	DA830_NSPI1_ENA,
-	DA830_I2C1_SCL,
-	DA830_I2C1_SDA,
-	DA830_EQEP1S,
-	DA830_I2C0_SDA,
-	DA830_I2C0_SCL,
-	DA830_UART2_RXD,
-	DA830_TM64P0_IN12,
-	DA830_TM64P0_OUT12,
-	DA830_GPIO5_5,
-	DA830_GPIO5_6,
-	DA830_GPIO5_7,
-	DA830_GPIO5_8,
-	DA830_GPIO5_9,
-	DA830_GPIO5_10,
-	DA830_GPIO5_11,
-	DA830_GPIO5_12,
-	DA830_NSPI1_SCS_0,
-	DA830_USB0_DRVVBUS,
-	DA830_AHCLKX0,
-	DA830_ACLKX0,
-	DA830_AFSX0,
-	DA830_AHCLKR0,
-	DA830_ACLKR0,
-	DA830_AFSR0,
-	DA830_UART2_TXD,
-	DA830_AHCLKX2,
-	DA830_ECAP0_APWM0,
-	DA830_RMII_MHZ_50_CLK,
-	DA830_ECAP1_APWM1,
-	DA830_USB_REFCLKIN,
-	DA830_GPIO5_13,
-	DA830_GPIO4_15,
-	DA830_GPIO2_11,
-	DA830_GPIO2_12,
-	DA830_GPIO2_13,
-	DA830_GPIO2_14,
-	DA830_GPIO2_15,
-	DA830_GPIO3_12,
-	DA830_AMUTE0,
-	DA830_AXR0_0,
-	DA830_AXR0_1,
-	DA830_AXR0_2,
-	DA830_AXR0_3,
-	DA830_AXR0_4,
-	DA830_AXR0_5,
-	DA830_AXR0_6,
-	DA830_RMII_TXD_0,
-	DA830_RMII_TXD_1,
-	DA830_RMII_TXEN,
-	DA830_RMII_CRS_DV,
-	DA830_RMII_RXD_0,
-	DA830_RMII_RXD_1,
-	DA830_RMII_RXER,
-	DA830_AFSR2,
-	DA830_ACLKX2,
-	DA830_AXR2_3,
-	DA830_AXR2_2,
-	DA830_AXR2_1,
-	DA830_AFSX2,
-	DA830_ACLKR2,
-	DA830_NRESETOUT,
-	DA830_GPIO3_0,
-	DA830_GPIO3_1,
-	DA830_GPIO3_2,
-	DA830_GPIO3_3,
-	DA830_GPIO3_4,
-	DA830_GPIO3_5,
-	DA830_GPIO3_6,
-	DA830_AXR0_7,
-	DA830_AXR0_8,
-	DA830_UART1_RXD,
-	DA830_UART1_TXD,
-	DA830_AXR0_11,
-	DA830_AHCLKX1,
-	DA830_ACLKX1,
-	DA830_AFSX1,
-	DA830_MDIO_CLK,
-	DA830_MDIO_D,
-	DA830_AXR0_9,
-	DA830_AXR0_10,
-	DA830_EPWM0B,
-	DA830_EPWM0A,
-	DA830_EPWMSYNCI,
-	DA830_AXR2_0,
-	DA830_EPWMSYNC0,
-	DA830_GPIO3_7,
-	DA830_GPIO3_8,
-	DA830_GPIO3_9,
-	DA830_GPIO3_10,
-	DA830_GPIO3_11,
-	DA830_GPIO3_14,
-	DA830_GPIO3_15,
-	DA830_GPIO4_10,
-	DA830_AHCLKR1,
-	DA830_ACLKR1,
-	DA830_AFSR1,
-	DA830_AMUTE1,
-	DA830_AXR1_0,
-	DA830_AXR1_1,
-	DA830_AXR1_2,
-	DA830_AXR1_3,
-	DA830_ECAP2_APWM2,
-	DA830_EHRPWMGLUETZ,
-	DA830_EQEP1A,
-	DA830_GPIO4_11,
-	DA830_GPIO4_12,
-	DA830_GPIO4_13,
-	DA830_GPIO4_14,
-	DA830_GPIO4_0,
-	DA830_GPIO4_1,
-	DA830_GPIO4_2,
-	DA830_GPIO4_3,
-	DA830_AXR1_4,
-	DA830_AXR1_5,
-	DA830_AXR1_6,
-	DA830_AXR1_7,
-	DA830_AXR1_8,
-	DA830_AXR1_9,
-	DA830_EMA_D_0,
-	DA830_EMA_D_1,
-	DA830_EQEP1B,
-	DA830_EPWM2B,
-	DA830_EPWM2A,
-	DA830_EPWM1B,
-	DA830_EPWM1A,
-	DA830_MMCSD_DAT_0,
-	DA830_MMCSD_DAT_1,
-	DA830_UHPI_HD_0,
-	DA830_UHPI_HD_1,
-	DA830_GPIO4_4,
-	DA830_GPIO4_5,
-	DA830_GPIO4_6,
-	DA830_GPIO4_7,
-	DA830_GPIO4_8,
-	DA830_GPIO4_9,
-	DA830_GPIO0_0,
-	DA830_GPIO0_1,
-	DA830_EMA_D_2,
-	DA830_EMA_D_3,
-	DA830_EMA_D_4,
-	DA830_EMA_D_5,
-	DA830_EMA_D_6,
-	DA830_EMA_D_7,
-	DA830_EMA_D_8,
-	DA830_EMA_D_9,
-	DA830_MMCSD_DAT_2,
-	DA830_MMCSD_DAT_3,
-	DA830_MMCSD_DAT_4,
-	DA830_MMCSD_DAT_5,
-	DA830_MMCSD_DAT_6,
-	DA830_MMCSD_DAT_7,
-	DA830_UHPI_HD_8,
-	DA830_UHPI_HD_9,
-	DA830_UHPI_HD_2,
-	DA830_UHPI_HD_3,
-	DA830_UHPI_HD_4,
-	DA830_UHPI_HD_5,
-	DA830_UHPI_HD_6,
-	DA830_UHPI_HD_7,
-	DA830_LCD_D_8,
-	DA830_LCD_D_9,
-	DA830_GPIO0_2,
-	DA830_GPIO0_3,
-	DA830_GPIO0_4,
-	DA830_GPIO0_5,
-	DA830_GPIO0_6,
-	DA830_GPIO0_7,
-	DA830_GPIO0_8,
-	DA830_GPIO0_9,
-	DA830_EMA_D_10,
-	DA830_EMA_D_11,
-	DA830_EMA_D_12,
-	DA830_EMA_D_13,
-	DA830_EMA_D_14,
-	DA830_EMA_D_15,
-	DA830_EMA_A_0,
-	DA830_EMA_A_1,
-	DA830_UHPI_HD_10,
-	DA830_UHPI_HD_11,
-	DA830_UHPI_HD_12,
-	DA830_UHPI_HD_13,
-	DA830_UHPI_HD_14,
-	DA830_UHPI_HD_15,
-	DA830_LCD_D_7,
-	DA830_MMCSD_CLK,
-	DA830_LCD_D_10,
-	DA830_LCD_D_11,
-	DA830_LCD_D_12,
-	DA830_LCD_D_13,
-	DA830_LCD_D_14,
-	DA830_LCD_D_15,
-	DA830_UHPI_HCNTL0,
-	DA830_GPIO0_10,
-	DA830_GPIO0_11,
-	DA830_GPIO0_12,
-	DA830_GPIO0_13,
-	DA830_GPIO0_14,
-	DA830_GPIO0_15,
-	DA830_GPIO1_0,
-	DA830_GPIO1_1,
-	DA830_EMA_A_2,
-	DA830_EMA_A_3,
-	DA830_EMA_A_4,
-	DA830_EMA_A_5,
-	DA830_EMA_A_6,
-	DA830_EMA_A_7,
-	DA830_EMA_A_8,
-	DA830_EMA_A_9,
-	DA830_MMCSD_CMD,
-	DA830_LCD_D_6,
-	DA830_LCD_D_3,
-	DA830_LCD_D_2,
-	DA830_LCD_D_1,
-	DA830_LCD_D_0,
-	DA830_LCD_PCLK,
-	DA830_LCD_HSYNC,
-	DA830_UHPI_HCNTL1,
-	DA830_GPIO1_2,
-	DA830_GPIO1_3,
-	DA830_GPIO1_4,
-	DA830_GPIO1_5,
-	DA830_GPIO1_6,
-	DA830_GPIO1_7,
-	DA830_GPIO1_8,
-	DA830_GPIO1_9,
-	DA830_EMA_A_10,
-	DA830_EMA_A_11,
-	DA830_EMA_A_12,
-	DA830_EMA_BA_1,
-	DA830_EMA_BA_0,
-	DA830_EMA_CLK,
-	DA830_EMA_SDCKE,
-	DA830_NEMA_CAS,
-	DA830_LCD_VSYNC,
-	DA830_NLCD_AC_ENB_CS,
-	DA830_LCD_MCLK,
-	DA830_LCD_D_5,
-	DA830_LCD_D_4,
-	DA830_OBSCLK,
-	DA830_NEMA_CS_4,
-	DA830_UHPI_HHWIL,
-	DA830_AHCLKR2,
-	DA830_GPIO1_10,
-	DA830_GPIO1_11,
-	DA830_GPIO1_12,
-	DA830_GPIO1_13,
-	DA830_GPIO1_14,
-	DA830_GPIO1_15,
-	DA830_GPIO2_0,
-	DA830_GPIO2_1,
-	DA830_NEMA_RAS,
-	DA830_NEMA_WE,
-	DA830_NEMA_CS_0,
-	DA830_NEMA_CS_2,
-	DA830_NEMA_CS_3,
-	DA830_NEMA_OE,
-	DA830_NEMA_WE_DQM_1,
-	DA830_NEMA_WE_DQM_0,
-	DA830_NEMA_CS_5,
-	DA830_UHPI_HRNW,
-	DA830_NUHPI_HAS,
-	DA830_NUHPI_HCS,
-	DA830_NUHPI_HDS1,
-	DA830_NUHPI_HDS2,
-	DA830_NUHPI_HINT,
-	DA830_AXR0_12,
-	DA830_AMUTE2,
-	DA830_AXR0_13,
-	DA830_AXR0_14,
-	DA830_AXR0_15,
-	DA830_GPIO2_2,
-	DA830_GPIO2_3,
-	DA830_GPIO2_4,
-	DA830_GPIO2_5,
-	DA830_GPIO2_6,
-	DA830_GPIO2_7,
-	DA830_GPIO2_8,
-	DA830_GPIO2_9,
-	DA830_EMA_WAIT_0,
-	DA830_NUHPI_HRDY,
-	DA830_GPIO2_10,
-};
-
-enum davinci_da850_index {
-	/* UART0 function */
-	DA850_NUART0_CTS,
-	DA850_NUART0_RTS,
-	DA850_UART0_RXD,
-	DA850_UART0_TXD,
-
-	/* UART1 function */
-	DA850_NUART1_CTS,
-	DA850_NUART1_RTS,
-	DA850_UART1_RXD,
-	DA850_UART1_TXD,
-
-	/* UART2 function */
-	DA850_NUART2_CTS,
-	DA850_NUART2_RTS,
-	DA850_UART2_RXD,
-	DA850_UART2_TXD,
-
-	/* I2C1 function */
-	DA850_I2C1_SCL,
-	DA850_I2C1_SDA,
-
-	/* I2C0 function */
-	DA850_I2C0_SDA,
-	DA850_I2C0_SCL,
-
-	/* EMAC function */
-	DA850_MII_TXEN,
-	DA850_MII_TXCLK,
-	DA850_MII_COL,
-	DA850_MII_TXD_3,
-	DA850_MII_TXD_2,
-	DA850_MII_TXD_1,
-	DA850_MII_TXD_0,
-	DA850_MII_RXER,
-	DA850_MII_CRS,
-	DA850_MII_RXCLK,
-	DA850_MII_RXDV,
-	DA850_MII_RXD_3,
-	DA850_MII_RXD_2,
-	DA850_MII_RXD_1,
-	DA850_MII_RXD_0,
-	DA850_MDIO_CLK,
-	DA850_MDIO_D,
-	DA850_RMII_TXD_0,
-	DA850_RMII_TXD_1,
-	DA850_RMII_TXEN,
-	DA850_RMII_CRS_DV,
-	DA850_RMII_RXD_0,
-	DA850_RMII_RXD_1,
-	DA850_RMII_RXER,
-	DA850_RMII_MHZ_50_CLK,
-
-	/* McASP function */
-	DA850_ACLKR,
-	DA850_ACLKX,
-	DA850_AFSR,
-	DA850_AFSX,
-	DA850_AHCLKR,
-	DA850_AHCLKX,
-	DA850_AMUTE,
-	DA850_AXR_15,
-	DA850_AXR_14,
-	DA850_AXR_13,
-	DA850_AXR_12,
-	DA850_AXR_11,
-	DA850_AXR_10,
-	DA850_AXR_9,
-	DA850_AXR_8,
-	DA850_AXR_7,
-	DA850_AXR_6,
-	DA850_AXR_5,
-	DA850_AXR_4,
-	DA850_AXR_3,
-	DA850_AXR_2,
-	DA850_AXR_1,
-	DA850_AXR_0,
-
-	/* LCD function */
-	DA850_LCD_D_7,
-	DA850_LCD_D_6,
-	DA850_LCD_D_5,
-	DA850_LCD_D_4,
-	DA850_LCD_D_3,
-	DA850_LCD_D_2,
-	DA850_LCD_D_1,
-	DA850_LCD_D_0,
-	DA850_LCD_D_15,
-	DA850_LCD_D_14,
-	DA850_LCD_D_13,
-	DA850_LCD_D_12,
-	DA850_LCD_D_11,
-	DA850_LCD_D_10,
-	DA850_LCD_D_9,
-	DA850_LCD_D_8,
-	DA850_LCD_PCLK,
-	DA850_LCD_HSYNC,
-	DA850_LCD_VSYNC,
-	DA850_NLCD_AC_ENB_CS,
-
-	/* MMC/SD0 function */
-	DA850_MMCSD0_DAT_0,
-	DA850_MMCSD0_DAT_1,
-	DA850_MMCSD0_DAT_2,
-	DA850_MMCSD0_DAT_3,
-	DA850_MMCSD0_CLK,
-	DA850_MMCSD0_CMD,
-
-	/* MMC/SD1 function */
-	DA850_MMCSD1_DAT_0,
-	DA850_MMCSD1_DAT_1,
-	DA850_MMCSD1_DAT_2,
-	DA850_MMCSD1_DAT_3,
-	DA850_MMCSD1_CLK,
-	DA850_MMCSD1_CMD,
-
-	/* EMIF2.5/EMIFA function */
-	DA850_EMA_D_7,
-	DA850_EMA_D_6,
-	DA850_EMA_D_5,
-	DA850_EMA_D_4,
-	DA850_EMA_D_3,
-	DA850_EMA_D_2,
-	DA850_EMA_D_1,
-	DA850_EMA_D_0,
-	DA850_EMA_A_1,
-	DA850_EMA_A_2,
-	DA850_NEMA_CS_3,
-	DA850_NEMA_CS_4,
-	DA850_NEMA_WE,
-	DA850_NEMA_OE,
-	DA850_EMA_D_15,
-	DA850_EMA_D_14,
-	DA850_EMA_D_13,
-	DA850_EMA_D_12,
-	DA850_EMA_D_11,
-	DA850_EMA_D_10,
-	DA850_EMA_D_9,
-	DA850_EMA_D_8,
-	DA850_EMA_A_0,
-	DA850_EMA_A_3,
-	DA850_EMA_A_4,
-	DA850_EMA_A_5,
-	DA850_EMA_A_6,
-	DA850_EMA_A_7,
-	DA850_EMA_A_8,
-	DA850_EMA_A_9,
-	DA850_EMA_A_10,
-	DA850_EMA_A_11,
-	DA850_EMA_A_12,
-	DA850_EMA_A_13,
-	DA850_EMA_A_14,
-	DA850_EMA_A_15,
-	DA850_EMA_A_16,
-	DA850_EMA_A_17,
-	DA850_EMA_A_18,
-	DA850_EMA_A_19,
-	DA850_EMA_A_20,
-	DA850_EMA_A_21,
-	DA850_EMA_A_22,
-	DA850_EMA_A_23,
-	DA850_EMA_BA_1,
-	DA850_EMA_CLK,
-	DA850_EMA_WAIT_1,
-	DA850_NEMA_CS_2,
-
-	/* GPIO function */
-	DA850_GPIO2_4,
-	DA850_GPIO2_6,
-	DA850_GPIO2_8,
-	DA850_GPIO2_15,
-	DA850_GPIO3_12,
-	DA850_GPIO3_13,
-	DA850_GPIO4_0,
-	DA850_GPIO4_1,
-	DA850_GPIO6_9,
-	DA850_GPIO6_10,
-	DA850_GPIO6_13,
-	DA850_RTC_ALARM,
-
-	/* VPIF Capture */
-	DA850_VPIF_DIN0,
-	DA850_VPIF_DIN1,
-	DA850_VPIF_DIN2,
-	DA850_VPIF_DIN3,
-	DA850_VPIF_DIN4,
-	DA850_VPIF_DIN5,
-	DA850_VPIF_DIN6,
-	DA850_VPIF_DIN7,
-	DA850_VPIF_DIN8,
-	DA850_VPIF_DIN9,
-	DA850_VPIF_DIN10,
-	DA850_VPIF_DIN11,
-	DA850_VPIF_DIN12,
-	DA850_VPIF_DIN13,
-	DA850_VPIF_DIN14,
-	DA850_VPIF_DIN15,
-	DA850_VPIF_CLKIN0,
-	DA850_VPIF_CLKIN1,
-	DA850_VPIF_CLKIN2,
-	DA850_VPIF_CLKIN3,
-
-	/* VPIF Display */
-	DA850_VPIF_DOUT0,
-	DA850_VPIF_DOUT1,
-	DA850_VPIF_DOUT2,
-	DA850_VPIF_DOUT3,
-	DA850_VPIF_DOUT4,
-	DA850_VPIF_DOUT5,
-	DA850_VPIF_DOUT6,
-	DA850_VPIF_DOUT7,
-	DA850_VPIF_DOUT8,
-	DA850_VPIF_DOUT9,
-	DA850_VPIF_DOUT10,
-	DA850_VPIF_DOUT11,
-	DA850_VPIF_DOUT12,
-	DA850_VPIF_DOUT13,
-	DA850_VPIF_DOUT14,
-	DA850_VPIF_DOUT15,
-	DA850_VPIF_CLKO2,
-	DA850_VPIF_CLKO3,
-};
-
-#define PINMUX(x)		(4 * (x))
-
-#ifdef CONFIG_DAVINCI_MUX
-/* setup pin muxing */
-extern int davinci_cfg_reg(unsigned long reg_cfg);
-extern int davinci_cfg_reg_list(const short pins[]);
-#else
-/* boot loader does it all (no warnings from CONFIG_DAVINCI_MUX_WARNINGS) */
-static inline int davinci_cfg_reg(unsigned long reg_cfg) { return 0; }
-static inline int davinci_cfg_reg_list(const short pins[])
-{
-	return 0;
-}
-#endif
-
-#endif /* __INC_MACH_MUX_H */
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
deleted file mode 100644
index 53b456a5bbe0..000000000000
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * Serial port stubs for kernel decompress status messages
- *
- * Initially based on:
- * arch/arm/plat-omap/include/mach/uncompress.h
- *
- * Original copyrights follow.
- *
- * Copyright (C) 2000 RidgeRun, Inc.
- * Author: Greg Lonnon <glonnon@ridgerun.com>
- *
- * Rewritten by:
- * Author: <source@mvista.com>
- * 2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/types.h>
-#include <linux/serial_reg.h>
-
-#include <asm/mach-types.h>
-
-#include <mach/serial.h>
-
-#define IOMEM(x)	((void __force __iomem *)(x))
-
-u32 *uart;
-
-/* PORT_16C550A, in polled non-fifo mode */
-static inline void putc(char c)
-{
-	if (!uart)
-		return;
-
-	while (!(uart[UART_LSR] & UART_LSR_THRE))
-		barrier();
-	uart[UART_TX] = c;
-}
-
-static inline void flush(void)
-{
-	if (!uart)
-		return;
-
-	while (!(uart[UART_LSR] & UART_LSR_THRE))
-		barrier();
-}
-
-static inline void set_uart_info(u32 phys)
-{
-	uart = (u32 *)phys;
-}
-
-#define _DEBUG_LL_ENTRY(machine, phys)				\
-	{							\
-		if (machine_is_##machine()) {			\
-			set_uart_info(phys);			\
-			break;					\
-		}						\
-	}
-
-#define DEBUG_LL_DAVINCI(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DAVINCI_UART##port##_BASE)
-
-#define DEBUG_LL_DA8XX(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DA8XX_UART##port##_BASE)
-
-static inline void __arch_decomp_setup(unsigned long arch_id)
-{
-	/*
-	 * Initialize the port based on the machine ID from the bootloader.
-	 * Note that we're using macros here instead of switch statement
-	 * as machine_is functions are optimized out for the boards that
-	 * are not selected.
-	 */
-	do {
-		/* Davinci boards */
-		DEBUG_LL_DAVINCI(davinci_evm,		0);
-		DEBUG_LL_DAVINCI(sffsdr,		0);
-		DEBUG_LL_DAVINCI(neuros_osd2,		0);
-		DEBUG_LL_DAVINCI(davinci_dm355_evm,	0);
-		DEBUG_LL_DAVINCI(dm355_leopard,		0);
-		DEBUG_LL_DAVINCI(davinci_dm6467_evm,	0);
-		DEBUG_LL_DAVINCI(davinci_dm365_evm,	0);
-
-		/* DA8xx boards */
-		DEBUG_LL_DA8XX(davinci_da830_evm,	2);
-		DEBUG_LL_DA8XX(davinci_da850_evm,	2);
-		DEBUG_LL_DA8XX(mityomapl138,		1);
-		DEBUG_LL_DA8XX(omapl138_hawkboard,	2);
-	} while (0);
-}
-
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index 6a2ff0a654a5..bab1eea7fca6 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -22,8 +22,8 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
 
-#include <mach/mux.h>
-#include <mach/common.h>
+#include "mux.h"
+#include "common.h"
 
 static void __iomem *pinmux_base;
 
diff --git a/arch/arm/mach-davinci/mux.h b/arch/arm/mach-davinci/mux.h
index 5aad1e7dd210..b0d1c4fb78dc 100644
--- a/arch/arm/mach-davinci/mux.h
+++ b/arch/arm/mach-davinci/mux.h
@@ -13,7 +13,974 @@
 #ifndef _MACH_DAVINCI_MUX_H_
 #define _MACH_DAVINCI_MUX_H_
 
-#include <mach/mux.h>
+struct mux_config {
+	const char *name;
+	const char *mux_reg_name;
+	const unsigned char mux_reg;
+	const unsigned char mask_offset;
+	const unsigned char mask;
+	const unsigned char mode;
+	bool debug;
+};
+
+enum davinci_dm644x_index {
+	/* ATA and HDDIR functions */
+	DM644X_HDIREN,
+	DM644X_ATAEN,
+	DM644X_ATAEN_DISABLE,
+
+	/* HPI functions */
+	DM644X_HPIEN_DISABLE,
+
+	/* AEAW functions */
+	DM644X_AEAW,
+	DM644X_AEAW0,
+	DM644X_AEAW1,
+	DM644X_AEAW2,
+	DM644X_AEAW3,
+	DM644X_AEAW4,
+
+	/* Memory Stick */
+	DM644X_MSTK,
+
+	/* I2C */
+	DM644X_I2C,
+
+	/* ASP function */
+	DM644X_MCBSP,
+
+	/* UART1 */
+	DM644X_UART1,
+
+	/* UART2 */
+	DM644X_UART2,
+
+	/* PWM0 */
+	DM644X_PWM0,
+
+	/* PWM1 */
+	DM644X_PWM1,
+
+	/* PWM2 */
+	DM644X_PWM2,
+
+	/* VLYNQ function */
+	DM644X_VLYNQEN,
+	DM644X_VLSCREN,
+	DM644X_VLYNQWD,
+
+	/* EMAC and MDIO function */
+	DM644X_EMACEN,
+
+	/* GPIO3V[0:16] pins */
+	DM644X_GPIO3V,
+
+	/* GPIO pins */
+	DM644X_GPIO0,
+	DM644X_GPIO3,
+	DM644X_GPIO43_44,
+	DM644X_GPIO46_47,
+
+	/* VPBE */
+	DM644X_RGB666,
+
+	/* LCD */
+	DM644X_LOEEN,
+	DM644X_LFLDEN,
+};
+
+enum davinci_dm646x_index {
+	/* ATA function */
+	DM646X_ATAEN,
+
+	/* AUDIO Clock */
+	DM646X_AUDCK1,
+	DM646X_AUDCK0,
+
+	/* CRGEN Control */
+	DM646X_CRGMUX,
+
+	/* VPIF Control */
+	DM646X_STSOMUX_DISABLE,
+	DM646X_STSIMUX_DISABLE,
+	DM646X_PTSOMUX_DISABLE,
+	DM646X_PTSIMUX_DISABLE,
+
+	/* TSIF Control */
+	DM646X_STSOMUX,
+	DM646X_STSIMUX,
+	DM646X_PTSOMUX_PARALLEL,
+	DM646X_PTSIMUX_PARALLEL,
+	DM646X_PTSOMUX_SERIAL,
+	DM646X_PTSIMUX_SERIAL,
+};
+
+enum davinci_dm355_index {
+	/* MMC/SD 0 */
+	DM355_MMCSD0,
+
+	/* MMC/SD 1 */
+	DM355_SD1_CLK,
+	DM355_SD1_CMD,
+	DM355_SD1_DATA3,
+	DM355_SD1_DATA2,
+	DM355_SD1_DATA1,
+	DM355_SD1_DATA0,
+
+	/* I2C */
+	DM355_I2C_SDA,
+	DM355_I2C_SCL,
+
+	/* ASP0 function */
+	DM355_MCBSP0_BDX,
+	DM355_MCBSP0_X,
+	DM355_MCBSP0_BFSX,
+	DM355_MCBSP0_BDR,
+	DM355_MCBSP0_R,
+	DM355_MCBSP0_BFSR,
+
+	/* SPI0 */
+	DM355_SPI0_SDI,
+	DM355_SPI0_SDENA0,
+	DM355_SPI0_SDENA1,
+
+	/* IRQ muxing */
+	DM355_INT_EDMA_CC,
+	DM355_INT_EDMA_TC0_ERR,
+	DM355_INT_EDMA_TC1_ERR,
+
+	/* EDMA event muxing */
+	DM355_EVT8_ASP1_TX,
+	DM355_EVT9_ASP1_RX,
+	DM355_EVT26_MMC0_RX,
+
+	/* Video Out */
+	DM355_VOUT_FIELD,
+	DM355_VOUT_FIELD_G70,
+	DM355_VOUT_HVSYNC,
+	DM355_VOUT_COUTL_EN,
+	DM355_VOUT_COUTH_EN,
+
+	/* Video In Pin Mux */
+	DM355_VIN_PCLK,
+	DM355_VIN_CAM_WEN,
+	DM355_VIN_CAM_VD,
+	DM355_VIN_CAM_HD,
+	DM355_VIN_YIN_EN,
+	DM355_VIN_CINL_EN,
+	DM355_VIN_CINH_EN,
+};
+
+enum davinci_dm365_index {
+	/* MMC/SD 0 */
+	DM365_MMCSD0,
+
+	/* MMC/SD 1 */
+	DM365_SD1_CLK,
+	DM365_SD1_CMD,
+	DM365_SD1_DATA3,
+	DM365_SD1_DATA2,
+	DM365_SD1_DATA1,
+	DM365_SD1_DATA0,
+
+	/* I2C */
+	DM365_I2C_SDA,
+	DM365_I2C_SCL,
+
+	/* AEMIF */
+	DM365_AEMIF_AR_A14,
+	DM365_AEMIF_AR_BA0,
+	DM365_AEMIF_A3,
+	DM365_AEMIF_A7,
+	DM365_AEMIF_D15_8,
+	DM365_AEMIF_CE0,
+	DM365_AEMIF_CE1,
+	DM365_AEMIF_WE_OE,
+
+	/* ASP0 function */
+	DM365_MCBSP0_BDX,
+	DM365_MCBSP0_X,
+	DM365_MCBSP0_BFSX,
+	DM365_MCBSP0_BDR,
+	DM365_MCBSP0_R,
+	DM365_MCBSP0_BFSR,
+
+	/* SPI0 */
+	DM365_SPI0_SCLK,
+	DM365_SPI0_SDI,
+	DM365_SPI0_SDO,
+	DM365_SPI0_SDENA0,
+	DM365_SPI0_SDENA1,
+
+	/* UART */
+	DM365_UART0_RXD,
+	DM365_UART0_TXD,
+	DM365_UART1_RXD,
+	DM365_UART1_TXD,
+	DM365_UART1_RTS,
+	DM365_UART1_CTS,
+
+	/* EMAC */
+	DM365_EMAC_TX_EN,
+	DM365_EMAC_TX_CLK,
+	DM365_EMAC_COL,
+	DM365_EMAC_TXD3,
+	DM365_EMAC_TXD2,
+	DM365_EMAC_TXD1,
+	DM365_EMAC_TXD0,
+	DM365_EMAC_RXD3,
+	DM365_EMAC_RXD2,
+	DM365_EMAC_RXD1,
+	DM365_EMAC_RXD0,
+	DM365_EMAC_RX_CLK,
+	DM365_EMAC_RX_DV,
+	DM365_EMAC_RX_ER,
+	DM365_EMAC_CRS,
+	DM365_EMAC_MDIO,
+	DM365_EMAC_MDCLK,
+
+	/* Key Scan */
+	DM365_KEYSCAN,
+
+	/* PWM */
+	DM365_PWM0,
+	DM365_PWM0_G23,
+	DM365_PWM1,
+	DM365_PWM1_G25,
+	DM365_PWM2_G87,
+	DM365_PWM2_G88,
+	DM365_PWM2_G89,
+	DM365_PWM2_G90,
+	DM365_PWM3_G80,
+	DM365_PWM3_G81,
+	DM365_PWM3_G85,
+	DM365_PWM3_G86,
+
+	/* SPI1 */
+	DM365_SPI1_SCLK,
+	DM365_SPI1_SDO,
+	DM365_SPI1_SDI,
+	DM365_SPI1_SDENA0,
+	DM365_SPI1_SDENA1,
+
+	/* SPI2 */
+	DM365_SPI2_SCLK,
+	DM365_SPI2_SDO,
+	DM365_SPI2_SDI,
+	DM365_SPI2_SDENA0,
+	DM365_SPI2_SDENA1,
+
+	/* SPI3 */
+	DM365_SPI3_SCLK,
+	DM365_SPI3_SDO,
+	DM365_SPI3_SDI,
+	DM365_SPI3_SDENA0,
+	DM365_SPI3_SDENA1,
+
+	/* SPI4 */
+	DM365_SPI4_SCLK,
+	DM365_SPI4_SDO,
+	DM365_SPI4_SDI,
+	DM365_SPI4_SDENA0,
+	DM365_SPI4_SDENA1,
+
+	/* Clock */
+	DM365_CLKOUT0,
+	DM365_CLKOUT1,
+	DM365_CLKOUT2,
+
+	/* GPIO */
+	DM365_GPIO20,
+	DM365_GPIO30,
+	DM365_GPIO31,
+	DM365_GPIO32,
+	DM365_GPIO33,
+	DM365_GPIO40,
+	DM365_GPIO64_57,
+
+	/* Video */
+	DM365_VOUT_FIELD,
+	DM365_VOUT_FIELD_G81,
+	DM365_VOUT_HVSYNC,
+	DM365_VOUT_COUTL_EN,
+	DM365_VOUT_COUTH_EN,
+	DM365_VIN_CAM_WEN,
+	DM365_VIN_CAM_VD,
+	DM365_VIN_CAM_HD,
+	DM365_VIN_YIN4_7_EN,
+	DM365_VIN_YIN0_3_EN,
+
+	/* IRQ muxing */
+	DM365_INT_EDMA_CC,
+	DM365_INT_EDMA_TC0_ERR,
+	DM365_INT_EDMA_TC1_ERR,
+	DM365_INT_EDMA_TC2_ERR,
+	DM365_INT_EDMA_TC3_ERR,
+	DM365_INT_PRTCSS,
+	DM365_INT_EMAC_RXTHRESH,
+	DM365_INT_EMAC_RXPULSE,
+	DM365_INT_EMAC_TXPULSE,
+	DM365_INT_EMAC_MISCPULSE,
+	DM365_INT_IMX0_ENABLE,
+	DM365_INT_IMX0_DISABLE,
+	DM365_INT_HDVICP_ENABLE,
+	DM365_INT_HDVICP_DISABLE,
+	DM365_INT_IMX1_ENABLE,
+	DM365_INT_IMX1_DISABLE,
+	DM365_INT_NSF_ENABLE,
+	DM365_INT_NSF_DISABLE,
+
+	/* EDMA event muxing */
+	DM365_EVT2_ASP_TX,
+	DM365_EVT3_ASP_RX,
+	DM365_EVT2_VC_TX,
+	DM365_EVT3_VC_RX,
+	DM365_EVT26_MMC0_RX,
+};
+
+enum da830_index {
+	DA830_GPIO7_14,
+	DA830_RTCK,
+	DA830_GPIO7_15,
+	DA830_EMU_0,
+	DA830_EMB_SDCKE,
+	DA830_EMB_CLK_GLUE,
+	DA830_EMB_CLK,
+	DA830_NEMB_CS_0,
+	DA830_NEMB_CAS,
+	DA830_NEMB_RAS,
+	DA830_NEMB_WE,
+	DA830_EMB_BA_1,
+	DA830_EMB_BA_0,
+	DA830_EMB_A_0,
+	DA830_EMB_A_1,
+	DA830_EMB_A_2,
+	DA830_EMB_A_3,
+	DA830_EMB_A_4,
+	DA830_EMB_A_5,
+	DA830_GPIO7_0,
+	DA830_GPIO7_1,
+	DA830_GPIO7_2,
+	DA830_GPIO7_3,
+	DA830_GPIO7_4,
+	DA830_GPIO7_5,
+	DA830_GPIO7_6,
+	DA830_GPIO7_7,
+	DA830_EMB_A_6,
+	DA830_EMB_A_7,
+	DA830_EMB_A_8,
+	DA830_EMB_A_9,
+	DA830_EMB_A_10,
+	DA830_EMB_A_11,
+	DA830_EMB_A_12,
+	DA830_EMB_D_31,
+	DA830_GPIO7_8,
+	DA830_GPIO7_9,
+	DA830_GPIO7_10,
+	DA830_GPIO7_11,
+	DA830_GPIO7_12,
+	DA830_GPIO7_13,
+	DA830_GPIO3_13,
+	DA830_EMB_D_30,
+	DA830_EMB_D_29,
+	DA830_EMB_D_28,
+	DA830_EMB_D_27,
+	DA830_EMB_D_26,
+	DA830_EMB_D_25,
+	DA830_EMB_D_24,
+	DA830_EMB_D_23,
+	DA830_EMB_D_22,
+	DA830_EMB_D_21,
+	DA830_EMB_D_20,
+	DA830_EMB_D_19,
+	DA830_EMB_D_18,
+	DA830_EMB_D_17,
+	DA830_EMB_D_16,
+	DA830_NEMB_WE_DQM_3,
+	DA830_NEMB_WE_DQM_2,
+	DA830_EMB_D_0,
+	DA830_EMB_D_1,
+	DA830_EMB_D_2,
+	DA830_EMB_D_3,
+	DA830_EMB_D_4,
+	DA830_EMB_D_5,
+	DA830_EMB_D_6,
+	DA830_GPIO6_0,
+	DA830_GPIO6_1,
+	DA830_GPIO6_2,
+	DA830_GPIO6_3,
+	DA830_GPIO6_4,
+	DA830_GPIO6_5,
+	DA830_GPIO6_6,
+	DA830_EMB_D_7,
+	DA830_EMB_D_8,
+	DA830_EMB_D_9,
+	DA830_EMB_D_10,
+	DA830_EMB_D_11,
+	DA830_EMB_D_12,
+	DA830_EMB_D_13,
+	DA830_EMB_D_14,
+	DA830_GPIO6_7,
+	DA830_GPIO6_8,
+	DA830_GPIO6_9,
+	DA830_GPIO6_10,
+	DA830_GPIO6_11,
+	DA830_GPIO6_12,
+	DA830_GPIO6_13,
+	DA830_GPIO6_14,
+	DA830_EMB_D_15,
+	DA830_NEMB_WE_DQM_1,
+	DA830_NEMB_WE_DQM_0,
+	DA830_SPI0_SOMI_0,
+	DA830_SPI0_SIMO_0,
+	DA830_SPI0_CLK,
+	DA830_NSPI0_ENA,
+	DA830_NSPI0_SCS_0,
+	DA830_EQEP0I,
+	DA830_EQEP0S,
+	DA830_EQEP1I,
+	DA830_NUART0_CTS,
+	DA830_NUART0_RTS,
+	DA830_EQEP0A,
+	DA830_EQEP0B,
+	DA830_GPIO6_15,
+	DA830_GPIO5_14,
+	DA830_GPIO5_15,
+	DA830_GPIO5_0,
+	DA830_GPIO5_1,
+	DA830_GPIO5_2,
+	DA830_GPIO5_3,
+	DA830_GPIO5_4,
+	DA830_SPI1_SOMI_0,
+	DA830_SPI1_SIMO_0,
+	DA830_SPI1_CLK,
+	DA830_UART0_RXD,
+	DA830_UART0_TXD,
+	DA830_AXR1_10,
+	DA830_AXR1_11,
+	DA830_NSPI1_ENA,
+	DA830_I2C1_SCL,
+	DA830_I2C1_SDA,
+	DA830_EQEP1S,
+	DA830_I2C0_SDA,
+	DA830_I2C0_SCL,
+	DA830_UART2_RXD,
+	DA830_TM64P0_IN12,
+	DA830_TM64P0_OUT12,
+	DA830_GPIO5_5,
+	DA830_GPIO5_6,
+	DA830_GPIO5_7,
+	DA830_GPIO5_8,
+	DA830_GPIO5_9,
+	DA830_GPIO5_10,
+	DA830_GPIO5_11,
+	DA830_GPIO5_12,
+	DA830_NSPI1_SCS_0,
+	DA830_USB0_DRVVBUS,
+	DA830_AHCLKX0,
+	DA830_ACLKX0,
+	DA830_AFSX0,
+	DA830_AHCLKR0,
+	DA830_ACLKR0,
+	DA830_AFSR0,
+	DA830_UART2_TXD,
+	DA830_AHCLKX2,
+	DA830_ECAP0_APWM0,
+	DA830_RMII_MHZ_50_CLK,
+	DA830_ECAP1_APWM1,
+	DA830_USB_REFCLKIN,
+	DA830_GPIO5_13,
+	DA830_GPIO4_15,
+	DA830_GPIO2_11,
+	DA830_GPIO2_12,
+	DA830_GPIO2_13,
+	DA830_GPIO2_14,
+	DA830_GPIO2_15,
+	DA830_GPIO3_12,
+	DA830_AMUTE0,
+	DA830_AXR0_0,
+	DA830_AXR0_1,
+	DA830_AXR0_2,
+	DA830_AXR0_3,
+	DA830_AXR0_4,
+	DA830_AXR0_5,
+	DA830_AXR0_6,
+	DA830_RMII_TXD_0,
+	DA830_RMII_TXD_1,
+	DA830_RMII_TXEN,
+	DA830_RMII_CRS_DV,
+	DA830_RMII_RXD_0,
+	DA830_RMII_RXD_1,
+	DA830_RMII_RXER,
+	DA830_AFSR2,
+	DA830_ACLKX2,
+	DA830_AXR2_3,
+	DA830_AXR2_2,
+	DA830_AXR2_1,
+	DA830_AFSX2,
+	DA830_ACLKR2,
+	DA830_NRESETOUT,
+	DA830_GPIO3_0,
+	DA830_GPIO3_1,
+	DA830_GPIO3_2,
+	DA830_GPIO3_3,
+	DA830_GPIO3_4,
+	DA830_GPIO3_5,
+	DA830_GPIO3_6,
+	DA830_AXR0_7,
+	DA830_AXR0_8,
+	DA830_UART1_RXD,
+	DA830_UART1_TXD,
+	DA830_AXR0_11,
+	DA830_AHCLKX1,
+	DA830_ACLKX1,
+	DA830_AFSX1,
+	DA830_MDIO_CLK,
+	DA830_MDIO_D,
+	DA830_AXR0_9,
+	DA830_AXR0_10,
+	DA830_EPWM0B,
+	DA830_EPWM0A,
+	DA830_EPWMSYNCI,
+	DA830_AXR2_0,
+	DA830_EPWMSYNC0,
+	DA830_GPIO3_7,
+	DA830_GPIO3_8,
+	DA830_GPIO3_9,
+	DA830_GPIO3_10,
+	DA830_GPIO3_11,
+	DA830_GPIO3_14,
+	DA830_GPIO3_15,
+	DA830_GPIO4_10,
+	DA830_AHCLKR1,
+	DA830_ACLKR1,
+	DA830_AFSR1,
+	DA830_AMUTE1,
+	DA830_AXR1_0,
+	DA830_AXR1_1,
+	DA830_AXR1_2,
+	DA830_AXR1_3,
+	DA830_ECAP2_APWM2,
+	DA830_EHRPWMGLUETZ,
+	DA830_EQEP1A,
+	DA830_GPIO4_11,
+	DA830_GPIO4_12,
+	DA830_GPIO4_13,
+	DA830_GPIO4_14,
+	DA830_GPIO4_0,
+	DA830_GPIO4_1,
+	DA830_GPIO4_2,
+	DA830_GPIO4_3,
+	DA830_AXR1_4,
+	DA830_AXR1_5,
+	DA830_AXR1_6,
+	DA830_AXR1_7,
+	DA830_AXR1_8,
+	DA830_AXR1_9,
+	DA830_EMA_D_0,
+	DA830_EMA_D_1,
+	DA830_EQEP1B,
+	DA830_EPWM2B,
+	DA830_EPWM2A,
+	DA830_EPWM1B,
+	DA830_EPWM1A,
+	DA830_MMCSD_DAT_0,
+	DA830_MMCSD_DAT_1,
+	DA830_UHPI_HD_0,
+	DA830_UHPI_HD_1,
+	DA830_GPIO4_4,
+	DA830_GPIO4_5,
+	DA830_GPIO4_6,
+	DA830_GPIO4_7,
+	DA830_GPIO4_8,
+	DA830_GPIO4_9,
+	DA830_GPIO0_0,
+	DA830_GPIO0_1,
+	DA830_EMA_D_2,
+	DA830_EMA_D_3,
+	DA830_EMA_D_4,
+	DA830_EMA_D_5,
+	DA830_EMA_D_6,
+	DA830_EMA_D_7,
+	DA830_EMA_D_8,
+	DA830_EMA_D_9,
+	DA830_MMCSD_DAT_2,
+	DA830_MMCSD_DAT_3,
+	DA830_MMCSD_DAT_4,
+	DA830_MMCSD_DAT_5,
+	DA830_MMCSD_DAT_6,
+	DA830_MMCSD_DAT_7,
+	DA830_UHPI_HD_8,
+	DA830_UHPI_HD_9,
+	DA830_UHPI_HD_2,
+	DA830_UHPI_HD_3,
+	DA830_UHPI_HD_4,
+	DA830_UHPI_HD_5,
+	DA830_UHPI_HD_6,
+	DA830_UHPI_HD_7,
+	DA830_LCD_D_8,
+	DA830_LCD_D_9,
+	DA830_GPIO0_2,
+	DA830_GPIO0_3,
+	DA830_GPIO0_4,
+	DA830_GPIO0_5,
+	DA830_GPIO0_6,
+	DA830_GPIO0_7,
+	DA830_GPIO0_8,
+	DA830_GPIO0_9,
+	DA830_EMA_D_10,
+	DA830_EMA_D_11,
+	DA830_EMA_D_12,
+	DA830_EMA_D_13,
+	DA830_EMA_D_14,
+	DA830_EMA_D_15,
+	DA830_EMA_A_0,
+	DA830_EMA_A_1,
+	DA830_UHPI_HD_10,
+	DA830_UHPI_HD_11,
+	DA830_UHPI_HD_12,
+	DA830_UHPI_HD_13,
+	DA830_UHPI_HD_14,
+	DA830_UHPI_HD_15,
+	DA830_LCD_D_7,
+	DA830_MMCSD_CLK,
+	DA830_LCD_D_10,
+	DA830_LCD_D_11,
+	DA830_LCD_D_12,
+	DA830_LCD_D_13,
+	DA830_LCD_D_14,
+	DA830_LCD_D_15,
+	DA830_UHPI_HCNTL0,
+	DA830_GPIO0_10,
+	DA830_GPIO0_11,
+	DA830_GPIO0_12,
+	DA830_GPIO0_13,
+	DA830_GPIO0_14,
+	DA830_GPIO0_15,
+	DA830_GPIO1_0,
+	DA830_GPIO1_1,
+	DA830_EMA_A_2,
+	DA830_EMA_A_3,
+	DA830_EMA_A_4,
+	DA830_EMA_A_5,
+	DA830_EMA_A_6,
+	DA830_EMA_A_7,
+	DA830_EMA_A_8,
+	DA830_EMA_A_9,
+	DA830_MMCSD_CMD,
+	DA830_LCD_D_6,
+	DA830_LCD_D_3,
+	DA830_LCD_D_2,
+	DA830_LCD_D_1,
+	DA830_LCD_D_0,
+	DA830_LCD_PCLK,
+	DA830_LCD_HSYNC,
+	DA830_UHPI_HCNTL1,
+	DA830_GPIO1_2,
+	DA830_GPIO1_3,
+	DA830_GPIO1_4,
+	DA830_GPIO1_5,
+	DA830_GPIO1_6,
+	DA830_GPIO1_7,
+	DA830_GPIO1_8,
+	DA830_GPIO1_9,
+	DA830_EMA_A_10,
+	DA830_EMA_A_11,
+	DA830_EMA_A_12,
+	DA830_EMA_BA_1,
+	DA830_EMA_BA_0,
+	DA830_EMA_CLK,
+	DA830_EMA_SDCKE,
+	DA830_NEMA_CAS,
+	DA830_LCD_VSYNC,
+	DA830_NLCD_AC_ENB_CS,
+	DA830_LCD_MCLK,
+	DA830_LCD_D_5,
+	DA830_LCD_D_4,
+	DA830_OBSCLK,
+	DA830_NEMA_CS_4,
+	DA830_UHPI_HHWIL,
+	DA830_AHCLKR2,
+	DA830_GPIO1_10,
+	DA830_GPIO1_11,
+	DA830_GPIO1_12,
+	DA830_GPIO1_13,
+	DA830_GPIO1_14,
+	DA830_GPIO1_15,
+	DA830_GPIO2_0,
+	DA830_GPIO2_1,
+	DA830_NEMA_RAS,
+	DA830_NEMA_WE,
+	DA830_NEMA_CS_0,
+	DA830_NEMA_CS_2,
+	DA830_NEMA_CS_3,
+	DA830_NEMA_OE,
+	DA830_NEMA_WE_DQM_1,
+	DA830_NEMA_WE_DQM_0,
+	DA830_NEMA_CS_5,
+	DA830_UHPI_HRNW,
+	DA830_NUHPI_HAS,
+	DA830_NUHPI_HCS,
+	DA830_NUHPI_HDS1,
+	DA830_NUHPI_HDS2,
+	DA830_NUHPI_HINT,
+	DA830_AXR0_12,
+	DA830_AMUTE2,
+	DA830_AXR0_13,
+	DA830_AXR0_14,
+	DA830_AXR0_15,
+	DA830_GPIO2_2,
+	DA830_GPIO2_3,
+	DA830_GPIO2_4,
+	DA830_GPIO2_5,
+	DA830_GPIO2_6,
+	DA830_GPIO2_7,
+	DA830_GPIO2_8,
+	DA830_GPIO2_9,
+	DA830_EMA_WAIT_0,
+	DA830_NUHPI_HRDY,
+	DA830_GPIO2_10,
+};
+
+enum davinci_da850_index {
+	/* UART0 function */
+	DA850_NUART0_CTS,
+	DA850_NUART0_RTS,
+	DA850_UART0_RXD,
+	DA850_UART0_TXD,
+
+	/* UART1 function */
+	DA850_NUART1_CTS,
+	DA850_NUART1_RTS,
+	DA850_UART1_RXD,
+	DA850_UART1_TXD,
+
+	/* UART2 function */
+	DA850_NUART2_CTS,
+	DA850_NUART2_RTS,
+	DA850_UART2_RXD,
+	DA850_UART2_TXD,
+
+	/* I2C1 function */
+	DA850_I2C1_SCL,
+	DA850_I2C1_SDA,
+
+	/* I2C0 function */
+	DA850_I2C0_SDA,
+	DA850_I2C0_SCL,
+
+	/* EMAC function */
+	DA850_MII_TXEN,
+	DA850_MII_TXCLK,
+	DA850_MII_COL,
+	DA850_MII_TXD_3,
+	DA850_MII_TXD_2,
+	DA850_MII_TXD_1,
+	DA850_MII_TXD_0,
+	DA850_MII_RXER,
+	DA850_MII_CRS,
+	DA850_MII_RXCLK,
+	DA850_MII_RXDV,
+	DA850_MII_RXD_3,
+	DA850_MII_RXD_2,
+	DA850_MII_RXD_1,
+	DA850_MII_RXD_0,
+	DA850_MDIO_CLK,
+	DA850_MDIO_D,
+	DA850_RMII_TXD_0,
+	DA850_RMII_TXD_1,
+	DA850_RMII_TXEN,
+	DA850_RMII_CRS_DV,
+	DA850_RMII_RXD_0,
+	DA850_RMII_RXD_1,
+	DA850_RMII_RXER,
+	DA850_RMII_MHZ_50_CLK,
+
+	/* McASP function */
+	DA850_ACLKR,
+	DA850_ACLKX,
+	DA850_AFSR,
+	DA850_AFSX,
+	DA850_AHCLKR,
+	DA850_AHCLKX,
+	DA850_AMUTE,
+	DA850_AXR_15,
+	DA850_AXR_14,
+	DA850_AXR_13,
+	DA850_AXR_12,
+	DA850_AXR_11,
+	DA850_AXR_10,
+	DA850_AXR_9,
+	DA850_AXR_8,
+	DA850_AXR_7,
+	DA850_AXR_6,
+	DA850_AXR_5,
+	DA850_AXR_4,
+	DA850_AXR_3,
+	DA850_AXR_2,
+	DA850_AXR_1,
+	DA850_AXR_0,
+
+	/* LCD function */
+	DA850_LCD_D_7,
+	DA850_LCD_D_6,
+	DA850_LCD_D_5,
+	DA850_LCD_D_4,
+	DA850_LCD_D_3,
+	DA850_LCD_D_2,
+	DA850_LCD_D_1,
+	DA850_LCD_D_0,
+	DA850_LCD_D_15,
+	DA850_LCD_D_14,
+	DA850_LCD_D_13,
+	DA850_LCD_D_12,
+	DA850_LCD_D_11,
+	DA850_LCD_D_10,
+	DA850_LCD_D_9,
+	DA850_LCD_D_8,
+	DA850_LCD_PCLK,
+	DA850_LCD_HSYNC,
+	DA850_LCD_VSYNC,
+	DA850_NLCD_AC_ENB_CS,
+
+	/* MMC/SD0 function */
+	DA850_MMCSD0_DAT_0,
+	DA850_MMCSD0_DAT_1,
+	DA850_MMCSD0_DAT_2,
+	DA850_MMCSD0_DAT_3,
+	DA850_MMCSD0_CLK,
+	DA850_MMCSD0_CMD,
+
+	/* MMC/SD1 function */
+	DA850_MMCSD1_DAT_0,
+	DA850_MMCSD1_DAT_1,
+	DA850_MMCSD1_DAT_2,
+	DA850_MMCSD1_DAT_3,
+	DA850_MMCSD1_CLK,
+	DA850_MMCSD1_CMD,
+
+	/* EMIF2.5/EMIFA function */
+	DA850_EMA_D_7,
+	DA850_EMA_D_6,
+	DA850_EMA_D_5,
+	DA850_EMA_D_4,
+	DA850_EMA_D_3,
+	DA850_EMA_D_2,
+	DA850_EMA_D_1,
+	DA850_EMA_D_0,
+	DA850_EMA_A_1,
+	DA850_EMA_A_2,
+	DA850_NEMA_CS_3,
+	DA850_NEMA_CS_4,
+	DA850_NEMA_WE,
+	DA850_NEMA_OE,
+	DA850_EMA_D_15,
+	DA850_EMA_D_14,
+	DA850_EMA_D_13,
+	DA850_EMA_D_12,
+	DA850_EMA_D_11,
+	DA850_EMA_D_10,
+	DA850_EMA_D_9,
+	DA850_EMA_D_8,
+	DA850_EMA_A_0,
+	DA850_EMA_A_3,
+	DA850_EMA_A_4,
+	DA850_EMA_A_5,
+	DA850_EMA_A_6,
+	DA850_EMA_A_7,
+	DA850_EMA_A_8,
+	DA850_EMA_A_9,
+	DA850_EMA_A_10,
+	DA850_EMA_A_11,
+	DA850_EMA_A_12,
+	DA850_EMA_A_13,
+	DA850_EMA_A_14,
+	DA850_EMA_A_15,
+	DA850_EMA_A_16,
+	DA850_EMA_A_17,
+	DA850_EMA_A_18,
+	DA850_EMA_A_19,
+	DA850_EMA_A_20,
+	DA850_EMA_A_21,
+	DA850_EMA_A_22,
+	DA850_EMA_A_23,
+	DA850_EMA_BA_1,
+	DA850_EMA_CLK,
+	DA850_EMA_WAIT_1,
+	DA850_NEMA_CS_2,
+
+	/* GPIO function */
+	DA850_GPIO2_4,
+	DA850_GPIO2_6,
+	DA850_GPIO2_8,
+	DA850_GPIO2_15,
+	DA850_GPIO3_12,
+	DA850_GPIO3_13,
+	DA850_GPIO4_0,
+	DA850_GPIO4_1,
+	DA850_GPIO6_9,
+	DA850_GPIO6_10,
+	DA850_GPIO6_13,
+	DA850_RTC_ALARM,
+
+	/* VPIF Capture */
+	DA850_VPIF_DIN0,
+	DA850_VPIF_DIN1,
+	DA850_VPIF_DIN2,
+	DA850_VPIF_DIN3,
+	DA850_VPIF_DIN4,
+	DA850_VPIF_DIN5,
+	DA850_VPIF_DIN6,
+	DA850_VPIF_DIN7,
+	DA850_VPIF_DIN8,
+	DA850_VPIF_DIN9,
+	DA850_VPIF_DIN10,
+	DA850_VPIF_DIN11,
+	DA850_VPIF_DIN12,
+	DA850_VPIF_DIN13,
+	DA850_VPIF_DIN14,
+	DA850_VPIF_DIN15,
+	DA850_VPIF_CLKIN0,
+	DA850_VPIF_CLKIN1,
+	DA850_VPIF_CLKIN2,
+	DA850_VPIF_CLKIN3,
+
+	/* VPIF Display */
+	DA850_VPIF_DOUT0,
+	DA850_VPIF_DOUT1,
+	DA850_VPIF_DOUT2,
+	DA850_VPIF_DOUT3,
+	DA850_VPIF_DOUT4,
+	DA850_VPIF_DOUT5,
+	DA850_VPIF_DOUT6,
+	DA850_VPIF_DOUT7,
+	DA850_VPIF_DOUT8,
+	DA850_VPIF_DOUT9,
+	DA850_VPIF_DOUT10,
+	DA850_VPIF_DOUT11,
+	DA850_VPIF_DOUT12,
+	DA850_VPIF_DOUT13,
+	DA850_VPIF_DOUT14,
+	DA850_VPIF_DOUT15,
+	DA850_VPIF_CLKO2,
+	DA850_VPIF_CLKO3,
+};
+
+#define PINMUX(x)		(4 * (x))
+
+#ifdef CONFIG_DAVINCI_MUX
+/* setup pin muxing */
+extern int davinci_cfg_reg(unsigned long reg_cfg);
+extern int davinci_cfg_reg_list(const short pins[]);
+#else
+/* boot loader does it all (no warnings from CONFIG_DAVINCI_MUX_WARNINGS) */
+static inline int davinci_cfg_reg(unsigned long reg_cfg) { return 0; }
+static inline int davinci_cfg_reg_list(const short pins[])
+{
+	return 0;
+}
+#endif
+
 
 #define MUX_CFG(soc, desc, muxreg, mode_offset, mode_mask, mux_mode, dbg)\
 [soc##_##desc] = {							\
diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
index 67f1c8537354..b8b5f1a5e092 100644
--- a/arch/arm/mach-davinci/pdata-quirks.c
+++ b/arch/arm/mach-davinci/pdata-quirks.c
@@ -10,8 +10,8 @@
 #include <media/i2c/tvp514x.h>
 #include <media/i2c/adv7343.h>
 
-#include <mach/common.h>
-#include <mach/da8xx.h>
+#include "common.h"
+#include "da8xx.h"
 
 struct pdata_init {
 	const char *compatible;
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 323ee4e657c4..8aa39db095d7 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -16,11 +16,10 @@
 #include <asm/delay.h>
 #include <asm/io.h>
 
-#include <mach/common.h>
-#include <mach/da8xx.h>
-#include <mach/mux.h>
-#include <mach/pm.h>
-
+#include "common.h"
+#include "da8xx.h"
+#include "mux.h"
+#include "pm.h"
 #include "clock.h"
 #include "psc.h"
 #include "sram.h"
diff --git a/arch/arm/mach-davinci/include/mach/pm.h b/arch/arm/mach-davinci/pm.h
similarity index 100%
rename from arch/arm/mach-davinci/include/mach/pm.h
rename to arch/arm/mach-davinci/pm.h
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 127b62ce7b1e..7f7814807bb5 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -14,8 +14,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/serial.h>
-#include <mach/cputype.h>
+#include "serial.h"
+#include "cputype.h"
 
 static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
 				    int value)
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/serial.h
similarity index 97%
rename from arch/arm/mach-davinci/include/mach/serial.h
rename to arch/arm/mach-davinci/serial.h
index d4b4aa87964f..14473cb19852 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/serial.h
@@ -13,7 +13,7 @@
 
 #include <asm/memory.h>
 
-#include <mach/hardware.h>
+#include "hardware.h"
 
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index bbae190fd82c..d04f39fc84b6 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/genalloc.h>
 
-#include <mach/common.h>
+#include "common.h"
 #include "sram.h"
 
 static struct gen_pool *sram_pool;
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 25f21ee86f1a..9c8fc5031907 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -15,10 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 
-#include <mach/common.h>
-#include <mach/cputype.h>
-#include <mach/da8xx.h>
-
+#include "common.h"
+#include "cputype.h"
+#include "da8xx.h"
 #include "irqs.h"
 
 #define DA8XX_USB0_BASE		0x01e00000
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index dd8db61cdd1c..a9e5c6e91e5d 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -8,9 +8,8 @@
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/usb/musb.h>
 
-#include <mach/common.h>
-#include <mach/cputype.h>
-
+#include "common.h"
+#include "cputype.h"
 #include "irqs.h"
 
 #define DAVINCI_USB_OTG_BASE	0x01c64000
-- 
2.29.2

