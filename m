Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38350DFCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiDYMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiDYMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:21:37 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED801A3AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:18:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c150:c4b6:d197:3811])
        by xavier.telenet-ops.be with bizsmtp
        id P0JU270033M22MD010JUHG; Mon, 25 Apr 2022 14:18:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nixff-0026ck-Ci; Mon, 25 Apr 2022 14:18:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nixfe-006ZU1-UT; Mon, 25 Apr 2022 14:18:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] staging: vc04_services: Re-add dependency on HAS_DMA to BCM2835_VCHIQ
Date:   Mon, 25 Apr 2022 14:18:25 +0200
Message-Id: <da55bd87eebf1a969dc8ccd807843319833f6c40.1650888813.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to stubs for the NO_DMA=y case, drivers that use the DMA API can
be compile-tested on systems that do not support DMA.  Hence the
dependency of BCM2835_VCHIQ on HAS_DMA was dropped to increase compile
coverage.

Unfortunately compilers became smarter, leading to new failures.
E.g. for a CONFIG_SUN3=y allmodconfig kernel with gcc 9.4.0:

    drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c: In function ‘free_pagelist’:
    arch/m68k/include/asm/string.h:72:25: warning: argument 2 null where non-null expected [-Wnonnull]
       72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:614:4: note: in expansion of macro ‘memcpy’
      614 |    memcpy((char *)kmap(pages[0]) +
	  |    ^~~~~~
    arch/m68k/include/asm/string.h:72:25: note: in a call to built-in function ‘__builtin_memcpy’
       72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
	  |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:614:4: note: in expansion of macro ‘memcpy’
      614 |    memcpy((char *)kmap(pages[0]) +
	  |    ^~~~~~

This happens because the compiler can trace back the source pointer to a
allocation by dma_alloc_attrs(), which always returns NULL if NO_DMA=y.

Avoid this reinstating the dependency of the BCM2835_VCHIQ symbol on
HAS_DMA, and by restricting the selection of BCM2835_VCHIQ.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/staging/vc04_services/Kconfig                | 1 +
 drivers/staging/vc04_services/bcm2835-audio/Kconfig  | 2 +-
 drivers/staging/vc04_services/bcm2835-camera/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index cb7c82403dbf22cb..31e58c9d1a110441 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -13,6 +13,7 @@ if BCM_VIDEOCORE
 
 config BCM2835_VCHIQ
 	tristate "BCM2835 VCHIQ"
+	depends on HAS_DMA
 	imply VCHIQ_CDEV
 	help
 		Broadcom BCM2835 and similar SoCs have a VPU called VideoCore. This config
diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index d32ea348e846f2c0..5a3a5279551eb702 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -3,7 +3,7 @@ config SND_BCM2835
 	tristate "BCM2835 Audio"
 	depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
 	select SND_PCM
-	select BCM2835_VCHIQ
+	select BCM2835_VCHIQ if HAS_DMA
 	help
 	  Say Y or M if you want to support BCM2835 built in audio
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/Kconfig b/drivers/staging/vc04_services/bcm2835-camera/Kconfig
index dcda565f9b38090f..870c9afb223a220b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-camera/Kconfig
@@ -3,8 +3,8 @@ config VIDEO_BCM2835
 	tristate "BCM2835 Camera"
 	depends on MEDIA_SUPPORT
 	depends on VIDEO_DEV && (ARCH_BCM2835 || COMPILE_TEST)
-	select BCM2835_VCHIQ
-	select BCM2835_VCHIQ_MMAL
+	select BCM2835_VCHIQ if HAS_DMA
+	select BCM2835_VCHIQ_MMAL if HAS_DMA
 	select VIDEOBUF2_VMALLOC
 	select BTREE
 	help
-- 
2.25.1

