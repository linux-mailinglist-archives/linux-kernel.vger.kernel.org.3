Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B7D545915
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiFJARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiFJARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:17:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3FB2C11A;
        Thu,  9 Jun 2022 17:17:29 -0700 (PDT)
X-UUID: 55312f6602ac4c4082d6e10292fa5791-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:27768122-4a1c-41f1-88b8-956b6770a65d,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:105
X-CID-INFO: VERSION:1.1.5,REQID:27768122-4a1c-41f1-88b8-956b6770a65d,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:105
X-CID-META: VersionHash:2a19b09,CLOUDID:c542d97e-c8dc-403a-96e8-6237210dceee,C
        OID:3132453bd665,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 55312f6602ac4c4082d6e10292fa5791-20220610
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 765861630; Fri, 10 Jun 2022 08:17:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 08:17:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 08:17:18 +0800
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
        <linux-kernel@vger.kernel.org>, Yake Yang <yake.yang@mediatek.com>
Subject: [PATCH] Bluetooth: btmtksdio: Add in-band wakeup support
Date:   Fri, 10 Jun 2022 08:17:17 +0800
Message-ID: <742cdffcf110e1601257207fb2b0d3f426d4008c.1654819586.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

'ce64b3e94919 ("Bluetooth: mt7921s: Support wake on bluetooth")'
have added the waken-on-bluetooth via dedicated GPIO.

The patch extends the function to the waken-on-bluetooth via SDIO DAT1 pin
(inband wakeup) when the SDIO host driver is able to support.

Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d6700efcfe8c..9ed3af4ba51a 100644
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
 
+	/* Mark if the mmc host can support waken by SDIO */
+	if (device_can_wakeup(func->card->host->parent))
+		set_bit(BTMTKSDIO_INBAND_WAKEUP, &bdev->tx_state);
+
 	err = device_init_wakeup(bdev->dev, true);
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
-- 
2.25.1

