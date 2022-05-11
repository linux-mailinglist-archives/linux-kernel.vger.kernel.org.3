Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3D52402B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbiEKWWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348678AbiEKWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:22:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B473E528A;
        Wed, 11 May 2022 15:22:23 -0700 (PDT)
X-UUID: b85aee54ed8d442d866d81aa4441db2b-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3e91916c-83d9-4f10-a804-e3ddb5006d76,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:85
X-CID-INFO: VERSION:1.1.4,REQID:3e91916c-83d9-4f10-a804-e3ddb5006d76,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:85
X-CID-META: VersionHash:faefae9,CLOUDID:831c78b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:6d935a507c4f,Recheck:0,SF:28|16|19|48,TC:nil,Content:1,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: b85aee54ed8d442d866d81aa4441db2b-20220512
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 685863023; Thu, 12 May 2022 06:22:18 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 06:22:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 06:22:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 06:22:16 +0800
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
        <linux-kernel@vger.kernel.org>,
        "Yake Yang" <yake.yang@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
Date:   Thu, 12 May 2022 06:22:15 +0800
Message-ID: <f8bf12f9682a01de8905d4c0d7a0a1ff0502ba5f.1652307131.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
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

From: Sean Wang <sean.wang@mediatek.com>

We should not access skb buffer data anymore after hci_recv_frame was
called.

[   39.634809] BUG: KASAN: use-after-free in btmtksdio_recv_event+0x1b0
[   39.634855] Read of size 1 at addr ffffff80cf28a60d by task kworker
[   39.634962] Call trace:
[   39.634974]  dump_backtrace+0x0/0x3b8
[   39.634999]  show_stack+0x20/0x2c
[   39.635016]  dump_stack_lvl+0x60/0x78
[   39.635040]  print_address_description+0x70/0x2f0
[   39.635062]  kasan_report+0x154/0x194
[   39.635079]  __asan_report_load1_noabort+0x44/0x50
[   39.635099]  btmtksdio_recv_event+0x1b0/0x1c4
[   39.635129]  btmtksdio_txrx_work+0x6cc/0xac4
[   39.635157]  process_one_work+0x560/0xc5c
[   39.635177]  worker_thread+0x7ec/0xcc0
[   39.635195]  kthread+0x2d0/0x3d0
[   39.635215]  ret_from_fork+0x10/0x20
[   39.635247] Allocated by task 0:
[   39.635260] (stack is not available)
[   39.635281] Freed by task 2392:
[   39.635295]  kasan_save_stack+0x38/0x68
[   39.635319]  kasan_set_track+0x28/0x3c
[   39.635338]  kasan_set_free_info+0x28/0x4c
[   39.635357]  ____kasan_slab_free+0x104/0x150
[   39.635374]  __kasan_slab_free+0x18/0x28
[   39.635391]  slab_free_freelist_hook+0x114/0x248
[   39.635410]  kfree+0xf8/0x2b4
[   39.635427]  skb_free_head+0x58/0x98
[   39.635447]  skb_release_data+0x2f4/0x410
[   39.635464]  skb_release_all+0x50/0x60
[   39.635481]  kfree_skb+0xc8/0x25c
[   39.635498]  hci_event_packet+0x894/0xca4 [bluetooth]
[   39.635721]  hci_rx_work+0x1c8/0x68c [bluetooth]
[   39.635925]  process_one_work+0x560/0xc5c
[   39.635951]  worker_thread+0x7ec/0xcc0
[   39.635970]  kthread+0x2d0/0x3d0
[   39.635990]  ret_from_fork+0x10/0x20
[   39.636021] The buggy address belongs to the object at ffffff80cf28a600
                which belongs to the cache kmalloc-512 of size 512
[   39.636039] The buggy address is located 13 bytes inside of
                512-byte region [ffffff80cf28a600, ffffff80cf28a800)

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Co-developed-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: add Fixes tag
---
 drivers/bluetooth/btmtksdio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b6d77e04240c..4ae6631a7c29 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -379,6 +379,7 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct hci_event_hdr *hdr = (void *)skb->data;
+	u8 evt = hdr->evt;
 	int err;
 
 	/* When someone waits for the WMT event, the skb is being cloned
@@ -396,7 +397,7 @@ static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	if (err < 0)
 		goto err_free_skb;
 
-	if (hdr->evt == HCI_EV_WMT) {
+	if (evt == HCI_EV_WMT) {
 		if (test_and_clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT,
 				       &bdev->tx_state)) {
 			/* Barrier to sync with other CPUs */
-- 
2.25.1

