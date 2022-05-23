Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D7530A59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiEWHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiEWHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:40:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE6C1DA40;
        Mon, 23 May 2022 00:40:30 -0700 (PDT)
X-UUID: 0ac28a072bef4073a8a678164e0c2b61-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:fe224b73-7fd2-4c59-b8f0-30792c8a2a6a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:42c8427a-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 0ac28a072bef4073a8a678164e0c2b61-20220523
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2143665401; Mon, 23 May 2022 15:40:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 15:40:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 23 May 2022 15:40:21 +0800
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
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v11 2/3] mmc: core: Add support for SDIO wakeup interrupt
Date:   Mon, 23 May 2022 15:40:16 +0800
Message-ID: <20220523074017.12649-3-axe.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523074017.12649-1-axe.yang@mediatek.com>
References: <20220523074017.12649-1-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Axe Yang <axe.yang@mediatek.com>
---
 drivers/mmc/core/sdio.c  | 14 ++++++++++++++
 include/linux/mmc/card.h |  8 +++++++-
 include/linux/mmc/sdio.h |  5 +++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799accf8a0..165d8b3c3a96 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -226,6 +226,20 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 				card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_C;
 			if (data & SDIO_DRIVE_SDTD)
 				card->sw_caps.sd3_drv_type |= SD_DRIVER_TYPE_D;
+
+			ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTERRUPT_EXT, 0, &data);
+			if (ret)
+				goto out;
+
+			if (data & SDIO_INTERRUPT_EXT_SAI) {
+				data |= SDIO_INTERRUPT_EXT_EAI;
+				ret = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_INTERRUPT_EXT,
+						       data, NULL);
+				if (ret)
+					goto out;
+
+				card->cccr.enable_async_irq = 1;
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

