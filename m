Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41056B356
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiGHHTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbiGHHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448EB7969C;
        Fri,  8 Jul 2022 00:19:14 -0700 (PDT)
X-UUID: f1112de5602a4561bfa2648e931dec60-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a4b4596e-a82a-4a21-af1a-6393e9275d92,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:a4b4596e-a82a-4a21-af1a-6393e9275d92,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:0bb6f3d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:934b5963375d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: f1112de5602a4561bfa2648e931dec60-20220708
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 755103184; Fri, 08 Jul 2022 15:19:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Jul 2022 15:19:08 +0800
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
Subject: [PATCH 4/5] usb: mtu3: check capability of usb3 dual role
Date:   Fri, 8 Jul 2022 15:19:02 +0800
Message-ID: <20220708071903.25752-4-chunfeng.yun@mediatek.com>
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

It is capable of supporting usb3 dual role if there is at least one
usb3 port for device and xhci controller, we can check it from the
controller's capability, so no need the property "mediatek,usb3-drd"
anymore, but I find the property is not decribed in dt-binding.
Meanwhile, also take into account if the u3 port is disabled when the
u3 phy is shared with pcie.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 42987d08ce8c..4cb65346789d 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -190,6 +190,31 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
+static void ssusb_u3_drd_check(struct ssusb_mtk *ssusb)
+{
+	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	u32 dev_u3p_num;
+	u32 host_u3p_num;
+	u32 value;
+
+	/* u3 port0 is disabled */
+	if (ssusb->u3p_dis_msk & BIT(0)) {
+		otg_sx->is_u3_drd = false;
+		goto out;
+	}
+
+	value = mtu3_readl(ssusb->ippc_base, U3D_SSUSB_IP_DEV_CAP);
+	dev_u3p_num = SSUSB_IP_DEV_U3_PORT_NUM(value);
+
+	value = mtu3_readl(ssusb->ippc_base, U3D_SSUSB_IP_XHCI_CAP);
+	host_u3p_num = SSUSB_IP_XHCI_U3_PORT_NUM(value);
+
+	otg_sx->is_u3_drd = !!(dev_u3p_num && host_u3p_num);
+
+out:
+	dev_info(ssusb->dev, "usb3-drd: %d\n", otg_sx->is_u3_drd);
+}
+
 static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -270,7 +295,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		goto out;
 
 	/* if dual-role mode is supported */
-	otg_sx->is_u3_drd = of_property_read_bool(node, "mediatek,usb3-drd");
 	otg_sx->manual_drd_enabled =
 		of_property_read_bool(node, "enable-manual-drd");
 	otg_sx->role_sw_used = of_property_read_bool(node, "usb-role-switch");
@@ -290,9 +314,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	}
 
 out:
-	dev_info(dev, "dr_mode: %d, is_u3_dr: %d, drd: %s\n",
-		 ssusb->dr_mode, otg_sx->is_u3_drd,
-		otg_sx->manual_drd_enabled ? "manual" : "auto");
+	dev_info(dev, "dr_mode: %d, drd: %s\n", ssusb->dr_mode,
+		 otg_sx->manual_drd_enabled ? "manual" : "auto");
 	dev_info(dev, "u2p_dis_msk: %x, u3p_dis_msk: %x\n",
 		 ssusb->u2p_dis_msk, ssusb->u3p_dis_msk);
 
@@ -353,6 +376,7 @@ static int mtu3_probe(struct platform_device *pdev)
 	}
 
 	ssusb_ip_sw_reset(ssusb);
+	ssusb_u3_drd_check(ssusb);
 
 	if (IS_ENABLED(CONFIG_USB_MTU3_HOST))
 		ssusb->dr_mode = USB_DR_MODE_HOST;
-- 
2.18.0

