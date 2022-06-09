Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE4E544502
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiFIHmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiFIHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:42:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E051DA52;
        Thu,  9 Jun 2022 00:42:43 -0700 (PDT)
X-UUID: 1404f54a2a6c40eaa4e7087ddf05d916-20220609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:cbae9d9a-7040-4dd5-b802-665c971927b5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:cbae9d9a-7040-4dd5-b802-665c971927b5,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:b19c39e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:64c1756fc639,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 1404f54a2a6c40eaa4e7087ddf05d916-20220609
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 537685179; Thu, 09 Jun 2022 15:42:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 9 Jun 2022 15:42:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jun 2022 15:42:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 2/3] usb: mtu3: implement udc_async_callbacks of gadget operation
Date:   Thu, 9 Jun 2022 15:42:32 +0800
Message-ID: <20220609074233.15532-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609074233.15532-1-chunfeng.yun@mediatek.com>
References: <20220609074233.15532-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement udc_async_callbacks hook function to avoid a race when unnbinding
gadget drivers, refer to:
7dc0c55e9f30 ('USB: UDC core: Add udc_async_callbacks gadget op')

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h            |  1 +
 drivers/usb/mtu3/mtu3_gadget.c     | 19 ++++++++++++++++---
 drivers/usb/mtu3/mtu3_gadget_ep0.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 022bbdc54e68..8408e1b1a24a 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -357,6 +357,7 @@ struct mtu3 {
 	unsigned delayed_status:1;
 	unsigned gen2cp:1;
 	unsigned connected:1;
+	unsigned async_callbacks:1;
 
 	u8 address;
 	u8 test_mode_nr;
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index d57cea62fe6b..30999b4debb8 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -592,6 +592,18 @@ mtu3_gadget_set_speed(struct usb_gadget *g, enum usb_device_speed speed)
 	spin_unlock_irqrestore(&mtu->lock, flags);
 }
 
+static void mtu3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
+{
+	struct mtu3 *mtu = gadget_to_mtu3(g);
+	unsigned long flags;
+
+	dev_dbg(mtu->dev, "%s %s\n", __func__, enable ? "en" : "dis");
+
+	spin_lock_irqsave(&mtu->lock, flags);
+	mtu->async_callbacks = enable;
+	spin_unlock_irqrestore(&mtu->lock, flags);
+}
+
 static const struct usb_gadget_ops mtu3_gadget_ops = {
 	.get_frame = mtu3_gadget_get_frame,
 	.wakeup = mtu3_gadget_wakeup,
@@ -600,6 +612,7 @@ static const struct usb_gadget_ops mtu3_gadget_ops = {
 	.udc_start = mtu3_gadget_start,
 	.udc_stop = mtu3_gadget_stop,
 	.udc_set_speed = mtu3_gadget_set_speed,
+	.udc_async_callbacks = mtu3_gadget_async_callbacks,
 };
 
 static void mtu3_state_reset(struct mtu3 *mtu)
@@ -697,7 +710,7 @@ void mtu3_gadget_cleanup(struct mtu3 *mtu)
 void mtu3_gadget_resume(struct mtu3 *mtu)
 {
 	dev_dbg(mtu->dev, "gadget RESUME\n");
-	if (mtu->gadget_driver && mtu->gadget_driver->resume) {
+	if (mtu->async_callbacks && mtu->gadget_driver && mtu->gadget_driver->resume) {
 		spin_unlock(&mtu->lock);
 		mtu->gadget_driver->resume(&mtu->g);
 		spin_lock(&mtu->lock);
@@ -708,7 +721,7 @@ void mtu3_gadget_resume(struct mtu3 *mtu)
 void mtu3_gadget_suspend(struct mtu3 *mtu)
 {
 	dev_dbg(mtu->dev, "gadget SUSPEND\n");
-	if (mtu->gadget_driver && mtu->gadget_driver->suspend) {
+	if (mtu->async_callbacks && mtu->gadget_driver && mtu->gadget_driver->suspend) {
 		spin_unlock(&mtu->lock);
 		mtu->gadget_driver->suspend(&mtu->g);
 		spin_lock(&mtu->lock);
@@ -719,7 +732,7 @@ void mtu3_gadget_suspend(struct mtu3 *mtu)
 void mtu3_gadget_disconnect(struct mtu3 *mtu)
 {
 	dev_dbg(mtu->dev, "gadget DISCONNECT\n");
-	if (mtu->gadget_driver && mtu->gadget_driver->disconnect) {
+	if (mtu->async_callbacks && mtu->gadget_driver && mtu->gadget_driver->disconnect) {
 		spin_unlock(&mtu->lock);
 		mtu->gadget_driver->disconnect(&mtu->g);
 		spin_lock(&mtu->lock);
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 0ca47212f1ec..7e7013508af6 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -66,7 +66,7 @@ __acquires(mtu->lock)
 {
 	int ret;
 
-	if (!mtu->gadget_driver)
+	if (!mtu->gadget_driver || !mtu->async_callbacks)
 		return -EOPNOTSUPP;
 
 	spin_unlock(&mtu->lock);
-- 
2.18.0

