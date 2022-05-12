Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566D52571E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358777AbiELVi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiELViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:38:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218B85DD31;
        Thu, 12 May 2022 14:38:18 -0700 (PDT)
X-UUID: b82524a4edff423f84b75bc94a81e01c-20220513
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.4,REQID:cda7d05d-f1bf-4473-8742-7059f31d5a96,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:55,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:160
X-CID-INFO: VERSION:1.1.4,REQID:cda7d05d-f1bf-4473-8742-7059f31d5a96,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:55,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_US65DF41,A
        CTION:quarantine,TS:160
X-CID-META: VersionHash:faefae9,CLOUDID:a27b1aa7-eab7-4b74-a74d-5359964535a9,C
        OID:cc3953f54a13,Recheck:0,SF:28|16|19|48|801,TC:nil,Content:3,EDM:-3,File
        :nil,QS:0,BEC:nil
X-UUID: b82524a4edff423f84b75bc94a81e01c-20220513
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 301289705; Fri, 13 May 2022 05:38:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 13 May 2022 05:38:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 05:38:13 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Yake Yang <yake.yang@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btmtksdio: fix the reset takes too long
Date:   Fri, 13 May 2022 05:38:11 +0800
Message-ID: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Sending WMT command during the reset in progress is invalid and would get
no response from firmware until the reset is complete, so we ignore the WMT
command here to resolve the issue which causes the whole reset process
taking too long.

Fixes: 8fafe702253d ("Bluetooth: mt7921s: support bluetooth reset mechanism")
Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 4ae6631a7c29..26e27fd79a21 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1189,6 +1189,10 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 	 */
 	pm_runtime_get_sync(bdev->dev);
 
+	/* wmt command only works until the reset is complete */
+	if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
+		goto ignore_wmt_cmd;
+
 	/* Disable the device */
 	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
@@ -1202,6 +1206,7 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 		return err;
 	}
 
+ignore_wmt_cmd:
 	pm_runtime_put_noidle(bdev->dev);
 	pm_runtime_disable(bdev->dev);
 
-- 
2.25.1

