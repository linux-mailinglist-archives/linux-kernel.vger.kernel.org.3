Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB51647ED19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351972AbhLXI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:26:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52736 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351959AbhLXI0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:26:09 -0500
X-UUID: 40da604aadd443f8a8981ab57d376b0f-20211224
X-UUID: 40da604aadd443f8a8981ab57d376b0f-20211224
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 13279467; Fri, 24 Dec 2021 16:26:06 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Dec 2021 16:26:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Dec
 2021 16:26:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 16:26:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mark Chen <mark-yw.chen@mediatek.com>
Subject: [PATCH v4 1/3] Bluetooth: mt7921s: Support wake on bluetooth
Date:   Fri, 24 Dec 2021 16:26:00 +0800
Message-ID: <91dfa736b7629cdb94bd2029f05717eeae77b07d.1640334021.git.sean.wang@kernel.org>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Chen <mark-yw.chen@mediatek.com>

Enable wake on bluetooth on mt7921s that can be supported since the
firmware with version 20211129211059 was added, and the patch would
not cause any harm even when the old firmware is applied.

The patch was tested by setting up an HID or HOGP profile to connect a
Bluetooth keyboard and mouse, then putting the system to suspend, then
trying to wake up the system by moving the Bluetooth keyboard or mouse,
and then checking if the system can wake up and be brought back to
the normal state.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
---
v2: refine the git message
v3:
    1. fit to single line as possible
    2. move the skb variable into local scope
    3. free skb after calling __hci_cmd_sync
    4. make bt_awake as const struct btmtk_wakeon
v4: 1. drop __func__ in error messages
    2. make hdev->wakeup assignment aligned to hdev->send
---
 drivers/bluetooth/btmtk.h     |  8 ++++++++
 drivers/bluetooth/btmtksdio.c | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6e7b0c7567c0..2be1d2680ad8 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -68,6 +68,14 @@ struct btmtk_tci_sleep {
 	u8 time_compensation;
 } __packed;
 
+struct btmtk_wakeon {
+	u8 mode;
+	u8 gpo;
+	u8 active_high;
+	__le16 enable_delay;
+	__le16 wakeup_delay;
+} __packed;
+
 struct btmtk_hci_wmt_params {
 	u8 op;
 	u8 flag;
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b5ea8d3bffaa..89bd70651e9e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -958,6 +958,32 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static bool btmtk_sdio_wakeup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+	bool may_wakeup = device_may_wakeup(bdev->dev);
+	const struct btmtk_wakeon bt_awake = {
+		.mode = 0x1,
+		.gpo = 0,
+		.active_high = 0x1,
+		.enable_delay = cpu_to_le16(0xc80),
+		.wakeup_delay = cpu_to_le16(0x20)
+	};
+
+	if (may_wakeup && bdev->data->chipid == 0x7921) {
+		struct sk_buff *skb;
+
+		skb =  __hci_cmd_sync(hdev, 0xfc27, sizeof(bt_awake),
+				      &bt_awake, HCI_CMD_TIMEOUT);
+		if (IS_ERR(skb))
+			may_wakeup = false;
+
+		kfree_skb(skb);
+	}
+
+	return may_wakeup;
+}
+
 static int btmtksdio_probe(struct sdio_func *func,
 			   const struct sdio_device_id *id)
 {
@@ -998,6 +1024,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->shutdown = btmtksdio_shutdown;
 	hdev->send     = btmtksdio_send_frame;
 	hdev->set_bdaddr = btmtk_set_bdaddr;
+	hdev->wakeup   = btmtk_sdio_wakeup;
 
 	SET_HCIDEV_DEV(hdev, &func->dev);
 
@@ -1032,7 +1059,11 @@ static int btmtksdio_probe(struct sdio_func *func,
 	 */
 	pm_runtime_put_noidle(bdev->dev);
 
-	return 0;
+	err = device_init_wakeup(bdev->dev, true);
+	if (err)
+		bt_dev_err(hdev, "failed to init_wakeup");
+
+	return err;
 }
 
 static void btmtksdio_remove(struct sdio_func *func)
-- 
2.25.1

