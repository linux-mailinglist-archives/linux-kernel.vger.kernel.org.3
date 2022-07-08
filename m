Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A342256B355
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiGHHTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiGHHTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:19:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C3796BE;
        Fri,  8 Jul 2022 00:19:14 -0700 (PDT)
X-UUID: bf0b9e4ca3af4539821d9dfcb2efcbd9-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0cb08816-709d-4a8d-8b0d-36ae2ecef3e3,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:0cb08816-709d-4a8d-8b0d-36ae2ecef3e3,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:e2b5f3d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:7ed0fa5035a7,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: bf0b9e4ca3af4539821d9dfcb2efcbd9-20220708
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1085040604; Fri, 08 Jul 2022 15:19:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 8 Jul 2022 15:19:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 15:19:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 1/5] usb: mtu3: fix coverity of string buffer
Date:   Fri, 8 Jul 2022 15:18:59 +0800
Message-ID: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

Use snprintf instead of sprintf which could cause buffer overflow.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h         | 4 +++-
 drivers/usb/mtu3/mtu3_debugfs.c | 2 +-
 drivers/usb/mtu3/mtu3_gadget.c  | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 8408e1b1a24a..9893dd1bafbb 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -92,6 +92,8 @@ struct mtu3_request;
 
 #define BULK_CLKS_CNT	4
 
+#define MTU3_EP_NAME_LEN	12
+
 /* device operated link and speed got from DEVICE_CONF register */
 enum mtu3_speed {
 	MTU3_SPEED_INACTIVE = 0,
@@ -272,7 +274,7 @@ struct ssusb_mtk {
  */
 struct mtu3_ep {
 	struct usb_ep ep;
-	char name[12];
+	char name[MTU3_EP_NAME_LEN];
 	struct mtu3 *mtu;
 	u8 epnum;
 	u8 type;
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index d27de647c86a..a6f72494b819 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -132,7 +132,7 @@ static void mtu3_debugfs_regset(struct mtu3 *mtu, void __iomem *base,
 	if (!mregs)
 		return;
 
-	sprintf(mregs->name, "%s", name);
+	snprintf(mregs->name, MTU3_DEBUGFS_NAME_LEN, "%s", name);
 	regset = &mregs->regset;
 	regset->regs = regs;
 	regset->nregs = nregs;
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index 30999b4debb8..a751e0533c2d 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -635,8 +635,8 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 
 	INIT_LIST_HEAD(&mep->req_list);
 
-	sprintf(mep->name, "ep%d%s", epnum,
-		!epnum ? "" : (is_in ? "in" : "out"));
+	snprintf(mep->name, MTU3_EP_NAME_LEN, "ep%d%s", epnum,
+		 !epnum ? "" : (is_in ? "in" : "out"));
 
 	mep->ep.name = mep->name;
 	INIT_LIST_HEAD(&mep->ep.ep_list);
-- 
2.18.0

