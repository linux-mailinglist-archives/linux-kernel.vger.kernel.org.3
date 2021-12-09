Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A76046E136
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhLIDSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:18:14 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231387AbhLIDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:18:05 -0500
X-UUID: 30d56f00a0af4e9f883b2debffb0ab25-20211209
X-UUID: 30d56f00a0af4e9f883b2debffb0ab25-20211209
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1485629117; Thu, 09 Dec 2021 11:14:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 9 Dec 2021 11:14:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 9 Dec 2021 11:14:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Yuwen Ng" <yuwen.ng@mediatek.com>
Subject: [PATCH 3/3] usb: mtu3: fix list_head check warning
Date:   Thu, 9 Dec 2021 11:14:24 +0800
Message-ID: <20211209031424.17842-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is caused by uninitialization of list_head.

BUG: KASAN: use-after-free in __list_del_entry_valid+0x34/0xe4

Call trace:
dump_backtrace+0x0/0x298
show_stack+0x24/0x34
dump_stack+0x130/0x1a8
print_address_description+0x88/0x56c
__kasan_report+0x1b8/0x2a0
kasan_report+0x14/0x20
__asan_load8+0x9c/0xa0
__list_del_entry_valid+0x34/0xe4
mtu3_req_complete+0x4c/0x300 [mtu3]
mtu3_gadget_stop+0x168/0x448 [mtu3]
usb_gadget_unregister_driver+0x204/0x3a0
unregister_gadget_item+0x44/0xa4

Reported-by: Yuwen Ng <yuwen.ng@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index c51be015345b..b6c8a4a99c4d 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -235,6 +235,7 @@ struct usb_request *mtu3_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	mreq->request.dma = DMA_ADDR_INVALID;
 	mreq->epnum = mep->epnum;
 	mreq->mep = mep;
+	INIT_LIST_HEAD(&mreq->list);
 	trace_mtu3_alloc_request(mreq);
 
 	return &mreq->request;
-- 
2.18.0

