Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD54DA1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiCOSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiCOSBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:01:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60664522C5;
        Tue, 15 Mar 2022 11:00:12 -0700 (PDT)
X-UUID: c38af39dd86a419dbe497f03a9be6ee9-20220316
X-UUID: c38af39dd86a419dbe497f03a9be6ee9-20220316
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 475824538; Wed, 16 Mar 2022 02:00:07 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Mar 2022 02:00:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Mar
 2022 02:00:06 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 02:00:05 +0800
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
Subject: [PATCH RESEND 1/5] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
Date:   Wed, 16 Mar 2022 02:00:00 +0800
Message-ID: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647367024.git.objelf@gmail.com>
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

From: Yake Yang <yake.yang@mediatek.com>

Fix the following kernel oops in btmtksdio_interrrupt

[   14.339134]  btmtksdio_interrupt+0x28/0x54
[   14.339139]  process_sdio_pending_irqs+0x68/0x1a0
[   14.339144]  sdio_irq_work+0x40/0x70
[   14.339154]  process_one_work+0x184/0x39c
[   14.339160]  worker_thread+0x228/0x3e8
[   14.339168]  kthread+0x148/0x3ac
[   14.339176]  ret_from_fork+0x10/0x30

That happened because hdev->power_on is already called before
sdio_set_drvdata which btmtksdio_interrupt handler relies on is not
properly set up.

The details are shown as the below: hci_register_dev would run
queue_work(hdev->req_workqueue, &hdev->power_on) as WQ_HIGHPRI
workqueue_struct to complete the power-on sequeunce and thus hci_power_on
may run before sdio_set_drvdata is done in btmtksdio_probe.

The hci_dev_do_open in hci_power_on would initialize the device and enable
the interrupt and thus it is possible that btmtksdio_interrupt is being
called right before sdio_set_drvdata is filled out.

When btmtksdio_interrupt is being called and sdio_set_drvdata is not filled
, the kernel oops is going to happen because btmtksdio_interrupt access an
uninitialized pointer.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Reviewed-by: Mark Chen <markyawenchen@gmail.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Yake Yang <yake.yang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index df3f9d090529..9644069cecbb 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1281,6 +1281,8 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->manufacturer = 70;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
+	sdio_set_drvdata(func, bdev);
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		dev_err(&func->dev, "Can't register HCI device\n");
@@ -1288,8 +1290,6 @@ static int btmtksdio_probe(struct sdio_func *func,
 		return err;
 	}
 
-	sdio_set_drvdata(func, bdev);
-
 	/* pm_runtime_enable would be done after the firmware is being
 	 * downloaded because the core layer probably already enables
 	 * runtime PM for this func such as the case host->caps &
-- 
2.25.1

