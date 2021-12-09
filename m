Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC72646E10D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLIC6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:58:02 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55340 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229446AbhLIC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:58:01 -0500
X-UUID: a02a5383e5c34f1bb5976d6943a0babf-20211209
X-UUID: a02a5383e5c34f1bb5976d6943a0babf-20211209
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 667723867; Thu, 09 Dec 2021 10:54:25 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 9 Dec 2021 10:54:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Dec
 2021 10:54:24 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 9 Dec 2021 10:54:23 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eddie Hung" <eddie.hung@mediatek.com>
Subject: [PATCH] usb: xhci-mtk: fix list_del warning when enable list debug
Date:   Thu, 9 Dec 2021 10:54:22 +0800
Message-ID: <20211209025422.17108-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is warning of 'list_del corruption' when enable list debug
(CONFIG_DEBUG_LIST=y), fix it by using list_del_init()

Fixes: 4ce186665e7c ("usb: xhci-mtk: Do not use xhci's virt_dev in drop_endpoint")
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index 1edef7527c11..edbfa82c6565 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -781,7 +781,7 @@ int xhci_mtk_check_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 
 	ret = xhci_check_bandwidth(hcd, udev);
 	if (!ret)
-		INIT_LIST_HEAD(&mtk->bw_ep_chk_list);
+		list_del_init(&mtk->bw_ep_chk_list);
 
 	return ret;
 }
-- 
2.18.0

