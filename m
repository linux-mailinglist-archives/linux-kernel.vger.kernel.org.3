Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F0532C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbiEXOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiEXOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:53:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F676EC46;
        Tue, 24 May 2022 07:53:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h8so21179953ljb.6;
        Tue, 24 May 2022 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=YenQcjheBrq0vv9z1vB/LB15hlmj+OsSMNFzna6+wL8=;
        b=f2eatNVnpDlgjVI+sKNIjUG7rZmVJPVfKKR377sj1ESjXWwjc4Ql6lrzmZ05oKsGrS
         0QDBHhdy0HLUY9wqsM8COMbyVOdzXTbaz29vT8J6+30jtCR4oUY1PRGDW0FyBABp/ZRI
         tfWiXBQlqNSPqV1kr5PR4LgOW4NJ0b0hzd+spvs7mLim9+oysGb9n/fKUnELgTPeNcy6
         HYRbetussPG4t9M/9Za6CF2nUYKqHzAYX3IkiZWQTF8Fvr0ZjJH58o5ILJBCRoUIl5tU
         /ZjwyBPQHzA03vT6sdHbQUZEOdTZx4mCO0ltsMBsoz4ctXgINcnr5OnM5KYGm28U/uuG
         ZZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=YenQcjheBrq0vv9z1vB/LB15hlmj+OsSMNFzna6+wL8=;
        b=ygqeS415cxJt+t8yntl6iJU2Nra8Czn4pF0frJOHNERt5t+hAgKcZeZCBZJQUivoga
         ot0koUMwmmIJqlxR89lhGz1WkaIjQfj2SWnNJFTUPAWAzdAhmDGQ7ugCvH0r31J4Q/IE
         rsJuO6q5MatBBJrWzcEsKw7f/SBMYJLGepFOuXZHRv4EZc5y6zXr6NP7msduPUWuM86O
         EHXHNugN0vvmbPBpdcI9E4sOuzvIfkc54OXBhTapnnpJw22rgcAn3fdiAAB7kf6KTYrr
         g1FVA0rD9+i85jRQ1hTuE+BUFcpJrSs7X8AiNSZvDeVhYOO1SbBxBC7t3X8cyufsMR/I
         ooyg==
X-Gm-Message-State: AOAM530EQApe3phoRb/KT4zLxlAW/5JntaIh+ZHCceo7FihHeO5YjB/M
        sNHNqzWznO4FWnMEU115Jhx1FZ94FrM=
X-Google-Smtp-Source: ABdhPJx9HIBj7mCgZF6m00YPHRr+ZtN7LNnkn7WA1r6PphNGx1354jokVLnabinYAdRiJ1g4zrXZRA==
X-Received: by 2002:a05:651c:1a06:b0:253:eacb:14e5 with SMTP id by6-20020a05651c1a0600b00253eacb14e5mr6502248ljb.29.1653403996941;
        Tue, 24 May 2022 07:53:16 -0700 (PDT)
Received: from crux (31-208-31-147.cust.bredband2.com. [31.208.31.147])
        by smtp.gmail.com with ESMTPSA id z4-20020a056512370400b0047255d211easm2565186lfr.281.2022.05.24.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:53:16 -0700 (PDT)
Date:   Tue, 24 May 2022 16:53:13 +0200
From:   Artur Bujdoso <artur.bujdoso@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon-usb: move driver out of staging
Message-ID: <YozxWT9veRJloyDD@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is sparse clean and as you replied 8th Apr the original
is fine, checkpatch has only warnings.

Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
---
 arch/mips/configs/cavium_octeon_defconfig             |  2 +-
 drivers/staging/Kconfig                               |  2 --
 drivers/staging/Makefile                              |  1 -
 drivers/staging/octeon-usb/Kconfig                    | 11 -----------
 drivers/staging/octeon-usb/Makefile                   |  2 --
 drivers/staging/octeon-usb/TODO                       |  8 --------
 drivers/usb/host/Kconfig                              | 10 ++++++++++
 drivers/usb/host/Makefile                             |  1 +
 drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c |  0
 drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h |  0
 10 files changed, 12 insertions(+), 25 deletions(-)
 delete mode 100644 drivers/staging/octeon-usb/Kconfig
 delete mode 100644 drivers/staging/octeon-usb/Makefile
 delete mode 100644 drivers/staging/octeon-usb/TODO
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c (100%)
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h (100%)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index b6695367aa33..97ceaf080c0c 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -134,7 +134,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
 CONFIG_OCTEON_ETHERNET=y
-CONFIG_OCTEON_USB=y
+CONFIG_USB_OCTEON_HCD=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_RAS=y
 CONFIG_EXT4_FS=y
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 0a993c47273e..3bd80f9695ac 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -42,8 +42,6 @@ source "drivers/staging/rts5208/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
 
-source "drivers/staging/octeon-usb/Kconfig"
-
 source "drivers/staging/vt6655/Kconfig"
 
 source "drivers/staging/vt6656/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 2800ab9b2d1d..1d9ae39fea14 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_R8712U)		+= rtl8712/
 obj-$(CONFIG_R8188EU)		+= r8188eu/
 obj-$(CONFIG_RTS5208)		+= rts5208/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
-obj-$(CONFIG_OCTEON_USB)	+= octeon-usb/
 obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme_user/
diff --git a/drivers/staging/octeon-usb/Kconfig b/drivers/staging/octeon-usb/Kconfig
deleted file mode 100644
index 6a5d842ee0f2..000000000000
--- a/drivers/staging/octeon-usb/Kconfig
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config OCTEON_USB
-	tristate "Cavium Networks Octeon USB support"
-	depends on CAVIUM_OCTEON_SOC && USB
-	help
-	  This driver supports USB host controller on some Cavium
-	  Networks' products in the Octeon family.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called octeon-hcd.
-
diff --git a/drivers/staging/octeon-usb/Makefile b/drivers/staging/octeon-usb/Makefile
deleted file mode 100644
index 9873a0130ad5..000000000000
--- a/drivers/staging/octeon-usb/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-${CONFIG_OCTEON_USB} := octeon-hcd.o
diff --git a/drivers/staging/octeon-usb/TODO b/drivers/staging/octeon-usb/TODO
deleted file mode 100644
index 2b29acca5caa..000000000000
--- a/drivers/staging/octeon-usb/TODO
+++ /dev/null
@@ -1,8 +0,0 @@
-This driver is functional and has been tested on EdgeRouter Lite,
-D-Link DSR-1000N and EBH5600 evaluation board with USB mass storage.
-
-TODO:
-	- kernel coding style
-	- checkpatch warnings
-
-Contact: Aaro Koskinen <aaro.koskinen@iki.fi>
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 57ca5f97a3dc..4acf3987bfd2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -306,6 +306,16 @@ config USB_EHCI_MV
 	  Dova, Armada 370 and Armada XP. See "Support for Marvell EBU
 	  on-chip EHCI USB controller" for those.
 
+config USB_OCTEON_HCD
+	tristate "Cavium Networks Octeon USB support"
+	depends on CAVIUM_OCTEON_SOC && USB
+	help
+	  This driver supports USB host controller on some Cavium
+	  Networks' products in the Octeon family.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called octeon-hcd.
+
 config USB_CNS3XXX_EHCI
 	bool "Cavium CNS3XXX EHCI Module (DEPRECATED)"
 	depends on ARCH_CNS3XXX || COMPILE_TEST
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 2948983618fb..2c8a61be7e46 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
 obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
 obj-$(CONFIG_USB_OHCI_HCD_PXA27X)	+= ohci-pxa27x.o
 obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
+obj-$(CONFIG_USB_OCTEON_HCD)	+= octeon-hcd.o
 
 obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/usb/host/octeon-hcd.c
similarity index 100%
rename from drivers/staging/octeon-usb/octeon-hcd.c
rename to drivers/usb/host/octeon-hcd.c
diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/usb/host/octeon-hcd.h
similarity index 100%
rename from drivers/staging/octeon-usb/octeon-hcd.h
rename to drivers/usb/host/octeon-hcd.h
-- 
2.30.2

