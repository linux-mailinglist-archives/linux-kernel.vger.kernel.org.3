Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAD48BF18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351268AbiALHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:33 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33488 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351233AbiALHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:30 -0500
X-UUID: feff6ed3060e4dfb954c0dfe0bda293d-20220112
X-UUID: feff6ed3060e4dfb954c0dfe0bda293d-20220112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1009571288; Wed, 12 Jan 2022 15:39:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 15:39:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:24 +0800
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
Subject: [PATCH 4/7] Bluetooth: mt7921s: fix btmtksdio_[drv|fw]_pmctrl()
Date:   Wed, 12 Jan 2022 15:39:14 +0800
Message-ID: <bf8979567a5bff061a500730aeeccc6a5f0fd645.1641972745.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
References: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Chen <mark-yw.chen@mediatek.com>

According to the firmware behavior (even the oldest one in linux-firmware)

If the firmware is downloaded, MT7921S must rely on the additional mailbox
mechanism that resides in firmware to check if the device is the right
state for btmtksdio_mcu_[drv|fw]_pmctrl(). Otherwise, we still apply the
old way for that.

That is a necessary patch before we enable runtime pm for mt7921s as
default.

Fixes: c603bf1f94d0 ("Bluetooth: btmtksdio: add MT7921s Bluetooth support")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 0951bb10d117..b0aae4143037 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -38,21 +38,25 @@ static bool enable_autosuspend;
 struct btmtksdio_data {
 	const char *fwname;
 	u16 chipid;
+	bool lp_mbox_supported;
 };
 
 static const struct btmtksdio_data mt7663_data = {
 	.fwname = FIRMWARE_MT7663,
 	.chipid = 0x7663,
+	.lp_mbox_supported = false,
 };
 
 static const struct btmtksdio_data mt7668_data = {
 	.fwname = FIRMWARE_MT7668,
 	.chipid = 0x7668,
+	.lp_mbox_supported = false,
 };
 
 static const struct btmtksdio_data mt7921_data = {
 	.fwname = FIRMWARE_MT7961,
 	.chipid = 0x7921,
+	.lp_mbox_supported = true,
 };
 
 static const struct sdio_device_id btmtksdio_table[] = {
@@ -90,8 +94,12 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define FW_MAILBOX_INT		BIT(15)
 #define RX_PKT_LEN		GENMASK(31, 16)
 
+#define MTK_REG_CSICR		0xc0
+#define CSICR_CLR_MBOX_ACK BIT(0)
 #define MTK_REG_PH2DSM0R	0xc4
 #define PH2DSM0R_DRIVER_OWN	BIT(0)
+#define MTK_REG_PD2HRM0R	0xdc
+#define PD2HRM0R_DRV_OWN	BIT(0)
 
 #define MTK_REG_CTDR		0x18
 
@@ -104,6 +112,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define BTMTKSDIO_TX_WAIT_VND_EVT	1
 #define BTMTKSDIO_HW_TX_READY		2
 #define BTMTKSDIO_FUNC_ENABLED		3
+#define BTMTKSDIO_PATCH_ENABLED		4
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -282,6 +291,11 @@ static u32 btmtksdio_drv_own_query(struct btmtksdio_dev *bdev)
 	return sdio_readl(bdev->func, MTK_REG_CHLPCR, NULL);
 }
 
+static u32 btmtksdio_drv_own_query_79xx(struct btmtksdio_dev *bdev)
+{
+	return sdio_readl(bdev->func, MTK_REG_PD2HRM0R, NULL);
+}
+
 static int btmtksdio_fw_pmctrl(struct btmtksdio_dev *bdev)
 {
 	u32 status;
@@ -289,6 +303,19 @@ static int btmtksdio_fw_pmctrl(struct btmtksdio_dev *bdev)
 
 	sdio_claim_host(bdev->func);
 
+	if (bdev->data->lp_mbox_supported &&
+	    test_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state)) {
+		sdio_writel(bdev->func, CSICR_CLR_MBOX_ACK, MTK_REG_CSICR,
+			    &err);
+		err = readx_poll_timeout(btmtksdio_drv_own_query_79xx, bdev,
+					 status, !(status & PD2HRM0R_DRV_OWN),
+					 2000, 1000000);
+		if (err < 0) {
+			bt_dev_err(bdev->hdev, "mailbox ACK not cleared");
+			goto out;
+		}
+	}
+
 	/* Return ownership to the device */
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
 	if (err < 0)
@@ -321,6 +348,12 @@ static int btmtksdio_drv_pmctrl(struct btmtksdio_dev *bdev)
 	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
 				 status & C_COM_DRV_OWN, 2000, 1000000);
 
+	if (!err && bdev->data->lp_mbox_supported &&
+	    test_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state))
+		err = readx_poll_timeout(btmtksdio_drv_own_query_79xx, bdev,
+					 status, status & PD2HRM0R_DRV_OWN,
+					 2000, 1000000);
+
 out:
 	sdio_release_host(bdev->func);
 
@@ -728,6 +761,7 @@ static int btmtksdio_func_query(struct hci_dev *hdev)
 
 static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 {
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_tci_sleep tci_sleep;
 	struct sk_buff *skb;
@@ -788,6 +822,8 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 		return err;
 	}
 
+	set_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state);
+
 ignore_func_on:
 	/* Apply the low power environment setup */
 	tci_sleep.mode = 0x5;
@@ -810,6 +846,7 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 
 static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 {
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x1;
 	int err;
@@ -835,6 +872,7 @@ static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 
 	hci_set_msft_opcode(hdev, 0xFD30);
 	hci_set_aosp_capable(hdev);
+	set_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state);
 
 	return err;
 }
-- 
2.25.1

