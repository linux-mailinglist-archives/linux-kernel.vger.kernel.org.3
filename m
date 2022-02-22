Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1E4C05A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiBVX4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiBVX4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:56:40 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79E6252;
        Tue, 22 Feb 2022 15:56:09 -0800 (PST)
X-UUID: 75955e18b78b4233b713773810e60346-20220223
X-UUID: 75955e18b78b4233b713773810e60346-20220223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 958287712; Wed, 23 Feb 2022 07:56:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 23 Feb 2022 07:56:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 07:56:03 +0800
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
        <linux-kernel@vger.kernel.org>, Yake Yang <yake.yang@mediatek.com>
Subject: [PATCH 2/2] Bluetooth: btmtksdio: Fix kernel oops when sdio suspend.
Date:   Wed, 23 Feb 2022 07:56:00 +0800
Message-ID: <939606fc0825aa17729ab9a1400f3993043fa2d3.1645573830.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <dba1c05e4bfdf53e631ff134eaa9449e2ad5deef.1645573830.git.objelf@gmail.com>
References: <dba1c05e4bfdf53e631ff134eaa9449e2ad5deef.1645573830.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yake Yang <yake.yang@mediatek.com>

Do not kfree the skb when the skb failed to send with __hci_cmd_sync

2435.241210] Call trace:
[ 2435.241224]  kfree_skb+0x20/0x140
[ 2435.241240]  btmtksdio_sdio_wakeup+0x8c/0xcc
[ 2435.241360]  hci_suspend_notifier+0x108/0x184
[ 2435.241377]  notifier_call_chain_robust+0x58/0xd8
[ 2435.241390]  blocking_notifier_call_chain_robust+0x54/0x84
[ 2435.241402]  pm_notifier_call_chain_robust+0x2c/0x4c
[ 2435.241414]  suspend_prepare+0x40/0x238
[ 2435.241425]  enter_state+0xec/0x3a8
[ 2435.241436]  pm_suspend+0x60/0xcc
[ 2435.241446]  state_store+0xb8/0x114
[ 2435.241460]  kobj_attr_store+0x18/0x2c
[ 2435.241473]  sysfs_kf_write+0x44/0x58
[ 2435.241486]  kernfs_fop_write_iter+0xf4/0x190
[ 2435.241500]  vfs_write+0x2b0/0x2e4
[ 2435.241511]  ksys_write+0x80/0xec
[ 2435.241523]  __arm64_sys_write+0x24/0x30
[ 2435.241538]  el0_svc_common+0xf0/0x1d8
[ 2435.241550]  do_el0_svc_compat+0x28/0x54
[ 2435.241564]  el0_svc_compat+0x10/0x1c
[ 2435.241574]  el0_sync_compat_handler+0xa8/0xcc
[ 2435.241586]  el0_sync_compat+0x188/0x1c0
[ 2435.241606] Code: a9014ff4 910003fd b40002c0 aa0003f3 (b84d4c08)
[ 2435.241619] ---[ end trace d496539b850baf14 ]---

Fixes: ce64b3e94919  ("Bluetooth: mt7921s: Support wake on bluetooth")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index cbb09e1b823d..df3f9d090529 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1226,8 +1226,8 @@ static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 				      &bt_awake, HCI_CMD_TIMEOUT);
 		if (IS_ERR(skb))
 			may_wakeup = false;
-
-		kfree_skb(skb);
+		else
+			kfree_skb(skb);
 	}
 
 	return may_wakeup;
-- 
2.25.1

