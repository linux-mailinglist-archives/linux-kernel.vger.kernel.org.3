Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07FF4A2C10
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiA2GCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:02:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49852 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238600AbiA2GCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:02:14 -0500
X-UUID: 4bd9a8234c1144a3a80b3c6fcca80ec0-20220129
X-UUID: 4bd9a8234c1144a3a80b3c6fcca80ec0-20220129
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1190797187; Sat, 29 Jan 2022 14:02:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 29 Jan 2022 14:02:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 29 Jan 2022 14:02:10 +0800
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
        Chih-Ying Chiang <chih-yin.chiang@mediatek.com>,
        Mark Chen <mark-yw.chen@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: mt7921s: support bluetooth reset mechanism
Date:   Sat, 29 Jan 2022 14:02:07 +0800
Message-ID: <52ae30c33f2994efcdff180764801141d59e6e0c.1643435854.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chih-Ying Chiang <chih-yin.chiang@mediatek.com>

Implement .cmd_timeout to reset the MT7921s device via a dedicated GPIO
pin when the firmware hang or the command has no response.

Co-developed-by: Mark Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chih-Ying Chiang <chih-yin.chiang@mediatek.com>
---
 drivers/bluetooth/btmtk.h     |   6 ++
 drivers/bluetooth/btmtksdio.c | 113 +++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index fb76d9765ce0..8960a5f89d48 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -10,9 +10,15 @@
 #define BTMTK_WMT_REG_WRITE 0x1
 #define BTMTK_WMT_REG_READ 0x2
 
+#define MT7921_BTSYS_RST 0x70002610
+#define MT7921_BTSYS_RST_WITH_GPIO BIT(7)
+
 #define MT7921_PINMUX_0 0x70005050
 #define MT7921_PINMUX_1 0x70005054
 
+#define MT7921_DLSTATUS 0x7c053c10
+#define BT_DL_STATE BIT(1)
+
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
 	BTMTK_WMT_TEST = 0x2,
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 8be763ab3bf4..8e200e80d2f6 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -12,10 +12,12 @@
 
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/skbuff.h>
 
@@ -83,6 +85,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 
 #define MTK_REG_CHCR		0xc
 #define C_INT_CLR_CTRL		BIT(1)
+#define BT_RST_DONE		BIT(8)
 
 /* CHISR have the same bits field definition with CHIER */
 #define MTK_REG_CHISR		0x10
@@ -114,6 +117,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define BTMTKSDIO_HW_TX_READY		2
 #define BTMTKSDIO_FUNC_ENABLED		3
 #define BTMTKSDIO_PATCH_ENABLED		4
+#define BTMTKSDIO_HW_RESET_ACTIVE	5
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -133,6 +137,8 @@ struct btmtksdio_dev {
 	struct sk_buff *evt_skb;
 
 	const struct btmtksdio_data *data;
+
+	struct gpio_desc *reset;
 };
 
 static int mtk_hci_wmt_sync(struct hci_dev *hdev,
@@ -297,6 +303,11 @@ static u32 btmtksdio_drv_own_query_79xx(struct btmtksdio_dev *bdev)
 	return sdio_readl(bdev->func, MTK_REG_PD2HRM0R, NULL);
 }
 
+static u32 btmtksdio_chcr_query(struct btmtksdio_dev *bdev)
+{
+	return sdio_readl(bdev->func, MTK_REG_CHCR, NULL);
+}
+
 static int btmtksdio_fw_pmctrl(struct btmtksdio_dev *bdev)
 {
 	u32 status;
@@ -967,6 +978,28 @@ static int btmtksdio_sco_setting(struct hci_dev *hdev)
 	return btmtksdio_mtk_reg_write(hdev, MT7921_PINMUX_1, val, ~0);
 }
 
+static int btmtksdio_reset_setting(struct hci_dev *hdev)
+{
+	int err;
+	u32 val;
+
+	err = btmtksdio_mtk_reg_read(hdev, MT7921_PINMUX_1, &val);
+	if (err < 0)
+		return err;
+
+	val |= 0x20; /* set the pin (bit field 11:8) work as GPIO mode */
+	err = btmtksdio_mtk_reg_write(hdev, MT7921_PINMUX_1, val, ~0);
+	if (err < 0)
+		return err;
+
+	err = btmtksdio_mtk_reg_read(hdev, MT7921_BTSYS_RST, &val);
+	if (err < 0)
+		return err;
+
+	val |= MT7921_BTSYS_RST_WITH_GPIO;
+	return btmtksdio_mtk_reg_write(hdev, MT7921_BTSYS_RST, val, ~0);
+}
+
 static int btmtksdio_setup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -974,13 +1007,32 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	unsigned long long duration;
 	char fwname[64];
 	int err, dev_id;
-	u32 fw_version = 0;
+	u32 fw_version = 0, val;
 
 	calltime = ktime_get();
 	set_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
 
 	switch (bdev->data->chipid) {
 	case 0x7921:
+		if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state)) {
+			err = btmtksdio_mtk_reg_read(hdev, MT7921_DLSTATUS,
+						     &val);
+			if (err < 0)
+				return err;
+
+			val &= ~BT_DL_STATE;
+			err = btmtksdio_mtk_reg_write(hdev, MT7921_DLSTATUS,
+						      val, ~0);
+			if (err < 0)
+				return err;
+
+			btmtksdio_fw_pmctrl(bdev);
+			msleep(20);
+			btmtksdio_drv_pmctrl(bdev);
+
+			clear_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state);
+		}
+
 		err = btmtksdio_mtk_reg_read(hdev, 0x70010200, &dev_id);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to get device id (%d)", err);
@@ -1015,6 +1067,16 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 			return err;
 		}
 
+		/* Enable GPIO reset mechanism */
+		if (bdev->reset) {
+			err = btmtksdio_reset_setting(hdev);
+			if (err < 0) {
+				bt_dev_err(hdev, "Failed to enable Reset setting (%d)", err);
+				devm_gpiod_put(bdev->dev, bdev->reset);
+				bdev->reset = NULL;
+			}
+		}
+
 		break;
 	case 0x7663:
 	case 0x7668:
@@ -1111,6 +1173,47 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static void btmtksdio_cmd_timeout(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+	u32 status;
+	int err;
+
+	if (!bdev->reset || bdev->data->chipid != 0x7921)
+		return;
+
+	pm_runtime_get_sync(bdev->dev);
+
+	if (test_and_set_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
+		return;
+
+	sdio_claim_host(bdev->func);
+
+	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
+	skb_queue_purge(&bdev->txq);
+	cancel_work_sync(&bdev->txrx_work);
+
+	gpiod_set_value_cansleep(bdev->reset, 1);
+	msleep(100);
+	gpiod_set_value_cansleep(bdev->reset, 0);
+
+	err = readx_poll_timeout(btmtksdio_chcr_query, bdev, status,
+				 status & BT_RST_DONE, 100000, 2000000);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to reset (%d)", err);
+		goto err;
+	}
+
+	clear_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state);
+err:
+	sdio_release_host(bdev->func);
+
+	pm_runtime_put_noidle(bdev->dev);
+	pm_runtime_disable(bdev->dev);
+
+	hci_reset_dev(hdev);
+}
+
 static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -1172,6 +1275,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 
 	hdev->open     = btmtksdio_open;
 	hdev->close    = btmtksdio_close;
+	hdev->cmd_timeout = btmtksdio_cmd_timeout;
 	hdev->flush    = btmtksdio_flush;
 	hdev->setup    = btmtksdio_setup;
 	hdev->shutdown = btmtksdio_shutdown;
@@ -1216,6 +1320,13 @@ static int btmtksdio_probe(struct sdio_func *func,
 	if (err)
 		bt_dev_err(hdev, "failed to initialize device wakeup");
 
+	bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
+						     "mediatek,mt7921s-bluetooth");
+	bdev->reset = devm_gpiod_get_optional(bdev->dev, "reset",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(bdev->reset))
+		err = PTR_ERR(bdev->reset);
+
 	return err;
 }
 
-- 
2.25.1

