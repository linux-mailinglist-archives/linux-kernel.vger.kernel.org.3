Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120554D2564
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiCIBDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiCIBCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1313197D;
        Tue,  8 Mar 2022 16:40:31 -0800 (PST)
X-UUID: 39d2e8487e9749519bf0774d7f47cc99-20220309
X-UUID: 39d2e8487e9749519bf0774d7f47cc99-20220309
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 135036769; Wed, 09 Mar 2022 08:03:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 9 Mar 2022 08:03:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 08:03:55 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/3] Bluetooth: btmtkuart: rely on BT_MTK module
Date:   Wed, 9 Mar 2022 08:03:52 +0800
Message-ID: <f0167a9631fd0b392490311825ff0f826c054bc1.1646783737.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Rely on btmtk module to reduce duplicated code

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/Kconfig     |   1 +
 drivers/bluetooth/btmtk.c     |   1 +
 drivers/bluetooth/btmtk.h     |   1 +
 drivers/bluetooth/btmtkuart.c | 184 +++++-----------------------------
 4 files changed, 29 insertions(+), 158 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 36380e618ba4..e30707405455 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -400,6 +400,7 @@ config BT_MTKSDIO
 config BT_MTKUART
 	tristate "MediaTek HCI UART driver"
 	depends on SERIAL_DEV_BUS
+	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI UART driver.
 	  This driver is required if you want to use MediaTek Bluetooth
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 526dfdf1fe01..809762d64fc6 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -285,6 +285,7 @@ MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FIRMWARE_MT7622);
 MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
 MODULE_FIRMWARE(FIRMWARE_MT7961);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 013850fd2055..2a88ea8e475e 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: ISC */
 /* Copyright (C) 2021 MediaTek Inc. */
 
+#define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
 #define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 9ba22b13b4fa..136b901eb6f2 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -28,13 +28,10 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "h4_recv.h"
+#include "btmtk.h"
 
 #define VERSION "0.2"
 
-#define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
-#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
-#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
-
 #define MTK_STP_TLR_SIZE	2
 
 #define BTMTKUART_TX_STATE_ACTIVE	1
@@ -44,25 +41,6 @@
 
 #define BTMTKUART_FLAG_STANDALONE_HW	 BIT(0)
 
-enum {
-	MTK_WMT_PATCH_DWNLD = 0x1,
-	MTK_WMT_TEST = 0x2,
-	MTK_WMT_WAKEUP = 0x3,
-	MTK_WMT_HIF = 0x4,
-	MTK_WMT_FUNC_CTRL = 0x6,
-	MTK_WMT_RST = 0x7,
-	MTK_WMT_SEMAPHORE = 0x17,
-};
-
-enum {
-	BTMTK_WMT_INVALID,
-	BTMTK_WMT_PATCH_UNDONE,
-	BTMTK_WMT_PATCH_DONE,
-	BTMTK_WMT_ON_UNDONE,
-	BTMTK_WMT_ON_DONE,
-	BTMTK_WMT_ON_PROGRESS,
-};
-
 struct mtk_stp_hdr {
 	u8	prefix;
 	__be16	dlen;
@@ -74,44 +52,6 @@ struct btmtkuart_data {
 	const char *fwname;
 };
 
-struct mtk_wmt_hdr {
-	u8	dir;
-	u8	op;
-	__le16	dlen;
-	u8	flag;
-} __packed;
-
-struct mtk_hci_wmt_cmd {
-	struct mtk_wmt_hdr hdr;
-	u8 data[256];
-} __packed;
-
-struct btmtk_hci_wmt_evt {
-	struct hci_event_hdr hhdr;
-	struct mtk_wmt_hdr whdr;
-} __packed;
-
-struct btmtk_hci_wmt_evt_funcc {
-	struct btmtk_hci_wmt_evt hwhdr;
-	__be16 status;
-} __packed;
-
-struct btmtk_tci_sleep {
-	u8 mode;
-	__le16 duration;
-	__le16 host_duration;
-	u8 host_wakeup_pin;
-	u8 time_compensation;
-} __packed;
-
-struct btmtk_hci_wmt_params {
-	u8 op;
-	u8 flag;
-	u16 dlen;
-	const void *data;
-	u32 *status;
-};
-
 struct btmtkuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -153,29 +93,34 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
 	u32 hlen, status = BTMTK_WMT_INVALID;
 	struct btmtk_hci_wmt_evt *wmt_evt;
-	struct mtk_hci_wmt_cmd wc;
-	struct mtk_wmt_hdr *hdr;
+	struct btmtk_hci_wmt_cmd *wc;
+	struct btmtk_wmt_hdr *hdr;
 	int err;
 
+	/* Send the WMT command and wait until the WMT event returns */
 	hlen = sizeof(*hdr) + wmt_params->dlen;
 	if (hlen > 255) {
 		err = -EINVAL;
 		goto err_free_skb;
 	}
 
-	hdr = (struct mtk_wmt_hdr *)&wc;
+	wc = kzalloc(hlen, GFP_KERNEL);
+	if (!wc)
+		return -ENOMEM;
+
+	hdr = &wc->hdr;
 	hdr->dir = 1;
 	hdr->op = wmt_params->op;
 	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
 	hdr->flag = wmt_params->flag;
-	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
+	memcpy(wc->data, wmt_params->data, wmt_params->dlen);
 
 	set_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 
-	err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
+	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
 	if (err < 0) {
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
-		goto err_free_skb;
+		goto err_free_wc;
 	}
 
 	/* The vendor specific WMT commands are all answered by a vendor
@@ -192,14 +137,14 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
-		goto err_free_skb;
+		goto err_free_wc;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 		err = -ETIMEDOUT;
-		goto err_free_skb;
+		goto err_free_wc;
 	}
 
 	/* Parse and handle the return WMT event */
@@ -212,13 +157,13 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	}
 
 	switch (wmt_evt->whdr.op) {
-	case MTK_WMT_SEMAPHORE:
+	case BTMTK_WMT_SEMAPHORE:
 		if (wmt_evt->whdr.flag == 2)
 			status = BTMTK_WMT_PATCH_UNDONE;
 		else
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
-	case MTK_WMT_FUNC_CTRL:
+	case BTMTK_WMT_FUNC_CTRL:
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
@@ -235,86 +180,12 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 err_free_skb:
 	kfree_skb(bdev->evt_skb);
 	bdev->evt_skb = NULL;
+err_free_wc:
+	kfree(wc);
 
 	return err;
 }
 
-static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
-{
-	struct btmtk_hci_wmt_params wmt_params;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	size_t fw_size;
-	int err, dlen;
-	u8 flag;
-
-	err = request_firmware(&fw, fwname, &hdev->dev);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
-		return err;
-	}
-
-	fw_ptr = fw->data;
-	fw_size = fw->size;
-
-	/* The size of patch header is 30 bytes, should be skip */
-	if (fw_size < 30) {
-		err = -EINVAL;
-		goto free_fw;
-	}
-
-	fw_size -= 30;
-	fw_ptr += 30;
-	flag = 1;
-
-	wmt_params.op = MTK_WMT_PATCH_DWNLD;
-	wmt_params.status = NULL;
-
-	while (fw_size > 0) {
-		dlen = min_t(int, 250, fw_size);
-
-		/* Tell device the position in sequence */
-		if (fw_size - dlen <= 0)
-			flag = 3;
-		else if (fw_size < fw->size - 30)
-			flag = 2;
-
-		wmt_params.flag = flag;
-		wmt_params.dlen = dlen;
-		wmt_params.data = fw_ptr;
-
-		err = mtk_hci_wmt_sync(hdev, &wmt_params);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
-				   err);
-			goto free_fw;
-		}
-
-		fw_size -= dlen;
-		fw_ptr += dlen;
-	}
-
-	wmt_params.op = MTK_WMT_RST;
-	wmt_params.flag = 4;
-	wmt_params.dlen = 0;
-	wmt_params.data = NULL;
-	wmt_params.status = NULL;
-
-	/* Activate funciton the firmware providing to */
-	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
-		goto free_fw;
-	}
-
-	/* Wait a few moments for firmware activation done */
-	usleep_range(10000, 12000);
-
-free_fw:
-	release_firmware(fw);
-	return err;
-}
-
 static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
@@ -645,7 +516,7 @@ static int btmtkuart_func_query(struct hci_dev *hdev)
 	u8 param = 0;
 
 	/* Query whether the function is enabled */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 4;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -672,7 +543,7 @@ static int btmtkuart_change_baudrate(struct hci_dev *hdev)
 	 * ready to change a new baudrate.
 	 */
 	baudrate = cpu_to_le32(bdev->desired_speed);
-	wmt_params.op = MTK_WMT_HIF;
+	wmt_params.op = BTMTK_WMT_HIF;
 	wmt_params.flag = 1;
 	wmt_params.dlen = 4;
 	wmt_params.data = &baudrate;
@@ -706,7 +577,7 @@ static int btmtkuart_change_baudrate(struct hci_dev *hdev)
 	usleep_range(20000, 22000);
 
 	/* Test the new baudrate */
-	wmt_params.op = MTK_WMT_TEST;
+	wmt_params.op = BTMTK_WMT_TEST;
 	wmt_params.flag = 7;
 	wmt_params.dlen = 0;
 	wmt_params.data = NULL;
@@ -741,7 +612,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	 * do any setups.
 	 */
 	if (test_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state)) {
-		wmt_params.op = MTK_WMT_WAKEUP;
+		wmt_params.op = BTMTK_WMT_WAKEUP;
 		wmt_params.flag = 3;
 		wmt_params.dlen = 0;
 		wmt_params.data = NULL;
@@ -760,7 +631,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 		btmtkuart_change_baudrate(hdev);
 
 	/* Query whether the firmware is already download */
-	wmt_params.op = MTK_WMT_SEMAPHORE;
+	wmt_params.op = BTMTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
 	wmt_params.dlen = 0;
 	wmt_params.data = NULL;
@@ -778,7 +649,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = mtk_setup_firmware(hdev, bdev->data->fwname);
+	err = btmtk_setup_firmware(hdev, bdev->data->fwname, mtk_hci_wmt_sync);
 	if (err < 0)
 		return err;
 
@@ -801,7 +672,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	}
 
 	/* Enable Bluetooth protocol */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -846,7 +717,7 @@ static int btmtkuart_shutdown(struct hci_dev *hdev)
 	int err;
 
 	/* Disable the device */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -1131,6 +1002,3 @@ MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth Serial driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE(FIRMWARE_MT7622);
-MODULE_FIRMWARE(FIRMWARE_MT7663);
-MODULE_FIRMWARE(FIRMWARE_MT7668);
-- 
2.25.1

