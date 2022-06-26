Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49B55B472
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiFZX1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 19:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiFZX1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 19:27:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E252BEB;
        Sun, 26 Jun 2022 16:27:46 -0700 (PDT)
X-UUID: 56871dbf8593469eb0112fb5eb0b22dc-20220627
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:15fc8f8d-b5af-434f-92b5-7fab2098bdab,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:9d638bea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 56871dbf8593469eb0112fb5eb0b22dc-20220627
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 164823766; Mon, 27 Jun 2022 07:27:39 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 27 Jun 2022 07:27:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jun 2022 07:27:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 27 Jun 2022 07:27:37 +0800
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
Subject: [PATCH v3] Bluetooth: btmtksdio: Add in-band wakeup support
Date:   Mon, 27 Jun 2022 07:27:36 +0800
Message-ID: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
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
v3: add a way suggested by the AngeloGioacchino Del Regno that look
    elegant and can avoid the addition of the BTMTKSDIO_INBAND_WAKEUP
    flag
---
 drivers/bluetooth/btmtksdio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index d6700efcfe8c..f9a3444753c2 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1282,6 +1282,13 @@ static void btmtksdio_cmd_timeout(struct hci_dev *hdev)
 	hci_reset_dev(hdev);
 }
 
+static bool btmtksdio_sdio_inband_wakeup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+
+	return device_may_wakeup(bdev->dev);
+}
+
 static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -1349,6 +1356,14 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->shutdown = btmtksdio_shutdown;
 	hdev->send     = btmtksdio_send_frame;
 	hdev->wakeup   = btmtksdio_sdio_wakeup;
+	/*
+	 * If SDIO controller supports wake on Bluetooth, sending a wakeon
+	 * command is not necessary.
+	 */
+	if (device_can_wakeup(func->card->host->parent))
+		hdev->wakeup = btmtksdio_sdio_inband_wakeup;
+	else
+		hdev->wakeup = btmtksdio_sdio_wakeup;
 	hdev->set_bdaddr = btmtk_set_bdaddr;
 
 	SET_HCIDEV_DEV(hdev, &func->dev);
-- 
2.25.1

