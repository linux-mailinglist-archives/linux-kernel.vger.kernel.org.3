Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF804F0DE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377058AbiDDEEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376996AbiDDEEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:04:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC36393FC;
        Sun,  3 Apr 2022 21:02:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so36001pjn.3;
        Sun, 03 Apr 2022 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Oa+8byNWNKKPzQUi9Ts2CajVA6iBJj5SCfhXQT0Kjo=;
        b=X/Y5YHGZW9tWJ+B9jlEAAJWG+dmynG23Ldbowkbt071qsod4+Nod/haYkCzrENf8Ar
         sEhtn5BucB36zCep41qVSWZHCOTktzTgx3RBuwizi3SW73tQMnmBLXHeP8AycXUUJcZj
         wUHWlOBVW0s27lHlormQyPUchXW5ys5Tc7AaAeqyyNy7/AO+xcqWgp90yTCJUH3qCiYx
         Q/2pOM4bTnbqyA+KICTsySdkiZrki207AcDjqeZAxJUqZrs81BnOrcMy8/3LMYNVZ6zA
         k5rwuVGdtbLZUv9qv/gObf6yAOiW+yvqP3oEStnV2t/Hk2KmonD0TFsaExVHpkJ8Ko4s
         sQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Oa+8byNWNKKPzQUi9Ts2CajVA6iBJj5SCfhXQT0Kjo=;
        b=LPEEOATjgUPYvNrLqt3SC/7e6QNS8FkALCWtkgU1N+MhLzZFEWpmO2LwN7EtR/HikA
         YeMZL+r3TJua7ZhR9c1tKaxaPLWWpkTITvJ5C2VggvKwhjg0Lp6zWoRWX4OWlCxlPsAk
         jFZmsD+zeb6rGFNo8SH4vwkYruRgKfNkB9qahtjEd1z5x5GyCAbXYi+0ilxLdOkfD2mK
         D2AXD7ODxpp+rMuQdVbTSVnB1GJ0CLBUqxQnnKs3uAzGX/s7+BbJ7H+ua8p6VFrTK6Xx
         q0iK5CRRasRBbjFYrPpWhgJbSMsiNZTM1vYF1AoebUGvOlwGKYBQQH5G5FjLDrTZM91P
         IvwQ==
X-Gm-Message-State: AOAM5302LKHbSJXEk5sjGuCkw9R2EZsdPtnZvpOHxtlGMsrwM7N4BnyH
        ajiFrm2QSUckzI8ZJTjGuuF8CfshaO/uUO3kF5Q+CQ==
X-Google-Smtp-Source: ABdhPJyez1j8M8EU8wBC4daK2EdE3R5g7YnIA5VP3b4jqFeO/EPK99JHzzzxw9a6LhitJTZtxqAtlw==
X-Received: by 2002:a17:90b:1bc9:b0:1c7:228a:95ce with SMTP id oa9-20020a17090b1bc900b001c7228a95cemr24273683pjb.3.1649044935542;
        Sun, 03 Apr 2022 21:02:15 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id j70-20020a638b49000000b003985b5ddaa1sm8756191pge.49.2022.04.03.21.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 21:02:15 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: [PATCH v2 1/5] mtd: nand: make mtk_ecc.c a separated module
Date:   Mon,  4 Apr 2022 12:01:49 +0800
Message-Id: <20220404040153.1509966-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404040153.1509966-1-gch981213@gmail.com>
References: <20220404040153.1509966-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this code will be used in mediatek snfi spi-mem controller with
pipelined ECC engine.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

Change since v1:
  actually make it a module instead of a part of nandcore.o
    (ECC_MXIC probablly needs a similar fix.)

 drivers/mtd/nand/Kconfig                                   | 7 +++++++
 drivers/mtd/nand/Makefile                                  | 1 +
 drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c}              | 3 +--
 drivers/mtd/nand/raw/Kconfig                               | 1 +
 drivers/mtd/nand/raw/Makefile                              | 2 +-
 drivers/mtd/nand/raw/mtk_nand.c                            | 2 +-
 .../nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h | 0
 7 files changed, 12 insertions(+), 4 deletions(-)
 rename drivers/mtd/nand/{raw/mtk_ecc.c => ecc-mtk.c} (99%)
 rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 9b249826ef93..2f3e02ab72ed 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -53,6 +53,13 @@ config MTD_NAND_ECC_MXIC
 	help
 	  This enables support for the hardware ECC engine from Macronix.
 
+config MTD_NAND_ECC_MEDIATEK
+	tristate "Mediatek hardware ECC engine"
+	depends on HAS_IOMEM
+	select MTD_NAND_ECC
+	help
+	  This enables support for the hardware ECC engine from Mediatek.
+
 endmenu
 
 endmenu
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index a4e6b7ae0614..19e1291ac4d5 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -2,6 +2,7 @@
 
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
+obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) += ecc-mtk.o
 
 obj-y	+= onenand/
 obj-y	+= raw/
diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/ecc-mtk.c
similarity index 99%
rename from drivers/mtd/nand/raw/mtk_ecc.c
rename to drivers/mtd/nand/ecc-mtk.c
index 49ab3448b9b1..74ddaa46ba7c 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -15,8 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/mutex.h>
-
-#include "mtk_ecc.h"
+#include <linux/mtd/nand-ecc-mtk.h>
 
 #define ECC_IDLE_MASK		BIT(0)
 #define ECC_IRQ_EN		BIT(0)
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 9b078e78f3fa..8b6d7a515445 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -374,6 +374,7 @@ config MTD_NAND_QCOM
 
 config MTD_NAND_MTK
 	tristate "MTK NAND controller"
+	depends on MTD_NAND_ECC_MEDIATEK
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 88a566513c56..fa1d00120310 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
 obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
-obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
+obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_nand.o
 obj-$(CONFIG_MTD_NAND_MXIC)		+= mxic_nand.o
 obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
 obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+= stm32_fmc2_nand.o
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 66f04c693c87..d540454cbbdf 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -17,7 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include "mtk_ecc.h"
+#include <linux/mtd/nand-ecc-mtk.h>
 
 /* NAND controller register definition */
 #define NFI_CNFG		(0x00)
diff --git a/drivers/mtd/nand/raw/mtk_ecc.h b/include/linux/mtd/nand-ecc-mtk.h
similarity index 100%
rename from drivers/mtd/nand/raw/mtk_ecc.h
rename to include/linux/mtd/nand-ecc-mtk.h
-- 
2.35.1

