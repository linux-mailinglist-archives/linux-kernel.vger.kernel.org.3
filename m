Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243DD570D48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiGKWXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiGKWXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:23:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC8821B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9661734pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZFhWlnda4SXoJnWWqvMvV3sR5/zMUvEmc+r8suqDxc=;
        b=NXIoVtBZLRNtdnYNk75WJuKEh1EQthMAB+vTJbMlnGkk4+c/yHwI7iNBVcQuFg/mZw
         IcVeDUQpShLeYI5rYsbB3dlj4AaXLFgUMMaPxgPoIqqPKgDF1DJZ6P9xDLSlv6719gE1
         YtsszF04M/z4BCg+8wVvBAn91Y7QWdFbyvpiM6/5233n4Y8lD1soPMBKdKTpJCk4oe57
         5fe+2y1ErOgVDb946coFo9YipcNoUgMBX/A8DBUtWF8q5NxF/9LWXHdMVi++qyQYgGgM
         sRS2nUTPaSrzrrClOYo2X1a5cmMbQ51QkJFdGfGmb0ggyBAQgnNET29g1AU+0Cm1yiqY
         0Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZFhWlnda4SXoJnWWqvMvV3sR5/zMUvEmc+r8suqDxc=;
        b=OSdiM2V3LqDchxD9ugYX2PeftTLKbwfloq9lIK94nME9HRrM+rvX5uhNZZrmFTWHNG
         aIZwAzU7yRDiWfKidcZ7J21rcdRL3kFf2FEGVWfSgfXqQmI9+zRvjjydVD+jRBMJ+oJf
         fDilRrXafxH5bhKFp8SKgKVu+0FVT0v7nWQK1Mopjav/nPj4B+XjcxxnVfbeBnzGXmRe
         68xJxnzbMIhsx/HG6J3XnX7A6KoIthVoHI5il+1HIt5okV8ZABQHluQ3wG7Ur09wnbHo
         ZbIEA8eQ5hXIsYv2RfsvAmAJ9XVJCVmzoeiaY/4Jd6vtHayDBke4ss8aNydLLPVtSTc8
         c0nA==
X-Gm-Message-State: AJIora+o/Lh54Q8zaTzjFOiStXeRYG44gDslL035D5/Fo0d+AfLyYX5h
        9GcdB/ZMvbfAF6bJBPNBdsA3qBrcyb4=
X-Google-Smtp-Source: AGRyM1uFWCGpl6fspxtDr/tVPfV/5GWUPsNkGgcDYOLqbaCfklQ8MldUdsHxQLL4YKQjdAQ26rOK1A==
X-Received: by 2002:a17:90a:9f8d:b0:1f0:253e:3ecf with SMTP id o13-20020a17090a9f8d00b001f0253e3ecfmr647419pjp.33.1657578211109;
        Mon, 11 Jul 2022 15:23:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016be5f24aaesm5274774plg.163.2022.07.11.15.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:23:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 1/2] mtd: rawnand: brcmnand: Move Kconfig to driver folder
Date:   Mon, 11 Jul 2022 15:23:22 -0700
Message-Id: <20220711222323.4048197-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711222323.4048197-1-f.fainelli@gmail.com>
References: <20220711222323.4048197-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for allowing each of the brcmnand stub to be built
separately, move the Kconfig entry to the driver folder.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/Kconfig          | 22 +---------------------
 drivers/mtd/nand/raw/brcmnand/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/brcmnand/Kconfig

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 8b6d7a515445..43a151b4c8fc 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -200,27 +200,7 @@ config MTD_NAND_TMIO
 	  Support for NAND flash connected to a Toshiba Mobile IO
 	  Controller in some PDAs, including the Sharp SL6000x.
 
-config MTD_NAND_BRCMNAND
-	tristate "Broadcom STB NAND controller"
-	depends on ARM || ARM64 || MIPS || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Enables the Broadcom NAND controller driver. The controller was
-	  originally designed for Set-Top Box but is used on various BCM7xxx,
-	  BCM3xxx, BCM63xxx, iProc/Cygnus and more.
-
-if MTD_NAND_BRCMNAND
-
-config MTD_NAND_BRCMNAND_BCMA
-	tristate "Broadcom BCMA NAND controller"
-	depends on BCMA_NFLASH
-	depends on BCMA
-	help
-	  Enables the BRCMNAND controller over BCMA on BCM47186/BCM5358 SoCs.
-	  The glue driver will take care of performing the low-level I/O
-	  operations to interface the BRCMNAND controller over the BCMA bus.
-
-endif # MTD_NAND_BRCMNAND
+source "drivers/mtd/nand/raw/brcmnand/Kconfig"
 
 config MTD_NAND_BCM47XXNFLASH
 	tristate "BCM4706 BCMA NAND controller"
diff --git a/drivers/mtd/nand/raw/brcmnand/Kconfig b/drivers/mtd/nand/raw/brcmnand/Kconfig
new file mode 100644
index 000000000000..d5a0265525ca
--- /dev/null
+++ b/drivers/mtd/nand/raw/brcmnand/Kconfig
@@ -0,0 +1,21 @@
+config MTD_NAND_BRCMNAND
+	tristate "Broadcom STB NAND controller"
+	depends on ARM || ARM64 || MIPS || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Enables the Broadcom NAND controller driver. The controller was
+	  originally designed for Set-Top Box but is used on various BCM7xxx,
+	  BCM3xxx, BCM63xxx, iProc/Cygnus and more.
+
+if MTD_NAND_BRCMNAND
+
+config MTD_NAND_BRCMNAND_BCMA
+	tristate "Broadcom BCMA NAND controller"
+	depends on BCMA_NFLASH
+	depends on BCMA
+	help
+	  Enables the BRCMNAND controller over BCMA on BCM47186/BCM5358 SoCs.
+	  The glue driver will take care of performing the low-level I/O
+	  operations to interface the BRCMNAND controller over the BCMA bus.
+
+endif # MTD_NAND_BRCMNAND
-- 
2.25.1

