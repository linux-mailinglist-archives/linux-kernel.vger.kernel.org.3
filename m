Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6B556E09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiFVV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiFVV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:56:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC354091F;
        Wed, 22 Jun 2022 14:56:52 -0700 (PDT)
X-UUID: 6cab5ec6d26c4b64a2758275354ba7a7-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f070b29b-1b90-403b-959e-e22f7ef95d15,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:f070b29b-1b90-403b-959e-e22f7ef95d15,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:c7ab3438-5e4b-44d7-80b2-bb618cb09d29,C
        OID:76d87f2229d8,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6cab5ec6d26c4b64a2758275354ba7a7-20220623
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 969767491; Thu, 23 Jun 2022 05:56:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 05:56:44 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 05:56:43 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Yake Yang" <yake.yang@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtksdio: Add in-band wakeup support
Date:   Thu, 23 Jun 2022 05:56:43 +0800
Message-ID: <52b63a1be094a1ccbb20f2c89472580d95f0652a.1655934689.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Commit ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")
adds the wake on bluethooth via a dedicated GPIO.

Extend the wake-on-bluetooth to use the SDIO DAT1 pin (in-band wakeup),
when supported by the SDIO host driver.

Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: enhance the patch description and comments
---
 drivers/bluetooth/btmtksdio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d6700efcfe8c..9d79c9107b3a 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -118,6 +118,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define BTMTKSDIO_FUNC_ENABLED		3
 #define BTMTKSDIO_PATCH_ENABLED		4
 #define BTMTKSDIO_HW_RESET_ACTIVE	5
+#define BTMTKSDIO_INBAND_WAKEUP		6
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -1294,6 +1295,9 @@ static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 		.wakeup_delay = cpu_to_le16(0x20),
 	};
 
+	if (test_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state))
+		return may_wakeup;
+
 	if (may_wakeup && bdev->data->chipid == 0x7921) {
 		struct sk_buff *skb;
 
@@ -1384,6 +1388,10 @@ static int btmtksdio_probe(struct sdio_func *func,
 	 */
 	pm_runtime_put_noidle(bdev->dev);
 
+	/* Mark if MMC host supports wake on bluetooth by SDIO */
+	if (device_can_wakeup(func->card->host->parent))
+		set_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state);
+
 	err = device_init_wakeup(bdev->dev, true);
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
-- 
2.25.1

