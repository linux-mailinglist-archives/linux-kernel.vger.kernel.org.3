Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3832558788A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiHBH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiHBH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:59:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FEB31DD9;
        Tue,  2 Aug 2022 00:59:54 -0700 (PDT)
X-UUID: 71bef0e673364a029d76015472538e65-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:77eacfd1-624b-45f7-b11c-b7b2243d2da2,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:77eacfd1-624b-45f7-b11c-b7b2243d2da2,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:c5280ed0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:5cf007a313eb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 71bef0e673364a029d76015472538e65-20220802
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 629295692; Tue, 02 Aug 2022 15:59:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 15:59:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Aug 2022 15:59:49 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ikjoon Jang" <ikjn@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: xhci-mtk: fix bandwidth release issue
Date:   Tue, 2 Aug 2022 15:59:46 +0800
Message-ID: <20220802075946.18168-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802075946.18168-1-chunfeng.yun@mediatek.com>
References: <20220802075946.18168-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when @udev->reset_resume is set to true, when usb resume,
the flow as below:
  - hub_resume
    - usb_disable_interface
      - usb_disable_endpoint
        - usb_hcd_disable_endpoint
          - xhci_endpoint_disable  // it set @ep->hcpriv to NULL

Then when reset usb device, it will drop allocated endpoints,
the flow as below:
  - usb_reset_and_verify_device
    - usb_hcd_alloc_bandwidth
      - xhci_mtk_drop_ep

but @ep->hcpriv is already set to NULL, the bandwidth will be not
released anymore.

Due to the added endponts are stored in hash table, we can drop the check
of @ep->hcpriv.

Fixes: 4ce186665e7c ("usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index a17bc584ee99..b54626732d18 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -764,8 +764,7 @@ int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret)
 		return ret;
 
-	if (ep->hcpriv)
-		drop_ep_quirk(hcd, udev, ep);
+	drop_ep_quirk(hcd, udev, ep);
 
 	return 0;
 }
-- 
2.18.0

