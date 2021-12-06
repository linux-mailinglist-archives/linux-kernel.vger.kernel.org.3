Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7903746A30F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbhLFRhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:37:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243035AbhLFRhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:37:34 -0500
X-UUID: c18ec835ccd54ce591a56ba04b5ad362-20211207
X-UUID: c18ec835ccd54ce591a56ba04b5ad362-20211207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1396821294; Tue, 07 Dec 2021 01:34:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Dec 2021 01:34:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Dec 2021 01:34:01 +0800
From:   <mark-yw.chen@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <sean.wang@mediatek.com>, <mark-yw.chen@mediatek.com>,
        <aaron.hou@mediatek.com>, <kaichuan.hsieh@canonical.com>,
        <pmenzel@molgen.mpg.de>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] Bluetooth: btusb: Return error code when getting patch status failed
Date:   Tue, 7 Dec 2021 01:33:43 +0800
Message-ID: <20211206173343.31380-2-mark-yw.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211206173343.31380-1-mark-yw.chen@mediatek.com>
References: <20211206173343.31380-1-mark-yw.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Chen <mark-yw.chen@mediatek.com>

If there are failure cases in getting patch status, it should return the
error code (-EIO).

Fixes: fc342c4dc4087 ("Bluetooth: btusb: Add protocol support for MediaTek MT7921U USB devices")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index c2ee5c4b975a..526dfdf1fe01 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -121,6 +121,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 				} else {
 					bt_dev_err(hdev, "Failed wmt patch dwnld status (%d)",
 						   status);
+					err = -EIO;
 					goto err_release_fw;
 				}
 			}
-- 
2.18.0

