Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8556B35B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiGHHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiGHHTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456367B345;
        Fri,  8 Jul 2022 00:19:15 -0700 (PDT)
X-UUID: 198eab96c6f24f08a5655844307932aa-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:68d94cc1-0ab9-4cb3-bc62-b7aa6ca2990e,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:68d94cc1-0ab9-4cb3-bc62-b7aa6ca2990e,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:0eb6f3d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:4cadae7140df,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 198eab96c6f24f08a5655844307932aa-20220708
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 379927623; Fri, 08 Jul 2022 15:19:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Jul 2022 15:19:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 15:19:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 3/5] usb: mtu3: add feature to disable device's usb3 port
Date:   Fri, 8 Jul 2022 15:19:01 +0800
Message-ID: <20220708071903.25752-3-chunfeng.yun@mediatek.com>
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

We may want to disable device's usb3 port when the combo phy is switched
from usb3 mode to pcie mode for some projects.
Meanwhile rename member @is_u3_ip to @u3_capable to avoid misleading, due
to the member's value may be changed when disable usb3 port, but the
controller is still a usb3 IP which also tells us how to manage the fifo.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      |  4 +++-
 drivers/usb/mtu3/mtu3_core.c | 32 +++++++++++++++++++-------------
 drivers/usb/mtu3/mtu3_plat.c |  4 ++--
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 9893dd1bafbb..388839397142 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -319,6 +319,7 @@ static inline struct ssusb_mtk *dev_to_ssusb(struct device *dev)
  * @ep0_req: dummy request used while handling standard USB requests
  *		for GET_STATUS and SET_SEL
  * @setup_buf: ep0 response buffer for GET_STATUS and SET_SEL requests
+ * @u3_capable: is capable of supporting USB3
  */
 struct mtu3 {
 	spinlock_t lock;
@@ -355,11 +356,12 @@ struct mtu3 {
 	unsigned softconnect:1;
 	unsigned u1_enable:1;
 	unsigned u2_enable:1;
-	unsigned is_u3_ip:1;
+	unsigned u3_capable:1;
 	unsigned delayed_status:1;
 	unsigned gen2cp:1;
 	unsigned connected:1;
 	unsigned async_callbacks:1;
+	unsigned separate_fifo:1;
 
 	u8 address;
 	u8 test_mode_nr;
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 3c6a670efafa..0ca173af87bb 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -100,7 +100,7 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 
 	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 
-	if (mtu->is_u3_ip) {
+	if (mtu->u3_capable) {
 		check_clk = SSUSB_U3_MAC_RST_B_STS;
 		mtu3_clrbits(ibase, SSUSB_U3_CTRL(0),
 			(SSUSB_U3_PORT_DIS | SSUSB_U3_PORT_PDN |
@@ -112,7 +112,7 @@ static int mtu3_device_enable(struct mtu3 *mtu)
 
 	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG) {
 		mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
-		if (mtu->is_u3_ip)
+		if (mtu->u3_capable)
 			mtu3_setbits(ibase, SSUSB_U3_CTRL(0),
 				     SSUSB_U3_PORT_DUAL_MODE);
 	}
@@ -124,7 +124,7 @@ static void mtu3_device_disable(struct mtu3 *mtu)
 {
 	void __iomem *ibase = mtu->ippc_base;
 
-	if (mtu->is_u3_ip)
+	if (mtu->u3_capable)
 		mtu3_setbits(ibase, SSUSB_U3_CTRL(0),
 			(SSUSB_U3_PORT_DIS | SSUSB_U3_PORT_PDN));
 
@@ -133,7 +133,7 @@ static void mtu3_device_disable(struct mtu3 *mtu)
 
 	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG) {
 		mtu3_clrbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_OTG_SEL);
-		if (mtu->is_u3_ip)
+		if (mtu->u3_capable)
 			mtu3_clrbits(ibase, SSUSB_U3_CTRL(0),
 				     SSUSB_U3_PORT_DUAL_MODE);
 	}
@@ -146,7 +146,7 @@ static void mtu3_dev_power_on(struct mtu3 *mtu)
 	void __iomem *ibase = mtu->ippc_base;
 
 	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
-	if (mtu->is_u3_ip)
+	if (mtu->u3_capable)
 		mtu3_clrbits(ibase, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
 
 	mtu3_clrbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
@@ -156,7 +156,7 @@ static void mtu3_dev_power_down(struct mtu3 *mtu)
 {
 	void __iomem *ibase = mtu->ippc_base;
 
-	if (mtu->is_u3_ip)
+	if (mtu->u3_capable)
 		mtu3_setbits(ibase, SSUSB_U3_CTRL(0), SSUSB_U3_PORT_PDN);
 
 	mtu3_setbits(ibase, SSUSB_U2_CTRL(0), SSUSB_U2_PORT_PDN);
@@ -213,7 +213,7 @@ static void mtu3_intr_enable(struct mtu3 *mtu)
 	value = SUSPEND_INTR | RESUME_INTR | RESET_INTR;
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR_ENABLE, value);
 
-	if (mtu->is_u3_ip) {
+	if (mtu->u3_capable) {
 		/* Enable U3 LTSSM interrupts */
 		value = HOT_RST_INTR | WARM_RST_INTR |
 			ENTER_U3_INTR | EXIT_U3_INTR;
@@ -273,7 +273,7 @@ static void mtu3_csr_init(struct mtu3 *mtu)
 {
 	void __iomem *mbase = mtu->mac_base;
 
-	if (mtu->is_u3_ip) {
+	if (mtu->u3_capable) {
 		/* disable LGO_U1/U2 by default */
 		mtu3_clrbits(mbase, U3D_LINK_POWER_CONTROL,
 				SW_U1_REQUEST_ENABLE | SW_U2_REQUEST_ENABLE);
@@ -341,7 +341,7 @@ void mtu3_ep_stall_set(struct mtu3_ep *mep, bool set)
 
 void mtu3_dev_on_off(struct mtu3 *mtu, int is_on)
 {
-	if (mtu->is_u3_ip && mtu->speed >= USB_SPEED_SUPER)
+	if (mtu->u3_capable && mtu->speed >= USB_SPEED_SUPER)
 		mtu3_ss_func_set(mtu, is_on);
 	else
 		mtu3_hs_softconn_set(mtu, is_on);
@@ -544,7 +544,7 @@ static void get_ep_fifo_config(struct mtu3 *mtu)
 	struct mtu3_fifo_info *rx_fifo;
 	u32 fifosize;
 
-	if (mtu->is_u3_ip) {
+	if (mtu->separate_fifo) {
 		fifosize = mtu3_readl(mtu->mac_base, U3D_CAP_EPNTXFFSZ);
 		tx_fifo = &mtu->tx_fifo;
 		tx_fifo->base = 0;
@@ -821,6 +821,10 @@ static irqreturn_t mtu3_irq(int irq, void *data)
 
 static void mtu3_check_params(struct mtu3 *mtu)
 {
+	/* device's u3 port (port0) is disabled */
+	if (mtu->u3_capable && (mtu->ssusb->u3p_dis_msk & BIT(0)))
+		mtu->u3_capable = 0;
+
 	/* check the max_speed parameter */
 	switch (mtu->max_speed) {
 	case USB_SPEED_FULL:
@@ -838,7 +842,7 @@ static void mtu3_check_params(struct mtu3 *mtu)
 		break;
 	}
 
-	if (!mtu->is_u3_ip && (mtu->max_speed > USB_SPEED_HIGH))
+	if (!mtu->u3_capable && (mtu->max_speed > USB_SPEED_HIGH))
 		mtu->max_speed = USB_SPEED_HIGH;
 
 	mtu->speed = mtu->max_speed;
@@ -857,10 +861,12 @@ static int mtu3_hw_init(struct mtu3 *mtu)
 	mtu->gen2cp = !!(mtu->hw_version >= MTU3_TRUNK_VERS_1003);
 
 	value = mtu3_readl(mtu->ippc_base, U3D_SSUSB_IP_DEV_CAP);
-	mtu->is_u3_ip = !!SSUSB_IP_DEV_U3_PORT_NUM(value);
+	mtu->u3_capable = !!SSUSB_IP_DEV_U3_PORT_NUM(value);
+	/* usb3 ip uses separate fifo */
+	mtu->separate_fifo = mtu->u3_capable;
 
 	dev_info(mtu->dev, "IP version 0x%x(%s IP)\n", mtu->hw_version,
-		mtu->is_u3_ip ? "U3" : "U2");
+		mtu->u3_capable ? "U3" : "U2");
 
 	mtu3_check_params(mtu);
 
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index d14494b30064..42987d08ce8c 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -244,6 +244,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN)
 		ssusb->dr_mode = USB_DR_MODE_OTG;
 
+	of_property_read_u32(node, "mediatek,u3p-dis-msk", &ssusb->u3p_dis_msk);
+
 	if (ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
 		goto out;
 
@@ -255,8 +257,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	}
 
 	/* optional property, ignore the error if it does not exist */
-	of_property_read_u32(node, "mediatek,u3p-dis-msk",
-			     &ssusb->u3p_dis_msk);
 	of_property_read_u32(node, "mediatek,u2p-dis-msk",
 			     &ssusb->u2p_dis_msk);
 
-- 
2.18.0

