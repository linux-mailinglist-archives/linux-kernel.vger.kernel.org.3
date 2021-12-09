Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF346E131
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhLIDSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:18:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231363AbhLIDSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:18:02 -0500
X-UUID: 63ff790bee984ac6b799a6b80d21c9d2-20211209
X-UUID: 63ff790bee984ac6b799a6b80d21c9d2-20211209
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 435789986; Thu, 09 Dec 2021 11:14:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Dec 2021 11:14:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 9 Dec 2021 11:14:25 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yuwen Ng <yuwen.ng@mediatek.com>
Subject: [PATCH 1/3] usb: mtu3: fix interval value for intr and isoc
Date:   Thu, 9 Dec 2021 11:14:22 +0800
Message-ID: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Interval value from isoc/intr endpoint descriptor, no need
minus one. But the original code doesn't cause transfer error for
normal cases, due to the interval is less than the host request.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index a9a65b4bbfed..c51be015345b 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -77,7 +77,7 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
 		if (usb_endpoint_xfer_int(desc) ||
 				usb_endpoint_xfer_isoc(desc)) {
 			interval = desc->bInterval;
-			interval = clamp_val(interval, 1, 16) - 1;
+			interval = clamp_val(interval, 1, 16);
 			if (usb_endpoint_xfer_isoc(desc) && comp_desc)
 				mult = comp_desc->bmAttributes;
 		}
@@ -89,7 +89,7 @@ static int mtu3_ep_enable(struct mtu3_ep *mep)
 		if (usb_endpoint_xfer_isoc(desc) ||
 				usb_endpoint_xfer_int(desc)) {
 			interval = desc->bInterval;
-			interval = clamp_val(interval, 1, 16) - 1;
+			interval = clamp_val(interval, 1, 16);
 			mult = usb_endpoint_maxp_mult(desc) - 1;
 		}
 		break;
-- 
2.18.0

