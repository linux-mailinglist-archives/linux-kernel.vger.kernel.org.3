Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EA48BF14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351243AbiALHj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38144 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344426AbiALHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:28 -0500
X-UUID: d4759ae4b16d4846be40c8d56df8dd6c-20220112
X-UUID: d4759ae4b16d4846be40c8d56df8dd6c-20220112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1706099696; Wed, 12 Jan 2022 15:39:23 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 15:39:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 15:39:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:21 +0800
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
Subject: [PATCH 2/7] Bluetooth: btmtksdio: refactor btmtksdio_runtime_[suspend|resume]()
Date:   Wed, 12 Jan 2022 15:39:12 +0800
Message-ID: <b18877fc0136c336260e831614c463709d9cb261.1641972745.git.objelf@gmail.com>
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

Refactor btmtksdio_runtime_[suspend|resume]() to create the common
funcitons btmtksdio_[fw|drv]_pmctrl() shared with btmtksdio_[open|close]()
to avoid the redundant code as well.

This is also a prerequisite patch for the incoming patches.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 94 ++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 784e65c3fddd..8cbd49013d86 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -282,6 +282,54 @@ static u32 btmtksdio_drv_own_query(struct btmtksdio_dev *bdev)
 	return sdio_readl(bdev->func, MTK_REG_CHLPCR, NULL);
 }
 
+static int btmtksdio_fw_pmctrl(struct btmtksdio_dev *bdev)
+{
+	u32 status;
+	int err;
+
+	sdio_claim_host(bdev->func);
+
+	/* Return ownership to the device */
+	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
+	if (err < 0)
+		goto out;
+
+	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
+				 !(status & C_COM_DRV_OWN), 2000, 1000000);
+
+out:
+	sdio_release_host(bdev->func);
+
+	if (err < 0)
+		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
+
+	return err;
+}
+
+static int btmtksdio_drv_pmctrl(struct btmtksdio_dev *bdev)
+{
+	u32 status;
+	int err;
+
+	sdio_claim_host(bdev->func);
+
+	/* Get ownership from the device */
+	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
+	if (err < 0)
+		goto out;
+
+	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
+				 status & C_COM_DRV_OWN, 2000, 1000000);
+
+out:
+	sdio_release_host(bdev->func);
+
+	if (err < 0)
+		bt_dev_err(bdev->hdev, "Cannot get ownership from device");
+
+	return err;
+}
+
 static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -541,7 +589,7 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 static int btmtksdio_open(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
-	u32 status, val;
+	u32 val;
 	int err;
 
 	sdio_claim_host(bdev->func);
@@ -552,18 +600,10 @@ static int btmtksdio_open(struct hci_dev *hdev)
 
 	set_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
 
-	/* Get ownership from the device */
-	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
+	err = btmtksdio_drv_pmctrl(bdev);
 	if (err < 0)
 		goto err_disable_func;
 
-	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 status & C_COM_DRV_OWN, 2000, 1000000);
-	if (err < 0) {
-		bt_dev_err(bdev->hdev, "Cannot get ownership from device");
-		goto err_disable_func;
-	}
-
 	/* Disable interrupt & mask out all interrupt sources */
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, &err);
 	if (err < 0)
@@ -633,8 +673,6 @@ static int btmtksdio_open(struct hci_dev *hdev)
 static int btmtksdio_close(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
-	u32 status;
-	int err;
 
 	sdio_claim_host(bdev->func);
 
@@ -645,13 +683,7 @@ static int btmtksdio_close(struct hci_dev *hdev)
 
 	cancel_work_sync(&bdev->txrx_work);
 
-	/* Return ownership to the device */
-	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, NULL);
-
-	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 !(status & C_COM_DRV_OWN), 2000, 1000000);
-	if (err < 0)
-		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
+	btmtksdio_fw_pmctrl(bdev);
 
 	clear_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state);
 	sdio_disable_func(bdev->func);
@@ -1162,7 +1194,6 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct btmtksdio_dev *bdev;
-	u32 status;
 	int err;
 
 	bdev = sdio_get_drvdata(func);
@@ -1174,19 +1205,10 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 
 	sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
 
-	sdio_claim_host(bdev->func);
-
-	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
-	if (err < 0)
-		goto out;
+	err = btmtksdio_fw_pmctrl(bdev);
 
-	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 !(status & C_COM_DRV_OWN), 2000, 1000000);
-out:
 	bt_dev_info(bdev->hdev, "status (%d) return ownership to device", err);
 
-	sdio_release_host(bdev->func);
-
 	return err;
 }
 
@@ -1194,7 +1216,6 @@ static int btmtksdio_runtime_resume(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct btmtksdio_dev *bdev;
-	u32 status;
 	int err;
 
 	bdev = sdio_get_drvdata(func);
@@ -1204,19 +1225,10 @@ static int btmtksdio_runtime_resume(struct device *dev)
 	if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
 		return 0;
 
-	sdio_claim_host(bdev->func);
-
-	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
-	if (err < 0)
-		goto out;
+	err = btmtksdio_drv_pmctrl(bdev);
 
-	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 status & C_COM_DRV_OWN, 2000, 1000000);
-out:
 	bt_dev_info(bdev->hdev, "status (%d) get ownership from device", err);
 
-	sdio_release_host(bdev->func);
-
 	return err;
 }
 
-- 
2.25.1

