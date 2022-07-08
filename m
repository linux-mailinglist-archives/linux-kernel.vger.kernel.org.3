Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270B56B359
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiGHHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbiGHHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AB7B347;
        Fri,  8 Jul 2022 00:19:17 -0700 (PDT)
X-UUID: 5e7c28860faa4fb29eb0132610c942e4-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:aca42f3d-30c3-44ae-b6a7-7ee90c0f6877,OB:0,LO
        B:20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:aca42f3d-30c3-44ae-b6a7-7ee90c0f6877,OB:0,LOB:
        20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:8c70c163-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:976e24596999,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5e7c28860faa4fb29eb0132610c942e4-20220708
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 203999795; Fri, 08 Jul 2022 15:19:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 8 Jul 2022 15:19:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 15:19:08 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 5/5] usb: mtu3: support function remote wakeup
Date:   Fri, 8 Jul 2022 15:19:03 +0800
Message-ID: <20220708071903.25752-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function wake notification to support function remote wakeup,
currently assume the composite device only enable function wake
for the first interface.

Forward request to function driver when the recipient is an interface,
including:
GetStatus() request to the first interface in a function returns the
information about 'function remote wakeup' and 'function remote wakeup
capalbe';
SetFeature request of FUNCTION_SUSPEND to an interface recipient, the
controller driver saves the suspend option;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c     | 18 ++++++++++++++++++
 drivers/usb/mtu3/mtu3_gadget_ep0.c |  8 ++++----
 drivers/usb/mtu3/mtu3_hw_regs.h    | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index a751e0533c2d..291ec53c6c75 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -433,6 +433,13 @@ static int mtu3_gadget_get_frame(struct usb_gadget *gadget)
 	return (int)mtu3_readl(mtu->mac_base, U3D_USB20_FRAME_NUM);
 }
 
+static void function_wake_notif(struct mtu3 *mtu, u8 intf)
+{
+	mtu3_writel(mtu->mac_base, U3D_DEV_NOTIF_0,
+		    TYPE_FUNCTION_WAKE | DEV_NOTIF_VAL_FW(intf));
+	mtu3_setbits(mtu->mac_base, U3D_DEV_NOTIF_0, SEND_DEV_NOTIF);
+}
+
 static int mtu3_gadget_wakeup(struct usb_gadget *gadget)
 {
 	struct mtu3 *mtu = gadget_to_mtu3(gadget);
@@ -446,7 +453,18 @@ static int mtu3_gadget_wakeup(struct usb_gadget *gadget)
 
 	spin_lock_irqsave(&mtu->lock, flags);
 	if (mtu->g.speed >= USB_SPEED_SUPER) {
+		/*
+		 * class driver may do function wakeup even UFP is in U0,
+		 * and UX_EXIT only takes effect in U1/U2/U3;
+		 */
 		mtu3_setbits(mtu->mac_base, U3D_LINK_POWER_CONTROL, UX_EXIT);
+		/*
+		 * Assume there's only one function on the composite device
+		 * and enable remote wake for the first interface.
+		 * FIXME if the IAD (interface association descriptor) shows
+		 * there is more than one function.
+		 */
+		function_wake_notif(mtu, 0);
 	} else {
 		mtu3_setbits(mtu->mac_base, U3D_POWER_MANAGEMENT, RESUME);
 		spin_unlock_irqrestore(&mtu->lock, flags);
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 7e7013508af6..e4fd1bb14a55 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -226,6 +226,8 @@ ep0_get_status(struct mtu3 *mtu, const struct usb_ctrlrequest *setup)
 
 		break;
 	case USB_RECIP_INTERFACE:
+		/* status of function remote wakeup, forward request */
+		handled = 0;
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = (u8) le16_to_cpu(setup->wIndex);
@@ -397,10 +399,8 @@ static int ep0_handle_feature(struct mtu3 *mtu,
 		/* superspeed only */
 		if (value == USB_INTRF_FUNC_SUSPEND &&
 		    mtu->g.speed >= USB_SPEED_SUPER) {
-			/*
-			 * forward the request because function drivers
-			 * should handle it
-			 */
+			/* forward the request for function suspend */
+			mtu->may_wakeup = !!(index & USB_INTRF_FUNC_SUSPEND_RW);
 			handled = 0;
 		}
 		break;
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index 072db1f6470e..519a58301f45 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -341,6 +341,8 @@
 #define U3D_LINK_UX_INACT_TIMER	(SSUSB_USB3_SYS_CSR_BASE + 0x020C)
 #define U3D_LINK_POWER_CONTROL	(SSUSB_USB3_SYS_CSR_BASE + 0x0210)
 #define U3D_LINK_ERR_COUNT	(SSUSB_USB3_SYS_CSR_BASE + 0x0214)
+#define U3D_DEV_NOTIF_0		(SSUSB_USB3_SYS_CSR_BASE + 0x0290)
+#define U3D_DEV_NOTIF_1		(SSUSB_USB3_SYS_CSR_BASE + 0x0294)
 
 /*---------------- SSUSB_USB3_SYS_CSR FIELD DEFINITION ----------------*/
 
@@ -365,6 +367,20 @@
 #define CLR_LINK_ERR_CNT	BIT(16)
 #define LINK_ERROR_COUNT	GENMASK(15, 0)
 
+/* U3D_DEV_NOTIF_0 */
+#define DEV_NOTIF_TYPE_SPECIFIC_LOW_MSK		GENMASK(31, 8)
+#define DEV_NOTIF_VAL_FW(x)		(((x) & 0xff) << 8)
+#define DEV_NOTIF_VAL_LTM(x)	(((x) & 0xfff) << 8)
+#define DEV_NOTIF_VAL_IAM(x)	(((x) & 0xffff) << 8)
+#define DEV_NOTIF_TYPE_MSK		GENMASK(7, 4)
+/* Notification Type */
+#define TYPE_FUNCTION_WAKE			(0x1 << 4)
+#define TYPE_LATENCY_TOLERANCE_MESSAGE		(0x2 << 4)
+#define TYPE_BUS_INTERVAL_ADJUST_MESSAGE	(0x3 << 4)
+#define TYPE_HOST_ROLE_REQUEST			(0x4 << 4)
+#define TYPE_SUBLINK_SPEED			(0x5 << 4)
+#define SEND_DEV_NOTIF			BIT(0)
+
 /*---------------- SSUSB_USB2_CSR REGISTER DEFINITION ----------------*/
 
 #define U3D_POWER_MANAGEMENT		(SSUSB_USB2_CSR_BASE + 0x0004)
-- 
2.18.0

