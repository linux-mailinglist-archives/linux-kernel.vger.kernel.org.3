Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4F570D47
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 00:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiGKWXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiGKWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:23:37 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE035B21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:33 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m14so5644545plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwoWAKJGLd9SSlXMcBweio9xAZcHotQKiELuk/jadhs=;
        b=cUDerjFW+ZfJ27rSAVACN/ymG+8oibDmVlh1CXTofv1OvUiQkDQQEXaYyiJUxuudvF
         tbqhn+XNzlCTseO+hGlruLk1otnFXW4rLKNcbOT56qh2Qf6fwq6Vi6HqCm52N9aq6yxI
         HsOOh90lQYPL2mEK+tSIjE+UwhlPErUEid8yv4cpTgBgFRPWmvhSnuSnESs6/4nhq8t4
         MNMgOd3b+jJYTG8i3e7D0mhwNVVwYVgU881iXoblK3kOwlHDJs7yyFGBWD4QetEx3ytX
         atBtbUyt55Bz4EwcC+fH3TNPQzBa5SA3vmGtTpRrq2UmGIEZc6Nv6b3E3FLJbF69++vh
         9wRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwoWAKJGLd9SSlXMcBweio9xAZcHotQKiELuk/jadhs=;
        b=yRoOnqsUTnVQmQG28DJICrNu7Q+RNVCYEPvJAhbGT+idIRVVtjvJAOsDmH5OqOV6ms
         GvJp4ffkoLeJ7OXPYZiJV4BOIz+o3rXERHnW/J14FmR9dnqi2Gem3ghQAZS1AMSEPa64
         Wc/ER7/tavoAZy4agtXOGkgF8LnfBTEeS4Tsyxyy0CxX9CkK8GRU2AP/yoj18Dg3Paqd
         AcbRhpK6tA2b9X4dBwNY7W73Z3YmsP3AxsI1cFFSu1MORcZGEukov3+MfqnqExQX6+rh
         M4jCRNP19E92R0/XU2vcr02OJ0scxFZr3MrccroQ3JxQy472Ty1jhRLZj0nuO/xzd87x
         q5Vw==
X-Gm-Message-State: AJIora9+aVnSVV71GymGpLX0ujmVPmMoy7nYnfSst21XGXYR1noK/baE
        0MH245wR+X0ZvkzwfwEhIIY=
X-Google-Smtp-Source: AGRyM1tfnPqPWAZx7h3NfTzcNn4bH4ejXLJRMterUSsiEbLQQlGDh3YmCTxE0k8e6QeBLZOcvMN8bA==
X-Received: by 2002:a17:90a:710a:b0:1ef:991c:dc67 with SMTP id h10-20020a17090a710a00b001ef991cdc67mr655749pjk.110.1657578212878;
        Mon, 11 Jul 2022 15:23:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016be5f24aaesm5274774plg.163.2022.07.11.15.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 15:23:32 -0700 (PDT)
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
Subject: [PATCH 2/2] mtd: rawnand: brcmnand: Add individual glue driver selection
Date:   Mon, 11 Jul 2022 15:23:23 -0700
Message-Id: <20220711222323.4048197-3-f.fainelli@gmail.com>
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

Allow each platform to define a dedicated Kconfig entry for its glue
driver such that we can decide on a per-platfomr basis whether to build
it or not. This allows for a finer grained control over the resulting
kernel image or set of modules.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/Kconfig  | 28 ++++++++++++++++++++++++++
 drivers/mtd/nand/raw/brcmnand/Makefile |  8 ++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/Kconfig b/drivers/mtd/nand/raw/brcmnand/Kconfig
index d5a0265525ca..4bc51bf60aca 100644
--- a/drivers/mtd/nand/raw/brcmnand/Kconfig
+++ b/drivers/mtd/nand/raw/brcmnand/Kconfig
@@ -9,6 +9,13 @@ config MTD_NAND_BRCMNAND
 
 if MTD_NAND_BRCMNAND
 
+config MTD_NAND_BRCMNAND_BCM63XX
+	tristate "Broadcom BCM63xx NAND controller glue"
+	default BCM63XX
+	help
+	  Enables the BRCMNAND glue driver to register the NAND controller
+	  on Broadcom BCM63xx MIPS-based DSL platforms.
+
 config MTD_NAND_BRCMNAND_BCMA
 	tristate "Broadcom BCMA NAND controller"
 	depends on BCMA_NFLASH
@@ -18,4 +25,25 @@ config MTD_NAND_BRCMNAND_BCMA
 	  The glue driver will take care of performing the low-level I/O
 	  operations to interface the BRCMNAND controller over the BCMA bus.
 
+config MTD_NAND_BRCMNAND_BCMBCA
+	tristate "Broadcom BCMBCA NAND controller glue"
+	default ARCH_BCMBCA
+	help
+	  Enables the BRCMNAND glue driver to register the NAND controller
+	  on Broadcom BCA platforms.
+
+config MTD_NAND_BRCMNAND_BRCMSTB
+	tristate "Broadcom STB Nand controller glue"
+	default ARCH_BRCMSTB
+	help
+	  Enables the BRCMNAND glue driver to register the NAND controller
+	  on Broadcom STB platforms.
+
+config MTD_NAND_BRCMNAND_IPROC
+	tristate "Broadcom iProc NAND controller glue"
+	default ARCH_BCM_IPROC
+	help
+	  Enables the BRCMNAND controller glue driver to register the NAND
+	  controller on Broadcom iProc platforms.
+
 endif # MTD_NAND_BRCMNAND
diff --git a/drivers/mtd/nand/raw/brcmnand/Makefile b/drivers/mtd/nand/raw/brcmnand/Makefile
index 16dc7254200e..9907e3ec4bb2 100644
--- a/drivers/mtd/nand/raw/brcmnand/Makefile
+++ b/drivers/mtd/nand/raw/brcmnand/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # link order matters; don't link the more generic brcmstb_nand.o before the
 # more specific iproc_nand.o, for instance
-obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= iproc_nand.o
-obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm63138_nand.o
-obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= bcm6368_nand.o
-obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmstb_nand.o
+obj-$(CONFIG_MTD_NAND_BRCMNAND_IPROC)	+= iproc_nand.o
+obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMBCA)	+= bcm63138_nand.o
+obj-$(CONFIG_MTD_NAND_BRCMNAND_BCM63XX)	+= bcm6368_nand.o
+obj-$(CONFIG_MTD_NAND_BRCMNAND_BRCMSTB)	+= brcmstb_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand.o
 
 obj-$(CONFIG_MTD_NAND_BRCMNAND_BCMA)	+= bcma_nand.o
-- 
2.25.1

