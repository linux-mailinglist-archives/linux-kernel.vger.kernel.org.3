Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2D4DC3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiCQKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbiCQKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:13:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57221DDFF5;
        Thu, 17 Mar 2022 03:12:28 -0700 (PDT)
X-UUID: f23b125a8b31466799a2ea1d769c2992-20220317
X-UUID: f23b125a8b31466799a2ea1d769c2992-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 636321638; Thu, 17 Mar 2022 18:12:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 18:12:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 18:12:20 +0800
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Axe Yang <axe.yang@mediatek.com>, Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND v7 2/3] mmc: core: Add support for SDIO wakeup interrupt
Date:   Thu, 17 Mar 2022 18:12:14 +0800
Message-ID: <20220317101215.24985-3-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317101215.24985-1-axe.yang@mediatek.com>
References: <20220317101215.24985-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wakeup-source flag is set in host dts node, parse EAI information
from SDIO CCCR interrupt externsion segment for in-band wakeup. If
async interrupt is supported by SDIO card then enable it and set
enable_async_irq flag in sdio_cccr structure to 1. The parse flow is
implemented in sdio_read_cccr().

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/core/sdio.c  | 17 +++++++++++++++++
 include/linux/mmc/card.h |  8 +++++++-
 include/linux/mmc/sdio.h |  5 +++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799accf8a0..4898c5e9a299 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -226,6 +226,23 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 				card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_C;
 			if (data & SDIO_DRIVE_SDTD)
 				card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_D;
+
+			if (card->host->pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+				ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTERRUPT_EXT, 0,
+						       &data);
+				if (ret)
+					goto out;
+
+				if (data & SDIO_INTERRUPT_EXT_SAI) {
+					data |= SDIO_INTERRUPT_EXT_EAI;
+					ret = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_INTERRUPT_EXT,
+							       data, NULL);
+					if (ret)
+						goto out;
+
+					card->cccr.enable_async_irq = 1;
+				}
+			}
 		}
 
 		/* if no uhs mode ensure we check for high speed */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f975875102..968650c0b345 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -219,7 +219,8 @@ struct sdio_cccr {
 				wide_bus:1,
 				high_power:1,
 				high_speed:1,
-				disable_cd:1;
+				disable_cd:1,
+				enable_async_irq:1;
 };
 
 struct sdio_cis {
@@ -343,6 +344,11 @@ static inline bool mmc_large_sector(struct mmc_card *card)
 	return card->ext_csd.data_sector_size == 4096;
 }
 
+static inline int mmc_card_enable_async_irq(struct mmc_card *card)
+{
+	return card->cccr.enable_async_irq;
+}
+
 bool mmc_card_is_blockaddr(struct mmc_card *card);
 
 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 2a05d1ac4f0e..1ef400f28642 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -159,6 +159,11 @@
 #define  SDIO_DTSx_SET_TYPE_A	(1 << SDIO_DRIVE_DTSx_SHIFT)
 #define  SDIO_DTSx_SET_TYPE_C	(2 << SDIO_DRIVE_DTSx_SHIFT)
 #define  SDIO_DTSx_SET_TYPE_D	(3 << SDIO_DRIVE_DTSx_SHIFT)
+
+#define SDIO_CCCR_INTERRUPT_EXT	0x16
+#define SDIO_INTERRUPT_EXT_SAI	(1 << 0)
+#define SDIO_INTERRUPT_EXT_EAI	(1 << 1)
+
 /*
  * Function Basic Registers (FBR)
  */
-- 
2.25.1

