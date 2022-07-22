Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736257E89B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiGVUxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 16:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:53:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0502AF708;
        Fri, 22 Jul 2022 13:53:10 -0700 (PDT)
X-UUID: 9242fd9632124bd99d83cc7842e0163a-20220723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d0aa9e4c-7dfc-44f1-b7a0-daa25181b502,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:b28e9829-fd69-41f1-91fc-8b8a329d3a88,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9242fd9632124bd99d83cc7842e0163a-20220723
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2030280754; Sat, 23 Jul 2022 04:53:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 23 Jul 2022 04:53:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 23 Jul 2022 04:53:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <abhishekpandit@google.com>,
        <michaelfsun@google.com>, <mcchou@chromium.org>,
        <shawnku@google.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH v2] Bluetooth: btusb: mediatek: fix WMT command failure during runtime suspend
Date:   Sat, 23 Jul 2022 04:53:02 +0800
Message-ID: <d78a3734ffb59fcb1d19bacf59d217957d7b4091.1658515026.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

WMT cmd/event doesn't follow up the generic HCI cmd/event handling, it
needs constantly polling control pipe until the host received the WMT
event, thus, we should require to specifically acquire PM counter on the
USB to prevent the interface from entering auto suspended while WMT
cmd/event in progress.

Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
Co-developed-by: Jing Cai <jing.cai@mediatek.com>
Signed-off-by: Jing Cai <jing.cai@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
1. move usb_autopm_[get, put]_interface to btusb_mtk_hci_wmt_sync whenever
wmt cmd is invoked.
2. add the explanation why we needed the specific
usb_autopm_[get, put]_interface there.
---
 drivers/bluetooth/btusb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 480ea891c09a..bdcfc3deea6c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2453,15 +2453,29 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 
 	set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
 
+	/* WMT cmd/event doesn't follow up the generic HCI cmd/event handling,
+	 * it needs constantly polling control pipe until the host received the
+	 * WMT event, thus, we should require to specifically acquire PM counter
+	 * on the USB to prevent the interface from entering auto suspended
+	 * while WMT cmd/event in progress.
+	 */
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		goto err_free_wc;
+
 	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
 
 	if (err < 0) {
 		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
+		usb_autopm_put_interface(data->intf);
 		goto err_free_wc;
 	}
 
 	/* Submit control IN URB on demand to process the WMT event */
 	err = btusb_mtk_submit_wmt_recv_urb(hdev);
+
+	usb_autopm_put_interface(data->intf);
+
 	if (err < 0)
 		goto err_free_wc;
 
-- 
2.25.1

