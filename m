Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7958A5C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbiHEGDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:03:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237427B03;
        Thu,  4 Aug 2022 23:03:35 -0700 (PDT)
X-UUID: 4da849926483465fb7441a17ac2c6379-20220805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JWSwfN8mSEnWeeZ9W2+DjYGYc2dFgD2DckE83Uv9OzA=;
        b=UTpyA/I8l54TNohu2UmYJSnOFd9mvIxFeKeHZcQmOLAC4PitjRXaSgvy7PpZ3ufnW2OnYQLTpanIqkYmyFGzpAwbfOFdC/Vci1BUS/iprguzQecwFpjIIoO6BmG7G/heUNtE+4Xp1kzcXsvCznRKtewI+znEkNEz2vaZpYKkOXI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:9e95f804-d7aa-435c-ade9-d69c0d664c26,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:0f94e32,CLOUDID:5da3ffad-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4da849926483465fb7441a17ac2c6379-20220805
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1874094933; Fri, 05 Aug 2022 14:03:32 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 5 Aug 2022 14:03:31 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 5 Aug 2022 14:03:30 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 2/2] usb: xhci-mtk: fix bandwidth release issue
Date:   Fri, 5 Aug 2022 14:03:28 +0800
Message-ID: <20220805060328.6189-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805060328.6189-1-chunfeng.yun@mediatek.com>
References: <20220805060328.6189-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
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

Fixes: 4ce186665e7c ("usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add comment
---
 drivers/usb/host/xhci-mtk-sch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c
 b/drivers/usb/host/xhci-mtk-sch.c
index a17bc584ee99..579899eb24c1 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -764,8 +764,8 @@ int xhci_mtk_drop_ep(struct usb_hcd *hcd, struct
 usb_device *udev,
 	if (ret)
 		return ret;
 
-	if (ep->hcpriv)
-		drop_ep_quirk(hcd, udev, ep);
+	/* needn't check @ep->hcpriv, xhci_endpoint_disable set it NULL */
+	drop_ep_quirk(hcd, udev, ep);
 
 	return 0;
 }
-- 
2.18.0

