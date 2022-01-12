Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3148BF27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351316AbiALHks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:40:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38308 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351272AbiALHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:33 -0500
X-UUID: 4246199e049e4f0f80f9ecdb982e7845-20220112
X-UUID: 4246199e049e4f0f80f9ecdb982e7845-20220112
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1394784379; Wed, 12 Jan 2022 15:39:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 15:39:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:28 +0800
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
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] Bluetooth: btmtksdio: mask out interrupt status
Date:   Wed, 12 Jan 2022 15:39:17 +0800
Message-ID: <a8fb77540e15a0c042fdfa338bee32e992aaafc9.1641972745.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
References: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Currently, there is a loop in btmtksdio_txrx_work() which iteratively
executes until the variable int_status is zero.

But the variable int_status should be masked out with the actual interrupt
sources (MTK_REG_CHISR bit 0-15) before we check the loop condition.
Otherwise, RX_PKT_LEN (MTK_REG_CHISR bit 16-31) which is read-only and
unclearable would cause the loop to get stuck on some chipsets like
MT7663s.

Fixes: 26270bc189ea ("Bluetooth: btmtksdio: move interrupt service to work")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 491f029452ca..8be763ab3bf4 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -92,6 +92,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define TX_EMPTY		BIT(2)
 #define TX_FIFO_OVERFLOW	BIT(8)
 #define FW_MAILBOX_INT		BIT(15)
+#define INT_MASK		GENMASK(15, 0)
 #define RX_PKT_LEN		GENMASK(31, 16)
 
 #define MTK_REG_CSICR		0xc0
@@ -565,6 +566,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 		 * FIFO.
 		 */
 		sdio_writel(bdev->func, int_status, MTK_REG_CHISR, NULL);
+		int_status &= INT_MASK;
 
 		if ((int_status & FW_MAILBOX_INT) &&
 		    bdev->data->chipid == 0x7921) {
-- 
2.25.1

