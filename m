Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9814FDCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352701AbiDLKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381422AbiDLK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:29:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79395580CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=pXpt/O0wt40ELy2VjiVcNMr4U+X
        Bfk5SDzhV9fM2Egk=; b=JonB2GfC1bYb3hU/Pm+B/VVayEli2jf5gVR+JuHgVI9
        0QU1Z1rg+w/ylhmfkssV9mzymBRYToStQ9jqBqjrgUPM2KkGAqoTwbnK1plACiO9
        nVMgRySQ10W7FikM2QDbyLs5FNnesUrNhNVnvAK8KOyXHkF1EnZXwkwM0UAObKtc
        =
Received: (qmail 981999 invoked from network); 12 Apr 2022 11:31:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 11:31:30 +0200
X-UD-Smtp-Session: l3s3148p1@jLPGuXHcAucgAQnoAGZ4AFi7qjeMIP6q
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sh_mmcif: move platform_data header to proper location
Date:   Tue, 12 Apr 2022 11:31:02 +0200
Message-Id: <20220412093102.3428-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a dedicated directory for platform_data meanwhile, don't spoil
the MMC directory with it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: fixed sorting of includes in the MMCIF driver
		 (Thanks Geert!)

I don't have the HW to test this but the buildbots are happy with this
change. I checked that they actually tested the SH builds. To make the
patch more readable, I used the -M (rename) feature of git-format-patch.

 arch/sh/boards/board-sh7757lcr.c                | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c            | 2 +-
 arch/sh/boot/romimage/mmcif-sh7724.c            | 2 +-
 drivers/mmc/host/sh_mmcif.c                     | 2 +-
 include/linux/{mmc => platform_data}/sh_mmcif.h | 2 --
 5 files changed, 4 insertions(+), 6 deletions(-)
 rename include/linux/{mmc => platform_data}/sh_mmcif.h (99%)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index c32b4c6229d3..f39c8196efdf 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
+#include <linux/platform_data/sh_mmcif.h>
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/renesas_usbhs.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4c9522dd351f..674da7ebd8b7 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -19,7 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mmcif.h>
+#include <linux/platform_data/sh_mmcif.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
index 6595b6b45bf1..d30123d859e0 100644
--- a/arch/sh/boot/romimage/mmcif-sh7724.c
+++ b/arch/sh/boot/romimage/mmcif-sh7724.c
@@ -8,7 +8,7 @@
  * for more details.
  */
 
-#include <linux/mmc/sh_mmcif.h>
+#include <linux/platform_data/sh_mmcif.h>
 #include <mach/romimage.h>
 
 #define MMCIF_BASE      (void __iomem *)0xa4ca0000
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5f9ebf045b1c..0fd4c9d644dd 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -43,12 +43,12 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
-#include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/pagemap.h>
+#include <linux/platform_data/sh_mmcif.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/platform_data/sh_mmcif.h
similarity index 99%
rename from include/linux/mmc/sh_mmcif.h
rename to include/linux/platform_data/sh_mmcif.h
index e25533b95d9f..6eb914f958f9 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/platform_data/sh_mmcif.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * include/linux/mmc/sh_mmcif.h
- *
  * platform data for eMMC driver
  *
  * Copyright (C) 2010 Renesas Solutions Corp.
-- 
2.30.2

