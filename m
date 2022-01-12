Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60548BF11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351231AbiALHjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:25 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344426AbiALHjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:24 -0500
X-UUID: b93436c9d1cf4de88a6d9ae0a0618db1-20220112
X-UUID: b93436c9d1cf4de88a6d9ae0a0618db1-20220112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1273416240; Wed, 12 Jan 2022 15:39:22 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 12 Jan 2022 15:39:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 15:39:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:19 +0800
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
Subject: [PATCH 1/7] Bluetooth: mt7921s: fix firmware coredump retrieve
Date:   Wed, 12 Jan 2022 15:39:11 +0800
Message-ID: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Chen <mark-yw.chen@mediatek.com>

According to the MCU firmware behavior, as the driver is aware of the
notification of the interrupt source FW_MAILBOX_INT that shows the MCU
completed delivered a core dump piece to the host, the driver must
acknowledge the MCU with the register PH2DSM0R bit PH2DSM0R_DRIVER_OWN
to notify the MCU to handle the next core dump piece.

Fixes: db57b625912a ("Bluetooth: btmtksdio: add support of processing firmware coredump and log")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 25fb9c79b1f4..784e65c3fddd 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -87,8 +87,12 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define RX_DONE_INT		BIT(1)
 #define TX_EMPTY		BIT(2)
 #define TX_FIFO_OVERFLOW	BIT(8)
+#define FW_MAILBOX_INT		BIT(15)
 #define RX_PKT_LEN		GENMASK(31, 16)
 
+#define MTK_REG_PH2DSM0R	0xc4
+#define PH2DSM0R_DRIVER_OWN	BIT(0)
+
 #define MTK_REG_CTDR		0x18
 
 #define MTK_REG_CRDR		0x1c
@@ -481,6 +485,12 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 		 */
 		sdio_writel(bdev->func, int_status, MTK_REG_CHISR, NULL);
 
+		if ((int_status & FW_MAILBOX_INT) &&
+		    bdev->data->chipid == 0x7921) {
+			sdio_writel(bdev->func, PH2DSM0R_DRIVER_OWN,
+				    MTK_REG_PH2DSM0R, 0);
+		}
+
 		if (int_status & FW_OWN_BACK_INT)
 			bt_dev_dbg(bdev->hdev, "Get fw own back");
 
-- 
2.25.1

