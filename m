Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FD48BF26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351273AbiALHkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:40:40 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:33672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351299AbiALHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:36 -0500
X-UUID: 2e40ab6a741e481b81514266684dba5b-20220112
X-UUID: 2e40ab6a741e481b81514266684dba5b-20220112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1835634332; Wed, 12 Jan 2022 15:39:33 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 12 Jan 2022 15:39:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 15:39:26 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:25 +0800
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
Subject: [PATCH 5/7] Bluetooth: btmtksdio: lower log level in btmtksdio_runtime_[resume|suspend]()
Date:   Wed, 12 Jan 2022 15:39:15 +0800
Message-ID: <c355cd94eee37a15a17a0ad51e82def6c922cd89.1641972745.git.objelf@gmail.com>
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

Lower its log level from INFO to DEBUG prior to we enable runtime pm for
mt7921s with the smaller idle time as default.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b0aae4143037..3e8f19556e2c 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1253,7 +1253,7 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 
 	err = btmtksdio_fw_pmctrl(bdev);
 
-	bt_dev_info(bdev->hdev, "status (%d) return ownership to device", err);
+	bt_dev_dbg(bdev->hdev, "status (%d) return ownership to device", err);
 
 	return err;
 }
@@ -1273,7 +1273,7 @@ static int btmtksdio_runtime_resume(struct device *dev)
 
 	err = btmtksdio_drv_pmctrl(bdev);
 
-	bt_dev_info(bdev->hdev, "status (%d) get ownership from device", err);
+	bt_dev_dbg(bdev->hdev, "status (%d) get ownership from device", err);
 
 	return err;
 }
-- 
2.25.1

