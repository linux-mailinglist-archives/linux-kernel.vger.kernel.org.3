Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281074DBAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiCPXRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiCPXQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:16:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537582607;
        Wed, 16 Mar 2022 16:15:35 -0700 (PDT)
X-UUID: 331c614c7ffc45338737186dfa79be79-20220317
X-UUID: 331c614c7ffc45338737186dfa79be79-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1259241657; Thu, 17 Mar 2022 07:15:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 07:15:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 07:15:29 +0800
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
Subject: [PATCH v5 4/5] Bluetooth: mt7921s: Add .btmtk_get_codec_config_data
Date:   Thu, 17 Mar 2022 07:15:22 +0800
Message-ID: <5e1b185ae792e8ac339b91cada351216fd3438b9.1647472087.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
References: <d4be9c9c1ce2757bad4df19885d605e97a1ceec8.1647472087.git.objelf@gmail.com>
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

From: Yake Yang <yake.yang@mediatek.com>

add .btmtk_get_codec_config_data to get codec configuration data.

In HFP offload usecase, controllers need to be set codec details before
opening SCO. This callback function is used to fetch vendor specific codec
config data.

This is a preliminary patch to add the WBS support to the MT7921 driver.

Reviewed-by: Mark Chen <markyawenchen@gmail.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
---
v4->v5: no change
---
 drivers/bluetooth/btmtksdio.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 4000a994fe2c..c28eb9fc6176 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -943,6 +943,55 @@ static int btmtksdio_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
 	return 0;
 }
 
+static int btmtksdio_get_codec_config_data(struct hci_dev *hdev,
+					   __u8 link, struct bt_codec *codec,
+					   __u8 *ven_len, __u8 **ven_data)
+{
+	int err = 0;
+
+	if (!ven_data || !ven_len)
+		return -EINVAL;
+
+	*ven_len = 0;
+	*ven_data = NULL;
+
+	if (link != ESCO_LINK) {
+		bt_dev_err(hdev, "Invalid link type(%u)", link);
+		return -EINVAL;
+	}
+
+	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
+	if (!ven_data) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	/* supports only CVSD and mSBC offload codecs */
+	switch (codec->id) {
+	case 0x02:
+		**ven_data = 0x00;
+		break;
+	case 0x05:
+		**ven_data = 0x01;
+		break;
+	default:
+		err = -EINVAL;
+		bt_dev_err(hdev, "Invalid codec id(%u)", codec->id);
+		goto error;
+	}
+	/* codec and its capabilities are pre-defined to ids
+	 * preset id = 0x00 represents CVSD codec with sampling rate 8K
+	 * preset id = 0x01 represents mSBC codec with sampling rate 16K
+	 */
+	*ven_len = sizeof(__u8);
+	return err;
+
+error:
+	kfree(*ven_data);
+	*ven_data = NULL;
+	return err;
+}
+
 static int btmtksdio_sco_setting(struct hci_dev *hdev)
 {
 	const struct btmtk_sco sco_setting = {
@@ -980,6 +1029,7 @@ static int btmtksdio_sco_setting(struct hci_dev *hdev)
 		return err;
 
 	hdev->get_data_path_id = btmtksdio_get_data_path_id;
+	hdev->get_codec_config_data = btmtksdio_get_codec_config_data;
 
 	return err;
 }
-- 
2.25.1

